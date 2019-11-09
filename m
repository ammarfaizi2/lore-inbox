Return-Path: <SRS0=jnAq=ZB=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CB0C43331
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 14:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EEC12196F
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 14:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BEhWHJ4P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfKIOKD (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 9 Nov 2019 09:10:03 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39915 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbfKIOKD (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 9 Nov 2019 09:10:03 -0500
Received: by mail-pg1-f194.google.com with SMTP id 29so6036405pgm.6
        for <io-uring@vger.kernel.org>; Sat, 09 Nov 2019 06:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=PMtKAdTIslbNSxkPc2fpv0D1hjxZiSRD+mkxT/LDZjc=;
        b=BEhWHJ4PNa1X67ug1laUgoWbD0Sdy8f1ReJfZKhQOnGvG5yQUDjZiUklNIMgZ/ndiO
         ZGRimp9hI/34nAZI8DOKifJF9CgkWq4ix2myFeoc9u3HG+SFyQSE4faqkj/vtyEw7B7X
         jc3wybOsQ8cUrQv6fIFwy6JBbvhpKczB4cdQOuu4USHzbcqZhShUib2nktBlQz2RBR1n
         Ze8sYNNKq922nI9nympEuegix0oUPqRs6t2b9QqLFN60urd/kYfa8Hfi4loDvTqh71KP
         g36ecz9ON+CvH/Aabr8cqyVKdC0qsNitC3knvjpFTSjSGoxCuhHNIDR4grAt1A4mqfKP
         BTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PMtKAdTIslbNSxkPc2fpv0D1hjxZiSRD+mkxT/LDZjc=;
        b=ZQUFWyJbcQi9ScvbFbuQe+CHwhR4YMod91yj5PmujyNxHG6OTA/62kzeOpRhj16kCm
         y31T6o1o6ac/GPEoiP3dIk8z3YEDGPp8p89wGgWGi/pVEFpuYE/DPUet041O5R7B6kci
         Gt8LT+UMjLkmUGAPlFOIwoE8aGcxVpAidxTVq9Qr+k+1VvRSBmZMoVqmBSwucCYX7Q7+
         jvhDXmYx/KZJuJIwB/Odw1WImAx0KBFdEFC/BZn2JxZMy0GDxnCwHk4cpacHFjBIhMWq
         /Kr9pMgFTWdcd+qOyPmbeBsG/ZSNgn6T5umodx5Ik75VxELxB+yKMMEt/L3gXg3jVp/o
         /CDQ==
X-Gm-Message-State: APjAAAXHGhDf+AL2nGo9qDoXiAdyD3t5sFrX3o0UIBrvIEMIo85eiFwH
        2poaJA0vGy3kEsOYxstEs2gxDNcGZb0=
X-Google-Smtp-Source: APXvYqzrI4ILohTW1dSYRxgQl9zArKdvZqENamvYq/QbLDMfUB8y4tIZE1Lk3siw8hykoarx+sU2vg==
X-Received: by 2002:a63:586:: with SMTP id 128mr9318675pgf.198.1573308601436;
        Sat, 09 Nov 2019 06:10:01 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id d8sm8829170pfo.47.2019.11.09.06.09.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Nov 2019 06:10:00 -0800 (PST)
Subject: Re: [PATCH] io_uring: account overflows even with
 IORING_SETUP_CQ_NODROP
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
References: <16c996fa-61e9-74b9-bc61-b31ecc085c87@kernel.dk>
 <bad714dd-5c79-df38-1aef-7b8bf1cb1a94@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fa6a39f7-7e1d-7166-abc3-ed78ba9b93c3@kernel.dk>
Date:   Sat, 9 Nov 2019 07:09:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <bad714dd-5c79-df38-1aef-7b8bf1cb1a94@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/9/19 2:59 AM, Pavel Begunkov wrote:
> On 08/11/2019 18:51, Jens Axboe wrote:
>> It's useful for the application to know if the kernel had to dip into
>> using the backlog to prevent overflows. Let's keep on accounting any
>> overflow in cq_ring->overflow, even if we handled it correctly. As it's
>> impossible to get dropped events with IORING_SETUP_CQ_NODROP, overflow
>> with CQ_NODROP enabled simply provides a hint to the application that it
>> may reconsider using a bigger ring.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> ---
>>
>> Since this hasn't been released yet, we can tweak the behavior a bit. I
>> think it makes sense to still account the overflows, even if we handled
>> it correctly. If the application doesn't care, it simply doesn't need to
>> look at cq_ring->overflow if it is using CQ_NODROP. But it may care, as
>> it is less efficient than a suitably sized ring.
>>
>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> index 94ec44caac00..aa3b6149dfe9 100644
>> --- a/fs/io_uring.c
>> +++ b/fs/io_uring.c
>> @@ -666,10 +666,10 @@ static void io_cqring_overflow(struct io_ring_ctx *ctx, struct io_kiocb *req,
>>   			       long res)
>>   	__must_hold(&ctx->completion_lock)
>>   {
>> -	if (!(ctx->flags & IORING_SETUP_CQ_NODROP)) {
>> -		WRITE_ONCE(ctx->rings->cq_overflow,
>> -				atomic_inc_return(&ctx->cached_cq_overflow));
>> -	} else {
>> +	WRITE_ONCE(ctx->rings->cq_overflow,
>> +			atomic_inc_return(&ctx->cached_cq_overflow));
>> +
>> +	if (ctx->flags & IORING_SETUP_CQ_NODROP) {
> 
> We used cq_overflow to fix __io_sequence_defer().
> This breaks the assumption:
> cached_cq_tail + cached_cq_overflow ==
> 	total number of handled completions
> 
> First, we account overflow, and then add it to cq_ring
> (i.e. cached_cq_tail++) in io_cqring_overflow_flush()

Yeah, I realized that later, and also the fact that it makes it awkward
to use in a program because of that. I dropped this patch, thanks
for taking a look at it!

-- 
Jens Axboe

