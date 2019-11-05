Return-Path: <SRS0=KDoC=Y5=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5304C5DF60
	for <io-uring@archiver.kernel.org>; Tue,  5 Nov 2019 15:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6272087E
	for <io-uring@archiver.kernel.org>; Tue,  5 Nov 2019 15:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="DuFctzP3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfKEPfl (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 5 Nov 2019 10:35:41 -0500
Received: from mail-io1-f41.google.com ([209.85.166.41]:35959 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbfKEPfl (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 5 Nov 2019 10:35:41 -0500
Received: by mail-io1-f41.google.com with SMTP id s3so19275341ioe.3
        for <io-uring@vger.kernel.org>; Tue, 05 Nov 2019 07:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5T1Fjm5Ks1CsyYqkLdbyekSD5CmhScY/2CNezowtQGs=;
        b=DuFctzP3q7cMze+exwKbWIQMZ8uxQfP/kx7QSJOXQNxwydB4T+fMsTDq9GFIfslHc6
         nx74QQZi6nTfiEy1ebZhaMU0fdsfQ96eADnuqszlVizrTaus8mk/MEU9CySuUX7tKyqp
         FNNWwk3ivHrLJQpBGqAdWmVvN/O5htujtmkzyHdYSrrodElnSE5GS0T9zu7JUmR54O0n
         oYF5rX2zpqHzwc+bhiSr5j2qqluIn3Wmqg7TDtTmBHkc14gC26npkLaUwRvsg23z9LVt
         /uhqi//ACiai17xTu2ondADJxvzBckXhL7XiLNjAvS7jTB07WAc27zFejm0RTD5Uqjyv
         mTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5T1Fjm5Ks1CsyYqkLdbyekSD5CmhScY/2CNezowtQGs=;
        b=QUnld5dpdMOQEua4vCMjFVBhAr8Lm/rKtTQ7JfjtaymNOgL36G/IpQ4fKsgykSN8gd
         sF30YuHe1y7U3hGqiuYX5rVECf+pOlRJQizEdAGAqlOboGDpE4BZaAwhIjGE6d9se8RU
         2MCXJ9HRW0he9sw1yVVBWYF4ws/qI/U438bqaw1uD3s8/TgV755sDCLJzJqSYQ6N5NN2
         Jmrh5yii+87ajmwwUPmq8t5sPzHNL/cSST41qZn9RxidNnpHu3QlVpsIcdCEWQ7lI+xU
         80XWZl+8rxLZP6H0uYmNKWy7I98r/T2uvehZxsessFPcaO0hkeglap2KEuicqZEcycde
         +s3A==
X-Gm-Message-State: APjAAAVgrDULjXPkOZBiFOdkgKjPP4c+AXjVHarf+Hsaekgq6JVtV65X
        evCL4Z/eZlJnO6tfklnNYdcnRCv34hg=
X-Google-Smtp-Source: APXvYqy/d3JVL32UOZwTR/SrQ3KAE5//NuclKZ7ixyFX01Ej0hPIeiFP7Hj4UuSo5kJK3jr6jvGmlA==
X-Received: by 2002:a02:2b03:: with SMTP id h3mr2430989jaa.93.1572968139811;
        Tue, 05 Nov 2019 07:35:39 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a7sm676808ioc.67.2019.11.05.07.35.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 07:35:39 -0800 (PST)
Subject: Re: [liburing patch] barrier.h: add generic smp_mb implementation
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     io-uring@vger.kernel.org
References: <x49k18e9w3k.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3181b156-6d2c-0d6a-8e0f-a632c4800378@kernel.dk>
Date:   Tue, 5 Nov 2019 08:35:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <x49k18e9w3k.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/5/19 8:33 AM, Jeff Moyer wrote:
> This missing define causes build failures on s390:
> 
>    src/include/liburing.h:298: undefined reference to `io_uring_smp_mb'

Applied, thanks.

-- 
Jens Axboe

