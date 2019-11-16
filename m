Return-Path: <SRS0=SU/R=ZI=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E23C432C3
	for <io-uring@archiver.kernel.org>; Sat, 16 Nov 2019 01:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCC092073A
	for <io-uring@archiver.kernel.org>; Sat, 16 Nov 2019 01:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="h7xcBQls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfKPBxh (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 15 Nov 2019 20:53:37 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:46379 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727256AbfKPBxh (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 15 Nov 2019 20:53:37 -0500
Received: by mail-pj1-f68.google.com with SMTP id a16so193448pjs.13
        for <io-uring@vger.kernel.org>; Fri, 15 Nov 2019 17:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8s2w2jH+gcP8ZLEWUVOX7PvyxuU75Ly8qzDSEBoZakU=;
        b=h7xcBQls8Lqez1d+sGWDX5bKiW56ENrR8ClFH4ZgESQowsccqnoYfiNSGdWnGPTS/f
         AW5SjIMczbUxSYIU99fLi690rX0gmojVTtAik8J1uyA8OLkQPDrt3d3BUjI0B62F3hgS
         fNvyWseS7OLmaJoIUmbZoe3xL+u7VyOiw4rFBZ68SaxXAUgyy1nJy4NYh45g719kLN89
         DCb2OzJuXmcA6bDbWEdXLemCblCNqVaY+FHQfc7yCB3ziLgP0P1LrenpqFMT5D/BZQyk
         9F3ap7ISG2ecwZVMDoBFL0RhUUSLCSAL9icXcrXV52Xb7WYLnuTdBQSrdLV81WIPVmQB
         I7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8s2w2jH+gcP8ZLEWUVOX7PvyxuU75Ly8qzDSEBoZakU=;
        b=l1YE4cC7A+kgmYB80Tk8Bu3lrq0X27M+FiZazsq1nVG14owNhpAJwAXavQK2zGVAKB
         TVdzw1Z7DHXA92WNIuJmHrn1p9cHQQYTPcCB/prH1f5xZ6bhJoW7BfjPRnyWawSIV0vg
         s3hGSrPfr3TEoE/wECa1YYnjUFInYRIC5mwgFGaLcCZoYGwhYu8cgPfp6t+CEhBe+l+K
         lDMRrDGTDF7F/1Bo5OF2K44S7EZmmDYMTYEegduaKdN5DiYP2PYDKv0QtIgoUzYPEC/z
         EwJtUcihHBP6/8PPtuELvZTznqRLTr59E46iwA2dpl3Arw3ta0+7nPPrGIChqJPSci9f
         Ff1A==
X-Gm-Message-State: APjAAAXr00DZeu0MPwtbtUUmV6VgtO+dLhp+HigKgWyfsycPaijthD3Y
        egWZvTzfEBxRrRafQZxWrOJmgrZmUxs=
X-Google-Smtp-Source: APXvYqxFNLhPlhF66vaINgPJcbd4hUmfhURThRo39R9T0INMuEW/fCFm2wSacYRrTaA33LgczVm8TQ==
X-Received: by 2002:a17:902:4c:: with SMTP id 70mr17459520pla.4.1573869214751;
        Fri, 15 Nov 2019 17:53:34 -0800 (PST)
Received: from x1.localdomain ([2620:10d:c090:180::be7a])
        by smtp.gmail.com with ESMTPSA id i123sm16565458pfe.145.2019.11.15.17.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 17:53:33 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     asml.silence@gmail.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 7/8] io_uring: fix sequencing issues with linked timeouts
Date:   Fri, 15 Nov 2019 18:53:13 -0700
Message-Id: <20191116015314.24276-8-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191116015314.24276-1-axboe@kernel.dk>
References: <20191116015314.24276-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

We have an issue with timeout links that are deeper in the submit chain,
because we only handle it upfront, not from later submissions. Move the
prep + issue of the timeout link to the async work prep handler, and do
it normally for non-async queue. If we validate and prepare the timeout
links upfront when we first see them, there's nothing stopping us from
supporting any sort of nesting.

Fixes: 2665abfd757f ("io_uring: add support for linked SQE timeouts")
Reported-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 102 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 61 insertions(+), 41 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 883ac9b01083..b88bd65c9848 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -352,6 +352,7 @@ struct io_kiocb {
 #define REQ_F_MUST_PUNT		4096	/* must be punted even for NONBLOCK */
 #define REQ_F_INFLIGHT		8192	/* on inflight list */
 #define REQ_F_COMP_LOCKED	16384	/* completion under lock */
+#define REQ_F_FREE_SQE		32768	/* free sqe if not async queued */
 	u64			user_data;
 	u32			result;
 	u32			sequence;
@@ -390,6 +391,8 @@ static void __io_free_req(struct io_kiocb *req);
 static void io_put_req(struct io_kiocb *req);
 static void io_double_put_req(struct io_kiocb *req);
 static void __io_double_put_req(struct io_kiocb *req);
+static struct io_kiocb *io_prep_linked_timeout(struct io_kiocb *req);
+static void io_queue_linked_timeout(struct io_kiocb *req);
 
 static struct kmem_cache *req_cachep;
 
@@ -524,7 +527,8 @@ static inline bool io_sqe_needs_user(const struct io_uring_sqe *sqe)
 		 opcode == IORING_OP_WRITE_FIXED);
 }
 
-static inline bool io_prep_async_work(struct io_kiocb *req)
+static inline bool io_prep_async_work(struct io_kiocb *req,
+				      struct io_kiocb **link)
 {
 	bool do_hashed = false;
 
@@ -553,13 +557,17 @@ static inline bool io_prep_async_work(struct io_kiocb *req)
 			req->work.flags |= IO_WQ_WORK_NEEDS_USER;
 	}
 
+	*link = io_prep_linked_timeout(req);
 	return do_hashed;
 }
 
 static inline void io_queue_async_work(struct io_kiocb *req)
 {
-	bool do_hashed = io_prep_async_work(req);
 	struct io_ring_ctx *ctx = req->ctx;
+	struct io_kiocb *link;
+	bool do_hashed;
+
+	do_hashed = io_prep_async_work(req, &link);
 
 	trace_io_uring_queue_async_work(ctx, do_hashed, req, &req->work,
 					req->flags);
@@ -569,6 +577,9 @@ static inline void io_queue_async_work(struct io_kiocb *req)
 		io_wq_enqueue_hashed(ctx->io_wq, &req->work,
 					file_inode(req->file));
 	}
+
+	if (link)
+		io_queue_linked_timeout(link);
 }
 
 static void io_kill_timeout(struct io_kiocb *req)
@@ -870,6 +881,15 @@ static void io_req_link_next(struct io_kiocb *req, struct io_kiocb **nxtptr)
 	nxt = list_first_entry_or_null(&req->link_list, struct io_kiocb, list);
 	while (nxt) {
 		list_del_init(&nxt->list);
+
+		if ((req->flags & REQ_F_LINK_TIMEOUT) &&
+		    (nxt->flags & REQ_F_TIMEOUT)) {
+			wake_ev |= io_link_cancel_timeout(nxt);
+			nxt = list_first_entry_or_null(&req->link_list,
+							struct io_kiocb, list);
+			req->flags &= ~REQ_F_LINK_TIMEOUT;
+			continue;
+		}
 		if (!list_empty(&req->link_list)) {
 			INIT_LIST_HEAD(&nxt->link_list);
 			list_splice(&req->link_list, &nxt->link_list);
@@ -880,19 +900,13 @@ static void io_req_link_next(struct io_kiocb *req, struct io_kiocb **nxtptr)
 		 * If we're in async work, we can continue processing the chain
 		 * in this context instead of having to queue up new async work.
 		 */
-		if (req->flags & REQ_F_LINK_TIMEOUT) {
-			wake_ev = io_link_cancel_timeout(nxt);
-
-			/* we dropped this link, get next */
-			nxt = list_first_entry_or_null(&req->link_list,
-							struct io_kiocb, list);
-		} else if (nxtptr && io_wq_current_is_worker()) {
-			*nxtptr = nxt;
-			break;
-		} else {
-			io_queue_async_work(nxt);
-			break;
+		if (nxt) {
+			if (nxtptr && io_wq_current_is_worker())
+				*nxtptr = nxt;
+			else
+				io_queue_async_work(nxt);
 		}
+		break;
 	}
 
 	if (wake_ev)
@@ -911,11 +925,16 @@ static void io_fail_links(struct io_kiocb *req)
 	spin_lock_irqsave(&ctx->completion_lock, flags);
 
 	while (!list_empty(&req->link_list)) {
+		const struct io_uring_sqe *sqe_to_free = NULL;
+
 		link = list_first_entry(&req->link_list, struct io_kiocb, list);
 		list_del_init(&link->list);
 
 		trace_io_uring_fail_link(req, link);
 
+		if (link->flags & REQ_F_FREE_SQE)
+			sqe_to_free = link->submit.sqe;
+
 		if ((req->flags & REQ_F_LINK_TIMEOUT) &&
 		    link->submit.sqe->opcode == IORING_OP_LINK_TIMEOUT) {
 			io_link_cancel_timeout(link);
@@ -923,6 +942,7 @@ static void io_fail_links(struct io_kiocb *req)
 			io_cqring_fill_event(link, -ECANCELED);
 			__io_double_put_req(link);
 		}
+		kfree(sqe_to_free);
 	}
 
 	io_commit_cqring(ctx);
@@ -2668,8 +2688,12 @@ static void io_wq_submit_work(struct io_wq_work **workptr)
 
 	/* if a dependent link is ready, pass it back */
 	if (!ret && nxt) {
-		io_prep_async_work(nxt);
+		struct io_kiocb *link;
+
+		io_prep_async_work(nxt, &link);
 		*workptr = &nxt->work;
+		if (link)
+			io_queue_linked_timeout(link);
 	}
 }
 
@@ -2804,7 +2828,6 @@ static enum hrtimer_restart io_link_timeout_fn(struct hrtimer *timer)
 
 static void io_queue_linked_timeout(struct io_kiocb *req)
 {
-	struct io_timeout_data *data = req->timeout.data;
 	struct io_ring_ctx *ctx = req->ctx;
 
 	/*
@@ -2813,6 +2836,8 @@ static void io_queue_linked_timeout(struct io_kiocb *req)
 	 */
 	spin_lock_irq(&ctx->completion_lock);
 	if (!list_empty(&req->list)) {
+		struct io_timeout_data *data = req->timeout.data;
+
 		data->timer.function = io_link_timeout_fn;
 		hrtimer_start(&data->timer, timespec64_to_ktime(data->ts),
 				data->mode);
@@ -2826,7 +2851,6 @@ static void io_queue_linked_timeout(struct io_kiocb *req)
 static struct io_kiocb *io_prep_linked_timeout(struct io_kiocb *req)
 {
 	struct io_kiocb *nxt;
-	int ret;
 
 	if (!(req->flags & REQ_F_LINK))
 		return NULL;
@@ -2835,33 +2859,15 @@ static struct io_kiocb *io_prep_linked_timeout(struct io_kiocb *req)
 	if (!nxt || nxt->submit.sqe->opcode != IORING_OP_LINK_TIMEOUT)
 		return NULL;
 
-	ret = io_timeout_setup(nxt);
-	/* common setup allows offset being set, we don't */
-	if (!ret && nxt->submit.sqe->off)
-		ret = -EINVAL;
-	if (ret) {
-		list_del_init(&nxt->list);
-		io_cqring_add_event(nxt, ret);
-		io_double_put_req(nxt);
-		return ERR_PTR(-ECANCELED);
-	}
-
 	req->flags |= REQ_F_LINK_TIMEOUT;
 	return nxt;
 }
 
 static void __io_queue_sqe(struct io_kiocb *req)
 {
-	struct io_kiocb *nxt;
+	struct io_kiocb *nxt = io_prep_linked_timeout(req);
 	int ret;
 
-	nxt = io_prep_linked_timeout(req);
-	if (IS_ERR(nxt)) {
-		ret = PTR_ERR(nxt);
-		nxt = NULL;
-		goto err;
-	}
-
 	ret = __io_submit_sqe(req, NULL, true);
 
 	/*
@@ -2889,10 +2895,6 @@ static void __io_queue_sqe(struct io_kiocb *req)
 			 * submit reference when the iocb is actually submitted.
 			 */
 			io_queue_async_work(req);
-
-			if (nxt)
-				io_queue_linked_timeout(nxt);
-
 			return;
 		}
 	}
@@ -2937,6 +2939,10 @@ static void io_queue_link_head(struct io_kiocb *req, struct io_kiocb *shadow)
 	int need_submit = false;
 	struct io_ring_ctx *ctx = req->ctx;
 
+	if (unlikely(req->flags & REQ_F_FAIL_LINK)) {
+		ret = -ECANCELED;
+		goto err;
+	}
 	if (!shadow) {
 		io_queue_sqe(req);
 		return;
@@ -2951,9 +2957,11 @@ static void io_queue_link_head(struct io_kiocb *req, struct io_kiocb *shadow)
 	ret = io_req_defer(req);
 	if (ret) {
 		if (ret != -EIOCBQUEUED) {
+err:
 			io_cqring_add_event(req, ret);
 			io_double_put_req(req);
-			__io_free_req(shadow);
+			if (shadow)
+				__io_free_req(shadow);
 			return;
 		}
 	} else {
@@ -3010,6 +3018,17 @@ static void io_submit_sqe(struct io_kiocb *req, struct io_submit_state *state,
 	if (*link) {
 		struct io_kiocb *prev = *link;
 
+		if (READ_ONCE(s->sqe->opcode) == IORING_OP_LINK_TIMEOUT) {
+			ret = io_timeout_setup(req);
+			/* common setup allows offset being set, we don't */
+			if (!ret && s->sqe->off)
+				ret = -EINVAL;
+			if (ret) {
+				prev->flags |= REQ_F_FAIL_LINK;
+				goto err_req;
+			}
+		}
+
 		sqe_copy = kmemdup(s->sqe, sizeof(*sqe_copy), GFP_KERNEL);
 		if (!sqe_copy) {
 			ret = -EAGAIN;
@@ -3017,6 +3036,7 @@ static void io_submit_sqe(struct io_kiocb *req, struct io_submit_state *state,
 		}
 
 		s->sqe = sqe_copy;
+		req->flags |= REQ_F_FREE_SQE;
 		trace_io_uring_link(ctx, req, prev);
 		list_add_tail(&req->list, &prev->link_list);
 	} else if (s->sqe->flags & IOSQE_IO_LINK) {
-- 
2.24.0

