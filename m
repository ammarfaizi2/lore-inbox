Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261702AbVFTV6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbVFTV6Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 17:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbVFTV40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 17:56:26 -0400
Received: from coderock.org ([193.77.147.115]:62104 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261718AbVFTVy2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 17:54:28 -0400
Message-Id: <20050620215131.063471000@nd47.coderock.org>
Date: Mon, 20 Jun 2005 23:51:31 +0200
From: domen@coderock.org
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, Maximilian Attems <janitor@sternwelten.at>,
       domen@coderock.org
Subject: [patch 01/12] replace PRINTK with pr_debug in block/umem.c
Content-Disposition: inline; filename=pr_debug-drivers_block_umem.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Domen Puncer <domen@coderock.org>



Removed unused dprintk, replaced PRINTK with pr_debug.
Compile tested.

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 umem.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

Index: quilt/drivers/block/umem.c
===================================================================
--- quilt.orig/drivers/block/umem.c
+++ quilt/drivers/block/umem.c
@@ -34,6 +34,7 @@
  *			 - set initialised bit then.
  */
 
+//#define DEBUG /* uncomment if you want debugging info (pr_debug) */
 #include <linux/config.h>
 #include <linux/sched.h>
 #include <linux/fs.h>
@@ -58,10 +59,6 @@
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
-#define PRINTK(x...) do {} while (0)
-#define dprintk(x...) do {} while (0)
-/*#define dprintk(x...) printk(x) */
-
 #define MM_MAXCARDS 4
 #define MM_RAHEAD 2      /* two sectors */
 #define MM_BLKSIZE 1024  /* 1k blocks */
@@ -299,7 +296,7 @@ static void mm_start_io(struct cardinfo 
 
 	/* make the last descriptor end the chain */
 	page = &card->mm_pages[card->Active];
-	PRINTK("start_io: %d %d->%d\n", card->Active, page->headcnt, page->cnt-1);
+	pr_debug("start_io: %d %d->%d\n", card->Active, page->headcnt, page->cnt-1);
 	desc = &page->desc[page->cnt-1];
 
 	desc->control_bits |= cpu_to_le32(DMASCR_CHAIN_COMP_EN);
@@ -532,7 +529,7 @@ static void process_page(unsigned long d
 		activate(card);
 	} else {
 		/* haven't finished with this one yet */
-		PRINTK("do some more\n");
+		pr_debug("do some more\n");
 		mm_start_io(card);
 	}
  out_unlock:
@@ -555,7 +552,7 @@ static void process_page(unsigned long d
 static int mm_make_request(request_queue_t *q, struct bio *bio)
 {
 	struct cardinfo *card = q->queuedata;
-	PRINTK("mm_make_request %ld %d\n", bh->b_rsector, bh->b_size);
+	pr_debug("mm_make_request %ld %d\n", bh->b_rsector, bh->b_size);
 
 	bio->bi_phys_segments = bio->bi_idx; /* count of completed segments*/
 	spin_lock_irq(&card->lock);

--
