Return-Path: <SRS0=cPsQ=ZA=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7845EFA372C
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 17:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48E2A2178F
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 17:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wejFCMIb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfKHRpZ (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 8 Nov 2019 12:45:25 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:38589 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbfKHRpZ (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 8 Nov 2019 12:45:25 -0500
Received: by mail-io1-f68.google.com with SMTP id i13so5909155ioj.5
        for <io-uring@vger.kernel.org>; Fri, 08 Nov 2019 09:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=BQEgD5mEk5MEYrC47/WQtrP4JGHx96kY2Ks+cBAhl8o=;
        b=wejFCMIb7f/2iTubcJiIjqfjzliN12xiOchkywfAC5wXZd+XhyPJ7OIy04TwIrQxu7
         R5aLaJmER+fFtYMp0o8fqIcLp0cMrD8NGRv9VfbbbzSngAEmUaBBHuK6OFy+W4tfO7rP
         v/hsk79dT7bhvoJp1Ds2TaqcGZrP/ryzsxf7vD4fDO6rb3lA4kNwuIPgtz3bsrFLDyf1
         aFGgNmLjyJCPozUTm2BOYSNIadVg4AJsi1VjgWVZaUwLP7d8LEX3axXOxz76cf3VTQ9y
         bjqJYA3qn7wuMlmhOviWsD/uHJYTRgFng83EVi6TjvMYgQ1kcUOXF++vVoqJeBy6Vg7Q
         jsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BQEgD5mEk5MEYrC47/WQtrP4JGHx96kY2Ks+cBAhl8o=;
        b=pagio2QX25JF8KS9SLtr4UtjeIZixWQxYxQbgRBR34rwrxkW6VKy1lPxDEUPRUi6w+
         GkZMOSSBsbjxWPZSmGjVlnANXOfm8OO9i5kWwERtWRJkRXqgXnl6CSwV/jV+QuESO0Jw
         oip63c50utOBNvTey+Gk1jYRhIz/9O/DuWdZdZBI53R/FRvCwo/RpuadZIgI8Zar0Gbx
         INpFRPUoz5pTcCMdZBYowI3WNFe9reTc871vHQw0Tbvdn7gHR85kKji9ZQYZQo/9YCeH
         u4daIyM2qKpFqQGlWmcy5Ut91S+2GEtSJvr30TYJ2u/xD49RcKlVN8B77tSYXz3QOv4x
         lfZw==
X-Gm-Message-State: APjAAAVxB9flZciPwAyNesaiAhZgwy/qTjYjxnbwdSB8/T2ocuydvsNw
        v+GQQ9250mBOP3I9V+JdNnJWuyfvc3Y=
X-Google-Smtp-Source: APXvYqyVw1I/iw8qwGgwe8PvX5+wjhCp4+8EONaJtCjNiv3nNwddwkWo3UAWrMeHP9ATlq76UGlXEw==
X-Received: by 2002:a6b:770b:: with SMTP id n11mr7779136iom.154.1573235121941;
        Fri, 08 Nov 2019 09:45:21 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m4sm365909ilf.18.2019.11.08.09.45.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 09:45:21 -0800 (PST)
Subject: Re: [PATCH RFC] io_uring: limit inflight IO
From:   Jens Axboe <axboe@kernel.dk>
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
References: <e7f01b7b-5915-606f-b5b4-0d59f8e096b6@kernel.dk>
 <33958a03-6714-ce51-9856-1dcbf53f67d5@kernel.dk>
 <273391a6-1def-3c29-986c-8efca569fc16@gmail.com>
 <cc6b368b-10e3-504c-4895-feefe6311004@kernel.dk>
Message-ID: <bdfdad32-91b7-7721-ccdf-0dd399e7e051@kernel.dk>
Date:   Fri, 8 Nov 2019 10:45:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <cc6b368b-10e3-504c-4895-feefe6311004@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/8/19 7:05 AM, Jens Axboe wrote:
> On 11/8/19 2:56 AM, Pavel Begunkov wrote:
>> On 08/11/2019 03:19, Jens Axboe wrote:
>>> On 11/7/19 4:21 PM, Jens Axboe wrote:
>>>> I'd like some feedback on this one. Even tith the overflow backpressure
>>>> patch, we still have a potentially large gap where applications can
>>>> submit IO before we get any dropped events in the CQ ring. This is
>>>> especially true if the execution time of those requests are long
>>>> (unbounded).
>>>>
>>>> This adds IORING_SETUP_INFLIGHT, which if set, will return -EBUSY if we
>>>> have more IO pending than we can feasibly support. This is normally the
>>>> CQ ring size, but of IORING_SETUP_CQ_NODROP is enabled, then it's twice
>>>> the CQ ring size.
>>>>
>>>> This helps manage the pending queue size instead of letting it grow
>>>> indefinitely.
>>>>
>>>> Note that we could potentially just make this the default behavior -
>>>> applications need to handle -EAGAIN returns already, in case we run out
>>>> of memory, and if we change this to return -EAGAIN as well, then it
>>>> doesn't introduce any new failure cases. I'm tempted to do that...
>>>>
>>>> Anyway, comments solicited!
>> What's wrong with giving away overflow handling to the userspace? It
>> knows its inflight count, and it shouldn't be a problem to allocate
>> large enough rings. The same goes for the backpressure patch. Do you
>> have a particular requirement/user for this?
> 
> There are basically two things at play here:
> 
> - The backpressure patch helps with users that can't easily size the
>    ring. This could be library use cases, or just normal use cases that
>    don't necessarily know how big the ring needs to be. Hence they need
>    to size for the worst case, which is wasteful.
> 
> - For this case, it's different. I just want to avoid having the
>    application having potential tons of requests in flight. Before the
>    backpressure patch, if you had more than the CQ ring size inflight,
>    you'd get dropped events. Once you get dropped events, it's game over,
>    the application has totally lost track. Hence I think it's safe to
>    unconditionally return -EBUSY if we exceed that limit.
> 
> The first one helps use cases that couldn't really io_uring before, the
> latter helps protect against use cases that would use a lot of memory.
> If the request for the latter use case takes a long time to run, the
> problem is even worse.
> 
>> Awhile something could be done {efficiently,securely,etc} in the
>> userspace, I would prefer to keep the kernel part simpler.
> 
> For this particular patch, the majority of issues will just read the sq
> head and mask, which we will just now anyway. The extra cost is
> basically a branch and cmp instruction. There's no way you can do that
> in userspace that efficiently, and it helps protect the kernel.
> 
> I'm not a fan of adding stuff we don't need either, but I do believe we
> need this one.

I've been struggling a bit with how to make this reliable, and I'm not
so sure there's a way to do that. Let's say an application sets up a
ring with 8 sq entries, which would then default to 16 cq entries. With
this patch, we'd allow 16 ios inflight. But what if the application does

for (i = 0; i < 32; i++) {
	sqe = get_sqe();
	prep_sqe();
	submit_sqe();
}

And then directly proceeds to:

do {
	get_completions();
} while (has_completions);

As long as fewer than 16 requests complete before we start reaping,
we don't lose any events. Hence there's a risk of breaking existing
setups with this, even though I don't think that's a high risk.

We probably want to add some sysctl limit for this instead. But then
the question is, what should that entry (or entries) be?

-- 
Jens Axboe

