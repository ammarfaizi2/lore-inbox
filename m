Return-Path: <SRS0=nqv2=Y7=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2086BC43331
	for <io-uring@archiver.kernel.org>; Thu,  7 Nov 2019 20:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D839F2084D
	for <io-uring@archiver.kernel.org>; Thu,  7 Nov 2019 20:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="e8hkYhc4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725823AbfKGUXn (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 7 Nov 2019 15:23:43 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:43126 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfKGUXn (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 7 Nov 2019 15:23:43 -0500
Received: by mail-io1-f67.google.com with SMTP id c11so3750798iom.10
        for <io-uring@vger.kernel.org>; Thu, 07 Nov 2019 12:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=QkrqYzMkY7OxMGyzHP1y16af2vTH3WmC68pleB+phqw=;
        b=e8hkYhc4OkbLQ/chDnJ0BYKLfI1TZ+HeiDq7A8r69706VXcgz8VoPFTmrtqrQC+3td
         RDTtqEj7e3yQK1kTOfbHuOWmF4mT3tR21cpnBVWG3nCBXeHeaQJ5SL1lk9cFtJyh0Wi1
         1mP0WgYTTt2kfWAjUGRq11+VRuKhTp7DpojJ4aZQPwqd8jkIxgy2N9pxXq55tMUebMG6
         4guwCVWOeueR+XzHRqt3qjGuxv7PgjP16HJbJGYc7wew0BZYUuizxNRYP2xrAwVeADem
         MR2tjpaV3IfcJCZBuPXF6CQIm1zZTutg62XNahXyHr8UcSwFjdjXcHloaqG7aEqWG3S7
         l6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=QkrqYzMkY7OxMGyzHP1y16af2vTH3WmC68pleB+phqw=;
        b=WPsBL2T6tg0++93/jCKy57i1L7yHzEgR4xDNen0QOrgPCwr9mu9SjxQAo9lKHomoim
         9RXMSz44cNbode+XPI+5Ij+TO685HQIciFlKX/i17dSOg9tqcXK0wqqLKYnFHyc1OugU
         eNJbXWgoTF2vvuOFw7imeGUf/DE7vNBwNkbzVJfIAILqFg+NHkf/sqa2PwWO60mA0weQ
         nPNccHqEqI4sQ1O/yTCTCtML26T93/9glP7uaU+n7WNAbLWn+BE9Bqt54c4Lvn9L2E++
         RXRG5fQPhmuzsZlVHFq4JvALjfagKmbdzas0cYnyfCi0lfhB3Cd1vlPXljVk4EnItztV
         kXmg==
X-Gm-Message-State: APjAAAVtCDFDMTtHK15uBrCmxF6MMCJMnsRw/VFDF4GksvD5s0AxT6PX
        2cST3VADeevghDqCDd28ZGMwazzyuNM=
X-Google-Smtp-Source: APXvYqyCyODaYuTe+x+NOyKV2gT/iVUFUQSIVLAY9m6ndmr1T7QAyMXveJlipu8f6p8bsbxwcRhvVA==
X-Received: by 2002:a02:7158:: with SMTP id n24mr6462219jaf.127.1573158221495;
        Thu, 07 Nov 2019 12:23:41 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id b7sm283465ioq.9.2019.11.07.12.23.39
        for <io-uring@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 12:23:40 -0800 (PST)
To:     io-uring@vger.kernel.org
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: reduce/pack size of io_ring_ctx
Message-ID: <1031c163-abd1-f42c-370d-8801f5fd2440@kernel.dk>
Date:   Thu, 7 Nov 2019 13:23:39 -0700
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

With the recent flurry of additions and changes to io_uring, the
layout of io_ring_ctx has become a bit stale. We're right now at
704 bytes in size on my x86-64 build, or 11 cachelines. This
patch does two things:

- We have to completion structs embedded, that we only use for
  quiesce of the ctx (or shutdown) and for sqthread init cases.
  That 2x32 bytes right there, let's dynamically allocate them.

- Reorder the struct a bit with an eye on cachelines, use cases,
  and holes.

With this patch, we're down to 512 bytes, or 8 cachelines.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

--

diff --git a/fs/io_uring.c b/fs/io_uring.c
index f8344f95817e..2dbc108fa27b 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -212,25 +212,14 @@ struct io_ring_ctx {
 		wait_queue_head_t	inflight_wait;
 	} ____cacheline_aligned_in_smp;
 
+	struct io_rings	*rings;
+
 	/* IO offload */
 	struct io_wq		*io_wq;
 	struct task_struct	*sqo_thread;	/* if using sq thread polling */
 	struct mm_struct	*sqo_mm;
 	wait_queue_head_t	sqo_wait;
-	struct completion	sqo_thread_started;
-
-	struct {
-		unsigned		cached_cq_tail;
-		atomic_t		cached_cq_overflow;
-		unsigned		cq_entries;
-		unsigned		cq_mask;
-		struct wait_queue_head	cq_wait;
-		struct fasync_struct	*cq_fasync;
-		struct eventfd_ctx	*cq_ev_fd;
-		atomic_t		cq_timeouts;
-	} ____cacheline_aligned_in_smp;
-
-	struct io_rings	*rings;
+	struct completion	*sqo_done;
 
 	/*
 	 * If used, fixed file set. Writers must ensure that ->refs is dead,
@@ -246,7 +235,22 @@ struct io_ring_ctx {
 
 	struct user_struct	*user;
 
-	struct completion	ctx_done;
+	struct completion	*ctx_done;
+
+#if defined(CONFIG_UNIX)
+	struct socket		*ring_sock;
+#endif
+
+	struct {
+		unsigned		cached_cq_tail;
+		atomic_t		cached_cq_overflow;
+		unsigned		cq_entries;
+		unsigned		cq_mask;
+		struct wait_queue_head	cq_wait;
+		struct fasync_struct	*cq_fasync;
+		struct eventfd_ctx	*cq_ev_fd;
+		atomic_t		cq_timeouts;
+	} ____cacheline_aligned_in_smp;
 
 	struct {
 		struct mutex		uring_lock;
@@ -268,10 +272,6 @@ struct io_ring_ctx {
 		spinlock_t		inflight_lock;
 		struct list_head	inflight_list;
 	} ____cacheline_aligned_in_smp;
-
-#if defined(CONFIG_UNIX)
-	struct socket		*ring_sock;
-#endif
 };
 
 struct sqe_submit {
@@ -396,7 +396,7 @@ static void io_ring_ctx_ref_free(struct percpu_ref *ref)
 {
 	struct io_ring_ctx *ctx = container_of(ref, struct io_ring_ctx, refs);
 
-	complete(&ctx->ctx_done);
+	complete(ctx->ctx_done);
 }
 
 static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
@@ -407,17 +407,20 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 	if (!ctx)
 		return NULL;
 
+	ctx->ctx_done = kmalloc(sizeof(struct completion), GFP_KERNEL);
+	ctx->sqo_done = kmalloc(sizeof(struct completion), GFP_KERNEL);
+	if (!ctx->ctx_done || !ctx->sqo_done)
+		goto err;
+
 	if (percpu_ref_init(&ctx->refs, io_ring_ctx_ref_free,
-			    PERCPU_REF_ALLOW_REINIT, GFP_KERNEL)) {
-		kfree(ctx);
-		return NULL;
-	}
+			    PERCPU_REF_ALLOW_REINIT, GFP_KERNEL))
+		goto err;
 
 	ctx->flags = p->flags;
 	init_waitqueue_head(&ctx->cq_wait);
 	INIT_LIST_HEAD(&ctx->cq_overflow_list);
-	init_completion(&ctx->ctx_done);
-	init_completion(&ctx->sqo_thread_started);
+	init_completion(ctx->ctx_done);
+	init_completion(ctx->sqo_done);
 	mutex_init(&ctx->uring_lock);
 	init_waitqueue_head(&ctx->wait);
 	spin_lock_init(&ctx->completion_lock);
@@ -429,6 +432,11 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 	spin_lock_init(&ctx->inflight_lock);
 	INIT_LIST_HEAD(&ctx->inflight_list);
 	return ctx;
+err:
+	kfree(ctx->ctx_done);
+	kfree(ctx->sqo_done);
+	kfree(ctx);
+	return NULL;
 }
 
 static inline bool __io_sequence_defer(struct io_ring_ctx *ctx,
@@ -3037,7 +3045,7 @@ static int io_sq_thread(void *data)
 	unsigned inflight;
 	unsigned long timeout;
 
-	complete(&ctx->sqo_thread_started);
+	complete(ctx->sqo_done);
 
 	old_fs = get_fs();
 	set_fs(USER_DS);
@@ -3276,7 +3284,7 @@ static int io_sqe_files_unregister(struct io_ring_ctx *ctx)
 static void io_sq_thread_stop(struct io_ring_ctx *ctx)
 {
 	if (ctx->sqo_thread) {
-		wait_for_completion(&ctx->sqo_thread_started);
+		wait_for_completion(ctx->sqo_done);
 		/*
 		 * The park is a bit of a work-around, without it we get
 		 * warning spews on shutdown with SQPOLL set and affinity
@@ -4098,6 +4106,8 @@ static void io_ring_ctx_free(struct io_ring_ctx *ctx)
 		io_unaccount_mem(ctx->user,
 				ring_pages(ctx->sq_entries, ctx->cq_entries));
 	free_uid(ctx->user);
+	kfree(ctx->ctx_done);
+	kfree(ctx->sqo_done);
 	kfree(ctx);
 }
 
@@ -4141,7 +4151,7 @@ static void io_ring_ctx_wait_and_kill(struct io_ring_ctx *ctx)
 		io_wq_cancel_all(ctx->io_wq);
 
 	io_iopoll_reap_events(ctx);
-	wait_for_completion(&ctx->ctx_done);
+	wait_for_completion(ctx->ctx_done);
 	io_ring_ctx_free(ctx);
 }
 
@@ -4545,7 +4555,7 @@ static int __io_uring_register(struct io_ring_ctx *ctx, unsigned opcode,
 	 * no new references will come in after we've killed the percpu ref.
 	 */
 	mutex_unlock(&ctx->uring_lock);
-	wait_for_completion(&ctx->ctx_done);
+	wait_for_completion(ctx->ctx_done);
 	mutex_lock(&ctx->uring_lock);
 
 	switch (opcode) {
@@ -4588,7 +4598,7 @@ static int __io_uring_register(struct io_ring_ctx *ctx, unsigned opcode,
 	}
 
 	/* bring the ctx back to life */
-	reinit_completion(&ctx->ctx_done);
+	reinit_completion(ctx->ctx_done);
 	percpu_ref_reinit(&ctx->refs);
 	return ret;
 }

-- 
Jens Axboe

