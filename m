Return-Path: <SRS0=cPsQ=ZA=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0A9FA372C
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 15:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635E72178F
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 15:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tMtlUxMu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfKHPWK (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 8 Nov 2019 10:22:10 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:43494 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfKHPWK (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 8 Nov 2019 10:22:10 -0500
Received: by mail-io1-f66.google.com with SMTP id c11so6724751iom.10
        for <io-uring@vger.kernel.org>; Fri, 08 Nov 2019 07:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=rO3jbOn2jAYsXKAQG2bcZ9mGFdULiZ4r9yGhYOusOBA=;
        b=tMtlUxMuW6FXhHRATUTq4rhgF6o7i31JC6aJNpCV5aqzXy59waGpoOMbYbA0R+kFs6
         5wJf3cCJaWw0MJh3yuegEbkIwKfwJ3j+E2L7AwWyEeJMVpYPrHJyBbPy6LYJ3LjAUbtT
         CzAlsXl+8GM3OxtD3891Qxpyn/ASZzo4uzl7+qZ08VAGhsftR5xF6VR1D37FLEcscsMW
         1kpmY3vY+Fg9AcaUxo6xMZo/4bV5Rk5ij6nDJQPZEh2dshGtCZZTjvNCk0GWP97x6EKh
         xwd4yv1lHvfoN2KSCC+66/uYpz6+mXBHkilZLx1aKINouHeOMzLstGZqes+2pntS3Fjf
         L4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=rO3jbOn2jAYsXKAQG2bcZ9mGFdULiZ4r9yGhYOusOBA=;
        b=l6u0hpGf5sF8wYj7zppg+/FmDg1dLn9UJdhuScm1gTwqiAzx3Lv4XJmZTZH/wBus/e
         XwcwEw3bj0v3ngyfCTPuy0ABhrHsYTDh5aZ+IGQeQP1dvcXG7de1pSvt1jsSLJjtry8I
         V960+sQtSYgHt+UEr+0GtnfZRYCdMFB9HRwk0Fgt4XNlkQNszuDp2PJSsqpixxOeE8th
         KA7Sw3TrT7/XKWesHTlG8gNr7iTj2vIOmRr5qtoIkL1jqtlaYU9PIkEk1moGzlnUSqVd
         AhOHHu660xhesxqvr8IdsKCfllEYbcyOHWcb4hK7QCnqg5f9hyKCLuAM9yI6bB2Cqr5r
         PpfQ==
X-Gm-Message-State: APjAAAXtvf6YAAvLC8iE9x9EmUuHZpJfvc7m4CPvJgHXoFtxgCjOJRKU
        sUHyM2CYAAM/FHIkqtfMQVu66owwASk=
X-Google-Smtp-Source: APXvYqwk33p04En16B6Ri25kgT9lPVGCOQrJ5yPUo7ErycIEQLcmrRlwxDUyZN7ujp18Ina6isoFwA==
X-Received: by 2002:a05:6602:2496:: with SMTP id g22mr10429732ioe.246.1573226528358;
        Fri, 08 Nov 2019 07:22:08 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k4sm512102ion.52.2019.11.08.07.22.06
        for <io-uring@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 07:22:07 -0800 (PST)
To:     io-uring@vger.kernel.org
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: provide fallback request for OOM situations
Message-ID: <5b00b9eb-8189-6aed-d56b-854d7a8bd689@kernel.dk>
Date:   Fri, 8 Nov 2019 08:22:06 -0700
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
memory for a request. We first to to the atomic pool and see if we can
get memory that way, if that fails, we punt to a pre-allocated request.
There's just one of these, but the important part is if we ever return
-EBUSY to the application, the applications knows that it can wait for
events and make forward progress when events have completed. This is the
important part.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 94ec44caac00..fb25cce9d580 100644
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
@@ -732,6 +741,27 @@ static bool io_req_over_limit(struct io_ring_ctx *ctx)
 	return inflight >= limit;
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
+	req = kmem_cache_alloc(req_cachep, GFP_ATOMIC | __GFP_NOWARN);
+	if (req)
+		return req;
+
+	req = ctx->fallback_req;
+	if (!test_and_set_bit_lock(0, (unsigned long *) ctx->fallback_req))
+		return req;
+
+	return NULL;
+}
+
 static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 				   struct io_submit_state *state, bool force)
 {
@@ -742,21 +772,17 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 		return ERR_PTR(-ENXIO);
 
 	if (!state) {
-		if (unlikely(!force && io_req_over_limit(ctx))) {
-			req = ERR_PTR(-EBUSY);
+		if (unlikely(!force && io_req_over_limit(ctx)))
 			goto out_limit;
-		}
 		req = kmem_cache_alloc(req_cachep, gfp);
 		if (unlikely(!req))
-			goto out;
+			goto fallback;
 	} else if (!state->free_reqs) {
 		size_t sz;
 		int ret;
 
-		if (unlikely(!force && io_req_over_limit(ctx))) {
-			req = ERR_PTR(-EBUSY);
+		if (unlikely(!force && io_req_over_limit(ctx)))
 			goto out_limit;
-		}
 		sz = min_t(size_t, state->ios_left, ARRAY_SIZE(state->reqs));
 		ret = kmem_cache_alloc_bulk(req_cachep, gfp, sz, state->reqs);
 
@@ -767,7 +793,7 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 		if (unlikely(ret <= 0)) {
 			state->reqs[0] = kmem_cache_alloc(req_cachep, gfp);
 			if (!state->reqs[0])
-				goto out;
+				goto fallback;
 			ret = 1;
 		}
 		state->free_reqs = ret - 1;
@@ -779,6 +805,7 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 		state->cur_req++;
 	}
 
+got_it:
 	req->file = NULL;
 	req->ctx = ctx;
 	req->flags = 0;
@@ -787,11 +814,13 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 	req->result = 0;
 	INIT_IO_WORK(&req->work, io_wq_submit_work);
 	return req;
-out:
-	req = ERR_PTR(-EAGAIN);
+fallback:
+	req = io_get_fallback_req(ctx);
+	if (req)
+		goto got_it;
 out_limit:
 	percpu_ref_put(&ctx->refs);
-	return req;
+	return ERR_PTR(-EBUSY);
 }
 
 static void io_free_req_many(struct io_ring_ctx *ctx, void **reqs, int *nr)
@@ -819,7 +848,10 @@ static void __io_free_req(struct io_kiocb *req)
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
@@ -1025,8 +1057,8 @@ static void io_iopoll_complete(struct io_ring_ctx *ctx, unsigned int *nr_events,
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
@@ -4143,6 +4175,7 @@ static void io_ring_ctx_free(struct io_ring_ctx *ctx)
 				ring_pages(ctx->sq_entries, ctx->cq_entries));
 	free_uid(ctx->user);
 	kfree(ctx->completions);
+	kmem_cache_free(req_cachep, ctx->fallback_req);
 	kfree(ctx);
 }

-- 
Jens Axboe

