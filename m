Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030643AbVIIWIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030643AbVIIWIM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 18:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030641AbVIIWIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 18:08:11 -0400
Received: from ccerelbas04.cce.hp.com ([161.114.21.107]:13014 "EHLO
	ccerelbas04.cce.hp.com") by vger.kernel.org with ESMTP
	id S1030639AbVIIWII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 18:08:08 -0400
Date: Fri, 9 Sep 2005 17:07:50 -0500
From: mike.miller@hp.com
To: akpm@osdl.org, axboe@suse.de
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 5/8] cciss: bug fix in cciss_remove_one
Message-ID: <20050909220750.GE4616@beardog.cca.cpqcorp.net>
Reply-To: mikem@beardog.cca.cpqcorp.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 5 of 8
This patch fixes a bug in cciss_remove_one. A set of braces was missing 
for the if statement causing an Oops on driver unload.
Please consider this for inclusion.

Signed-off-by: Mike Miller <mike.miller@hp.com>

 cciss.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)
--------------------------------------------------------------------------------
diff -burNp lx2613-p004/drivers/block/cciss.c lx2613/drivers/block/cciss.c
--- lx2613-p004/drivers/block/cciss.c	2005-09-09 16:09:13.362617000 -0500
+++ lx2613/drivers/block/cciss.c	2005-09-09 16:10:55.801044320 -0500
@@ -3097,9 +3097,10 @@ static void __devexit cciss_remove_one (
 	/* remove it from the disk list */
 	for (j = 0; j < NWD; j++) {
 		struct gendisk *disk = hba[i]->gendisk[j];
-		if (disk->flags & GENHD_FL_UP)
-			blk_cleanup_queue(disk->queue);
+		if (disk->flags & GENHD_FL_UP) {
 			del_gendisk(disk);
+			blk_cleanup_queue(disk->queue);
+		}
 	}
 
 	pci_free_consistent(hba[i]->pdev, NR_CMDS * sizeof(CommandList_struct),
