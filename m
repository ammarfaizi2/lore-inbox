Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271368AbTHKFcr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 01:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271217AbTHKFcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 01:32:46 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:29886 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S271417AbTHKFcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 01:32:43 -0400
From: Peter Chubb <peterc@gelato.unsw.edu.au>
To: jejb@raven.il.steeleye.com
Date: Mon, 11 Aug 2003 15:32:37 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16183.10869.215949.575737@wombat.disy.cse.unsw.edu.au>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH, TRIVIAL] kill warnings in ide-scsi.c
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	ide-scsi.c has a pointer to a struct request_queue in its
struct driver; thus there's no need to dereference to get a pointer.

This kills two warnings.

===== drivers/scsi/ide-scsi.c 1.27 vs edited =====
--- 1.27/drivers/scsi/ide-scsi.c	Mon Jul  7 04:14:29 2003
+++ edited/drivers/scsi/ide-scsi.c	Mon Aug 11 14:34:57 2003
@@ -872,7 +872,7 @@
 			continue;
 		}
 		/* no, but is it queued in the ide subsystem? */
-		if (elv_queue_empty(&drive->queue)) {
+		if (elv_queue_empty(drive->queue)) {
 			spin_unlock_irqrestore(&ide_lock, flags);
 			return SUCCESS;
 		}
@@ -899,7 +899,7 @@
 		schedule_timeout(1);
 	}
 	/* now nuke the drive queue */
-	while ((req = elv_next_request(&drive->queue))) {
+	while ((req = elv_next_request(drive->queue))) {
 		blkdev_dequeue_request(req);
 		end_that_request_last(req);
 	}
