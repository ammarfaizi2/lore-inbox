Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264198AbUFSQVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264198AbUFSQVG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 12:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264371AbUFSQSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 12:18:31 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:5028 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264305AbUFSQPp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 12:15:45 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] ide-taskfile.c fixups/cleanups [2/11]
Date: Sat, 19 Jun 2004 18:08:27 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406191808.27138.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH] ide: end request fix for CONFIG_IDE_TASKFILE_IO=y PIO handlers

ide_end_drive_cmd() should only be called for "flagged" taskfiles
which have separate PIO handlers so use driver->end_request() instead.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-bzolnier/drivers/ide/ide-taskfile.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -puN drivers/ide/ide-taskfile.c~ide_tf_end_fix drivers/ide/ide-taskfile.c
--- linux-2.6.7/drivers/ide/ide-taskfile.c~ide_tf_end_fix	2004-06-19 02:41:30.203064168 +0200
+++ linux-2.6.7-bzolnier/drivers/ide/ide-taskfile.c	2004-06-19 02:41:30.207063560 +0200
@@ -586,7 +586,7 @@ check_status:
 			return ide_stopped;
 	/* Complete rq->buffer based request (ioctls). */
 	if (!rq->bio && !rq->nr_sectors) {
-		ide_end_drive_cmd(drive, stat, HWIF(drive)->INB(IDE_ERROR_REG));
+		DRIVER(drive)->end_request(drive, 1, 0);
 		return ide_stopped;
 	}
 
@@ -637,7 +637,7 @@ check_status:
 			return ide_stopped;
 	/* Complete rq->buffer based request (ioctls). */
 	if (!rq->bio && !rq->nr_sectors) {
-		ide_end_drive_cmd(drive, stat, HWIF(drive)->INB(IDE_ERROR_REG));
+		DRIVER(drive)->end_request(drive, 1, 0);
 		return ide_stopped;
 	}
 
@@ -703,7 +703,7 @@ ide_startstop_t task_out_intr (ide_drive
 			return ide_stopped;
 	/* Complete rq->buffer based request (ioctls). */
 	if (!rq->bio && !rq->nr_sectors) {
-		ide_end_drive_cmd(drive, stat, HWIF(drive)->INB(IDE_ERROR_REG));
+		DRIVER(drive)->end_request(drive, 1, 0);
 		return ide_stopped;
 	}
 
@@ -772,7 +772,7 @@ ide_startstop_t task_mulout_intr (ide_dr
 			return ide_stopped;
 	/* Complete rq->buffer based request (ioctls). */
 	if (!rq->bio && !rq->nr_sectors) {
-		ide_end_drive_cmd(drive, stat, HWIF(drive)->INB(IDE_ERROR_REG));
+		DRIVER(drive)->end_request(drive, 1, 0);
 		return ide_stopped;
 	}
 

_

