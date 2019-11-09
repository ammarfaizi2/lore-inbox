Return-Path: <SRS0=jnAq=ZB=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F7AC43331
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 21:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6452120869
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 21:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="D7XiLC+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfKIVBd (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 9 Nov 2019 16:01:33 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41343 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfKIVBd (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 9 Nov 2019 16:01:33 -0500
Received: by mail-pf1-f195.google.com with SMTP id p26so7468719pfq.8
        for <io-uring@vger.kernel.org>; Sat, 09 Nov 2019 13:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=/ec+4gG94PY/W3H8aYcWbdH12ExmsmOD/qWx2VKrK/s=;
        b=D7XiLC+FA1Bvqwv6r+fwFBo2b6O6MN3ahklaecH2LhYHdV7SmY8f2TyDqEPGBaWjTu
         RTJT8vWsCHp5SYJcSudThREHqORsFm8ZLmFavypQGbnlQ0+BYzkoEeyI7vo6OcK4nvwD
         GFHrRIfW2nQyttTgroiMHoVo1jQYTKgx+1I/utBiSFtZFmpc+CgnZCwWS8YjwhJEe6Un
         G7uAUGfxbGbnJ00rHhjt77idsZA2rhmwaH9cmmjG2+/dLxhZ/Dyv1WGmMiCv71GzNQEl
         8Lad1HLpuaO5TWfwjIRjd+WrzRnJIA/gAn6zFwng8CTnDH1g73S1A9p/jVpSWgfEQG19
         O2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=/ec+4gG94PY/W3H8aYcWbdH12ExmsmOD/qWx2VKrK/s=;
        b=QNWFMD1SuKZbhVnwa9NM/bU7h5bcsFbOGBluFCzA+cZtmR5LqSQ0lRXUE2OSe6YWmx
         iGRpB+MDsrB8XayM4U7lp3VE7WNWkZLr2BDkiFx5/triAO32ONBvFXLv+oDlKa6ITu5M
         Lv0/xmifNQc/p7qiR4lq9KjKCQSN+jCKiCav+9x0UE75QUN9g6MM4H4EZWvqTpkcOYYs
         rbjkWYa1y48IPoSnSwL36hca8camGxAlpYxHTCtiddkEFdFo3zwE6/3IW1fHGwNKksm3
         +CqSSNOco0NVwNG8k3oMhUhsyucBatR/9paRUfdm6yPxLwwPfbbwIRalyseZQha1lNcR
         UOBg==
X-Gm-Message-State: APjAAAWIl8niGJOwzT6T/vTm4ZIdtaUle7hsrwngZEJ42eK6E32ijXCE
        Ut5Vvu0aP9Kh+yFY3zXP2R8OAcdNqr8=
X-Google-Smtp-Source: APXvYqz6hbtNdRc2e5/+e6AMmCnu1cGLOUTbIGIlipkD9Ovs3Ke+Y+/rq3lEe8xDQVL4s10EMYWMzA==
X-Received: by 2002:a63:7158:: with SMTP id b24mr19976096pgn.153.1573333292189;
        Sat, 09 Nov 2019 13:01:32 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id y8sm9504036pfl.8.2019.11.09.13.01.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Nov 2019 13:01:31 -0800 (PST)
To:     io-uring@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v4] io_uring: limit inflight IO
Message-ID: <8c57d694-6f73-4ac7-f390-ffbb3d780fea@kernel.dk>
Date:   Sat, 9 Nov 2019 14:01:29 -0700
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

With unbounded request times, we can potentially have a lot of IO
inflight. As we provide no real backpressure unless
IORING_SETUP_CQ_NODROP is set, and even there there's quite some delay
between overflows and backpressure being applied, let's put some safety
in place to avoid going way overboard.

This limits the maximum number of inflight IO for any given io_ring_ctx
to twice the CQ ring size. This is a losely managed limit, we only check
for every SQ ring size number of events. That should be good enough to
achieve our goal, which is to prevent massively deep queues. If these
are async requests, they would just be waiting for an execution slot
anyway.

We return -EBUSY if we can't queue anymore IO. The caller should reap
some completions and retry the operation after that. Note that this is
a "should never hit this" kind of condition, as driving the depth into
CQ overflow situations is unreliable.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

Changes since v3:
- Fixup masking for when to check (Pavel)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 472bbc11688c..a2548a6dd195 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -745,7 +745,7 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 	struct io_kiocb *req;
 
 	if (!percpu_ref_tryget(&ctx->refs))
-		return NULL;
+		return ERR_PTR(-ENXIO);
 
 	if (!state) {
 		req = kmem_cache_alloc(req_cachep, gfp);
@@ -791,7 +791,7 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 	if (req)
 		goto got_it;
 	percpu_ref_put(&ctx->refs);
-	return NULL;
+	return ERR_PTR(-EBUSY);
 }
 
 static void io_free_req_many(struct io_ring_ctx *ctx, void **reqs, int *nr)
@@ -2997,6 +2997,31 @@ static bool io_get_sqring(struct io_ring_ctx *ctx, struct sqe_submit *s)
 	return false;
 }
 
+static bool io_sq_over_limit(struct io_ring_ctx *ctx, unsigned to_submit)
+{
+	unsigned inflight;
+
+	if (!list_empty(&ctx->cq_overflow_list)) {
+		io_cqring_overflow_flush(ctx, false);
+		return true;
+	}
+
+	/*
+	 * This doesn't need to be super precise, so only check every once
+	 * in a while.
+	 */
+	if ((ctx->cached_sq_head & ~ctx->sq_mask) !=
+	    ((ctx->cached_sq_head + to_submit) & ~ctx->sq_mask))
+		return false;
+
+	/*
+	 * Limit us to 2x the CQ ring size
+	 */
+	inflight = ctx->cached_sq_head -
+		  (ctx->cached_cq_tail + atomic_read(&ctx->cached_cq_overflow));
+	return inflight > 2 * ctx->cq_entries;
+}
+
 static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 			  struct file *ring_file, int ring_fd,
 			  struct mm_struct **mm, bool async)
@@ -3007,10 +3032,8 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 	int i, submitted = 0;
 	bool mm_fault = false;
 
-	if (!list_empty(&ctx->cq_overflow_list)) {
-		io_cqring_overflow_flush(ctx, false);
+	if (unlikely(io_sq_over_limit(ctx, nr)))
 		return -EBUSY;
-	}
 
 	if (nr > IO_PLUG_THRESHOLD) {
 		io_submit_state_start(&state, ctx, nr);
@@ -3022,9 +3045,9 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 		unsigned int sqe_flags;
 
 		req = io_get_req(ctx, statep);
-		if (unlikely(!req)) {
+		if (unlikely(IS_ERR(req))) {
 			if (!submitted)
-				submitted = -EAGAIN;
+				submitted = PTR_ERR(req);
 			break;
 		}
 		if (!io_get_sqring(ctx, &req->submit)) {
@@ -3045,8 +3068,10 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 		if (link && (sqe_flags & IOSQE_IO_DRAIN)) {
 			if (!shadow_req) {
 				shadow_req = io_get_req(ctx, NULL);
-				if (unlikely(!shadow_req))
+				if (unlikely(IS_ERR(shadow_req))) {
+					shadow_req = NULL;
 					goto out;
+				}
 				shadow_req->flags |= (REQ_F_IO_DRAIN | REQ_F_SHADOW_DRAIN);
 				refcount_dec(&shadow_req->refs);
 			}

-- 
Jens Axboe

