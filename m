Return-Path: <SRS0=UBdq=ZV=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A61C432C0
	for <io-uring@archiver.kernel.org>; Fri, 29 Nov 2019 17:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A4DB216F4
	for <io-uring@archiver.kernel.org>; Fri, 29 Nov 2019 17:19:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="gnPU+aFe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfK2RTI (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 29 Nov 2019 12:19:08 -0500
Received: from mail-pf1-f180.google.com ([209.85.210.180]:37458 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbfK2RTH (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 29 Nov 2019 12:19:07 -0500
Received: by mail-pf1-f180.google.com with SMTP id s18so718267pfm.4
        for <io-uring@vger.kernel.org>; Fri, 29 Nov 2019 09:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=atD/SeTuAdpeJthdMe7F2FiasybKORZCosKUEbA0WqE=;
        b=gnPU+aFesHihtq9CqLLBnLNqP7V3f7NduS62gA5UGBjcVHc+G1li5ug+GZp/KJJafb
         Xr0xzrAxgQ+XK7xXcomYmerFeE+hGQWL1usPxOiAjcXBEUqKjQfvjAhxtgOBcCA1RLAj
         Fv+NZkmlMnqCKzDp1bzmnYChXUOGOvtOipPZNTzVG+Z3sUAgWByuVplUAmnW7IHNu+Dl
         5Nkht+hRmzPgFsagKCq+cnfVgrGeGHsC84/WWbu4Sd7jxe3vGFaDtqJ+hvz2bWxR+7HF
         o18jfllgOsVRoFzAbviJiy7t4wUBPd6JiClXWD4LKFYNNiSPTx3mUfDATpXv+a7YR121
         P54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=atD/SeTuAdpeJthdMe7F2FiasybKORZCosKUEbA0WqE=;
        b=sKqZvCo+oI43hbJf5HvUxzyqGU++zcOyynhKxL3xDUy9UaKc5sbWrh9W/rccjpq12I
         e76VnQXFKaW5vFnmy5cF8BlFrLR8jvv+0UmUNIANocp24uv0e9quRddHS++IwARUt0b5
         Mb3Ilc6vfkGTfD+0xpZPLXrOxtUdchBqB5qXRH4jkR3l16RKKk/OMil0td+YTfBTGA+t
         qlw0630Zg+NJGkDuUiR7GiPN9isKZt9YsegblaN+M2mw0ldFWsUDnNV+2S1vOTXFDywt
         htd7n/nLJvVsZxZPqo+UB+oL7lESXj7GVHSz6UwLcmY5FX2eAJSGoN3S62ojJTFTfF/u
         vjaA==
X-Gm-Message-State: APjAAAWO5BdhGGMjJlVsszSM1rXV/wo+PTQN6M0fDHVGps8fRO4V4mtL
        YZ0j6AI0SAJmoBUK2QhX3ahWr9fktTF++g==
X-Google-Smtp-Source: APXvYqxpJzwQY1W+5OzNrWGPHFwanGpc9iyxy5h4ZG1ReOuhs92rTd3wcd0qNlIkDPCOqPX0RWf3ow==
X-Received: by 2002:a62:545:: with SMTP id 66mr57613475pff.1.1575047943516;
        Fri, 29 Nov 2019 09:19:03 -0800 (PST)
Received: from ?IPv6:2605:e000:100e:8c61:c457:26a3:bdc5:9aed? ([2605:e000:100e:8c61:c457:26a3:bdc5:9aed])
        by smtp.gmail.com with ESMTPSA id i26sm24679009pfr.151.2019.11.29.09.19.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2019 09:19:00 -0800 (PST)
Subject: Re: delete unneeded int-type
To:     liming wu <wu860403@gmail.com>, io-uring@vger.kernel.org
References: <CAPnMXWW=cV_H2xs=r21DOuhfKWcCaxgG2iXR9LaExuRMNGUvpA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2088a8ff-2550-260d-ff6f-938b27d15ef1@kernel.dk>
Date:   Fri, 29 Nov 2019 09:18:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <CAPnMXWW=cV_H2xs=r21DOuhfKWcCaxgG2iXR9LaExuRMNGUvpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/29/19 12:19 AM, liming wu wrote:
> Hi
> 
> It can't buid successfully except use c99.

Thanks, I'll apply this a bit sanitized.

-- 
Jens Axboe

