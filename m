Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266720AbUHOOg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266720AbUHOOg4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 10:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266717AbUHOOg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 10:36:56 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22998 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266704AbUHOOgt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 10:36:49 -0400
Date: Sun, 15 Aug 2004 10:35:46 -0400
From: Alan Cox <alan@redhat.com>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: PATCH: IDE - fix various comments remove never changing ifdef
Message-ID: <20040815143546.GA6284@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No code changes in this patch just documenting

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.8-rc3/drivers/ide/ide.c linux-2.6.8-rc3/drivers/ide/ide.c
--- linux.vanilla-2.6.8-rc3/drivers/ide/ide.c	2004-08-09 15:51:00.000000000 +0100
+++ linux-2.6.8-rc3/drivers/ide/ide.c	2004-08-12 17:55:05.000000000 +0100
@@ -347,10 +405,15 @@
 	return system_bus_speed;
 }
 
-/*
- * current_capacity() returns the capacity (in sectors) of a drive
- * according to its current geometry/LBA settings.
+/**
+ *	current_capacity	-	drive capacity
+ *	@drive: drive to query
+ *
+ *	Return the current capacity (in sectors) of a drive according to
+ *	its current geometry/LBA settings. Empty removables are reported
+ *	as size zero
  */
+ 
 sector_t current_capacity (ide_drive_t *drive)
 {
 	if (!drive->present)
@@ -360,9 +423,17 @@
 
 EXPORT_SYMBOL(current_capacity);
 
-/*
- * Error reporting, in human readable form (luxurious, but a memory hog).
+/**
+ *	ide_dump_status		-	translate ATA error
+ *	@drive: drive the error occured on
+ *	@msg: information string
+ *	@stat: status byte
+ *
+ *	Error reporting, in human readable form (luxurious, but a memory hog).
+ *	Combines the drive name, message and status byte to provide a
+ *	user understandable explanation of the device error.
  */
+ 
 u8 ide_dump_status (ide_drive_t *drive, const char *msg, u8 stat)
 {
 	ide_hwif_t *hwif = HWIF(drive);
@@ -371,7 +442,6 @@
 
 	local_irq_set(flags);
 	printk(KERN_WARNING "%s: %s: status=0x%02x", drive->name, msg, stat);
-#if FANCY_STATUS_DUMPS
 	printk(" { ");
 	if (stat & BUSY_STAT) {
 		printk("Busy ");
@@ -385,12 +455,10 @@
 		if (stat & ERR_STAT)	printk("Error ");
 	}
 	printk("}");
-#endif	/* FANCY_STATUS_DUMPS */
 	printk("\n");
 	if ((stat & (BUSY_STAT|ERR_STAT)) == ERR_STAT) {
 		err = hwif->INB(IDE_ERROR_REG);
 		printk("%s: %s: error=0x%02x", drive->name, msg, err);
-#if FANCY_STATUS_DUMPS
 		if (drive->media == ide_disk) {
 			printk(" { ");
 			if (err & ABRT_ERR)	printk("DriveStatusError ");
@@ -434,7 +502,6 @@
 					printk(", sector=%llu", (unsigned long long)HWGROUP(drive)->rq->sector);
 			}
 		}
-#endif	/* FANCY_STATUS_DUMPS */
 		printk("\n");
 	}
 	local_irq_restore(flags);
