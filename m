Return-Path: <SRS0=yioi=ZS=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90241C432C0
	for <io-uring@archiver.kernel.org>; Tue, 26 Nov 2019 18:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 514B120727
	for <io-uring@archiver.kernel.org>; Tue, 26 Nov 2019 18:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UPVT1c6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbfKZSQc (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 26 Nov 2019 13:16:32 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:34616 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfKZSQc (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 26 Nov 2019 13:16:32 -0500
Received: by mail-pj1-f66.google.com with SMTP id bo14so8665195pjb.1
        for <io-uring@vger.kernel.org>; Tue, 26 Nov 2019 10:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k4vLQdKiPnyOOI9/oroqiBsvSTVqLXplMfUqWVd5olg=;
        b=UPVT1c6JkIyflCAz0dwKdlFTs58STc8DvtuYgru0/aooLAYPjYltVCwa7+faISdzrC
         X+Qsp2ViG6GX8ZCyhwmOIB+eFSSyQF3Jf9vTJtsxAzvoriZP82R0wWxT84OWZH/kdHWU
         TkkJ1LAzdulm8Hpg5+Y6A/Gu1oTRjldlhg8tkeVkwPFIE2JJBtGOg8SCGkvIJ7NKTjFv
         DyTWO4v0HS4eXtFSTaek79KBg27Pm+plJoOdasZSMrZc8yhFGpgrmAzzfeVpcaffHvSS
         O7uj77GvSRcrWa9JLxDd5Byt7aMwTCffcXC94NN0iApVz0GS1B2m71cYE1w4iAxUqhkt
         hjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k4vLQdKiPnyOOI9/oroqiBsvSTVqLXplMfUqWVd5olg=;
        b=ErEBb7mILB/UkZV8ZcbQ2YeCLq5w8xSvo+wfaavUf7WzaTLi8pObv1ru7Zok5/YwGV
         RfY2wJ97v5OTx8oYAzPpND4/Yfdeb3jhtVWo01NbtE2Xx/cteDRokkhmqzmx/NK6AmK2
         9apF0oTMR65eI+3zGQr8Kz4epZtmctKFq6CkyFR8J4A/CmnOxpmRb2/cQyJmW81kNIO6
         2sJ77R1OkItAGC2KyN+rVhBqzoRWbDDrR2ZoB1FvfYX53iuDfm5f9Eli4LgxgWGYY6zl
         cktTLoLsAisDma8ZlP7SihuGTa4cLo0sRM/E55XC1TuYzjMOlkoN4x9z1jXUrSOz82lM
         nyig==
X-Gm-Message-State: APjAAAV2B2nI8gsBzg9nBoofoYZue3igKSeH7arKHPkZMFZoYy0hQzYO
        rHglsCaaXgnv4mV+guPSCqxfxUxweSCMtg==
X-Google-Smtp-Source: APXvYqxIejWTuN+vTaqHjxhy0MoqDMP06bMrPShZtRHDXQPU8/d8C2HTIrLTaTrCMSHLaelOoG9gTw==
X-Received: by 2002:a17:90a:fc90:: with SMTP id ci16mr499825pjb.140.1574792190735;
        Tue, 26 Nov 2019 10:16:30 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id c17sm13306026pfo.42.2019.11.26.10.16.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Nov 2019 10:16:29 -0800 (PST)
Subject: Re: [PATCH] io_uring: use kzalloc instead of kcalloc for
 single-element allocations
To:     Jann Horn <jannh@google.com>
Cc:     io-uring@vger.kernel.org
References: <20191126163945.185849-1-jannh@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5eac85c3-4497-982f-0352-c06b47e49434@kernel.dk>
Date:   Tue, 26 Nov 2019 11:16:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191126163945.185849-1-jannh@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/26/19 9:39 AM, Jann Horn wrote:
> These allocations are single-element allocations, so don't use the array
> allocation wrapper for them.

Thanks, applied.

-- 
Jens Axboe

