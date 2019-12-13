Return-Path: <SRS0=bCXC=2D=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03591C7E0A2
	for <io-uring@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D52324790
	for <io-uring@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="DZbJg3jD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbfLMSll (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 13 Dec 2019 13:41:41 -0500
Received: from mail-io1-f52.google.com ([209.85.166.52]:37583 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbfLMSll (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 13 Dec 2019 13:41:41 -0500
Received: by mail-io1-f52.google.com with SMTP id k24so670873ioc.4
        for <io-uring@vger.kernel.org>; Fri, 13 Dec 2019 10:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=yd5A7ma8jHxTuZcHgFtZXqeJ8DP4wuiJ8ADgctoYPMo=;
        b=DZbJg3jD5pZD5t9zzFulKMq9+S4JOXB/LXmwhAg9206kVbdLF0zj3Pjt0IaYq33O44
         +NdEUMIt9QoxibkSFMqOJm6WblvgS472iXraOc++wfR1Kdpil3pdqzGw0adOjCxLh5Am
         ULOffSdRi7cXx1Rmv93ZCkuet2h4RuHEoLFowVdpYsFq6Wch7UWfiPDufaZfH0cRlUGL
         JnrBW7nscCYkFhApA9V6vn2kzuJpvHSRRkw6aGtsKIl0NkXKzUbMlhveZkbk9u1UQrRr
         koFnpRX7++9MvKnYld2reE8TJ0PrQowGkGlqZMj0fQ2gDuY5dbD7vDGBuKiHdT7Veer2
         sVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yd5A7ma8jHxTuZcHgFtZXqeJ8DP4wuiJ8ADgctoYPMo=;
        b=XLJdBT0OKyvOppnp6MPCYwMEra4ffNBph4B53t9qm1ZMS8OQBJKpy4dh0z6/y9hXuu
         +lpN3cw1HPKGhcgQ8QZ5tOzpXT7XAMxSp/z2ZHAzZH68034lNq3IH+lWK1PbqJsR6tEC
         kotRMzl4KpjCeYSswTbg6SsnsGVq811hVaX4wCa9K6p29lRau8N1IysfPnqebZgsbc1Z
         +gR1E86WKGIhudktPVRV+NM3EZlbE0/zZJs4qGUFM0WDvWdx2aGMw0JlfTGIJ+JDaoTE
         C8kdMSo2myFhlnyZ+mkxwB8admY7R7TpiR6iw1Nwt9koqzUetRHJs48g0piJyqAm7pn8
         wBdw==
X-Gm-Message-State: APjAAAVav1f1AZUCH5vrmU8uY881UxB9UayNzIGQa4+cl6p3Xmq5j7Vt
        VEu5Ol5ZoNsVY37EeA22G7b710KzPJLi8w==
X-Google-Smtp-Source: APXvYqwiDB+1bQ5bT1MfUZBSdIHg3ryJ47xkyuSPzD6u2tP0P/3N99wdYtImNvMSFdyJrpYa4VavIQ==
X-Received: by 2002:a02:cc75:: with SMTP id j21mr743891jaq.113.1576262500894;
        Fri, 13 Dec 2019 10:41:40 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k6sm2234070iom.52.2019.12.13.10.41.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2019 10:41:40 -0800 (PST)
Subject: Re: [PATCH v2 liburing] Test wait after under-consuming
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <e5579bbac4fcb4f0e9b6ba4fbf3a56bd9a925c6c.1576224356.git.asml.silence@gmail.com>
 <512741aa9160cc9648780a21a4bf4aa10a47193f.1576256964.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3b6a6e8f-ca6b-ea3d-5530-bfe2eab99400@kernel.dk>
Date:   Fri, 13 Dec 2019 11:41:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <512741aa9160cc9648780a21a4bf4aa10a47193f.1576256964.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 12/13/19 10:11 AM, Pavel Begunkov wrote:
> In case of an error submission won't consume all sqes. This tests that
> it will get back to the userspace even if (to_submit == to_wait)

Applied, thanks.

-- 
Jens Axboe

