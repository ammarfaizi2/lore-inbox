Return-Path: <SRS0=nqv2=Y7=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72C9C43331
	for <io-uring@archiver.kernel.org>; Thu,  7 Nov 2019 23:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87FA9214D8
	for <io-uring@archiver.kernel.org>; Thu,  7 Nov 2019 23:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="qp7HSKwG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbfKGXV6 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 7 Nov 2019 18:21:58 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37802 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfKGXV6 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 7 Nov 2019 18:21:58 -0500
Received: by mail-pl1-f193.google.com with SMTP id p13so2692398pll.4
        for <io-uring@vger.kernel.org>; Thu, 07 Nov 2019 15:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=fdcZ1FoxipusDYi2PCIrnx3/jA3OOWo0scJjWrptLi4=;
        b=qp7HSKwGvEv3Y4bQfjnq6m79MyoMBBFhy1t80f5h1vHc5IS5/Vn/l3hyZ1tlOuoqEn
         eBGRxFWfizwcIcvHmz8rWtFRcCuiXW6XuNKoPDzf2uf9FHfJwxwZaU4vY8+xtCcKWU3e
         hVWDSe+QsRINBuQV8cTqo9nCoJNLWbXk92l3V0vZQwu5aHlQagoJ3J/ekGialhlId5r+
         14IegpNQPOlqkpD9SwpiMjUoF83aZNwAT1nuZqHvm2FoYagl8Tp/47gumh92OM4xv+IV
         qOTyOx3h9rfJe8qi/epkwxqp22LEj8OCXZuYWGWRrOp6rEOnRAA99NThMFWDQ4SYbR3j
         VGBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=fdcZ1FoxipusDYi2PCIrnx3/jA3OOWo0scJjWrptLi4=;
        b=cLPml6XWpwBZ1f4Mmv2VC7jB6vJ2FnRp/A1JGZBPZFPZUdhMxh14aAWIeG/0ub9dv1
         p4DHdX69DSv59iI6fBJNrsIVi50fW+PBdY4G5LI1Yp4Z2L9PVtqT1CzDUIkny5MfWybE
         HW5XscLRQtoIjVz+P5FesTbghSORNrXXa+HoSebl+RbUgGzzzAEpLq+upvpKXLtqxT7N
         +4Ir0blookvZKdPEOYP9uL+L3d9XMpyAug9kc8mwgQxDaGt7+QRAXyJY+QNXQLo4O1RZ
         pyKlFJRmINIirgVEz1U3PvDHppxh6F6oxYrAx3XPsXszZTwyXJwzSMB30q51PqoL0ZUb
         P16Q==
X-Gm-Message-State: APjAAAV1hte2Q6U9Wq6q9xElguswNg8NXJXg0/M3jiCtrjii1WR4RIBQ
        0S74TsLlvcCv24aR+7UfSIxpn2rY8Fo=
X-Google-Smtp-Source: APXvYqyEFPBPTeGCy1ceyNsrk8etGrqHVnxYClSi9SaP5xD6lq9KjbGSTDpk3a6Y40gYSY9jRD5Qxg==
X-Received: by 2002:a17:90a:9a81:: with SMTP id e1mr9112401pjp.59.1573168916789;
        Thu, 07 Nov 2019 15:21:56 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id x125sm4134017pfb.93.2019.11.07.15.21.55
        for <io-uring@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 15:21:56 -0800 (PST)
To:     io-uring@vger.kernel.org
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH RFC] io_uring: limit inflight IO
Message-ID: <e7f01b7b-5915-606f-b5b4-0d59f8e096b6@kernel.dk>
Date:   Thu, 7 Nov 2019 16:21:54 -0700
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

I'd like some feedback on this one. Even tith the overflow backpressure
patch, we still have a potentially large gap where applications can
submit IO before we get any dropped events in the CQ ring. This is
especially true if the execution time of those requests are long
(unbounded).

This adds IORING_SETUP_INFLIGHT, which if set, will return -EBUSY if we
have more IO pending than we can feasibly support. This is normally the
CQ ring size, but of IORING_SETUP_CQ_NODROP is enabled, then it's twice
the CQ ring size.

This helps manage the pending queue size instead of letting it grow
indefinitely.

Note that we could potentially just make this the default behavior -
applications need to handle -EAGAIN returns already, in case we run out
of memory, and if we change this to return -EAGAIN as well, then it
doesn't introduce any new failure cases. I'm tempted to do that...

Anyway, comments solicited!

Not-yet-signed-off-by

---

diff --git a/fs/io_uring.c b/fs/io_uring.c
index f8344f95817e..db8b7e06f36d 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -203,6 +203,7 @@ struct io_ring_ctx {
 		unsigned		sq_mask;
 		unsigned		sq_thread_idle;
 		unsigned		cached_sq_dropped;
+		atomic_t		cached_cq_overflow;
 		struct io_uring_sqe	*sq_sqes;
 
 		struct list_head	defer_list;
@@ -221,13 +222,12 @@ struct io_ring_ctx {
 
 	struct {
 		unsigned		cached_cq_tail;
-		atomic_t		cached_cq_overflow;
 		unsigned		cq_entries;
 		unsigned		cq_mask;
+		atomic_t		cq_timeouts;
 		struct wait_queue_head	cq_wait;
 		struct fasync_struct	*cq_fasync;
 		struct eventfd_ctx	*cq_ev_fd;
-		atomic_t		cq_timeouts;
 	} ____cacheline_aligned_in_smp;
 
 	struct io_rings	*rings;
@@ -705,23 +705,53 @@ static void io_cqring_add_event(struct io_kiocb *req, long res)
 	io_cqring_ev_posted(ctx);
 }
 
+static bool io_req_over_limit(struct io_ring_ctx *ctx)
+{
+	unsigned limit, inflight;
+
+	if (!(ctx->flags & IORING_SETUP_INFLIGHT))
+		return false;
+	/* only do checks every once in a while */
+	if (ctx->cached_sq_head & ctx->sq_mask)
+		return false;
+
+	if (ctx->flags & IORING_SETUP_CQ_NODROP)
+		limit = 2 * ctx->cq_entries;
+	else
+		limit = ctx->cq_entries;
+
+	inflight = ctx->cached_sq_head -
+		  (ctx->cached_cq_tail + atomic_read(&ctx->cached_cq_overflow));
+	return inflight >= limit;
+}
+
 static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
-				   struct io_submit_state *state)
+				   struct io_submit_state *state, bool force)
 {
 	gfp_t gfp = GFP_KERNEL | __GFP_NOWARN;
 	struct io_kiocb *req;
 
 	if (!percpu_ref_tryget(&ctx->refs))
-		return NULL;
+		return ERR_PTR(-ENXIO);
 
 	if (!state) {
+		if (!force && io_req_over_limit(ctx)) {
+			req = ERR_PTR(-EBUSY);
+			goto out;
+		}
 		req = kmem_cache_alloc(req_cachep, gfp);
-		if (unlikely(!req))
+		if (unlikely(!req)) {
+			req = ERR_PTR(-EAGAIN);
 			goto out;
+		}
 	} else if (!state->free_reqs) {
 		size_t sz;
 		int ret;
 
+		if (!force && io_req_over_limit(ctx)) {
+			req = ERR_PTR(-EBUSY);
+			goto out;
+		}
 		sz = min_t(size_t, state->ios_left, ARRAY_SIZE(state->reqs));
 		ret = kmem_cache_alloc_bulk(req_cachep, gfp, sz, state->reqs);
 
@@ -731,8 +761,10 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 		 */
 		if (unlikely(ret <= 0)) {
 			state->reqs[0] = kmem_cache_alloc(req_cachep, gfp);
-			if (!state->reqs[0])
+			if (!state->reqs[0]) {
+				req = ERR_PTR(-EAGAIN);
 				goto out;
+			}
 			ret = 1;
 		}
 		state->free_reqs = ret - 1;
@@ -754,7 +786,7 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 	return req;
 out:
 	percpu_ref_put(&ctx->refs);
-	return NULL;
+	return req;
 }
 
 static void io_free_req_many(struct io_ring_ctx *ctx, void **reqs, int *nr)
@@ -2963,10 +2995,11 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 		struct io_kiocb *req;
 		unsigned int sqe_flags;
 
-		req = io_get_req(ctx, statep);
-		if (unlikely(!req)) {
+		req = io_get_req(ctx, statep, false);
+		if (unlikely(IS_ERR(req))) {
 			if (!submitted)
-				submitted = -EAGAIN;
+				submitted = PTR_ERR(req);
+			req = NULL;
 			break;
 		}
 		if (!io_get_sqring(ctx, &req->submit)) {
@@ -2986,9 +3019,11 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 
 		if (link && (sqe_flags & IOSQE_IO_DRAIN)) {
 			if (!shadow_req) {
-				shadow_req = io_get_req(ctx, NULL);
-				if (unlikely(!shadow_req))
+				shadow_req = io_get_req(ctx, NULL, true);
+				if (unlikely(IS_ERR(shadow_req))) {
+					shadow_req = NULL;
 					goto out;
+				}
 				shadow_req->flags |= (REQ_F_IO_DRAIN | REQ_F_SHADOW_DRAIN);
 				refcount_dec(&shadow_req->refs);
 			}
@@ -4501,7 +4536,7 @@ static long io_uring_setup(u32 entries, struct io_uring_params __user *params)
 
 	if (p.flags & ~(IORING_SETUP_IOPOLL | IORING_SETUP_SQPOLL |
 			IORING_SETUP_SQ_AFF | IORING_SETUP_CQSIZE |
-			IORING_SETUP_CQ_NODROP))
+			IORING_SETUP_CQ_NODROP | IORING_SETUP_INFLIGHT))
 		return -EINVAL;
 
 	ret = io_uring_create(entries, &p);
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 3d8517eb376e..e7d8e16f9e22 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -57,6 +57,7 @@ struct io_uring_sqe {
 #define IORING_SETUP_SQ_AFF	(1U << 2)	/* sq_thread_cpu is valid */
 #define IORING_SETUP_CQSIZE	(1U << 3)	/* app defines CQ size */
 #define IORING_SETUP_CQ_NODROP	(1U << 4)	/* no CQ drops */
+#define IORING_SETUP_INFLIGHT	(1U << 5)	/* reject IO over limit */
 
 #define IORING_OP_NOP		0
 #define IORING_OP_READV		1

-- 
Jens Axboe

