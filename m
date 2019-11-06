Return-Path: <SRS0=PUae=Y6=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D26FC6194
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 23:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B28206C3
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 23:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vSbxyIUB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfKFXxR (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 6 Nov 2019 18:53:17 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39697 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbfKFXxR (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 6 Nov 2019 18:53:17 -0500
Received: by mail-pl1-f194.google.com with SMTP id o9so26768plk.6
        for <io-uring@vger.kernel.org>; Wed, 06 Nov 2019 15:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=unxMWJqvjQ5xxxzmnSephyWmdkVRzY16oe7Dagd9SFs=;
        b=vSbxyIUBQe2XLGKt6jNeRQW4mH8jqc7HjrqV1gaX84i8FmWcq6SDY95NY5IMHZ1ueT
         vBM+T7eIyEengof8gEYttkPqmtw+pMF397XApXsPnADdbYTauMXCa+U2TzYSKZkCIpjc
         UrHQ734Ujaphj+tnG1WTSPqZGckncJZFcBBIb8QBA1ZnQiq8HFoHiroOmUMc2IZ/8SEE
         UrImQjhe/fBYNd+W8Zr35G5iPzESx+XVtk4ufiOYs5x82E1ch6rjNcL4DPHxtv9OLpn2
         RSm9PU72QM3mjIElm7AVKGPn8leFy9syqVeb3qR/Jx1aj+0Qml/uymkA2ZgGKdE4YJVl
         KCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=unxMWJqvjQ5xxxzmnSephyWmdkVRzY16oe7Dagd9SFs=;
        b=Nr1AWaSvo0KOmF4XZ7ONLn1bzi93QdZy8fzQ2GsFy8T7erMbeblc8Bx9kidvu3rveW
         KoCzhTkVmybrbdsRr/pHDZ1eDGeEUoVPYWlK6n1gf6pBYGxgqpT5Vsuz5hJnochY/1PH
         ddXENaUz+dnUlbusNV8FPxj5cMk+2W857MbAUieyTJGD7hHNW/WOvsom7GeSB65XfPf4
         ygDm9Fqnsl2RXYDW1lq7MziRNc86EfyB9PG1G7soUUM70+HLjfhef0X9m3oe8S+3ZuCh
         jXRTSmCjZxoIBlfXhaihmuLzd29n9BSQPD2a5kHzyPNwfFRWGFlwZeAbVjuZ4MbRfUpl
         W4eQ==
X-Gm-Message-State: APjAAAXBHk7r0a+ATMAPi++/ys9nQ73bCpy8a3guYkglbC5aFQuMjfv1
        p+Vf07zW+ZVk7amEV0sUNhpEFNIp578=
X-Google-Smtp-Source: APXvYqykNzw2GLe9JHAm6yXTgBQD3PgQ5rZ6OpxZdV/41GgSCYgz9yhNKYq6ubcaIiukxxf8jVFPjQ==
X-Received: by 2002:a17:902:9687:: with SMTP id n7mr376935plp.166.1573084396333;
        Wed, 06 Nov 2019 15:53:16 -0800 (PST)
Received: from x1.localdomain ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id x125sm109137pfb.93.2019.11.06.15.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 15:53:15 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-block@vger.kernel.org, asml.silence@gmail.com,
        jannh@google.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/3] io_uring: pass in io_kiocb to fill/add CQ handlers
Date:   Wed,  6 Nov 2019 16:53:06 -0700
Message-Id: <20191106235307.32196-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191106235307.32196-1-axboe@kernel.dk>
References: <20191106235307.32196-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

This is in preparation for handling CQ ring overflow a bit smarter. We
should not have any functional changes in this patch. Most of the changes
are fairly straight forward, the only ones that stick out a bit are the
ones that change:

__io_free_req()

to a double io_put_req(). If the request hasn't been submitted yet, we
know it's safe to simply ignore references and free it. But let's clean
these up too, as later patches will depend on the caller doing the right
thing if the completion logging grabs a reference to the request.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 90 +++++++++++++++++++++++++--------------------------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 36ca7bc38ebf..fb621a564dcf 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -369,8 +369,7 @@ struct io_submit_state {
 };
 
 static void io_wq_submit_work(struct io_wq_work **workptr);
-static void io_cqring_fill_event(struct io_ring_ctx *ctx, u64 ki_user_data,
-				 long res);
+static void io_cqring_fill_event(struct io_kiocb *req, long res);
 static void __io_free_req(struct io_kiocb *req);
 static void io_put_req(struct io_kiocb *req, struct io_kiocb **nxtptr);
 
@@ -535,8 +534,8 @@ static void io_kill_timeout(struct io_kiocb *req)
 	if (ret != -1) {
 		atomic_inc(&req->ctx->cq_timeouts);
 		list_del_init(&req->list);
-		io_cqring_fill_event(req->ctx, req->user_data, 0);
-		__io_free_req(req);
+		io_cqring_fill_event(req, 0);
+		io_put_req(req, NULL);
 	}
 }
 
@@ -588,12 +587,12 @@ static struct io_uring_cqe *io_get_cqring(struct io_ring_ctx *ctx)
 	return &rings->cqes[tail & ctx->cq_mask];
 }
 
-static void io_cqring_fill_event(struct io_ring_ctx *ctx, u64 ki_user_data,
-				 long res)
+static void io_cqring_fill_event(struct io_kiocb *req, long res)
 {
+	struct io_ring_ctx *ctx = req->ctx;
 	struct io_uring_cqe *cqe;
 
-	trace_io_uring_complete(ctx, ki_user_data, res);
+	trace_io_uring_complete(ctx, req->user_data, res);
 
 	/*
 	 * If we can't get a cq entry, userspace overflowed the
@@ -602,7 +601,7 @@ static void io_cqring_fill_event(struct io_ring_ctx *ctx, u64 ki_user_data,
 	 */
 	cqe = io_get_cqring(ctx);
 	if (cqe) {
-		WRITE_ONCE(cqe->user_data, ki_user_data);
+		WRITE_ONCE(cqe->user_data, req->user_data);
 		WRITE_ONCE(cqe->res, res);
 		WRITE_ONCE(cqe->flags, 0);
 	} else {
@@ -621,13 +620,13 @@ static void io_cqring_ev_posted(struct io_ring_ctx *ctx)
 		eventfd_signal(ctx->cq_ev_fd, 1);
 }
 
-static void io_cqring_add_event(struct io_ring_ctx *ctx, u64 user_data,
-				long res)
+static void io_cqring_add_event(struct io_kiocb *req, long res)
 {
+	struct io_ring_ctx *ctx = req->ctx;
 	unsigned long flags;
 
 	spin_lock_irqsave(&ctx->completion_lock, flags);
-	io_cqring_fill_event(ctx, user_data, res);
+	io_cqring_fill_event(req, res);
 	io_commit_cqring(ctx);
 	spin_unlock_irqrestore(&ctx->completion_lock, flags);
 
@@ -721,10 +720,10 @@ static void io_link_cancel_timeout(struct io_ring_ctx *ctx,
 
 	ret = hrtimer_try_to_cancel(&req->timeout.timer);
 	if (ret != -1) {
-		io_cqring_fill_event(ctx, req->user_data, -ECANCELED);
+		io_cqring_fill_event(req, -ECANCELED);
 		io_commit_cqring(ctx);
 		req->flags &= ~REQ_F_LINK;
-		__io_free_req(req);
+		io_put_req(req, NULL);
 	}
 }
 
@@ -804,8 +803,10 @@ static void io_fail_links(struct io_kiocb *req)
 		    link->submit.sqe->opcode == IORING_OP_LINK_TIMEOUT) {
 			io_link_cancel_timeout(ctx, link);
 		} else {
-			io_cqring_fill_event(ctx, link->user_data, -ECANCELED);
-			__io_free_req(link);
+			io_cqring_fill_event(link, -ECANCELED);
+			/* drop both submit and complete references */
+			io_put_req(link, NULL);
+			io_put_req(link, NULL);
 		}
 	}
 
@@ -891,7 +892,7 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
 		req = list_first_entry(done, struct io_kiocb, list);
 		list_del(&req->list);
 
-		io_cqring_fill_event(ctx, req->user_data, req->result);
+		io_cqring_fill_event(req, req->result);
 		(*nr_events)++;
 
 		if (refcount_dec_and_test(&req->refs)) {
@@ -1087,7 +1088,7 @@ static void io_complete_rw_common(struct kiocb *kiocb, long res)
 
 	if ((req->flags & REQ_F_LINK) && res != req->result)
 		req->flags |= REQ_F_FAIL_LINK;
-	io_cqring_add_event(req->ctx, req->user_data, res);
+	io_cqring_add_event(req, res);
 }
 
 static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
@@ -1588,15 +1589,14 @@ static int io_write(struct io_kiocb *req, struct io_kiocb **nxt,
 /*
  * IORING_OP_NOP just posts a completion event, nothing else.
  */
-static int io_nop(struct io_kiocb *req, u64 user_data)
+static int io_nop(struct io_kiocb *req)
 {
 	struct io_ring_ctx *ctx = req->ctx;
-	long err = 0;
 
 	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
 		return -EINVAL;
 
-	io_cqring_add_event(ctx, user_data, err);
+	io_cqring_add_event(req, 0);
 	io_put_req(req, NULL);
 	return 0;
 }
@@ -1643,7 +1643,7 @@ static int io_fsync(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 
 	if (ret < 0 && (req->flags & REQ_F_LINK))
 		req->flags |= REQ_F_FAIL_LINK;
-	io_cqring_add_event(req->ctx, sqe->user_data, ret);
+	io_cqring_add_event(req, ret);
 	io_put_req(req, nxt);
 	return 0;
 }
@@ -1690,7 +1690,7 @@ static int io_sync_file_range(struct io_kiocb *req,
 
 	if (ret < 0 && (req->flags & REQ_F_LINK))
 		req->flags |= REQ_F_FAIL_LINK;
-	io_cqring_add_event(req->ctx, sqe->user_data, ret);
+	io_cqring_add_event(req, ret);
 	io_put_req(req, nxt);
 	return 0;
 }
@@ -1726,7 +1726,7 @@ static int io_send_recvmsg(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 			return ret;
 	}
 
-	io_cqring_add_event(req->ctx, sqe->user_data, ret);
+	io_cqring_add_event(req, ret);
 	if (ret < 0 && (req->flags & REQ_F_LINK))
 		req->flags |= REQ_F_FAIL_LINK;
 	io_put_req(req, nxt);
@@ -1782,7 +1782,7 @@ static int io_accept(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	}
 	if (ret < 0 && (req->flags & REQ_F_LINK))
 		req->flags |= REQ_F_FAIL_LINK;
-	io_cqring_add_event(req->ctx, sqe->user_data, ret);
+	io_cqring_add_event(req, ret);
 	io_put_req(req, nxt);
 	return 0;
 #else
@@ -1843,7 +1843,7 @@ static int io_poll_remove(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	}
 	spin_unlock_irq(&ctx->completion_lock);
 
-	io_cqring_add_event(req->ctx, sqe->user_data, ret);
+	io_cqring_add_event(req, ret);
 	if (ret < 0 && (req->flags & REQ_F_LINK))
 		req->flags |= REQ_F_FAIL_LINK;
 	io_put_req(req, NULL);
@@ -1854,7 +1854,7 @@ static void io_poll_complete(struct io_ring_ctx *ctx, struct io_kiocb *req,
 			     __poll_t mask)
 {
 	req->poll.done = true;
-	io_cqring_fill_event(ctx, req->user_data, mangle_poll(mask));
+	io_cqring_fill_event(req, mangle_poll(mask));
 	io_commit_cqring(ctx);
 }
 
@@ -2048,7 +2048,7 @@ static enum hrtimer_restart io_timeout_fn(struct hrtimer *timer)
 		list_del_init(&req->list);
 	}
 
-	io_cqring_fill_event(ctx, req->user_data, -ETIME);
+	io_cqring_fill_event(req, -ETIME);
 	io_commit_cqring(ctx);
 	spin_unlock_irqrestore(&ctx->completion_lock, flags);
 
@@ -2092,7 +2092,7 @@ static int io_timeout_remove(struct io_kiocb *req,
 	/* didn't find timeout */
 	if (ret) {
 fill_ev:
-		io_cqring_fill_event(ctx, req->user_data, ret);
+		io_cqring_fill_event(req, ret);
 		io_commit_cqring(ctx);
 		spin_unlock_irq(&ctx->completion_lock);
 		io_cqring_ev_posted(ctx);
@@ -2108,8 +2108,8 @@ static int io_timeout_remove(struct io_kiocb *req,
 		goto fill_ev;
 	}
 
-	io_cqring_fill_event(ctx, req->user_data, 0);
-	io_cqring_fill_event(ctx, treq->user_data, -ECANCELED);
+	io_cqring_fill_event(req, 0);
+	io_cqring_fill_event(treq, -ECANCELED);
 	io_commit_cqring(ctx);
 	spin_unlock_irq(&ctx->completion_lock);
 	io_cqring_ev_posted(ctx);
@@ -2249,7 +2249,7 @@ static int io_async_cancel(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 
 	if (ret < 0 && (req->flags & REQ_F_LINK))
 		req->flags |= REQ_F_FAIL_LINK;
-	io_cqring_add_event(req->ctx, sqe->user_data, ret);
+	io_cqring_add_event(req, ret);
 	io_put_req(req, nxt);
 	return 0;
 }
@@ -2288,12 +2288,10 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	int ret, opcode;
 	struct sqe_submit *s = &req->submit;
 
-	req->user_data = READ_ONCE(s->sqe->user_data);
-
 	opcode = READ_ONCE(s->sqe->opcode);
 	switch (opcode) {
 	case IORING_OP_NOP:
-		ret = io_nop(req, req->user_data);
+		ret = io_nop(req);
 		break;
 	case IORING_OP_READV:
 		if (unlikely(s->sqe->buf_index))
@@ -2402,7 +2400,7 @@ static void io_wq_submit_work(struct io_wq_work **workptr)
 	if (ret) {
 		if (req->flags & REQ_F_LINK)
 			req->flags |= REQ_F_FAIL_LINK;
-		io_cqring_add_event(ctx, sqe->user_data, ret);
+		io_cqring_add_event(req, ret);
 		io_put_req(req, NULL);
 	}
 
@@ -2530,7 +2528,7 @@ static enum hrtimer_restart io_link_timeout_fn(struct hrtimer *timer)
 	if (prev)
 		ret = io_async_cancel_one(ctx, (void *) prev->user_data);
 
-	io_cqring_add_event(ctx, req->user_data, ret);
+	io_cqring_add_event(req, ret);
 	io_put_req(req, NULL);
 	return HRTIMER_NORESTART;
 }
@@ -2573,7 +2571,7 @@ static int io_queue_linked_timeout(struct io_kiocb *req, struct io_kiocb *nxt)
 		 * failed by the regular submission path.
 		 */
 		list_del(&nxt->list);
-		io_cqring_fill_event(ctx, nxt->user_data, ret);
+		io_cqring_fill_event(nxt, ret);
 		trace_io_uring_fail_link(req, nxt);
 		io_commit_cqring(ctx);
 		io_put_req(nxt, NULL);
@@ -2646,7 +2644,7 @@ static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req)
 
 	/* and drop final reference, if we failed */
 	if (ret) {
-		io_cqring_add_event(ctx, req->user_data, ret);
+		io_cqring_add_event(req, ret);
 		if (req->flags & REQ_F_LINK)
 			req->flags |= REQ_F_FAIL_LINK;
 		io_put_req(req, NULL);
@@ -2662,7 +2660,7 @@ static int io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req)
 	ret = io_req_defer(ctx, req);
 	if (ret) {
 		if (ret != -EIOCBQUEUED) {
-			io_cqring_add_event(ctx, req->submit.sqe->user_data, ret);
+			io_cqring_add_event(req, ret);
 			io_free_req(req, NULL);
 		}
 		return 0;
@@ -2689,8 +2687,8 @@ static int io_queue_link_head(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	ret = io_req_defer(ctx, req);
 	if (ret) {
 		if (ret != -EIOCBQUEUED) {
-			io_cqring_add_event(ctx, req->submit.sqe->user_data, ret);
-			io_free_req(req, NULL);
+			io_cqring_add_event(req, ret);
+			io_put_req(req, NULL);
 			__io_free_req(shadow);
 			return 0;
 		}
@@ -2723,6 +2721,8 @@ static void io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	struct sqe_submit *s = &req->submit;
 	int ret;
 
+	req->user_data = s->sqe->user_data;
+
 	/* enforce forwards compatibility on users */
 	if (unlikely(s->sqe->flags & ~SQE_VALID_FLAGS)) {
 		ret = -EINVAL;
@@ -2732,13 +2732,13 @@ static void io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	ret = io_req_set_file(ctx, state, req);
 	if (unlikely(ret)) {
 err_req:
-		io_cqring_add_event(ctx, s->sqe->user_data, ret);
-		io_free_req(req, NULL);
+		io_cqring_add_event(req, ret);
+		/* drop both submit and complete references */
+		io_put_req(req, NULL);
+		io_put_req(req, NULL);
 		return;
 	}
 
-	req->user_data = s->sqe->user_data;
-
 	/*
 	 * If we already have a head request, queue this one for async
 	 * submittal once the head completes. If we don't have a head but
-- 
2.24.0

