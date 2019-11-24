Return-Path: <SRS0=S5qu=ZQ=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79A6C432C0
	for <io-uring@archiver.kernel.org>; Sun, 24 Nov 2019 16:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74FB82075E
	for <io-uring@archiver.kernel.org>; Sun, 24 Nov 2019 16:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="enuSZ23s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfKXQg7 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 24 Nov 2019 11:36:59 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37215 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfKXQg6 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 24 Nov 2019 11:36:58 -0500
Received: by mail-pg1-f194.google.com with SMTP id b10so5849333pgd.4
        for <io-uring@vger.kernel.org>; Sun, 24 Nov 2019 08:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=m8v9j9lNHoi5k8hju8UKFyjjRG5zgmr9d4CJnLXEFgc=;
        b=enuSZ23sVzhTIgKQ5JaW5kQp8/83+bDbczG7PeBxo5p263YKpdyyZTLHG/+N1Secax
         GF1rzXvtyYAEFdtqhqcHouMuSxrFUVIfR53PcbbuBqWOzSyApNXOjEfVv0sNUqnCzArX
         mijqdypIp/95zwRBe5zEOomvJsXKUQeb4bfPm35SYH4rnjk3JAOdyKsoSAP2HByb/dhk
         q4MR10k2D0FlBKA13LWmvE21+oDSumKQaMu5Ko30CK9r/KdZtZzHTu8aUt6+SsopTamq
         Qh17VB0lEG98yX7AnYuMZFMMugE2DvNxB6y7UJqszjtUlI74EQHgfWz2TKU3v84xyO4m
         qcsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m8v9j9lNHoi5k8hju8UKFyjjRG5zgmr9d4CJnLXEFgc=;
        b=eCqOK1pLzeVcxC1mVPNPvrmZL1d32KgZ8srtjENTD9Cf3/7PkGFAau04m8anDmwMPt
         9W9vmLQzVs/XETi+8ddI3uH8J+YaeByrvSvucDTgviOuJ6qwhl00B8d0V+Gk1gV7JuaT
         EMLphfBUhFPU5x4JzV8n3eFHLhLKMD9eOVO6Le4GU/zEmgny5bJJDcUoVwMJLKX1UdiY
         fvr/P/8C2M0ENNYvMOHlCzy9JecvNuErKxcHw+xbWTQc8yButL1iUD2CdOU7PBlPbQ9v
         e9YymGt+VCQr7jQVpZDuO0TUrrl9syTak0J0wuYCqGLVWfl5AJq+es1M/3TvPY9DPNFv
         mclw==
X-Gm-Message-State: APjAAAV9sZmfwyM2A1VdphXDiJV9w5GY3DizCMo2A29/hxzkN+fR9UoH
        UP1mhyCms+fTDfkztHo68E7Y42XXtigOBQ==
X-Google-Smtp-Source: APXvYqxNBKPBBJGaeqjILy8F8SDTpPwRgSaHUXRMBhmayIoMzvFixsNtJyZbdzUftQD9wvWcO4+x8g==
X-Received: by 2002:a62:108:: with SMTP id 8mr29855110pfb.53.1574613416086;
        Sun, 24 Nov 2019 08:36:56 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id v24sm5039634pfn.53.2019.11.24.08.36.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Nov 2019 08:36:54 -0800 (PST)
Subject: Re: [RFC 0/2] fix in-kernel segfault
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
References: <cover.1574549055.git.asml.silence@gmail.com>
 <fb952a30-3e42-fa81-f0ea-200b7acbf6a9@kernel.dk>
 <cb4c9440-a974-a8df-5eb1-5aa37ae2936c@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6f0420a6-18e6-a0df-ecc6-5b0576cdffcd@kernel.dk>
Date:   Sun, 24 Nov 2019 09:36:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <cb4c9440-a974-a8df-5eb1-5aa37ae2936c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/24/19 1:57 AM, Pavel Begunkov wrote:
> On 24/11/2019 02:08, Jens Axboe wrote:
>> On 11/23/19 3:49 PM, Pavel Begunkov wrote:
>>> There is a bug hunging my system when run fixed-link with /dev/urandom
>>> instead of /dev/zero (see patch 1/2).
>>>
>>> As for me, the easiest way to fix is to grab mm and use userspace
>>> address for this specific case (as it's done in patches). The other
>>> way is to kmap/vmap, but the first should be short-lived and the
>>> second needs mm anyway.
>>>
>>> Ideas how to do it better way? Suggestions and corrections are welcome.
>>
>> OK, took a quick look. kmap() etc doesn't need context, but the copy
> 
> Thanks! What copy do you mean? The first and pretty short version was
> with kmap.
> e.g. while(count) { read(kmap()); ...; knumap(); }
> 
> I'll send this shortly. What I don't like here, is that it passes
> kmapped virtual address as "void __user *". Is that ok?

I think that's OK, it is a user address, after all. Stripping the other
way is usually a bigger concern :-)

-- 
Jens Axboe

