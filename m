Return-Path: <SRS0=PUae=Y6=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761FBFC6196
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 23:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C1C0206C3
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 23:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="rHfj6vU1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbfKFXxV (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 6 Nov 2019 18:53:21 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40021 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbfKFXxU (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 6 Nov 2019 18:53:20 -0500
Received: by mail-pl1-f196.google.com with SMTP id e3so22729plt.7
        for <io-uring@vger.kernel.org>; Wed, 06 Nov 2019 15:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2e+qT25tBhRlrVPpJqJfTOuLTYrhScPquGaSigXDLfw=;
        b=rHfj6vU13o4LxL/o0U3/lKY0LcIinIi5kT5UYZbZp2/VHMC4zHkAHmwYi5DgS3xp5m
         QcExg5X+PVNQBH4czR4M0vfKRhOsijIgo/BgVmHadmfDvDUTvZFJ6hx3vDAeifd+G+st
         i9Yjo7MtmRCa/EZZInYZDzTHjIlKtKnZ3y1L259HXEvRaDeUmF/BrqV/bSbjSzjI6jH5
         nzeM+XOLyF22j8eWPDbDGp1j23MO9CZFNqEG9D1PXz8m1xWbG8YmruI/qfhook+4/5iQ
         GRzQbYVfU7r91j7UIIm2aTZrpUU2Im4NAqsRx8BpBMKwD7H9Nw7D7Ji2uZLD2oBb+5uY
         sYsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2e+qT25tBhRlrVPpJqJfTOuLTYrhScPquGaSigXDLfw=;
        b=ivPNiLRDpZCmxle+/hwnLLj/udFBjIr2mOHiJ71C41/XWH5FzkV2QvpUh8scxzELnD
         eNVGpKXE9LuvkDftfY56kVwQTuYz1+vMg/gP/ri6cyCH4Qdbb3wHAEzT0scpCThpJlli
         bIJKKWpt0xNY7JbXD/lDb4lNreS5TxD+TPGd97alp4U6HXRX5cG0YddYkOuDqZO2EpoQ
         fD6zL419ojPHivEmbBD+NDsIYoF7biGj9Ozro+w53ZOuBxTTfe+N/8SPUOK2JOiw3P32
         V7q2dsA7UGvPil6Xb5k2fYXILsDxfRKAkyW/Rp5XDGCorAZKEmi2EhlziQ+xeTZLfs94
         wOsg==
X-Gm-Message-State: APjAAAW9H2eOu3y96Ue1cHjDLDA+etECuOqTSGXR3W8wIHfJ3d1hahK2
        1DHRWVRYOpuRMKbKtDpsaJvr7tS72Z8=
X-Google-Smtp-Source: APXvYqyC0FegZUAz0VTFVibV7SWs5BwULfKMORzt7skHw3au1zKw5CGTw9WE9fxgFmUoLv4/OK+Sfg==
X-Received: by 2002:a17:902:8a85:: with SMTP id p5mr365807plo.150.1573084398154;
        Wed, 06 Nov 2019 15:53:18 -0800 (PST)
Received: from x1.localdomain ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id x125sm109137pfb.93.2019.11.06.15.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 15:53:17 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-block@vger.kernel.org, asml.silence@gmail.com,
        jannh@google.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/3] io_uring: add support for backlogged CQ ring
Date:   Wed,  6 Nov 2019 16:53:07 -0700
Message-Id: <20191106235307.32196-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191106235307.32196-1-axboe@kernel.dk>
References: <20191106235307.32196-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
simply stores a backlog of completions that we weren't able to put into
the CQ ring. To prevent the backlog from growing indefinitely, if the
backlog is non-empty, we apply back pressure on IO submissions. Any
attempt to submit new IO with a non-empty backlog will get an -EBUSY
return from the kernel. This is a signal to the application that it has
backlogged CQ events, and that it must reap those before being allowed
to submit more IO.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c                 | 103 ++++++++++++++++++++++++++++------
 include/uapi/linux/io_uring.h |   1 +
 2 files changed, 87 insertions(+), 17 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index fb621a564dcf..22373b7b3db0 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -207,6 +207,7 @@ struct io_ring_ctx {
 
 		struct list_head	defer_list;
 		struct list_head	timeout_list;
+		struct list_head	cq_overflow_list;
 
 		wait_queue_head_t	inflight_wait;
 	} ____cacheline_aligned_in_smp;
@@ -413,6 +414,7 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 
 	ctx->flags = p->flags;
 	init_waitqueue_head(&ctx->cq_wait);
+	INIT_LIST_HEAD(&ctx->cq_overflow_list);
 	init_completion(&ctx->ctx_done);
 	init_completion(&ctx->sqo_thread_started);
 	mutex_init(&ctx->uring_lock);
@@ -587,6 +589,72 @@ static struct io_uring_cqe *io_get_cqring(struct io_ring_ctx *ctx)
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
+	if (list_empty_careful(&ctx->cq_overflow_list))
+		return;
+	if (ctx->cached_cq_tail - READ_ONCE(rings->cq.head) ==
+	    rings->cq_ring_entries)
+		return;
+
+	spin_lock_irqsave(&ctx->completion_lock, flags);
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
+static void io_cqring_overflow(struct io_ring_ctx *ctx, struct io_kiocb *req,
+			       long res)
+	__must_hold(&ctx->completion_lock)
+{
+	if (!(ctx->flags & IORING_SETUP_CQ_NODROP)) {
+		WRITE_ONCE(ctx->rings->cq_overflow,
+				atomic_inc_return(&ctx->cached_cq_overflow));
+	} else {
+		refcount_inc(&req->refs);
+		req->result = res;
+		list_add_tail(&req->list, &ctx->cq_overflow_list);
+	}
+}
+
 static void io_cqring_fill_event(struct io_kiocb *req, long res)
 {
 	struct io_ring_ctx *ctx = req->ctx;
@@ -600,26 +668,15 @@ static void io_cqring_fill_event(struct io_kiocb *req, long res)
 	 * the ring.
 	 */
 	cqe = io_get_cqring(ctx);
-	if (cqe) {
+	if (likely(cqe)) {
 		WRITE_ONCE(cqe->user_data, req->user_data);
 		WRITE_ONCE(cqe->res, res);
 		WRITE_ONCE(cqe->flags, 0);
 	} else {
-		WRITE_ONCE(ctx->rings->cq_overflow,
-				atomic_inc_return(&ctx->cached_cq_overflow));
+		io_cqring_overflow(ctx, req, res);
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
@@ -864,6 +921,9 @@ static unsigned io_cqring_events(struct io_ring_ctx *ctx)
 {
 	struct io_rings *rings = ctx->rings;
 
+	if (ctx->flags & IORING_SETUP_CQ_NODROP)
+		io_cqring_overflow_flush(ctx, false);
+
 	/* See comment at the top of this file */
 	smp_rmb();
 	return READ_ONCE(rings->cq.tail) - READ_ONCE(rings->cq.head);
@@ -2863,6 +2923,10 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 	int i, submitted = 0;
 	bool mm_fault = false;
 
+	if ((ctx->flags & IORING_SETUP_CQ_NODROP) &&
+	    !list_empty(&ctx->cq_overflow_list))
+		return -EBUSY;
+
 	if (nr > IO_PLUG_THRESHOLD) {
 		io_submit_state_start(&state, ctx, nr);
 		statep = &state;
@@ -2951,6 +3015,7 @@ static int io_sq_thread(void *data)
 	timeout = inflight = 0;
 	while (!kthread_should_park()) {
 		unsigned int to_submit;
+		int ret;
 
 		if (inflight) {
 			unsigned nr_events = 0;
@@ -3035,8 +3100,9 @@ static int io_sq_thread(void *data)
 		}
 
 		to_submit = min(to_submit, ctx->sq_entries);
-		inflight += io_submit_sqes(ctx, to_submit, NULL, -1, &cur_mm,
-					   true);
+		ret = io_submit_sqes(ctx, to_submit, NULL, -1, &cur_mm, true);
+		if (ret > 0)
+			inflight += ret;
 	}
 
 	set_fs(old_fs);
@@ -4100,8 +4166,10 @@ static int io_uring_flush(struct file *file, void *data)
 	struct io_ring_ctx *ctx = file->private_data;
 
 	io_uring_cancel_files(ctx, data);
-	if (fatal_signal_pending(current) || (current->flags & PF_EXITING))
+	if (fatal_signal_pending(current) || (current->flags & PF_EXITING)) {
+		io_cqring_overflow_flush(ctx, true);
 		io_wq_cancel_all(ctx->io_wq);
+	}
 	return 0;
 }
 
@@ -4402,7 +4470,8 @@ static long io_uring_setup(u32 entries, struct io_uring_params __user *params)
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
2.24.0

