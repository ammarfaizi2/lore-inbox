Return-Path: <SRS0=jnAq=ZB=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C17C43331
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 18:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC51214E0
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 18:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="MnbcdeIX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfKISuz (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 9 Nov 2019 13:50:55 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44847 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfKISuz (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 9 Nov 2019 13:50:55 -0500
Received: by mail-pl1-f196.google.com with SMTP id az9so4929647plb.11
        for <io-uring@vger.kernel.org>; Sat, 09 Nov 2019 10:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=olZbs3NX0vtawmeKZQ0jymTnl07EvlLPDzLuw5fKjWs=;
        b=MnbcdeIXrIsHuZscRugynTVMpTEXX/vkRauZQK2qr7SK5eMVqspyH+h8C+A9Vx57iY
         l7WeGA5w+Ij1qTPOvOYp8uKQ5zOXPfknK/DGArkYM9NsHv/YIlySjOU5lbIi2+JAe4Bd
         5J2mpidqWoDs8lu8OV2cqvIV18KNkJ/IosaROfe64YmKZ9YJheUKFdebAfUwcBRk6g2i
         fgZCtaWiscBxtENwFAbjETKXrwbJAE3zeuNA0HDUEHERC3Z86BNUKcWYP5YuFODzH5GI
         I1lkS8WmLfylOT6gVnC7VKCbqsvMIZ6IoOdCrZbfr3iwN4g1qCpig+QIM+QNkuob9yJ0
         A0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=olZbs3NX0vtawmeKZQ0jymTnl07EvlLPDzLuw5fKjWs=;
        b=TNePgPu69MwT0vDEkfOWLpDbrvYy4M8CJZkzZOdF3UbTSwPrLLizrzpeRq12U2S4fx
         ueAgxInou36VSbVKr8dL040dJC4XICFMlVPykOaZ0Ua5cz8uhpBsufFWyLFNaBCGIbm0
         yMbKIEmeKX/gh21+pzG5nVlBAiF1T5NyqKScSFW7Wm6A3YAfvOatlZ1cMGvF9e8ZYJxr
         KfhpmC+6/RDGXzIfcOdTGB+OGGOota48d+cVDuPmoIPzRwc74ARJhd1ciZscMy3XzK+u
         sGRSLI467LYJ2d3tRcYK8EJmcnCp2KPpFg5PIH0gA+41ro4C22DgNFs8WCXbeM/71x8x
         2XTg==
X-Gm-Message-State: APjAAAV0EydiHKX2fwP43OWXFwdmWVHIQFQkYDjwobBco/5Dskh+vsKz
        vi07IkB0vY7RL6wH8rkO7U0m8mnmSRE=
X-Google-Smtp-Source: APXvYqzLdcNA8NTDHu0WPE8gHU0KWxBqjas3ZQiWTg70whut+Mx4bjl0KybmQUhBH2eRXNR/Gcf8Ag==
X-Received: by 2002:a17:902:d215:: with SMTP id t21mr17972591ply.125.1573325452738;
        Sat, 09 Nov 2019 10:50:52 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id x190sm10986018pfc.89.2019.11.09.10.50.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Nov 2019 10:50:51 -0800 (PST)
To:     io-uring@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v4] io_uring: add support for backlogged CQ ring
Message-ID: <1fb145f2-7acb-ca76-b5e7-c17b2a30f31d@kernel.dk>
Date:   Sat, 9 Nov 2019 11:50:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Currently we drop completion events, if the CQ ring is full. That's fine
for requests with bounded completion times, but it may make it harder or
impossible to use io_uring with networked IO where request completion
times are generally unbounded. Or with POLL, for example, which is also
unbounded.

After this patch, we never overflow the ring, we simply store requests
in a backlog for later flushing. This flushing is done automatically by
the kernel. To prevent the backlog from growing indefinitely, if the
backlog is non-empty, we apply back pressure on IO submissions. Any
attempt to submit new IO with a non-empty backlog will get an -EBUSY
return from the kernel. This is a signal to the application that it has
backlogged CQ events, and that it must reap those before being allowed
to submit more IO.

Note that if we do return -EBUSY, we will have filled whatever
backlogged events into the CQ ring first, if there's room. This means
the application can safely reap events WITHOUT entering the kernel and
waiting for them, they are already available in the CQ ring.

If io_uring supports never dropping events, it'll flag
IORING_FEAT_NODROP in the feature flags.
    
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

Changes since v3:
- Drop IORING_SETUP_CQ_NODROP, enable always and provide an associated
  feature flag.
- Fix flushing from inside wakeup and on teardown.
- Fold in patch from Pavel on force flushing increment overflow counts,
  if appropriate.
- Ensure we don't add to backlog if ring is going away


diff --git a/fs/io_uring.c b/fs/io_uring.c
index 91103fc9771d..4d89a2f222bf 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -185,6 +185,7 @@ struct io_ring_ctx {
 		unsigned int		flags;
 		bool			compat;
 		bool			account_mem;
+		bool			cq_overflow_flushed;
 
 		/*
 		 * Ring buffer of indices into array of io_uring_sqe, which is
@@ -207,6 +208,7 @@ struct io_ring_ctx {
 
 		struct list_head	defer_list;
 		struct list_head	timeout_list;
+		struct list_head	cq_overflow_list;
 
 		wait_queue_head_t	inflight_wait;
 	} ____cacheline_aligned_in_smp;
@@ -414,6 +416,7 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 
 	ctx->flags = p->flags;
 	init_waitqueue_head(&ctx->cq_wait);
+	INIT_LIST_HEAD(&ctx->cq_overflow_list);
 	init_completion(&ctx->ctx_done);
 	init_completion(&ctx->sqo_thread_started);
 	mutex_init(&ctx->uring_lock);
@@ -588,6 +591,67 @@ static struct io_uring_cqe *io_get_cqring(struct io_ring_ctx *ctx)
 	return &rings->cqes[tail & ctx->cq_mask];
 }
 
+static void io_cqring_ev_posted(struct io_ring_ctx *ctx)
+{
+	if (waitqueue_active(&ctx->wait))
+		wake_up(&ctx->wait);
+	if (waitqueue_active(&ctx->sqo_wait))
+		wake_up(&ctx->sqo_wait);
+	if (ctx->cq_ev_fd)
+		eventfd_signal(ctx->cq_ev_fd, 1);
+}
+
+static void io_cqring_overflow_flush(struct io_ring_ctx *ctx, bool force)
+{
+	struct io_rings *rings = ctx->rings;
+	struct io_uring_cqe *cqe;
+	struct io_kiocb *req;
+	unsigned long flags;
+	LIST_HEAD(list);
+
+	if (!force) {
+		if (list_empty_careful(&ctx->cq_overflow_list))
+			return;
+		if ((ctx->cached_cq_tail - READ_ONCE(rings->cq.head) ==
+		    rings->cq_ring_entries))
+			return;
+	}
+
+	spin_lock_irqsave(&ctx->completion_lock, flags);
+
+	/* if force is set, the ring is going away. always drop after that */
+	if (force)
+		ctx->cq_overflow_flushed = true;
+
+	while (!list_empty(&ctx->cq_overflow_list)) {
+		cqe = io_get_cqring(ctx);
+		if (!cqe && !force)
+			break;
+
+		req = list_first_entry(&ctx->cq_overflow_list, struct io_kiocb,
+						list);
+		list_move(&req->list, &list);
+		if (cqe) {
+			WRITE_ONCE(cqe->user_data, req->user_data);
+			WRITE_ONCE(cqe->res, req->result);
+			WRITE_ONCE(cqe->flags, 0);
+		} else {
+			WRITE_ONCE(ctx->rings->cq_overflow,
+				atomic_inc_return(&ctx->cached_cq_overflow));
+		}
+	}
+
+	io_commit_cqring(ctx);
+	spin_unlock_irqrestore(&ctx->completion_lock, flags);
+	io_cqring_ev_posted(ctx);
+
+	while (!list_empty(&list)) {
+		req = list_first_entry(&list, struct io_kiocb, list);
+		list_del(&req->list);
+		io_put_req(req, NULL);
+	}
+}
+
 static void io_cqring_fill_event(struct io_kiocb *req, long res)
 {
 	struct io_ring_ctx *ctx = req->ctx;
@@ -601,26 +665,20 @@ static void io_cqring_fill_event(struct io_kiocb *req, long res)
 	 * the ring.
 	 */
 	cqe = io_get_cqring(ctx);
-	if (cqe) {
+	if (likely(cqe)) {
 		WRITE_ONCE(cqe->user_data, req->user_data);
 		WRITE_ONCE(cqe->res, res);
 		WRITE_ONCE(cqe->flags, 0);
-	} else {
+	} else if (ctx->cq_overflow_flushed) {
 		WRITE_ONCE(ctx->rings->cq_overflow,
 				atomic_inc_return(&ctx->cached_cq_overflow));
+	} else {
+		refcount_inc(&req->refs);
+		req->result = res;
+		list_add_tail(&req->list, &ctx->cq_overflow_list);
 	}
 }
 
-static void io_cqring_ev_posted(struct io_ring_ctx *ctx)
-{
-	if (waitqueue_active(&ctx->wait))
-		wake_up(&ctx->wait);
-	if (waitqueue_active(&ctx->sqo_wait))
-		wake_up(&ctx->sqo_wait);
-	if (ctx->cq_ev_fd)
-		eventfd_signal(ctx->cq_ev_fd, 1);
-}
-
 static void io_cqring_add_event(struct io_kiocb *req, long res)
 {
 	struct io_ring_ctx *ctx = req->ctx;
@@ -873,10 +931,20 @@ static void io_double_put_req(struct io_kiocb *req)
 		__io_free_req(req);
 }
 
-static unsigned io_cqring_events(struct io_ring_ctx *ctx)
+static unsigned io_cqring_events(struct io_ring_ctx *ctx, bool noflush)
 {
 	struct io_rings *rings = ctx->rings;
 
+	/*
+	 * noflush == true is from the waitqueue handler, just ensure we wake
+	 * up the task, and the next invocation will flush the entries. We
+	 * cannot safely to it from here.
+	 */
+	if (noflush && !list_empty(&ctx->cq_overflow_list))
+		return -1U;
+
+	io_cqring_overflow_flush(ctx, false);
+
 	/* See comment at the top of this file */
 	smp_rmb();
 	return READ_ONCE(rings->cq.tail) - READ_ONCE(rings->cq.head);
@@ -1032,7 +1100,7 @@ static int __io_iopoll_check(struct io_ring_ctx *ctx, unsigned *nr_events,
 		 * If we do, we can potentially be spinning for commands that
 		 * already triggered a CQE (eg in error).
 		 */
-		if (io_cqring_events(ctx))
+		if (io_cqring_events(ctx, false))
 			break;
 
 		/*
@@ -2876,6 +2944,11 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 	int i, submitted = 0;
 	bool mm_fault = false;
 
+	if (!list_empty(&ctx->cq_overflow_list)) {
+		io_cqring_overflow_flush(ctx, false);
+		return -EBUSY;
+	}
+
 	if (nr > IO_PLUG_THRESHOLD) {
 		io_submit_state_start(&state, ctx, nr);
 		statep = &state;
@@ -2967,6 +3040,7 @@ static int io_sq_thread(void *data)
 	timeout = inflight = 0;
 	while (!kthread_should_park()) {
 		unsigned int to_submit;
+		int ret;
 
 		if (inflight) {
 			unsigned nr_events = 0;
@@ -3051,8 +3125,9 @@ static int io_sq_thread(void *data)
 		}
 
 		to_submit = min(to_submit, ctx->sq_entries);
-		inflight += io_submit_sqes(ctx, to_submit, NULL, -1, &cur_mm,
-					   true);
+		ret = io_submit_sqes(ctx, to_submit, NULL, -1, &cur_mm, true);
+		if (ret > 0)
+			inflight += ret;
 	}
 
 	set_fs(old_fs);
@@ -3073,7 +3148,7 @@ struct io_wait_queue {
 	unsigned nr_timeouts;
 };
 
-static inline bool io_should_wake(struct io_wait_queue *iowq)
+static inline bool io_should_wake(struct io_wait_queue *iowq, bool noflush)
 {
 	struct io_ring_ctx *ctx = iowq->ctx;
 
@@ -3082,7 +3157,7 @@ static inline bool io_should_wake(struct io_wait_queue *iowq)
 	 * started waiting. For timeouts, we always want to return to userspace,
 	 * regardless of event count.
 	 */
-	return io_cqring_events(ctx) >= iowq->to_wait ||
+	return io_cqring_events(ctx, noflush) >= iowq->to_wait ||
 			atomic_read(&ctx->cq_timeouts) != iowq->nr_timeouts;
 }
 
@@ -3092,7 +3167,8 @@ static int io_wake_function(struct wait_queue_entry *curr, unsigned int mode,
 	struct io_wait_queue *iowq = container_of(curr, struct io_wait_queue,
 							wq);
 
-	if (!io_should_wake(iowq))
+	/* use noflush == true, as we can't safely rely on locking context */
+	if (!io_should_wake(iowq, true))
 		return -1;
 
 	return autoremove_wake_function(curr, mode, wake_flags, key);
@@ -3117,7 +3193,7 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 	struct io_rings *rings = ctx->rings;
 	int ret = 0;
 
-	if (io_cqring_events(ctx) >= min_events)
+	if (io_cqring_events(ctx, false) >= min_events)
 		return 0;
 
 	if (sig) {
@@ -3138,7 +3214,7 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 	do {
 		prepare_to_wait_exclusive(&ctx->wait, &iowq.wq,
 						TASK_INTERRUPTIBLE);
-		if (io_should_wake(&iowq))
+		if (io_should_wake(&iowq, false))
 			break;
 		schedule();
 		if (signal_pending(current)) {
@@ -4061,6 +4137,7 @@ static void io_ring_ctx_wait_and_kill(struct io_ring_ctx *ctx)
 		io_wq_cancel_all(ctx->io_wq);
 
 	io_iopoll_reap_events(ctx);
+	io_cqring_overflow_flush(ctx, true);
 	wait_for_completion(&ctx->ctx_done);
 	io_ring_ctx_free(ctx);
 }
@@ -4116,8 +4193,10 @@ static int io_uring_flush(struct file *file, void *data)
 	struct io_ring_ctx *ctx = file->private_data;
 
 	io_uring_cancel_files(ctx, data);
-	if (fatal_signal_pending(current) || (current->flags & PF_EXITING))
+	if (fatal_signal_pending(current) || (current->flags & PF_EXITING)) {
+		io_cqring_overflow_flush(ctx, true);
 		io_wq_cancel_all(ctx->io_wq);
+	}
 	return 0;
 }
 
@@ -4391,7 +4470,7 @@ static int io_uring_create(unsigned entries, struct io_uring_params *p)
 	if (ret < 0)
 		goto err;
 
-	p->features = IORING_FEAT_SINGLE_MMAP;
+	p->features = IORING_FEAT_SINGLE_MMAP | IORING_FEAT_NODROP;
 	trace_io_uring_create(ret, ctx, p->sq_entries, p->cq_entries, p->flags);
 	return ret;
 err:
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index f1a118b01d18..2a1569211d87 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -155,6 +155,7 @@ struct io_uring_params {
  * io_uring_params->features flags
  */
 #define IORING_FEAT_SINGLE_MMAP		(1U << 0)
+#define IORING_FEAT_NODROP		(1U << 1)
 
 /*
  * io_uring_register(2) opcodes and arguments

-- 
Jens Axboe

