Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267234AbUIXBlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267234AbUIXBlv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 21:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267662AbUIXBjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 21:39:55 -0400
Received: from baikonur.stro.at ([213.239.196.228]:24463 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267234AbUIWUoL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:44:11 -0400
Subject: [patch 1/9]  replace PRINTK with pr_debug in 	block/umem.c
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, domen@coderock.org
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:44:12 +0200
Message-ID: <E1CAaRo-0002Dw-L5@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org







Hi.

Removed unused dprintk, replaced PRINTK with pr_debug.
Compile tested.

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.9-rc2-bk7-max/drivers/block/umem.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff -puN drivers/block/umem.c~pr_debug-drivers_block_umem drivers/block/umem.c
--- linux-2.6.9-rc2-bk7/drivers/block/umem.c~pr_debug-drivers_block_umem	2004-09-21 20:51:31.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/block/umem.c	2004-09-21 20:51:31.000000000 +0200
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
