Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281181AbRK3Xak>; Fri, 30 Nov 2001 18:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281191AbRK3Xaa>; Fri, 30 Nov 2001 18:30:30 -0500
Received: from air-1.osdl.org ([65.201.151.5]:1548 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S281184AbRK3XaV>;
	Fri, 30 Nov 2001 18:30:21 -0500
Date: Fri, 30 Nov 2001 15:26:59 -0800 (PST)
From: <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: [patch] 2.5.1-pre4 scsi.c/scsi_lib.c
Message-ID: <Pine.LNX.4.33L2.0111301523490.6115-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch to 2.5.1-pre4 fixes error in scsi_lib.c
and warnings in scsi.c.

I haven't seen these corrections yet...

~Randy


--- linux/drivers/scsi/scsi.c.org	Fri Nov 30 11:50:11 2001
+++ linux/drivers/scsi/scsi.c	Fri Nov 30 15:15:19 2001
@@ -2430,7 +2430,7 @@
 		for (SDpnt = shpnt->host_queue; SDpnt; SDpnt = SDpnt->next) {
 			for (SCpnt = SDpnt->device_queue; SCpnt; SCpnt = SCpnt->next) {
 				/*  (0) h:c:t:l (dev sect nsect cnumsec sg) (ret all flg) (to/cmd to ito) cmd snse result %d %x      */
-				printk(KERN_INFO "(%3d) %2d:%1d:%2d:%2d (%6s %4ld %4ld %4ld %4x %1d) (%1d %1d 0x%2x) (%4d %4d %4d) 0x%2.2x 0x%2.2x 0x%8.8x\n",
+				printk(KERN_INFO "(%3d) %2d:%1d:%2d:%2d (%6s %4ld %4ld %4d %4x %1d) (%1d %1d 0x%2x) (%4d %4d %4d) 0x%2.2x 0x%2.2x 0x%8.8x\n",
 				       i++,

 				       SCpnt->host->host_no,
@@ -2476,12 +2476,12 @@
 					entry = queue_head->next;
 					do {
 						req = blkdev_entry_to_request(entry);
-						printk("(%s %d %ld %ld %ld) ",
+						printk("(%s %d %lu %lu %u) ",
 						   kdevname(req->rq_dev),
 						       req->cmd,
 						       req->sector,
 						       req->nr_sectors,
-						req->current_nr_sectors);
+						       req->current_nr_sectors);
 					} while ((entry = entry->next) != queue_head);
 					printk("\n");
 				}
--- linux/drivers/scsi/scsi_lib.c.org	Fri Nov 30 11:50:11 2001
+++ linux/drivers/scsi/scsi_lib.c	Fri Nov 30 13:53:03 2001
@@ -582,7 +582,7 @@
 	 */
 	if (good_sectors > 0) {
 		SCSI_LOG_HLCOMPLETE(1, printk("%ld sectors total, %d sectors done.\n",
-					      req->nr_sectors good_sectors));
+					      req->nr_sectors, good_sectors));
 		SCSI_LOG_HLCOMPLETE(1, printk("use_sg is %d\n ", SCpnt->use_sg));

 		req->errors = 0;

-- 

