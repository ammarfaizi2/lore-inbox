Return-Path: <SRS0=KKPr=ZF=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BF0C43215
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 19:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F55D206E1
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 19:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZpxfJBgU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfKMToE (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 13 Nov 2019 14:44:04 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:36695 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfKMToE (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 13 Nov 2019 14:44:04 -0500
Received: by mail-il1-f193.google.com with SMTP id s75so2920455ilc.3
        for <io-uring@vger.kernel.org>; Wed, 13 Nov 2019 11:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ugIaBuUqf7Vu8F9NdLeHoAg8IER4ps6Ezy1tXBvq2u0=;
        b=ZpxfJBgU7NhXS4wZhSE7KApkosxjDZAwyj3IreiD+e948KG3VwDXGmMvEpueik1yns
         +aMU6cFF8bWkDrF8h0aKcHt63gNbi4hlt6+nAaKa0/EZjMAbpWcmYdDiSx2al61Zu3+f
         tLLw+K52LLohNS2jCrDm23fdFMuI01yR0nuwy2F1AB2ZcfEeb4HJHtghoK+YN4TmBORa
         pTygR95yR5nSBB2XuGOiOmJRbeDSxUXVOJQXo9Q9awkgEe5mjXGCDiVLBzuO6vHdUxGx
         ppUAdHGgHonJ6jIb5FbzX+Yc3b4PrEOOITv4pqeKVmej3JV707J7pmqaIEw7H05SW9Xs
         w5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ugIaBuUqf7Vu8F9NdLeHoAg8IER4ps6Ezy1tXBvq2u0=;
        b=ddbwW2LDNo0VwOrj68lhXiWiXaPRI0T1rGE8vcw4foukCHLrn5fU+lt314PSsz3PQ+
         pmYwm2FLCuQApK46HNBWSZfqXZrQhnZupgRJAjmM7EMjn4uZlO1vfAzGJpq8C6UdVyIg
         sXWsMNrp4uIhfUxyetYVtrX+lDSNhxxD68MGdUwVpFMNjRH4AFiNgx/yo6DIoBcRdsyR
         fS3/QbSkjIfghKcc5KbOEas6HFIKAksKn7Vhp5AGHRFXvEU5FqMqm743DSy+afbqVkg5
         jmMqmg5LQB1tcXUimiRvZYvmmFC9+N/xu10ooa0RnEJyOL/dOlo9MOcEiJ1NK9WiU2zH
         3FDg==
X-Gm-Message-State: APjAAAXgWwLtbM0G/7UPiyZtIIJDVFGCunlHwLZhhujhODWORY6qfIsb
        aLuBzYHJkfUjXjHUaXWOAYtscQol0Cs=
X-Google-Smtp-Source: APXvYqwOSuM91KWKQjQqt1q9Um9jcQOh++8BMvRsDk9zaM7m4N/9dtzBJPHk1Nos+VVwB0Ix11MERQ==
X-Received: by 2002:a92:af99:: with SMTP id v25mr6184031ill.167.1573674241505;
        Wed, 13 Nov 2019 11:44:01 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p2sm295812iod.39.2019.11.13.11.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 11:44:00 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH 2/2] io-wq: ensure task is valid before sending it a signal
Date:   Wed, 13 Nov 2019 12:43:55 -0700
Message-Id: <20191113194355.12107-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191113194355.12107-1-axboe@kernel.dk>
References: <20191113194355.12107-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

While we're always under RCU read protection when finding the worker
to signal, that only protects the worker from being freed. The task
could very well be exiting, if we get unlucky enough.

Same is true for ->cur_work, which is currently under protection by
the wqe->lock that this worker belongs to. Add a specific worker lock
that protects whether the task is exiting and also the current work
item. Then we can guarantee that the task we're sending a signal is:

1) Currently processing the exact work we think it is
2) It's not currently exiting

It's important to not use the wqe->lock for ->cur_work, as we can run
into lock ordering issues with io_poll_wake() being called under the
signal lock if we're polling a signal fd, and io_poll_wake() then
needing to call io_wq_enqueue() which grabs wqe->lock. For cancel, the
ordering is exactly the opposite.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io-wq.c | 66 ++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 22 deletions(-)

diff --git a/fs/io-wq.c b/fs/io-wq.c
index 26d81540c1fc..f035460b9776 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -49,7 +49,10 @@ struct io_worker {
 	struct task_struct *task;
 	wait_queue_head_t wait;
 	struct io_wqe *wqe;
+
 	struct io_wq_work *cur_work;
+	spinlock_t lock;
+	int exiting;
 
 	struct rcu_head rcu;
 	struct mm_struct *mm;
@@ -223,6 +226,10 @@ static void io_worker_exit(struct io_worker *worker)
 	if (!nr_workers && refcount_dec_and_test(&wqe->wq->refs))
 		complete(&wqe->wq->done);
 
+	spin_lock_irq(&worker->lock);
+	worker->exiting = true;
+	spin_unlock_irq(&worker->lock);
+
 	kfree_rcu(worker, rcu);
 }
 
@@ -323,7 +330,6 @@ static void __io_worker_busy(struct io_wqe *wqe, struct io_worker *worker,
 		hlist_nulls_add_head_rcu(&worker->nulls_node,
 						&wqe->busy_list.head);
 	}
-	worker->cur_work = work;
 
 	/*
 	 * If worker is moving from bound to unbound (or vice versa), then
@@ -402,17 +408,6 @@ static void io_worker_handle_work(struct io_worker *worker)
 	do {
 		unsigned hash = -1U;
 
-		/*
-		 * Signals are either sent to cancel specific work, or to just
-		 * cancel all work items. For the former, ->cur_work must
-		 * match. ->cur_work is NULL at this point, since we haven't
-		 * assigned any work, so it's safe to flush signals for that
-		 * case. For the latter case of cancelling all work, the caller
-		 * wil have set IO_WQ_BIT_CANCEL.
-		 */
-		if (signal_pending(current))
-			flush_signals(current);
-
 		/*
 		 * If we got some work, mark us as busy. If we didn't, but
 		 * the list isn't empty, it means we stalled on hashed work.
@@ -432,6 +427,14 @@ static void io_worker_handle_work(struct io_worker *worker)
 		if (!work)
 			break;
 next:
+		/* flush any pending signals before assigning new work */
+		if (signal_pending(current))
+			flush_signals(current);
+
+		spin_lock_irq(&worker->lock);
+		worker->cur_work = work;
+		spin_unlock_irq(&worker->lock);
+
 		if ((work->flags & IO_WQ_WORK_NEEDS_FILES) &&
 		    current->files != work->files) {
 			task_lock(current);
@@ -457,8 +460,12 @@ static void io_worker_handle_work(struct io_worker *worker)
 		old_work = work;
 		work->func(&work);
 
-		spin_lock_irq(&wqe->lock);
+		spin_lock_irq(&worker->lock);
 		worker->cur_work = NULL;
+		spin_unlock_irq(&worker->lock);
+
+		spin_lock_irq(&wqe->lock);
+
 		if (hash != -1U) {
 			wqe->hash_map &= ~BIT_ULL(hash);
 			wqe->flags &= ~IO_WQE_FLAG_STALLED;
@@ -577,6 +584,7 @@ static void create_io_worker(struct io_wq *wq, struct io_wqe *wqe, int index)
 	worker->nulls_node.pprev = NULL;
 	init_waitqueue_head(&worker->wait);
 	worker->wqe = wqe;
+	spin_lock_init(&worker->lock);
 
 	worker->task = kthread_create_on_node(io_wqe_worker, worker, wqe->node,
 				"io_wqe_worker-%d/%d", index, wqe->node);
@@ -721,7 +729,10 @@ void io_wq_enqueue_hashed(struct io_wq *wq, struct io_wq_work *work, void *val)
 
 static bool io_wqe_worker_send_sig(struct io_worker *worker, void *data)
 {
-	send_sig(SIGINT, worker->task, 1);
+	spin_lock_irq(&worker->lock);
+	if (!worker->exiting)
+		send_sig(SIGINT, worker->task, 1);
+	spin_unlock_irq(&worker->lock);
 	return false;
 }
 
@@ -783,7 +794,6 @@ struct io_cb_cancel_data {
 static bool io_work_cancel(struct io_worker *worker, void *cancel_data)
 {
 	struct io_cb_cancel_data *data = cancel_data;
-	struct io_wqe *wqe = data->wqe;
 	unsigned long flags;
 	bool ret = false;
 
@@ -791,13 +801,14 @@ static bool io_work_cancel(struct io_worker *worker, void *cancel_data)
 	 * Hold the lock to avoid ->cur_work going out of scope, caller
 	 * may deference the passed in work.
 	 */
-	spin_lock_irqsave(&wqe->lock, flags);
+	spin_lock_irqsave(&worker->lock, flags);
 	if (worker->cur_work &&
 	    data->cancel(worker->cur_work, data->caller_data)) {
-		send_sig(SIGINT, worker->task, 1);
+		if (!worker->exiting)
+			send_sig(SIGINT, worker->task, 1);
 		ret = true;
 	}
-	spin_unlock_irqrestore(&wqe->lock, flags);
+	spin_unlock_irqrestore(&worker->lock, flags);
 
 	return ret;
 }
@@ -864,13 +875,21 @@ enum io_wq_cancel io_wq_cancel_cb(struct io_wq *wq, work_cancel_fn *cancel,
 static bool io_wq_worker_cancel(struct io_worker *worker, void *data)
 {
 	struct io_wq_work *work = data;
+	unsigned long flags;
+	bool ret = false;
+
+	if (worker->cur_work != work)
+		return false;
 
+	spin_lock_irqsave(&worker->lock, flags);
 	if (worker->cur_work == work) {
-		send_sig(SIGINT, worker->task, 1);
-		return true;
+		if (!worker->exiting)
+			send_sig(SIGINT, worker->task, 1);
+		ret = true;
 	}
+	spin_unlock_irqrestore(&worker->lock, flags);
 
-	return false;
+	return ret;
 }
 
 static enum io_wq_cancel io_wqe_cancel_work(struct io_wqe *wqe,
@@ -1049,7 +1068,10 @@ struct io_wq *io_wq_create(unsigned bounded, struct mm_struct *mm,
 
 static bool io_wq_worker_wake(struct io_worker *worker, void *data)
 {
-	wake_up_process(worker->task);
+	spin_lock_irq(&worker->lock);
+	if (!worker->exiting)
+		wake_up_process(worker->task);
+	spin_unlock_irq(&worker->lock);
 	return false;
 }
 
-- 
2.24.0

