Return-Path: <SRS0=yjkE=ZH=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AF2C432C3
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 03:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561E120706
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 03:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="gBKetp6y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfKODWR (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 14 Nov 2019 22:22:17 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42668 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfKODWR (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 14 Nov 2019 22:22:17 -0500
Received: by mail-pl1-f195.google.com with SMTP id j12so3667293plt.9
        for <io-uring@vger.kernel.org>; Thu, 14 Nov 2019 19:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ZmABSWSiE/DmAz3fqu+pp6Wg/xtNltn809coD4OK5tY=;
        b=gBKetp6y81eJRUGyByLm/ofgSAhHPMb9lzWFswNyEPoDL6JAG2vjx4BsiskqKxHlHR
         vWQkXNobLhxHjePgAEQ6O1tvyU3iAJl9mYHNy/J+AH/EKZIZSZ5T5xOu2q1CaZyjQO45
         TxUvRQohZWGjl6GUczsySYawxi4yVFchCbU2l0vZs96v3Hkmq/++SMsNQ7oqKyCoNVI2
         wiMJOckqoCa1qDj8Vio7VPWXJPQrOt6/hyIgGafsAgSce4+dLyaGTgMB6vqAKXAK4cSI
         YAQ451r5Q8/W446Qoq1mOqtB6yJ5CfOcUs+wgdC7JuzDQ3bgE8rAajXAJNI0JwaQmfJs
         Adbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZmABSWSiE/DmAz3fqu+pp6Wg/xtNltn809coD4OK5tY=;
        b=SChBwL4JrBCbYvyLhvM3137FEQx3vHiZhY8fPV5HTGtRZzqU4Y0oWlU0yI5UhJXpKI
         T26FlKIIThDCbWxkiqTNPQiVdfGB7fSdWbYpppTCPlT1Nsz/eNmLBzTURGnrp+vbmqtA
         wsQIKSi3MypNFkhHUU0dB3Lxzx/j7qwgr2ZAUXtsoVmEbmxgN/7Y+eXfjm0MasNt7+1m
         VZ1Egv2imY9mugC+vXN3zfK0gP7dKLv+JT0l8jHfCRe3JdbyK7ojaIMK3AUglslYKds4
         SPMawsgbWRCb48Lg/4g9+E6Jt7JOxDqZOVUa9De7QyxYo/CJpi44IlIHy0jroS6298dG
         9Wyw==
X-Gm-Message-State: APjAAAXsPFYKk8sRejvw9ZupJnIZr8QESwwPLWHhvb9FREnblcU7VDFL
        GP22U47vnUvxqdc3iEBMIEujnEktv0M=
X-Google-Smtp-Source: APXvYqzIcWiFNbrgn+4nhN52sZvWCmF7vsACkE+e+Zj6x2tKw0phmWYvm8FSIYj7LhGY/2IG+0xWEA==
X-Received: by 2002:a17:902:76ca:: with SMTP id j10mr13215224plt.58.1573788135664;
        Thu, 14 Nov 2019 19:22:15 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id e17sm10749486pgt.89.2019.11.14.19.22.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 19:22:14 -0800 (PST)
Subject: Re: [PATCH] io_uring: Fix LINK_TIMEOUT checks
From:   Jens Axboe <axboe@kernel.dk>
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
References: <9a5eef46f7ed9f52f8de67d314651cd4a4234572.1573766402.git.asml.silence@gmail.com>
 <ef655254-b8ce-8ee3-a776-d44803557ad9@kernel.dk>
 <ea4f23f3-4751-2074-f553-d3db8b3c2bda@kernel.dk>
 <5c01de81-47db-3275-f08a-e8e376171e64@kernel.dk>
Message-ID: <34c4de2f-c0c8-616b-3a22-0cada9f71618@kernel.dk>
Date:   Thu, 14 Nov 2019 20:22:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5c01de81-47db-3275-f08a-e8e376171e64@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/14/19 7:36 PM, Jens Axboe wrote:
> On 11/14/19 5:12 PM, Jens Axboe wrote:
>> On 11/14/19 2:25 PM, Jens Axboe wrote:
>>> On 11/14/19 2:20 PM, Pavel Begunkov wrote:
>>>> If IORING_OP_LINK_TIMEOUT request is a head of a link or an individual
>>>> request, pass it further through the submission path, where it will
>>>> eventually fail in __io_submit_sqe(). So respecting links and drains.
>>>>
>>>> The case, which is really need to be checked, is if a
>>>> IORING_OP_LINK_TIMEOUT request is 3rd or later in a link, that is
>>>> invalid from the user API perspective (judging by the code). Moreover,
>>>> put/free and friends will try to io_link_cancel_timeout() such request,
>>>> even though it wasn't initialised.
>>>
>>> Care to add a test case for these to liburings test/link-timeout.c?
>>
>> Wrote some test cases, I think that io_req_link_next() is just wrong.
>> The below should correct it. We shouldn't loop here at all, just find
>> the first one. That'll start that guy, sequence will continue, etc.
> 
> Well that was crap, I sent an earlier unfinished version. Here's the
> right one:

I think the only thing missing after this is handling multiple linked
timeouts in a sequence. I'll do that now.

-- 
Jens Axboe

