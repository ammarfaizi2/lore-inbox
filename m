Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315785AbSETFTB>; Mon, 20 May 2002 01:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315788AbSETFTA>; Mon, 20 May 2002 01:19:00 -0400
Received: from rj.SGI.COM ([192.82.208.96]:1254 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S315785AbSETFS6>;
	Mon, 20 May 2002 01:18:58 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel - take 3 
In-Reply-To: Your message of "Mon, 20 May 2002 01:09:36 -0400."
             <200205200509.g4K59a9494917@saturn.cs.uml.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 20 May 2002 15:18:37 +1000
Message-ID: <3640.1021871917@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 May 2002 01:09:36 -0400 (EDT), 
"Albert D. Cahalan" <acahalan@cs.uml.edu> wrote:
>Well, not everybody trusts "make install" to do something useful.
>I'd do something like this:
>
>make clean
>bzip2 -dc ../foo.bz2 | patch -E -s -p1
>make menuconfig
>time script build-log
>make vmlinux && make modules && make modules_install && exit
>cp vmlinux /boot/vmlinux-2.5.16
>cp System.map /boot/System.map-2.5.16
>cp .config /boot/config-2.5.16
>sync
>su -
>joe /etc/yaboot.conf
>sync
>exit

Then you will be pleased to hear that kbuild 2.5 supports precisely
that model.  It has an install menu which lets you specify the name of
the install kernel, whether to install System.map and .config, and the
names to install them under.  It even has an config entry for a
post-install script.

After setting up these variables (only needs to be done once)

CONFIG_INSTALL_KERNEL_NAME=/boot/vmlinux-KERNELRELEASE
CONFIG_INSTALL_SYSTEM_MAP=y
CONFIG_INSTALL_SYSTEM_MAP_NAME=/boot/System.map-KERNELRELEASE
CONFIG_INSTALL_CONFIG=y
CONFIG_INSTALL_CONFIG_NAME=/boot/config-KERNELRELEASE
CONFIG_INSTALL_SCRIPT=y
CONFIG_INSTALL_SCRIPT_NAME=joe /etc/yaboot.conf

Your build process collapes to

  make -j defconfig installable && sudo make install

It does not get any simpler than that!

