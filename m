Return-Path: <SRS0=BBHt=ZN=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0061C432C0
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 01:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5502084D
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 01:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HZk/Snjd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbfKUBte (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 20 Nov 2019 20:49:34 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34079 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfKUBtd (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 20 Nov 2019 20:49:33 -0500
Received: by mail-pg1-f193.google.com with SMTP id z188so733624pgb.1
        for <io-uring@vger.kernel.org>; Wed, 20 Nov 2019 17:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HDgcxSR6bDy1DabmfEMIOg4i4jQkbhjU4frvZis2j6w=;
        b=HZk/SnjdPJizAdzCArrFE0lK50J2UQNRiuW1c9g21jYTIQh4S4bCntKwm7lrwDZCui
         s7A0bQv4mmLphTdhu3LPpvHWo4i3MqSE5eT0WKjtDcM8ul3k3qZS0pBtIT++83F94r6D
         q29s6HxxwX7olqIqTdIBbM3qsexS7tsfxlw2ZEdIfcR2Oercx5Esd5t5f7f/9VlmzV5Z
         pltztsi34DtaJXvemBuQtlvw42FOwpmpMMYJevYH5jWHnTVC7sE/A2sRLvdAXERJ31jw
         ZJ1n/kt6E3rHyk5NbdQD8PIatNnDB/Q/XG+GKe6vi5WybHe4S/xRWSbjpJXo+z89jG6h
         ZYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HDgcxSR6bDy1DabmfEMIOg4i4jQkbhjU4frvZis2j6w=;
        b=bHQyz5iFVRq/WFvdCQbUCCjvxrzH/nSRVsuwp+9EEPxpuJTnVi/YpYbE0ip4qOzVvF
         VEwT0lHzltJuW/ZUbyY22ZYg3xA5id1BSJ5cuUyMCVwqrUztQZeningM62EBfQYCssdU
         x9mH3aMlg1oRqoc1CQj3etVfZaMcwqYMwERdb1cjc7MBWk06yR0fjrYL2NmMjlzWEYZC
         dNTfKzZhPPTAu3tNLl+WxUCDyUlRDOGwk0xygHiflAV0+krPBEist0xh33JHkaDUlyb4
         tDs6Sl4bHPyk1jSLn3tQgAfWhlDAughqlLgwJYcjgZIUPL7+/eBMhi8z2kiEUt1y/n2f
         wBNg==
X-Gm-Message-State: APjAAAXKFjoyR1xpxuA95939mT+dlztnQhaJbdGglIHVg2GnLA8dECmR
        YuJw/bVHq5sF8qvfWBIqFwyc/14YlDNcng==
X-Google-Smtp-Source: APXvYqyp7JEvBw2Ngo09PvAlAmz8XLjlxYa3cj+sDHKLiP9vC0v3N2eoxIi4TvILHcuHrC1RazKAxw==
X-Received: by 2002:a63:fc1e:: with SMTP id j30mr6277411pgi.98.1574300972316;
        Wed, 20 Nov 2019 17:49:32 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id n72sm525079pjc.4.2019.11.20.17.49.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 17:49:31 -0800 (PST)
Subject: Re: [PATCH] io_uring: fix race with shadow drain deferrals
From:   Jens Axboe <axboe@kernel.dk>
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     io-uring@vger.kernel.org
References: <27c153ee-cfc8-3251-a874-df85a033429a@kernel.dk>
 <cabb202a-a405-9f36-0363-1548f1b4dfd4@kernel.dk>
 <1C6D35BF-C89B-4AB9-83CD-0A6B676E4752@kylinos.cn>
 <890E4F5B-DDA2-40EF-B7AD-3C63EFA20D93@kylinos.cn>
 <b70c7e29-408c-af72-5dc1-85456c904c7a@kernel.dk>
Message-ID: <2005c339-5ed3-6c2e-f011-5bc89dac3f5c@kernel.dk>
Date:   Wed, 20 Nov 2019 18:49:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b70c7e29-408c-af72-5dc1-85456c904c7a@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/20/19 6:40 PM, Jens Axboe wrote:
> On 11/20/19 6:35 PM, Jackie Liu wrote:
>>
>>
>>> 2019年11月21日 09:32，Jackie Liu <liuyun01@kylinos.cn> 写道：
>>>
>>> 2019年11月21日 07:58，Jens Axboe <axboe@kernel.dk> 写道：
>>>
>>>>
>>>> On 11/20/19 4:07 PM, Jens Axboe wrote:
>>>>> When we go and queue requests with drain, we check if we need to defer
>>>>> based on sequence. This is done safely under the lock, but then we drop
>>>>> the lock before actually inserting the shadow. If the original request
>>>>> is found on the deferred list by another completion in the mean time,
>>>>> it could have been started AND completed by the time we insert the
>>>>> shadow, which will stall the queue.
>>>>>
>>>>> After re-grabbing the completion lock, check if the original request is
>>>>> still in the deferred list. If it isn't, then we know that someone else
>>>>> already found and issued it. If that happened, then our job is done, we
>>>>> can simply free the shadow.
>>>>>
>>>>> Cc: Jackie Liu <liuyun01@kylinos.cn>
>>>>> Fixes: 4fe2c963154c ("io_uring: add support for link with drain")
>>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>>
>>>> BTW, the other solution here is to not release the completion_lock if
>>>> we're going to return -EIOCBQUEUED, and let the caller do what it needs
>>>> before releasing it. That'd look something like this, with some sparse
>>>> annotations to keep things happy.
>>>>
>>>> I think the original I posted here is easier to follow, and the
>>>> deferral list is going to be tiny in general so it won't really add
>>>> any extra overhead.
>>>>
>>>> Let me know what you think and prefer.
>>>>
>>>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>>>> index 6175e2e195c0..0d1f33bcedc0 100644
>>>> --- a/fs/io_uring.c
>>>> +++ b/fs/io_uring.c
>>>> @@ -2552,6 +2552,11 @@ static int io_async_cancel(struct io_kiocb *req, const struct io_uring_sqe *sqe,
>>>> 	return 0;
>>>> }
>>>>
>>>> +/*
>>>> + * Returns with ctx->completion_lock held if -EIOCBQUEUED is returned, so
>>>> + * the caller can make decisions based on the deferral without worrying about
>>>> + * the request being found and issued in the mean time.
>>>> + */
>>>> static int io_req_defer(struct io_kiocb *req)
>>>> {
>>>> 	const struct io_uring_sqe *sqe = req->submit.sqe;
>>>> @@ -2579,7 +2584,7 @@ static int io_req_defer(struct io_kiocb *req)
>>>>
>>>> 	trace_io_uring_defer(ctx, req, false);
>>>> 	list_add_tail(&req->list, &ctx->defer_list);
>>>> -	spin_unlock_irq(&ctx->completion_lock);
>>>> +	__release(&ctx->completion_lock);
>>>> 	return -EIOCBQUEUED;
>>>> }
>>>>
>>>> @@ -2954,6 +2959,7 @@ static void __io_queue_sqe(struct io_kiocb *req)
>>>>
>>>> static void io_queue_sqe(struct io_kiocb *req)
>>>> {
>>>> +	struct io_ring_ctx *ctx = req->ctx;
>>>> 	int ret;
>>>>
>>>> 	ret = io_req_defer(req);
>>>> @@ -2963,6 +2969,9 @@ static void io_queue_sqe(struct io_kiocb *req)
>>>> 			if (req->flags & REQ_F_LINK)
>>>> 				req->flags |= REQ_F_FAIL_LINK;
>>>> 			io_double_put_req(req);
>>>> +		} else {
>>>> +			__acquire(&ctx->completion_lock);
>>>> +			spin_unlock_irq(&ctx->completion_lock);
>>>> 		}
>>>> 	} else
>>>> 		__io_queue_sqe(req);
>>>> @@ -3001,16 +3010,17 @@ static void io_queue_link_head(struct io_kiocb *req, struct io_kiocb *shadow)
>>>> 				__io_free_req(shadow);
>>>> 			return;
>>>> 		}
>>>> +		__acquire(&ctx->completion_lock);
>>>> 	} else {
>>>> 		/*
>>>> 		 * If ret == 0 means that all IOs in front of link io are
>>>> 		 * running done. let's queue link head.
>>>> 		 */
>>>> 		need_submit = true;
>>>> +		spin_lock_irq(&ctx->completion_lock);
>>>> 	}
>>>>
>>>> 	/* Insert shadow req to defer_list, blocking next IOs */
>>>> -	spin_lock_irq(&ctx->completion_lock);
>>>> 	trace_io_uring_defer(ctx, shadow, true);
>>>> 	list_add_tail(&shadow->list, &ctx->defer_list);
>>>> 	spin_unlock_irq(&ctx->completion_lock);
>>>
>>> This is indeed a potential lock issue, thanks, I am prefer this solution, clearer than first one.
>>> But It may be a bit difficult for other people who read the code, use 'io_req_defer_may_lock'?
>>>
>>> who about this?
>>>
>>> diff --git a/fs/io_uring.c b/fs/io_uring.c
>>> index 5ad652f..6fdaeb1 100644
>>> --- a/fs/io_uring.c
>>> +++ b/fs/io_uring.c
>>> @@ -2469,7 +2469,7 @@ static int io_async_cancel(struct io_kiocb *req, const struct io_uring_sqe *sqe,
>>>          return 0;
>>> }
>>>
>>> -static int io_req_defer(struct io_kiocb *req)
>>> +static int __io_req_defer(struct io_kiocb *req)
>>> {
>>>          const struct io_uring_sqe *sqe = req->submit.sqe;
>>>          struct io_uring_sqe *sqe_copy;
>>> @@ -2495,8 +2495,21 @@ static int io_req_defer(struct io_kiocb *req)
>>>
>>>          trace_io_uring_defer(ctx, req, false);
>>>          list_add_tail(&req->list, &ctx->defer_list);
>>> +
>>> +       return -EIOCBQUEUED;
>>> +}
>>> +
>>> +static int io_req_defer(struct io_kiocb *req)
>>> +{
>>> +       int ret = __io_req_defer(req);
>>
>> There have an problem, need fix.
>>
>> static int io_req_defer(struct io_kiocb *req)
>> {
>> 	int ret = __io_req_defer(req);
>> 	if (ret == -EIOCBQUEUED)
>> 		spin_unlock_irq(&ctx->completion_lock);
>> 	return ret;
>> }
> 
> Mid-air collision, indeed.
> 
> But as I wrote in the previous email, I don't think this one improves on
> the situation... And fwiw, I did test both of mine, both are verified to
> fix the issue.

Maybe we can compromise on something like this? Doesn't introduce any
may_lock() naming, just uses the __io_req_defer() to take that blame.
And uses the right sparse annotations to keep things happy with C=2 as
well. Uses your trick to make io_req_defer() do the lock drop for the
other caller.

Ran it through 400x rounds of testing, confirmed as well.


diff --git a/fs/io_uring.c b/fs/io_uring.c
index 6175e2e195c0..299a218e9552 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2552,7 +2552,12 @@ static int io_async_cancel(struct io_kiocb *req, const struct io_uring_sqe *sqe,
 	return 0;
 }
 
-static int io_req_defer(struct io_kiocb *req)
+/*
+ * Returns with ctx->completion_lock held if -EIOCBQUEUED is returned, so
+ * the caller can make decisions based on the deferral without worrying about
+ * the request being found and issued in the mean time.
+ */
+static int __io_req_defer(struct io_kiocb *req)
 {
 	const struct io_uring_sqe *sqe = req->submit.sqe;
 	struct io_uring_sqe *sqe_copy;
@@ -2579,10 +2584,23 @@ static int io_req_defer(struct io_kiocb *req)
 
 	trace_io_uring_defer(ctx, req, false);
 	list_add_tail(&req->list, &ctx->defer_list);
-	spin_unlock_irq(&ctx->completion_lock);
+	__release(&ctx->completion_lock);
 	return -EIOCBQUEUED;
 }
 
+static int io_req_defer(struct io_kiocb *req)
+{
+	struct io_ring_ctx *ctx = req->ctx;
+	int ret;
+
+	ret = __io_req_defer(req);
+	if (ret == -EIOCBQUEUED) {
+		__acquire(&ctx->completion_lock);
+		spin_unlock_irq(&ctx->completion_lock);
+	}
+	return ret;
+}
+
 static int __io_submit_sqe(struct io_kiocb *req, struct io_kiocb **nxt,
 			   bool force_nonblock)
 {
@@ -2957,15 +2975,14 @@ static void io_queue_sqe(struct io_kiocb *req)
 	int ret;
 
 	ret = io_req_defer(req);
-	if (ret) {
-		if (ret != -EIOCBQUEUED) {
-			io_cqring_add_event(req, ret);
-			if (req->flags & REQ_F_LINK)
-				req->flags |= REQ_F_FAIL_LINK;
-			io_double_put_req(req);
-		}
-	} else
+	if (!ret) {
 		__io_queue_sqe(req);
+	} else if (ret != -EIOCBQUEUED) {
+		io_cqring_add_event(req, ret);
+		if (req->flags & REQ_F_LINK)
+			req->flags |= REQ_F_FAIL_LINK;
+		io_double_put_req(req);
+	}
 }
 
 static void io_queue_link_head(struct io_kiocb *req, struct io_kiocb *shadow)
@@ -2989,7 +3006,7 @@ static void io_queue_link_head(struct io_kiocb *req, struct io_kiocb *shadow)
 	 * list.
 	 */
 	req->flags |= REQ_F_IO_DRAIN;
-	ret = io_req_defer(req);
+	ret = __io_req_defer(req);
 	if (ret) {
 		if (ret != -EIOCBQUEUED) {
 err:
@@ -3001,16 +3018,17 @@ static void io_queue_link_head(struct io_kiocb *req, struct io_kiocb *shadow)
 				__io_free_req(shadow);
 			return;
 		}
+		__acquire(&ctx->completion_lock);
 	} else {
 		/*
 		 * If ret == 0 means that all IOs in front of link io are
 		 * running done. let's queue link head.
 		 */
 		need_submit = true;
+		spin_lock_irq(&ctx->completion_lock);
 	}
 
 	/* Insert shadow req to defer_list, blocking next IOs */
-	spin_lock_irq(&ctx->completion_lock);
 	trace_io_uring_defer(ctx, shadow, true);
 	list_add_tail(&shadow->list, &ctx->defer_list);
 	spin_unlock_irq(&ctx->completion_lock);

-- 
Jens Axboe

