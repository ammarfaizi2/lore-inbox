Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269477AbUJFUg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269477AbUJFUg5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 16:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269456AbUJFU2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 16:28:47 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:41387 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269467AbUJFURT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 16:17:19 -0400
Subject: PATCH: Minimal ide-disk updates
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1097090081.29692.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 06 Oct 2004 20:14:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are the minimal updates for ide-disk. They don't remove all ident
whacking in the it8212 driver because there are genuine things to fix
there such as the LBA28 flags.


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.9rc3/drivers/ide/ide-disk.c linux-2.6.9rc3/drivers/ide/ide-disk.c
--- linux.vanilla-2.6.9rc3/drivers/ide/ide-disk.c	2004-09-30 16:13:08.000000000 +0100
+++ linux-2.6.9rc3/drivers/ide/ide-disk.c	2004-10-04 16:07:29.294774296 +0100
@@ -88,6 +88,10 @@
 {
 	unsigned long lba_sects, chs_sects, head, tail;
 
+	/* No non-LBA info .. so valid! */
+	if (id->cyls == 0)
+		return 1;
+		
 	/*
 	 * The ATA spec tells large drives to return
 	 * C/H/S = 16383/16/63 independent of their size.
@@ -1602,8 +1606,10 @@
 	if (id->buf_size)
 		printk (" w/%dKiB Cache", id->buf_size/2);
 
-	printk(", CHS=%d/%d/%d", 
-	       drive->bios_cyl, drive->bios_head, drive->bios_sect);
+	if(drive->bios_cyl)
+		printk(", CHS=%d/%d/%d", 
+	       		drive->bios_cyl, drive->bios_head, drive->bios_sect);
+	       		
 	if (drive->using_dma)
 		(void) HWIF(drive)->ide_dma_verbose(drive);
 	printk("\n");

