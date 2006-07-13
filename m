Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932514AbWGMMpD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbWGMMpD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 08:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbWGMMoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 08:44:09 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:27183 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751542AbWGMMoC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 08:44:02 -0400
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@suse.de>
Subject: [PATCH] 8/15 cfq-iosched: convert to using the FIFO elevator defines
Date: Thu, 13 Jul 2006 14:46:31 +0200
Message-Id: <11527947982544-git-send-email-axboe@suse.de>
X-Mailer: git-send-email 1.4.1.ged0e0
In-Reply-To: <11527947982769-git-send-email-axboe@suse.de>
References: <11527947982769-git-send-email-axboe@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jens Axboe <axboe@suse.de>
---
 block/cfq-iosched.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/block/cfq-iosched.c b/block/cfq-iosched.c
index 75efc82..3770c27 100644
--- a/block/cfq-iosched.c
+++ b/block/cfq-iosched.c
@@ -42,7 +42,6 @@ #define CFQ_QHASH_ENTRIES	(1 << CFQ_QHAS
 #define list_entry_qhash(entry)	hlist_entry((entry), struct cfq_queue, cfq_hash)
 
 #define list_entry_cfqq(ptr)	list_entry((ptr), struct cfq_queue, cfq_list)
-#define list_entry_fifo(ptr)	list_entry((ptr), struct request, queuelist)
 
 #define RQ_DATA(rq)		(rq)->elevator_private
 
@@ -840,7 +839,7 @@ static inline struct cfq_rq *cfq_check_f
 	if (!list_empty(&cfqq->fifo)) {
 		int fifo = cfq_cfqq_class_sync(cfqq);
 
-		crq = RQ_DATA(list_entry_fifo(cfqq->fifo.next));
+		crq = RQ_DATA(rq_entry_fifo(cfqq->fifo.next));
 		rq = crq->request;
 		if (time_after(jiffies, rq->start_time + cfqd->cfq_fifo_expire[fifo])) {
 			cfq_mark_cfqq_fifo_expire(cfqq);
-- 
1.4.1.ged0e0

