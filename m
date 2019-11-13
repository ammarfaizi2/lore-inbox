Return-Path: <SRS0=KKPr=ZF=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53E6C432C3
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 21:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE2F9206E3
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 21:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="aAsJ/lm+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfKMVcP (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:32:15 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:43185 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfKMVcP (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 13 Nov 2019 16:32:15 -0500
Received: by mail-io1-f68.google.com with SMTP id c11so4267109iom.10
        for <io-uring@vger.kernel.org>; Wed, 13 Nov 2019 13:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5mG5lr2hsUL5S7ub8TymtW4h9/g5o27Ko1LgXqg1+No=;
        b=aAsJ/lm+TMA18MZWRq33MUYt0nTm/TJdCmV6aMEIqKGv03D7QY0HF5GWHzRswSocel
         Kqgp14N4O/qsDE+kcnCm3EhOZqEwYtyzH6h1fLkfHpdOkkWpyBtpt/SVri1cTzXwe0wt
         HO/hC3lFgLWAKxXD3YGNDV7548Oy0kV2E9Vc8K5UXJm/4bv1Q6UmjmFfcPPpFPgtUMFY
         wTrEXR9r/cwl8z2+NH65ov0Ys/MhjeUxNqwHwnrqUwKCRjccRBoczhV8KkAXEvdLasvU
         5DTgwz5tHR8kisRTOLHCf9zMpzzlWZhcWz8GS3bxmma1xrZPBj8zOX3t0I6uZF58JBqB
         uKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5mG5lr2hsUL5S7ub8TymtW4h9/g5o27Ko1LgXqg1+No=;
        b=jSIEy5i5/H6x7egFHETV+As//n+pxvuy6+1s2mEZpefrgzPhSmZT4X43lNVGnI2yjf
         GvFiukVeN8ntS/ml9fdxlZYAPiNzUEyaJFQ/unmsg1PWvEn1twUoBHnbTnpDguVS5Hyt
         A+KQ1jvDptgYdauIARSuzOQa7S2JVcbBzvuGnAjmMvLce5Ft8B//WC3CqPb/K2albYQY
         OCAOhqCJDZ/B9s2msirOLpvVsjg+Nx5J4f3mf0Iej0YE6oe9LmpG93NxrVX22C8B4fI6
         uJf2uSzcQDOOvxq+NVet12+Lao3Hui4nOJXxJ26WWMqld47dpjy6sT+7NkqISaddmszl
         sd7w==
X-Gm-Message-State: APjAAAV2CIo3To1NkhKDtOkQkiIGYurhto48tAFfiKj1B25HrlqREAFZ
        jF/3sOMGL1bfmHff6WmAl5NqZhy26Lc=
X-Google-Smtp-Source: APXvYqyHxCAB0gWN5wyW097Aphq9CGOdIhVLxUP7v3mIl1r3I0bN0zS4MalynkzimzFNiA1XGeWetQ==
X-Received: by 2002:a6b:760c:: with SMTP id g12mr5553632iom.304.1573680733637;
        Wed, 13 Nov 2019 13:32:13 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 6sm304872iov.45.2019.11.13.13.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 13:32:12 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     paulmck@kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/3] io-wq: ensure free/busy list browsing see all items
Date:   Wed, 13 Nov 2019 14:32:06 -0700
Message-Id: <20191113213206.2415-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191113213206.2415-1-axboe@kernel.dk>
References: <20191113213206.2415-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

We have two lists for workers in io-wq, a busy and a free list. For
certain operations we want to browse all workers, and we currently do
that by browsing the two separate lists. But since these lists are RCU
protected, we can potentially miss workers if they move between the two
lists while we're browsing them.

Add a third list, all_list, that simply holds all workers. A worker is
added to that list when it starts, and removed when it exits. This makes
the worker iteration cleaner, too.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io-wq.c | 41 +++++++++++------------------------------
 1 file changed, 11 insertions(+), 30 deletions(-)

diff --git a/fs/io-wq.c b/fs/io-wq.c
index 4031b75541be..fcb6c74209da 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -46,6 +46,7 @@ struct io_worker {
 	refcount_t ref;
 	unsigned flags;
 	struct hlist_nulls_node nulls_node;
+	struct list_head all_list;
 	struct task_struct *task;
 	wait_queue_head_t wait;
 	struct io_wqe *wqe;
@@ -96,6 +97,7 @@ struct io_wqe {
 
 	struct io_wq_nulls_list free_list;
 	struct io_wq_nulls_list busy_list;
+	struct list_head all_list;
 
 	struct io_wq *wq;
 };
@@ -212,6 +214,7 @@ static void io_worker_exit(struct io_worker *worker)
 
 	spin_lock_irq(&wqe->lock);
 	hlist_nulls_del_rcu(&worker->nulls_node);
+	list_del_rcu(&worker->all_list);
 	if (__io_worker_unuse(wqe, worker)) {
 		__release(&wqe->lock);
 		spin_lock_irq(&wqe->lock);
@@ -590,6 +593,7 @@ static void create_io_worker(struct io_wq *wq, struct io_wqe *wqe, int index)
 
 	spin_lock_irq(&wqe->lock);
 	hlist_nulls_add_head_rcu(&worker->nulls_node, &wqe->free_list.head);
+	list_add_tail_rcu(&worker->all_list, &wqe->all_list);
 	worker->flags |= IO_WORKER_F_FREE;
 	if (index == IO_WQ_ACCT_BOUND)
 		worker->flags |= IO_WORKER_F_BOUND;
@@ -733,16 +737,13 @@ static bool io_wqe_worker_send_sig(struct io_worker *worker, void *data)
  * worker that isn't exiting
  */
 static bool io_wq_for_each_worker(struct io_wqe *wqe,
-				  struct io_wq_nulls_list *list,
 				  bool (*func)(struct io_worker *, void *),
 				  void *data)
 {
-	struct hlist_nulls_node *n;
 	struct io_worker *worker;
 	bool ret = false;
 
-restart:
-	hlist_nulls_for_each_entry_rcu(worker, n, &list->head, nulls_node) {
+	list_for_each_entry_rcu(worker, &wqe->all_list, all_list) {
 		if (io_worker_get(worker)) {
 			ret = func(worker, data);
 			io_worker_release(worker);
@@ -750,8 +751,7 @@ static bool io_wq_for_each_worker(struct io_wqe *wqe,
 				break;
 		}
 	}
-	if (!ret && get_nulls_value(n) != list->nulls)
-		goto restart;
+
 	return ret;
 }
 
@@ -769,10 +769,7 @@ void io_wq_cancel_all(struct io_wq *wq)
 	for (i = 0; i < wq->nr_wqes; i++) {
 		struct io_wqe *wqe = wq->wqes[i];
 
-		io_wq_for_each_worker(wqe, &wqe->busy_list,
-					io_wqe_worker_send_sig, NULL);
-		io_wq_for_each_worker(wqe, &wqe->free_list,
-					io_wqe_worker_send_sig, NULL);
+		io_wq_for_each_worker(wqe, io_wqe_worker_send_sig, NULL);
 	}
 	rcu_read_unlock();
 }
@@ -834,14 +831,7 @@ static enum io_wq_cancel io_wqe_cancel_cb_work(struct io_wqe *wqe,
 	}
 
 	rcu_read_lock();
-	found = io_wq_for_each_worker(wqe, &wqe->free_list, io_work_cancel,
-					&data);
-	if (found)
-		goto done;
-
-	found = io_wq_for_each_worker(wqe, &wqe->busy_list, io_work_cancel,
-					&data);
-done:
+	found = io_wq_for_each_worker(wqe, io_work_cancel, &data);
 	rcu_read_unlock();
 	return found ? IO_WQ_CANCEL_RUNNING : IO_WQ_CANCEL_NOTFOUND;
 }
@@ -919,14 +909,7 @@ static enum io_wq_cancel io_wqe_cancel_work(struct io_wqe *wqe,
 	 * completion will run normally in this case.
 	 */
 	rcu_read_lock();
-	found = io_wq_for_each_worker(wqe, &wqe->free_list, io_wq_worker_cancel,
-					cwork);
-	if (found)
-		goto done;
-
-	found = io_wq_for_each_worker(wqe, &wqe->busy_list, io_wq_worker_cancel,
-					cwork);
-done:
+	found = io_wq_for_each_worker(wqe, io_wq_worker_cancel, cwork);
 	rcu_read_unlock();
 	return found ? IO_WQ_CANCEL_RUNNING : IO_WQ_CANCEL_NOTFOUND;
 }
@@ -1030,6 +1013,7 @@ struct io_wq *io_wq_create(unsigned bounded, struct mm_struct *mm,
 		wqe->free_list.nulls = 0;
 		INIT_HLIST_NULLS_HEAD(&wqe->busy_list.head, 1);
 		wqe->busy_list.nulls = 1;
+		INIT_LIST_HEAD(&wqe->all_list);
 
 		i++;
 	}
@@ -1077,10 +1061,7 @@ void io_wq_destroy(struct io_wq *wq)
 
 		if (!wqe)
 			continue;
-		io_wq_for_each_worker(wqe, &wqe->free_list, io_wq_worker_wake,
-						NULL);
-		io_wq_for_each_worker(wqe, &wqe->busy_list, io_wq_worker_wake,
-						NULL);
+		io_wq_for_each_worker(wqe, io_wq_worker_wake, NULL);
 	}
 	rcu_read_unlock();
 
-- 
2.24.0

