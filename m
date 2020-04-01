Return-Path: <SRS0=hkMi=5R=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3561FC18E5B
	for <io-uring@archiver.kernel.org>; Wed,  1 Apr 2020 13:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BD632073B
	for <io-uring@archiver.kernel.org>; Wed,  1 Apr 2020 13:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tov01zkT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732697AbgDANE0 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 1 Apr 2020 09:04:26 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:33611 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732514AbgDANEZ (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 1 Apr 2020 09:04:25 -0400
Received: by mail-pl1-f172.google.com with SMTP id g18so9617801plq.0
        for <io-uring@vger.kernel.org>; Wed, 01 Apr 2020 06:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B0LpzoKBtxdE1EIqwH+WF8IajwEfMlbTxCiToqeJLDs=;
        b=tov01zkTfCr9FMYEJul4OL8VaNLUaBlzf/RcwE0BPr2KU1CVsxY6RKar2CCpfgzTCM
         bL9ic0N5EYKLR2EUA2uhbzznwmB6ZQNSDc487iEJ3f1pc+R0AmCmHejAU3uKXB/+TjX3
         q+9eTf2Byp6cfKtxIeiVEK1z7UkE1TiLx4crWq1UCQd7pDSO3MDV8xopar00us5oFJPR
         0lgDS1sUEQysL/u6G1lj+LuJeI2a7cHDmrMcxXvxCkgwf9RRTWrz86qZmEnkQe5qsPCx
         4y2OHPd7uGJ3g0p96CA2spRQoymHtZ3+Q/aC9hvRQm8xMLp2ZZIOKk7EaZQwlePp/ofM
         zn0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B0LpzoKBtxdE1EIqwH+WF8IajwEfMlbTxCiToqeJLDs=;
        b=R6bBTS83gV3585mn3jVECAqf/5zmWO4bowd0afkjXwFBf3hURtYVxM+PbxUJqJ9L4k
         8mQZGYqdQXxwJnlppYaqHAyHjwpiZOpJp3965pE/WVHBQ+OjMrMGRVLcv1DYon0zrPhX
         3IxEUDpwSFmHmyYVHQhY+5a5Pf+r54undB6hobEB14k9zav9mHT0Vl6aM08+A2Qo/j1q
         41UGoafAR87XExfDswuEyLedJmblu43/4RHf/PG4HPdia+Xazd0rIokDk3Z7egumMwUL
         fl/M8Xq7WLOEoh1/GP0UMNJLAxNhO/By/FrHek2NQSJU4CZUVsI19xvYjVO6SFVE+0nn
         kOlw==
X-Gm-Message-State: AGi0PuaLmGgBrfqAs432ti+wxmfBEwNZvbMTpPG4jgTRZu7KPfalb7Iq
        LWeg/K8yw6o2Nnpc5cdfC8Su7A==
X-Google-Smtp-Source: APiQypILcnoRSadC9assugQKxNMol2Dzlqx/Bor8ULFQrBWMqeL0mRPSNW/G6wO6FnHSJSkXW7vPXw==
X-Received: by 2002:a17:90a:8a17:: with SMTP id w23mr4541353pjn.94.1585746262705;
        Wed, 01 Apr 2020 06:04:22 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id kb18sm1810284pjb.14.2020.04.01.06.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 06:04:21 -0700 (PDT)
Subject: Re: [PATCH] io_uring: add missing finish_wait() in io_sq_thread()
To:     Hillf Danton <hdanton@sina.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        io-uring <io-uring@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200401091933.17536-1-hdanton@sina.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a2097c01-4f55-90f8-9ae5-60aaa6623964@kernel.dk>
Date:   Wed, 1 Apr 2020 07:04:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200401091933.17536-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 4/1/20 3:19 AM, Hillf Danton wrote:
> 
> Add it to pair with prepare_to_wait() in an attempt to avoid
> anything weird in the field.

Applied, thanks.

-- 
Jens Axboe

