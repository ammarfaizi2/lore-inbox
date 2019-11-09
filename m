Return-Path: <SRS0=jnAq=ZB=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186CDC17441
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 03:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0686207FF
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 03:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mxD2tSQY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbfKIDKN (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 8 Nov 2019 22:10:13 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41745 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbfKIDKN (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 8 Nov 2019 22:10:13 -0500
Received: by mail-pf1-f195.google.com with SMTP id p26so6391442pfq.8
        for <io-uring@vger.kernel.org>; Fri, 08 Nov 2019 19:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PAGQ9BamrFPNi3L0HZ917S+2wCrFqiIha5TpD1SOVFk=;
        b=mxD2tSQYcxFV+ff+5PR16k/LZQlUT/g6UBROs5nlMrqDtqpvXM15tuDnJpR2mZeE2R
         SaWnrOS+/smm0ZPjWf2QwbsIuIOSBvsOsazqr2N3LtNE3y7mu0sreeI+vk9HJI1xRohP
         qXaVxLnh7LOTOnGxsqtSb+0kTVkjxN7OIkIDP6AGpT+gR4AKg5hDiwuGnQLbCwwo9Rl5
         /xxa9Reuv62nyL+mshxligTo1TqjbJ6Rto/eypZAIi3nSzg43ha29HImVmaukbBxpG9M
         zHrvmVPL0Witf971I3uddLVTso/T4iRiwffxGhVJLgGSyVXGagoK/KBHKPzPdNHKO4yV
         UO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PAGQ9BamrFPNi3L0HZ917S+2wCrFqiIha5TpD1SOVFk=;
        b=nlWqlfel/jOiF1bvGVhWQS4Lqt/zcwuTlJc+bNNTU2JwRJbXMknJ6dE4IG2CJtqvvi
         fDVeZViFy/VJVqK2z8XuYUhR1NXZqXzTKAmQDOVWfdrZEeLUpNl0wIVbqEdynotGmBlZ
         R46nP2G6fyGYWF5p2EqQZiBhiECW38MDrObK/NclCx9OlyuPqNcW/bUvdm5KtRB2r1MJ
         4ICpnCYX6Exoquj5jh3Y4lMi8ezSF72TZGa26vYbw1T1nECh6tBnTaOVkEgXzCWDTtqP
         9AUlRZwIGcp9gWFgwZqGt3PAIfJJgQx6ruGbSMVvepfw5dOOOV8i0oXi2AgMGlSieZCc
         mDww==
X-Gm-Message-State: APjAAAUlF4TDv5GmSG/UKOo5YLWNgFd96YdJNm1eSbBvSFYQPwT6+DfL
        om1CuVBwEJ+cAlQ2T3tAn1cfQPDi/sw=
X-Google-Smtp-Source: APXvYqxE1/qJYLRKgPTPS3LRVDdFDTNS/EFdAjKq0PTEt7JXfw6/bLM7xrFMOBxXbSWwbPKmI+6eog==
X-Received: by 2002:a63:a804:: with SMTP id o4mr14809853pgf.401.1573269010324;
        Fri, 08 Nov 2019 19:10:10 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id y4sm7540413pgy.27.2019.11.08.19.10.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 19:10:09 -0800 (PST)
Subject: Re: [PATCH] liburing: Add regression test case for link with drain
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     io-uring@vger.kernel.org
References: <1573268409-86058-1-git-send-email-liuyun01@kylinos.cn>
 <1573268409-86058-2-git-send-email-liuyun01@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cb0cd46a-2703-df7a-af7d-33b0b9b9c3d1@kernel.dk>
Date:   Fri, 8 Nov 2019 20:10:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1573268409-86058-2-git-send-email-liuyun01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/8/19 8:00 PM, Jackie Liu wrote:
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
>   test/Makefile     |   5 ++-
>   test/link_drain.c | 122 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 125 insertions(+), 2 deletions(-)
>   create mode 100644 test/link_drain.c

Great to have this! Thanks.

I really like how the regressions tests keep on growing, and generally of
high quality. We would not be able to move as fast on features or changes
on io_uring as we do now, if it wasn't for the test suite.

-- 
Jens Axboe

