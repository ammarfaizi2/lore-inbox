Return-Path: <SRS0=jnAq=ZB=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE58C43331
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 14:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A065207FA
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 14:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ItcSJ+f7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfKIOMb (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 9 Nov 2019 09:12:31 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38103 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfKIOMb (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 9 Nov 2019 09:12:31 -0500
Received: by mail-pl1-f196.google.com with SMTP id w8so5599130plq.5
        for <io-uring@vger.kernel.org>; Sat, 09 Nov 2019 06:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=1BGWO+AldsiprC8aNx6hOPvqFdYrKtS4Xgk3ffhFOe8=;
        b=ItcSJ+f77IH1FcqRUNXQF3+xD3fURi9N0Nuh/Zjf1pGgy+SM72jaZBAJoQFPd6P9m8
         K9nossgsF9de26nEbYXQYk5ql3PwCwVFNtENvabS5v1mg2aNqktL5W3OZdyx1adKYtW7
         sbv4nqCUMj1ofZ8r7ka8dUazKZbzMTMJYB8KsvThvOEYgBdciu1PmqECdJP6GNw3YDTo
         KO8h1mRD1NffbvhClJ57R1YJ4CduNGQrFeRI6/V7j0h4vgsCFcHuWYFI22Pjwg0k4cx2
         WsjL6v2Ty4pABkttKRg3F3ocydmO+P198OPIvJAMAovIhECzdl2BeeSxfAJNriABnz8i
         mDgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1BGWO+AldsiprC8aNx6hOPvqFdYrKtS4Xgk3ffhFOe8=;
        b=SMKhlBQ1bojicCpNgt13vuV1Dit7Ww4nAjYpYbRqP7B7o+eYkXLZMG3thJeytMQemc
         RY2fY6EWg7RfzLyuh7Jpoj7fUJs+uh+qUnnFZAVw689b5CjBzNI2X+1rSvHwhjQ+6raA
         EhCXgBXNUwoxwmX3WqPPM67nEuOHL6tL1R98uLcm+FuguPx3tKc98rjOS7Zq0jHAS1s0
         RqsMdpwCfHbvxKV4jAz3COrblOyeVfFMWMa/VcT0FLkXL7Rz3RiwJpkbanY1Vbw+23YM
         oqOsiRK/r6VwSTlmgunhLLxEvBeFmdUHBonJLAJGpQn1SweB5jgDJpB18tYua5kMVZJL
         lTfA==
X-Gm-Message-State: APjAAAXhMRHRVbSrNUBQ0ggMByN8U4Av8uMmpqy+F32stnP41nyDLVSF
        zC9azhAPyFdkvaVwYH0tnpZ5j2j1mQs=
X-Google-Smtp-Source: APXvYqx6EQw7t1sati+8NsEJOpy7h0nnqDYdsiEgcBQzsXclVYP4IQ/0hvWNpuNmCYXAKsq4Aq9iEg==
X-Received: by 2002:a17:902:6acb:: with SMTP id i11mr16827291plt.214.1573308750095;
        Sat, 09 Nov 2019 06:12:30 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id r8sm9395247pgr.59.2019.11.09.06.12.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Nov 2019 06:12:29 -0800 (PST)
Subject: Re: [PATCH RFC] io_uring: limit inflight IO
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
References: <e7f01b7b-5915-606f-b5b4-0d59f8e096b6@kernel.dk>
 <33958a03-6714-ce51-9856-1dcbf53f67d5@kernel.dk>
 <273391a6-1def-3c29-986c-8efca569fc16@gmail.com>
 <cc6b368b-10e3-504c-4895-feefe6311004@kernel.dk>
 <e3c1f9a8-bd6a-ea08-1450-0d7a55a843a6@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0b482581-50a6-e309-e6ff-01cd81ff7931@kernel.dk>
Date:   Sat, 9 Nov 2019 07:12:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e3c1f9a8-bd6a-ea08-1450-0d7a55a843a6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/9/19 3:33 AM, Pavel Begunkov wrote:
> On 08/11/2019 17:05, Jens Axboe wrote:
>> On 11/8/19 2:56 AM, Pavel Begunkov wrote:
>>> On 08/11/2019 03:19, Jens Axboe wrote:
>>>> On 11/7/19 4:21 PM, Jens Axboe wrote:
>>>>> I'd like some feedback on this one. Even tith the overflow backpressure
>>>>> patch, we still have a potentially large gap where applications can
>>>>> submit IO before we get any dropped events in the CQ ring. This is
>>>>> especially true if the execution time of those requests are long
>>>>> (unbounded).
>>>>>
>>>>> This adds IORING_SETUP_INFLIGHT, which if set, will return -EBUSY if we
>>>>> have more IO pending than we can feasibly support. This is normally the
>>>>> CQ ring size, but of IORING_SETUP_CQ_NODROP is enabled, then it's twice
>>>>> the CQ ring size.
>>>>>
>>>>> This helps manage the pending queue size instead of letting it grow
>>>>> indefinitely.
>>>>>
>>>>> Note that we could potentially just make this the default behavior -
>>>>> applications need to handle -EAGAIN returns already, in case we run out
>>>>> of memory, and if we change this to return -EAGAIN as well, then it
>>>>> doesn't introduce any new failure cases. I'm tempted to do that...
>>>>>
>>>>> Anyway, comments solicited!
>>> What's wrong with giving away overflow handling to the userspace? It
>>> knows its inflight count, and it shouldn't be a problem to allocate
>>> large enough rings. The same goes for the backpressure patch. Do you
>>> have a particular requirement/user for this?
>>
>> There are basically two things at play here:
>>
>> - The backpressure patch helps with users that can't easily size the
>>    ring. This could be library use cases, or just normal use cases that
>>    don't necessarily know how big the ring needs to be. Hence they need
>>    to size for the worst case, which is wasteful.
>>
>> - For this case, it's different. I just want to avoid having the
>>    application having potential tons of requests in flight. Before the
>>    backpressure patch, if you had more than the CQ ring size inflight,
>>    you'd get dropped events. Once you get dropped events, it's game over,
>>    the application has totally lost track. Hence I think it's safe to
>>    unconditionally return -EBUSY if we exceed that limit.
>>
>> The first one helps use cases that couldn't really io_uring before, the
>> latter helps protect against use cases that would use a lot of memory.
>> If the request for the latter use case takes a long time to run, the
>> problem is even worse.
> 
> I see, thanks. I like the point with having an upper-bound for inflight
> memory. Seems, the patch doesn't keep it strict and we can get more
> than specified. Is that so?

Right, the important part is providing some upper bound, not an exact
one.

> As an RFC, we could think about using static request pool, e.g.
> with sbitmap as in blk-mq. Would also be able to get rid of some
> refcounting. However, struggle to estimate performance difference.

That would be fine if we needed exact limits, for this case it's just be
a waste of CPU with no real win. So I would not advocate that, and it's
not like we need a tagged identifier for it either.

>>> Awhile something could be done {efficiently,securely,etc} in the
>>> userspace, I would prefer to keep the kernel part simpler.
>>
>> For this particular patch, the majority of issues will just read the sq
>> head and mask, which we will just now anyway. The extra cost is
>> basically a branch and cmp instruction. There's no way you can do that
>> in userspace that efficiently, and it helps protect the kernel.
>>
> I'm more concern about complexity, and bugs as consequences. The second
> concern is edge cases and an absence of formalised guarantees for that.
> 
> For example, it could fetch and submit only half of a link because of
> failed io_get_req(). Shouldn't it be kind of atomic? From the
> userspace perspective I'd prefer so.

If we start a sequence, we should let it finish, agree. I'll post an
update.


-- 
Jens Axboe

