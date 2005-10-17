Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbVJQMoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbVJQMoY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 08:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbVJQMoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 08:44:24 -0400
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:23048 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id S932297AbVJQMoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 08:44:23 -0400
From: Felix Oxley <lkml@oxley.org>
To: Rob Landley <rob@landley.net>
Subject: Re: [PATCH 1/1] Kconfig help text for RAM Disk & initrd
Date: Mon, 17 Oct 2005 13:44:17 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <200510170102.19717.lkml@oxley.org> <200510170812.11590.lkml@oxley.org> <200510170233.46811.rob@landley.net>
In-Reply-To: <200510170233.46811.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510171344.18416.lkml@oxley.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 October 2005 08:33, Rob Landley wrote:
> > On Monday 17 October 2005 06:37, Rob Landley wrote:
> > > Actually if this is a patch against 2.6, between ramfs (including
> > > initramfs) and the ability to loopback mount files, I personally consider
> > > ramdisks semi-obsolete.  (This might be _why_ it says most normal users
> > > won't need them.)

You are right in all you say.
However, my system uses initrd and I thought that a help message warning newbies
that these options are required if inrd is used, would be useful.
Since I removed it and was uanble to boot :-)

Do you think the slimmed down patch below is appropriate, or shall I just drop the subject?

reagrds,
Felix

Signed-off-by: Felix Oxley <lkml@oxley.org>
---
--- ./drivers/block/Kconfig.orig	2005-10-17 13:04:31.000000000 +0100
+++ ./drivers/block/Kconfig	2005-10-17 13:20:31.000000000 +0100
@@ -368,9 +368,9 @@ config BLK_DEV_RAM
 	  Saying Y here will allow you to use a portion of your RAM memory as
 	  a block device, so that you can make file systems on it, read and
 	  write to it and do all the other things that you can do with normal
-	  block devices (such as hard drives). It is usually used to load and
-	  store a copy of a minimal root file system off of a floppy into RAM
-	  during the initial install of Linux.
+	  block devices (such as hard drives). This is usually used to load and
+	  store a copy of a minimal root file system into RAM during the boot
+	  sequence.
 
 	  Note that the kernel command line option "ramdisk=XX" is now
 	  obsolete. For details, read <file:Documentation/ramdisk.txt>.
@@ -378,8 +378,10 @@ config BLK_DEV_RAM
 	  To compile this driver as a module, choose M here: the
 	  module will be called rd.
 
-	  Most normal users won't need the RAM disk functionality, and can
-	  thus say N here.
+	  Say Y here if your system uses an initrd RAM disk whilst booting, you
+	  will also need to to enable initrd below. (Check for /boot/initrd*).
+
+	  If unsure, say N.
 
 config BLK_DEV_RAM_COUNT
 	int "Default number of RAM disks" if BLK_DEV_RAM
@@ -403,11 +405,14 @@ config BLK_DEV_INITRD
 	depends on BLK_DEV_RAM=y
 	help
 	  The initial RAM disk is a RAM disk that is loaded by the boot loader
-	  (loadlin or lilo) and that is mounted as root before the normal boot
+	  (lilo or grub) and that is mounted as root before the normal boot
 	  procedure. It is typically used to load modules needed to mount the
 	  "real" root file system, etc. See <file:Documentation/initrd.txt>
 	  for details.
 
+	  Some systems will require this to boot (check for /boot/initrd*).
+	  Otherwise, say N.
+
 
 #XXX - it makes sense to enable this only for 32-bit subarch's, not for x86_64
 #for instance.
