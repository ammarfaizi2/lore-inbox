Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267463AbTBNU4L>; Fri, 14 Feb 2003 15:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267466AbTBNUy1>; Fri, 14 Feb 2003 15:54:27 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:17674 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S267463AbTBNUwv>; Fri, 14 Feb 2003 15:52:51 -0500
Subject: PATCH: fix cciss scsi breakage
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Fri, 14 Feb 2003 21:02:37 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E18jmyj-0005f2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.60-ref/drivers/block/cciss_scsi.c linux-2.5.60-ac1/drivers/block/cciss_scsi.c
--- linux-2.5.60-ref/drivers/block/cciss_scsi.c	2003-02-14 21:21:37.000000000 +0000
+++ linux-2.5.60-ac1/drivers/block/cciss_scsi.c	2003-02-14 19:01:45.000000000 +0000
@@ -1379,10 +1379,10 @@
 
 	// Get the ptr to our adapter structure (hba[i]) out of cmd->host.
 	// We violate cmd->host privacy here.  (Is there another way?)
-	c = (ctlr_info_t **) &cmd->host->hostdata[0];	
+	c = (ctlr_info_t **) &cmd->device->host->hostdata[0];
 	ctlr = (*c)->ctlr;
 
-	rc = lookup_scsi3addr(ctlr, cmd->channel, cmd->target, cmd->lun, 
+	rc = lookup_scsi3addr(ctlr, cmd->device->channel, cmd->device->id, cmd->device->lun, 
 			scsi3addr);
 	if (rc != 0) {
 		/* the scsi nexus does not match any that we presented... */
