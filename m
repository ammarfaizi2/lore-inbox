Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273256AbRIWEVx>; Sun, 23 Sep 2001 00:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273265AbRIWEVl>; Sun, 23 Sep 2001 00:21:41 -0400
Received: from embolism.psychosis.com ([216.242.103.100]:43016 "EHLO
	embolism.psychosis.com") by vger.kernel.org with ESMTP
	id <S273256AbRIWEVf>; Sun, 23 Sep 2001 00:21:35 -0400
Content-Type: text/plain; charset=US-ASCII
From: David Cinege <dcinege@psychosis.com>
Reply-To: dcinege@psychosis.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Initrd Dynamic v4.2 - New Feature: Tmpfs root support
Date: Sun, 23 Sep 2001 00:22:28 -0400
X-Mailer: KMail [version 1.3.1]
Cc: LRP <linux-router@linuxrouter.org>,
        LRPD <linux-router-devel@linuxrouter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15l0m0-0004cH-00@schizo.psychosis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus and Alan, 

Initrd Dynamic is mature, stable, well mantained code. It makes very minimal 
impact to the current source tree, segrigating itself to it's own source 
files. It is fully backwards compatible with current initrd operations.

Please consider it for inclusion in the next 2.4 kernel release.

2.4.9 kernel patch
ftp://ftp.psychosis.com/linux/initrd-dyn/kernelpatches/initrd-dyn_4.2_2.4.9.diff.gz

2.0 and 2.2 kernel patches:
ftp://ftp.psychosis.com/linux/initrd-dyn/kernelpatches/

More info
ftp://ftp.psychosis.com/linux/initrd-dyn/README
-----------------------------------------------------------
About:

Current Release: 4.2

Initrd Dynamic supercedes Initrd Archive. This function subset was
first written in January 1998 and has progressed in features since
then. Developed for the Linux Router Project, it is in wide spread
use in various Linux embedded systems and thin OS's.


kernelpatches/
	Patches for Linux 2.0, 2.2, and 2.4 kernels.
	The kernel patches include the base files, required changes to rd.c
	and configuration files, and a fix in main.c to allow /linuxrc
	even if root=/dev/ram0. (Long standing bug)
-------------------------------------------------------------
What is it:

Initial RAM disk dynamic creation support
CONFIG_BLK_DEV_INITRD_DYN
  Initrd Dynamic allows you to use tar.gz archive(s) instead of those
  nasty raw  images. It works by dynamically creating a filesystem at
  boot, mounting it as '/', then extracting the archive(s) loaded into
  the initrd memory space. If your bootloader can load multiple archives
  sequentially (IE a patched GRUB) all archives will be extracted in the
  order they where loaded.

  Optionally Initrd Dynamic can create the /dev directory and some
  failsafe console files.

  You must select at least one of the available filesystems below.
  You probably want to use tmpfs if it's available in your kernel.

  The kernel parameter to specify options is:
  initrd_dyn=fstype[,fssize[k|m]][,mkdev]

  fstype == One of the supported dynamic mkfs filesystems.

  fssize ==  Limits the size of the filesystem created.
	tmpfs: If not speced it's equal to the real memory space.
  	minix: If not speced it's equal to ramdisk_size.

  mkdev  == /dev is created after archive untar. Useful even if devfs=mount.

  Examples:
  initrd_dyn=tmpfs load_ramdisk=1
  initrd_dyn=tmpfs,4096k load_ramdisk=1
  initrd_dyn=tmpfs,16m,mkdev load_ramdisk=1

  initrd_dyn=minix,8m ramdisk_size=20480 root=/dev/ram0 load_ramdisk=1
  initrd_dyn=minix,,mkdev root=/dev/rd/0 load_ramdisk=1

Initial RAM disk tmpfs auto filesystem support
CONFIG_BLK_DEV_INITRD_DYN_TMPFS
  Specing initrd_tar=tmpfs[,fssize] will have the kernel dynamically
  mount a tmpfs filesystem as the root. Spec a normal tar.gz file for
  the boot loader to load as the initrd root archive.

Initial RAM disk minix auto filesystem support
CONFIG_BLK_DEV_INITRD_DYN_MINIX
  Specing initrd_tar=minix[,fssize] will have the kernel dynamically
  create a minix filesystem on /dev/ram0 at boot time. Spec a normal
  tar.gz file for the boot loader to load as the initrd root archive.
