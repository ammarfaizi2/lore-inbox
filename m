Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267309AbUBSO6C (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 09:58:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267302AbUBSO55
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 09:57:57 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:4837 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S267310AbUBSO5X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 09:57:23 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] IDE update for 2.6.3 (2/9)
Date: Thu, 19 Feb 2004 15:56:58 +0100
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402191556.58471.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[IDE] keep documentation of kernel parameters in one place only

 linux-2.6.3-root/Documentation/ide.txt |    5 +-
 linux-2.6.3-root/drivers/ide/ide.c     |   72 ---------------------------------
 2 files changed, 5 insertions(+), 72 deletions(-)

diff -puN Documentation/ide.txt~ide_params_doc Documentation/ide.txt
--- linux-2.6.3/Documentation/ide.txt~ide_params_doc	2004-02-19 02:08:02.719286520 +0100
+++ linux-2.6.3-root/Documentation/ide.txt	2004-02-19 02:08:02.728285152 +0100
@@ -231,9 +231,10 @@ Summary of ide driver parameters for ker
  
  "hdx=cyl,head,sect"	: disk drive is present, with specified geometry
 
- "hdx=remap"		: remap access of sector 0 to sector 1 (for EZD)
+ "hdx=remap"		: remap access of sector 0 to sector 1 (for EZDrive)
 
- "hdx=remap63"		: remap the drive: shift all by 63 sectors (for DM)
+ "hdx=remap63"		: remap the drive: add 63 to all sector numbers
+			  (for DM OnTrack)
  
  "hdx=autotune"		: driver will attempt to tune interface speed
 			  to the fastest PIO mode supported,
diff -puN drivers/ide/ide.c~ide_params_doc drivers/ide/ide.c
--- linux-2.6.3/drivers/ide/ide.c~ide_params_doc	2004-02-19 02:08:02.723285912 +0100
+++ linux-2.6.3-root/drivers/ide/ide.c	2004-02-19 02:08:02.731284696 +0100
@@ -1785,77 +1785,9 @@ static int __initdata is_chipset_set[MAX
 
 /*
  * ide_setup() gets called VERY EARLY during initialization,
- * to handle kernel "command line" strings beginning with "hdx="
- * or "ide".  Here is the complete set currently supported:
+ * to handle kernel "command line" strings beginning with "hdx=" or "ide".
  *
- * "hdx="  is recognized for all "x" from "a" to "h", such as "hdc".
- * "idex=" is recognized for all "x" from "0" to "3", such as "ide1".
- *
- * "hdx=noprobe"	: drive may be present, but do not probe for it
- * "hdx=none"		: drive is NOT present, ignore cmos and do not probe
- * "hdx=nowerr"		: ignore the WRERR_STAT bit on this drive
- * "hdx=cdrom"		: drive is present, and is a cdrom drive
- * "hdx=cyl,head,sect"	: disk drive is present, with specified geometry
- * "hdx=remap63"	: add 63 to all sector numbers (for OnTrack DM)
- * "hdx=remap"		: remap 0->1 (for EZDrive)
- * "hdx=autotune"	: driver will attempt to tune interface speed
- *				to the fastest PIO mode supported,
- *				if possible for this drive only.
- *				Not fully supported by all chipset types,
- *				and quite likely to cause trouble with
- *				older/odd IDE drives.
- * "hdx=swapdata"	: when the drive is a disk, byte swap all data
- * "hdx=bswap"		: same as above..........
- * "hdxlun=xx"          : set the drive last logical unit.
- * "hdx=scsi"		: the return of the ide-scsi flag, this is useful for
- *				allowing ide-floppy, ide-tape, and ide-cdrom|writers
- *				to use ide-scsi emulation on a device specific option.
- * "idebus=xx"		: inform IDE driver of VESA/PCI bus speed in MHz,
- *				where "xx" is between 20 and 66 inclusive,
- *				used when tuning chipset PIO modes.
- *				For PCI bus, 25 is correct for a P75 system,
- *				30 is correct for P90,P120,P180 systems,
- *				and 33 is used for P100,P133,P166 systems.
- *				If in doubt, use idebus=33 for PCI.
- *				As for VLB, it is safest to not specify it.
- *
- * "idex=noprobe"	: do not attempt to access/use this interface
- * "idex=base"		: probe for an interface at the addr specified,
- *				where "base" is usually 0x1f0 or 0x170
- *				and "ctl" is assumed to be "base"+0x206
- * "idex=base,ctl"	: specify both base and ctl
- * "idex=base,ctl,irq"	: specify base, ctl, and irq number
- * "idex=autotune"	: driver will attempt to tune interface speed
- *				to the fastest PIO mode supported,
- *				for all drives on this interface.
- *				Not fully supported by all chipset types,
- *				and quite likely to cause trouble with
- *				older/odd IDE drives.
- * "idex=noautotune"	: driver will NOT attempt to tune interface speed
- *				This is the default for most chipsets,
- *				except the cmd640.
- * "idex=serialize"	: do not overlap operations on idex and ide(x^1)
- * "idex=four"		: four drives on idex and ide(x^1) share same ports
- * "idex=reset"		: reset interface before first use
- * "idex=dma"		: enable DMA by default on both drives if possible
- * "idex=ata66"		: informs the interface that it has an 80c cable
- *				for chipsets that are ATA-66 capable, but
- *				the ablity to bit test for detection is
- *				currently unknown.
- * "ide=reverse"	: Formerly called to pci sub-system, but now local.
- *
- * The following are valid ONLY on ide0, (except dc4030)
- * and the defaults for the base,ctl ports must not be altered.
- *
- * "ide0=dtc2278"	: probe/support DTC2278 interface
- * "ide0=ht6560b"	: probe/support HT6560B interface
- * "ide0=cmd640_vlb"	: *REQUIRED* for VLB cards with the CMD640 chip
- *			  (not for PCI -- automatically detected)
- * "ide0=qd65xx"	: probe/support qd65xx interface
- * "ide0=ali14xx"	: probe/support ali14xx chipsets (ALI M1439, M1443, M1445)
- * "ide0=umc8672"	: probe/support umc8672 chipsets
- * "idex=dc4030"	: probe/support Promise DC4030VL interface
- * "ide=doubler"	: probe/support IDE doublers on Amiga
+ * Remember to update Documentation/ide.txt if you change something here.
  */
 int __init ide_setup (char *s)
 {

_

