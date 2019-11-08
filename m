Return-Path: <SRS0=cPsQ=ZA=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFCDC43331
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 00:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A14C02084C
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 00:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="G2Dv5sON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725946AbfKHAUD (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 7 Nov 2019 19:20:03 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35022 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfKHAUD (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 7 Nov 2019 19:20:03 -0500
Received: by mail-pl1-f195.google.com with SMTP id s10so2792013plp.2
        for <io-uring@vger.kernel.org>; Thu, 07 Nov 2019 16:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=iT8KTat3rvuSmzK173prI1k3B/Q0JRSCNCAU8p1uN1o=;
        b=G2Dv5sONy5EwCX9OI7OoP6W01H+e/d8SFp+e3cR6d9R8SAUDQ6b8vOs4gDtjjm4bKc
         NMxucTj7uw5uUf1YzTslzyMxVektgnHdS5qcMOlf9PKsOS38LrqpRfzyEjeW9CDhw8TG
         CwmUakg5IYcGXLjU+7K+ULdeGVSJRqx+q7NYoKg4jHQSL97WDn/88korVfMLgEXunr+b
         I3ge3hDD2MaSAmgxlFqQZTBV/VqPEn+QJjlO/3xCB2Gbrjg6meUJgvlFIUjPh+nH1BGW
         W1ypozCVDRZDFB+FWtVRlelqZModLPDIBaUNbDr0onch1BOU+pRnCW4UIH3zZ5xfsvR3
         pWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iT8KTat3rvuSmzK173prI1k3B/Q0JRSCNCAU8p1uN1o=;
        b=e+dXJHwlvlXzQoTLwJpFjnv00kTIsP5fxI5Nf72XymlDZs/7NzXGFG4utF4vvp9FkV
         Xwq6wasiYwgL+bwtSsxaBKGuuun7ahm/V2x8RyrgFdj6NtVh78r7rOgrZXYm+s2EqCjl
         NBO6OfcKYBggQV4cWcJkX8WjjwnsLgWo9uVIM+3HIdKU45GhrUxh4dhWgzGApYrXL3sG
         5avfxuZHgi0h3BKN924s6SfRPpK4wUl677l9p4bv/GYG/qh9IVSfIWs19lMEo9OgWDpw
         wmt7dBkQEGRb4eimiQYrFCfzQfJ64UAHo4KYN9nFEIU0VR8+xhqKCJZwHLq+4zC6DSyH
         o9GQ==
X-Gm-Message-State: APjAAAX/1HICiB8KYlNGxHK/QXdzdl4G3KNEMRGy42+j1a98WKoAvmLc
        B/FG4LKybauenUp19YNEaYQ4HKmPckg=
X-Google-Smtp-Source: APXvYqyTl3YUk9hQ+tcriormbAzCz9ucYAPMFNdeFFrLBx8jWib6Q4k9oFxbVx7u3oL5ArPN3ZLRAw==
X-Received: by 2002:a17:90a:2e03:: with SMTP id q3mr9187036pjd.63.1573172401162;
        Thu, 07 Nov 2019 16:20:01 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id w15sm3793841pfn.13.2019.11.07.16.19.59
        for <io-uring@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 16:20:00 -0800 (PST)
Subject: Re: [PATCH RFC] io_uring: limit inflight IO
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
References: <e7f01b7b-5915-606f-b5b4-0d59f8e096b6@kernel.dk>
Message-ID: <33958a03-6714-ce51-9856-1dcbf53f67d5@kernel.dk>
Date:   Thu, 7 Nov 2019 17:19:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e7f01b7b-5915-606f-b5b4-0d59f8e096b6@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/7/19 4:21 PM, Jens Axboe wrote:
> I'd like some feedback on this one. Even tith the overflow backpressure
> patch, we still have a potentially large gap where applications can
> submit IO before we get any dropped events in the CQ ring. This is
> especially true if the execution time of those requests are long
> (unbounded).
> 
> This adds IORING_SETUP_INFLIGHT, which if set, will return -EBUSY if we
> have more IO pending than we can feasibly support. This is normally the
> CQ ring size, but of IORING_SETUP_CQ_NODROP is enabled, then it's twice
> the CQ ring size.
> 
> This helps manage the pending queue size instead of letting it grow
> indefinitely.
> 
> Note that we could potentially just make this the default behavior -
> applications need to handle -EAGAIN returns already, in case we run out
> of memory, and if we change this to return -EAGAIN as well, then it
> doesn't introduce any new failure cases. I'm tempted to do that...
> 
> Anyway, comments solicited!

After a little deliberation, I think we should go with the one that
doesn't require users to opt-in. As mentioned, let's change it to
-EAGAIN to not introduce a new errno for this. They essentially mean
the same thing anyway.


diff --git a/fs/io_uring.c b/fs/io_uring.c
index f8344f95817e..4c488bf6e889 100644
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
@@ -705,16 +705,39 @@ static void io_cqring_add_event(struct io_kiocb *req, long res)
 	io_cqring_ev_posted(ctx);
 }
 
+static bool io_req_over_limit(struct io_ring_ctx *ctx)
+{
+	unsigned limit, inflight;
+
+	/*
+	 * This doesn't need to be super precise, so only check every once
+	 * in a while.
+	 */
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
+		if (unlikely(!force && io_req_over_limit(ctx)))
+			goto out;
 		req = kmem_cache_alloc(req_cachep, gfp);
 		if (unlikely(!req))
 			goto out;
@@ -722,6 +745,8 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 		size_t sz;
 		int ret;
 
+		if (unlikely(!force && io_req_over_limit(ctx)))
+			goto out;
 		sz = min_t(size_t, state->ios_left, ARRAY_SIZE(state->reqs));
 		ret = kmem_cache_alloc_bulk(req_cachep, gfp, sz, state->reqs);
 
@@ -754,7 +779,7 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 	return req;
 out:
 	percpu_ref_put(&ctx->refs);
-	return NULL;
+	return ERR_PTR(-EAGAIN);
 }
 
 static void io_free_req_many(struct io_ring_ctx *ctx, void **reqs, int *nr)
@@ -2963,10 +2988,11 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
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
@@ -2986,9 +3012,11 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 
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

-- 
Jens Axboe

