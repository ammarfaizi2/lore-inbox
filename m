Return-Path: <SRS0=jnAq=ZB=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B5DC43331
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 12:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6493C2077C
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 12:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ax9K7hDP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbfKIM2i (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 9 Nov 2019 07:28:38 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37079 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbfKIM2i (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 9 Nov 2019 07:28:38 -0500
Received: by mail-lj1-f196.google.com with SMTP id l21so1647675ljg.4
        for <io-uring@vger.kernel.org>; Sat, 09 Nov 2019 04:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=LUzle+8m7N2+/CrboC7PjFvy2kEWHv1Jo7jzU2U5xko=;
        b=ax9K7hDPzAEvUqOoCLqVhADPjf9Pr2xzA27qXWrKdsT4oUR+Pv0PAq5lsoFv2N8U5x
         QafQFKvRAhS91vqzYLh9VpdGPpKJu0UilDzRw17QhJ7z15dGD54DZQngaBIsbolNKrqu
         HdEkOQu7sxbzwpnjnTCy399er0KLz/wkh4sxUnBY/wMXK3PcbpNVtlFDmR24x39OXbYc
         zhQPKXYMoofkGgGZK7TH5TKhFwpOdFXdNLabYkjyhWjNO7hFKQC6GgVerwgYqpHCnvE0
         bWmHJ/anAZnKORXVusdj34FKi1bV+HLlA+G6SLOXe6ry597gm0RYxcrR5sHoLZ6OUFJC
         uIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LUzle+8m7N2+/CrboC7PjFvy2kEWHv1Jo7jzU2U5xko=;
        b=pF80nrWdfvy/zCXNWHF/Gt6UVzeLzgYgvCdM9gFs/8cmEq42IZAbUESPxWMxNPqFuz
         wtWdYFALsjsgRgAbxNcp/HLWq12dRVaUwSR9sirQBQA39Q0k+28iU0jo3+Qh0i+GjXZy
         Mu3PBrdWluBTSj8AiYov1kZL+v7wbNjmA67KJ7r2J++bujJRgDlT9ST/LkM88gw6sHZH
         LFxWXSrQ2JFKN/I9GBypbR4CEiu2ODov2Wr5C+5ec+HIagW/EH7vLEIq4VnAAORapC/q
         3dQW+AtLXh3lq35xAiScjl/Y27HeFa/H/p3VIg5+yItKj0zWxXHzLmDrgb9YtmYg3hZY
         ttTA==
X-Gm-Message-State: APjAAAVrixOO+ERcGEpXDNPrr68Sjgz2yAQqz/0kf5siiKEIZ0/9owz8
        epfh+99ZvmCWehSLXpUNaMRggNh1
X-Google-Smtp-Source: APXvYqyGJrvtSajRlXkfVvrU80bzQV2uIAL8pe2dBgfSDdnnfxWtXNrPsscZX9Jf4Qn4mN1utYKsow==
X-Received: by 2002:a2e:9d97:: with SMTP id c23mr9897935ljj.121.1573302514873;
        Sat, 09 Nov 2019 04:28:34 -0800 (PST)
Received: from [172.31.190.83] ([86.57.146.226])
        by smtp.gmail.com with ESMTPSA id r19sm3973444lfi.13.2019.11.09.04.28.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Nov 2019 04:28:34 -0800 (PST)
Subject: Re: [PATCH RFC v2] io_uring: limit inflight IO
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
References: <d7604123-1499-70b1-9990-74b3b1cfab69@kernel.dk>
 <6945baa5-7539-1d67-fcb5-5642e81994a8@gmail.com>
Message-ID: <614016e6-9e94-0b26-1652-8ce140952d28@gmail.com>
Date:   Sat, 9 Nov 2019 15:28:33 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <6945baa5-7539-1d67-fcb5-5642e81994a8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/9/2019 2:01 PM, Pavel Begunkov wrote:
> On 09/11/2019 00:10, Jens Axboe wrote:
>> Here's a modified version for discussion. Instead of sizing this on the
>> specific ring, just size it based on the max allowable CQ ring size. I
>> think this should be safer, and won't risk breaking existing use cases
>> out there.
>>
>> The reasoning here is that we already limit the ring sizes globally,
>> they are under ulimit memlock protection. With this on top, we have some
>> sort of safe guard for the system as a whole as well, whereas before we
>> had none. Even a small ring size can keep queuing IO.
>>
>> Let me know what you guys think...
>>
>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> index 29ea1106132d..0d8c3b1612af 100644
>> --- a/fs/io_uring.c
>> +++ b/fs/io_uring.c
>> @@ -737,6 +737,25 @@ static struct io_kiocb *io_get_fallback_req(struct io_ring_ctx *ctx)
>>  	return NULL;
>>  }
>>  
>> +static bool io_req_over_limit(struct io_ring_ctx *ctx)
>> +{
>> +	unsigned inflight;
>> +
>> +	/*
>> +	 * This doesn't need to be super precise, so only check every once
>> +	 * in a while.
>> +	 */
>> +	if (ctx->cached_sq_head & ctx->sq_mask)
>> +		return false;
>> +
>> +	/*
>> +	 * Use 2x the max CQ ring size
>> +	 */
>> +	inflight = ctx->cached_sq_head -
>> +		  (ctx->cached_cq_tail + atomic_read(&ctx->cached_cq_overflow));
>> +	return inflight >= 2 * IORING_MAX_CQ_ENTRIES;
>> +}
> 
> ctx->cached_cq_tail protected by ctx->completion_lock and can be
> changed asynchronously. That's a not synchronised access, so 
> formally (probably) breaks the memory model.
> 
> False values shouldn't be a problem here, but anyway.
> 

Took a glance, it seems access to cached_cq_tail is already messed up in
other places. Do I miss something?

> 
>> +
>>  static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
>>  				   struct io_submit_state *state)
>>  {
>> @@ -744,9 +763,11 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
>>  	struct io_kiocb *req;
>>  
>>  	if (!percpu_ref_tryget(&ctx->refs))
>> -		return NULL;
>> +		return ERR_PTR(-ENXIO);
>>  
>>  	if (!state) {
>> +		if (unlikely(io_req_over_limit(ctx)))
>> +			goto out_limit;
>>  		req = kmem_cache_alloc(req_cachep, gfp);
>>  		if (unlikely(!req))
>>  			goto fallback;
>> @@ -754,6 +775,8 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
>>  		size_t sz;
>>  		int ret;
>>  
>> +		if (unlikely(io_req_over_limit(ctx)))
>> +			goto out_limit;
>>  		sz = min_t(size_t, state->ios_left, ARRAY_SIZE(state->reqs));
>>  		ret = kmem_cache_alloc_bulk(req_cachep, gfp, sz, state->reqs);
>>  
>> @@ -789,8 +812,9 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
>>  	req = io_get_fallback_req(ctx);
>>  	if (req)
>>  		goto got_it;
>> +out_limit:
>>  	percpu_ref_put(&ctx->refs);
>> -	return NULL;
>> +	return ERR_PTR(-EBUSY);
>>  }
>>  
>>  static void io_free_req_many(struct io_ring_ctx *ctx, void **reqs, int *nr)
>> @@ -3016,9 +3040,9 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
>>  		unsigned int sqe_flags;
>>  
>>  		req = io_get_req(ctx, statep);
>> -		if (unlikely(!req)) {
>> +		if (unlikely(IS_ERR(req))) {
>>  			if (!submitted)
>> -				submitted = -EAGAIN;
>> +				submitted = PTR_ERR(req);
>>  			break;
>>  		}
>>  		if (!io_get_sqring(ctx, &req->submit)) {
>> @@ -3039,8 +3063,10 @@ static int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr,
>>  		if (link && (sqe_flags & IOSQE_IO_DRAIN)) {
>>  			if (!shadow_req) {
>>  				shadow_req = io_get_req(ctx, NULL);
>> -				if (unlikely(!shadow_req))
>> +				if (unlikely(IS_ERR(shadow_req))) {
>> +					shadow_req = NULL;
>>  					goto out;
>> +				}
>>  				shadow_req->flags |= (REQ_F_IO_DRAIN | REQ_F_SHADOW_DRAIN);
>>  				refcount_dec(&shadow_req->refs);
>>  			}
>>
> 
