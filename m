Return-Path: <SRS0=pC3Y=ZR=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6BBC432C0
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 02:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21DD92073F
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 02:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="KyZwUXaU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfKYCh5 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 24 Nov 2019 21:37:57 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46430 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbfKYCh5 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 24 Nov 2019 21:37:57 -0500
Received: by mail-pf1-f196.google.com with SMTP id 193so6596343pfc.13
        for <io-uring@vger.kernel.org>; Sun, 24 Nov 2019 18:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=e8KJ9h/g7LiPV6UPc8/rgoMup0S0WBP9JEmlWinRcdo=;
        b=KyZwUXaUPotQduiwaGH9DRTy5WE1BeLSHIVLoy4Se1RofLCHiIB8RuWUTNjpvU1b2d
         s9rTXqML8oM2sZXJfjh4jdsVSs6loO09oTEVvcjSsJlodbIqYmt3aykRcKskwkKgQoa0
         jdZ8jtseYNE7mv0mtiAF3PCrUzRUWcJG734nEhIUEtoGaZ/frfZHUF6eocVs6trAsp9R
         b5bmIXE+e5L6YnkgT1okK73KNOMa1peBCVcQeX/52WQxN2Hex6XU1mVjr1TMhlUsm6Wg
         8N8yQP3pk9W3AIiWIjgOkgkJvLeQ0vynYgJwdIoXIOpYZQYtvF7GZvVMH5fZzH9VbEMx
         HfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e8KJ9h/g7LiPV6UPc8/rgoMup0S0WBP9JEmlWinRcdo=;
        b=Zkf8TcuHoWHQtnNawQuJSSKF5vAl/ZmVkNvn9b27Cs5ZEXiAsIp4hdO5VGWS3jEIMV
         qvBjeVkV/1KELzsZgtPT0QlMi6d0Ld+nEw3KEt/fYMT3QEHMngTTyiBY0WX/aUQZBEZd
         bojmonMPpkZjueR+ROGdM9AutdFbmk5Y+7ESd31FwawVN5+Ix3DcTPtCUov7nvxihv4O
         QV203FaUyGGo6+AmcQj4JOXJCUZ3VDy1W/egrn8tk2UqqYuP4Xd0Otq/K5oYk7oQN3Hs
         y07dT4f20xvCGFMQ2s/BlJtUCzXyAy7KtyXglHgFw47nbk9q/WflaGEHY2WMZnEAEuqE
         bjrQ==
X-Gm-Message-State: APjAAAV8oXWoqiADgyCioE2RnSOL4H6GbdxtsIWPj9/TDSjI/vzsE+YJ
        HIz2ehu/3h1S9TBBmVrzgkGMPjqOpbH0CA==
X-Google-Smtp-Source: APXvYqwUyDyrWbGAqcOGVXpUaRzLxgMcV0GxgECYR86tYjvXecqUOeHj9pBE7fvi1Z4cqhyCF7zqAg==
X-Received: by 2002:a62:e214:: with SMTP id a20mr32664643pfi.193.1574649476064;
        Sun, 24 Nov 2019 18:37:56 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id f26sm5683952pgf.22.2019.11.24.18.37.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Nov 2019 18:37:54 -0800 (PST)
Subject: Re: [PATCH v2] io_uring: fix dead-hung for non-iter fixed rw
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
References: <cover.1574585281.git.asml.silence@gmail.com>
 <620023b272fef0fd76d0f91ff1876fa64864caa6.1574585281.git.asml.silence@gmail.com>
 <6a2fcf67-1267-a02a-98ce-435bbb2ca9bb@kernel.dk>
 <c44dd55c-79b9-78c0-06ad-45f7d47fdd5f@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <272c3bae-484a-1caf-c11d-b3cb9808257e@kernel.dk>
Date:   Sun, 24 Nov 2019 19:37:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <c44dd55c-79b9-78c0-06ad-45f7d47fdd5f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/24/19 10:52 AM, Pavel Begunkov wrote:
> On 24/11/2019 20:10, Jens Axboe wrote:
>> On 11/24/19 1:58 AM, Pavel Begunkov wrote:
>>> Read/write requests to devices without implemented read/write_iter
>>> using fixed buffers causes general protection fault, which totally
>>> hangs a machine.
>>>
>>> io_import_fixed() initialises iov_iter with bvec, but loop_rw_iter()
>>> accesses it as iovec, so dereferencing random address.
>>>
>>> kmap() page by page in this case
>>
>> This looks good to me, much cleaner/simpler. I've added a few pipe fixed
>> buffer tests to liburing as well. Didn't crash for me, but obvious
>> garbage coming out. I've flagged this for stable as well.
>>
> The problem I have is that __user pointer is meant to be checked
> for not being a kernel address. I suspect, it could fail in some
> device, which double checks the pointer after vfs (e.g. using access_ok()).
> Am I wrong? Not a fault at least...
> 
> #define access_ok(...) __range_not_ok(addr, user_addr_max());

They are user pages! So this should be totally fine. The only difference
is that we have them pre-mapped. But it's not like we're pretending
these kernel pages are user pages, and hence access_ok() should be
totally happy with them.

> BTW, is there anybody testing it for non x86-64 arch?

Would be nice, I've mostly failed at getting other archs interested
enough to actually make hardware available. Which seems pretty lame, but
only so much I can do there. There _shouldn't_ be anything arch
specific, but it would be great to have archs with eg weaker ordering as
part of the regular test arsenal.

-- 
Jens Axboe

