Return-Path: <SRS0=lMt9=Z3=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2D8C43603
	for <io-uring@archiver.kernel.org>; Thu,  5 Dec 2019 03:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5496220661
	for <io-uring@archiver.kernel.org>; Thu,  5 Dec 2019 03:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="R1EyHNvV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbfLEDQV (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 4 Dec 2019 22:16:21 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40967 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbfLEDQU (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 4 Dec 2019 22:16:20 -0500
Received: by mail-pl1-f196.google.com with SMTP id bd4so607722plb.8
        for <io-uring@vger.kernel.org>; Wed, 04 Dec 2019 19:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=5HunQsowSWeWG/dAZWUcppDkNIXMut/ob1XzEtAUNbQ=;
        b=R1EyHNvVNKIprLPzFs/39vHiIGs44XUj2MA1Zpt8NZohP1mnU8l2X1X8tn0qcUO7VS
         +jk25na2ODKzQp8OZyT6Q3pDcKvOf1k79XjaydyhmHam+6veBDvfvNhcCnkdFnYa5prQ
         ZVLec6YZuV0hUUmm6tnZetzBD7CDVbiaDgHhZrT/BjqQs3/N+nXGogZMrL/N0vDhU0y+
         3fNp9SZV17Xsg9NXHvepwZM8jXtzGqSfVtPs6Ft1jbc2w2iOIfB/8JX+Ofq5umBR9GRa
         IQos6jiS96Bm0RRIFj4F5tjjQ86L3HO0zHnlXH9y0nFM5kyFaOp6yuHZWYGSqBOhv7fT
         L8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=5HunQsowSWeWG/dAZWUcppDkNIXMut/ob1XzEtAUNbQ=;
        b=MEtZQv6swENr/gtJL8Wd1WxJcyHjz/cSi0EU5KtoGjaMz0S+WMdXS+HqX1yYurqYYg
         pagRM7WZXLURRGBx1jti0dG8oHAL8ceFv34Q5s41TCxnnuW8QG4RRmnS1w3te/JiN87j
         ZtLFclcRsoBIixKdQx/ge3fTgP1IdcACNIaHaEpVwt1NP9CiIe4EdZMGL9+3ybIv3uOO
         xfgkQx74TBfOHqJwuZ2sJSL5yxcH+1c0QNDOsdem6bUii0wHH0UmyZsa/ganGDvQ3mNj
         R2DjhZf/VJV0C81vIp7ES9wrqhceDGs1SYhDly80DkCMB1keCdtbl/F7S6VIo4gmU1Rb
         3ZQg==
X-Gm-Message-State: APjAAAU4ZtLEDfG6Wd+3QCOLDd3wkpCyIees4UxOiwg2biz/7fKPri3m
        0gxQXG5Szzdii6fnz68Asz/dsQ==
X-Google-Smtp-Source: APXvYqwLEl7DgeChhlVsXloJTjMxCw4N5tNQYHHNPh7fd6GIGksXatiBjTIHv8pO1shYFyJ7YL6unA==
X-Received: by 2002:a17:90a:19d1:: with SMTP id 17mr6875178pjj.52.1575515778627;
        Wed, 04 Dec 2019 19:16:18 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1130::1153? ([2620:10d:c090:180::6ce3])
        by smtp.gmail.com with ESMTPSA id h7sm9412288pfn.43.2019.12.04.19.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2019 19:16:17 -0800 (PST)
To:     io-uring <io-uring@vger.kernel.org>, Dan Melnic <dmm@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2] io_uring: use hash table for poll command lookups
Message-ID: <b50c3e32-5805-6dea-4adf-b8e79f3efaf7@kernel.dk>
Date:   Wed, 4 Dec 2019 20:16:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

We recently changed this from a single list to an rbtree, but for some
real life workloads, the rbtree slows down the submission/insertion
case enough so that it's the top cycle consumer on the io_uring side.
In testing, using a hash table is a more well rounded compromise. It
is fast for insertion, and as long as it's sized appropriately, it
works well for the cancellation case as well. Running TAO with a lot
of network sockets, this removes io_poll_req_insert() from spending
2% of the CPU cycles.

Reported-by: Dan Melnic <dmm@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

V2:
Didn't test the 0 edge case, liburing regression tests found that.
Make sure we use at least one bit.

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 2efe1ac7352a..8fa6b190a238 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -275,7 +275,8 @@ struct io_ring_ctx {
 		 * manipulate the list, hence no extra locking is needed there.
 		 */
 		struct list_head	poll_list;
-		struct rb_root		cancel_tree;
+		struct hlist_head	*cancel_hash;
+		unsigned		cancel_hash_bits;
 
 		spinlock_t		inflight_lock;
 		struct list_head	inflight_list;
@@ -355,7 +356,7 @@ struct io_kiocb {
 	struct io_ring_ctx	*ctx;
 	union {
 		struct list_head	list;
-		struct rb_node		rb_node;
+		struct hlist_node	hash_node;
 	};
 	struct list_head	link_list;
 	unsigned int		flags;
@@ -444,6 +445,7 @@ static void io_ring_ctx_ref_free(struct percpu_ref *ref)
 static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 {
 	struct io_ring_ctx *ctx;
+	int hash_bits;
 
 	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
@@ -457,6 +459,21 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 	if (!ctx->completions)
 		goto err;
 
+	/*
+	 * Use 5 bits less than the max cq entries, that should give us around
+	 * 32 entries per hash list if totally full and uniformly spread.
+	 */
+	hash_bits = ilog2(p->cq_entries);
+	hash_bits -= 5;
+	if (hash_bits <= 0)
+		hash_bits = 1;
+	ctx->cancel_hash_bits = hash_bits;
+	ctx->cancel_hash = kmalloc((1U << hash_bits) * sizeof(struct hlist_head),
+					GFP_KERNEL);
+	if (!ctx->cancel_hash)
+		goto err;
+	__hash_init(ctx->cancel_hash, 1U << hash_bits);
+
 	if (percpu_ref_init(&ctx->refs, io_ring_ctx_ref_free,
 			    PERCPU_REF_ALLOW_REINIT, GFP_KERNEL))
 		goto err;
@@ -470,7 +487,6 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 	init_waitqueue_head(&ctx->wait);
 	spin_lock_init(&ctx->completion_lock);
 	INIT_LIST_HEAD(&ctx->poll_list);
-	ctx->cancel_tree = RB_ROOT;
 	INIT_LIST_HEAD(&ctx->defer_list);
 	INIT_LIST_HEAD(&ctx->timeout_list);
 	init_waitqueue_head(&ctx->inflight_wait);
@@ -481,6 +497,7 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 	if (ctx->fallback_req)
 		kmem_cache_free(req_cachep, ctx->fallback_req);
 	kfree(ctx->completions);
+	kfree(ctx->cancel_hash);
 	kfree(ctx);
 	return NULL;
 }
@@ -2260,14 +2277,6 @@ static int io_connect(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 #endif
 }
 
-static inline void io_poll_remove_req(struct io_kiocb *req)
-{
-	if (!RB_EMPTY_NODE(&req->rb_node)) {
-		rb_erase(&req->rb_node, &req->ctx->cancel_tree);
-		RB_CLEAR_NODE(&req->rb_node);
-	}
-}
-
 static void io_poll_remove_one(struct io_kiocb *req)
 {
 	struct io_poll_iocb *poll = &req->poll;
@@ -2279,36 +2288,34 @@ static void io_poll_remove_one(struct io_kiocb *req)
 		io_queue_async_work(req);
 	}
 	spin_unlock(&poll->head->lock);
-	io_poll_remove_req(req);
+	hash_del(&req->hash_node);
 }
 
 static void io_poll_remove_all(struct io_ring_ctx *ctx)
 {
-	struct rb_node *node;
+	struct hlist_node *tmp;
 	struct io_kiocb *req;
+	int i;
 
 	spin_lock_irq(&ctx->completion_lock);
-	while ((node = rb_first(&ctx->cancel_tree)) != NULL) {
-		req = rb_entry(node, struct io_kiocb, rb_node);
-		io_poll_remove_one(req);
+	for (i = 0; i < (1U << ctx->cancel_hash_bits); i++) {
+		struct hlist_head *list;
+
+		list = &ctx->cancel_hash[i];
+		hlist_for_each_entry_safe(req, tmp, list, hash_node)
+			io_poll_remove_one(req);
 	}
 	spin_unlock_irq(&ctx->completion_lock);
 }
 
 static int io_poll_cancel(struct io_ring_ctx *ctx, __u64 sqe_addr)
 {
-	struct rb_node *p, *parent = NULL;
+	struct hlist_head *list;
 	struct io_kiocb *req;
 
-	p = ctx->cancel_tree.rb_node;
-	while (p) {
-		parent = p;
-		req = rb_entry(parent, struct io_kiocb, rb_node);
-		if (sqe_addr < req->user_data) {
-			p = p->rb_left;
-		} else if (sqe_addr > req->user_data) {
-			p = p->rb_right;
-		} else {
+	list = &ctx->cancel_hash[hash_long(sqe_addr, ctx->cancel_hash_bits)];
+	hlist_for_each_entry(req, list, hash_node) {
+		if (sqe_addr == req->user_data) {
 			io_poll_remove_one(req);
 			return 0;
 		}
@@ -2390,7 +2397,7 @@ static void io_poll_complete_work(struct io_wq_work **workptr)
 		spin_unlock_irq(&ctx->completion_lock);
 		return;
 	}
-	io_poll_remove_req(req);
+	hash_del(&req->hash_node);
 	io_poll_complete(req, mask, ret);
 	spin_unlock_irq(&ctx->completion_lock);
 
@@ -2425,7 +2432,7 @@ static int io_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 	 * for finalizing the request, mark us as having grabbed that already.
 	 */
 	if (mask && spin_trylock_irqsave(&ctx->completion_lock, flags)) {
-		io_poll_remove_req(req);
+		hash_del(&req->hash_node);
 		io_poll_complete(req, mask, 0);
 		req->flags |= REQ_F_COMP_LOCKED;
 		io_put_req(req);
@@ -2463,20 +2470,10 @@ static void io_poll_queue_proc(struct file *file, struct wait_queue_head *head,
 static void io_poll_req_insert(struct io_kiocb *req)
 {
 	struct io_ring_ctx *ctx = req->ctx;
-	struct rb_node **p = &ctx->cancel_tree.rb_node;
-	struct rb_node *parent = NULL;
-	struct io_kiocb *tmp;
-
-	while (*p) {
-		parent = *p;
-		tmp = rb_entry(parent, struct io_kiocb, rb_node);
-		if (req->user_data < tmp->user_data)
-			p = &(*p)->rb_left;
-		else
-			p = &(*p)->rb_right;
-	}
-	rb_link_node(&req->rb_node, parent, p);
-	rb_insert_color(&req->rb_node, &ctx->cancel_tree);
+	struct hlist_head *list;
+
+	list = &ctx->cancel_hash[hash_long(req->user_data, ctx->cancel_hash_bits)];
+	hlist_add_head(&req->hash_node, list);
 }
 
 static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe,
@@ -2504,7 +2501,7 @@ static int io_poll_add(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	INIT_IO_WORK(&req->work, io_poll_complete_work);
 	events = READ_ONCE(sqe->poll_events);
 	poll->events = demangle_poll(events) | EPOLLERR | EPOLLHUP;
-	RB_CLEAR_NODE(&req->rb_node);
+	INIT_HLIST_NODE(&req->hash_node);
 
 	poll->head = NULL;
 	poll->done = false;
@@ -4644,6 +4641,7 @@ static void io_ring_ctx_free(struct io_ring_ctx *ctx)
 	free_uid(ctx->user);
 	put_cred(ctx->creds);
 	kfree(ctx->completions);
+	kfree(ctx->cancel_hash);
 	kmem_cache_free(req_cachep, ctx->fallback_req);
 	kfree(ctx);
 }

-- 
Jens Axboe

