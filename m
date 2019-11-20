Return-Path: <SRS0=jdTg=ZM=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A10C432C0
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 17:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2084720878
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 17:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0VooOCZB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbfKTRTU (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 20 Nov 2019 12:19:20 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:38324 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728142AbfKTRTU (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 20 Nov 2019 12:19:20 -0500
Received: by mail-il1-f194.google.com with SMTP id u17so361579ilq.5
        for <io-uring@vger.kernel.org>; Wed, 20 Nov 2019 09:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=rK8mECBCSGqzquyDZulskWQVqqh35iX5G6zP6lQLGoA=;
        b=0VooOCZBpr3y9m1hLDy8oCc1d5Rbl65Hp3XJP4o1sfuFrXqnxes5mw1+A9wdjXzMYx
         3aAc3jeobkmGsayJBIFbH0Grt1Pn1ylpIAcJ7DOnstAoybwYclLvZ34LThYEeiuczuhH
         Meuc17ehT0jBp9yqFuUQQIGvw9NAm9pC1aUG0TXklmhs3F9bbLmzfbNsXzWZ0XPXxHOl
         2d96B1c/u0WCIj9xz8ronl9kYnIfbBGUY5WTkbPG7465ApJnyXzAKMLJOwKELX+bjKZN
         cnfFKjnDFhHkMJm66CWb5wlEuBhuRYLBU/Rv4VX4atTzBEVAKKG2KIZk/S+ZbDL4HIdh
         /yzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rK8mECBCSGqzquyDZulskWQVqqh35iX5G6zP6lQLGoA=;
        b=RHNVVMJfgVkOjcfHsABu3gC/2nRRDhTnfGZARW9M1Jqzoc/yz19iPEJZrZAdDAYyF0
         9cD/ErgzOv/cxjgOyaNodVzs9Cd9mizaORsuWHCVwoblm+DxqVuuE/H4sckwo0y9Xkz1
         y0yv+F7tqMX4tQ51R6Gq3HehgvsTmeDtk+WY2ssnNnBZoMNcYvPRzq6eDkjj8VHIDHmz
         qTXsuMEVzEkEyUT2KWtnIIYPEufrZN1rXkLtpzKJCzyLfp5sWOTefgvtue5fJzuMmGqr
         W0iZKnEFhY/sCk5bkbPMMzVJ5C0jjpSOkhCDVHSz6AfnDM3dXQSDWpEVEKriQCc4aQQY
         37QA==
X-Gm-Message-State: APjAAAU54ItjZ2Jo6mXwcXsNevSHkaUlIWwTG/4gsCSRt6DotN+E6t9Y
        DrtTaUWfTnh588Nhv9xqACFwORes8h5tyA==
X-Google-Smtp-Source: APXvYqx+Z/9+UesOUz/AE0ZI4cQtLoCe8BK0R9cArvg56Ivh2aZxioCJqYCTfjR7S1ARUCa40qT5aw==
X-Received: by 2002:a92:9a85:: with SMTP id c5mr4298970ill.99.1574270358381;
        Wed, 20 Nov 2019 09:19:18 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t7sm5081916iog.85.2019.11.20.09.19.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 09:19:17 -0800 (PST)
Subject: Re: [PATCH 7/8] io_uring: fix sequencing issues with linked timeouts
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
References: <20191116015314.24276-1-axboe@kernel.dk>
 <20191116015314.24276-8-axboe@kernel.dk>
 <ccf48def-1a4a-9cb1-aa9a-467294487856@gmail.com>
 <b98a91cd-54c1-49ef-d75d-8007dcc470c1@kernel.dk>
 <66547def-073c-8c4f-da68-17be900a192d@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f961fd7a-53f1-37fe-f540-10a220535517@kernel.dk>
Date:   Wed, 20 Nov 2019 10:19:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <66547def-073c-8c4f-da68-17be900a192d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/20/19 5:42 AM, Pavel Begunkov wrote:
> On 11/20/2019 1:13 AM, Jens Axboe wrote:
>> On 11/19/19 1:51 PM, Pavel Begunkov wrote:
>>> On 16/11/2019 04:53, Jens Axboe wrote:
>>>> We have an issue with timeout links that are deeper in the submit chain,
>>>> because we only handle it upfront, not from later submissions. Move the
>>>> prep + issue of the timeout link to the async work prep handler, and do
>>>> it normally for non-async queue. If we validate and prepare the timeout
>>>> links upfront when we first see them, there's nothing stopping us from
>>>> supporting any sort of nesting.
>>>>
>>>> Fixes: 2665abfd757f ("io_uring: add support for linked SQE timeouts")
>>>> Reported-by: Pavel Begunkov <asml.silence@gmail.com>
>>>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>>> ---
>>>
>>>> @@ -923,6 +942,7 @@ static void io_fail_links(struct io_kiocb *req)
>>>>    			io_cqring_fill_event(link, -ECANCELED);
>>>>    			__io_double_put_req(link);
>>>>    		}
>>>> +		kfree(sqe_to_free);
>>>>    	}
>>>>    
>>>>    	io_commit_cqring(ctx);
>>>> @@ -2668,8 +2688,12 @@ static void io_wq_submit_work(struct io_wq_work **workptr)
>>>>    
>>>>    	/* if a dependent link is ready, pass it back */
>>>>    	if (!ret && nxt) {
>>>> -		io_prep_async_work(nxt);
>>>> +		struct io_kiocb *link;
>>>> +
>>>> +		io_prep_async_work(nxt, &link);
>>>>    		*workptr = &nxt->work;
>>> Are we safe here without synchronisation?
>>> Probably io_link_timeout_fn() may miss the new value
>>> (doing io-wq cancel).
>>
>> Miss what new value? Don't follow that part.
>>
> 
> As I've got the idea of postponing:
> at the moment of io_queue_linked_timeout(), a request should be either
> in io-wq or completed. So, @nxt->work after the assignment above should
> be visible to asynchronously called io_wq_cancel_work().
> 
>>>>   *workptr = &nxt->work;
> However, there is no synchronisation for this assignment, and it could
> be not visible from a parallel thread. Is it somehow handled in io-wq?
> 
> The pseudo code is below (th1, th2 - parallel threads)
> th1: *workptr = &req->work;
> // non-atomic assignment, the new value of workptr (i.e. &req->work)
> // isn't yet propagated to th2
> 
> th1: io_queue_linked_timeout()
> th2: io_linked_timeout_fn(), calls io_wq_cancel_work(), @req not found
> th2: // memory model finally propagated *workptr = &req->work to @th2
> 
> 
> Please, let me know if that's also not clear.

OK, so I see what you're saying, but I don't think it's missing locking.
There is, however, a gap where we won't be able to find the request.
What we need is a way to assign the io-wq current work before we call
io_queue_linked_timeout(). Something ala:

	io_prep_async_work(nxt, &link);
	*workptr = &nxt->work;
+	io_wq_assign_cur();
	if (link)
		io_queue_linked_timeout(link);

where io_wq_assign_cur() ensures that worker->cur_work is set to the new
work, so we know it's discoverable before calling
io_queue_linked_timeout(). Probably also needs to include the
->get_work() call as part of that, so moving the logic around a bit in
io_worker_handle_work().

If we do that, then by the time we arm the linked timer, we know we'll
be able to find the new work item. The old work is done at this point
anyway, so doing this a bit earlier is fine.

-- 
Jens Axboe

