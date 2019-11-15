Return-Path: <SRS0=yjkE=ZH=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37ACAC432C3
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 22:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 045322073A
	for <io-uring@archiver.kernel.org>; Fri, 15 Nov 2019 22:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tIeBXhX5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbfKOWZM (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 15 Nov 2019 17:25:12 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32851 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfKOWZM (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 15 Nov 2019 17:25:12 -0500
Received: by mail-pl1-f195.google.com with SMTP id ay6so5622101plb.0
        for <io-uring@vger.kernel.org>; Fri, 15 Nov 2019 14:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lam3eXmSSPsdV3ln6vXtObG/p1mq+6yGi5DT9YZMyzQ=;
        b=tIeBXhX5oummlxSqnhwprhOuTFrjj/0V/C0kwYPNFqrBVb2pLRodlneVFZU+jzntP5
         lJHuvE7oKbA+x2zNb1kbezPAQdHw4xwn/FZGvK27P7zrv6gv1hKfNnCkYJkj0oygByXb
         C9TXcSubh9UDra/lb44LSseiVih+dOeUa1ZFaOjugOc369zK+Bq47Xd+bL2w63MvwBub
         wMyN8evYJzvDrrzY3nVSLMR1kIo3whyqLk8Ur+ASpmEy6BRlq8LfcB7aWnGBY+M2yXzT
         UlhASz5OxbFKPkJY0QkY9J3eQdf8hn9uhLjG4yxNZS3ikolxaSu7N6BtjuvIl3t0nNcG
         rlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lam3eXmSSPsdV3ln6vXtObG/p1mq+6yGi5DT9YZMyzQ=;
        b=jAr4x1KLo+sGBuRMPTzj0XhQdLOePXUUY3rkriwj0MtS0KlFeq316jvj2awo2qTqAi
         KHYFnKetA/OwxmPIdOdB0gAlNdmzrfRX/U1kVE7oCaIwBnLR21yg1uulJivldSqPftM/
         HmCOYXkG9DItXfp+HCfR8wkZ85jYKn9oFv+yTQZaBLB9RxVFybwPeyxcM7v52Mx7zSND
         oqiNcyPZu8yj3DwGv+rtJz4ncvCqScvkGZJOL+kuaJSRfMl2SO3udSuGQGKW7CpxZM1W
         /ld36lqzOMMgjeiSQ1WB3Nh4GZiwBK5guU6+QWuiyKhxI1XOhZXgHpCmDvpOmXcLYZk7
         Ijsg==
X-Gm-Message-State: APjAAAXiXXNG4n8IHvFWlyoPGZV4Z6q7ONll0rbF0Po07qZHs6xsYBtJ
        oHT1WcQRMd6r9q3phbGxQ0hpRg==
X-Google-Smtp-Source: APXvYqzb7V06t067yQYh8XFflKjOsMPSsLTsbTLFUyR+3v1fmzGZDXxVmUJPNZqr/wvw6p/02Zzk6g==
X-Received: by 2002:a17:90a:bd95:: with SMTP id z21mr22815798pjr.10.1573856710419;
        Fri, 15 Nov 2019 14:25:10 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id x2sm10927973pfn.167.2019.11.15.14.25.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 14:25:09 -0800 (PST)
Subject: Re: [PATCHSET 0/2] io_uring support for linked timeouts
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
Cc:     zeba.hrvoje@gmail.com, liuyun01@kylinos.cn
References: <20191105211130.6130-1-axboe@kernel.dk>
 <4566889a-7e12-9bfd-b2a1-716d8b934684@gmail.com>
 <9b6cd06b-cd6c-d7e5-157b-32c1e2e9ceac@kernel.dk>
 <3c0ef10d-9524-e2e2-abf2-e1b0bcee9223@gmail.com>
 <178bae7d-3162-7de2-8bb8-037bac70469b@gmail.com>
 <d0f1065e-f295-6c0d-66cc-a424ec72751b@kernel.dk>
 <aabbed5f-db68-4a48-1596-28ac4110ce95@gmail.com>
 <2b35c1a0-69bf-1e50-8bda-2fff73bac8de@kernel.dk>
 <cdba1334-b037-d223-29a6-051bd49fef70@kernel.dk>
 <bde153ca-ff2a-8899-172e-0aa6359bff8c@gmail.com>
 <a35ad645-0340-62e4-fba7-7c1a080a9a65@kernel.dk>
 <62cb2281-f107-7bfa-bbab-2134d473066c@gmail.com>
 <31482102-510e-3421-1a32-c864475e3b87@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6728eb90-ce52-dc1f-c436-e1162d9293be@kernel.dk>
Date:   Fri, 15 Nov 2019 15:25:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <31482102-510e-3421-1a32-c864475e3b87@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/15/19 3:23 PM, Pavel Begunkov wrote:
> On 16/11/2019 01:19, Pavel Begunkov wrote:
>> On 16/11/2019 01:15, Jens Axboe wrote:
>>> On 11/15/19 2:38 PM, Pavel Begunkov wrote:
>>>> On 16/11/2019 00:16, Jens Axboe wrote:
>>>>> On 11/15/19 12:34 PM, Jens Axboe wrote:
>>>>>> How about something like this? Should work (and be valid) to have any
>>>>>> sequence of timeout links, as long as there's something in front of it.
>>>>>> Commit message has more details.
>>>>>
>>>>> Updated below (missed the sqe free), easiest to check out the repo
>>>>> here:
>>>>>
>>>>> https://git.kernel.dk/cgit/linux-block/log/?h=for-5.5/io_uring-post
>>>>>
>>>>> as that will show the couple of prep patches, too. Let me know what
>>>>> you think.
>>>>>
>>>>
>>>> Sure,
>>>>
>>>> BTW, found "io_uring: make io_double_put_req() use normal completion
>>>> path" in the tree. And it do exactly the same, what my patch was doing,
>>>> the one which "blowed" the link test :)
>>>
>>> Hah yes, you are right, you never did resend it though. I'll get
>>> rid of the one I have, and replace with your original (but with
>>> the arguments fixed).
>>>
>> Just keep yours, it's better :)
> 
> Moreover, mine have one extra REQ_F_FAIL_LINK, which really
> should not be there.

Gotcha, ok I'll just keep it as-is.

-- 
Jens Axboe

