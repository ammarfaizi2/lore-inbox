Return-Path: <SRS0=pC3Y=ZR=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524F7C432C0
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 03:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 224CA20748
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 03:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1zgcFnXb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfKYDrQ (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 24 Nov 2019 22:47:16 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38263 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbfKYDrQ (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 24 Nov 2019 22:47:16 -0500
Received: by mail-pf1-f195.google.com with SMTP id c13so6686494pfp.5
        for <io-uring@vger.kernel.org>; Sun, 24 Nov 2019 19:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=50DHB2gnFylf6gKLegx9OQBZUm3NuaxWp7f09A6Xrzk=;
        b=1zgcFnXbgtapnvAa+Jd1MLRVnIvS7xio4Uwo/DU6Or82yU5H23DSQr2LdPyiE4Pa9R
         LaDovVHTDsTGK0EwOEOWs7JccQAbn0HsnG+2ZHVon1kEe5Js/nNpgwSIz/+/uHVlV91N
         fUx/s6Ac2v47Xxm3XhvYMA65PLfVmuf+2ReIv+r3G6I0OuOckYgRnOHI2WwEnvDccXMd
         oFefY8xskcZs5NIMehfITO5nfkBSyTuYtFVhIgzSekvCvMOOFQQYX+EhTmAMtiLPxjrT
         5LlLbvvQXcPagUnrYcfNxjQBBTn79BSjIaP1peUXYq2LYJeOkTL7b3XEfHNclSsYo5nl
         D/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=50DHB2gnFylf6gKLegx9OQBZUm3NuaxWp7f09A6Xrzk=;
        b=pqaot2HjECFfbhKrJinrFvy7rhesTX8u41bcFm8nB24tEHyzsOeIOuLezk7JcmROCi
         97w/2iqcdLyKLGOpJlQ+X8XmfelARLpr86pxQj72xzX5wVBkOKU3LiqTw7q3YWixBISZ
         PxAnSKna8/YbnvQjUeDoT1OongbervEU8CAFp/DtIFw67JXlwNB3c+ikR39XP7G9nNZt
         GGf57n59bBhd1sM6tMva1MY/TZ9oYT/NLGTEIVoFfoE2pUB4QyxPE7npE2RSVWvHqbwt
         hdK1a/uSt/xbvK1BJJhKS8AY6GLmwWCb5MtFAhj2yBvWJxJ2zTkxE3mmwceQmmSFQDiX
         ZOXQ==
X-Gm-Message-State: APjAAAUWuaPM2zZix9kYaUMFVPIqkZ0kCMx4QVfm9wjNqGqleN8cV9JO
        Me9BTqDftYAuaJEs3NNcrPdknDcc3C3kCA==
X-Google-Smtp-Source: APXvYqzHAVOXK/VKOEYUy5wELp4W4VH9qwEe3ND4AP0oUm+itC+CuH0Mar9QOyc9sqqXnmF+4NmwzQ==
X-Received: by 2002:a63:4c43:: with SMTP id m3mr30666680pgl.315.1574653635527;
        Sun, 24 Nov 2019 19:47:15 -0800 (PST)
Received: from [192.168.1.205] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id p9sm6214920pfq.40.2019.11.24.19.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Nov 2019 19:47:14 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Jens Axboe <axboe@kernel.dk>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] io_uring: fix dead-hung for non-iter fixed rw
Date:   Sun, 24 Nov 2019 20:47:13 -0700
Message-Id: <97C3369D-8788-464A-A3B3-241708A4B454@kernel.dk>
References: <107FEF05-A0E6-4E81-BD0A-BB360CD7F628@byteisland.com>
Cc:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
In-Reply-To: <107FEF05-A0E6-4E81-BD0A-BB360CD7F628@byteisland.com>
To:     Jackie Liu <jackieliu@byteisland.com>
X-Mailer: iPhone Mail (17C5046a)
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org


> On Nov 24, 2019, at 8:38 PM, Jackie Liu <jackieliu@byteisland.com> wrote:
>=20
> =EF=BB=BF
>=20
>> 2019=E5=B9=B411=E6=9C=8825=E6=97=A5 10:38=EF=BC=8CJens Axboe <axboe@kerne=
l.dk> =E5=86=99=E9=81=93=EF=BC=9A
>>=20
>>> On 11/24/19 5:43 PM, Jackie Liu wrote:
>>>=20
>>>=20
>>>> 2019=E5=B9=B411=E6=9C=8825=E6=97=A5 01:52=EF=BC=8CPavel Begunkov <asml.=
silence@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>>>>=20
>>>> On 24/11/2019 20:10, Jens Axboe wrote:
>>>>> On 11/24/19 1:58 AM, Pavel Begunkov wrote:
>>>>>> Read/write requests to devices without implemented read/write_iter
>>>>>> using fixed buffers causes general protection fault, which totally
>>>>>> hangs a machine.
>>>>>>=20
>>>>>> io_import_fixed() initialises iov_iter with bvec, but loop_rw_iter()
>>>>>> accesses it as iovec, so dereferencing random address.
>>>>>>=20
>>>>>> kmap() page by page in this case
>>>>>=20
>>>>> This looks good to me, much cleaner/simpler. I've added a few pipe fix=
ed
>>>>> buffer tests to liburing as well. Didn't crash for me, but obvious
>>>>> garbage coming out. I've flagged this for stable as well.
>>>>>=20
>>>> The problem I have is that __user pointer is meant to be checked
>>>> for not being a kernel address. I suspect, it could fail in some
>>>> device, which double checks the pointer after vfs (e.g. using access_ok=
()).
>>>> Am I wrong? Not a fault at least...
>>>>=20
>>>> #define access_ok(...) __range_not_ok(addr, user_addr_max());
>>>>=20
>>>> BTW, is there anybody testing it for non x86-64 arch?
>>>>=20
>>>=20
>>> I have some aarch64 platform, What test do you want me to do?
>>=20
>> A basic one to try would be:
>>=20
>> axboe@x1:/home/axboe/git/liburing $ test/stdout=20
>> This is a pipe test
>> This is a fixed pipe test
>>=20
>> But in general I'd just run make runtests in the liburing directory
>> and go through all of them.
>>=20
>=20
> For test/stdout is PASS. Tested-by: Jackie Liu <liuyun01@kylinos.cn>

Thanks!

> But test/accept-link and test/fixed-link failed in for-5.5/io_uring-post b=
ranch.
> that is expect?

Yes, the fix for that is in 5.4, didn=E2=80=99t merge it into the 5.5 branch=
. It=E2=80=99ll pass once Linus pulls the 5.5 bits and the branches merge.=20=


=E2=80=94=20
Jens Axboe

