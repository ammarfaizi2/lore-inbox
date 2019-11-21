Return-Path: <SRS0=BBHt=ZN=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED67C432C0
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 13:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20DCF2070A
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 13:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="JiXoNspg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfKUNrU (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 21 Nov 2019 08:47:20 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42918 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfKUNrT (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 21 Nov 2019 08:47:19 -0500
Received: by mail-pg1-f196.google.com with SMTP id q17so1613124pgt.9
        for <io-uring@vger.kernel.org>; Thu, 21 Nov 2019 05:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MyAiivcsF2PofDHmK8dKWR/6pmgyuHLP/0IXYbVSHUI=;
        b=JiXoNspg/7NCEu0esQ7xr9DOl2sx1niS8rRCX2AcTXH17rrG8iYmM/ZRu9CAY8ZYMl
         TkOXqm4nxG7Zl06Wj/NxsqQtW/uZgC/ZTdRYyg4JLr+2FZ5fg0liEFyK8F1Rm0nSL24F
         Ikaqs0YXTuUyiDcohFnS1PYgxrFRbEU8Bud52mk3ybjPWpyUMgF4DZ0EnJZ6m8/GzZjA
         yMCYpL9cIVq4PeyEMtJxHGgE67YbpEqGC7n9awaqA7tjlqn8Ss5OwYmq4uxVHMRaNf40
         QPhpJXdC1VlOVCmIdD8V9HHt6eIAXfknwWAERFYCZW4W/YQN5mtDXCbKXRgH40O4OlIK
         JtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MyAiivcsF2PofDHmK8dKWR/6pmgyuHLP/0IXYbVSHUI=;
        b=GzAFNtbMt9nIm+TYybLw3N7xlIVDBRBpFyXoFcWm28I0Zv811sFRDIbvzDj9m1NPy9
         KLjjrWqFHc7HKc21dORTggCbduuFi3GxL5AjxMm/m7bYX6hX8INLBK8ZcQpS2pby+eMo
         mvktAs7+aqybD3ut69I05C5YulaJSQiPVJbQ76vTVf3efgXqkncXs6jw8aFi6G/T4mVt
         ETi116x8rX37mv1ISFWTC7VZsvUCboFXyyH4p8bMqo6IbySRIpNdT3YVBsNktac2p+Mn
         VZDQHSP3+jiMpq7xeCZVojnCvzt+3aFLDHauJqSvd647hicsV8aUeq3w7H8RE/3nkkxK
         59eA==
X-Gm-Message-State: APjAAAV49yhmhWUfp2IxzsotAkkjtWyZJVvDD5SI8Jmq3la97b+Re/c/
        /8Rn7Ez5E/mMiS23F40br5TkiZSy7+/Wig==
X-Google-Smtp-Source: APXvYqwbn41c/brPs4x2Tq13lwX2yzOcY+e0MWa+oyQDjiDCmdOHkQnfzJGRLf8Cnoshtd6seDy0qg==
X-Received: by 2002:a63:d258:: with SMTP id t24mr9604702pgi.289.1574344038367;
        Thu, 21 Nov 2019 05:47:18 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id u3sm3468901pjn.0.2019.11.21.05.47.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 05:47:17 -0800 (PST)
Subject: Re: [PATCH] io_uring: drain next sqe instead of shadowing
To:     Jackie Liu <liuyun01@kylinos.cn>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     io-uring@vger.kernel.org
References: <2005c339-5ed3-6c2e-f011-5bc89dac3f5c@kernel.dk>
 <5e8a8176e29a61ec79004521bc2ef28e4d9715b1.1574325863.git.asml.silence@gmail.com>
 <A12FD0FF-3C4F-46BE-8ABB-AA732002A9CA@kylinos.cn>
 <bb367887-ed2c-1da3-59f5-c66f12ab7c5c@gmail.com>
 <5dd68282.1c69fb81.110a.43a7SMTPIN_ADDED_BROKEN@mx.google.com>
 <6da3585e-b419-ea9b-4246-1ee5ca14f5b9@gmail.com>
 <5dd68820.1c69fb81.64e0b.4340SMTPIN_ADDED_BROKEN@mx.google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b129f1ba-b82c-d8cf-7dbd-efd14fd3fe8f@kernel.dk>
Date:   Thu, 21 Nov 2019 06:47:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5dd68820.1c69fb81.64e0b.4340SMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/21/19 5:49 AM, Jackie Liu wrote:
> 
> 
> On 2019/11/21 20:40, Pavel Begunkov wrote:
>>> 在 2019/11/21 17:43, Pavel Begunkov 写道:
>>>> On 11/21/2019 12:26 PM, Jackie Liu wrote:
>>>>> 2019年11月21日 16:54，Pavel Begunkov <asml.silence@gmail.com> 写道：
>>>>>>
>>>>>> If there is a DRAIN in the middle of a link, it uses shadow req. Defer
>>>>>> the next request/link instead. This:
>>>>>>
>>>>>> Pros:
>>>>>> 1. removes semi-duplicated code
>>>>>> 2. doesn't allocate memory for shadows
>>>>>> 3. works better if only the head marked for drain
>>>>>
>>>>> I thought about this before, just only drain the head, but if the
>>>>> latter IO depends
>>>>> on the link-list, then latter IO will run in front of the link-list.
>>>>> If we think it
>>>>> is acceptable, then I think it is ok for me.
>>>>
>>>> If I got your point right, latter requests won't run ahead of the
>>>> link-list. There shouldn't be change of behaviour.
>>>>
>>>> The purpose of shadow requests is to mark some request right ahead of
>>>> the link for draining. This patch uses not a specially added shadow
>>>> request, but the following regular one. And, as drained IO shouldn't be
>>>> issued until every request behind completed, this should give the same
>>>> effect.
>>>>
>>>> Am I missed something?
>>>
>>> Thanks for explaining. This is also correct, if I understand
>>> correctly, It seems that other IOs will wait for all the links are
>>> done. this is a little different, is it?
>>
>> Yes, you're right, it also was briefly stated in the patch description
>> (see Cons). I hope, links + drain in the middle is an uncommon case.
>> But it can be added back, but may become a little bit uglier.
>>
>> What do you think, should we care about this case?
> 
> Yes, this is a very tiny scene. When I first time wrote this part of the
> code, my suggestion was to ban it directly.
> 
> For this patch, I am fine, Jens, what do you think.

I am fine with it as well, it'd be nice to get rid of needing that
extra request.

Was that a reviewed-by from you? It'd be nice to get these more
formally so I can add the attributes. I'll drop the other patch.

> The mailing list always rejects my mail, is my smtp server IP banned?

Probably because you have text/html in your email, the list is pretty
picky when it comes to anything that isn't just text/plain.

-- 
Jens Axboe

