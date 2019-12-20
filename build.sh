#!/bin/bash

# cd docker-node-ssh-rsync

git checkout master
git pull --rebase
git checkout -b ${VERSION}
sed -r -i "s@(.*)NG_CLI_VERSION=.*@\1NG_CLI_VERSION=${VERSION}@g" Dockerfile*
sed -r -i "s@latest@${VERSOPM}@g" hooks/multi-arch-manifest.yaml
git commit -a -m "update to ${VERSION}"
git checkout master
${MASTER} && git merge ${VERSION}
git push -u origin ${VERSION}
cd ..

echo "Waiting for build docker-node-ssh-rsync"
sleep 10m #amd64
sleep 20m #aarch64
sleep 20m #arm32v7
echo "Build should be done"

cd docker-node-ssh-rsync-karma
git checkout master
git pull --rebase
git checkout -b ${VERSION}
sed -i -r "s@(.*)unbekannt3/node-ssh-rsync:.*@\1unbekannt3/node-ssh-rsync:${VERSION}@g" Dockerfile
git commit -a -m "update to ${VERSION}"
git checkout master
${MASTER} && git merge ${VERSION}
git push -u origin ${VERSION}
cd ..

echo "Waiting for build docker-node-ssh-rsync-karma"
sleep 13m
echo "Build should be done"

cd docker-node-ssh-rsync-e2e
git checkout master
git pull --rebase
git checkout -b ${VERSION}
sed -i -r "s@(.*)unbekannt3/node-ssh-rsync-karma:.*@\1unbekannt3/node-ssh-rsync-karma:${VERSION}@g" Dockerfile
git commit -a -m "update to ${VERSION}"
git checkout master
${MASTER} &&  git merge ${VERSION}
git push -u origin ${VERSION}
cd ..

echo "Pushing latest..."
cd docker-node-ssh-rsync
git push --all
cd ..
cd docker-node-ssh-rsync-karma
git push --all
cd ..
cd docker-node-ssh-rsync-e2e
git push --all
cd ..
