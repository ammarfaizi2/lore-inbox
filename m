Return-Path: <SRS0=SU/R=ZI=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58057C432C3
	for <io-uring@archiver.kernel.org>; Sat, 16 Nov 2019 01:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA8E2073A
	for <io-uring@archiver.kernel.org>; Sat, 16 Nov 2019 01:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Hewm9WgN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfKPBx2 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 15 Nov 2019 20:53:28 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46110 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbfKPBx1 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 15 Nov 2019 20:53:27 -0500
Received: by mail-pf1-f195.google.com with SMTP id 193so7474906pfc.13
        for <io-uring@vger.kernel.org>; Fri, 15 Nov 2019 17:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FofUTOF7IKZAnP/JenfWFFVTpnLu79rqX+gb90GIGXE=;
        b=Hewm9WgNt7bap8vLFXr1hNI2GUrhdl6qdG05VpxoiheT0dLmf+QkXo/3fOUZbEYqWp
         OHnW2ZlKUTadm9cgXJKDBgvMuB7GYguYssNIMAtMtlZJGy807wPvWqOwfzoegeE/7Vgt
         t8EpI9U4G7xogfXbice1Zge/QuB/1KpjnPwPJzheo1sk/HPPRbijUUlFnnQmY1mdl9Ta
         XorsvKbfA5+xsX7HFBmvkGeTr6Vral8YOPWMFC3iFCu2mbrXUk6Q1lc0PUjI4dfndoti
         iJ66iIKBgf19Tjc/vH4A8MBIecxYJkBIIXjzX5DKijcUet60I9b0IbSfP3ZvyJwm/Tlr
         oJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FofUTOF7IKZAnP/JenfWFFVTpnLu79rqX+gb90GIGXE=;
        b=YH+yCSNeLXVMB9ve/NfXGXZySwZe8kxZ//h7oS2agS8/P6URjgjiAXqNVYHFCStFos
         1XWvC+nZZAZc3NNbv0yxjz26EMra9f736UlD7rsWmopqMMlsZL02K6g0h+2PEYv2bdyJ
         Tj3vqPgqwhOmH4B/ZmdmsnSGwSRip+tMLzxOsEMiMduHcyFLoHFKB7IzVbsF0LIVL7Wq
         mUL0jSfpym3MILHRZvyMiNDteuYDA8KzFi801uEbSnh5GqUS/eHMYMKN027r/UVd3xRe
         0P2ewpuDMsVN+M8kMYH0Rv0N6WCGo6QyXVQB5YISufVeHS6qoMRF21rSMNeLPPjIyddE
         egMw==
X-Gm-Message-State: APjAAAXOu7DsOIYuaG8Ylj2gOBhyj5Mbn5RUQzkftctPYkh3qv612Hsw
        G4XSqwmeBzFewRZS6Jr589PQnZvFBtQ=
X-Google-Smtp-Source: APXvYqydZckRkKe1Zgd4VxFxXdZgM28nomF/p0evjamr8baBwdZlkjiGQYAmj1hOSOFSUUnvLHTY6Q==
X-Received: by 2002:a62:6404:: with SMTP id y4mr20302380pfb.170.1573869205083;
        Fri, 15 Nov 2019 17:53:25 -0800 (PST)
Received: from x1.localdomain ([2620:10d:c090:180::be7a])
        by smtp.gmail.com with ESMTPSA id i123sm16565458pfe.145.2019.11.15.17.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 17:53:24 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     asml.silence@gmail.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/8] io_uring: make POLL_ADD/POLL_REMOVE scale better
Date:   Fri, 15 Nov 2019 18:53:08 -0700
Message-Id: <20191116015314.24276-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191116015314.24276-1-axboe@kernel.dk>
References: <20191116015314.24276-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

One of the obvious use cases for these commands is networking, where
it's not uncommon to have tons of sockets open and polled for. The
current implementation uses a list for insertion and lookup, which works
fine for file based use cases where the count is usually low, it breaks
down somewhat for higher number of files / sockets. A test case with
30k sockets being polled for and cancelled takes:

real    0m6.968s
user    0m0.002s
sys     0m6.936s

with the patch it takes:

real    0m0.233s
user    0m0.010s
sys     0m0.176s

If you go to 50k sockets, it gets even more abysmal with the current
code:

real    0m40.602s
user    0m0.010s
sys     0m40.555s

with the patch it takes:

real    0m0.398s
user    0m0.000s
sys     0m0.341s

Change is pretty straight forward, just replace the cancel_list with
a red/black tree instead.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 69 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 54 insertions(+), 15 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 55f8b1d378df..5ad652fa24b8 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -271,7 +271,7 @@ struct io_ring_ctx {
 		 * manipulate the list, hence no extra locking is needed there.
 		 */
 		struct list_head	poll_list;
-		struct list_head	cancel_list;
+		struct rb_root		cancel_tree;
 
 		spinlock_t		inflight_lock;
 		struct list_head	inflight_list;
@@ -323,7 +323,10 @@ struct io_kiocb {
 	struct sqe_submit	submit;
 
 	struct io_ring_ctx	*ctx;
-	struct list_head	list;
+	union {
+		struct list_head	list;
+		struct rb_node		rb_node;
+	};
 	struct list_head	link_list;
 	unsigned int		flags;
 	refcount_t		refs;
@@ -433,7 +436,7 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 	init_waitqueue_head(&ctx->wait);
 	spin_lock_init(&ctx->completion_lock);
 	INIT_LIST_HEAD(&ctx->poll_list);
-	INIT_LIST_HEAD(&ctx->cancel_list);
+	ctx->cancel_tree = RB_ROOT;
 	INIT_LIST_HEAD(&ctx->defer_list);
 	INIT_LIST_HEAD(&ctx->timeout_list);
 	init_waitqueue_head(&ctx->inflight_wait);
@@ -1934,6 +1937,14 @@ static int io_accept(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 #endif
 }
 
+static inline void io_poll_remove_req(struct io_kiocb *req)
+{
+	if (!RB_EMPTY_NODE(&req->rb_node)) {
+		rb_erase(&req->rb_node, &req->ctx->cancel_tree);
+		RB_CLEAR_NODE(&req->rb_node);
+	}
+}
+
 static void io_poll_remove_one(struct io_kiocb *req)
 {
 	struct io_poll_iocb *poll = &req->poll;
@@ -1945,17 +1956,17 @@ static void io_poll_remove_one(struct io_kiocb *req)
 		io_queue_async_work(req);
 	}
 	spin_unlock(&poll->head->lock);
-
-	list_del_init(&req->list);
+	io_poll_remove_req(req);
 }
 
 static void io_poll_remove_all(struct io_ring_ctx *ctx)
 {
+	struct rb_node *node;
 	struct io_kiocb *req;
 
 	spin_lock_irq(&ctx->completion_lock);
-	while (!list_empty(&ctx->cancel_list)) {
-		req = list_first_entry(&ctx->cancel_list, struct io_kiocb,list);
+	while ((node = rb_first(&ctx->cancel_tree)) != NULL) {
+		req = rb_entry(node, struct io_kiocb, rb_node);
 		io_poll_remove_one(req);
 	}
 	spin_unlock_irq(&ctx->completion_lock);
@@ -1963,13 +1974,21 @@ static void io_poll_remove_all(struct io_ring_ctx *ctx)
 
 static int io_poll_cancel(struct io_ring_ctx *ctx, __u64 sqe_addr)
 {
+	struct rb_node *p, *parent = NULL;
 	struct io_kiocb *req;
 
-	list_for_each_entry(req, &ctx->cancel_list, list) {
-		if (req->user_data != sqe_addr)
-			continue;
-		io_poll_remove_one(req);
-		return 0;
+	p = ctx->cancel_tree.rb_node;
+	while (p) {
+		parent = p;
+		req = rb_entry(parent, struct io_kiocb, rb_node);
+		if (sqe_addr < req->user_data) {
+			p = p->rb_left;
+		} else if (sqe_addr > req->user_data) {
+			p = p->rb_right;
+		} else {
+			io_poll_remove_one(req);
+			return 0;
+		}
 	}
 
 	return -ENOENT;
@@ -2039,7 +2058,7 @@ static void io_poll_complete_work(struct io_wq_work **workptr)
 		spin_unlock_irq(&ctx->completion_lock);
 		return;
 	}
-	list_del_init(&req->list);
+	io_poll_remove_req(req);
 	io_poll_complete(req, mask);
 	spin_unlock_irq(&ctx->completion_lock);
 
@@ -2073,7 +2092,7 @@ static int io_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 	 * for finalizing the request, mark us as having grabbed that already.
 	 */
 	if (mask && spin_trylock_irqsave(&ctx->completion_lock, flags)) {
-		list_del(&req->list);
+		io_poll_remove_req(req);
 		io_poll_complete(req, mask);
 		req->flags |= REQ_F_COMP_LOCKED;
 		io_put_req(req);
@@ -2108,6 +2127,25 @@ static void io_poll_queue_proc(struct file *file, struct wait_queue_head *head,
 	add_wait_queue(head, &pt->req->poll.wait);
 }
 
+static void io_poll_req_insert(struct io_kiocb *req)
+{
+	struct io_ring_ctx *ctx = req->ctx;
+	struct rb_node **p = &ctx->cancel_tree.rb_node;
+	struct rb_node *parent = NULL;
+	struct io_kiocb *tmp;
+
+	while (*p) {
+		parent = *p;
+		tmp = rb_entry(parent, struct io_kiocb, rb_node);
+		if (req->user_data < tmp->user_data)
+			p = &(*p)->rb_left;
+		else
+			p = &(*p)->rb_right;
+	}
+	rb_link_node(&req->rb_node, parent, p);
+	rb_insert_color(&req->rb_node, &ctx->cancel_tree);
+}
+
 static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 		       struct io_kiocb **nxt)
 {
@@ -2129,6 +2167,7 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	INIT_IO_WORK(&req->work, io_poll_complete_work);
 	events = READ_ONCE(sqe->poll_events);
 	poll->events = demangle_poll(events) | EPOLLERR | EPOLLHUP;
+	RB_CLEAR_NODE(&req->rb_node);
 
 	poll->head = NULL;
 	poll->done = false;
@@ -2161,7 +2200,7 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 		else if (cancel)
 			WRITE_ONCE(poll->canceled, true);
 		else if (!poll->done) /* actually waiting for an event */
-			list_add_tail(&req->list, &ctx->cancel_list);
+			io_poll_req_insert(req);
 		spin_unlock(&poll->head->lock);
 	}
 	if (mask) { /* no async, we'd stolen it */
-- 
2.24.0

