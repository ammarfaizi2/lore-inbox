Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbTERMyO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 08:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbTERMyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 08:54:14 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:31176 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262042AbTERMxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 08:53:39 -0400
Date: Sun, 18 May 2003 15:06:27 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: alan@redhat.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Erik Andersen <andersen@codepoet.org>, trivial@rustcorp.com.au
Subject: [2.5 patch] 2.4.21-rc1 pointless IDE noise reduction
Message-ID: <20030518130627.GC12766@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is a 2.5 version of the patch to remove 
idedisk_supports_host_protected_area.

I've tested the compilation with 2.5.69-mm6.

cu
Adrian


--- linux-2.5.69-mm6/drivers/ide/ide-disk.c.old	2003-05-18 14:55:31.000000000 +0200
+++ linux-2.5.69-mm6/drivers/ide/ide-disk.c	2003-05-18 14:56:17.000000000 +0200
@@ -1064,18 +1064,6 @@
 #endif /* CONFIG_IDEDISK_STROKE */
 
 /*
- * Tests if the drive supports Host Protected Area feature.
- * Returns true if supported, false otherwise.
- */
-static inline int idedisk_supports_host_protected_area(ide_drive_t *drive)
-{
-	int flag = (drive->id->cfs_enable_1 & 0x0400) ? 1 : 0;
-	if (flag)
-		printk(KERN_INFO "%s: host protected area => %d\n", drive->name, flag);
-	return flag;
-}
-
-/*
  * Compute drive->capacity, the full capacity of the drive
  * Called with drive->id != NULL.
  *
@@ -1101,8 +1089,6 @@
 	drive->capacity48 = 0;
 	drive->select.b.lba = 0;
 
-	(void) idedisk_supports_host_protected_area(drive);
-
 	if (id->cfs_enable_2 & 0x0400) {
 		capacity_2 = id->lba_capacity_2;
 		drive->head		= drive->bios_head = 255;

