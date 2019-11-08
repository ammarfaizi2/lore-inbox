Return-Path: <SRS0=cPsQ=ZA=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60434FC6196
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 21:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277A62084D
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 21:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="W6OVnaQK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbfKHVZ5 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 8 Nov 2019 16:25:57 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:37412 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfKHVZ4 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 8 Nov 2019 16:25:56 -0500
Received: by mail-il1-f196.google.com with SMTP id s5so6396675iln.4
        for <io-uring@vger.kernel.org>; Fri, 08 Nov 2019 13:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=0RqcD68H19QHmYElnGHGoV4jdO2YAtut6cOovNvgsWY=;
        b=W6OVnaQKv7Jyw7w53wSj2yUKG8gJ6OcCTY5BcNaHo5GjTht6cuu3BP+o7eFOR8cooZ
         SssN69PPfg/fsKLCDBVWmMVkf6bDTcl6bdgqH6y37ZHt9YxfbIC+VAFVztbFYTpoTZ8j
         xBXfWkN2BM44M1aVoZ0qtptOZw0FsC+G1ALCgVumLlyDiA2lzqM4oMdSN7+E17ICVoSW
         s5A/BbbgyJiWSFlGzJkUiX8wse9QrrQjGueNQolwy/mgmSpCS+7wyGetrlnRp4ieGaOJ
         xUdR7BCbJQ2mFy2YHXDBy756aTpSQCJq7TVvfUTB5sv0RwO9lnQ7gPYzL/V0rdwHmEZA
         sK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=0RqcD68H19QHmYElnGHGoV4jdO2YAtut6cOovNvgsWY=;
        b=erFpjL4WdfgSCMb2njgraabGhQKzpuKCOa6jBy+EyP83owJBFzgM+NWbFqlTU0kDbH
         PcgaKsnqSc5sZEB7NPMBwtSYu/nn0rRqeSmGJ+78eJPSGKM+jCCkJoDbuqhCRonIuLgI
         PeSWDuBP34GoLke2aFaQYgmDA7fJPyeqSFSrXXctVW5UioRoUPp0O32ASxYlSw+qn8et
         2knw6LGrW5yh8wtbGsB4iwjRHkMAyEX41BB16QItE5NKzivH+qxSZmM6ST9j+e0sy22T
         m84IlFPcEUJzhUXzkhCfp6sxEgAcvwgyKPG65lODnynzpYhg6uP2kBZcBGXxLVx8ic+8
         KL9w==
X-Gm-Message-State: APjAAAW5uJjjPQuOotviKKfpOI2LBDwZAx9gShyyBOjiHr1m6S+8+a/r
        xWXVOFntO/jHzJBfoJ1sfFbzkZ9tKUY=
X-Google-Smtp-Source: APXvYqyJgrQu25L22L6kKrMfkqtLV8GEGVcaJ0jsoXd70UcwuCvciRcL11XAyL5bO16aDjXoVz6Aow==
X-Received: by 2002:a92:7308:: with SMTP id o8mr16422510ilc.102.1573248353199;
        Fri, 08 Nov 2019 13:25:53 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id d8sm569578ioq.84.2019.11.08.13.25.51
        for <io-uring@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 13:25:51 -0800 (PST)
To:     io-uring@vger.kernel.org
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2] io_uring: provide fallback request for OOM situations
Message-ID: <55798841-7303-525c-fe38-c3fb4fc47a65@kernel.dk>
Date:   Fri, 8 Nov 2019 14:25:50 -0700
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

One thing that really sucks for userspace APIs is if the kernel passes
back -ENOMEM/-EAGAIN for resource shortages. The application really has
no idea of what to do in those cases. Should it try and reap
completions? Probably a good idea. Will it solve the issue? Who knows.

This patch adds a simple fallback mechanism if we fail to allocate
memory for a request. If we fail allocating memory from the slab for a
request, we punt to a pre-allocated request. There's just one of these
per io_ring_ctx, but the important part is if we ever return -EBUSY to
the application, the applications knows that it can wait for events and
make forward progress when events have completed. This is the important
part.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

Changes since v1:
- Get rid of the GFP_ATOMIC fallback, just provide the fallback. That
  should be plenty, and we probably don't want to dip into the atomic
  pool if GFP_KERNEL failed.

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 1e4c1b7eac6e..81457913e9c9 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -238,6 +238,9 @@ struct io_ring_ctx {
 	/* 0 is for ctx quiesce/reinit/free, 1 is for sqo_thread started */
 	struct completion	*completions;
 
+	/* if all else fails... */
+	struct io_kiocb		*fallback_req;
+
 #if defined(CONFIG_UNIX)
 	struct socket		*ring_sock;
 #endif
@@ -407,6 +410,10 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 	if (!ctx)
 		return NULL;
 
+	ctx->fallback_req = kmem_cache_alloc(req_cachep, GFP_KERNEL);
+	if (!ctx->fallback_req)
+		goto err;
+
 	ctx->completions = kmalloc(2 * sizeof(struct completion), GFP_KERNEL);
 	if (!ctx->completions)
 		goto err;
@@ -432,6 +439,8 @@ static struct io_ring_ctx *io_ring_ctx_alloc(struct io_uring_params *p)
 	INIT_LIST_HEAD(&ctx->inflight_list);
 	return ctx;
 err:
+	if (ctx->fallback_req)
+		kmem_cache_free(req_cachep, ctx->fallback_req);
 	kfree(ctx->completions);
 	kfree(ctx);
 	return NULL;
@@ -711,6 +720,23 @@ static void io_cqring_add_event(struct io_kiocb *req, long res)
 	io_cqring_ev_posted(ctx);
 }
 
+static inline bool io_is_fallback_req(struct io_kiocb *req)
+{
+	return req == (struct io_kiocb *)
+			((unsigned long) req->ctx->fallback_req & ~1UL);
+}
+
+static struct io_kiocb *io_get_fallback_req(struct io_ring_ctx *ctx)
+{
+	struct io_kiocb *req;
+
+	req = ctx->fallback_req;
+	if (!test_and_set_bit_lock(0, (unsigned long *) ctx->fallback_req))
+		return req;
+
+	return NULL;
+}
+
 static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 				   struct io_submit_state *state)
 {
@@ -723,7 +749,7 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 	if (!state) {
 		req = kmem_cache_alloc(req_cachep, gfp);
 		if (unlikely(!req))
-			goto out;
+			goto fallback;
 	} else if (!state->free_reqs) {
 		size_t sz;
 		int ret;
@@ -738,7 +764,7 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 		if (unlikely(ret <= 0)) {
 			state->reqs[0] = kmem_cache_alloc(req_cachep, gfp);
 			if (!state->reqs[0])
-				goto out;
+				goto fallback;
 			ret = 1;
 		}
 		state->free_reqs = ret - 1;
@@ -750,6 +776,7 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 		state->cur_req++;
 	}
 
+got_it:
 	req->file = NULL;
 	req->ctx = ctx;
 	req->flags = 0;
@@ -758,7 +785,10 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 	req->result = 0;
 	INIT_IO_WORK(&req->work, io_wq_submit_work);
 	return req;
-out:
+fallback:
+	req = io_get_fallback_req(ctx);
+	if (req)
+		goto got_it;
 	percpu_ref_put(&ctx->refs);
 	return NULL;
 }
@@ -788,7 +818,10 @@ static void __io_free_req(struct io_kiocb *req)
 		spin_unlock_irqrestore(&ctx->inflight_lock, flags);
 	}
 	percpu_ref_put(&ctx->refs);
-	kmem_cache_free(req_cachep, req);
+	if (likely(!io_is_fallback_req(req)))
+		kmem_cache_free(req_cachep, req);
+	else
+		clear_bit_unlock(0, (unsigned long *) ctx->fallback_req);
 }
 
 static bool io_link_cancel_timeout(struct io_kiocb *req)
@@ -1000,8 +1033,8 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
 			 * completions for those, only batch free for fixed
 			 * file and non-linked commands.
 			 */
-			if ((req->flags & (REQ_F_FIXED_FILE|REQ_F_LINK)) ==
-			    REQ_F_FIXED_FILE) {
+			if (((req->flags & (REQ_F_FIXED_FILE|REQ_F_LINK)) ==
+			    REQ_F_FIXED_FILE) && !io_is_fallback_req(req)) {
 				reqs[to_free++] = req;
 				if (to_free == ARRAY_SIZE(reqs))
 					io_free_req_many(ctx, reqs, &to_free);
@@ -4119,6 +4152,7 @@ static void io_ring_ctx_free(struct io_ring_ctx *ctx)
 				ring_pages(ctx->sq_entries, ctx->cq_entries));
 	free_uid(ctx->user);
 	kfree(ctx->completions);
+	kmem_cache_free(req_cachep, ctx->fallback_req);
 	kfree(ctx);
 }
 
-- 
Jens Axboe

