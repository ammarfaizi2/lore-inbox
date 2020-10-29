Return-Path: <SRS0=zNVv=EE=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BBEC55179
	for <io-uring@archiver.kernel.org>; Thu, 29 Oct 2020 01:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50A1A20790
	for <io-uring@archiver.kernel.org>; Thu, 29 Oct 2020 01:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="o31t2zCz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404168AbgJ2BHB (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 28 Oct 2020 21:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732198AbgJ2BG4 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 28 Oct 2020 21:06:56 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25210C0613CF
        for <io-uring@vger.kernel.org>; Wed, 28 Oct 2020 18:06:55 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x13so926675pfa.9
        for <io-uring@vger.kernel.org>; Wed, 28 Oct 2020 18:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Ui6yipPZ4DZJa2S02Xrc6rIEuGe7YB0GlazEZ2ZSRpc=;
        b=o31t2zCzyAbOv/bpZcPlhn4q/kPcJE0uINBWIoMfM+ezX7nRmv1J9OJURXYbogj40y
         h/7XzQqlNmIRYO//aFGLqiDLxgoHhBvHuhUT0cT3d/0CT+y4gXaS5TJ/k7lCYrUSr3W3
         Eql3boQryvwbidoXUjsxqzjiOuEhBhDMJWXuTPOb58//bYqJgR/dv09909rzA+/02gSn
         DQLVfc98UUDpVxl5AB/xn8bu7IK0iTWuatRStGpWkqG6b3QXMDDvdFyaDnEwfD05grbJ
         0uXfg8LqQkT399FW69PLSMXy7Wr2RwCqfhMIK+auGa7W99zj/8B6Iywhk2Lf8Ypy+4Qa
         8AVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ui6yipPZ4DZJa2S02Xrc6rIEuGe7YB0GlazEZ2ZSRpc=;
        b=KAt4nbn7iCQzL+PgGHYXzoec2ruGSrz42Qn3GCH8bMu1HazpzFgcH5vsH7SBDRq2t+
         x1XNnw2mrcHywR9YBvFpIt4NlsFv/g/rrVSsLRdDtv9jZAh/DaFaNEZMlcmJUAtnC2Nr
         tL7Y/yFI7egmK4HkHaDNXl/27R0VwrHoxXhgmWRCfsTlB/Wl/Esqf1xuljqlIM+USuPV
         6AWmMBfXNmROUFfeZohbbGQPbiB3m+JUYJ6zIis3m9/B2q4jzpe9/98+YSwXg3njSZOn
         QPRtSBmfxleabN3KmBN6W+Hq1RRHdG4IPqk6vC0lkjJIw08MJLbZgGIkZ/nJrA5aITja
         3TAA==
X-Gm-Message-State: AOAM533A+8RWuzcSxlDy6JiR8VUSP1/zyvkOHw26UqmymM8IF7PHRRI7
        NJAFfENe98wa4x0F9i5bMpJzX21xuwpCbQ==
X-Google-Smtp-Source: ABdhPJzgTz2y/MxOxyS9OxfKEcYMFB95hNsThWKp148Bd1KLFmPe915OXNFV6rQ+6I0m2YOGoehV2w==
X-Received: by 2002:aa7:96f6:0:b029:164:2def:5ef7 with SMTP id i22-20020aa796f60000b02901642def5ef7mr1653817pfq.44.1603933614500;
        Wed, 28 Oct 2020 18:06:54 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id y124sm815364pfy.28.2020.10.28.18.06.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 18:06:53 -0700 (PDT)
Subject: Re: [PATCH] examples: disable ucontext-cp if ucontext.h is not
 available
To:     Simon Zeni <simon@bl4ckb0ne.ca>, io-uring@vger.kernel.org
References: <C6OYQ7AU7G3Z.2XB9LZ8CPC23V@gengar>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f728786a-cd29-9ea5-68e9-eb2a2df6ecdc@kernel.dk>
Date:   Wed, 28 Oct 2020 19:06:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <C6OYQ7AU7G3Z.2XB9LZ8CPC23V@gengar>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 10/28/20 6:53 PM, Simon Zeni wrote:
> On Wed Oct 28, 2020 at 12:33 PM EDT, Jens Axboe wrote:
>> It's been a while since I double checked 5.4-stable, I bet a lot of
>> these
>> are due to the tests not being very diligent in checking what is and
>> what
>> isn't supported. I'll take a look and rectify some of that.
> 
> I tried with 5.9.1 and fewer tests failed.
> 
> ```
> Tests failed:  <defer> <double-poll-crash> <file-register>
> <io_uring_enter> <io_uring_register> <iopoll> <poll-cancel-ton>
> <read-write> <rename> <sq-poll-dup> <sq-poll-share> <unlink>
> ```
> 
> It might be due to musl, I'll as I use the library and send the
> necessary patches if needed.

The log for those would be interesting. rename/unlink is probably
me messing up on skipping on not-supported, sq-poll-* ditto. The
others, not sure - if you fail with -1/-12, probably just missing
capability checks.

-- 
Jens Axboe

