Return-Path: <SRS0=PUae=Y6=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4605CC5DF65
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 19:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF7820869
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 19:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ucb0NRr2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfKFTkt (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 6 Nov 2019 14:40:49 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:36930 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbfKFTkt (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 6 Nov 2019 14:40:49 -0500
Received: by mail-il1-f194.google.com with SMTP id s5so12589635iln.4
        for <io-uring@vger.kernel.org>; Wed, 06 Nov 2019 11:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EjPO4QGMU1DUkG3NOfSlQzoiYgK/klA/PbFh8I6Gp7E=;
        b=ucb0NRr2LeEymGb8msx0bgKSraZ3nTLBeoIishUzhfstpPqq9XtGUupaLCjRFdNiUm
         nZ49j3czZ+PfytMrTMjQc/X/oiJAHmv55Qis27F5Mjs8XSf4Ov3y0nr+ZHJhBIyiPMGX
         OQQRJmJjyzHdWdoljzm4kZWGrHDW8gvSjGvG8HMsgH0VvX2eCkDkb3oczx+P5Wom8zqL
         o3DgiAzR4/J8+WNiHelmQab4adF7vSBKfdsqftrV0SXthi3zQJFRdlIQQZ5ycmtqiv2J
         /Yocwqp9FP2sT9dR44tQS+ZqP5s6DnI5qpSn/Rv0N592LjZGg9/x7GepGJDDH/9gzrxp
         nLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EjPO4QGMU1DUkG3NOfSlQzoiYgK/klA/PbFh8I6Gp7E=;
        b=sbIPJWofVzgTQ+prqJyL/PyhTiDI17aLkAa2189Hmwo01N1Txn0fZztoYakhpr+ys4
         t59XBotLHZmg35RVIVuC8gjN39i9GBB49OCWd52xhe9BNKMyP4Z5r1Et67BNg78zl6Rx
         f17fzriMGp6FG8kQsn1unIxxbnZOQiGVFB4BBurvqRxc/PKWztqGgN438RtMqM9rfu3P
         HqcAXIWmHgoiTapc/MOqqrZ5Umje0oQ/TPPAu9BnQ1IpqQ3lSjux5UCU609Lx4oS5TDa
         dMfuc/sq2VSst/kX/llZmhMSVNzHX/8oifs5b9mBQ/lntY6s8srrg9D4TxnvCGPTdfaZ
         WUBQ==
X-Gm-Message-State: APjAAAV0AqC2yBPxe6cXa0vUeMEx8oIsa8goyaiuqS0KksgNrVA0gLl5
        ynabiTNOuu0Z0Uq/g2Y1oKLb3jU7H0w=
X-Google-Smtp-Source: APXvYqwxshu4LjyeateSyP2kKfh9erUw/YQzpSImvfSuZw2S7E58obX3aEyiWFzLWPrFRyGaRHfXpg==
X-Received: by 2002:a92:1711:: with SMTP id u17mr4982416ill.192.1573069247523;
        Wed, 06 Nov 2019 11:40:47 -0800 (PST)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k22sm911298iot.34.2019.11.06.11.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 11:40:46 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] io_uring: use separate io_wq's for bounded and unbounded request times
Date:   Wed,  6 Nov 2019 12:40:40 -0700
Message-Id: <20191106194040.26723-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191106194040.26723-1-axboe@kernel.dk>
References: <20191106194040.26723-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

We currently have just the one io_wq for the ctx, which is used for
both disk and network IO. Generally it can be a problem to mix the two,
since disk IO is bounded in time, and network IO is not. This can lead
to situations where we could tie up all workers with unbounded work,
leaving no room for bounded work.

Add a separate io_wq for unbounded work times.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 139 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 102 insertions(+), 37 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index ad452be9f3bc..4418139c1fce 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -213,7 +213,7 @@ struct io_ring_ctx {
 	} ____cacheline_aligned_in_smp;
 
 	/* IO offload */
-	struct io_wq		*io_wq;
+	struct io_wq		*io_wq[2];
 	struct task_struct	*sqo_thread;	/* if using sq thread polling */
 	struct mm_struct	*sqo_mm;
 	wait_queue_head_t	sqo_wait;
@@ -496,37 +496,55 @@ static inline bool io_sqe_needs_user(const struct io_uring_sqe *sqe)
 		 opcode == IORING_OP_WRITE_FIXED);
 }
 
-static inline bool io_prep_async_work(struct io_kiocb *req)
+static inline struct io_wq *io_prep_async_work(struct io_ring_ctx *ctx,
+					       struct io_kiocb *req,
+					       bool *do_hashed)
 {
-	bool do_hashed = false;
+	struct io_wq *wq = ctx->io_wq[0];
 
+	*do_hashed = false;
 	if (req->submit.sqe) {
 		switch (req->submit.sqe->opcode) {
 		case IORING_OP_WRITEV:
 		case IORING_OP_WRITE_FIXED:
-			do_hashed = true;
+			*do_hashed = true;
+			/* fall-through */
+		case IORING_OP_READV:
+		case IORING_OP_READ_FIXED:
+		case IORING_OP_SENDMSG:
+		case IORING_OP_RECVMSG:
+		case IORING_OP_ACCEPT:
+		case IORING_OP_POLL_ADD:
+			/*
+			 * We know REQ_F_ISREG is not set on some of these
+			 * opcodes, but this enables us to keep the check in
+			 * just one place.
+			 */
+			if (!(req->flags & REQ_F_ISREG))
+				wq = ctx->io_wq[1];
 			break;
 		}
 		if (io_sqe_needs_user(req->submit.sqe))
 			req->work.flags |= IO_WQ_WORK_NEEDS_USER;
 	}
 
-	return do_hashed;
+	return wq;
 }
 
 static inline void io_queue_async_work(struct io_ring_ctx *ctx,
 				       struct io_kiocb *req)
 {
-	bool do_hashed = io_prep_async_work(req);
+	struct io_wq *wq;
+	bool do_hashed;
+
+	wq = io_prep_async_work(ctx, req, &do_hashed);
 
 	trace_io_uring_queue_async_work(ctx, do_hashed, req, &req->work,
 					req->flags);
-	if (!do_hashed) {
-		io_wq_enqueue(ctx->io_wq, &req->work);
-	} else {
-		io_wq_enqueue_hashed(ctx->io_wq, &req->work,
-					file_inode(req->file));
-	}
+	if (!do_hashed)
+		io_wq_enqueue(wq, &req->work);
+	else
+		io_wq_enqueue_hashed(wq, &req->work, file_inode(req->file));
 }
 
 static void io_kill_timeout(struct io_kiocb *req)
@@ -2282,12 +2300,12 @@ static bool io_cancel_cb(struct io_wq_work *work, void *data)
 	return req->user_data == (unsigned long) data;
 }
 
-static int io_async_cancel_one(struct io_ring_ctx *ctx, void *sqe_addr)
+static int io_async_cancel_one(struct io_wq *wq, void *sqe_addr)
 {
 	enum io_wq_cancel cancel_ret;
 	int ret = 0;
 
-	cancel_ret = io_wq_cancel_cb(ctx->io_wq, io_cancel_cb, sqe_addr);
+	cancel_ret = io_wq_cancel_cb(wq, io_cancel_cb, sqe_addr);
 	switch (cancel_ret) {
 	case IO_WQ_CANCEL_OK:
 		ret = 0;
@@ -2308,7 +2326,7 @@ static int io_async_cancel(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 {
 	struct io_ring_ctx *ctx = req->ctx;
 	void *sqe_addr;
-	int ret;
+	int i, ret;
 
 	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
 		return -EINVAL;
@@ -2317,7 +2335,11 @@ static int io_async_cancel(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 		return -EINVAL;
 
 	sqe_addr = (void *) (unsigned long) READ_ONCE(sqe->addr);
-	ret = io_async_cancel_one(ctx, sqe_addr);
+	for (i = 0; i < ARRAY_SIZE(ctx->io_wq); i++) {
+		ret = io_async_cancel_one(ctx->io_wq[i], sqe_addr);
+		if (ret != IO_WQ_CANCEL_NOTFOUND)
+			break;
+	}
 
 	if (ret < 0 && (req->flags & REQ_F_LINK))
 		req->flags |= REQ_F_FAIL_LINK;
@@ -2481,10 +2503,20 @@ static void io_wq_submit_work(struct io_wq *wq, struct io_wq_work **workptr)
 	/* async context always use a copy of the sqe */
 	kfree(sqe);
 
-	/* if a dependent link is ready, pass it back */
+	/*
+	 * If a dependent link is ready and is on the same io_wq as us, pass it
+	 * back for immediate execution. If it's on a different io_wq, enqueue
+	 * it separately.
+	 */
 	if (!ret && nxt) {
-		io_prep_async_work(nxt);
-		*workptr = &nxt->work;
+		struct io_wq *nxt_wq;
+		bool do_hashed;
+
+		nxt_wq = io_prep_async_work(ctx, nxt, &do_hashed);
+		if (nxt_wq == wq)
+			*workptr = &nxt->work;
+		else
+			io_wq_enqueue(nxt_wq, &nxt->work);
 	}
 }
 
@@ -2598,8 +2630,13 @@ static enum hrtimer_restart io_link_timeout_fn(struct hrtimer *timer)
 
 	spin_unlock_irqrestore(&ctx->completion_lock, flags);
 
-	if (prev)
-		ret = io_async_cancel_one(ctx, (void *) prev->user_data);
+	if (prev) {
+		struct io_wq *wq;
+		bool tmp;
+
+		wq = io_prep_async_work(ctx, prev, &tmp);
+		ret = io_async_cancel_one(wq, (void *) prev->user_data);
+	}
 
 	io_cqring_add_event(ctx, req->user_data, ret);
 	io_put_req(req, NULL);
@@ -3274,11 +3311,15 @@ static void io_sq_thread_stop(struct io_ring_ctx *ctx)
 
 static void io_finish_async(struct io_ring_ctx *ctx)
 {
+	int i;
+
 	io_sq_thread_stop(ctx);
 
-	if (ctx->io_wq) {
-		io_wq_destroy(ctx->io_wq);
-		ctx->io_wq = NULL;
+	for (i = 0; i < ARRAY_SIZE(ctx->io_wq); i++) {
+		if (ctx->io_wq[i]) {
+			io_wq_destroy(ctx->io_wq[i]);
+			ctx->io_wq[i] = NULL;
+		}
 	}
 }
 
@@ -3286,9 +3327,11 @@ static void io_finish_async(struct io_ring_ctx *ctx)
 static void io_destruct_skb(struct sk_buff *skb)
 {
 	struct io_ring_ctx *ctx = skb->sk->sk_user_data;
+	int i;
 
-	if (ctx->io_wq)
-		io_wq_flush(ctx->io_wq);
+	for (i = 0; i < ARRAY_SIZE(ctx->io_wq); i++)
+		if (ctx->io_wq[i])
+			io_wq_flush(ctx->io_wq[i]);
 
 	unix_destruct_scm(skb);
 }
@@ -3731,12 +3774,27 @@ static int io_sq_offload_start(struct io_ring_ctx *ctx,
 		goto err;
 	}
 
-	/* Do QD, or 4 * CPUS, whatever is smallest */
+	/*
+	 * This is for the bounded time requests, generally disk IO.
+	 * Do QD, or 4 * CPUS, whatever is smallest
+	 */
 	concurrency = min(ctx->sq_entries, 4 * num_online_cpus());
-	ctx->io_wq = io_wq_create(concurrency, ctx->sqo_mm);
-	if (IS_ERR(ctx->io_wq)) {
-		ret = PTR_ERR(ctx->io_wq);
-		ctx->io_wq = NULL;
+	ctx->io_wq[0] = io_wq_create(concurrency, ctx->sqo_mm);
+	if (IS_ERR(ctx->io_wq[0])) {
+		ret = PTR_ERR(ctx->io_wq[0]);
+		ctx->io_wq[0] = NULL;
+		goto err;
+	}
+
+	/*
+	 * This pool is for unbounded request times, things that could
+	 * take an indeterminite amount of time to complete. Use a separate
+	 * pool for those, to provide fairness with the bounded queue.
+	 */
+	ctx->io_wq[1] = io_wq_create(ctx->cq_entries, ctx->sqo_mm);
+	if (IS_ERR(ctx->io_wq[1])) {
+		ret = PTR_ERR(ctx->io_wq[1]);
+		ctx->io_wq[1] = NULL;
 		goto err;
 	}
 
@@ -4114,6 +4172,8 @@ static int io_uring_fasync(int fd, struct file *file, int on)
 
 static void io_ring_ctx_wait_and_kill(struct io_ring_ctx *ctx)
 {
+	int i;
+
 	mutex_lock(&ctx->uring_lock);
 	percpu_ref_kill(&ctx->refs);
 	mutex_unlock(&ctx->uring_lock);
@@ -4121,8 +4181,9 @@ static void io_ring_ctx_wait_and_kill(struct io_ring_ctx *ctx)
 	io_kill_timeouts(ctx);
 	io_poll_remove_all(ctx);
 
-	if (ctx->io_wq)
-		io_wq_cancel_all(ctx->io_wq);
+	for (i = 0; i < ARRAY_SIZE(ctx->io_wq); i++)
+		if (ctx->io_wq[i])
+			io_wq_cancel_all(ctx->io_wq[i]);
 
 	io_iopoll_reap_events(ctx);
 	wait_for_completion(&ctx->ctx_done);
@@ -4138,7 +4199,7 @@ static int io_uring_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static void io_uring_cancel_files(struct io_ring_ctx *ctx,
+static void io_uring_cancel_files(struct io_ring_ctx *ctx, struct io_wq *wq,
 				  struct files_struct *files)
 {
 	struct io_kiocb *req;
@@ -4150,7 +4211,7 @@ static void io_uring_cancel_files(struct io_ring_ctx *ctx,
 		spin_lock_irq(&ctx->inflight_lock);
 		list_for_each_entry(req, &ctx->inflight_list, inflight_entry) {
 			if (req->work.files == files) {
-				ret = io_wq_cancel_work(ctx->io_wq, &req->work);
+				ret = io_wq_cancel_work(wq, &req->work);
 				break;
 			}
 		}
@@ -4178,10 +4239,14 @@ static void io_uring_cancel_files(struct io_ring_ctx *ctx,
 static int io_uring_flush(struct file *file, void *data)
 {
 	struct io_ring_ctx *ctx = file->private_data;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ctx->io_wq); i++)
+		io_uring_cancel_files(ctx, ctx->io_wq[i], data);
 
-	io_uring_cancel_files(ctx, data);
 	if (fatal_signal_pending(current) || (current->flags & PF_EXITING))
-		io_wq_cancel_all(ctx->io_wq);
+		for (i = 0; i < ARRAY_SIZE(ctx->io_wq); i++)
+			io_wq_cancel_all(ctx->io_wq[i]);
 	return 0;
 }
 
-- 
2.24.0

