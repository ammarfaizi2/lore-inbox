Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263212AbUCYP1H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 10:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263215AbUCYP1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 10:27:07 -0500
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:22281 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id S263212AbUCYP0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 10:26:31 -0500
Date: Thu, 25 Mar 2004 09:39:19 -0600
From: mikem@beardog.cca.cpqcorp.net
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: cciss updates [2 of 2]
Message-ID: <20040325153919.GB4456@beardog.cca.cpqcorp.net>
Reply-To: mike.miller@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please consider this for inclusion in the 2.4 kernel. 

If no device is attached we now return -ENXIO instead of some bogus numbers.
Prevents applications from trying to access non-existent disks.

 cciss.c |   16 ++++------------
 1 files changed, 4 insertions(+), 12 deletions(-)
-------------------------------------------------------------------------------
diff -burpN lx2425.orig/drivers/block/cciss.c lx2425-hazard-fix/drivers/block/cciss.c
--- lx2425.orig/drivers/block/cciss.c	2004-03-04 10:16:16.000000000 -0600
+++ lx2425-hazard-fix/drivers/block/cciss.c	2004-03-25 08:52:07.000000000 -0600
@@ -508,12 +508,8 @@ static int cciss_ioctl(struct inode *ino
 			driver_geo.heads = hba[ctlr]->drv[dsk].heads;
 			driver_geo.sectors = hba[ctlr]->drv[dsk].sectors;
 			driver_geo.cylinders = hba[ctlr]->drv[dsk].cylinders;
-		} else {
-			driver_geo.heads = 0xff;
-			driver_geo.sectors = 0x3f;
-			driver_geo.cylinders = 
-				hba[ctlr]->drv[dsk].nr_blocks / (0xff*0x3f);
-		}
+		} else 
+			return -ENXIO;
 		driver_geo.start=
 			hba[ctlr]->hd[MINOR(inode->i_rdev)].start_sect;
 		if (copy_to_user((void *) arg, &driver_geo,
@@ -528,12 +524,8 @@ static int cciss_ioctl(struct inode *ino
 			driver_geo.heads = hba[ctlr]->drv[dsk].heads;
 			driver_geo.sectors = hba[ctlr]->drv[dsk].sectors;
 			driver_geo.cylinders = hba[ctlr]->drv[dsk].cylinders;
-		} else {
-			driver_geo.heads = 0xff;
-			driver_geo.sectors = 0x3f;
-			driver_geo.cylinders = 
-				hba[ctlr]->drv[dsk].nr_blocks / (0xff*0x3f);
-		}
+		} else 
+			return -ENXIO;
 		driver_geo.start= 
 		hba[ctlr]->hd[MINOR(inode->i_rdev)].start_sect;
 		if (copy_to_user((void *) arg, &driver_geo,  
