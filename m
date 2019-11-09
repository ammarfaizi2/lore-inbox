Return-Path: <SRS0=jnAq=ZB=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF91FC43331
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 21:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900E521848
	for <io-uring@archiver.kernel.org>; Sat,  9 Nov 2019 21:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vXSLnhQu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfKIU7W (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 9 Nov 2019 15:59:22 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46668 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfKIU7V (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 9 Nov 2019 15:59:21 -0500
Received: by mail-pg1-f194.google.com with SMTP id r18so6373721pgu.13
        for <io-uring@vger.kernel.org>; Sat, 09 Nov 2019 12:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=OxHZhmijlMPEAIq9NRnLzVmCf74UApunA/OypB05+MQ=;
        b=vXSLnhQujk6JsRrTNa8P1/3SEJBem/WR2q74i2v9VjTQ5wwAItT5jvCIWKECfz+W13
         HdtNUmVvwqtrEp3Fm651EKoG8zT8bwexymIRSrF3pMi10KP2SXr4IhlQOWdWke208Of+
         wxpU28Zs5pNLXsZjXBEiOqU0+kpFMJDOapfInbZt6PCWbEF0S8EPpKg6KWk01CWLbcxe
         bOMRn4r6Dwc6B2xsjqSyaWoMoSimfWDQjwk3iWrNBmiYQuGfb8uULABjX0C8cn60SwSR
         oeEVcT34GoxlBubEMIn8M1wFs4St2Qxl3yqLZA+NftE62sPw5DvdDaAZXseIBMVgaDN+
         ca0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OxHZhmijlMPEAIq9NRnLzVmCf74UApunA/OypB05+MQ=;
        b=qlm4Z841QW4ez/7QYCYe5tfWwOTbWCCPa/iLw4Y/0oTeJ3QRupnF4gcrIsWkDHb8Pe
         +8npg8F55O2r6q1PjT2nQg5bNRdP92U5PCkpSKxexR3cRvY8QmfHhO0ptcYmxiFqC+e8
         P3Zz1svulUi0c52QfoGOTQ3e2uKykyVzEujVnxgmDUeBRf3zFyxdlWZOIXm71Dc2c3UB
         AwGFvfGRSBLRO753mRX/6BYCmWd6LewWW2nW+2hpvOQpzyXUYmHDspSdwFa/jeV6rCxi
         TxbEsiSgyai38/5ypPpkowdVhhxjPRDihpOJv0601GhvO+606FBZ8jBWWR+6Ye+CpOeP
         R6VQ==
X-Gm-Message-State: APjAAAU3a0QZcvH9W2sT/OGXD4Y0JDIkCjPDKUh1uTeURPGz1ySl4KTg
        tPqkAPWDwE/5ESTk3YTQDlXwVcKr9fQ=
X-Google-Smtp-Source: APXvYqzeVlmTEMEPvlKiOGUAIIEElBi0bbCvWK/cIBjg/2OHtQIVBbCdmLYkD1LvojO0V5EEgTOjKw==
X-Received: by 2002:a62:5216:: with SMTP id g22mr20052114pfb.78.1573333158914;
        Sat, 09 Nov 2019 12:59:18 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id y36sm9349173pgk.66.2019.11.09.12.59.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Nov 2019 12:59:17 -0800 (PST)
Subject: Re: [PATCH v3] io_uring: limit inflight IO
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
References: <ecf5959a-9853-5526-9764-ac273649a5f4@kernel.dk>
 <8d4610ab-48b0-8f55-27f0-ca760ff5be5f@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bb0216c2-7fb9-2243-fb10-f34a2b1892ad@kernel.dk>
Date:   Sat, 9 Nov 2019 13:59:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <8d4610ab-48b0-8f55-27f0-ca760ff5be5f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/9/19 12:16 PM, Pavel Begunkov wrote:
>> @@ -2992,6 +2992,30 @@ static bool io_get_sqring(struct io_ring_ctx *ctx, struct sqe_submit *s)
>>   	return false;
>>   }
>>   
>> +static bool io_sq_over_limit(struct io_ring_ctx *ctx, unsigned to_submit)
>> +{
>> +	unsigned inflight;
>> +
>> +	if ((ctx->flags & IORING_SETUP_CQ_NODROP) &&
>> +	    !list_empty(&ctx->cq_overflow_list))
>> +		return true;
>> +
>> +	/*
>> +	 * This doesn't need to be super precise, so only check every once
>> +	 * in a while.
>> +	 */
>> +	if ((ctx->cached_sq_head & ctx->sq_mask) !=
>> +	    ((ctx->cached_sq_head + to_submit) & ctx->sq_mask))
>> +		return false;
> 
> ctx->sq_mask = sq_entries - 1, e.g. 0x0000...ffff.
> Thus the code above is modular arithmetic (% sq_entries) and
> equivalent to:
> 
> if (to_submit != sq_entries)
> 	return false;
>   
> I suggest, the intention was:
> 
> if ((sq_head & ~mask) == ((sq_head + to_submit) & ~mask))
> 	return false;

Hah indeed, that was pretty silly. Fixed.

-- 
Jens Axboe

