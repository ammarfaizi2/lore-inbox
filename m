Return-Path: <SRS0=BBHt=ZN=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C29C432C0
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 15:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C8B20674
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 15:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJCgUf/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfKUPYC (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:24:02 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44769 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfKUPYB (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 21 Nov 2019 10:24:01 -0500
Received: by mail-lj1-f196.google.com with SMTP id g3so3633382ljl.11
        for <io-uring@vger.kernel.org>; Thu, 21 Nov 2019 07:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AQbPtfF2zEY07pxSXgtUDt2X382iPcyeBX3+EeDPu+U=;
        b=IJCgUf/jHAqwpLfOcxEngu+t6rHjylm0tpu9f6MQgGWxd92jzFhqy7ufCjfuH9WkAm
         he13Z0dJ6CP5rM3NEsFlMeB/7WKo6+e+aqwyWj5iCE8jvBH0kEsYivl+/1KLZ/Sn7A8f
         7KJz5b3GG/wvAqdTptJYyvAiPNu27XW/NqcS7s0qr3XsR2amf/O6D8CyrZWPMpf1safK
         6TyYXiwXuN7NWug0vVInOp9fuvUhWEmFf2p/O1Ec2uCOurWDS++uffJgJ8jPFfXQfIBS
         XjL/GE5/EOhGASD7i/6+QgIEyV9bU648/4Kcz7uoNkpn80Lpq+i5EPvsl3ocf4JrxYRw
         umGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AQbPtfF2zEY07pxSXgtUDt2X382iPcyeBX3+EeDPu+U=;
        b=t8rhAUJBa/lTUOctGTthr1C+AiWwLXbf3Adza17m0kB5rasXRhGHf0F6dpIgBspb4Z
         cPCeT33dZOe6YrKLVzg3JpeiDKA3BaLsX/RtM+FXBxZw/uWz8oEQm0cz8g0XZ5g48V3M
         rSnAb2Q+wYhrGsC1X2pUkxSvFiu/ubCUhyJv2QyZ2XRYME/iBOahi5OKok2uhim+WEJd
         t3uTf5ngh+iL/O+WF4wo4J5l6nyTnYC5QV9pBEMvmSwhtsUlTB50uWzezjqR0klR+yor
         OvayAGWoZkxLJvFmKApIIxCcuiS6gTkrT5wsH8pGCSvH+Xv/WwdEdM2JxIaCAofSJwTX
         np/g==
X-Gm-Message-State: APjAAAWs0bjYlS8f/T514LtmbRNsP12LNGBlD/VUdNch1W+J7TUhg/Wd
        WmT9/ueNDPr1rRevrnhPb64JdkpTxOA=
X-Google-Smtp-Source: APXvYqyKyzQxzgoaVdNIa+9j+bPpyCIajrhK7hizLbfFY1NNg/vdSXO7pqRpjKLBngl6XaXeuZIw3A==
X-Received: by 2002:a05:651c:205b:: with SMTP id t27mr8226016ljo.143.1574349839055;
        Thu, 21 Nov 2019 07:23:59 -0800 (PST)
Received: from [172.31.190.83] ([86.57.146.226])
        by smtp.gmail.com with ESMTPSA id m12sm1557328lfb.60.2019.11.21.07.23.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 07:23:58 -0800 (PST)
Subject: Re: [PATCH] io_uring: drain next sqe instead of shadowing
To:     Jens Axboe <axboe@kernel.dk>, Jackie Liu <liuyun01@kylinos.cn>
Cc:     io-uring@vger.kernel.org
References: <2005c339-5ed3-6c2e-f011-5bc89dac3f5c@kernel.dk>
 <5e8a8176e29a61ec79004521bc2ef28e4d9715b1.1574325863.git.asml.silence@gmail.com>
 <A12FD0FF-3C4F-46BE-8ABB-AA732002A9CA@kylinos.cn>
 <bb367887-ed2c-1da3-59f5-c66f12ab7c5c@gmail.com>
 <5dd68282.1c69fb81.110a.43a7SMTPIN_ADDED_BROKEN@mx.google.com>
 <6da3585e-b419-ea9b-4246-1ee5ca14f5b9@gmail.com>
 <5dd68820.1c69fb81.64e0b.4340SMTPIN_ADDED_BROKEN@mx.google.com>
 <b129f1ba-b82c-d8cf-7dbd-efd14fd3fe8f@kernel.dk>
 <5dd69c43.1c69fb81.6589a.b4f1SMTPIN_ADDED_BROKEN@mx.google.com>
 <1feba72a-08f9-14c3-91c6-7efe4d5b1d8b@gmail.com>
 <dc17c870-d7e0-44c5-e27b-d358d04a3ddf@kernel.dk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Message-ID: <b3387cf7-7cf6-eeb4-5513-1e1240a88321@gmail.com>
Date:   Thu, 21 Nov 2019 18:23:57 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <dc17c870-d7e0-44c5-e27b-d358d04a3ddf@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/21/2019 4:53 PM, Jens Axboe wrote:
> On 11/21/19 7:28 AM, Pavel Begunkov wrote:
>>>>
>>>> Was that a reviewed-by from you? It'd be nice to get these more
>>>> formally so I can add the attributes. I'll drop the other patch.
>>>
>>> I want to do more tests. There is no test machine at this time, at least
>>> until tomorrow morning.
>>>
>> BTW, aside from the locking problem, that it fixes another one. If
>> allocation for a shadow req is failed, io_submit_sqes() just continues
>> without it ignoring draining.
> 
> Indeed. BTW, your commit message is way too weak for this patch. It
> doesn't explain why we're making this change at all. I'm going to fix
> it up.
> 
Yeah, I were going to do that today. This one is of quick-before-leaving
kind, I didn't even looked up into the problem discussion properly.

It needs 2 problems statements + reported-by

-- 
Pavel Begunkov
