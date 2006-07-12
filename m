Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750876AbWGLIDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750876AbWGLIDQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 04:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbWGLIDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 04:03:15 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:6970 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750860AbWGLIDM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 04:03:12 -0400
Date: Wed, 12 Jul 2006 10:06:00 +0200
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: nickpiggin@yahoo.com.au
Subject: [PATCH 6/7] cfq-iosched: convert to using the FIFO elevator defines
Message-ID: <20060712080600.GG13920@suse.de>
References: <20060712080319.GA13920@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060712080319.GA13920@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] cfq-iosched: convert to using the FIFO elevator defines

Signed-off-by: Jens Axboe <axboe@suse.de>
---
 block/cfq-iosched.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index 95bc2e8..54cc8e3 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -42,7 +42,6 @@ #define CFQ_QHASH_ENTRIES	(1 << CFQ_QHAS
 #define list_entry_qhash(entry)	hlist_entry((entry), struct cfq_queue, cfq_hash)
 
 #define list_entry_cfqq(ptr)	list_entry((ptr), struct cfq_queue, cfq_list)
-#define list_entry_fifo(ptr)	list_entry((ptr), struct request, queuelist)
 
 #define RQ_DATA(rq)		(rq)->elevator_private
 
@@ -839,7 +838,7 @@ static inline struct cfq_rq *cfq_check_f
 	if (!list_empty(&cfqq->fifo)) {
 		int fifo = cfq_cfqq_class_sync(cfqq);
 
-		crq = RQ_DATA(list_entry_fifo(cfqq->fifo.next));
+		crq = RQ_DATA(rq_entry_fifo(cfqq->fifo.next));
 		rq = crq->request;
 		if (time_after(jiffies, rq->start_time + cfqd->cfq_fifo_expire[fifo])) {
 			cfq_mark_cfqq_fifo_expire(cfqq);
-- 
1.4.1.ged0e0

-- 
Jens Axboe

