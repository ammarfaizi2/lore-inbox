Return-Path: <SRS0=nqv2=Y7=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11218FC6194
	for <io-uring@archiver.kernel.org>; Thu,  7 Nov 2019 02:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D25217D7
	for <io-uring@archiver.kernel.org>; Thu,  7 Nov 2019 02:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="f1pcuZZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbfKGCFb (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 6 Nov 2019 21:05:31 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33878 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfKGCFb (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 6 Nov 2019 21:05:31 -0500
Received: by mail-pf1-f193.google.com with SMTP id n13so1124097pff.1
        for <io-uring@vger.kernel.org>; Wed, 06 Nov 2019 18:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=DKpktMecAhyYb9DgTgTtqb/0kaNHJHK6pwfvR8phk/A=;
        b=f1pcuZZJl3zKMGeqMkc/DPP/mru9dMkPsizPWeFWg3X0VsNnwBsFPEHROYFgBAZ7YW
         cAoBTWsPnMGH1sm3J5nLBTW3nzz8eUwpK8JulzaxRt38trDCPTFOTNqGkj3zDRQwJUzB
         qHZhZfLcOBD4shMKxNRqsi69TO67RsTz8zk3DgXe3otn3jQ7VswrmnZeR+UMkGjCdrE9
         AVHf8gyJ7h93vQQJwRPn1lj22NwFJwslbde6ijuXMTVcw/R83gKXVyj4vTd83VRHo1yo
         RLAh5xtoQ76lNBz5L2o3kU9UhMHZf51vzwO5429/xybXKyicOj6Rnf04WGiUSFg4onmW
         aGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=DKpktMecAhyYb9DgTgTtqb/0kaNHJHK6pwfvR8phk/A=;
        b=ZYYubOQ3lPRQhClqTAhr6gZ90MsajcWNJOEIw9AYa+IVuubhDihX+LU6stwqFOEEVm
         dW0EHfFlz0NpiFkzm3N3thub9xlMbMSwrLXqzL9gBhJ3TK7+S9QGC+y3Mn5GvH+uBmx9
         RVsDiNBnP5juql6lP56i/ko/QqFsSPmcGhYScQGCdcR6azFsd348nUmA5yRmzp3+Msy/
         3FWMZkg0T1V187UzJU7AIpHhTulbC9YnNLsMM/vmm2nClw5vzF5vTaFP7Yl7wowFtxSD
         135KR5glFbdBI8Npt9/iZPWnMLcZgrxoXwMkjYOv+WFvqeIg9jMUdd7hZA3P3YScSfBM
         ryeQ==
X-Gm-Message-State: APjAAAVWfn4xW1cC+t2hwaMyo7/FXAaTgK6vI0St2U3zhAI4/brR/yaz
        iGc7+H9yQIFXZ0TS4dUFy0BJzQ==
X-Google-Smtp-Source: APXvYqxYUXG/qYeoEMsM8esUlbCJzRBR6npU2VwfWVhwCiF6iW95GLLqum4omrddOTFSe5zBIEwU5Q==
X-Received: by 2002:a62:75d7:: with SMTP id q206mr655966pfc.232.1573092328909;
        Wed, 06 Nov 2019 18:05:28 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id b26sm376775pgs.93.2019.11.06.18.05.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 18:05:28 -0800 (PST)
To:     io-uring@vger.kernel.org
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2] io_uring: add support for linked SQE timeouts
Message-ID: <a7a32933-10fb-9c90-04ce-3f64ecad2421@kernel.dk>
Date:   Wed, 6 Nov 2019 19:05:25 -0700
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

While we have support for generic timeouts, we don't have a way to tie
a timeout to a specific SQE. The generic timeouts simply trigger wakeups
on the CQ ring.

This adds support for IORING_OP_LINK_TIMEOUT. This command is only valid
as a link to a previous command. The timeout specific can be either
relative or absolute, following the same rules as IORING_OP_TIMEOUT. If
the timeout triggers before the dependent command completes, it will
attempt to cancel that command. Likewise, if the dependent command
completes before the timeout triggers, it will cancel the timeout.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

Changes since v1:
- Move required locking outside of io_req_link_next(), it's much
  cleaner this way and avoids sparse complaining.
- Avoid 32-bit complaint on casting to pointer of different size
- Fix IORING_TIMEOUT_ABS, used sqe->flags instead of timeout_flags
- Rebase on top of current tree

diff --git a/fs/io_uring.c b/fs/io_uring.c
index c39d1c50a3be..e29ecc1b0218 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -329,6 +329,7 @@ struct io_kiocb {
 #define REQ_F_IO_DRAIN		16	/* drain existing IO first */
 #define REQ_F_IO_DRAINED	32	/* drain done */
 #define REQ_F_LINK		64	/* linked sqes */
+#define REQ_F_LINK_TIMEOUT	128	/* has linked timeout */
 #define REQ_F_FAIL_LINK		256	/* fail rest of links */
 #define REQ_F_SHADOW_DRAIN	512	/* link-drain shadow req */
 #define REQ_F_TIMEOUT		1024	/* timeout request */
@@ -371,6 +372,7 @@ static void io_wq_submit_work(struct io_wq_work **workptr);
 static void io_cqring_fill_event(struct io_ring_ctx *ctx, u64 ki_user_data,
 				 long res);
 static void __io_free_req(struct io_kiocb *req);
+static void io_put_req(struct io_kiocb *req, struct io_kiocb **nxtptr);
 
 static struct kmem_cache *req_cachep;
 
@@ -712,9 +714,28 @@ static void __io_free_req(struct io_kiocb *req)
 	kmem_cache_free(req_cachep, req);
 }
 
+static bool io_link_cancel_timeout(struct io_ring_ctx *ctx,
+				   struct io_kiocb *req)
+{
+	int ret;
+
+	ret = hrtimer_try_to_cancel(&req->timeout.timer);
+	if (ret != -1) {
+		io_cqring_fill_event(ctx, req->user_data, -ECANCELED);
+		io_commit_cqring(ctx);
+		req->flags &= ~REQ_F_LINK;
+		__io_free_req(req);
+		return true;
+	}
+
+	return false;
+}
+
 static void io_req_link_next(struct io_kiocb *req, struct io_kiocb **nxtptr)
 {
+	struct io_ring_ctx *ctx = req->ctx;
 	struct io_kiocb *nxt;
+	bool wake_ev = false;
 
 	/*
 	 * The list should never be empty when we are called here. But could
@@ -722,7 +743,7 @@ static void io_req_link_next(struct io_kiocb *req, struct io_kiocb **nxtptr)
 	 * safe side.
 	 */
 	nxt = list_first_entry_or_null(&req->link_list, struct io_kiocb, list);
-	if (nxt) {
+	while (nxt) {
 		list_del(&nxt->list);
 		if (!list_empty(&req->link_list)) {
 			INIT_LIST_HEAD(&nxt->link_list);
@@ -734,11 +755,23 @@ static void io_req_link_next(struct io_kiocb *req, struct io_kiocb **nxtptr)
 		 * If we're in async work, we can continue processing the chain
 		 * in this context instead of having to queue up new async work.
 		 */
-		if (nxtptr && current_work())
+		if (req->flags & REQ_F_LINK_TIMEOUT) {
+			wake_ev = io_link_cancel_timeout(ctx, nxt);
+
+			/* we dropped this link, get next */
+			nxt = list_first_entry_or_null(&req->link_list,
+							struct io_kiocb, list);
+		} else if (nxtptr && current_work()) {
 			*nxtptr = nxt;
-		else
+			nxt = NULL;
+		} else {
 			io_queue_async_work(req->ctx, nxt);
+			nxt = NULL;
+		}
 	}
+
+	if (wake_ev)
+		io_cqring_ev_posted(ctx);
 }
 
 /*
@@ -746,16 +779,30 @@ static void io_req_link_next(struct io_kiocb *req, struct io_kiocb **nxtptr)
  */
 static void io_fail_links(struct io_kiocb *req)
 {
+	struct io_ring_ctx *ctx = req->ctx;
 	struct io_kiocb *link;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ctx->completion_lock, flags);
 
 	while (!list_empty(&req->link_list)) {
 		link = list_first_entry(&req->link_list, struct io_kiocb, list);
-		list_del(&link->list);
+		list_del_init(&link->list);
 
 		trace_io_uring_fail_link(req, link);
-		io_cqring_add_event(req->ctx, link->user_data, -ECANCELED);
-		__io_free_req(link);
+
+		if ((req->flags & REQ_F_LINK_TIMEOUT) &&
+		    link->submit.sqe->opcode == IORING_OP_LINK_TIMEOUT) {
+			io_link_cancel_timeout(ctx, link);
+		} else {
+			io_cqring_fill_event(ctx, link->user_data, -ECANCELED);
+			__io_free_req(link);
+		}
 	}
+
+	io_commit_cqring(ctx);
+	spin_unlock_irqrestore(&ctx->completion_lock, flags);
+	io_cqring_ev_posted(ctx);
 }
 
 static void io_free_req(struct io_kiocb *req, struct io_kiocb **nxt)
@@ -767,10 +814,22 @@ static void io_free_req(struct io_kiocb *req, struct io_kiocb **nxt)
 	 * of the chain.
 	 */
 	if (req->flags & REQ_F_LINK) {
-		if (req->flags & REQ_F_FAIL_LINK)
+		if (req->flags & REQ_F_FAIL_LINK) {
 			io_fail_links(req);
-		else
+		} else if (req->flags & REQ_F_LINK_TIMEOUT) {
+			struct io_ring_ctx *ctx = req->ctx;
+			unsigned long flags;
+
+			/* If this is a timeout link, we could be racing with
+			 * the timeout timer. Grab the completion lock for
+			 * this case to protection against that.
+			 */
+			spin_lock_irqsave(&ctx->completion_lock, flags);
+			io_req_link_next(req, nxt);
+			spin_unlock_irqrestore(&ctx->completion_lock, flags);
+		} else {
 			io_req_link_next(req, nxt);
+		}
 	}
 
 	__io_free_req(req);
@@ -2447,10 +2506,112 @@ static int io_grab_files(struct io_ring_ctx *ctx, struct io_kiocb *req)
 	return ret;
 }
 
+static enum hrtimer_restart io_link_timeout_fn(struct hrtimer *timer)
+{
+	struct io_kiocb *req = container_of(timer, struct io_kiocb,
+						timeout.timer);
+	struct io_ring_ctx *ctx = req->ctx;
+	struct io_kiocb *prev = NULL;
+	unsigned long flags;
+	int ret = -ETIME;
+
+	spin_lock_irqsave(&ctx->completion_lock, flags);
+
+	/*
+	 * We don't expect the list to be empty, that will only happen if we
+	 * race with the completion of the linked work.
+	 */
+	if (!list_empty(&req->list)) {
+		prev = list_entry(req->list.prev, struct io_kiocb, link_list);
+		list_del_init(&req->list);
+	}
+
+	spin_unlock_irqrestore(&ctx->completion_lock, flags);
+
+	if (prev) {
+		void *user_data = (void *) (unsigned long) prev->user_data;
+		ret = io_async_cancel_one(ctx, user_data);
+	}
+
+	io_cqring_add_event(ctx, req->user_data, ret);
+	io_put_req(req, NULL);
+	return HRTIMER_NORESTART;
+}
+
+static int io_queue_linked_timeout(struct io_kiocb *req, struct io_kiocb *nxt)
+{
+	const struct io_uring_sqe *sqe = nxt->submit.sqe;
+	enum hrtimer_mode mode;
+	struct timespec64 ts;
+	int ret = -EINVAL;
+
+	if (sqe->ioprio || sqe->buf_index || sqe->len != 1 || sqe->off)
+		goto err;
+	if (sqe->timeout_flags & ~IORING_TIMEOUT_ABS)
+		goto err;
+	if (get_timespec64(&ts, u64_to_user_ptr(sqe->addr))) {
+		ret = -EFAULT;
+		goto err;
+	}
+
+	req->flags |= REQ_F_LINK_TIMEOUT;
+
+	if (sqe->timeout_flags & IORING_TIMEOUT_ABS)
+		mode = HRTIMER_MODE_ABS;
+	else
+		mode = HRTIMER_MODE_REL;
+	hrtimer_init(&nxt->timeout.timer, CLOCK_MONOTONIC, mode);
+	nxt->timeout.timer.function = io_link_timeout_fn;
+	hrtimer_start(&nxt->timeout.timer, timespec64_to_ktime(ts), mode);
+	ret = 0;
+err:
+	/* drop submission reference */
+	io_put_req(nxt, NULL);
+
+	if (ret) {
+		struct io_ring_ctx *ctx = req->ctx;
+
+		/*
+		 * Break the link and fail linked timeout, parent will get
+		 * failed by the regular submission path.
+		 */
+		list_del(&nxt->list);
+		io_cqring_fill_event(ctx, nxt->user_data, ret);
+		trace_io_uring_fail_link(req, nxt);
+		io_commit_cqring(ctx);
+		io_put_req(nxt, NULL);
+		ret = -ECANCELED;
+	}
+
+	return ret;
+}
+
+static inline struct io_kiocb *io_get_linked_timeout(struct io_kiocb *req)
+{
+	struct io_kiocb *nxt;
+
+	if (!(req->flags & REQ_F_LINK))
+		return NULL;
+
+	nxt = list_first_entry_or_null(&req->link_list, struct io_kiocb, list);
+	if (nxt && nxt->submit.sqe->opcode == IORING_OP_LINK_TIMEOUT)
+		return nxt;
+
+	return NULL;
+}
+
 static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req)
 {
+	struct io_kiocb *nxt;
 	int ret;
 
+	nxt = io_get_linked_timeout(req);
+	if (unlikely(nxt)) {
+		ret = io_queue_linked_timeout(req, nxt);
+		if (ret)
+			goto err;
+	}
+
 	ret = __io_submit_sqe(ctx, req, NULL, true);
 
 	/*
@@ -2605,6 +2766,10 @@ static void io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 
 		INIT_LIST_HEAD(&req->link_list);
 		*link = req;
+	} else if (READ_ONCE(s->sqe->opcode) == IORING_OP_LINK_TIMEOUT) {
+		/* Only valid as a linked SQE */
+		ret = -EINVAL;
+		goto err_req;
 	} else {
 		io_queue_sqe(ctx, req);
 	}
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 6877cf8894db..f1a118b01d18 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -72,6 +72,7 @@ struct io_uring_sqe {
 #define IORING_OP_TIMEOUT_REMOVE	12
 #define IORING_OP_ACCEPT	13
 #define IORING_OP_ASYNC_CANCEL	14
+#define IORING_OP_LINK_TIMEOUT	15
 
 /*
  * sqe->fsync_flags

-- 
Jens Axboe

