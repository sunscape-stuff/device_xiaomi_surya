#!/bin/bash


# This script will download Neutron clang, allowing for
# the kernel to be compiled without the builder/maintainer having
# to manually download/clone it.

# Set variables
TC_PATH="prebuilts/clang/host/linux-x86/clang-neutron"

function download() {
    curl -s https://api.github.com/repos/Neutron-Toolchains/clang-build-catalogue/releases/latest \
    | grep "browser_download_url.*tar.zst" \
    | cut -d : -f 2,3 \
    | tr -d \" \
    | wget --output-document=Neutron.tar.zst -qi -

    tar -xf Neutron.tar.zst -C "$TC_PATH/" || {
        echo "vendorsetup.sh: Failed to extract Neutron clang."
        echo "Please check if the file exists at the root directory of AOSP."
        exit 1
    }
    rm -rf Neutron.tar.zst
}

if [[ -d $TC_PATH ]]; then {
    echo "vendorsetup.sh: Neutron clang is already installed, don't do anything."
}
else {
    echo "vendorsetup.sh: Neutron clang isnt installed, downloading..."
    mkdir -p $TC_PATH
    download
}
fi
