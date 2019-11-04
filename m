Return-Path: <SRS0=koBJ=Y4=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE3ECA9EC9
	for <io-uring@archiver.kernel.org>; Mon,  4 Nov 2019 21:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADCFE20848
	for <io-uring@archiver.kernel.org>; Mon,  4 Nov 2019 21:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Pd2XPvo2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbfKDVpQ (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:45:16 -0500
Received: from mail-pg1-f180.google.com ([209.85.215.180]:34183 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbfKDVpQ (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 4 Nov 2019 16:45:16 -0500
Received: by mail-pg1-f180.google.com with SMTP id e4so12400723pgs.1
        for <io-uring@vger.kernel.org>; Mon, 04 Nov 2019 13:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qFoQlVXHSuwo1O595GnbOrAWWfl3AiwJfNlGA2xnpDU=;
        b=Pd2XPvo2LdN2+ZrZJPbB9k/ipdx/qmgVT+5NNHwi3/xMxLRZ3qKR+CtfkCNLALf4Mk
         sjJ5SFC5Ee9VAkoGNrsbKQx/M3mrlDR3vNcqG+M2rKhnbXV62Sla+QbO8o/MuNVNCqfi
         2c/StWnAGAODoW0ENmvDUjRM0g12sb9/7Cl/vlMD94z57rqKS4H8jdcW/LROEjjQmZK1
         0m4FoudksJ8pe607EuhApENwicD3OMKtfUPuxEHDQAcc3q/C8OcxhULJNaRIQ4nFwfaz
         5HJXPG9YGjdnjAaGvv6+OItHf8gdPUgfX3kEh81Bi4O30eoKkwbMcLjbMJf5Br1i6LXB
         YhpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qFoQlVXHSuwo1O595GnbOrAWWfl3AiwJfNlGA2xnpDU=;
        b=FHh1ypFoSVwfJdGviRMXqpvVsWaUupoYHAIe9tzqRYmOxhA8JwW7OaYJmIfinPySid
         I/MlszVGojC++1w965D0YY2qcqBQdpaWPpJWBcLUu4mRoaPlayP7WWOw4RQkAYNSUihU
         /vFj22woOZye0TJvRA7OSfNC7qFcc97ONDby/vHMwFS33ObWWS1DktXk/A3kVYeJ6ok4
         T3ZC6Ip/GoWuZPbk0Qy2pVU47J+EYbe/xq5voPIZ8xnZDdsKMidGVqsBkSA0ZHMlJuHh
         IEqqSGCn9nPFOrI338zVv+jF6guMgNL6bwokEwupoTk/1Bu3W8UexDOu3taPCRzMKb8o
         A7dA==
X-Gm-Message-State: APjAAAX+gjpokJl9374q1lNbEdQZ0VKy0CUlOS0XeaaFYv5LiTESUAu3
        A2oxxHKaLNYMoUPF9BDlTAjKkO7iJGMcPg==
X-Google-Smtp-Source: APXvYqw7H6jlLot0wQPPe3T/1iBYt63s2oPfMzl81x/NYFoXGMzQeU+sciQSpVyJ1VLBRMw1mIrBng==
X-Received: by 2002:a17:90a:ba17:: with SMTP id s23mr1734267pjr.78.1572903914619;
        Mon, 04 Nov 2019 13:45:14 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id i71sm19234586pfe.103.2019.11.04.13.45.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 13:45:13 -0800 (PST)
Subject: Re: This list is now archived on lore.kernel.org
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     io-uring@vger.kernel.org
References: <20191104212144.sszfmbbxdddxt765@chatter.i7.local>
 <0797e1e6-a1f8-53ae-0b58-e2d703bf2d54@kernel.dk>
 <20191104214302.3p6tood4gea7ssg3@chatter.i7.local>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <29504b7c-453a-8120-547c-5cd95f6c92d7@kernel.dk>
Date:   Mon, 4 Nov 2019 14:45:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191104214302.3p6tood4gea7ssg3@chatter.i7.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/4/19 2:43 PM, Konstantin Ryabitsev wrote:
> On Mon, Nov 04, 2019 at 02:40:24PM -0700, Jens Axboe wrote:
>>> This list is now archived on lore.kernel.org:
>>> https://lore.kernel.org/io-uring/
>>
>> Great, thanks! It's not on the index page yet, but I guess that
>> gets updated occasionally?
> 
> It is -- do a forced refresh.

Got it, must have been cached locally. I see it, thanks!

-- 
Jens Axboe

