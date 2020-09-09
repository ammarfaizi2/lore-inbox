Return-Path: <SRS0=/ioG=CS=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA9BC2D0A8
	for <io-uring@archiver.kernel.org>; Wed,  9 Sep 2020 17:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30FC421D92
	for <io-uring@archiver.kernel.org>; Wed,  9 Sep 2020 17:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SRwj4zfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbgIIRUk (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729913AbgIIPZN (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 9 Sep 2020 11:25:13 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDCDC061364
        for <io-uring@vger.kernel.org>; Wed,  9 Sep 2020 07:06:23 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id d18so3221153iop.13
        for <io-uring@vger.kernel.org>; Wed, 09 Sep 2020 07:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eHcdzC1Vjr+eEnGNce0StnaH8r/3dCNL4SRhcQUMlRk=;
        b=SRwj4zfFnrfJCYIIa0d/pBN8bUN1FeFiAh96+74cn1CriZXzI62ZHkuLvFCm6P31lL
         AAOxNZRtYsFtarUskfSyDHgH5fLM4ZtWeKnXcmmKHIaiBKiZNP67+5fR0W0PYjWJIIEF
         K/PWJr/LqEGo9WHPdegONBrkQLVHa0/EC+BlUxnGBk4/LmqeOO2PXhuT7v9pv2KWydkH
         U8kkt+8qIX+hlCCV3yYb1+qmBEuPB5wRlccXD0ilVAlYXH8t6Ktl2UoYqQ4p2VJqrOAD
         voO4N5MntQYmhAR4e36C1c+DcZIgl1QkLbYtrW1phmIzBa8UfN6iN2O5LDMLoySEEKMf
         7/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eHcdzC1Vjr+eEnGNce0StnaH8r/3dCNL4SRhcQUMlRk=;
        b=KQ5OTFEE0HSwcmu2W4bOqtCkdmTdMDothc9YNdio2y9uQb5YMnFySvu+gfY7cwE35W
         V8qR5I1EfJw5+wiviZP6qMMTGCEoIgCr49SMNDicD7OaUtbS0GU27FYKkA6VPWAPZumC
         XyBE2ACxGhitY/2xpxkhLw7sTF2gU+w6PDOZs1C8YBtmfhsB7cx3Kxq+WmWMtvW9cRIG
         Cd2r5cQWxXdEIFFJaKj+RVyOgTwbF8pJ4cAhKNO6VH9iZbkV9miQBfaQWC6sOj3ERRvz
         u8L2QE4ypoopV3BYUbthqkEFQYtjHMhsKtD6y7CVV2p3lTihS2vXjPy+yU8CEKi8gpZP
         56hw==
X-Gm-Message-State: AOAM532P1dhDW3NAN5h5kaco/YGMe9Weg90tCvyZXlGxnOYGWGWbQrUL
        POTMgs0JtgWemCdbg9p4GD8xYA==
X-Google-Smtp-Source: ABdhPJwtzLv8bwenmUUA+lfQ5tOU/l3y2j8uN59etgpB1Dhk5UazCcenXSIw2/PDFTejToUeurv5fg==
X-Received: by 2002:a05:6602:584:: with SMTP id v4mr3535381iox.195.1599660378888;
        Wed, 09 Sep 2020 07:06:18 -0700 (PDT)
Received: from [192.168.1.10] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id y19sm1373254ili.47.2020.09.09.07.06.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 07:06:18 -0700 (PDT)
Subject: Re: [PATCH -next] io_uring: Remove unneeded semicolon
To:     Zheng Bin <zhengbin13@huawei.com>, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     yi.zhang@huawei.com
References: <20200909121237.39914-1-zhengbin13@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cef491f9-0df7-ec9f-ebb2-0f62adcdc39d@kernel.dk>
Date:   Wed, 9 Sep 2020 08:06:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200909121237.39914-1-zhengbin13@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 9/9/20 6:12 AM, Zheng Bin wrote:
> Fixes coccicheck warning:
> 
> fs/io_uring.c:4242:13-14: Unneeded semicolon

Thanks, applied.

-- 
Jens Axboe

