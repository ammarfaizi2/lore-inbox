Return-Path: <SRS0=PUae=Y6=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF39C5DF63
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 20:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A88F2084D
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 20:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jPKMpqO+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731934AbfKFUI5 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 6 Nov 2019 15:08:57 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:34273 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbfKFUI5 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 6 Nov 2019 15:08:57 -0500
Received: by mail-il1-f195.google.com with SMTP id p6so10215665ilp.1
        for <io-uring@vger.kernel.org>; Wed, 06 Nov 2019 12:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Hya+nyz20/XqWABtHx4xC5HfBPnfc1pxfXEy+pnWSwg=;
        b=jPKMpqO+CZUqGgZhTDQRdPVk2mGJ4FK07A97rfjGVybzZwfPvkDOl0Y2IG51QCCNCP
         FYKd4D5UoZ6x5CP3tV1n8VcsrxT+EsPl6E4b1djCHcp1FQN0e/HIowFOZjktu5TgNrgI
         mNp1K8pCqkAfNXxg9XhHwVrLBZ44ese8VeiCDdr9LpEmE+ROJxlQGbTevJ/oqeNjxCiF
         DJXdtKXxP0IRTp8tU1di1CrWXJOHLpyS/MwFz7/kO7kguSqSnl3B+FTHs9+arqNPCrbp
         BPDDS/EOy62B4QeuWYPXkMRwrmEl/FcRhhoczKHPzbgaHZvD5MVH6mfjtjsX9YdnlMgh
         UlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hya+nyz20/XqWABtHx4xC5HfBPnfc1pxfXEy+pnWSwg=;
        b=Jt+o6pIeHIUDv0GqEBMtTU/3JxHKOCQB6oTsBpU+o/yvgfPfqLsmGyt3VmNed1ufdh
         lfYQqi3DKW1sq1VgzKJwuEqxBFYNsRjvu4NLBuWwMkzSASu2eksYsypm6r1rWI5I7IMX
         TCSnbQ0CiIL14SCbYbPgcabpKYqwPCn56R7tPLLHAR6Zt+pAHIyZinD6VGH8gqdFG3Lr
         FL6FGlBCZK8Z6BbZ4DPOvKKNGBzubQeYncE8oljH6b4nsQ4FAOD91NYKYOtWm70jputq
         Umjh5v/3m4KgogQ+80JCnnImyKRTu2flkBvQUJ/Y7kqieWr64M720slnMNNpE849wbUR
         KGZA==
X-Gm-Message-State: APjAAAVQG2Jyk3fWdWppmFwCWh58YTt0G6M0Aiq5QnIDseJKNhb9vsA6
        fEBX5ItEEuo1wefN+N71YBpo4rh5y3Q=
X-Google-Smtp-Source: APXvYqygeTGfEzsavFTi/5vMqgQEWJfS3f9e1VwkBYNMYlv13cxZL220uvSYTadEKgHaYUf2Y70tUg==
X-Received: by 2002:a92:79d2:: with SMTP id u201mr4992009ilc.103.1573070936312;
        Wed, 06 Nov 2019 12:08:56 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u9sm124262ior.46.2019.11.06.12.08.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 12:08:55 -0800 (PST)
Subject: Re: [RFC] io_uring CQ ring backpressure
To:     Jann Horn <jannh@google.com>
Cc:     io-uring@vger.kernel.org,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <37d8ba3d-27c7-7636-0343-23ec56e4bee7@kernel.dk>
 <CAG48ez1_91Lk73sdpp1SiufOQShdP2zX6g9gMLW46gAvMioKOA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c01e91d3-0f20-00e9-e2c6-e4148f667fb6@kernel.dk>
Date:   Wed, 6 Nov 2019 13:08:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez1_91Lk73sdpp1SiufOQShdP2zX6g9gMLW46gAvMioKOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/6/19 12:51 PM, Jann Horn wrote:
> On Wed, Nov 6, 2019 at 5:23 PM Jens Axboe <axboe@kernel.dk> wrote:
>> Currently we drop completion events, if the CQ ring is full. That's fine
>> for requests with bounded completion times, but it may make it harder to
>> use io_uring with networked IO where request completion times are
>> generally unbounded. Or with POLL, for example, which is also unbounded.
>>
>> This patch adds IORING_SETUP_CQ_NODROP, which changes the behavior a bit
>> for CQ ring overflows. First of all, it doesn't overflow the ring, it
>> simply stores backlog of completions that we weren't able to put into
>> the CQ ring. To prevent the backlog from growing indefinitely, if the
>> backlog is non-empty, we apply back pressure on IO submissions. Any
>> attempt to submit new IO with a non-empty backlog will get an -EBUSY
>> return from the kernel.
>>
>> I think that makes for a pretty sane API in terms of how the application
>> can handle it. With CQ_NODROP enabled, we'll never drop a completion
>> event (well unless we're totally out of memory...), but we'll also not
>> allow submissions with a completion backlog.
> [...]
>> +static void io_cqring_overflow(struct io_ring_ctx *ctx, u64 ki_user_data,
>> +                              long res)
>> +       __must_hold(&ctx->completion_lock)
>> +{
>> +       struct cqe_drop *drop;
>> +
>> +       if (!(ctx->flags & IORING_SETUP_CQ_NODROP)) {
>> +log_overflow:
>> +               WRITE_ONCE(ctx->rings->cq_overflow,
>> +                               atomic_inc_return(&ctx->cached_cq_overflow));
>> +               return;
>> +       }
>> +
>> +       drop = kmalloc(sizeof(*drop), GFP_ATOMIC);
>> +       if (!drop)
>> +               goto log_overflow;
>> +
>> +       drop->user_data = ki_user_data;
>> +       drop->res = res;
>> +       list_add_tail(&drop->list, &ctx->cq_overflow_list);
>> +}
> 
> This could potentially consume moderately large amounts of atomic
> memory quickly and without any guarantee that the memory will be freed
> anytime soon, right? That seems moderately bad. Is there no way to
> e.g. pre-reserve memory for completion events, or something like that?

As soon as there's even one entry in that backlog, the ring won't accept
anymore new IO. So I don't think it's a huge concern. If we pre-reserve,
we haven't really made much progress in making sure we don't drop events,
and we'll be tying up that memory all the time.

The alternative, as Pavel also mentioned, is to re-use the io_kiocb
for this. But that'll tie up more memory, and it's a bit tricky with
the life times. Just because the request has completed doesn't mean
that someone isn't still holding a reference to it, and who knows
what they will do.

-- 
Jens Axboe

