Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A05C47082
	for <io-uring@archiver.kernel.org>; Wed, 26 May 2021 16:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2CFA613CE
	for <io-uring@archiver.kernel.org>; Wed, 26 May 2021 16:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbhEZQen (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 26 May 2021 12:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbhEZQen (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 26 May 2021 12:34:43 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2187C061574;
        Wed, 26 May 2021 09:33:10 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id s5-20020a7bc0c50000b0290147d0c21c51so871157wmh.4;
        Wed, 26 May 2021 09:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TeMQf0+FO4ym4hfoS0vMKgOKCQ0f25mg9GpSl0nXAx4=;
        b=NdfZIzmtg8AV9+i2/ZJK84FGl8KxAq0sI1zLGz+4QEDHdH/oXgYZT++64Yd8rp3o+d
         VwUOfzwurhFS0+d1ch1f+ywU6E2R4RUXYRiiVHNc7VojKfFK2y3L1Du4YFQ5OwkxiRf+
         4pfyiBuVLY+iqWEJLFa5OHhCv6AaXqdOUsPtf9IMRasoSR5KIBu0wAW9zUe0a+6IjCq5
         AV8o6OlOWYV/UHXWqZGtROmSMaGf3HReLO6788GyMaREGx3BOjU+UpqpjGIrTIU6pSUs
         FPinedH1n7Y2yCToiSO5qn2w5JryTquq14oSvc/fFY6JLhflG/dHotyQWzpLhAFe2rlm
         Ocmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TeMQf0+FO4ym4hfoS0vMKgOKCQ0f25mg9GpSl0nXAx4=;
        b=VzkAmoucHbigO8YnTw9auC5d3fd2vV9QQkSXwqixy/b0QJ+0icD5vBY4wTfzrK8+81
         6KN0b7E+pf6RYGbEvIz7sPh47TZLOigrEiDHsYmIV2sUNaXsXUKNIUtqx5h0Q1/NAp6t
         ayo6jyoiKe3T/gD/49FTMvSjFge/AngfAVQw1yz/X2GZVWADPfPgigUlwTZSzOfdJUjs
         x1YC/5vjo4zRjCr1GNinMT/vY/GxjE+YLwKX+OSfdFB6/wysywx1TSHwbXEN4Ru0Qd0M
         OOw7rMIL7WO9L6LopCgMGOzisLv0JWxT1Q37ty0CmJ/VpWfoZ7u3h96YrN7zwFUw87HZ
         mzQQ==
X-Gm-Message-State: AOAM533801VnEPpytjIrFxluMHm+q72aS4+/LlQlH/iW239UZim8wkQh
        Pli3nes31D+g+wbRnCQ+/Ps=
X-Google-Smtp-Source: ABdhPJzH1UUmSHD3autQYEOj6mow+MtyrkyCZhDR0bW/18RPdCcwOCe89bcJO50YxIDQ6JflKGuj+g==
X-Received: by 2002:a7b:c770:: with SMTP id x16mr3522670wmk.126.1622046789472;
        Wed, 26 May 2021 09:33:09 -0700 (PDT)
Received: from [192.168.8.197] ([85.255.236.10])
        by smtp.gmail.com with ESMTPSA id s2sm5661727wmc.21.2021.05.26.09.33.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 09:33:09 -0700 (PDT)
Subject: Re: [syzbot] KCSAN: data-race in __io_uring_cancel /
 io_uring_try_cancel_requests
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Marco Elver <elver@google.com>, axboe@kernel.dk
Cc:     syzbot <syzbot+73554e2258b7b8bf0bbf@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, dvyukov@google.com
References: <000000000000fa9f7005c33d83b9@google.com>
 <YK5tyZNAFc8dh6ke@elver.google.com> <YK5uygiCGlmgQLKE@elver.google.com>
 <b5cff8b6-bd9c-9cbe-4f5f-52552d19ca48@gmail.com>
Message-ID: <0b33f17e-9105-aad0-5d32-c3ed54a00da4@gmail.com>
Date:   Wed, 26 May 2021 17:33:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <b5cff8b6-bd9c-9cbe-4f5f-52552d19ca48@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 5/26/21 5:29 PM, Pavel Begunkov wrote:
> On 5/26/21 4:52 PM, Marco Elver wrote:
>> Due to some moving around of code, the patch lost the actual fix (using
>> atomically read io_wq) -- so here it is again ... hopefully as intended.
>> :-)
> 
> "fortify" damn it...

fwiw, it's a reference to my own commit that came after -rc

-- 
Pavel Begunkov
