Return-Path: <SRS0=cPsQ=ZA=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB51DC5DF60
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 14:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761E02178F
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 14:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="f/uRw1u7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfKHOFX (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 8 Nov 2019 09:05:23 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:46257 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfKHOFX (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 8 Nov 2019 09:05:23 -0500
Received: by mail-il1-f193.google.com with SMTP id q1so4526176ile.13
        for <io-uring@vger.kernel.org>; Fri, 08 Nov 2019 06:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=+BSQD1UYXxyp/UY1IZQa5Ij2VoCl4HmcjAaxcYPPf8w=;
        b=f/uRw1u7/DCRa70zHMaQ7PRqAEsMoxj+wRJFX1oQpG19544UJW11FKtOHQSw+A8Nw2
         YNlAc2n5wHvSAel2N5/6IDqZNiUg4TF6Omhm7UPCz4XP0Mv8eSYgZd1p86fZT1GK3nki
         L32vGPq/QJCaDmRR3f7SHGCJn0sRn7j4X1Bi2kqenWxasJIgeuDMALDlwKVPtcV32byi
         wXmIfhbzjPOIFmJ5qzW6uphgJeTfM5VgPqzTPaxiwPnSbz1Vjl9Pf1P4ODl/RfVahnyW
         LMiCayiq2K/suNNWcosDCOsdFs4B8tHKCMRBkZgX1e2k4UKXyATk+im1yDWxy5mjFiOZ
         kgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+BSQD1UYXxyp/UY1IZQa5Ij2VoCl4HmcjAaxcYPPf8w=;
        b=G4D/9KgYBmyStITt4B2FakmUOt7XA/vjyI7WltbtQctA2XXi8ZGuM7AMaKnmhojznN
         yJ0gcIFYCW1RDttPdgrKmyheLDKxHwRAu/J3LfMOg2LhgFpvT/wiOcyGLGeNCK7mpMVT
         FnCEIcZ/Pc6yOmhzBJxSeEZK4/Dqy8HUsHNy3fXSCF+FMzpLLU50wS9nsJcxz5IGAK6J
         ZGXK8OAKppFgDa/OZE9Y3585bg1hQ/E+0m6LBDInEYUOBxXSQK8Q9gqxWWuataIX8LC+
         qc/4EBXg8Cg2WFNg3hCj0tUoU5Nx8s8mzpJjM6RxGBa8JRtgiynC7DxiCYEuanOHPd/a
         7g2Q==
X-Gm-Message-State: APjAAAVQKT3yElAmEkI/tKGmLp5NwSNykT2Mwgs+TLXXlZA/hhbZh0S0
        uZHJ9fV/nFR5CPCkbBpwn5VHLhSlvLI=
X-Google-Smtp-Source: APXvYqwUrzXMZYcCUwmSmKcYSq72U1MpS1hnzm40OgERw2qVAZCSs5VswROIQUkORwFmvCeX727RqQ==
X-Received: by 2002:a92:104a:: with SMTP id y71mr12385595ill.220.1573221921441;
        Fri, 08 Nov 2019 06:05:21 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m17sm778493ilb.5.2019.11.08.06.05.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 06:05:20 -0800 (PST)
Subject: Re: [PATCH RFC] io_uring: limit inflight IO
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
References: <e7f01b7b-5915-606f-b5b4-0d59f8e096b6@kernel.dk>
 <33958a03-6714-ce51-9856-1dcbf53f67d5@kernel.dk>
 <273391a6-1def-3c29-986c-8efca569fc16@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cc6b368b-10e3-504c-4895-feefe6311004@kernel.dk>
Date:   Fri, 8 Nov 2019 07:05:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <273391a6-1def-3c29-986c-8efca569fc16@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/8/19 2:56 AM, Pavel Begunkov wrote:
> On 08/11/2019 03:19, Jens Axboe wrote:
>> On 11/7/19 4:21 PM, Jens Axboe wrote:
>>> I'd like some feedback on this one. Even tith the overflow backpressure
>>> patch, we still have a potentially large gap where applications can
>>> submit IO before we get any dropped events in the CQ ring. This is
>>> especially true if the execution time of those requests are long
>>> (unbounded).
>>>
>>> This adds IORING_SETUP_INFLIGHT, which if set, will return -EBUSY if we
>>> have more IO pending than we can feasibly support. This is normally the
>>> CQ ring size, but of IORING_SETUP_CQ_NODROP is enabled, then it's twice
>>> the CQ ring size.
>>>
>>> This helps manage the pending queue size instead of letting it grow
>>> indefinitely.
>>>
>>> Note that we could potentially just make this the default behavior -
>>> applications need to handle -EAGAIN returns already, in case we run out
>>> of memory, and if we change this to return -EAGAIN as well, then it
>>> doesn't introduce any new failure cases. I'm tempted to do that...
>>>
>>> Anyway, comments solicited!
> What's wrong with giving away overflow handling to the userspace? It
> knows its inflight count, and it shouldn't be a problem to allocate
> large enough rings. The same goes for the backpressure patch. Do you
> have a particular requirement/user for this?

There are basically two things at play here:

- The backpressure patch helps with users that can't easily size the
  ring. This could be library use cases, or just normal use cases that
  don't necessarily know how big the ring needs to be. Hence they need
  to size for the worst case, which is wasteful.

- For this case, it's different. I just want to avoid having the
  application having potential tons of requests in flight. Before the
  backpressure patch, if you had more than the CQ ring size inflight,
  you'd get dropped events. Once you get dropped events, it's game over,
  the application has totally lost track. Hence I think it's safe to
  unconditionally return -EBUSY if we exceed that limit.

The first one helps use cases that couldn't really io_uring before, the
latter helps protect against use cases that would use a lot of memory.
If the request for the latter use case takes a long time to run, the
problem is even worse.

> Awhile something could be done {efficiently,securely,etc} in the
> userspace, I would prefer to keep the kernel part simpler.

For this particular patch, the majority of issues will just read the sq
head and mask, which we will just now anyway. The extra cost is
basically a branch and cmp instruction. There's no way you can do that
in userspace that efficiently, and it helps protect the kernel.

I'm not a fan of adding stuff we don't need either, but I do believe we
need this one.

-- 
Jens Axboe

