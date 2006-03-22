Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWCVPU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWCVPU5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:20:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbWCVPU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:20:57 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:27524 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750797AbWCVPU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:20:56 -0500
Date: Wed, 22 Mar 2006 16:21:23 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, horst.hummel@de.ibm.com, linux-kernel@vger.kernel.org
Subject: [patch 13/24] s390: Remove old history/whitespave from partition code.
Message-ID: <20060322152123.GM5801@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Horst Hummel <horst.hummel@de.ibm.com>

[patch 13/24] s390: Remove old history/whitespave from partition code.

Remove obsolete history and trailing whitespace.

Signed-off-by: Horst Hummel <horst.hummel@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 fs/partitions/ibm.c |   29 +++++++++++------------------
 1 files changed, 11 insertions(+), 18 deletions(-)

diff -urpN linux-2.6/fs/partitions/ibm.c linux-2.6-patched/fs/partitions/ibm.c
--- linux-2.6/fs/partitions/ibm.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/fs/partitions/ibm.c	2006-03-22 14:36:24.000000000 +0100
@@ -1,15 +1,9 @@
 /*
- * File...........: linux/fs/partitions/ibm.c      
+ * File...........: linux/fs/partitions/ibm.c
  * Author(s)......: Holger Smolinski <Holger.Smolinski@de.ibm.com>
  *                  Volker Sameske <sameske@de.ibm.com>
  * Bugreports.to..: <Linux390@de.ibm.com>
  * (C) IBM Corporation, IBM Deutschland Entwicklung GmbH, 1999,2000
-
- * History of changes (starts July 2000)
- * 07/10/00 Fixed detection of CMS formatted disks     
- * 02/13/00 VTOC partition support added
- * 12/27/01 fixed PL030593 (CMS reserved minidisk not detected on 64 bit)
- * 07/24/03 no longer using contents of freed page for CMS label recognition (BZ3611)
  */
 
 #include <linux/config.h>
@@ -25,7 +19,7 @@
 #include "ibm.h"
 
 /*
- * compute the block number from a 
+ * compute the block number from a
  * cyl-cyl-head-head structure
  */
 static inline int
@@ -34,9 +28,8 @@ cchh2blk (struct vtoc_cchh *ptr, struct 
 	       ptr->hh * geo->sectors;
 }
 
-
 /*
- * compute the block number from a 
+ * compute the block number from a
  * cyl-cyl-head-head-block structure
  */
 static inline int
@@ -48,7 +41,7 @@ cchhb2blk (struct vtoc_cchhb *ptr, struc
 
 /*
  */
-int 
+int
 ibm_partition(struct parsed_partitions *state, struct block_device *bdev)
 {
 	int blocksize, offset, size;
@@ -77,7 +70,7 @@ ibm_partition(struct parsed_partitions *
 		goto out_nogeo;
 	if ((label = kmalloc(sizeof(union label_t), GFP_KERNEL)) == NULL)
 		goto out_nolab;
-	
+
 	if (ioctl_by_bdev(bdev, BIODASDINFO, (unsigned long)info) != 0 ||
 	    ioctl_by_bdev(bdev, HDIO_GETGEO, (unsigned long)geo) != 0)
 		goto out_noioctl;
@@ -154,13 +147,13 @@ ibm_partition(struct parsed_partitions *
 
 			/* OK, we got valid partition data */
 		        offset = cchh2blk(&f1.DS1EXT1.llimit, geo);
-			size  = cchh2blk(&f1.DS1EXT1.ulimit, geo) - 
+			size  = cchh2blk(&f1.DS1EXT1.ulimit, geo) -
 				offset + geo->sectors;
 			if (counter >= state->limit)
 				break;
-			put_partition(state, counter + 1, 
-					 offset * (blocksize >> 9),
-					 size * (blocksize >> 9));
+			put_partition(state, counter + 1,
+				      offset * (blocksize >> 9),
+				      size * (blocksize >> 9));
 			counter++;
 			blk++;
 		}
@@ -175,7 +168,7 @@ ibm_partition(struct parsed_partitions *
 		offset = (info->label_block + 1);
 		size = i_size >> 9;
 		put_partition(state, 1, offset*(blocksize >> 9),
-				 size-offset*(blocksize >> 9));
+			      size-offset*(blocksize >> 9));
 	}
 
 	printk("\n");
@@ -183,7 +176,7 @@ ibm_partition(struct parsed_partitions *
 	kfree(geo);
 	kfree(info);
 	return 1;
-	
+
 out_readerr:
 out_noioctl:
 	kfree(label);
