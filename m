Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752473AbWAFRAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473AbWAFRAg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 12:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752476AbWAFRAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 12:00:35 -0500
Received: from verein.lst.de ([213.95.11.210]:52944 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S1752473AbWAFRAf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 12:00:35 -0500
Date: Fri, 6 Jan 2006 18:00:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: jejb@steeleye.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sd: use consistant printk prefixes
Message-ID: <20060106170020.GA22994@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Always use the gendisk name as prink prefix as we already do in most
places.  This makes the messages a lot more readable, especially during
bootup where sd is quite verbose.


Index: scsi-misc-2.6/drivers/scsi/sd.c
===================================================================
--- scsi-misc-2.6.orig/drivers/scsi/sd.c	2005-12-16 16:14:35.000000000 +0100
+++ scsi-misc-2.6/drivers/scsi/sd.c	2006-01-06 17:52:58.000000000 +0100
@@ -298,7 +298,8 @@
 	 */
 	if (sdp->sector_size == 1024) {
 		if ((block & 1) || (rq->nr_sectors & 1)) {
-			printk(KERN_ERR "sd: Bad block number requested");
+			printk(KERN_ERR "%s: Bad block number requested",
+					disk->disk_name);
 			return 0;
 		} else {
 			block = block >> 1;
@@ -307,7 +308,8 @@
 	}
 	if (sdp->sector_size == 2048) {
 		if ((block & 3) || (rq->nr_sectors & 3)) {
-			printk(KERN_ERR "sd: Bad block number requested");
+			printk(KERN_ERR "%s: Bad block number requested",
+					disk->disk_name);
 			return 0;
 		} else {
 			block = block >> 2;
@@ -316,7 +318,8 @@
 	}
 	if (sdp->sector_size == 4096) {
 		if ((block & 7) || (rq->nr_sectors & 7)) {
-			printk(KERN_ERR "sd: Bad block number requested");
+			printk(KERN_ERR "%s: Bad block number requested",
+					disk->disk_name);
 			return 0;
 		} else {
 			block = block >> 3;
@@ -333,7 +336,8 @@
 		SCpnt->cmnd[0] = READ_6;
 		SCpnt->sc_data_direction = DMA_FROM_DEVICE;
 	} else {
-		printk(KERN_ERR "sd: Unknown command %lx\n", rq->flags);
+		printk(KERN_ERR "%s: Unknown command %lx\n",
+				disk->disk_name, rq->flags);
 /* overkill 	panic("Unknown sd command %lx\n", rq->flags); */
 		return 0;
 	}
@@ -703,7 +707,8 @@
 			break;
 	}
 
-	if (res) {		printk(KERN_WARNING "FAILED\n  status = %x, message = %02x, "
+	if (res) {
+		printk(KERN_WARNING "FAILED\n  status = %x, message = %02x, "
 				    "host = %d, driver = %02x\n  ",
 				    status_byte(res), msg_byte(res),
 				    host_byte(res), driver_byte(res));
@@ -1267,8 +1272,7 @@
 		mb -= sz - 974;
 		sector_div(mb, 1950);
 
-		printk(KERN_NOTICE "SCSI device %s: "
-		       "%llu %d-byte hdwr sectors (%llu MB)\n",
+		printk(KERN_NOTICE "%s: %llu %d-byte hdwr sectors (%llu MB)\n",
 		       diskname, (unsigned long long)sdkp->capacity,
 		       hard_sector, (unsigned long long)mb);
 	}
@@ -1429,9 +1433,8 @@
 
 		ct =  sdkp->RCD + 2*sdkp->WCE;
 
-		printk(KERN_NOTICE "SCSI device %s: drive cache: %s\n",
+		printk(KERN_NOTICE "%s: drive cache: %s\n",
 		       diskname, types[ct]);
-
 		return;
 	}
 
@@ -1688,7 +1691,7 @@
 		return;         /* this can happen */
 
 	if (sdkp->WCE) {
-		printk(KERN_NOTICE "Synchronizing SCSI cache for disk %s: \n",
+		printk(KERN_NOTICE "%s: Synchronizing disk cache\n",
 				sdkp->disk->disk_name);
 		sd_sync_cache(sdp);
 	}
