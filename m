Return-Path: <SRS0=PUae=Y6=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E38C5DF63
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 16:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F45B2178F
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 16:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Kde3RP9E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732214AbfKFQWD (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 6 Nov 2019 11:22:03 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:46476 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729392AbfKFQWD (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 6 Nov 2019 11:22:03 -0500
Received: by mail-il1-f196.google.com with SMTP id m16so22269416iln.13
        for <io-uring@vger.kernel.org>; Wed, 06 Nov 2019 08:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=I7oCtuvQ+huXOioWiibHe04+fosNs1b1RQFbFch5Qho=;
        b=Kde3RP9EtO47isbDDqIw/t0RG+RO5j3mCcMK2G81YFMIAqfMRxSFBPNJUmVhigoB2T
         +0loJnip0UMVnvxvkypFLcppOjGQChHkr75p8otM4cvQ1/2sERqs9lZTIweQgNZIMajx
         CklZ2M3W/jWMOKtYbeiuLhQo5qOYrJuUaoWdfqlktpgs0lfvAKRt2JhV2sBjM6tdLhxF
         BqXLj8elmby2VH9U8ZyOOnumge7N20ycAzix/JHKj9zMO3B+wj/dHNojMum8/q6oXbs6
         VgqR1zddL73jGImhMAJEqF0tTRlrqjaGQHu8CdxpTHJ3sOZDxrcJSSwYWquli3ULaz7n
         alvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=I7oCtuvQ+huXOioWiibHe04+fosNs1b1RQFbFch5Qho=;
        b=jhm0OMTv+eWZRmRrJWnojXIkcpU8aABUPPvIF12GGvQv7pxnOGVntkMhpeLlNtJ73E
         J3HdM+iJPCwuHrZlUL0oZhk1h0cFE6q2I1T/H27sRA2J1+b7HKuPJbEvw87VkK9oBtvC
         X/Hvwtu7wx6Ob5cRmIGEeW84GG+ubQFh8XLOKfpjEx/8wZa700HBIoeiSzCypN5J60JE
         AyGthENgXNzdO8zLgnlgfesvOlnHbLRe3F1SV8df3572q+LmRCV2iEaJiAq5L0szjgSo
         EyS14x3xEYwbX36P+0oydUXCbZ8V5pYrcmJf/ZbyXcR9uw+NDWrJ3+RB4JvJTupIb7O0
         iSTg==
X-Gm-Message-State: APjAAAWaOtb2Lj7Qw1yvxUzrlrAOS+SuNkpohUFDE37+IH7LYiUteQKf
        z1lg8XeCTCr4SsrF21mK80NZiKcIkXY=
X-Google-Smtp-Source: APXvYqw96Ih7tq2xCUfiye1nG3ubI3uVsVTlNNyxqNSUyNxv6Y0xTA59+iiZhGRrenI8WD5xVVv+3g==
X-Received: by 2002:a05:6e02:c29:: with SMTP id q9mr3510873ilg.7.1573057319220;
        Wed, 06 Nov 2019 08:21:59 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h6sm1861263ilr.7.2019.11.06.08.21.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 08:21:58 -0800 (PST)
To:     io-uring@vger.kernel.org,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [RFC] io_uring CQ ring backpressure
Message-ID: <37d8ba3d-27c7-7636-0343-23ec56e4bee7@kernel.dk>
Date:   Wed, 6 Nov 2019 09:21:57 -0700
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
for requests with bounded completion times, but it may make it harder to
use io_uring with networked IO where request completion times are
generally unbounded. Or with POLL, for example, which is also unbounded.

This patch adds IORING_SETUP_CQ_NODROP, which changes the behavior a bit
for CQ ring overflows. First of all, it doesn't overflow the ring, it
simply stores backlog of completions that we weren't able to put into
the CQ ring. To prevent the backlog from growing indefinitely, if the
backlog is non-empty, we apply back pressure on IO submissions. Any
attempt to submit new IO with a non-empty backlog will get an -EBUSY
return from the kernel.

I think that makes for a pretty sane API in terms of how the application
can handle it. With CQ_NODROP enabled, we'll never drop a completion
event (well unless we're totally out of memory...), but we'll also not
allow submissions with a completion backlog.

---

diff --git a/fs/io_uring.c b/fs/io_uring.c
index b647cdf0312c..12e9fe2479f4 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -207,6 +207,7 @@ struct io_ring_ctx {
 
 		struct list_head	defer_list;
 		struct list_head	timeout_list;
+		struct list_head	cq_overflow_list;
 
 		wait_queue_head_t	inflight_wait;
 	} ____cacheline_aligned_in_smp;
@@ -414,6 +415,7 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 
 	ctx->flags = p->flags;
 	init_waitqueue_head(&ctx->cq_wait);
+	INIT_LIST_HEAD(&ctx->cq_overflow_list);
 	init_completion(&ctx->ctx_done);
 	init_completion(&ctx->sqo_thread_started);
 	mutex_init(&ctx->uring_lock);
@@ -588,6 +590,77 @@ static struct io_uring_cqe *io_get_cqring(struct io_ring_ctx *ctx)
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
+struct cqe_drop {
+	struct list_head list;
+	u64 user_data;
+	s32 res;
+};
+
+static void io_cqring_overflow_flush(struct io_ring_ctx *ctx)
+{
+	struct io_rings *rings = ctx->rings;
+	struct io_uring_cqe *cqe;
+	struct cqe_drop *drop;
+	unsigned long flags;
+
+	if (list_empty_careful(&ctx->cq_overflow_list))
+		return;
+	if (ctx->cached_cq_tail - READ_ONCE(rings->cq.head) ==
+	    rings->cq_ring_entries)
+		return;
+
+	spin_lock_irqsave(&ctx->completion_lock, flags);
+
+	while (!list_empty(&ctx->cq_overflow_list)) {
+		drop = list_first_entry(&ctx->cq_overflow_list, struct cqe_drop,
+						list);
+		cqe = io_get_cqring(ctx);
+		if (!cqe)
+			break;
+		list_del(&drop->list);
+		WRITE_ONCE(cqe->user_data, drop->user_data);
+		WRITE_ONCE(cqe->res, drop->res);
+		WRITE_ONCE(cqe->flags, 0);
+		kfree(drop);
+	}
+
+	io_commit_cqring(ctx);
+	spin_unlock_irqrestore(&ctx->completion_lock, flags);
+	io_cqring_ev_posted(ctx);
+}
+
+static void io_cqring_overflow(struct io_ring_ctx *ctx, u64 ki_user_data,
+			       long res)
+	__must_hold(&ctx->completion_lock)
+{
+	struct cqe_drop *drop;
+
+	if (!(ctx->flags & IORING_SETUP_CQ_NODROP)) {
+log_overflow:
+		WRITE_ONCE(ctx->rings->cq_overflow,
+				atomic_inc_return(&ctx->cached_cq_overflow));
+		return;
+	}
+
+	drop = kmalloc(sizeof(*drop), GFP_ATOMIC);
+	if (!drop)
+		goto log_overflow;
+
+	drop->user_data = ki_user_data;
+	drop->res = res;
+	list_add_tail(&drop->list, &ctx->cq_overflow_list);
+}
+
 static void io_cqring_fill_event(struct io_ring_ctx *ctx, u64 ki_user_data,
 				 long res)
 {
@@ -601,26 +674,15 @@ static void io_cqring_fill_event(struct io_ring_ctx *ctx, u64 ki_user_data,
 	 * the ring.
 	 */
 	cqe = io_get_cqring(ctx);
-	if (cqe) {
+	if (likely(cqe)) {
 		WRITE_ONCE(cqe->user_data, ki_user_data);
 		WRITE_ONCE(cqe->res, res);
 		WRITE_ONCE(cqe->flags, 0);
 	} else {
-		WRITE_ONCE(ctx->rings->cq_overflow,
-				atomic_inc_return(&ctx->cached_cq_overflow));
+		io_cqring_overflow(ctx, ki_user_data, res);
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
 static void io_cqring_add_event(struct io_ring_ctx *ctx, u64 user_data,
 				long res)
 {
@@ -859,8 +921,13 @@ static void io_put_req(struct io_kiocb *req, struct io_kiocb **nxtptr)
 	}
 }
 
-static unsigned io_cqring_events(struct io_rings *rings)
+static unsigned io_cqring_events(struct io_ring_ctx *ctx)
 {
+	struct io_rings *rings = ctx->rings;
+
+	if (ctx->flags & IORING_SETUP_CQ_NODROP)
+		io_cqring_overflow_flush(ctx);
+
 	/* See comment at the top of this file */
 	smp_rmb();
 	return READ_ONCE(rings->cq.tail) - READ_ONCE(rings->cq.head);
@@ -1016,7 +1083,7 @@ static int __io_iopoll_check(struct io_ring_ctx *ctx, unsigned *nr_events,
 		 * If we do, we can potentially be spinning for commands that
 		 * already triggered a CQE (eg in error).
 		 */
-		if (io_cqring_events(ctx->rings))
+		if (io_cqring_events(ctx))
 			break;
 
 		/*
@@ -2873,6 +2940,10 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 	int i, submitted = 0;
 	bool mm_fault = false;
 
+	if ((ctx->flags & IORING_SETUP_CQ_NODROP) &&
+	    !list_empty(&ctx->cq_overflow_list))
+		return -EBUSY;
+
 	if (nr > IO_PLUG_THRESHOLD) {
 		io_submit_state_start(&state, ctx, nr);
 		statep = &state;
@@ -2952,6 +3023,7 @@ static int io_sq_thread(void *data)
 	timeout = inflight = 0;
 	while (!kthread_should_park()) {
 		unsigned int to_submit;
+		int ret;
 
 		if (inflight) {
 			unsigned nr_events = 0;
@@ -3036,8 +3108,10 @@ static int io_sq_thread(void *data)
 		}
 
 		to_submit = min(to_submit, ctx->sq_entries);
-		inflight += io_submit_sqes(ctx, to_submit, NULL, -1, &cur_mm,
-					   true);
+		ret = io_submit_sqes(ctx, to_submit, NULL, -1, &cur_mm, true);
+		if (ret < 0)
+			continue;
+		inflight += ret;
 
 		/* Commit SQ ring head once we've consumed all SQEs */
 		io_commit_sqring(ctx);
@@ -3070,7 +3144,7 @@ static inline bool io_should_wake(struct io_wait_queue *iowq)
 	 * started waiting. For timeouts, we always want to return to userspace,
 	 * regardless of event count.
 	 */
-	return io_cqring_events(ctx->rings) >= iowq->to_wait ||
+	return io_cqring_events(ctx) >= iowq->to_wait ||
 			atomic_read(&ctx->cq_timeouts) != iowq->nr_timeouts;
 }
 
@@ -3105,7 +3179,7 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events,
 	struct io_rings *rings = ctx->rings;
 	int ret = 0;
 
-	if (io_cqring_events(rings) >= min_events)
+	if (io_cqring_events(ctx) >= min_events)
 		return 0;
 
 	if (sig) {
@@ -4406,7 +4480,8 @@ static long io_uring_setup(u32 entries, struct io_uring_params __user *params)
 	}
 
 	if (p.flags & ~(IORING_SETUP_IOPOLL | IORING_SETUP_SQPOLL |
-			IORING_SETUP_SQ_AFF | IORING_SETUP_CQSIZE))
+			IORING_SETUP_SQ_AFF | IORING_SETUP_CQSIZE |
+			IORING_SETUP_CQ_NODROP))
 		return -EINVAL;
 
 	ret = io_uring_create(entries, &p);
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index f1a118b01d18..3d8517eb376e 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -56,6 +56,7 @@ struct io_uring_sqe {
 #define IORING_SETUP_SQPOLL	(1U << 1)	/* SQ poll thread */
 #define IORING_SETUP_SQ_AFF	(1U << 2)	/* sq_thread_cpu is valid */
 #define IORING_SETUP_CQSIZE	(1U << 3)	/* app defines CQ size */
+#define IORING_SETUP_CQ_NODROP	(1U << 4)	/* no CQ drops */
 
 #define IORING_OP_NOP		0
 #define IORING_OP_READV		1

-- 
Jens Axboe

