Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282861AbRLWAkT>; Sat, 22 Dec 2001 19:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283002AbRLWAkM>; Sat, 22 Dec 2001 19:40:12 -0500
Received: from embolism.psychosis.com ([216.242.103.100]:46084 "EHLO
	embolism.psychosis.com") by vger.kernel.org with ESMTP
	id <S282861AbRLWAkC>; Sat, 22 Dec 2001 19:40:02 -0500
Content-Type: text/plain; charset=US-ASCII
From: Dave Cinege <dcinege@psychosis.com>
Reply-To: dcinege@psychosis.com
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Booting a modular kernel through a multiple streams file
Date: Sat, 22 Dec 2001 19:39:57 -0500
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.GSO.4.21.0112180350550.6100-100000@weyl.math.psu.edu> <T57e612d0dbac1785e6169@pcow028o.blueyonder.co.uk> <9vo4b3$iet$1@cesium.transmeta.com>
In-Reply-To: <9vo4b3$iet$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16HwgA-0001uk-00@schizo.psychosis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 December 2001 14:10, H. Peter Anvin wrote:

> Note that Al is working on a replacement; he's not just bitching.  The
> replacement is called "initramfs" which means populating a ramfs from
> an archive or collection of archives passwd by the bootloader.  With
> that in there, lots of things can be done in userspace.

Already done for many months (actully years) now. If I thought it
would be accepted, I'd gut rd.c and fully merge it into a 2.5 patch.

ftp://ftp.psychosis.com/linux/initrd-dyn/

Initrd Dynamic supercedes Initrd Archive. This function subset was
first written in January 1998 and has progressed in features since
then. Developed for the Linux Router Project, it is in wide spread
use in various Linux embedded systems and thin OS's.

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

-- 
The time is now 22:54 (Totalitarian)  -  http://www.ccops.org/
