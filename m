Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262573AbTHUKaX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 06:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262575AbTHUKaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 06:30:23 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:14016 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S262573AbTHUKaI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 06:30:08 -0400
Date: Thu, 21 Aug 2003 12:30:05 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
Cc: mlord@pobox.com, torvalds@transmeta.com
Subject: [PATCH 2.6][TRIVIAL] Update ide.txt documentation to current ide.c
Message-ID: <Pine.LNX.4.51.0308211225120.23765@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patches updates Documentation/ide.txt to reflect more options that
really are supported by the IDE driver (drivers/ide.c)

The patch despite the dirnames is versus 2.6.0-test3-bk8.

Please review and luckily apply.
Regards,
Maciej

diff -u linux-2.6.0-test2/Documentation/ide.txt linux-2.6.0-test3/Documentation/ide.txt
--- linux-2.6.0-test2/Documentation/ide.txt	2003-07-27 19:04:55.000000000 +0200
+++ linux-2.6.0-test3/Documentation/ide.txt	2003-08-21 12:28:09.000000000 +0200
@@ -1,5 +1,5 @@

-	Information regarding the Enhanced IDE drive in Linux 2.5
+	Information regarding the Enhanced IDE drive in Linux 2.6

 ==============================================================================

@@ -242,8 +242,23 @@
 			  and quite likely to cause trouble with
 			  older/odd IDE drives.

+ "hdx=biostimings"	: driver will NOT attempt to tune interface speed
+ 			  (DMA/PIO) but always honour BIOS timings.
+
  "hdx=slow"		: insert a huge pause after each access to the data
 			  port. Should be used only as a last resort.
+
+ "hdx=swapdata"		: when the drive is a disk, byte swap all data
+
+ "hdx=bswap"		: same as above..........
+
+ "hdx=flash"		: allows for more than one ata_flash disk to be
+ 			  registered. In most cases, only one device
+ 			  will be present.
+
+ "hdx=scsi"		: the return of the ide-scsi flag, this is useful for
+ 			  allowwing ide-floppy, ide-tape, and ide-cdrom|writers
+ 			  to use ide-scsi emulation on a device specific option.

  "hdxlun=xx"		: set the drive last logical unit

@@ -277,27 +292,41 @@
  "idex=noautotune"	: driver will NOT attempt to tune interface speed
 			  This is the default for most chipsets,
 			  except the cmd640.
+
+ "idex=biostimings"	: driver will NOT attempt to tune interface speed
+			  (DMA/PIO) but always honour BIOS timings.

  "idex=serialize"	: do not overlap operations on idex. Please note
 			  that you will have to specify this option for
 			  both the respecitve primary and secondary channel
 			  to take effect.
+
+ "idex=four"		: four drives on idex and ide(x^1) share same ports

  "idex=reset"		: reset interface after probe

  "idex=dma"		: automatically configure/use DMA if possible.

-The following are valid ONLY on ide0, which usually corresponds to the first
-ATA interface found on the particular host, and the defaults for the base,ctl
-ports must not be altered.
+ "idex=ata66"		: informs the interface that it has an 80c cable
+			  for chipsets that are ATA-66 capable, but the
+			  ability to bit test for detection is currently
+			  unknown.
+
+ "ide=reverse"		: formerly called to pci sub-system, but now local.
+
+The following are valid ONLY on ide0 (except dc4030), which usually corresponds
+to the first ATA interface found on the particular host, and the defaults for
+the base,ctl ports must not be altered.

  "ide0=dtc2278"		: probe/support DTC2278 interface
  "ide0=ht6560b"		: probe/support HT6560B interface
  "ide0=cmd640_vlb"	: *REQUIRED* for VLB cards with the CMD640 chip
 			  (not for PCI -- automatically detected)
  "ide0=qd65xx"		: probe/support qd65xx interface
- "ide0=ali14xx"		: probe/support ali14xx chipsets (ALI M1439/M1445)
+ "ide0=ali14xx"		: probe/support ali14xx chipsets (ALI M1439/M1443/M1445)
  "ide0=umc8672"		: probe/support umc8672 chipsets
+ "idex=dc4030"		: probe/support Promise DC4030VL interface
+ "ide=doubler"		: probe/support IDE doublers on Amiga

 There may be more options than shown -- use the source, Luke!

@@ -375,3 +404,6 @@

 Wed Apr 17 22:52:44 CEST 2002 edited by Marcin Dalecki, the current
 maintainer.
+
+Wed Aug 20 22:31:29 CEST 2003 updated ide boot uptions to current ide.c
+comments @ 2.6.0-test-bk8 time. Maciej Soltysiak <solt@dns.toxicfilms.tv>
