#!/usr/bin/env bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

sudo dnf install `sed 's/#.*//' "$DIR/packages" | tr '\n' ' '`

# https://github.com/wieczorek1990/dotfiles
git clone https://github.com/wieczorek1990/dotfiles.git && ./dotfiles/install.sh

# https://github.com/wieczorek1990/fish-config
git clone https://github.com/wieczorek1990/fish-config.git && ./fish-config/install.sh

# https://docs.docker.com/engine/installation/linux/fedora/
sudo systemctl enable docker.service
sudo systemctl start docker

# https://keybase.io/
wget https://prerelease.keybase.io/keybase_amd64.rpm
sudo dnf install ./keybase_amd64.rpm
run_keybase

# https://github.com/thoughtbot/gitsh
curl -OL https://github.com/thoughtbot/gitsh/releases/download/v0.11.1/gitsh-0.11.1.tar.gz
tar -zxvf gitsh-0.11.1.tar.gz
cd gitsh-0.11.1
./configure
make
sudo make install

# http://negativo17.org/spotify-client/
sudo dnf config-manager --add-repo=http://negativo17.org/repos/fedora-spotify.repo
sudo dnf install spotify-client
# workaround
wget -O spotify-client.deb http://repository.spotify.com/pool/non-free/s/spotify-client/spotify-client_1.0.44.100.ga60c0ce1-89_amd64.deb
ar -x spotify-client.deb
tar xf data.tar.gz
sudo cp -r usr/share/spotify/* /lib64/spotify-client/
rm -r usr/ control.tar.gz data.tar.gz debian-binary spotify-client.deb

# https://github.com/thoughtbot/gitsh
git clone https://github.com/thoughtbot/gitsh.git
cd gitsh
./autogen.sh
sudo gem install bundler
bundle
./configure
make
sudo make install
cd -

# https://github.com/settings/keys
ssh-keygen -b 4096

# https://github.com/kamranahmedse/git-standup 
curl -L https://raw.githubusercontent.com/kamranahmedse/git-standup/master/installer.sh | sudo sh

# https://github.com/deadalnix/pixel-saver
git clone https://github.com/deadalnix/pixel-saver.git pixel-saver@deadalnix.me
gnome-shell-extension-tool -e ~/.local/share/gnome-shell/extensions/pixel-saver@deadalnix.me

# https://github.com/vibou/vibou.gTile
git clone https://github.com/lundal/vibou.gTile.git ~/.local/share/gnome-shell/extensions/gTile@vibou
gnome-shell-extension-tool -e gTile@vibou

# https://copr.fedorainfracloud.org/coprs/mystro256/gnome-redshift/
sudo dnf copr enable mystro256/gnome-redshift
sudo dnf install gnome-shell-extension-redshift
gnome-shell-extension-prefs

