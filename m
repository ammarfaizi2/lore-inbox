Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65E7C433E0
	for <io-uring@archiver.kernel.org>; Mon,  4 Jan 2021 23:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93A9A20789
	for <io-uring@archiver.kernel.org>; Mon,  4 Jan 2021 23:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbhADXXa (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 4 Jan 2021 18:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbhADXX3 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 4 Jan 2021 18:23:29 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F266C061794
        for <io-uring@vger.kernel.org>; Mon,  4 Jan 2021 15:22:49 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id d23so6572070vkf.3
        for <io-uring@vger.kernel.org>; Mon, 04 Jan 2021 15:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=dJuUCzUUReHNuZYM4TZaZOPOZNY2BFT+LmDzgf70pmM=;
        b=KWwFkdqub3wUKKs8worIr8dWcOKOKEylqWGKQEubxphqHfa8+c/8G5x+jHFUhH4QcI
         Vhnbrj/rO66ubyUwb42ZLu2EeJcVG42Wzc9GAUjZ6PfXq3E3hG2VjlLy3su3fHn+NxFX
         yrImUDrSGf6kHM/wVTuPrS6cR09YNfQ5wRgFm2ZPA7tTrJwoPX3v+kdLaw1EC3twaaCD
         rgj39SK+wxkkrcIjKVdir5IeAEvbmHjX6Yi1wjWH9jFgmQTt/pp/oCMmjG/rjQmd14RU
         ryJNFuWF0Xiu5wgvVgbpXhhFNZS9NMd27OMueDiv1UdDgHFCzj7LGdv8JmJtWZ4z14Po
         /YvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dJuUCzUUReHNuZYM4TZaZOPOZNY2BFT+LmDzgf70pmM=;
        b=nc9f01Wpi3dLZtDbUaZd/WU15YpTpp6nkSctEj7/I2ENZnmR8IKkfQ8kxTETOkVWbA
         VQ0VpUJ8a/VFyEl8ABJHGmiyNzwafoKK5Z1TUaKWOsZI8s2A9e0Q0cCaq6TdAWg+XHxL
         d4r/MKf1G1OS6Xx1cLgzvahfM6K3qvpBLO192Zmuogs+tojN0oPxveg537u9BDKbK2YY
         4D3MMq8VbhzOKrMOcMPVsh3i7xr7ufGw5BiqO86yBakz7IgKAHo9DXVVzJLKIKzDbvmp
         5Uvq+iNBNn19iESv/Gcd2Ap7ZZ6M8+glCgEVI9ql7TPlmbai1L4Kem+yLTujdIcyLow1
         yDvA==
X-Gm-Message-State: AOAM530yAJyy0BhLpHPw0igxX3JlMtU0UTakIrllV93PkPYsAn89Ytm9
        pxGBVo0uDZmsnAY8SBTnR4mc0NvJQr4RQQ==
X-Google-Smtp-Source: ABdhPJwIsYh1QEa2XheCaaaILitz0TsNfDw68zHWwNjxzKWz1dmv4T2IdXUlTUnEBWf9IHX000TEAQ==
X-Received: by 2002:a05:6a00:230d:b029:18b:9cb:dead with SMTP id h13-20020a056a00230db029018b09cbdeadmr66579594pfh.24.1609798989329;
        Mon, 04 Jan 2021 14:23:09 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id t5sm344104pjr.22.2021.01.04.14.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 14:23:08 -0800 (PST)
Subject: Re: [PATCH 0/2] cancellation fixes
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
References: <cover.1609792653.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <844bbb44-5cfd-c61f-1d20-3e5bb678620f@kernel.dk>
Date:   Mon, 4 Jan 2021 15:23:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cover.1609792653.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 1/4/21 1:43 PM, Pavel Begunkov wrote:
> [previously a part of "bunch of random fixes"]
> haven't changed since then
> 
> Pavel Begunkov (2):
>   io_uring: drop file refs after task cancel
>   io_uring: cancel more aggressively in exit_work
> 
>  fs/io_uring.c | 38 +++++++++++++++++++++++++-------------
>  1 file changed, 25 insertions(+), 13 deletions(-)

Applied, thanks.

-- 
Jens Axboe

