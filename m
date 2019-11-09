Return-Path: <SRS0=jnAq=ZB=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E17C43331
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 15:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 942D9214E0
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 15:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UrnID8sb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfKIPVb (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 9 Nov 2019 10:21:31 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43968 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfKIPVb (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 9 Nov 2019 10:21:31 -0500
Received: by mail-pl1-f194.google.com with SMTP id a18so5617592plm.10
        for <io-uring@vger.kernel.org>; Sat, 09 Nov 2019 07:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=nfvynAx29H1yXgCCDPWkyXXn7iuXOwHjf3k+0+pbMo4=;
        b=UrnID8sbdvfAzrIrwsIKNx61IoQY4aMckIr0JgmsNowGBfroZMdzitQm5oqSaTAHVR
         C+d5kuN5PwPtmdNCoJ4vsgSazq1S9BqiMLDZwRq9GWCljwrETB81dds3wRQVMUMuqBLm
         BP2A1WYYF8gb4juSsDBobJsXaGNrEE4uBzPS5SFaeU2/knL+CWnOBUCs19iGYU/bCtaU
         fgTNTC+CTpx3NloP+JuG7p67DP2gjhJhjUHW2dxJdhh9ldPtQEz3Ot14awCPiSyjFHG8
         D6v2rw0hUGVFQIGINGbS0NaHMDDuSZkFzAKXNheutRUut5NQ7uvMf3cbQR4fS30EkU63
         lICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=nfvynAx29H1yXgCCDPWkyXXn7iuXOwHjf3k+0+pbMo4=;
        b=U9AyabYwiaeESsB/SRIcc0kSrWsgNNW1CDg8IBlyZxTiqS05mjBQgYjPs6yzKWDYK0
         Dh889Y1RAhfRNQVjVCU7yctAbbqIkyWGO00hEfoJRepOQ8QJmpvkM4IaAdvloyhGQArO
         wnc4/ye2yCNma4MROshgbT8GPmlmjK35OiGIY2q0XTiOLqzlLL6Q1HOVxg6jJAx+2Eje
         Lt/8Df4KHn/113591C5rNH94EVKmuHMnGkqSzyT6h3BOWVX9d7h1Nci59mXVbFZZGLx1
         acE9o4y/+KovuiCL/F/o9eqK+FQvNtWQwG+13rLHHKr9pJPQMSUr4QRtfYrf+M3XAnnu
         aong==
X-Gm-Message-State: APjAAAWeoCq1iue0TFtsnW4k0fiv14w7xrkKxugOxuDn2E6oOCqrAbGy
        QdAx7khlP8/xm7CutqfcfxWTRg==
X-Google-Smtp-Source: APXvYqwF6jzKUZrzAXUCsfGgOB/yxLMvYWexrm2rXQvGxUsprkym+8FjMRamFL9ZPp+QSsuB7kUT5Q==
X-Received: by 2002:a17:902:9a01:: with SMTP id v1mr17284567plp.132.1573312890273;
        Sat, 09 Nov 2019 07:21:30 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id h3sm7905140pji.16.2019.11.09.07.21.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Nov 2019 07:21:29 -0800 (PST)
To:     io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3] io_uring: limit inflight IO
Message-ID: <ecf5959a-9853-5526-9764-ac273649a5f4@kernel.dk>
Date:   Sat, 9 Nov 2019 08:21:27 -0700
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

Changes since v2:

- Check upfront if we're going over the limit, use the same kind of
  cost amortization logic except something that's appropriate for
  once-per-batch.

- Fold in with the backpressure -EBUSY logic

- Use twice setup CQ ring size as the rough limit

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 81457913e9c9..9dd0f5b5e5b2 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -744,7 +744,7 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 	struct io_kiocb *req;
 
 	if (!percpu_ref_tryget(&ctx->refs))
-		return NULL;
+		return ERR_PTR(-ENXIO);
 
 	if (!state) {
 		req = kmem_cache_alloc(req_cachep, gfp);
@@ -790,7 +790,7 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 	if (req)
 		goto got_it;
 	percpu_ref_put(&ctx->refs);
-	return NULL;
+	return ERR_PTR(-EBUSY);
 }
 
 static void io_free_req_many(struct io_ring_ctx *ctx, void **reqs, int *nr)
@@ -2992,6 +2992,30 @@ static bool io_get_sqring(struct io_ring_ctx *ctx, struct sqe_submit *s)
 	return false;
 }
 
+static bool io_sq_over_limit(struct io_ring_ctx *ctx, unsigned to_submit)
+{
+	unsigned inflight;
+
+	if ((ctx->flags & IORING_SETUP_CQ_NODROP) &&
+	    !list_empty(&ctx->cq_overflow_list))
+		return true;
+
+	/*
+	 * This doesn't need to be super precise, so only check every once
+	 * in a while.
+	 */
+	if ((ctx->cached_sq_head & ctx->sq_mask) !=
+	    ((ctx->cached_sq_head + to_submit) & ctx->sq_mask))
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
@@ -3002,8 +3026,7 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 	int i, submitted = 0;
 	bool mm_fault = false;
 
-	if ((ctx->flags & IORING_SETUP_CQ_NODROP) &&
-	    !list_empty(&ctx->cq_overflow_list))
+	if (unlikely(io_sq_over_limit(ctx, nr)))
 		return -EBUSY;
 
 	if (nr > IO_PLUG_THRESHOLD) {
@@ -3016,9 +3039,9 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
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
@@ -3039,8 +3062,10 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
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

