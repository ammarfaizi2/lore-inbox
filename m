Return-Path: <SRS0=jnAq=ZB=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7F8C43331
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 12:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFEE021924
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 12:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlkvE71c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfKIMdW (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 9 Nov 2019 07:33:22 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35905 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfKIMdW (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 9 Nov 2019 07:33:22 -0500
Received: by mail-lj1-f196.google.com with SMTP id k15so9002976lja.3;
        Sat, 09 Nov 2019 04:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y3F/zLWh0I4G30mmRjAB8S+rRfK9ZMoVepRjcfOush4=;
        b=hlkvE71cEuR5iVaLs9LesPM2xGjhcekwEGynazinviyN1+z0+YWxZPYQ0QJM3KLxuB
         NGPeByfCukDi9DO/1e3N/1rE29Edy+0FtzAgPsI+/a9YBHDA5X+b8aTht+Y0l45q1Zjo
         dFMq0ao1xmLQGvVouCW6Prw1AnHwtyndjUq8lmVX3wXNuwxIyXEZ1TnrZnyl5zNAygsj
         NNI2Xz9kATSLIgFr7WFSoj7dZxpOol+Kg/zEtzpgOlCs6r/EHKFzUWi4dseGrjuRfM+6
         Vaxjv+3Vh+MTQGf9P9VufRrATaF3xD3sxPerB1thnXEev6bnENdc39vkoOK3viPgmirv
         yuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y3F/zLWh0I4G30mmRjAB8S+rRfK9ZMoVepRjcfOush4=;
        b=FhdZ1lRmTsCncibEyNBU+9KmmGeBFVHrc+C6nnrzezjHSoYSYLzYRCLL1NIIQogkS/
         TjEc8yTrSWwB44hfh4+n1/CPJLM0BsdWjdGsr/C5nkUuL0QAXqcrcWFd+LEBUnAohDE1
         Ei4+H52M86c8cVn6rC2rvqDwtpzfesFX8Y7ymkb4TTIrk6HumfnIK1OU6LvGT0kmwcLx
         Rs+ibQieA2SzYiAPhM5WJZ11NPScwlW8nRcmld0NpxIWu7LqTJjNqSevM3L9VyszOIW1
         ypCkzrEDCk6I0938KZundGJ2lHuhLdidcFBrnEMGmE74S4+weZbjZeaQIx+d03DoaLEw
         kCMA==
X-Gm-Message-State: APjAAAXi4AU8h0tNBCgbBeXOkxuXtfNZT5oAuf1Cwrvd4v5+aEbFbO05
        H074YPm/GxRqGBnCd66UyxM=
X-Google-Smtp-Source: APXvYqzttUjepdRabgPWX0jTDRr2D3IMMf0wicn8IiF+NRZ/Hn04b6StzfwsPlUI+zcf6EPau6TL7g==
X-Received: by 2002:a2e:88c1:: with SMTP id a1mr10314166ljk.204.1573302800250;
        Sat, 09 Nov 2019 04:33:20 -0800 (PST)
Received: from [172.31.190.83] ([86.57.146.226])
        by smtp.gmail.com with ESMTPSA id z17sm4030919ljm.16.2019.11.09.04.33.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Nov 2019 04:33:19 -0800 (PST)
Subject: Re: [PATCH 3/3] io_uring: add support for backlogged CQ ring
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Cc:     linux-block@vger.kernel.org, jannh@google.com
References: <20191107160043.31725-1-axboe@kernel.dk>
 <20191107160043.31725-4-axboe@kernel.dk>
 <e9469ed1-dec0-c8ee-ee0a-5e81ee10d1bc@gmail.com>
Message-ID: <f185bc90-da47-473e-f533-162fed2a872d@gmail.com>
Date:   Sat, 9 Nov 2019 15:33:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <e9469ed1-dec0-c8ee-ee0a-5e81ee10d1bc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/9/2019 3:25 PM, Pavel Begunkov wrote:
> On 11/7/2019 7:00 PM, Jens Axboe wrote:
>> Currently we drop completion events, if the CQ ring is full. That's fine
>> for requests with bounded completion times, but it may make it harder to
>> use io_uring with networked IO where request completion times are
>> generally unbounded. Or with POLL, for example, which is also unbounded.
>>
>> This patch adds IORING_SETUP_CQ_NODROP, which changes the behavior a bit
>> for CQ ring overflows. First of all, it doesn't overflow the ring, it
>> simply stores a backlog of completions that we weren't able to put into
>> the CQ ring. To prevent the backlog from growing indefinitely, if the
>> backlog is non-empty, we apply back pressure on IO submissions. Any
>> attempt to submit new IO with a non-empty backlog will get an -EBUSY
>> return from the kernel. This is a signal to the application that it has
>> backlogged CQ events, and that it must reap those before being allowed
>> to submit more IO.>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> ---
>>  fs/io_uring.c                 | 103 ++++++++++++++++++++++++++++------
>>  include/uapi/linux/io_uring.h |   1 +
>>  2 files changed, 87 insertions(+), 17 deletions(-)
>>
>> +static void io_cqring_overflow_flush(struct io_ring_ctx *ctx, bool force)
>> +{
>> +	struct io_rings *rings = ctx->rings;
>> +	struct io_uring_cqe *cqe;
>> +	struct io_kiocb *req;
>> +	unsigned long flags;
>> +	LIST_HEAD(list);
>> +
>> +	if (list_empty_careful(&ctx->cq_overflow_list))
>> +		return;
>> +	if (ctx->cached_cq_tail - READ_ONCE(rings->cq.head) ==
>> +	    rings->cq_ring_entries)
>> +		return;
>> +
>> +	spin_lock_irqsave(&ctx->completion_lock, flags);
>> +
>> +	while (!list_empty(&ctx->cq_overflow_list)) {
>> +		cqe = io_get_cqring(ctx);
>> +		if (!cqe && !force)
>> +			break;> +
>> +		req = list_first_entry(&ctx->cq_overflow_list, struct io_kiocb,
>> +						list);
>> +		list_move(&req->list, &list);
>> +		if (cqe) {
>> +			WRITE_ONCE(cqe->user_data, req->user_data);
>> +			WRITE_ONCE(cqe->res, req->result);
>> +			WRITE_ONCE(cqe->flags, 0);
>> +		}
> 
> Hmm, second thought. We should account overflow here.
> 
Clarification: We should account overflow in case of (!cqe).

i.e.
if (!cqe) { // else
	WRITE_ONCE(ctx->rings->cq_overflow,
			atomic_inc_return(&ctx->cached_cq_overflow));
}

>> +	}
>> +
>> +	io_commit_cqring(ctx);
>> +	spin_unlock_irqrestore(&ctx->completion_lock, flags);
>> +	io_cqring_ev_posted(ctx);
>> +
>> +	while (!list_empty(&list)) {
>> +		req = list_first_entry(&list, struct io_kiocb, list);
>> +		list_del(&req->list);
>> +		io_put_req(req, NULL);
>> +	}
>> +}
>> +

-- 
Pavel Begunkov
