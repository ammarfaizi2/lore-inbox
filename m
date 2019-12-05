Return-Path: <SRS0=lMt9=Z3=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE127C43603
	for <io-uring@archiver.kernel.org>; Thu,  5 Dec 2019 02:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5573206DB
	for <io-uring@archiver.kernel.org>; Thu,  5 Dec 2019 02:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="M04wZtdH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfLEC5l (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 4 Dec 2019 21:57:41 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43472 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728321AbfLEC5l (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 4 Dec 2019 21:57:41 -0500
Received: by mail-pg1-f194.google.com with SMTP id b1so848833pgq.10
        for <io-uring@vger.kernel.org>; Wed, 04 Dec 2019 18:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=QxXDC0z2UnG65oKwdYyiymDGJaAvzsnfx3LMOi21csk=;
        b=M04wZtdHjf4BUtWuW4jWhye6uJe6BbbZ6lRuFixSLVF8LXj4xOrheSNwqZ8rcqYB6Y
         3qY8yDI8HatdS3xrNomX+aLhMN29JD2jwU2Ad+ks6YtlKTo7fneSQ39/bMG4CulBNb7m
         QPX1ZQjD55mAQCcIeXW9E3qjw6yCMBhSAzMQeiXbFKyWlZshPZ6s55IyPIBThZ/fbbWt
         YAib+iXPwS/HE6n8nzgp4spxocYWQWfbosuC96zIrQVSt/b0Y3fFNBoyCPO5n4L+OycA
         TEIoep0K85yGx0p+k1KX5i0p2kSeOAXs2vVyRgPuuHmIGL5sDojbFAPzBzkNb/23ccw9
         P+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=QxXDC0z2UnG65oKwdYyiymDGJaAvzsnfx3LMOi21csk=;
        b=chnfUOnsgeP0GLnOyP/TPwCmM9Vd1hwFzb90eQsDyHkdKkhjpen/OwDrI7OT7P4SAd
         VdB7MsB35EYoz5HC1RBwSuj/Y6UKxiwF0rF4OB8F3BnsudekY2QMR/Ek7/4W7K5r1pNP
         cB3st9AKId2IN28pYfIkGwAg54a3wePBuAwk0iDB1xhx1mfAUP/Hh5H+8saODfVnlh9I
         YxDGMlvEV23c9PhS8lW0wFNwVAzo5SHE0ZjnY0nBhytMKDbHOjlNFhtAHCIsvIdF40GO
         75Mb35Y3UeeMP18FfPHDIcvyY3dZWt81XVywpu0gHbRrEIlT2KoWATjQrZY8u4b8r6d6
         f4PA==
X-Gm-Message-State: APjAAAWlUo68gUWsztjDH/uJ0iF3XFIBLvXAw//Fvo0Ok7lbfzjuIvEb
        ER2+hHQrd50gjUUQAtVDVauVxnmU2P0=
X-Google-Smtp-Source: APXvYqyE0Svb3DhME9iBkOAcVIxQcElflYaceFbhvd8/M4FvZnd+AhiRi/Ox25XGLZ0QT4t0ruGUfA==
X-Received: by 2002:a63:2151:: with SMTP id s17mr7048076pgm.46.1575514659973;
        Wed, 04 Dec 2019 18:57:39 -0800 (PST)
Received: from ?IPv6:2620:10d:c081:1131::1567? ([2620:10d:c090:180::8b9a])
        by smtp.gmail.com with ESMTPSA id s18sm10043008pfs.20.2019.12.04.18.57.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2019 18:57:38 -0800 (PST)
To:     io-uring <io-uring@vger.kernel.org>
Cc:     Dan Melnic <dmm@fb.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: use hash table for poll command lookups
Message-ID: <3e27eacf-4501-6396-79c4-ce3ee83e98db@kernel.dk>
Date:   Wed, 4 Dec 2019 19:57:37 -0700
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

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 2efe1ac7352a..4fd4cf9c6261 100644
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
+	if (hash_bits < 0)
+		hash_bits = 0;
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

