Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265690AbSKAK6j>; Fri, 1 Nov 2002 05:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265694AbSKAK6j>; Fri, 1 Nov 2002 05:58:39 -0500
Received: from c-66-176-164-150.se.client2.attbi.com ([66.176.164.150]:27061
	"EHLO schizo.psychosis.com") by vger.kernel.org with ESMTP
	id <S265690AbSKAK6i>; Fri, 1 Nov 2002 05:58:38 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Dave Cinege <dcinege@psychosis.com>
Reply-To: dcinege@psychosis.com
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Initrd Dynamic -- Initramfs's GrandDaddy...(and competition)
Date: Fri, 1 Nov 2002 06:05:12 -0500
User-Agent: KMail/1.4.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200211010605.12473.dcinege@psychosis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

I am submitting this for inclusion into the pre-2.6 tree.
You've said 'yes' to initramfs. Maybe you'll like this
'ready to go' solution better.

A patch against 2.5.45 is here:
http://ftp.psychosis.com/linux/initrd-dyn/kernelpatches/2.5.45/initrd_dynamic-2.5.45.diff.gz

It has been tested as well I can as 2.5.45 has a new bug in rd.c
with initrd deallocation. It was tested with 2.5.44, A-1, no problems.

To find out if you 'like it' you can view the primary
files involved here: They are already 'post-patched' 2.5.45:
http://ftp.psychosis.com/linux/initrd-dyn/kernelpatches/2.5.45/do_mounts.c
http://ftp.psychosis.com/linux/initrd-dyn/kernelpatches/2.5.45/initrd.c
http://ftp.psychosis.com/linux/initrd-dyn/kernelpatches/2.5.45/untar.c

What this patch does:
	One or more tar and/or tar.gz archives can be loaded by a
	bootloader, and they will be extracted sequencially to a
	tmpfs (ramfs) root.

	Rewrote the initrd handling and made the code more modular.

	All legacy initrd functions have been removed from do_mounts.c.

	do_mounts.c has been greatly cleaned up. (Now ~10K)

	All new and legacy initrd related functions are now in initrd.c

	We id both un/compressed images/archives and act accordingly.

	Better error checking and printk messages


What this has that initramfs doesn't:
	Clean up and rewrite of the system already in place.
	The use of tar archives
	Multiple archive support
	Works good, right now

What initramfs has that this doesn't:
	Load image from a 'linked' kernel location.
	Uses CPIO archives

Why you should include this as the new tmpfs(ramfs) initial root
loading solution:

	More robust implementation. 

	Useful error checking and user output messages

	The ability to leave legacy initrd infrasturture
	inplace via #ifdef's if needed. 

	do_mounts.c gets scrubbed up. (Until the day it's purged,
	why not!?!)

	Tar is in wide spread (general audiences) use. CPIO is not.
	People have said Tar is bloated/complex.
	Tar == Read header. Determine type. Write file.
	CPIO == Read header. Determine type. Write file.
	(Look at untar.c. un-cpio'ing is no different. You decide.)

	I was here first. ; )  (The first version of this was made
	in January 1998 using a minixfs on /dev/ram0)

What I still need to do:
	Add loading 'linked image' support ala initramfs (minor work)
	Clean some minor things. (Purge mount_tmpfs_root() )
	Update docs and comments
	Test legacy 'load_ramdisk' style floppy support
	Purge anything people want gone (Legacy linuxrc root pivot, etc)

	ALL OF THESE WILL BE DONE WITHIN *DAYS* IF YOU SHOW INTEREST

What you should do if you have no desire in this at all:
	Please, tell Dave 'no, not at all' so he can go to bed already!

