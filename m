Return-Path: <SRS0=9Nvc=7S=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0A0C433E0
	for <io-uring@archiver.kernel.org>; Fri,  5 Jun 2020 22:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 612B4206F0
	for <io-uring@archiver.kernel.org>; Fri,  5 Jun 2020 22:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ycmsPe9Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgFEW1I (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 5 Jun 2020 18:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbgFEW1I (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 5 Jun 2020 18:27:08 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50374C08C5C2
        for <io-uring@vger.kernel.org>; Fri,  5 Jun 2020 15:27:08 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bh7so4235718plb.11
        for <io-uring@vger.kernel.org>; Fri, 05 Jun 2020 15:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Lf8dswigcXN36mTL58uWKzPytjTdJCSSCNEKAihLYHg=;
        b=ycmsPe9ZURPfcnHNdsrjrQ4HH9T1z0EDRgEb6mqQThbLpvnZ1fAmLxhdtJOtVTse6i
         rhQ2gDREuFe/5Efwtb15H71Fm7WSnvmpkm4MSsKCLeUm6Ojj8y/qpWCEagrB2BDjIKGR
         LqjuFPL8xiGYPaxpBJmNVM8AxXMoS99O9svbq9bVq7pXBAR7yawcyNqiUD4Pip/h1IZV
         ISvqecgC2WNiKBHMdf/iEQGGJv11cQ56LSobq1nnr3tc6AogRnrmzIKisxec5Pjc/Dph
         wxgPLiIixGrWDUt60BY664J5MY/vkeuMtxFD/aRbokoMM852Z1H+9iU/B4DGDduMPuNb
         rpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lf8dswigcXN36mTL58uWKzPytjTdJCSSCNEKAihLYHg=;
        b=mOsByPUf8aOOIEY/PDvLAyfIkqYQFuihoPaG76AXRZUD1kqhRe0uCyUImzxmc6Fh9u
         tSaohiunklbHsNyOJGcSJ5KYMohkq10sbVySdxneMH9OHVhq4mtaTGPQkqCVXetIzu1q
         cTSBqZiNXTeAgY1W/F9K+v/zpAJiof6pF+YRieubMa+LycBmeeSF71DUM2No+G8+TA07
         LE3wjCRZpURm8msJOKRh+nfHpSSWe0DD6GN9s3qKJkDD27dqk1jCPzT5bjCR4LCBhl2N
         u/MikJHOkDC/rm1PWpQpppdU7ib3UY2nACEyNcbgv282JHKp0br+MqdZUX/MGDutSisE
         Xv6A==
X-Gm-Message-State: AOAM531Y+e5L/ttQmFss6hGFrITPMEr8QEKMjtLK5ZRewk57fGmU4i56
        EHSI5Xc7Sy3E5BqVNxdqPnYYbxNLf9JAVg==
X-Google-Smtp-Source: ABdhPJyrSuYTlS42TRyPe56bBNGfZEoJtObP9JKmoY6gSG4RKfmuXkiciKlHf2VYspZIONQMpdiOpg==
X-Received: by 2002:a17:90a:f8e:: with SMTP id 14mr5674310pjz.172.1591396027517;
        Fri, 05 Jun 2020 15:27:07 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 6sm501876pfi.170.2020.06.05.15.27.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 15:27:06 -0700 (PDT)
Subject: Re: [PATCH] io_uring: re-issue plug based block requests that failed
To:     sedat.dilek@gmail.com
Cc:     io-uring@vger.kernel.org
References: <CA+icZUXRE+++FbchwF5Rhrj5AeRY=H2T8m07Y8CV5bhu_s5OgA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8ba08c47-10ec-6c65-39c2-4d183659c8f5@kernel.dk>
Date:   Fri, 5 Jun 2020 16:27:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CA+icZUXRE+++FbchwF5Rhrj5AeRY=H2T8m07Y8CV5bhu_s5OgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 6/5/20 4:05 PM, Sedat Dilek wrote:
> Hi Jens,
> 
> with clang-10 I see this new warning in my build-log:
> 
> fs/io_uring.c:5958:2: warning: variable 'ret' is used uninitialized
> whenever switch default is taken [-Wsometimes-uninitialized]
>         default:
>         ^~~~~~~
> fs/io_uring.c:5972:27: note: uninitialized use occurs here
>         io_cqring_add_event(req, ret);
>                                  ^~~
> fs/io_uring.c:5944:13: note: initialize the variable 'ret' to silence
> this warning
>         ssize_t ret;
>                    ^
>                     = 0
> 1 warning generated.

Thanks! I'll fold in the fix.

-- 
Jens Axboe

