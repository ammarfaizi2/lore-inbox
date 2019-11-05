Return-Path: <SRS0=KDoC=Y5=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362DDC5DF63
	for <io-uring@archiver.kernel.org>; Tue,  5 Nov 2019 21:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D9721929
	for <io-uring@archiver.kernel.org>; Tue,  5 Nov 2019 21:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="txv6rmu4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbfKEVNZ (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 5 Nov 2019 16:13:25 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:39174 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729747AbfKEVNZ (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 5 Nov 2019 16:13:25 -0500
Received: by mail-il1-f195.google.com with SMTP id f201so13921700ilh.6
        for <io-uring@vger.kernel.org>; Tue, 05 Nov 2019 13:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6UJP+IIcwA8kqmzs8u/aFw5EKlSS0EbAD+bT9j1YNOg=;
        b=txv6rmu48fLCVc3nxeC8cGVLCM4Z5VwagjSGMMFMkp+TSm/PohF+mhzrpHc/gCtHCd
         23bUZb9XWfnWb+svvIEeOMiCGSwkGARNLuli85FNAW4VepE21YRWyPpEYlkj7OoaWEKz
         S6P8Tk5e3A2ugRQp3UMPxCkBTXBOP4/cIbrST+00f7XzS2NrOF8GtNf8hdIUMa8lrvmW
         g0ANR1j5qFkeKtXIq+IWNTS3JMhSfRP6HnwzPMozQafhEvUIFk7Cs/IRz81cr0436P79
         pOSMpfbojsWM7fuurr+RyLMBWb6DT/tfCJ8hLbDdncchWNS4TsUQxPLiU/4XXYAvpUxx
         OrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6UJP+IIcwA8kqmzs8u/aFw5EKlSS0EbAD+bT9j1YNOg=;
        b=VxDqkORxjWx4IVSV3+YqccRzaNONX+YhlgRcr/ErP70/e87vd81o/EfKsOjXnQwTmG
         nuJZPekPaz0J8iw3nQCj25bA62Y8XRuESkysSfZvUDuaZVNWQtapJIoinX9AbeIoGmmM
         FM8SjwxwP20wB+95zFjg7mPc3rlJfOBqW3q2TI4QLgHC4G6vYdtG+QUPL7mv5s+BM+Zm
         VJHAtNiRHCr0OesHiNAJrJgTyEafWWxVNL4L0xDjg035baEa6z6QySBMDgfLBXur18/C
         oCmVfgH5OOLk2ZUW9ZycuiWakbcK6qFRTZ9Udq3BaLYvXJpPDchO9TgmzHL+dfWd6Bbf
         dzZg==
X-Gm-Message-State: APjAAAXsM9oV0CkLbqyxQpR4NqkAN6+66H3nnLX+uu0TOp0mZXQw16P1
        w35Y7lsn9PQ54/BQhwk0nCmyHmjHFO4=
X-Google-Smtp-Source: APXvYqy4EuomBZ/a0svnjKYtvf3IvAisPgDb0qHU80+ZAobKoI2FuomOdmbGVRzdC3FmveRK4IFQOw==
X-Received: by 2002:a92:5d8d:: with SMTP id e13mr36438395ilg.32.1572988402872;
        Tue, 05 Nov 2019 13:13:22 -0800 (PST)
Received: from x1.localdomain ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q69sm3065721ilb.4.2019.11.05.13.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 13:13:21 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org, linux-block@vger.kernel.org
Cc:     zeba.hrvoje@gmail.com, asml.silence@gmail.com, liuyun01@kylinos.cn,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] io_uring: add support for linked SQE timeouts
Date:   Tue,  5 Nov 2019 14:11:31 -0700
Message-Id: <20191105211130.6130-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191105211130.6130-1-axboe@kernel.dk>
References: <20191105211130.6130-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 fs/io_uring.c                 | 172 ++++++++++++++++++++++++++++++++--
 include/uapi/linux/io_uring.h |   1 +
 2 files changed, 167 insertions(+), 6 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index a71c84808dd0..d4ff3e49a78c 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -336,6 +336,7 @@ struct io_kiocb {
 #define REQ_F_ISREG		2048	/* regular file */
 #define REQ_F_MUST_PUNT		4096	/* must be punted even for NONBLOCK */
 #define REQ_F_INFLIGHT		8192	/* on inflight list */
+#define REQ_F_LINK_TIMEOUT	16384	/* has linked timeout */
 	u64			user_data;
 	u32			result;
 	u32			sequence;
@@ -372,6 +373,7 @@ static void io_wq_submit_work(struct io_wq_work **workptr);
 static void io_cqring_fill_event(struct io_ring_ctx *ctx, u64 ki_user_data,
 				 long res);
 static void __io_free_req(struct io_kiocb *req);
+static void io_put_req(struct io_kiocb *req, struct io_kiocb **nxtptr);
 
 static struct kmem_cache *req_cachep;
 
@@ -713,9 +715,35 @@ static void __io_free_req(struct io_kiocb *req)
 	kmem_cache_free(req_cachep, req);
 }
 
+static void io_link_cancel_timeout(struct io_ring_ctx *ctx,
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
+	}
+}
+
 static void io_req_link_next(struct io_kiocb *req, struct io_kiocb **nxtptr)
 {
+	struct io_ring_ctx *ctx = req->ctx;
 	struct io_kiocb *nxt;
+	bool is_timeout_link;
+	unsigned long flags;
+
+	/*
+	 * If this is a timeout link, we could be racing with the timeout
+	 * timer. Grab the completion lock for this case to protect against
+	 * that.
+	 */
+	is_timeout_link = (req->flags & REQ_F_LINK_TIMEOUT);
+	if (is_timeout_link)
+		spin_lock_irqsave(&ctx->completion_lock, flags);
 
 	/*
 	 * The list should never be empty when we are called here. But could
@@ -723,7 +751,7 @@ static void io_req_link_next(struct io_kiocb *req, struct io_kiocb **nxtptr)
 	 * safe side.
 	 */
 	nxt = list_first_entry_or_null(&req->link_list, struct io_kiocb, list);
-	if (nxt) {
+	while (nxt) {
 		list_del(&nxt->list);
 		if (!list_empty(&req->link_list)) {
 			INIT_LIST_HEAD(&nxt->link_list);
@@ -736,10 +764,24 @@ static void io_req_link_next(struct io_kiocb *req, struct io_kiocb **nxtptr)
 		 * If we're in async work, we can continue processing the chain
 		 * in this context instead of having to queue up new async work.
 		 */
-		if (nxtptr && current_work())
+		if (is_timeout_link) {
+			io_link_cancel_timeout(ctx, nxt);
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
+	}
+
+	if (is_timeout_link) {
+		spin_unlock_irqrestore(&ctx->completion_lock, flags);
+		io_cqring_ev_posted(ctx);
 	}
 }
 
@@ -748,16 +790,30 @@ static void io_req_link_next(struct io_kiocb *req, struct io_kiocb **nxtptr)
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
@@ -2434,11 +2490,111 @@ static int io_grab_files(struct io_ring_ctx *ctx, struct io_kiocb *req)
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
+	if (prev)
+		ret = io_async_cancel_one(ctx, (void *) prev->user_data);
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
+	if (sqe->flags || sqe->ioprio || sqe->buf_index || sqe->len != 1)
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
+	if (sqe->flags & IORING_TIMEOUT_ABS)
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
 static int __io_queue_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 			struct sqe_submit *s)
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
 	ret = __io_submit_sqe(ctx, req, s, NULL, true);
 
 	/*
@@ -2603,6 +2759,10 @@ static void io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 		memcpy(&req->submit, s, sizeof(*s));
 		INIT_LIST_HEAD(&req->link_list);
 		*link = req;
+	} else if (READ_ONCE(s->sqe->opcode) == IORING_OP_LINK_TIMEOUT) {
+		/* Only valid as a linked SQE */
+		ret = -EINVAL;
+		goto err_req;
 	} else {
 		io_queue_sqe(ctx, req, s);
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
2.24.0

