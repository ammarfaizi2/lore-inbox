Return-Path: <SRS0=BBHt=ZN=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77B3C432C0
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 15:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C8120674
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 15:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tHXKGFrW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfKUP0A (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 21 Nov 2019 10:26:00 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:36241 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfKUP0A (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 21 Nov 2019 10:26:00 -0500
Received: by mail-il1-f193.google.com with SMTP id s75so3670810ilc.3
        for <io-uring@vger.kernel.org>; Thu, 21 Nov 2019 07:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7hhEaTNgvN1+N8FqUN7TDDkL4pibxMZ7pe90gonPtx0=;
        b=tHXKGFrWYeIKexMWSveTX0dSDRlZJBCfTwoRQzQ1XRRerc0SI2e7MaLYX/HcCz6WSZ
         S6vmdMoyTCnFo1B9SH/kBg249vty95ETUTzvILU45vuOZWUoqEwCwVkECTP7TYttItdY
         GsiRqy6IIWUqnYXGg6nwYmnFLlMUuTzrJANAOLLMoqcCk8DsmHPq1qHAm8ugmN2kQST+
         Hdgqwg04g5Azky2lPfhTVk8QIEit6G9JCCM1z7UCvjUsCQBGMlLVa/UDvt7WBcVtfiCi
         iEYBkyGIjIkC10AX0LXrHberG0PkhEobAHUfZVn1vOH/XLTwH85VtkkFN9nqBIu1SkYf
         iUTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7hhEaTNgvN1+N8FqUN7TDDkL4pibxMZ7pe90gonPtx0=;
        b=LAP0LB+jiD8UNLBga6jdsOcry0TbqR5nY+YlED1p7VjyD6DB7LjWlNG7OW+WGEAaoB
         y1Zdk/E/pwlb/ymHkvLvT1Ofd43X6b7l/zQKOmpoTlBAIhmOtqaE0TwK+64ZyqB94fL0
         bAtnTyBxdLBZUTQa/FANTMrO8Ro3UT+BYSfAgHqoiIrR5kacGwIUMWf5ersOumNT7+p0
         O2YtPxB1UIVf0Fi3ApWEFB7sGSchUgSLRsgWX/x4Mg6YSlrNBJP3xSGXXPZrxAnf2Wpw
         lBfwjBLdkIqiSBnbn4VtcgzEccfqKViKve/20BTAvGNncBm+jubxjej9AC95gTLlUxsl
         +Q2A==
X-Gm-Message-State: APjAAAVJO0SoxAirzLAsf9Y3JQoFjt+630DATB1sj74/l32GuQPcpC+F
        UcSOBsv6LgFP7afuo8PRfJTbHNv71jynaQ==
X-Google-Smtp-Source: APXvYqw+PGoREDjZt6HypAXDW/UZutxsH4DW6ucRAHpDv/oF+jWOyJUkJY3yoOmpG7BjyD5sjujP0Q==
X-Received: by 2002:a92:9a17:: with SMTP id t23mr10791158ili.40.1574349957655;
        Thu, 21 Nov 2019 07:25:57 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id v13sm1328584ili.65.2019.11.21.07.25.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 07:25:56 -0800 (PST)
Subject: Re: [PATCH] io_uring: drain next sqe instead of shadowing
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Jackie Liu <liuyun01@kylinos.cn>
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
 <b3387cf7-7cf6-eeb4-5513-1e1240a88321@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <309dbce5-aec4-dc0e-c86e-042416ee143d@kernel.dk>
Date:   Thu, 21 Nov 2019 06:50:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b3387cf7-7cf6-eeb4-5513-1e1240a88321@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/21/19 8:23 AM, Pavel Begunkov wrote:
> On 11/21/2019 4:53 PM, Jens Axboe wrote:
>> On 11/21/19 7:28 AM, Pavel Begunkov wrote:
>>>>>
>>>>> Was that a reviewed-by from you? It'd be nice to get these more
>>>>> formally so I can add the attributes. I'll drop the other patch.
>>>>
>>>> I want to do more tests. There is no test machine at this time, at least
>>>> until tomorrow morning.
>>>>
>>> BTW, aside from the locking problem, that it fixes another one. If
>>> allocation for a shadow req is failed, io_submit_sqes() just continues
>>> without it ignoring draining.
>>
>> Indeed. BTW, your commit message is way too weak for this patch. It
>> doesn't explain why we're making this change at all. I'm going to fix
>> it up.
>>
> Yeah, I were going to do that today. This one is of quick-before-leaving
> kind, I didn't even looked up into the problem discussion properly.
> 
> It needs 2 problems statements + reported-by

Here's what I have:

https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.5/io_uring-post&id=b1417baddedff723b22a4817753625350cfa895a


-- 
Jens Axboe

