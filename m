Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272573AbTHKNWA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 09:22:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272576AbTHKNWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 09:22:00 -0400
Received: from hera.cwi.nl ([192.16.191.8]:25305 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S272573AbTHKNV4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 09:21:56 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 11 Aug 2003 15:21:52 +0200 (MEST)
Message-Id: <UTC200308111321.h7BDLqV29734.aeb@smtp.cwi.nl>
To: B.Zolnierkiewicz@elka.pw.edu.pl
Subject: [PATCH] hpt366 fix
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another one in the IDE series.

The HPT366 code is broken - it tries to set the interface
to a too high speed, which leads to error messages at boot
time and/or to data corruption.

The typical effect at boot time is

<4>hde: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
<4>hde: set_drive_speed_status: error=0x04 { DriveStatusError }

This is fixed by the patch below.

Andries

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/ide/pci/hpt366.c b/drivers/ide/pci/hpt366.c
--- a/drivers/ide/pci/hpt366.c	Sat Aug  9 22:16:42 2003
+++ b/drivers/ide/pci/hpt366.c	Mon Aug 11 16:04:06 2003
@@ -440,7 +440,7 @@
 
 static void hpt3xx_tune_drive (ide_drive_t *drive, u8 pio)
 {
-	pio = ide_get_best_pio_mode(drive, pio, 5, NULL);
+	pio = ide_get_best_pio_mode(drive, 255, pio, NULL);
 	(void) hpt3xx_tune_chipset(drive, (XFER_PIO_0 + pio));
 }
 
