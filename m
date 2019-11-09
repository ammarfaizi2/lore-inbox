Return-Path: <SRS0=jnAq=ZB=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A3CC43331
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 14:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA21E2196F
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 14:09:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="P3n9SXJQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfKIOJL (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 9 Nov 2019 09:09:11 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46450 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbfKIOJL (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 9 Nov 2019 09:09:11 -0500
Received: by mail-pf1-f195.google.com with SMTP id 193so7040479pfc.13
        for <io-uring@vger.kernel.org>; Sat, 09 Nov 2019 06:09:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QmkpvhtUjMqx/DQZkD4mGCBzEC2Yycy19201UJBqumQ=;
        b=P3n9SXJQLzhxPKaO/iWvzfHnBNrww2OOCUMZ8fme73+T6WcVB57e5TlHEvwrDuOE0w
         0SHajEross11Awv5ziqibEdTrCQPVQIuGL+jrtJ76ufaIKbzhlmVno6YAWMokNCpkaMT
         WuVDq3P90q7mmpVZYqmm2lORwdVuIuPnG2vq38tOMpFAfde1mRWuGOsxr39evXZbND4s
         UQGCvLLFe6oVfaoczWaEwreN8k+un7hQYtQBLoaR7c4mL2fG/EwGDAy/QnxuEDOL44tz
         Ju5pntZaA18tRB0Ezjh6ruuN71KIVKSKXUu75DWYtFzdvrcpTe/sQevez3wnYppfulOz
         IYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QmkpvhtUjMqx/DQZkD4mGCBzEC2Yycy19201UJBqumQ=;
        b=F6NgyLeIcpCVco6axS2ADIuNcPlTD63oT6P5OOWVfb8xa+hz/W13K1vWUssGZREqJ4
         y6EtQEPKV9266TFQNIAjSRG7ivZIcz2Z2PgNfLSgM0XokrbEYthuVd+o0iFl/KlMlodN
         uDJFUECf0IeW8jAC6NKYVDI2Z5mD5t5dyH81T4cWlg/Ak1h7jIOXwcCcNGEwrDtuFN6r
         BFjG2WFXS3dfhq6Ve/QOymElBM8kjNAA34ipISgE4H4XVKdliyeEUatvSQPhzp9fyvVO
         rnOdPcp6cV7zxXVbzRox+h5KMn5sHSZ3fFLSxekAe1bHp2EVRQdKKIiFCeuZrcVh/Sdp
         6Vfg==
X-Gm-Message-State: APjAAAV1pK09jVy+vn23uBnUq9OYkYZ+qgLJKsYF6TqYCu3CyA8NOCxU
        xUHfA3I6vZOqYxYuB6SpeUONadH88A8=
X-Google-Smtp-Source: APXvYqxbj+Oos2MRATBywMpWB3KLqmLvLUBhTRmZ4IPfsGrZIMh6muzCcjrA9e8RzwqRU89Gesbeww==
X-Received: by 2002:a17:90a:ec02:: with SMTP id l2mr21346174pjy.31.1573308548182;
        Sat, 09 Nov 2019 06:09:08 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id q26sm9487912pff.143.2019.11.09.06.09.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Nov 2019 06:09:07 -0800 (PST)
Subject: Re: [PATCH v2] liburing: Add regression test case for link with drain
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     io-uring@vger.kernel.org
References: <1573277816-3807-1-git-send-email-liuyun01@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <84b5f0d3-21f3-4cd0-8d91-a154ee54bdfe@kernel.dk>
Date:   Sat, 9 Nov 2019 07:09:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1573277816-3807-1-git-send-email-liuyun01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/8/19 10:36 PM, Jackie Liu wrote:
> Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
> ---
> V2:                                                                                                                                                                                                                                                                             - Fix loop iterators                                                                                                                                                                                                                                                           - close fd

I applied this as an incremental, as the other one was already applied
and pushed out.

-- 
Jens Axboe

