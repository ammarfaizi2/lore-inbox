Return-Path: <SRS0=BBHt=ZN=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611F9C432C0
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 01:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30DE120730
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 01:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dvefabIG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbfKUBkA (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 20 Nov 2019 20:40:00 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33102 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfKUBj7 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 20 Nov 2019 20:39:59 -0500
Received: by mail-pf1-f194.google.com with SMTP id c184so786553pfb.0
        for <io-uring@vger.kernel.org>; Wed, 20 Nov 2019 17:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p7bJlJ/zNwSh7pUpwJIhsHVHddmtbrzVuwIa1NLI+uM=;
        b=dvefabIGrXMpJMbc3aHHzITxoNqTssRSkJyZSRra/P75ImpMwtiMJFH4UbW1Q0iPWc
         hg9AUDCMyKl7fqKht7LHFOZY7AmP1Sxg3k4x4l/1xN0Ca0AS2bkwnKiXFmYPhKq7e/BY
         ypmTobhV6Zqt/X7WahoJ+CkRz4oXqgpe81nRujygABwGfLnC/dFzi0OBWbTccE1RgSMe
         u9HI7YjNYIHbwa4DS4P5Lrk9T704vFDYDG+o2Yjj1v5sje4vU3VnUsD5drGX7qIsm0YJ
         5XoT42xVOR3hUS+jpZBREsGr0ZPC6TvHTnzNS9oa3FXuRhcFRhRQD22qNu7nMZCf7ir0
         oRHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p7bJlJ/zNwSh7pUpwJIhsHVHddmtbrzVuwIa1NLI+uM=;
        b=mav5NreYGowJk8TK1RINgdOCELhSe7gJ8HIs8UbbE6JRHNz6Fjtsb1blGhdx9H7+8T
         eEQAwchxFP4RanFIV26n36gXrOi62Q+EBSjNdofl+4Oe905n660537DNpe89ryDioWva
         L4gjKRXz5Jqkjhn7JdoRam2onyeP8L12J+5jI8nTYObvat0u8Ze6N+mbb8aPXP2/2qlA
         kH6QEyaRLeLpaU+TEQgU6gOn0d44MDu0mG95ZrhGYBNualF7rjVLq3itOcsP4lMoHS27
         csQHQay4Xg7prHEfZJmuJpCoGv95GHNZH4vbTw8KNIlUBwHHSiv6oyCfu7Z5CJt2w6pz
         17HQ==
X-Gm-Message-State: APjAAAUnXK3hP8NeaY4Dn9Ofm5Q1hDSQg0DCKoVZWkDpA5+qqVQ5FuIp
        0mof/vKRb06Ry6M3KYcSyZYnOTNhdNTXLA==
X-Google-Smtp-Source: APXvYqwE4UFSZApJ55mWYONXnj1Sfyzu42oW3E7YRkkK+1h7Y167h7MS/iuODto0csScTTwhXpALAw==
X-Received: by 2002:a62:fb0e:: with SMTP id x14mr7727267pfm.194.1574300398034;
        Wed, 20 Nov 2019 17:39:58 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id c1sm498471pjc.23.2019.11.20.17.39.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 17:39:57 -0800 (PST)
Subject: Re: [PATCH] io_uring: fix race with shadow drain deferrals
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     io-uring@vger.kernel.org
References: <27c153ee-cfc8-3251-a874-df85a033429a@kernel.dk>
 <cabb202a-a405-9f36-0363-1548f1b4dfd4@kernel.dk>
 <1C6D35BF-C89B-4AB9-83CD-0A6B676E4752@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1020a3ef-d9e5-88b6-0ab7-a30d8b057bd0@kernel.dk>
Date:   Wed, 20 Nov 2019 18:39:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1C6D35BF-C89B-4AB9-83CD-0A6B676E4752@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/20/19 6:32 PM, Jackie Liu wrote:
> 2019年11月21日 07:58，Jens Axboe <axboe@kernel.dk> 写道：
> 
>>
>> On 11/20/19 4:07 PM, Jens Axboe wrote:
>>> When we go and queue requests with drain, we check if we need to defer
>>> based on sequence. This is done safely under the lock, but then we drop
>>> the lock before actually inserting the shadow. If the original request
>>> is found on the deferred list by another completion in the mean time,
>>> it could have been started AND completed by the time we insert the
>>> shadow, which will stall the queue.
>>>
>>> After re-grabbing the completion lock, check if the original request is
>>> still in the deferred list. If it isn't, then we know that someone else
>>> already found and issued it. If that happened, then our job is done, we
>>> can simply free the shadow.
>>>
>>> Cc: Jackie Liu <liuyun01@kylinos.cn>
>>> Fixes: 4fe2c963154c ("io_uring: add support for link with drain")
>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> BTW, the other solution here is to not release the completion_lock if
>> we're going to return -EIOCBQUEUED, and let the caller do what it needs
>> before releasing it. That'd look something like this, with some sparse
>> annotations to keep things happy.
>>
>> I think the original I posted here is easier to follow, and the
>> deferral list is going to be tiny in general so it won't really add
>> any extra overhead.
>>
>> Let me know what you think and prefer.
>>
>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> index 6175e2e195c0..0d1f33bcedc0 100644
>> --- a/fs/io_uring.c
>> +++ b/fs/io_uring.c
>> @@ -2552,6 +2552,11 @@ static int io_async_cancel(struct io_kiocb *req, const struct io_uring_sqe *sqe,
>> 	return 0;
>> }
>>
>> +/*
>> + * Returns with ctx->completion_lock held if -EIOCBQUEUED is returned, so
>> + * the caller can make decisions based on the deferral without worrying about
>> + * the request being found and issued in the mean time.
>> + */
>> static int io_req_defer(struct io_kiocb *req)
>> {
>> 	const struct io_uring_sqe *sqe = req->submit.sqe;
>> @@ -2579,7 +2584,7 @@ static int io_req_defer(struct io_kiocb *req)
>>
>> 	trace_io_uring_defer(ctx, req, false);
>> 	list_add_tail(&req->list, &ctx->defer_list);
>> -	spin_unlock_irq(&ctx->completion_lock);
>> +	__release(&ctx->completion_lock);
>> 	return -EIOCBQUEUED;
>> }
>>
>> @@ -2954,6 +2959,7 @@ static void __io_queue_sqe(struct io_kiocb *req)
>>
>> static void io_queue_sqe(struct io_kiocb *req)
>> {
>> +	struct io_ring_ctx *ctx = req->ctx;
>> 	int ret;
>>
>> 	ret = io_req_defer(req);
>> @@ -2963,6 +2969,9 @@ static void io_queue_sqe(struct io_kiocb *req)
>> 			if (req->flags & REQ_F_LINK)
>> 				req->flags |= REQ_F_FAIL_LINK;
>> 			io_double_put_req(req);
>> +		} else {
>> +			__acquire(&ctx->completion_lock);
>> +			spin_unlock_irq(&ctx->completion_lock);
>> 		}
>> 	} else
>> 		__io_queue_sqe(req);
>> @@ -3001,16 +3010,17 @@ static void io_queue_link_head(struct io_kiocb *req, struct io_kiocb *shadow)
>> 				__io_free_req(shadow);
>> 			return;
>> 		}
>> +		__acquire(&ctx->completion_lock);
>> 	} else {
>> 		/*
>> 		 * If ret == 0 means that all IOs in front of link io are
>> 		 * running done. let's queue link head.
>> 		 */
>> 		need_submit = true;
>> +		spin_lock_irq(&ctx->completion_lock);
>> 	}
>>
>> 	/* Insert shadow req to defer_list, blocking next IOs */
>> -	spin_lock_irq(&ctx->completion_lock);
>> 	trace_io_uring_defer(ctx, shadow, true);
>> 	list_add_tail(&shadow->list, &ctx->defer_list);
>> 	spin_unlock_irq(&ctx->completion_lock);
> 
> This is indeed a potential lock issue, thanks, I am prefer this solution, clearer than first one.
> But It may be a bit difficult for other people who read the code, use 'io_req_defer_may_lock'?
> 
> who about this?

I really don't think that improves it, I'm afraid. The ugly part is not
the naming, it's the fact that -EIOCBQUEUED returns with the lock held
and having to deal with that. It would be cleaner to have a helper that
just has the lock held, but that is difficult to do since we also need
the sqe copy allocation.

There's also an issue with your patch and the unconditional unlock...

-- 
Jens Axboe

