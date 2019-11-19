Return-Path: <SRS0=5OhC=ZL=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC628C432C0
	for <io-uring@archiver.kernel.org>; Tue, 19 Nov 2019 22:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D0F92245D
	for <io-uring@archiver.kernel.org>; Tue, 19 Nov 2019 22:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="MKtvtqMx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfKSWLC (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 19 Nov 2019 17:11:02 -0500
Received: from mail-pl1-f182.google.com ([209.85.214.182]:42494 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfKSWLC (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 19 Nov 2019 17:11:02 -0500
Received: by mail-pl1-f182.google.com with SMTP id j12so12678167plt.9
        for <io-uring@vger.kernel.org>; Tue, 19 Nov 2019 14:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=zAwQGd4NdZXLnuKmqDTYF879azVRTgJQfofXqFfH3dI=;
        b=MKtvtqMxvWboo3xy97pL2SCK3IPrwVYvGW9RmAlpvusRmzoM5hH3gcixuZY8BPb+5X
         xjGf9sG+104ruZftdYhMT4H3iWQDE/b+EdVRpQL/7VnIXamfcQ6kCm/pu5VanLPuZ2uy
         MCgsrHUz9LxfdK4UItEnqgsxJTKcgQuD1+mBqhiTuAiZv5YfAXA1ddtglmi8uIV+lIll
         vxDTy7I7zrjbE2HEky8bdnSEweb4+soCZ4utve9Jee8owHisltjLAijW+0kzIjH2TioS
         GN5frmtuaShc2V/V2WG2c8iUKTtZcMx6HhHMwnYPku3Kq3MH4b5ikbo/TYRUxWc8JxN6
         M5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zAwQGd4NdZXLnuKmqDTYF879azVRTgJQfofXqFfH3dI=;
        b=ZecEhgLpIChBKH7FRPxfgH4+Sbecr31p1gwTG26SqOurQTOBKVHvEMDvxyvhUu0OwZ
         kCnRM8LXv+8e6T59lNlAecsR8bAWUL65Qt1CFVj4NVCpR3X7aLnO/PUVcFlNUWVRIZGa
         pBlFf4sIDJrcjufHnNIJDlJQ2RK7DuJpL8q+I1k76lcpjXyX4aaP7ueKJlrf1K6R3864
         9+2XFluG8MMqDVdLKWYfevZJz7U29a2f4hFXYjeF88GHsG386Bvpy8GXbUvzceodgLO/
         M2y7Mrcw/Vzo3qszN9moOxxtHxLPOBIIxUx70MvWUCendf4jdHYSoJ+93qcxMokiUAZ7
         Kqfg==
X-Gm-Message-State: APjAAAWPeb3H3/MuI44u/enninppMoyVb2gEqkYLoLi/VGqczbYjzPFW
        Sz+XgfLxY3iltk6mg+51uTX0rNOhJbo=
X-Google-Smtp-Source: APXvYqxNUamLppBl3+qrI39YWM4DnQJUvvN8S1r29KzUrQcpb9wdhiT/g+Q4vQpo4OPccFiGo15BJQ==
X-Received: by 2002:a17:902:126:: with SMTP id 35mr37991845plb.105.1574201459272;
        Tue, 19 Nov 2019 14:10:59 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id q20sm25380411pff.134.2019.11.19.14.10.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 14:10:58 -0800 (PST)
Subject: Re: [PATCHSET 0/4][io_uring-post] cleanup after linked timeouts
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
References: <cover.1574195129.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <281efa7c-3c22-441c-0f5a-fc5a6876c9a6@kernel.dk>
Date:   Tue, 19 Nov 2019 15:10:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <cover.1574195129.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/19/19 1:32 PM, Pavel Begunkov wrote:
> The second fixes mild misbehaving for a very rare case.
> The last one fixes a nasty bug, which leaks request with a uring
> reference, so hunging a process.
> 
> Pavel Begunkov (4):
>    io_uring: Always REQ_F_FREE_SQE for allocated sqe
>    io_uring: break links for failed defer
>    io_uring: remove redundant check
>    io_uring: Fix leaking linked timeouts
> 
>   fs/io_uring.c | 58 ++++++++++++++++++++++++---------------------------
>   1 file changed, 27 insertions(+), 31 deletions(-)

Thanks, added 2-4 for now.

-- 
Jens Axboe

