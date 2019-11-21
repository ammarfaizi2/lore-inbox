Return-Path: <SRS0=BBHt=ZN=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D9DC432C0
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 12:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63DD32075E
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 12:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rz9AaAQ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfKUMkG (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 21 Nov 2019 07:40:06 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37730 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfKUMkG (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 21 Nov 2019 07:40:06 -0500
Received: by mail-lj1-f194.google.com with SMTP id d5so3056878ljl.4
        for <io-uring@vger.kernel.org>; Thu, 21 Nov 2019 04:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qmC/A0TE1Amj8ipp0/Sm9OqQTUGtR7Z7A+i8/z6Y3aI=;
        b=Rz9AaAQ2dSckigI3PEr2sNPzEvdTu9yzOP6eIbEK11Bigpq9vWp0rl941szH8DVib0
         zaR4oxNV5WycQ/nS11PlqHGdNkXOBp+LCbzPj4TANWTVe0ysI7MCs3hPOEVhJ9BXu1qS
         a0m5o52MLTVH//EVzr/vhn7Ex5Fgh+LnveK85zkTFGWgtz8Gn2sQwei4qkGd4JT9wAEV
         z1OwVg4TUFGAx3IZZBOGI3STwvx4RbI3YB1IG9EFB1iUVxIn9TzRjeBeR+1lPtlApHdX
         7gcn/IyIDZOskxlZc/tdpCjTPpUCN5/5ePTZwdRRXSFvGIcufzcnXV+YYeu57HMCAvps
         H+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qmC/A0TE1Amj8ipp0/Sm9OqQTUGtR7Z7A+i8/z6Y3aI=;
        b=Et4NmMuScxdWpE5/1/VdjNnZ5inyr5T0fo520t3lMO7NYK0RtaDwNz4ctMSzLPCQCH
         bByG8B691nKxx3GKhpO0IsnRjPjODkd6cw+SqK/5KDemxtcPYAh/gN0uUdH4rerh5pYG
         BAw0+Gc/fQ5r1k/vIaLHAHE/DXRBKM0QWyUlbcahvWIrjo+HHIuBhr5eIyBddCMJMWYL
         1XLkoIVEbt4qXDR+IGUDUHLw1Fr9iE64/iKDNTEoXCAfaYw4Zm1EjgXaxZkZF9657VS0
         sEaaRXro0+STUCe5R+jUPLj3DSSUn/JwXjrRSxLBuJVQRdwYao18fFhI2gONvu9F5FnG
         oQwA==
X-Gm-Message-State: APjAAAVRxNTa7B1Gj39DjojXBadLCV3bUflKmvfSrnRv01pCP+a8fKfa
        3WBQZlWQ1cy8PM1POQ9EIEGU72X3ciM=
X-Google-Smtp-Source: APXvYqwl8Hws3MR9zRnw0uN760Mv7shf2HGUUCaXxOfS0d/MCD2yFxwaBIBEmgsMKRs4EhLgB2Z1bw==
X-Received: by 2002:a2e:22c1:: with SMTP id i184mr7398878lji.1.1574340003380;
        Thu, 21 Nov 2019 04:40:03 -0800 (PST)
Received: from [172.31.190.83] ([86.57.146.226])
        by smtp.gmail.com with ESMTPSA id l21sm1306198lfc.62.2019.11.21.04.40.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 04:40:02 -0800 (PST)
Subject: Re: [PATCH] io_uring: drain next sqe instead of shadowing
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
References: <2005c339-5ed3-6c2e-f011-5bc89dac3f5c@kernel.dk>
 <5e8a8176e29a61ec79004521bc2ef28e4d9715b1.1574325863.git.asml.silence@gmail.com>
 <A12FD0FF-3C4F-46BE-8ABB-AA732002A9CA@kylinos.cn>
 <bb367887-ed2c-1da3-59f5-c66f12ab7c5c@gmail.com>
 <5dd68282.1c69fb81.110a.43a7SMTPIN_ADDED_BROKEN@mx.google.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Message-ID: <6da3585e-b419-ea9b-4246-1ee5ca14f5b9@gmail.com>
Date:   Thu, 21 Nov 2019 15:40:01 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <5dd68282.1c69fb81.110a.43a7SMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

> 在 2019/11/21 17:43, Pavel Begunkov 写道:
>> On 11/21/2019 12:26 PM, Jackie Liu wrote:
>>> 2019年11月21日 16:54，Pavel Begunkov <asml.silence@gmail.com> 写道：
>>>>
>>>> If there is a DRAIN in the middle of a link, it uses shadow req. Defer
>>>> the next request/link instead. This:
>>>>
>>>> Pros:
>>>> 1. removes semi-duplicated code
>>>> 2. doesn't allocate memory for shadows
>>>> 3. works better if only the head marked for drain
>>>
>>> I thought about this before, just only drain the head, but if the
>>> latter IO depends
>>> on the link-list, then latter IO will run in front of the link-list.
>>> If we think it
>>> is acceptable, then I think it is ok for me.
>>
>> If I got your point right, latter requests won't run ahead of the
>> link-list. There shouldn't be change of behaviour.
>>
>> The purpose of shadow requests is to mark some request right ahead of
>> the link for draining. This patch uses not a specially added shadow
>> request, but the following regular one. And, as drained IO shouldn't be
>> issued until every request behind completed, this should give the same
>> effect.
>>
>> Am I missed something?
> 
> Thanks for explaining. This is also correct, if I understand
> correctly, It seems that other IOs will wait for all the links are
> done. this is a little different, is it?

Yes, you're right, it also was briefly stated in the patch description
(see Cons). I hope, links + drain in the middle is an uncommon case.
But it can be added back, but may become a little bit uglier.

What do you think, should we care about this case?

> 
> -- 
> Jackie Liu
> 
> 

-- 
Pavel Begunkov
