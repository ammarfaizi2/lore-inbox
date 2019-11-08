Return-Path: <SRS0=cPsQ=ZA=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E530FC6197
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 21:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1136620869
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 21:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xW+3wMXR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731387AbfKHVK4 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 8 Nov 2019 16:10:56 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:36207 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfKHVK4 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 8 Nov 2019 16:10:56 -0500
Received: by mail-io1-f67.google.com with SMTP id s3so7877148ioe.3
        for <io-uring@vger.kernel.org>; Fri, 08 Nov 2019 13:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Ca4nTsX1lulVwWNTqkKsWKwg5SBGwxMSTC2j+DBlU/o=;
        b=xW+3wMXRKuE9zvPcpK2HdMqyDHN4ioTOl3MYvuorz7MEu/AYM+AQ3ivLTUz7XpqFPd
         EdnFbmYkqLLLiAsvvSKiBFOCb8gnSODS/3s9nd0IcP/z6EbekNSRWT+Ddd/URkzhn8px
         7FgMg3GIDQZPQpG/keQ/T5EZHqPqW17cR27JK/na/OyTz8H//8L17l0md0nf6A+GNCuW
         ihuFf0YiDkvZEGsYO7/NuzcQA/aAl6mvfb6YyRqWVwP8wu1yxedXyR5rtkTT8dDwe0gg
         P3U7Cl6i6EqLMinKFW5EHYx2hlCJ4Z0qn69Al/WPyg8ZBxg4nsTsCP7qdFXLAnsvd98d
         Empw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Ca4nTsX1lulVwWNTqkKsWKwg5SBGwxMSTC2j+DBlU/o=;
        b=HKA201hjJyH2JoLEtlllKbfnK8dlYqZaf9sEmXljToR4sGSaHUdNkRC13OiY1yoaZf
         idytuiuC/71ZPGnXD30D76OQAA9nSko8Ax6tjlqm4Lr8Sc+fM0wMRKxGg5C/uxhhT32b
         RlR3ar/hUjf61zRMgj6eycbw0slkSnu9920OKttZgp0CWg53/Vpobo2eIqO5mQmPZ/aL
         VwvILPVRbN5CtT+gkh+LPMiCZCjSyY3AAsRuJg6XNdB7OINN6nuqK14NX1npPU1m+vs8
         kHpd422LQfFoSBCf1T+FnNK0PubDyy7x6X8l4jS0/IkoFeOEuYMTlBmqeyYuifVbW0nT
         IgSQ==
X-Gm-Message-State: APjAAAV22+zXyIGaFA1vHzvy14YMKKANh5n1sQ4Zz1GvW2lKq4p76jB/
        lW1A74eCwMJBHiCCbAKG4EtdBw==
X-Google-Smtp-Source: APXvYqxRliCq4Oy0zAsx4TG5v+t3RiALEUXFM+cQSq2/Tbtl9gN9KMGxUf7lL+zrME1i0Opc6oJrHA==
X-Received: by 2002:a02:740a:: with SMTP id o10mr13362047jac.106.1573247454859;
        Fri, 08 Nov 2019 13:10:54 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id q69sm936681ilb.4.2019.11.08.13.10.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 13:10:53 -0800 (PST)
To:     io-uring@vger.kernel.org,
        "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH RFC v2] io_uring: limit inflight IO
Message-ID: <d7604123-1499-70b1-9990-74b3b1cfab69@kernel.dk>
Date:   Fri, 8 Nov 2019 14:10:52 -0700
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

Here's a modified version for discussion. Instead of sizing this on the
specific ring, just size it based on the max allowable CQ ring size. I
think this should be safer, and won't risk breaking existing use cases
out there.

The reasoning here is that we already limit the ring sizes globally,
they are under ulimit memlock protection. With this on top, we have some
sort of safe guard for the system as a whole as well, whereas before we
had none. Even a small ring size can keep queuing IO.

Let me know what you guys think...

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 29ea1106132d..0d8c3b1612af 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -737,6 +737,25 @@ static struct io_kiocb *io_get_fallback_req(struct io_ring_ctx *ctx)
 	return NULL;
 }
 
+static bool io_req_over_limit(struct io_ring_ctx *ctx)
+{
+	unsigned inflight;
+
+	/*
+	 * This doesn't need to be super precise, so only check every once
+	 * in a while.
+	 */
+	if (ctx->cached_sq_head & ctx->sq_mask)
+		return false;
+
+	/*
+	 * Use 2x the max CQ ring size
+	 */
+	inflight = ctx->cached_sq_head -
+		  (ctx->cached_cq_tail + atomic_read(&ctx->cached_cq_overflow));
+	return inflight >= 2 * IORING_MAX_CQ_ENTRIES;
+}
+
 static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 				   struct io_submit_state *state)
 {
@@ -744,9 +763,11 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 	struct io_kiocb *req;
 
 	if (!percpu_ref_tryget(&ctx->refs))
-		return NULL;
+		return ERR_PTR(-ENXIO);
 
 	if (!state) {
+		if (unlikely(io_req_over_limit(ctx)))
+			goto out_limit;
 		req = kmem_cache_alloc(req_cachep, gfp);
 		if (unlikely(!req))
 			goto fallback;
@@ -754,6 +775,8 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 		size_t sz;
 		int ret;
 
+		if (unlikely(io_req_over_limit(ctx)))
+			goto out_limit;
 		sz = min_t(size_t, state->ios_left, ARRAY_SIZE(state->reqs));
 		ret = kmem_cache_alloc_bulk(req_cachep, gfp, sz, state->reqs);
 
@@ -789,8 +812,9 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 	req = io_get_fallback_req(ctx);
 	if (req)
 		goto got_it;
+out_limit:
 	percpu_ref_put(&ctx->refs);
-	return NULL;
+	return ERR_PTR(-EBUSY);
 }
 
 static void io_free_req_many(struct io_ring_ctx *ctx, void **reqs, int *nr)
@@ -3016,9 +3040,9 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
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
@@ -3039,8 +3063,10 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
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

