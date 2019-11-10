Return-Path: <SRS0=ex/T=ZC=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8FDC43331
	for <io-uring@archiver.kernel.org>; Sun, 10 Nov 2019 02:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A785322573
	for <io-uring@archiver.kernel.org>; Sun, 10 Nov 2019 02:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="redF7Byk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfKJCzL (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:55:11 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33459 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbfKJCzL (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 9 Nov 2019 21:55:11 -0500
Received: by mail-pg1-f195.google.com with SMTP id h27so6752852pgn.0
        for <io-uring@vger.kernel.org>; Sat, 09 Nov 2019 18:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=XDQW6j1xy8ILfrnK98bDRqan/10e+mUyLj3dC2E6Fvw=;
        b=redF7Byk8wC/pdfQICmh/mIzl6tQEzJVmuBv3U/9cdBHZUSmcuABjnYRjeNELBA5GD
         TGtJFPTtco9f2C5OwZulLxiYLmOZRfJmoRAcxoK+8Br6sz0q77NkGajDoKC/ZswOkbZk
         E1X75RKWCtDDaKLlFsIMjHnXBvBx9jQ44/RsSAGgs/vsNanpLGD19Nqayl2ZZvtZPXA7
         4PYD9q7ZQoSLJu7pfv0LUVohqy7MeWoRxxPVP35fSrSgE87HEEP1VpkjlNvV5CiymhxQ
         NDDpwKq3W6SKmCWIrC6xIsK6WFzqJJKn+g5dBpByirie/iX6C/7pj6/GX9eD9NbwWjdk
         FUkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=XDQW6j1xy8ILfrnK98bDRqan/10e+mUyLj3dC2E6Fvw=;
        b=MI+C4/uFRJ83kAGJbUVTuxcb3amwauGVxiapVGfT08ny4IDzaxsLKQrge1Qs2gkM6J
         0fIPsHiM2A0g8f+OBZMDdF7B4iAaQaUL8mttq3IFt0gNzH/yqYprPH+wU4WoaCwqJ3ck
         4Z0lOrmUW3ogvxmfBN6056GE0iijKy30UHJ1wM9YBwixN381hXtYH6XI+oD0FPpoUucp
         ZFFu3Q6pQobu1Ba7xTQZeP0qzvQbobx3GgTegFiNsEe8cI6KtkRLJGRGQxFE79b4hr5W
         ky/DT/Uju+Hmfs7gu1QdW3zZEA/P3/D1f39vBUlvBRDmnMmMnE4AtU3KtJN0XI+4UuWM
         zb/Q==
X-Gm-Message-State: APjAAAUQCzrHl8mnvhoU7mUGxMWANwYXja7P2vQpxMfFz+KmcqI06xOi
        mDCAkwpb8xvdTtoESTv6yugmbKuAXO8=
X-Google-Smtp-Source: APXvYqx8Vp13p5lilxCDt2FPAwTXjPL8IGzhaoPMmAFu9TleF3tbyaWAAmd4SbfqtXjEBnVcmX+VFg==
X-Received: by 2002:a17:90a:268c:: with SMTP id m12mr24479525pje.69.1573354509976;
        Sat, 09 Nov 2019 18:55:09 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id 26sm9481905pjg.21.2019.11.09.18.55.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Nov 2019 18:55:09 -0800 (PST)
To:     io-uring@vger.kernel.org
Cc:     Hrvoje Zeba <zeba.hrvoje@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2] io_uring: make ASYNC_CANCEL work with poll and timeout
Message-ID: <51703f36-0a18-b7ef-6b11-7fba4b0022e3@kernel.dk>
Date:   Sat, 9 Nov 2019 19:55:07 -0700
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

It's a little confusing that we have multiple types of command
cancellation opcodes now that we have a generic one. Make the generic
one work with POLL_ADD and TIMEOUT commands as well, that makes for an
easier to use API for the application. The fact that they currently
don't is a bit confusing.

Add a helper that takes care of it, so we can user it from both
IORING_OP_ASYNC_CANCEL and from the linked timeout cancellation.

Reported-by: Hrvoje Zeba <zeba.hrvoje@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

Changes since v1:
- Add a generic helper that we can use from both IORING_OP_ASYNC_CANCEL
  and from the linked timeout handler. This makes it work as expected
  on linked timeouts, too.

diff --git a/fs/io_uring.c b/fs/io_uring.c
index a2548a6dd195..1d5a892841e9 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1957,6 +1957,20 @@ static void io_poll_remove_all(struct io_ring_ctx *ctx)
 	spin_unlock_irq(&ctx->completion_lock);
 }
 
+static int io_poll_cancel(struct io_ring_ctx *ctx, __u64 sqe_addr)
+{
+	struct io_kiocb *req;
+
+	list_for_each_entry(req, &ctx->cancel_list, list) {
+		if (req->user_data != sqe_addr)
+			continue;
+		io_poll_remove_one(req);
+		return 0;
+	}
+
+	return -ENOENT;
+}
+
 /*
  * Find a running poll command that matches one specified in sqe->addr,
  * and remove it if found.
@@ -1964,8 +1978,7 @@ static void io_poll_remove_all(struct io_ring_ctx *ctx)
 static int io_poll_remove(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
 	struct io_ring_ctx *ctx = req->ctx;
-	struct io_kiocb *poll_req, *next;
-	int ret = -ENOENT;
+	int ret;
 
 	if (unlikely(req->ctx->flags & IORING_SETUP_IOPOLL))
 		return -EINVAL;
@@ -1974,13 +1987,7 @@ static int io_poll_remove(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		return -EINVAL;
 
 	spin_lock_irq(&ctx->completion_lock);
-	list_for_each_entry_safe(poll_req, next, &ctx->cancel_list, list) {
-		if (READ_ONCE(sqe->addr) == poll_req->user_data) {
-			io_poll_remove_one(poll_req);
-			ret = 0;
-			break;
-		}
-	}
+	ret = io_poll_cancel(ctx, READ_ONCE(sqe->addr));
 	spin_unlock_irq(&ctx->completion_lock);
 
 	io_cqring_add_event(req, ret);
@@ -2200,6 +2207,31 @@ static enum hrtimer_restart io_timeout_fn(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
+static int io_timeout_cancel(struct io_ring_ctx *ctx, __u64 user_data)
+{
+	struct io_kiocb *req;
+	int ret = -ENOENT;
+
+	list_for_each_entry(req, &ctx->timeout_list, list) {
+		if (user_data == req->user_data) {
+			list_del_init(&req->list);
+			ret = 0;
+			break;
+		}
+	}
+
+	if (ret == -ENOENT)
+		return ret;
+
+	ret = hrtimer_try_to_cancel(&req->timeout.timer);
+	if (ret == -1)
+		return -EALREADY;
+
+	io_cqring_fill_event(req, -ECANCELED);
+	io_put_req(req);
+	return 0;
+}
+
 /*
  * Remove or update an existing timeout command
  */
@@ -2207,10 +2239,8 @@ static int io_timeout_remove(struct io_kiocb *req,
 			     const struct io_uring_sqe *sqe)
 {
 	struct io_ring_ctx *ctx = req->ctx;
-	struct io_kiocb *treq;
-	int ret = -ENOENT;
-	__u64 user_data;
 	unsigned flags;
+	int ret;
 
 	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
 		return -EINVAL;
@@ -2220,42 +2250,15 @@ static int io_timeout_remove(struct io_kiocb *req,
 	if (flags)
 		return -EINVAL;
 
-	user_data = READ_ONCE(sqe->addr);
 	spin_lock_irq(&ctx->completion_lock);
-	list_for_each_entry(treq, &ctx->timeout_list, list) {
-		if (user_data == treq->user_data) {
-			list_del_init(&treq->list);
-			ret = 0;
-			break;
-		}
-	}
+	ret = io_timeout_cancel(ctx, READ_ONCE(sqe->addr));
 
-	/* didn't find timeout */
-	if (ret) {
-fill_ev:
-		io_cqring_fill_event(req, ret);
-		io_commit_cqring(ctx);
-		spin_unlock_irq(&ctx->completion_lock);
-		io_cqring_ev_posted(ctx);
-		if (req->flags & REQ_F_LINK)
-			req->flags |= REQ_F_FAIL_LINK;
-		io_put_req(req);
-		return 0;
-	}
-
-	ret = hrtimer_try_to_cancel(&treq->timeout.timer);
-	if (ret == -1) {
-		ret = -EBUSY;
-		goto fill_ev;
-	}
-
-	io_cqring_fill_event(req, 0);
-	io_cqring_fill_event(treq, -ECANCELED);
+	io_cqring_fill_event(req, ret);
 	io_commit_cqring(ctx);
 	spin_unlock_irq(&ctx->completion_lock);
 	io_cqring_ev_posted(ctx);
-
-	io_put_req(treq);
+	if (ret < 0 && req->flags & REQ_F_LINK)
+		req->flags |= REQ_F_FAIL_LINK;
 	io_put_req(req);
 	return 0;
 }
@@ -2372,12 +2375,38 @@ static int io_async_cancel_one(struct io_ring_ctx *ctx, void *sqe_addr)
 	return ret;
 }
 
+static void io_async_find_and_cancel(struct io_ring_ctx *ctx,
+				     struct io_kiocb *req, __u64 sqe_addr,
+				     struct io_kiocb **nxt)
+{
+	int ret;
+
+	ret = io_async_cancel_one(ctx, (void *) (unsigned long) sqe_addr);
+	if (ret != -ENOENT) {
+		spin_lock_irq(&ctx->completion_lock);
+		goto done;
+	}
+
+	spin_lock_irq(&ctx->completion_lock);
+	ret = io_timeout_cancel(ctx, sqe_addr);
+	if (ret != -ENOENT)
+		goto done;
+	ret = io_poll_cancel(ctx, sqe_addr);
+done:
+	io_cqring_fill_event(req, ret);
+	io_commit_cqring(ctx);
+	spin_unlock_irq(&ctx->completion_lock);
+	io_cqring_ev_posted(ctx);
+
+	if (ret < 0 && (req->flags & REQ_F_LINK))
+		req->flags |= REQ_F_FAIL_LINK;
+	io_put_req_find_next(req, nxt);
+}
+
 static int io_async_cancel(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 			   struct io_kiocb **nxt)
 {
 	struct io_ring_ctx *ctx = req->ctx;
-	void *sqe_addr;
-	int ret;
 
 	if (unlikely(ctx->flags & IORING_SETUP_IOPOLL))
 		return -EINVAL;
@@ -2385,13 +2414,7 @@ static int io_async_cancel(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	    sqe->cancel_flags)
 		return -EINVAL;
 
-	sqe_addr = (void *) (unsigned long) READ_ONCE(sqe->addr);
-	ret = io_async_cancel_one(ctx, sqe_addr);
-
-	if (ret < 0 && (req->flags & REQ_F_LINK))
-		req->flags |= REQ_F_FAIL_LINK;
-	io_cqring_add_event(req, ret);
-	io_put_req_find_next(req, nxt);
+	io_async_find_and_cancel(ctx, req, READ_ONCE(sqe->addr), NULL);
 	return 0;
 }
 
@@ -2653,7 +2676,6 @@ static enum hrtimer_restart io_link_timeout_fn(struct hrtimer *timer)
 	struct io_ring_ctx *ctx = req->ctx;
 	struct io_kiocb *prev = NULL;
 	unsigned long flags;
-	int ret = -ETIME;
 
 	spin_lock_irqsave(&ctx->completion_lock, flags);
 
@@ -2669,12 +2691,11 @@ static enum hrtimer_restart io_link_timeout_fn(struct hrtimer *timer)
 	spin_unlock_irqrestore(&ctx->completion_lock, flags);
 
 	if (prev) {
-		void *user_data = (void *) (unsigned long) prev->user_data;
-		ret = io_async_cancel_one(ctx, user_data);
+		io_async_find_and_cancel(ctx, req, prev->user_data, NULL);
+	} else {
+		io_cqring_add_event(req, -ETIME);
+		io_put_req(req);
 	}
-
-	io_cqring_add_event(req, ret);
-	io_put_req(req);
 	return HRTIMER_NORESTART;
 }
 
-- 
Jens Axboe

