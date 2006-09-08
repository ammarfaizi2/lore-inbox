Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbWIHWzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbWIHWzK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 18:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWIHWzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 18:55:10 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:18059 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1751240AbWIHWzE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 18:55:04 -0400
From: Zach Brown <zach.brown@oracle.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Message-Id: <20060908225503.9340.58989.sendpatchset@kaori.pdx.zabbo.net>
In-Reply-To: <20060908225438.9340.69862.sendpatchset@kaori.pdx.zabbo.net>
References: <20060908225438.9340.69862.sendpatchset@kaori.pdx.zabbo.net>
Subject: [PATCH 5/10] umem: repair nonexistant bh pr_debug reference
Date: Fri,  8 Sep 2006 15:55:03 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

umem: repair nonexistant bh pr_debug reference

Signed-off-by: Zach Brown <zach.brown@oracle.com>
---

 drivers/block/umem.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: 2.6.18-rc6-debug-args/drivers/block/umem.c
===================================================================
--- 2.6.18-rc6-debug-args.orig/drivers/block/umem.c
+++ 2.6.18-rc6-debug-args/drivers/block/umem.c
@@ -552,7 +552,8 @@ static void process_page(unsigned long d
 static int mm_make_request(request_queue_t *q, struct bio *bio)
 {
 	struct cardinfo *card = q->queuedata;
-	pr_debug("mm_make_request %ld %d\n", bh->b_rsector, bh->b_size);
+	pr_debug("mm_make_request %llu %u\n",
+		 (unsigned long long)bio->bi_sector, bio->bi_size);
 
 	bio->bi_phys_segments = bio->bi_idx; /* count of completed segments*/
 	spin_lock_irq(&card->lock);
