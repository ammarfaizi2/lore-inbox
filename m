Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbVCEWss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVCEWss (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 17:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVCEWrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 17:47:40 -0500
Received: from coderock.org ([193.77.147.115]:39845 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261306AbVCEWmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 17:42:47 -0500
Subject: [patch 01/15] replace PRINTK with pr_debug in block/umem.c
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, janitor@sternwelten.at
From: domen@coderock.org
Date: Sat, 05 Mar 2005 23:42:42 +0100
Message-Id: <20050305224242.7C1B91EE1E@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org







Removed unused dprintk, replaced PRINTK with pr_debug.
Compile tested.

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/block/umem.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff -puN drivers/block/umem.c~pr_debug-drivers_block_umem drivers/block/umem.c
--- kj/drivers/block/umem.c~pr_debug-drivers_block_umem	2005-03-05 16:09:08.000000000 +0100
+++ kj-domen/drivers/block/umem.c	2005-03-05 16:09:08.000000000 +0100
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
_
