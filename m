Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263654AbTDTSQV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 14:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263656AbTDTSQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 14:16:20 -0400
Received: from hera.cwi.nl ([192.16.191.8]:8633 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S263654AbTDTSQR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 14:16:17 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 20 Apr 2003 20:28:17 +0200 (MEST)
Message-Id: <UTC200304201828.h3KISHp18103.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com
Subject: [PATCH] silence some superfluous boot messages
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I suppose these can be removed altogether.
For now #if 0 ... #endif.

diff -u --recursive --new-file -X /linux/dontdiff a/drivers/block/ll_rw_blk.c b/drivers/block/ll_rw_blk.c
--- a/drivers/block/ll_rw_blk.c	Tue Apr  8 09:36:36 2003
+++ b/drivers/block/ll_rw_blk.c	Sun Apr 20 18:58:38 2003
@@ -1867,7 +1867,7 @@
  * generic_make_request() does not return any status.  The
  * success/failure status of the request, along with notification of
  * completion, is delivered asynchronously through the bio->bi_end_io
- * function described (one day) else where.
+ * function described (one day) elsewhere.
  *
  * The caller of generic_make_request must make sure that bi_io_vec
  * are set to describe the memory buffer, and that bi_dev and bi_sector are
@@ -2204,14 +2204,14 @@
 	batch_requests = queue_nr_requests / 8;
 	if (batch_requests > 8)
 		batch_requests = 8;
-
+#if 0
 	printk("block request queues:\n");
 	printk(" %d requests per read queue\n", queue_nr_requests);
 	printk(" %d requests per write queue\n", queue_nr_requests);
 	printk(" %d requests per batch\n", batch_requests);
 	printk(" enter congestion at %d\n", queue_congestion_on_threshold());
 	printk(" exit congestion at %d\n", queue_congestion_off_threshold());
-
+#endif
 	blk_max_low_pfn = max_low_pfn;
 	blk_max_pfn = max_pfn;
 
diff -u --recursive --new-file -X /linux/dontdiff a/drivers/ide/ide-disk.c b/drivers/ide/ide-disk.c
--- a/drivers/ide/ide-disk.c	Sun Apr 20 12:59:31 2003
+++ b/drivers/ide/ide-disk.c	Sun Apr 20 18:58:58 2003
@@ -1079,8 +1079,11 @@
 static inline int idedisk_supports_host_protected_area(ide_drive_t *drive)
 {
 	int flag = (drive->id->cfs_enable_1 & 0x0400) ? 1 : 0;
+#if 0
 	if (flag)
-		printk(KERN_INFO "%s: host protected area => %d\n", drive->name, flag);
+		printk(KERN_INFO "%s: host protected area => %d\n",
+		       drive->name, flag);
+#endif
 	return flag;
 }
 
diff -u --recursive --new-file -X /linux/dontdiff a/fs/bio.c b/fs/bio.c
--- a/fs/bio.c	Tue Mar 25 04:54:40 2003
+++ b/fs/bio.c	Sun Apr 20 18:59:16 2003
@@ -743,10 +743,10 @@
 					mempool_free_slab, bp->slab);
 		if (!bp->pool)
 			panic("biovec: can't init mempool\n");
-
+#if 0
 		printk("biovec pool[%d]: %3d bvecs: %3d entries (%d bytes)\n",
-						i, bp->nr_vecs, pool_entries,
-						size);
+		       i, bp->nr_vecs, pool_entries, size);
+#endif
 	}
 }
 
