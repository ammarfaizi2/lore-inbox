Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267292AbTBLS7m>; Wed, 12 Feb 2003 13:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267415AbTBLS7l>; Wed, 12 Feb 2003 13:59:41 -0500
Received: from zmamail01.zma.compaq.com ([161.114.64.101]:20747 "EHLO
	zmamail01.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S267292AbTBLS7j>; Wed, 12 Feb 2003 13:59:39 -0500
Date: Wed, 12 Feb 2003 13:10:04 +0600
From: steve cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: [PATCH] 2.5.60 make cciss driver compile
Message-ID: <20030212071004.GA1032@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(patch 1 of 11)
Makes the cciss driver compile in 2.5.60  (from tony@cantech.net.au)
-- steve

--- linux-2.5.60/drivers/block/cciss_scsi.c~2_5_60_cciss_scsi_fix	2003-02-12 10:12:31.000000000 +0600
+++ linux-2.5.60-scameron/drivers/block/cciss_scsi.c	2003-02-12 10:12:31.000000000 +0600
@@ -1379,11 +1379,11 @@ cciss_scsi_queue_command (Scsi_Cmnd *cmd
 
 	// Get the ptr to our adapter structure (hba[i]) out of cmd->host.
 	// We violate cmd->host privacy here.  (Is there another way?)
-	c = (ctlr_info_t **) &cmd->host->hostdata[0];	
+	c = (ctlr_info_t **) &cmd->device->host->hostdata[0];	
 	ctlr = (*c)->ctlr;
 
-	rc = lookup_scsi3addr(ctlr, cmd->channel, cmd->target, cmd->lun, 
-			scsi3addr);
+	rc = lookup_scsi3addr(ctlr, cmd->device->channel, cmd->device->id, 
+			cmd->device->lun, scsi3addr);
 	if (rc != 0) {
 		/* the scsi nexus does not match any that we presented... */
 		/* pretend to mid layer that we got selection timeout */

_
