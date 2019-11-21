Return-Path: <SRS0=BBHt=ZN=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57005C432C0
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 01:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D43820730
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 01:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NK7qY1jC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfKUBkr (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 20 Nov 2019 20:40:47 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42313 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfKUBkq (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 20 Nov 2019 20:40:46 -0500
Received: by mail-pl1-f193.google.com with SMTP id j12so736730plt.9
        for <io-uring@vger.kernel.org>; Wed, 20 Nov 2019 17:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s2hSQtWwig9zpIXP+oa4cH71u2kb2zMsBLvAaIpg+gw=;
        b=NK7qY1jCOJcYA67ZxiUjehMXZnnQhRpNUZKHXdav37US48HIP5nIZ6dKVpeBzpwYh1
         XtldbVxe7Zt+m2BPaADwCG0AFBBD9r2uKSxd9hJTD1fxuHhwYBn19feZj8NotLvoj0+M
         MoJVEQAob8Fu5F2yjjpNA6AywjZIJBrM0PVC6xR+pqClkT6ozZPridqR5pDGvNShKw7Q
         je5QglaWfzYiZTVj1WOpUUbZONdvVBGlUjL1K8uAWNArpmC+OLq37VlQjNIVfvudrPPA
         5QPYQKnuUGohmI5ArQ1Q+O3IzwiSzz4rVSdU3kBbmjdwrpASoIVaQD47Gnn8WV5QX54p
         XOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s2hSQtWwig9zpIXP+oa4cH71u2kb2zMsBLvAaIpg+gw=;
        b=VVRQC34qpAKTPv1t+a6iP/EOsS5kVXWozZS694QTfMCJwowbgsqR7DLeOBsC4faFH6
         ykMW9DQKTQvwgVBav/DWgip9uqjnNCGwdox1P7CRCDnpCparK7goEJINWTr9DKipoed0
         luh3/8Np/LhHMuvNSUL0O6Qioxz2/wJALPNoIbakX73jAZ9Fm/sdYi+PkjwXdM0qPOEJ
         42YqsXpBAxlaE5VCOqVbExvbfuu4T3O8NeFDCFufX/2AgrlfQnMzsThqHjIDPnj2JfQ0
         D/Hv4IwAzR74G4AKE6rtr2wA9T9C9tM6dzxfNA1I6Ta/24g1/vSVo+FdRfQBXjnN9iQY
         JhNg==
X-Gm-Message-State: APjAAAX1b0UV8uavsR9k8FLnwK26mT1eshC8pmMqmYxeAjj952jYHrVL
        qNTLllV52B5at6yO59ukG6fVQNTt0uZleg==
X-Google-Smtp-Source: APXvYqw9rTQgd9f9mz6tiishAxQEQ+Kp3/8U9YLW9d96GBRab//VnPKFZi/RCWwI7vJFq968qJwMwg==
X-Received: by 2002:a17:90a:8990:: with SMTP id v16mr8019789pjn.114.1574300445247;
        Wed, 20 Nov 2019 17:40:45 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id 83sm469261pgh.86.2019.11.20.17.40.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 17:40:44 -0800 (PST)
Subject: Re: [PATCH] io_uring: fix race with shadow drain deferrals
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     io-uring@vger.kernel.org
References: <27c153ee-cfc8-3251-a874-df85a033429a@kernel.dk>
 <cabb202a-a405-9f36-0363-1548f1b4dfd4@kernel.dk>
 <1C6D35BF-C89B-4AB9-83CD-0A6B676E4752@kylinos.cn>
 <890E4F5B-DDA2-40EF-B7AD-3C63EFA20D93@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b70c7e29-408c-af72-5dc1-85456c904c7a@kernel.dk>
Date:   Wed, 20 Nov 2019 18:40:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <890E4F5B-DDA2-40EF-B7AD-3C63EFA20D93@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/20/19 6:35 PM, Jackie Liu wrote:
> 
> 
>> 2019年11月21日 09:32，Jackie Liu <liuyun01@kylinos.cn> 写道：
>>
>> 2019年11月21日 07:58，Jens Axboe <axboe@kernel.dk> 写道：
>>
>>>
>>> On 11/20/19 4:07 PM, Jens Axboe wrote:
>>>> When we go and queue requests with drain, we check if we need to defer
>>>> based on sequence. This is done safely under the lock, but then we drop
>>>> the lock before actually inserting the shadow. If the original request
>>>> is found on the deferred list by another completion in the mean time,
>>>> it could have been started AND completed by the time we insert the
>>>> shadow, which will stall the queue.
>>>>
>>>> After re-grabbing the completion lock, check if the original request is
>>>> still in the deferred list. If it isn't, then we know that someone else
>>>> already found and issued it. If that happened, then our job is done, we
>>>> can simply free the shadow.
>>>>
>>>> Cc: Jackie Liu <liuyun01@kylinos.cn>
>>>> Fixes: 4fe2c963154c ("io_uring: add support for link with drain")
>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>
>>> BTW, the other solution here is to not release the completion_lock if
>>> we're going to return -EIOCBQUEUED, and let the caller do what it needs
>>> before releasing it. That'd look something like this, with some sparse
>>> annotations to keep things happy.
>>>
>>> I think the original I posted here is easier to follow, and the
>>> deferral list is going to be tiny in general so it won't really add
>>> any extra overhead.
>>>
>>> Let me know what you think and prefer.
>>>
>>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>>> index 6175e2e195c0..0d1f33bcedc0 100644
>>> --- a/fs/io_uring.c
>>> +++ b/fs/io_uring.c
>>> @@ -2552,6 +2552,11 @@ static int io_async_cancel(struct io_kiocb *req, const struct io_uring_sqe *sqe,
>>> 	return 0;
>>> }
>>>
>>> +/*
>>> + * Returns with ctx->completion_lock held if -EIOCBQUEUED is returned, so
>>> + * the caller can make decisions based on the deferral without worrying about
>>> + * the request being found and issued in the mean time.
>>> + */
>>> static int io_req_defer(struct io_kiocb *req)
>>> {
>>> 	const struct io_uring_sqe *sqe = req->submit.sqe;
>>> @@ -2579,7 +2584,7 @@ static int io_req_defer(struct io_kiocb *req)
>>>
>>> 	trace_io_uring_defer(ctx, req, false);
>>> 	list_add_tail(&req->list, &ctx->defer_list);
>>> -	spin_unlock_irq(&ctx->completion_lock);
>>> +	__release(&ctx->completion_lock);
>>> 	return -EIOCBQUEUED;
>>> }
>>>
>>> @@ -2954,6 +2959,7 @@ static void __io_queue_sqe(struct io_kiocb *req)
>>>
>>> static void io_queue_sqe(struct io_kiocb *req)
>>> {
>>> +	struct io_ring_ctx *ctx = req->ctx;
>>> 	int ret;
>>>
>>> 	ret = io_req_defer(req);
>>> @@ -2963,6 +2969,9 @@ static void io_queue_sqe(struct io_kiocb *req)
>>> 			if (req->flags & REQ_F_LINK)
>>> 				req->flags |= REQ_F_FAIL_LINK;
>>> 			io_double_put_req(req);
>>> +		} else {
>>> +			__acquire(&ctx->completion_lock);
>>> +			spin_unlock_irq(&ctx->completion_lock);
>>> 		}
>>> 	} else
>>> 		__io_queue_sqe(req);
>>> @@ -3001,16 +3010,17 @@ static void io_queue_link_head(struct io_kiocb *req, struct io_kiocb *shadow)
>>> 				__io_free_req(shadow);
>>> 			return;
>>> 		}
>>> +		__acquire(&ctx->completion_lock);
>>> 	} else {
>>> 		/*
>>> 		 * If ret == 0 means that all IOs in front of link io are
>>> 		 * running done. let's queue link head.
>>> 		 */
>>> 		need_submit = true;
>>> +		spin_lock_irq(&ctx->completion_lock);
>>> 	}
>>>
>>> 	/* Insert shadow req to defer_list, blocking next IOs */
>>> -	spin_lock_irq(&ctx->completion_lock);
>>> 	trace_io_uring_defer(ctx, shadow, true);
>>> 	list_add_tail(&shadow->list, &ctx->defer_list);
>>> 	spin_unlock_irq(&ctx->completion_lock);
>>
>> This is indeed a potential lock issue, thanks, I am prefer this solution, clearer than first one.
>> But It may be a bit difficult for other people who read the code, use 'io_req_defer_may_lock'?
>>
>> who about this?
>>
>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>> index 5ad652f..6fdaeb1 100644
>> --- a/fs/io_uring.c
>> +++ b/fs/io_uring.c
>> @@ -2469,7 +2469,7 @@ static int io_async_cancel(struct io_kiocb *req, const struct io_uring_sqe *sqe,
>>         return 0;
>> }
>>
>> -static int io_req_defer(struct io_kiocb *req)
>> +static int __io_req_defer(struct io_kiocb *req)
>> {
>>         const struct io_uring_sqe *sqe = req->submit.sqe;
>>         struct io_uring_sqe *sqe_copy;
>> @@ -2495,8 +2495,21 @@ static int io_req_defer(struct io_kiocb *req)
>>
>>         trace_io_uring_defer(ctx, req, false);
>>         list_add_tail(&req->list, &ctx->defer_list);
>> +
>> +       return -EIOCBQUEUED;
>> +}
>> +
>> +static int io_req_defer(struct io_kiocb *req)
>> +{
>> +       int ret = __io_req_defer(req);
> 
> There have an problem, need fix.
> 
> static int io_req_defer(struct io_kiocb *req)
> {
> 	int ret = __io_req_defer(req);
> 	if (ret == -EIOCBQUEUED)
> 		spin_unlock_irq(&ctx->completion_lock);
> 	return ret;
> }

Mid-air collision, indeed.

But as I wrote in the previous email, I don't think this one improves on
the situation... And fwiw, I did test both of mine, both are verified to
fix the issue.

-- 
Jens Axboe

