Return-Path: <SRS0=jnAq=ZB=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE92C43331
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 15:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC5521848
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 15:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="awtrdnnU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfKIPP3 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 9 Nov 2019 10:15:29 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37260 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfKIPP3 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 9 Nov 2019 10:15:29 -0500
Received: by mail-pf1-f194.google.com with SMTP id p24so7168266pfn.4
        for <io-uring@vger.kernel.org>; Sat, 09 Nov 2019 07:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=NNQfo8tZERK8bwhBHG9aTXgcgRFasjSWw2Oh92gWh8I=;
        b=awtrdnnUd3iBXEo99ITDIaW0Ujh9NR0OOgV0ecnEFaLJEgl/jQSPy9lCLuBtEEFOW+
         Rs0lF1v+4JLUnaAscIRsKJPp4F0QAG3+Fom0zSruMJqmLeXOsgmKE1EDBf3piW4nUAQ0
         HVTeiEWIWh4kN56sFoSYWxb1uchYYQ4iy0NQcFdMyRrvwNxox51cTnnLMqMZ82LDZC3Z
         jAxEa+qsS+VdH51MuTJbKMIVg/IxKauRUrVckph7A2pPPMEwyk3rTLx3CC208tlvoo0a
         K1modD7h1mHWt9w7w9cv5CLUnZ7d4jzThXnHiNeq9YnJstLzp8hdKJhApMhbgTq/lULz
         l5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NNQfo8tZERK8bwhBHG9aTXgcgRFasjSWw2Oh92gWh8I=;
        b=fQ0xjaqE+TiVXB+SaVx4y664H9cqQhaqLtWL3zAFwmqwPAkpACtoUDunrJvjItdZ9g
         jhGAh+U8iE2b8AMEk4AdfnADdPCqkPH8EFDDVVUMKQJQgd2Qk0M9KvEw803yggFHqs8W
         NI9gQs7E7gWJybUTva6wrqn2JqRDfz6tWrBa37C9MqrQaAD7vx1o9JxF0/Bp31HWmayE
         1gEux53DAT4IQavrARxF/m/PELcWvX8ESyLhtkklbKwIOQ7Sueqg6k1PDlVR/dxUTHgK
         CeSql3zdOOzP8NkfAsanzaf2xgJrFNQrAa9Zbf01AtWUuvbEnlPqUCVizX3HXEXEzFul
         KGxQ==
X-Gm-Message-State: APjAAAXhH58FOc30SKmyWfIMHT0gjRJKjKn0k9ZDyScQtynMZ+IRnWjp
        Gm7uFBujjvBGcF4dNoI6Mxqf/cH6p6w=
X-Google-Smtp-Source: APXvYqybjcArO+Sxbt06vnK1GmeHdB1EdlVFIJaxpy/YDaJTjuT0/9kXTDqdREfv3bmPJs3vJiseCQ==
X-Received: by 2002:a17:90a:650:: with SMTP id q16mr22260413pje.53.1573312525890;
        Sat, 09 Nov 2019 07:15:25 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id t17sm7836606pfh.46.2019.11.09.07.15.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Nov 2019 07:15:24 -0800 (PST)
Subject: Re: [PATCH RFC] io_uring: limit inflight IO
From:   Jens Axboe <axboe@kernel.dk>
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
References: <e7f01b7b-5915-606f-b5b4-0d59f8e096b6@kernel.dk>
 <33958a03-6714-ce51-9856-1dcbf53f67d5@kernel.dk>
 <273391a6-1def-3c29-986c-8efca569fc16@gmail.com>
 <cc6b368b-10e3-504c-4895-feefe6311004@kernel.dk>
 <bdfdad32-91b7-7721-ccdf-0dd399e7e051@kernel.dk>
 <69985522-3e8e-102b-c8e9-ea9046cd22c6@gmail.com>
 <d8002007-7641-3e9d-0560-123358300e66@kernel.dk>
Message-ID: <38f51d0c-cd27-6631-c4d3-06fbb26a5c1e@kernel.dk>
Date:   Sat, 9 Nov 2019 08:15:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <d8002007-7641-3e9d-0560-123358300e66@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/9/19 7:23 AM, Jens Axboe wrote:
> On 11/9/19 4:16 AM, Pavel Begunkov wrote:
>>> I've been struggling a bit with how to make this reliable, and I'm not
>>> so sure there's a way to do that. Let's say an application sets up a
>>> ring with 8 sq entries, which would then default to 16 cq entries. With
>>> this patch, we'd allow 16 ios inflight. But what if the application does
>>>
>>> for (i = 0; i < 32; i++) {
>>> 	sqe = get_sqe();
>>> 	prep_sqe();
>>> 	submit_sqe();
>>> }
>>>
>>> And then directly proceeds to:
>>>
>>> do {
>>> 	get_completions();
>>> } while (has_completions);
>>>
>>> As long as fewer than 16 requests complete before we start reaping,
>>> we don't lose any events. Hence there's a risk of breaking existing
>>> setups with this, even though I don't think that's a high risk.
>>>
>>
>> I think, this should be considered as an erroneous usage of the API.
>> It's better to fail ASAP than to be surprised in a production
>> system, because of non-deterministic nature of such code. Even worse
>> with trying to debug such stuff.
>>
>> As for me, cases like below are too far-fetched
>>
>> for (i = 0; i < n; i++)
>> 	submit_read_sqe()
>> for (i = 0; i < n; i++) {
>> 	device_allow_next_read()
>> 	get_single_cqe()
>> }
> 
> I can't really disagree with that, it's a use case that's bound to fail
> every now and then...
> 
> But if we agree that's the case, then we should be able to just limit
> based on the cq ring size in question.
> 
> Do we make it different fro CQ_NODROP and !CQ_NODROP or not? Because the
> above case would work with CQ_NODROP, reliably. At least CQ_NODROP is
> new so we get to set the rules for that one, they just have to make
> sense.

Just tossing this one out there, it's an incremental to v2 of the patch.

- Check upfront if we're going over the limit, use the same kind of
  cost amortization logic except something that's appropriate for
  once-per-batch.

- Fold in with the backpressure -EBUSY logic

This avoids breaking up chains, for example, and also means we don't
have to run these checks for every request.

Limit is > 2 * cq_entries. I think that's liberal enough to not cause
issues, while still having a relation to the sq/cq ring sizes which
I like.


diff --git a/fs/io_uring.c b/fs/io_uring.c
index 18711d45b994..53ccd4e1dee2 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -737,25 +737,6 @@ static struct io_kiocb *io_get_fallback_req(struct io_ring_ctx *ctx)
 	return NULL;
 }
 
-static bool io_req_over_limit(struct io_ring_ctx *ctx)
-{
-	unsigned inflight;
-
-	/*
-	 * This doesn't need to be super precise, so only check every once
-	 * in a while.
-	 */
-	if (ctx->cached_sq_head & ctx->sq_mask)
-		return false;
-
-	/*
-	 * Use 2x the max CQ ring size
-	 */
-	inflight = ctx->cached_sq_head -
-		  (ctx->cached_cq_tail + atomic_read(&ctx->cached_cq_overflow));
-	return inflight >= 2 * IORING_MAX_CQ_ENTRIES;
-}
-
 static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 				   struct io_submit_state *state)
 {
@@ -766,8 +747,6 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 		return ERR_PTR(-ENXIO);
 
 	if (!state) {
-		if (unlikely(io_req_over_limit(ctx)))
-			goto out_limit;
 		req = kmem_cache_alloc(req_cachep, gfp);
 		if (unlikely(!req))
 			goto fallback;
@@ -775,8 +754,6 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 		size_t sz;
 		int ret;
 
-		if (unlikely(io_req_over_limit(ctx)))
-			goto out_limit;
 		sz = min_t(size_t, state->ios_left, ARRAY_SIZE(state->reqs));
 		ret = kmem_cache_alloc_bulk(req_cachep, gfp, sz, state->reqs);
 
@@ -812,7 +789,6 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 	req = io_get_fallback_req(ctx);
 	if (req)
 		goto got_it;
-out_limit:
 	percpu_ref_put(&ctx->refs);
 	return ERR_PTR(-EBUSY);
 }
@@ -3021,6 +2997,30 @@ static bool io_get_sqring(struct io_ring_ctx *ctx, struct sqe_submit *s)
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
@@ -3031,8 +3031,7 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
 	int i, submitted = 0;
 	bool mm_fault = false;
 
-	if ((ctx->flags & IORING_SETUP_CQ_NODROP) &&
-	    !list_empty(&ctx->cq_overflow_list))
+	if (unlikely(io_sq_over_limit(ctx, nr)))
 		return -EBUSY;
 
 	if (nr > IO_PLUG_THRESHOLD) {

-- 
Jens Axboe

