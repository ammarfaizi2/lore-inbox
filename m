Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268972AbUIADNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268972AbUIADNm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 23:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268975AbUIADNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 23:13:41 -0400
Received: from psems1.agilysys.com ([199.33.129.48]:4879 "HELO psems1.pios.com")
	by vger.kernel.org with SMTP id S268972AbUIADNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 23:13:34 -0400
Subject: Kernel or Grub bug.
From: "Wise, Jeremey" <jeremey.wise@agilysys.com>
To: linux-kernel@vger.kernel.org,
       "Wise, Beth & Jeremey" <jeremey.wise@agilysys.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 31 Aug 2004 23:12:21 -0400
Message-Id: <1094008341.4704.32.camel@wizej.agilysys.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.93 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Intro:With some level of trepidation I post this. I am not a programmer
but a computer consultant. I have been round and round on this issue and
have been pushed into this last effort, in hopes of getting Linux
working for me.

Issue: $600 dollar phone worthless as it's palm functions do not sync.
Hareware/OS: IBM Thinkpad T41 SuSE 9.1 running KDE 3.2

History: Per conversation with pilot-link devoloper (refernaced here
http://lists.pilot-link.org/pipermail/pilot-link-general/2004-
August/001924.html) their is a 'known issue' with the SuSE 9.1 ( ) which
I use. This is in conjunction with a buggy visor module (again,
referenced in email thread). SuSE says this is not their issue (unless I
put down a credit card:>) but acknowledge that it does look strange
(ticket number upon request). Only recourse is to move to a none 'buggy'
kernel (ie. >= 2.6.7)

Problem: Whenever I compile a 2.6.8.xxx kernel, with full patching on
any system and attempt to boot it I halt with the following error
"Kernel panic: VFS: Unable to mount root fs on unknown-block(0,0)" 

What I have tried: Several variations of: Fedora Core vs SuSE, reiserfs
vs ext3, or lilo vs grub. All yeild the same error. Also built
variations of 2.4 kernels and booted them on each system test to ensure
that my kernel compile skills were not missing something stupid or that
their was a hardware issue. I have also done seval weeks worth of LUG
and google searching  and inquiries and have not come up with any
suggestions that worked (lots of them ... but none fixing the kernel
booting issue). 
*********
Google hit on what APEARS to be many others hitting same issue:
http://usermodelinux.org/modules.php?name=News&file=article&sid=134
http://www.redhat.com/archives/fedora-test-list/2003-
December/msg00426.html
http://www.uwsg.iu.edu/hypermail/linux/kernel/0309.3/0681.html
http://search.luky.org/linux-kernel.2003/msg43513.html

I have also tried all suggestions or checks referenced therein
*******************

Kernel build process used:
1) Download kernel source from kernel.org (linux-2.6.8.1.tar.bz2)
2) Download Base Patches (patch-2.6.9-rc1.bz2)
3) Download Kernel Developer Specific tree Patches if desired (patch-
2.6.9-rc1-bk7.bz2)
4) 'cd /usr/src' -> place where all the source files will be put
5) Copy kernel file you downloaded into source directory -
>'cp /tmp/linux-2.6.8.1.tar.bz2 /usr/src'
6) Unpack kernel -> "bzip2 -d linux-2.6.8.1.tar.bz2"
7) Untar kernel -> "tar -xvf linux-2.6.8.1.tar.bz2"
9) Enter into kernel source directory -> "cd /usr/src/linux-2.6.8.1"
10) Copy kernel patch files to current directory -> "cp /tmp/patch* ."
11) Unpack patch files "bzip2 -d patch-2.6.9-rc1.bz2;bzip2 -d patch-
2.6.9-rc1-bk7.bz2"
12) Apply the main tree patch "patch -p1 < patch-2.6.9-rc1"
13) Apply kernel devolper patch if desired or downloaded "patch -p1 <
patch-2.6.9-rc1-bk7"
14) Copy configuration from currently running kernel
"cp /proc/config.gz /usr/src/linux-2.6.8.1"
15) Unpack currenty running system config file and move change it to
correct name "gzip -d config.gz;mv config .config"
16) Modify 'Makefile' the reflect current extraversion. Use 'vi' editor
to change it like example "EXTRAVERSION = .1-MyKernel"
17) Configure system specific settings via 'make menuconfig' or 'make
xconfig'
18) After exiting utity and saving configuration we can start compile
'make bzImage'
19) Copy the completed kernel image for booting 'cp
arch/i386/boot/bzImage /boot/vmlinuz-2.6.8.1-MyKernel'
20) After that completes we can compile required modules and install
them into /lib/modules 'make modules;make modules_install'
21) Now that the kernel is complete we can build a RAMDISK if required
'mkinitrd'
22) Lastly is to modify boot parameters for bootloader.
Likely /boot/grub/grub.conf or /boot/grub/menu.conf

Current Partition information:
   Device Boot      Start         End      Blocks   Id  System
/dev/hda1               1         217      102501   83  Linux -> /boot
/dev/hda2             218        2384     1023907+  82  Linux swap
/dev/hda3            2385       61950    28144935   83  Linux -> /

Current GRUB config file:
color white/blue black/light-gray
default 0
timeout 8
gfxmenu (hd0,0)/message

###Don't change this comment - YaST2 identifier: Original name: linux###
title Linux
    kernel (hd0,0)/vmlinuz root=/dev/hda3 showopts
    initrd (hd0,0)/initrd

title 2.6.8.1-Palm
    kernel (hd0,0)/vmlinuz-2.6.8.1-Palm showopts
    initrd (hd0,0)/initrd-2.6.8.1-Palm

*********************************
I have also tried "root=0303" per conversation with LUG members where
major and minor numbers were referenced instead of labels or /dev/hdaX
ls /dev/hda3
brw-rw----  1 root disk 3, 3 Apr  6 09:27 hda3
**********************************

I apologize for the mound of information. I would rather post too much
then too little. I would also usually join the list but being on SuSE,
Evolution, and Palm is enough right now with my day-job:>)

Please post directly back to me at the email listed below. I can supply
far greater detail as needed.

-- 
Thanks,

Jeremey Wise
jeremey.wise@agilysys.com

All opinions or information expressed here are personal in nature and do
not reflect the official position of Agilysys Inc.
