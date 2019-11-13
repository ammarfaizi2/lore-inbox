Return-Path: <SRS0=KKPr=ZF=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0927CC43141
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 21:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5FA3206ED
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 21:32:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tROX8GEH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfKMVcP (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 13 Nov 2019 16:32:15 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:39503 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfKMVcP (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 13 Nov 2019 16:32:15 -0500
Received: by mail-il1-f193.google.com with SMTP id a7so3212489ild.6
        for <io-uring@vger.kernel.org>; Wed, 13 Nov 2019 13:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sIfo+zthV9khLJLPc1TkK5OvuqRmFBkpUuRZErtsSFY=;
        b=tROX8GEHwW+HqqBHUp8BGegfYyFWUUZ0IlhThw6hCKXUSyJN7Gay6i2lVy8yJP1OXe
         GWvpn7SHmNq/19ANmySm5rqnl84MXXPjA0MXu6bRey+0dAyrs9ZcTpKjnerr0veHrfa2
         fnT5ARbcmo7CJ5Kvo3/BslVpSfm7xY6VmSE9Hi0w0fVF80xkhwCsZDhU4Arf6NCcmAxa
         /+b1IeVehdQhH65aazaogr/DRiXEF8t70ChA9Rzq7DoVHzgVVhkgNIDrso3ymY1ubpDx
         vtE+GWlEP8mTFq2MyHIFrdJtNmrhsqf8XfxiMfaBjH+/4NvKNe7oImNZra47aoaUfipP
         yOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sIfo+zthV9khLJLPc1TkK5OvuqRmFBkpUuRZErtsSFY=;
        b=epZ3O0CuF/3iof1hqLUnaAQ1xW5jaoozQS4UsMLbnDY881SGTNz4+J9GfjeoVcIXAi
         Y4Jlzg/V3Sif2kE3klv5Wq3hPptoIN4AyFzz2IOp1NC3Do69qgk1pYupZghoVdQwg6We
         rUWShfjrcYNYdmHNTwIeAaFFcBTdCV0tWyUv7zYfsgYPTYWelOLAGEtiuAT4lYFrihVB
         +nqr80qR0r+Yvck2f7zZ++wECSQSyuDyCPEXAv3DPSNApM18Mvb6XADTPWX+MxnQcvzL
         zsHzfsAsWcktTzqLE0WLTl3d8LL/wZem3YrPbK6gAqYY5KgjWSl2dC6fjejQzmJUYZxd
         yqzQ==
X-Gm-Message-State: APjAAAVr9uxAPrWpMBppR5IPVk6A9M3jpxgvy+FrxmY0qjpg2OF1KQaP
        8yH2iDFScjz8+YtE+h8TcWQsrYOKhZc=
X-Google-Smtp-Source: APXvYqyIdob0WBBkk5aPIVA8IWymYE/OLzB8YXaqBslwhjoLd5RBFPBNUpDK7NHZvA2BTlM/nvVLtw==
X-Received: by 2002:a92:cf4a:: with SMTP id c10mr6119941ilr.181.1573680732331;
        Wed, 13 Nov 2019 13:32:12 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 6sm304872iov.45.2019.11.13.13.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 13:32:11 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     paulmck@kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/3] io-wq: ensure we have a stable view of ->cur_work for cancellations
Date:   Wed, 13 Nov 2019 14:32:05 -0700
Message-Id: <20191113213206.2415-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191113213206.2415-1-axboe@kernel.dk>
References: <20191113213206.2415-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

worker->cur_work is currently protected by the lock of the wqe that the
worker belongs to. When we send a signal to a worker, we need a stable
view of ->cur_work, so we need to hold that lock. But this doesn't work
so well, since we have the opposite order potentially on queueing work.
If POLL_ADD is used with a signalfd, then io_poll_wake() is called with
the signal lock, and that sometimes needs to insert work items.

Add a specific worker lock that protects the current work item. Then we
can guarantee that the task we're sending a signal is currently
processing the exact work we think it is.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io-wq.c | 47 ++++++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/fs/io-wq.c b/fs/io-wq.c
index 26d81540c1fc..4031b75541be 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -49,7 +49,9 @@ struct io_worker {
 	struct task_struct *task;
 	wait_queue_head_t wait;
 	struct io_wqe *wqe;
+
 	struct io_wq_work *cur_work;
+	spinlock_t lock;
 
 	struct rcu_head rcu;
 	struct mm_struct *mm;
@@ -323,7 +325,6 @@ static void __io_worker_busy(struct io_wqe *wqe, struct io_worker *worker,
 		hlist_nulls_add_head_rcu(&worker->nulls_node,
 						&wqe->busy_list.head);
 	}
-	worker->cur_work = work;
 
 	/*
 	 * If worker is moving from bound to unbound (or vice versa), then
@@ -402,17 +403,6 @@ static void io_worker_handle_work(struct io_worker *worker)
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
@@ -432,6 +422,14 @@ static void io_worker_handle_work(struct io_worker *worker)
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
@@ -457,8 +455,12 @@ static void io_worker_handle_work(struct io_worker *worker)
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
@@ -577,6 +579,7 @@ static void create_io_worker(struct io_wq *wq, struct io_wqe *wqe, int index)
 	worker->nulls_node.pprev = NULL;
 	init_waitqueue_head(&worker->wait);
 	worker->wqe = wqe;
+	spin_lock_init(&worker->lock);
 
 	worker->task = kthread_create_on_node(io_wqe_worker, worker, wqe->node,
 				"io_wqe_worker-%d/%d", index, wqe->node);
@@ -783,21 +786,20 @@ struct io_cb_cancel_data {
 static bool io_work_cancel(struct io_worker *worker, void *cancel_data)
 {
 	struct io_cb_cancel_data *data = cancel_data;
-	struct io_wqe *wqe = data->wqe;
 	unsigned long flags;
 	bool ret = false;
 
 	/*
 	 * Hold the lock to avoid ->cur_work going out of scope, caller
-	 * may deference the passed in work.
+	 * may dereference the passed in work.
 	 */
-	spin_lock_irqsave(&wqe->lock, flags);
+	spin_lock_irqsave(&worker->lock, flags);
 	if (worker->cur_work &&
 	    data->cancel(worker->cur_work, data->caller_data)) {
 		send_sig(SIGINT, worker->task, 1);
 		ret = true;
 	}
-	spin_unlock_irqrestore(&wqe->lock, flags);
+	spin_unlock_irqrestore(&worker->lock, flags);
 
 	return ret;
 }
@@ -864,13 +866,20 @@ enum io_wq_cancel io_wq_cancel_cb(struct io_wq *wq, work_cancel_fn *cancel,
 static bool io_wq_worker_cancel(struct io_worker *worker, void *data)
 {
 	struct io_wq_work *work = data;
+	unsigned long flags;
+	bool ret = false;
 
+	if (worker->cur_work != work)
+		return false;
+
+	spin_lock_irqsave(&worker->lock, flags);
 	if (worker->cur_work == work) {
 		send_sig(SIGINT, worker->task, 1);
-		return true;
+		ret = true;
 	}
+	spin_unlock_irqrestore(&worker->lock, flags);
 
-	return false;
+	return ret;
 }
 
 static enum io_wq_cancel io_wqe_cancel_work(struct io_wqe *wqe,
-- 
2.24.0

