Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265281AbUFAWcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265281AbUFAWcn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 18:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265275AbUFAWbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 18:31:50 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:13221 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265265AbUFAWaa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 18:30:30 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] IDE update [10/10]
Date: Wed, 2 Jun 2004 00:21:54 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406020021.54091.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH] ide: simplify CONFIG_IDEDMA_ONLYDISK logic a bit

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/ide-probe.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff -puN drivers/ide/ide-probe.c~idedma_onlydisk drivers/ide/ide-probe.c
--- linux-2.6.7-rc2-bk2/drivers/ide/ide-probe.c~idedma_onlydisk	2004-06-01 20:03:50.409834424 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/drivers/ide/ide-probe.c	2004-06-01 20:03:50.417833208 +0200
@@ -800,18 +800,12 @@ void probe_hwif (ide_hwif_t *hwif)
 
 	for (unit = 0; unit < MAX_DRIVES; ++unit) {
 		ide_drive_t *drive = &hwif->drives[unit];
-		int enable_dma = 1;
 
 		if (drive->present) {
 			if (hwif->tuneproc != NULL && 
 				drive->autotune == IDE_TUNE_AUTO)
 				/* auto-tune PIO mode */
 				hwif->tuneproc(drive, 255);
-
-#ifdef CONFIG_IDEDMA_ONLYDISK
-			if (drive->media != ide_disk)
-				enable_dma = 0;
-#endif
 			/*
 			 * MAJOR HACK BARF :-/
 			 *
@@ -831,7 +825,9 @@ void probe_hwif (ide_hwif_t *hwif)
 				 *   PARANOIA!!!
 				 */
 				hwif->ide_dma_off_quietly(drive);
-				if (enable_dma)
+#ifdef CONFIG_IDEDMA_ONLYDISK
+				if (drive->media == ide_disk)
+#endif
 					hwif->ide_dma_check(drive);
 			}
 		}

_

