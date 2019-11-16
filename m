Return-Path: <SRS0=SU/R=ZI=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFD5C432C3
	for <io-uring@archiver.kernel.org>; Sat, 16 Nov 2019 01:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B492073A
	for <io-uring@archiver.kernel.org>; Sat, 16 Nov 2019 01:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="glkLqeI7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfKPBxf (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 15 Nov 2019 20:53:35 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33222 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbfKPBxf (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 15 Nov 2019 20:53:35 -0500
Received: by mail-pf1-f194.google.com with SMTP id c184so7512706pfb.0
        for <io-uring@vger.kernel.org>; Fri, 15 Nov 2019 17:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Te5v5lNCECfxBcYinaLO5Aj9rVGMLXVeZK8E3NI4t34=;
        b=glkLqeI7b804BMnpQ+FQqzRnx/Ov/834z0sDKn6kpXTcsrSjnQ5fQvV011X0Cd6DSJ
         Ikn3ViPpY2pz6xFHA5LUWwUBRZxUEnoENrxflKQdEhV8ELyBO1wmvmerpKcnFq4TszFT
         GAN30F/c5DSKxkYShnB/vFze8Pu+Ao16UxFbBoY/tAx2LPC04acs8nYkqf6fUsCGdlZw
         LduQxJcbc00XKeYo+mt/6UC9/+N9EvFohUKGpmyC9OZEGTz9mWhmRrMrLaHYQs0FJWOt
         sOtPpB8ZDqmt7FJfXAB129Vxl4lsb4dfxEoL5ZaOi5+pMwGAxsgVbyw5ktHEASYvYNl5
         rQmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Te5v5lNCECfxBcYinaLO5Aj9rVGMLXVeZK8E3NI4t34=;
        b=HQz3LRbN2KtvteqC2rHIK8r3Nf1w2Ps+n4FrTC0Gxg+JbODVtZF6g7X4w0H5B3Qlif
         VfHnXFE9U1gdh5CKZkSCGXnXry9QFSCU4P0eSSMvLFRqGp/veZiOEYUJeHPrjFgbQf/2
         4zjXNQCuPdVjtqYvE6OuAA6BBY+Ne0CP/PqoJGaAjqMTeBapVud4XYBBc7qdV/K5rgyV
         d2JhgfRTeDAbr94VVMUYLNJ+m63RARyr7NfQld40/r14fO5lNR7tx69BWMqpLSqT7qqB
         i17Kv7Uv/vhuBI2CySNe6nnlkEW6udHgNCmRTBJVOKVCfIQtZoo6mXUm/d2UuOOzYgH6
         0a9A==
X-Gm-Message-State: APjAAAWK0/ejFm7WaItKAW94UzefsGfa++6cZieYEpD9W+5JbAbCFhS4
        /OaL44robj0xy/uB6tWMnc5C+bLT6FA=
X-Google-Smtp-Source: APXvYqwGGZougivESYJqw0m95IHCbaUIObW2G++NI2l2oyjLI80b2CRUZNgbpXW4aTfUFUQQFiRTmQ==
X-Received: by 2002:a62:7a8a:: with SMTP id v132mr21070949pfc.228.1573869212813;
        Fri, 15 Nov 2019 17:53:32 -0800 (PST)
Received: from x1.localdomain ([2620:10d:c090:180::be7a])
        by smtp.gmail.com with ESMTPSA id i123sm16565458pfe.145.2019.11.15.17.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 17:53:32 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     asml.silence@gmail.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6/8] io_uring: make req->timeout be dynamically allocated
Date:   Fri, 15 Nov 2019 18:53:12 -0700
Message-Id: <20191116015314.24276-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191116015314.24276-1-axboe@kernel.dk>
References: <20191116015314.24276-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

There are a few reasons for this:

- As a prep to improving the linked timeout logic
- io_timeout is the biggest member in the io_kiocb opcode union

This also enables a few cleanups, like unifying the timer setup between
IORING_OP_TIMEOUT and IORING_OP_LINK_TIMEOUT, and not needing multiple
arguments to the link/prep helpers.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 129 +++++++++++++++++++++++++++-----------------------
 1 file changed, 70 insertions(+), 59 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 3f4d6641bea2..883ac9b01083 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -301,9 +301,16 @@ struct io_poll_iocb {
 	struct wait_queue_entry		wait;
 };
 
+struct io_timeout_data {
+	struct io_kiocb			*req;
+	struct hrtimer			timer;
+	struct timespec64		ts;
+	enum hrtimer_mode		mode;
+};
+
 struct io_timeout {
 	struct file			*file;
-	struct hrtimer			timer;
+	struct io_timeout_data		*data;
 };
 
 /*
@@ -568,7 +575,7 @@ static void io_kill_timeout(struct io_kiocb *req)
 {
 	int ret;
 
-	ret = hrtimer_try_to_cancel(&req->timeout.timer);
+	ret = hrtimer_try_to_cancel(&req->timeout.data->timer);
 	if (ret != -1) {
 		atomic_inc(&req->ctx->cq_timeouts);
 		list_del_init(&req->list);
@@ -823,6 +830,8 @@ static void __io_free_req(struct io_kiocb *req)
 			wake_up(&ctx->inflight_wait);
 		spin_unlock_irqrestore(&ctx->inflight_lock, flags);
 	}
+	if (req->flags & REQ_F_TIMEOUT)
+		kfree(req->timeout.data);
 	percpu_ref_put(&ctx->refs);
 	if (likely(!io_is_fallback_req(req)))
 		kmem_cache_free(req_cachep, req);
@@ -835,7 +844,7 @@ static bool io_link_cancel_timeout(struct io_kiocb *req)
 	struct io_ring_ctx *ctx = req->ctx;
 	int ret;
 
-	ret = hrtimer_try_to_cancel(&req->timeout.timer);
+	ret = hrtimer_try_to_cancel(&req->timeout.data->timer);
 	if (ret != -1) {
 		io_cqring_fill_event(req, -ECANCELED);
 		io_commit_cqring(ctx);
@@ -2230,12 +2239,12 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 
 static enum hrtimer_restart io_timeout_fn(struct hrtimer *timer)
 {
-	struct io_ring_ctx *ctx;
-	struct io_kiocb *req;
+	struct io_timeout_data *data = container_of(timer,
+						struct io_timeout_data, timer);
+	struct io_kiocb *req = data->req;
+	struct io_ring_ctx *ctx = req->ctx;
 	unsigned long flags;
 
-	req = container_of(timer, struct io_kiocb, timeout.timer);
-	ctx = req->ctx;
 	atomic_inc(&ctx->cq_timeouts);
 
 	spin_lock_irqsave(&ctx->completion_lock, flags);
@@ -2285,7 +2294,7 @@ static int io_timeout_cancel(struct io_ring_ctx *ctx, __u64 user_data)
 	if (ret == -ENOENT)
 		return ret;
 
-	ret = hrtimer_try_to_cancel(&req->timeout.timer);
+	ret = hrtimer_try_to_cancel(&req->timeout.data->timer);
 	if (ret == -1)
 		return -EALREADY;
 
@@ -2325,33 +2334,54 @@ static int io_timeout_remove(struct io_kiocb *req,
 	return 0;
 }
 
-static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
+static int io_timeout_setup(struct io_kiocb *req)
 {
-	unsigned count;
-	struct io_ring_ctx *ctx = req->ctx;
-	struct list_head *entry;
-	enum hrtimer_mode mode;
-	struct timespec64 ts;
-	unsigned span = 0;
+	const struct io_uring_sqe *sqe = req->submit.sqe;
+	struct io_timeout_data *data;
 	unsigned flags;
 
-	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
+	if (unlikely(req->ctx->flags & IORING_SETUP_IOPOLL))
 		return -EINVAL;
-	if (sqe->flags || sqe->ioprio || sqe->buf_index || sqe->len != 1)
+	if (sqe->ioprio || sqe->buf_index || sqe->len != 1)
 		return -EINVAL;
 	flags = READ_ONCE(sqe->timeout_flags);
 	if (flags & ~IORING_TIMEOUT_ABS)
 		return -EINVAL;
 
-	if (get_timespec64(&ts, u64_to_user_ptr(sqe->addr)))
+	data = kzalloc(sizeof(struct io_timeout_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	data->req = req;
+	req->timeout.data = data;
+	req->flags |= REQ_F_TIMEOUT;
+
+	if (get_timespec64(&data->ts, u64_to_user_ptr(sqe->addr)))
 		return -EFAULT;
 
 	if (flags & IORING_TIMEOUT_ABS)
-		mode = HRTIMER_MODE_ABS;
+		data->mode = HRTIMER_MODE_ABS;
 	else
-		mode = HRTIMER_MODE_REL;
+		data->mode = HRTIMER_MODE_REL;
+
+	hrtimer_init(&data->timer, CLOCK_MONOTONIC, data->mode);
+	return 0;
+}
+
+static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
+{
+	unsigned count;
+	struct io_ring_ctx *ctx = req->ctx;
+	struct io_timeout_data *data;
+	struct list_head *entry;
+	unsigned span = 0;
+	int ret;
 
-	hrtimer_init(&req->timeout.timer, CLOCK_MONOTONIC, mode);
+	ret = io_timeout_setup(req);
+	/* common setup allows flags (like links) set, we don't */
+	if (!ret && sqe->flags)
+		ret = -EINVAL;
+	if (ret)
+		return ret;
 
 	/*
 	 * sqe->off holds how many events that need to occur for this
@@ -2364,7 +2394,6 @@ static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	req->sequence = ctx->cached_sq_head + count - 1;
 	/* reuse it to store the count */
 	req->submit.sequence = count;
-	req->flags |= REQ_F_TIMEOUT;
 
 	/*
 	 * Insertion sort, ensuring the first entry in the list is always
@@ -2403,8 +2432,9 @@ static int io_timeout(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	}
 	req->sequence -= span;
 	list_add(&req->list, entry);
-	req->timeout.timer.function = io_timeout_fn;
-	hrtimer_start(&req->timeout.timer, timespec64_to_ktime(ts), mode);
+	data = req->timeout.data;
+	data->timer.function = io_timeout_fn;
+	hrtimer_start(&data->timer, timespec64_to_ktime(data->ts), data->mode);
 	spin_unlock_irq(&ctx->completion_lock);
 	return 0;
 }
@@ -2739,8 +2769,9 @@ static int io_grab_files(struct io_kiocb *req)
 
 static enum hrtimer_restart io_link_timeout_fn(struct hrtimer *timer)
 {
-	struct io_kiocb *req = container_of(timer, struct io_kiocb,
-						timeout.timer);
+	struct io_timeout_data *data = container_of(timer,
+						struct io_timeout_data, timer);
+	struct io_kiocb *req = data->req;
 	struct io_ring_ctx *ctx = req->ctx;
 	struct io_kiocb *prev = NULL;
 	unsigned long flags;
@@ -2771,9 +2802,9 @@ static enum hrtimer_restart io_link_timeout_fn(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
-static void io_queue_linked_timeout(struct io_kiocb *req, struct timespec64 *ts,
-				    enum hrtimer_mode *mode)
+static void io_queue_linked_timeout(struct io_kiocb *req)
 {
+	struct io_timeout_data *data = req->timeout.data;
 	struct io_ring_ctx *ctx = req->ctx;
 
 	/*
@@ -2782,9 +2813,9 @@ static void io_queue_linked_timeout(struct io_kiocb *req, struct timespec64 *ts,
 	 */
 	spin_lock_irq(&ctx->completion_lock);
 	if (!list_empty(&req->list)) {
-		req->timeout.timer.function = io_link_timeout_fn;
-		hrtimer_start(&req->timeout.timer, timespec64_to_ktime(*ts),
-				*mode);
+		data->timer.function = io_link_timeout_fn;
+		hrtimer_start(&data->timer, timespec64_to_ktime(data->ts),
+				data->mode);
 	}
 	spin_unlock_irq(&ctx->completion_lock);
 
@@ -2792,22 +2823,7 @@ static void io_queue_linked_timeout(struct io_kiocb *req, struct timespec64 *ts,
 	io_put_req(req);
 }
 
-static int io_validate_link_timeout(const struct io_uring_sqe *sqe,
-				    struct timespec64 *ts)
-{
-	if (sqe->ioprio || sqe->buf_index || sqe->len != 1 || sqe->off)
-		return -EINVAL;
-	if (sqe->timeout_flags & ~IORING_TIMEOUT_ABS)
-		return -EINVAL;
-	if (get_timespec64(ts, u64_to_user_ptr(sqe->addr)))
-		return -EFAULT;
-
-	return 0;
-}
-
-static struct io_kiocb *io_prep_linked_timeout(struct io_kiocb *req,
-					       struct timespec64 *ts,
-					       enum hrtimer_mode *mode)
+static struct io_kiocb *io_prep_linked_timeout(struct io_kiocb *req)
 {
 	struct io_kiocb *nxt;
 	int ret;
@@ -2819,7 +2835,10 @@ static struct io_kiocb *io_prep_linked_timeout(struct io_kiocb *req,
 	if (!nxt || nxt->submit.sqe->opcode != IORING_OP_LINK_TIMEOUT)
 		return NULL;
 
-	ret = io_validate_link_timeout(nxt->submit.sqe, ts);
+	ret = io_timeout_setup(nxt);
+	/* common setup allows offset being set, we don't */
+	if (!ret && nxt->submit.sqe->off)
+		ret = -EINVAL;
 	if (ret) {
 		list_del_init(&nxt->list);
 		io_cqring_add_event(nxt, ret);
@@ -2827,24 +2846,16 @@ static struct io_kiocb *io_prep_linked_timeout(struct io_kiocb *req,
 		return ERR_PTR(-ECANCELED);
 	}
 
-	if (nxt->submit.sqe->timeout_flags & IORING_TIMEOUT_ABS)
-		*mode = HRTIMER_MODE_ABS;
-	else
-		*mode = HRTIMER_MODE_REL;
-
 	req->flags |= REQ_F_LINK_TIMEOUT;
-	hrtimer_init(&nxt->timeout.timer, CLOCK_MONOTONIC, *mode);
 	return nxt;
 }
 
 static void __io_queue_sqe(struct io_kiocb *req)
 {
-	enum hrtimer_mode mode;
 	struct io_kiocb *nxt;
-	struct timespec64 ts;
 	int ret;
 
-	nxt = io_prep_linked_timeout(req, &ts, &mode);
+	nxt = io_prep_linked_timeout(req);
 	if (IS_ERR(nxt)) {
 		ret = PTR_ERR(nxt);
 		nxt = NULL;
@@ -2880,7 +2891,7 @@ static void __io_queue_sqe(struct io_kiocb *req)
 			io_queue_async_work(req);
 
 			if (nxt)
-				io_queue_linked_timeout(nxt, &ts, &mode);
+				io_queue_linked_timeout(nxt);
 
 			return;
 		}
@@ -2892,7 +2903,7 @@ static void __io_queue_sqe(struct io_kiocb *req)
 
 	if (nxt) {
 		if (!ret)
-			io_queue_linked_timeout(nxt, &ts, &mode);
+			io_queue_linked_timeout(nxt);
 		else
 			io_put_req(nxt);
 	}
-- 
2.24.0

