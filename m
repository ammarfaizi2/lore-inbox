Return-Path: <SRS0=jnAq=ZB=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D6EC43331
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 14:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3190F207FA
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 14:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HWycn4Tg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfKIOO1 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 9 Nov 2019 09:14:27 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46102 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbfKIOO1 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 9 Nov 2019 09:14:27 -0500
Received: by mail-pg1-f195.google.com with SMTP id r18so6005998pgu.13
        for <io-uring@vger.kernel.org>; Sat, 09 Nov 2019 06:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ts/jEoNHlk85ygzkQZRq2+zyzL7VU8Tj36WQ6x8ZIuk=;
        b=HWycn4TgEZDiBo8g1Vt9w66dOtP7qUda4b81xQ8XHfy0Ysp0ifoWnC3iLKoU0Iq2v4
         yntvZepWnxYlsdq9dCsspmN0w+MOe6ShtVUlYAN37ThYDo3z1QZFrUbb1Cq1sSG7zH5l
         1DUWaWUVYDeTsoLKGAkxkIMPksZ0WS7yQmCZ24VagCScW1z5SRIyuR/EwGHmO8hDK9ds
         QVmF16X5RGKCp73YpNhQjCCVfPSrtMyO0kjpvEcB6CWaoiihpfaItVVHAISfzgm1RQSB
         izXL1idVZj7KeBACY0Q0n1fyCJevMl2lsaUUTpG/6CvTThCv9ardi0dpAETs5gDks8+R
         3Sng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ts/jEoNHlk85ygzkQZRq2+zyzL7VU8Tj36WQ6x8ZIuk=;
        b=uPybOWwnsrOAKRA8ACgSRZZBOthDeGa3J7S8VaFI1trLqExgML8b6tC5GG9+8fK/Oe
         DdS2bdsM+AaKR0rBewrWlkXeSOyXI0zFoZ1/KKfbYUrFq6c4URYpYdzYypp/0Dj/Bw2z
         zmB09RYdMGUbTRnbbNNJEo11a3JNWMXDc10U6V0U00mN81UzT1e6/jmPjznxmyTPQARh
         fJYHdLtGByDQZkmCocygWevuqeY3NN1Ad86nitSlYxQqMGPQgbyp6y40h+veneY4zNZ3
         JKuj26e53MR5w75zK1OqlXA7Veef/CuF36Q0XOHKsUoXvaBzoMGc+LyZYiXA/9If+w4O
         42fg==
X-Gm-Message-State: APjAAAUx/i6e0zk+zIcZyoaIyjPCWU1a5qLRNDE7mLyQ5AyArcny49Vo
        9dF+Viv25xxTNQgXJI7gzSJ91A==
X-Google-Smtp-Source: APXvYqw+Rv2cXhaXNvyYcKYJ/nsk+ickua0ctPo0lhliNj20NIUO2Lm4w/z2y+ZO4FH5G1I2sKIQhg==
X-Received: by 2002:a17:90b:d85:: with SMTP id bg5mr2337077pjb.5.1573308866653;
        Sat, 09 Nov 2019 06:14:26 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id l62sm9538826pgl.24.2019.11.09.06.14.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Nov 2019 06:14:25 -0800 (PST)
Subject: Re: [PATCH 3/3] io_uring: add support for backlogged CQ ring
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc:     linux-block@vger.kernel.org, jannh@google.com
References: <20191107160043.31725-1-axboe@kernel.dk>
 <20191107160043.31725-4-axboe@kernel.dk>
 <e9469ed1-dec0-c8ee-ee0a-5e81ee10d1bc@gmail.com>
 <f185bc90-da47-473e-f533-162fed2a872d@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <39b387c8-9440-124a-e491-5847f1d68d2c@kernel.dk>
Date:   Sat, 9 Nov 2019 07:14:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <f185bc90-da47-473e-f533-162fed2a872d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/9/19 5:33 AM, Pavel Begunkov wrote:
> On 11/9/2019 3:25 PM, Pavel Begunkov wrote:
>> On 11/7/2019 7:00 PM, Jens Axboe wrote:
>>> Currently we drop completion events, if the CQ ring is full. That's fine
>>> for requests with bounded completion times, but it may make it harder to
>>> use io_uring with networked IO where request completion times are
>>> generally unbounded. Or with POLL, for example, which is also unbounded.
>>>
>>> This patch adds IORING_SETUP_CQ_NODROP, which changes the behavior a bit
>>> for CQ ring overflows. First of all, it doesn't overflow the ring, it
>>> simply stores a backlog of completions that we weren't able to put into
>>> the CQ ring. To prevent the backlog from growing indefinitely, if the
>>> backlog is non-empty, we apply back pressure on IO submissions. Any
>>> attempt to submit new IO with a non-empty backlog will get an -EBUSY
>>> return from the kernel. This is a signal to the application that it has
>>> backlogged CQ events, and that it must reap those before being allowed
>>> to submit more IO.>
>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>> ---
>>>   fs/io_uring.c                 | 103 ++++++++++++++++++++++++++++------
>>>   include/uapi/linux/io_uring.h |   1 +
>>>   2 files changed, 87 insertions(+), 17 deletions(-)
>>>
>>> +static void io_cqring_overflow_flush(struct io_ring_ctx *ctx, bool force)
>>> +{
>>> +	struct io_rings *rings = ctx->rings;
>>> +	struct io_uring_cqe *cqe;
>>> +	struct io_kiocb *req;
>>> +	unsigned long flags;
>>> +	LIST_HEAD(list);
>>> +
>>> +	if (list_empty_careful(&ctx->cq_overflow_list))
>>> +		return;
>>> +	if (ctx->cached_cq_tail - READ_ONCE(rings->cq.head) ==
>>> +	    rings->cq_ring_entries)
>>> +		return;
>>> +
>>> +	spin_lock_irqsave(&ctx->completion_lock, flags);
>>> +
>>> +	while (!list_empty(&ctx->cq_overflow_list)) {
>>> +		cqe = io_get_cqring(ctx);
>>> +		if (!cqe && !force)
>>> +			break;> +
>>> +		req = list_first_entry(&ctx->cq_overflow_list, struct io_kiocb,
>>> +						list);
>>> +		list_move(&req->list, &list);
>>> +		if (cqe) {
>>> +			WRITE_ONCE(cqe->user_data, req->user_data);
>>> +			WRITE_ONCE(cqe->res, req->result);
>>> +			WRITE_ONCE(cqe->flags, 0);
>>> +		}
>>
>> Hmm, second thought. We should account overflow here.
>>
> Clarification: We should account overflow in case of (!cqe).
> 
> i.e.
> if (!cqe) { // else
> 	WRITE_ONCE(ctx->rings->cq_overflow,
> 			atomic_inc_return(&ctx->cached_cq_overflow));
> }

Ah yes, we should, even if this is only the flush path. I'll send out
a patch for that, unless you beat me to it.

-- 
Jens Axboe

