Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262611AbVCVKix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262611AbVCVKix (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 05:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262614AbVCVKix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 05:38:53 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:60933 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262611AbVCVKit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 05:38:49 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: [PATCH] minor fix in IDE messages
Date: Tue, 22 Mar 2005 12:38:40 +0200
User-Agent: KMail/1.5.4
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_wW/PCVtdxVD/CkR"
Message-Id: <200503221238.40305.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_wW/PCVtdxVD/CkR
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Patch kills spurious empty line in the kernel log
ans also glues together some back-to-back printks.
--
vda

--Boundary-00=_wW/PCVtdxVD/CkR
Content-Type: text/x-diff;
  charset="koi8-r";
  name="ide-lib.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ide-lib.diff"

--- linux-2.6.11.src/drivers/ide/ide-lib.c.orig	Thu Mar  3 09:30:33 2005
+++ linux-2.6.11.src/drivers/ide/ide-lib.c	Tue Mar 22 12:37:39 2005
@@ -487,8 +487,7 @@ static u8 ide_dump_ata_status(ide_drive_
 	u8 err = 0;
 
 	local_irq_set(flags);
-	printk("%s: %s: status=0x%02x", drive->name, msg, stat);
-	printk(" { ");
+	printk("%s: %s: status=0x%02x { ", drive->name, msg, stat);
 	if (stat & BUSY_STAT)
 		printk("Busy ");
 	else {
@@ -500,12 +499,10 @@ static u8 ide_dump_ata_status(ide_drive_
 		if (stat & INDEX_STAT)	printk("Index ");
 		if (stat & ERR_STAT)	printk("Error ");
 	}
-	printk("}");
-	printk("\n");
+	printk("}\n");
 	if ((stat & (BUSY_STAT|ERR_STAT)) == ERR_STAT) {
 		err = hwif->INB(IDE_ERROR_REG);
-		printk("%s: %s: error=0x%02x", drive->name, msg, err);
-		printk(" { ");
+		printk("%s: %s: error=0x%02x { ", drive->name, msg, err);
 		if (err & ABRT_ERR)	printk("DriveStatusError ");
 		if (err & ICRC_ERR)
 			printk("Bad%s ", (err & ABRT_ERR) ? "CRC" : "Sector");
@@ -546,8 +543,8 @@ static u8 ide_dump_ata_status(ide_drive_
 				printk(", sector=%llu",
 					(unsigned long long)HWGROUP(drive)->rq->sector);
 		}
+		printk("\n");
 	}
-	printk("\n");
 	ide_dump_opcode(drive);
 	local_irq_restore(flags);
 	return err;

--Boundary-00=_wW/PCVtdxVD/CkR--

