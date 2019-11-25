Return-Path: <SRS0=pC3Y=ZR=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA56C432C3
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 10:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAB9920835
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 10:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWivo5t0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfKYKqT (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 25 Nov 2019 05:46:19 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38452 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727766AbfKYKqR (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 25 Nov 2019 05:46:17 -0500
Received: by mail-lj1-f194.google.com with SMTP id k8so4698022ljh.5
        for <io-uring@vger.kernel.org>; Mon, 25 Nov 2019 02:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=QF32qe2x8RhR7XyMyAtDkDWD1T0D8tqBMK1RgMKLZSU=;
        b=dWivo5t0cq+jbWZLLu3u2P5JyHn0EymLIYGHAnv14wScN7d4Cp8n56BwQpUzYQRD2k
         1ki8iCLbrZ1a6x5FYOfOmdCS83MFKA54Orp7mcCleCJ8JA8gmT6lmvYR1MOQxwnxpLeN
         rLKJoAnekwzkJwlirnVqKxsZJg1U4LXgvXP79GOi6if3syLCrj3Ay9ZTNUCKTJO6t1SJ
         wa96jNChNSvPQ97ygXkOYR7QOeHUyIdG/nrO4Pem6xgfgvm5Fwu7Q1YlCVAc3le55My7
         qwP+vLOEOyHluUKmdJukuUX3zEm210CvN2vyaHqpPN58jeKenXMEnTBu3GTC26z2zYXk
         3JOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QF32qe2x8RhR7XyMyAtDkDWD1T0D8tqBMK1RgMKLZSU=;
        b=KK90WilQUSnfegjLEKwtNTx42YPH0Wv7tQ0ovGl4sfTA+XWrdoPS9XrLDYsm5/Xbmi
         5Sv1D74UTpf9ALCtVwR6tE9PL6uEs3ybXA3apqLbQ9YmzlY0NWNCQFNhM92yZ+Jq3v/W
         nP2El/a5PytPJx38MtjG0d2bgZ4pQ9GKXKUrFw1CzE+kRvvlkb0N5omBTadwRh/ySNbq
         uyq4/8kiK04tIX4xRgAoDo237p++KcHwMKb9r9Jv+H9tFfaF9rfjPl1mnqR4p+ar7w4p
         JJLS1E9i9Ynsz8yHkONn9tqiB6ZS0uxQ7jgVFrExsY5u4VSb+yqKA/IM4INbCWbCtAr2
         Df3Q==
X-Gm-Message-State: APjAAAUCEd73gQ98jTn8Tovk6knyNKw4DW3gHjEW5tmsiROdwgnyqe4o
        dMF7bXzwT8hqriKWMHN5XDY2a8AoOBA=
X-Google-Smtp-Source: APXvYqydk3Jhf1HwIfrlB2SNHmT9u3LBeG2kPlZBBAvbQPxq0sqjRlZkh51JDqf/gNR+2LzPubrcLw==
X-Received: by 2002:a2e:8695:: with SMTP id l21mr21567837lji.53.1574678775545;
        Mon, 25 Nov 2019 02:46:15 -0800 (PST)
Received: from [172.31.190.83] ([86.57.146.226])
        by smtp.gmail.com with ESMTPSA id y18sm3711286lja.12.2019.11.25.02.46.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Nov 2019 02:46:14 -0800 (PST)
Subject: Re: [PATCH v2] io_uring: fix dead-hung for non-iter fixed rw
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
References: <cover.1574585281.git.asml.silence@gmail.com>
 <620023b272fef0fd76d0f91ff1876fa64864caa6.1574585281.git.asml.silence@gmail.com>
 <6a2fcf67-1267-a02a-98ce-435bbb2ca9bb@kernel.dk>
 <c44dd55c-79b9-78c0-06ad-45f7d47fdd5f@gmail.com>
 <272c3bae-484a-1caf-c11d-b3cb9808257e@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Message-ID: <d719563a-cbd9-3d9c-48ed-c55d9cce89e1@gmail.com>
Date:   Mon, 25 Nov 2019 13:46:13 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <272c3bae-484a-1caf-c11d-b3cb9808257e@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/25/2019 5:37 AM, Jens Axboe wrote:
> On 11/24/19 10:52 AM, Pavel Begunkov wrote:
>> On 24/11/2019 20:10, Jens Axboe wrote:
>>> On 11/24/19 1:58 AM, Pavel Begunkov wrote:
>>>> Read/write requests to devices without implemented read/write_iter
>>>> using fixed buffers causes general protection fault, which totally
>>>> hangs a machine.
>>>>
>>>> io_import_fixed() initialises iov_iter with bvec, but loop_rw_iter()
>>>> accesses it as iovec, so dereferencing random address.
>>>>
>>>> kmap() page by page in this case
>>>
>>> This looks good to me, much cleaner/simpler. I've added a few pipe fixed
>>> buffer tests to liburing as well. Didn't crash for me, but obvious
>>> garbage coming out. I've flagged this for stable as well.
>>>
>> The problem I have is that __user pointer is meant to be checked
>> for not being a kernel address. I suspect, it could fail in some
>> device, which double checks the pointer after vfs (e.g. using access_ok()).
>> Am I wrong? Not a fault at least...
>>
>> #define access_ok(...) __range_not_ok(addr, user_addr_max());
> 
> They are user pages! So this should be totally fine. The only difference
> is that we have them pre-mapped. But it's not like we're pretending
> these kernel pages are user pages, and hence access_ok() should be
> totally happy with them.
> 
Good, if you say so, but I'll take the liberty of asking a little bit
more :)

Yes, they are user pages, but that's rather about used virtual
addresses. Having virtual address space separation (e.g. [0-n): user's
virtual address space part, [n-m): kernel's one), I'd expect __user ptr
to be checked to be bounded by [0-n). E.g. copy_to_user() obviously
shouldn't write into kernel's addresses. And I also assume that kmap()
maps into [n-m), at least because the kernel may want to allocate and
kmap() pages, and use them internally.

And that's why I thought it may fail.
E.g. vfs_read_sys((__user void*)kmap()) _should_ fail.
Where is my mistake?

>> BTW, is there anybody testing it for non x86-64 arch?
> 
> Would be nice, I've mostly failed at getting other archs interested
> enough to actually make hardware available. Which seems pretty lame, but
> only so much I can do there. There _shouldn't_ be anything arch
> specific, but it would be great to have archs with eg weaker ordering as
> part of the regular test arsenal.
> 
Yeah, that's the point. It probably needs some use in Android to turn
the things over.

-- 
Pavel Begunkov
