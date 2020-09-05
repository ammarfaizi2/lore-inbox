Return-Path: <SRS0=YIAO=CO=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE514C433E2
	for <io-uring@archiver.kernel.org>; Sat,  5 Sep 2020 22:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77F5C2083B
	for <io-uring@archiver.kernel.org>; Sat,  5 Sep 2020 22:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xa8YWu7c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgIEWDs (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 5 Sep 2020 18:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728327AbgIEWDr (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 5 Sep 2020 18:03:47 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49620C061244
        for <io-uring@vger.kernel.org>; Sat,  5 Sep 2020 15:03:47 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bh1so2722933plb.12
        for <io-uring@vger.kernel.org>; Sat, 05 Sep 2020 15:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=sKj1h3enbRGZhvNgmjel4SFvSHaP9qeihsPeH+IU8mY=;
        b=xa8YWu7cr/yw4+LjzKp4BlFvmeLI0Kp/4F0VtF1xgKlxOyLVHtSTC9Y73mKVjNLGaU
         xVuUSs07rFbFBjA54natsdzXZVC4jET5uuxhy9WE1iTBaBhX8og8/nlLAO41FWc6KuhF
         luPMctMHHG5mKHKlaFAeaJhYH7nk/0TCpKloDxgBBDxNFCcMmv1mlkX+EQhDHhVg05Xj
         LWgqtO4ufTGvRD09AEDeNRdiT2IQpYvCDSeo+iJMdMHiv2XUDFgevYF/2UvftjEkN6iW
         YO+XVJyYI7fjJLa33FA2VNZ4V/X694K1lJVG0nmXCzP7nFD7ExQ/qTlGuVbj3DtiU6RZ
         oYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sKj1h3enbRGZhvNgmjel4SFvSHaP9qeihsPeH+IU8mY=;
        b=WMER3hkbq4nHpbbCRbVT/x/rCXHz0ZeUDz/szM7eeWAjS642YXtzlSQw8rH2+dmBFe
         zpJLvLL68QRroAONwXY5ecmHC68VinMJEZT0A0DWahoxX9mfCsW92kie8pxx3sl1opkH
         Vhf4MxyXeNUd15I4l5vp9yEzDiqZTSn+uDHCDGVGrvXfHfdc/Pw2lRXFfr70SqYahtwz
         J84xZWtCqEEfHH1aZT727MbauHrIYCORAFwTdXq6vBeoo2xrK6taVXastPaLc+qBXBZJ
         beWi8HzExQ0lITfB4CLPzmAZYreDNj9COIJ76bkDXCsshhRbD6e5kdQr+mUbBsGStUS4
         S5xA==
X-Gm-Message-State: AOAM5333Yyit5dPPGpXiq1CXRHUMPZUel/5evJ3/exkWCgywIGJU4avO
        yn/Hp31tZD1V4cUVNOHQJVgXe+fWrQyRLgwA
X-Google-Smtp-Source: ABdhPJxJnd7bnixXEnUxllD0VLWelNcwTribxFZmk+GTA3l4y33LtnTuTZSaFYUBk4x4wJpEjQH4CQ==
X-Received: by 2002:a17:90b:796:: with SMTP id l22mr13974663pjz.199.1599343426394;
        Sat, 05 Sep 2020 15:03:46 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id n2sm4679831pja.41.2020.09.05.15.03.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2020 15:03:45 -0700 (PDT)
Subject: Re: [PATCH for-5.9 0/2] fix deferred ->files cancel
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
References: <cover.1599340635.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <16ed92ae-d60b-0c04-242a-21b033333194@kernel.dk>
Date:   Sat, 5 Sep 2020 16:03:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cover.1599340635.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 9/5/20 3:45 PM, Pavel Begunkov wrote:
> io_uring_cancel_files() may hangs because it can't find requests with
>  ->files in defer_list.

Thanks! Applied with a few style changes.

-- 
Jens Axboe

