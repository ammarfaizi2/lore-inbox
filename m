Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbUCBVGj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 16:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbUCBVGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 16:06:38 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:12952 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261773AbUCBVGd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 16:06:33 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] IDE cleanups for 2.6.4-rc1 (1/3)
Date: Tue, 2 Mar 2004 22:13:50 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403022213.50294.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[IDE] ide-disk.c: cleanup get_command()

 linux-2.6.4-rc1-root/drivers/ide/ide-disk.c |   39 +++++++++++++---------------
 1 files changed, 19 insertions(+), 20 deletions(-)

diff -puN drivers/ide/ide-disk.c~ide_get_command drivers/ide/ide-disk.c
--- linux-2.6.4-rc1/drivers/ide/ide-disk.c~ide_get_command	2004-03-02 22:11:00.063116680 +0100
+++ linux-2.6.4-rc1-root/drivers/ide/ide-disk.c	2004-03-02 22:11:00.073115160 +0100
@@ -569,28 +569,27 @@ ide_startstop_t __ide_do_rw_disk (ide_dr
 }
 EXPORT_SYMBOL_GPL(__ide_do_rw_disk);
 
-static task_ioreg_t get_command (ide_drive_t *drive, int cmd)
+static u8 get_command(ide_drive_t *drive, int cmd)
 {
-	int lba48bit = (drive->addressing == 1) ? 1 : 0;
+	unsigned int lba48 = (drive->addressing == 1) ? 1 : 0;
 
-	if ((cmd == READ) && drive->using_tcq)
-		return lba48bit ? WIN_READDMA_QUEUED_EXT : WIN_READDMA_QUEUED;
-	if ((cmd == READ) && (drive->using_dma))
-		return (lba48bit) ? WIN_READDMA_EXT : WIN_READDMA;
-	else if ((cmd == READ) && (drive->mult_count))
-		return (lba48bit) ? WIN_MULTREAD_EXT : WIN_MULTREAD;
-	else if (cmd == READ)
-		return (lba48bit) ? WIN_READ_EXT : WIN_READ;
-	else if ((cmd == WRITE) && drive->using_tcq)
-		return lba48bit ? WIN_WRITEDMA_QUEUED_EXT : WIN_WRITEDMA_QUEUED;
-	else if ((cmd == WRITE) && (drive->using_dma))
-		return (lba48bit) ? WIN_WRITEDMA_EXT : WIN_WRITEDMA;
-	else if ((cmd == WRITE) && (drive->mult_count))
-		return (lba48bit) ? WIN_MULTWRITE_EXT : WIN_MULTWRITE;
-	else if (cmd == WRITE)
-		return (lba48bit) ? WIN_WRITE_EXT : WIN_WRITE;
-	else
-		return WIN_NOP;
+	if (cmd == READ) {
+		if (drive->using_tcq)
+			return lba48 ? WIN_READDMA_QUEUED_EXT : WIN_READDMA_QUEUED;
+		if (drive->using_dma)
+			return lba48 ? WIN_READDMA_EXT : WIN_READDMA;
+		if (drive->mult_count)
+			return lba48 ? WIN_MULTREAD_EXT : WIN_MULTREAD;
+		return lba48 ? WIN_READ_EXT : WIN_READ;
+	} else {
+		if (drive->using_tcq)
+			return lba48 ? WIN_WRITEDMA_QUEUED_EXT : WIN_WRITEDMA_QUEUED;
+		if (drive->using_dma)
+			return lba48 ? WIN_WRITEDMA_EXT : WIN_WRITEDMA;
+		if (drive->mult_count)
+			return lba48 ? WIN_MULTWRITE_EXT : WIN_MULTWRITE;
+		return lba48 ? WIN_WRITE_EXT : WIN_WRITE;
+	}
 }
 
 static ide_startstop_t chs_rw_disk (ide_drive_t *drive, struct request *rq, unsigned long block)

_

