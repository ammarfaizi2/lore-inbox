Return-Path: <SRS0=ex/T=ZC=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE591C17443
	for <io-uring@archiver.kernel.org>; Sun, 10 Nov 2019 15:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B061220869
	for <io-uring@archiver.kernel.org>; Sun, 10 Nov 2019 15:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="IXSYuL5Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfKJPWW (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 10 Nov 2019 10:22:22 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45883 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfKJPWW (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 10 Nov 2019 10:22:22 -0500
Received: by mail-pg1-f196.google.com with SMTP id w11so7503681pga.12
        for <io-uring@vger.kernel.org>; Sun, 10 Nov 2019 07:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=rbu9WW/S2zesXwUr08IfppzYLLSHptHN+GjBPeGUfVU=;
        b=IXSYuL5ZgzbMIowr/VfWiUHh67+3MKUKybGO7xME2/NWC4z52zKwmeDRmEspzu8TtM
         aWeoCp6AOtQNDLy3GiOXDXem3dokahQoW7umf1ibldovvq89TlJ6yEt4r7lcTCsFrUI5
         w4sduVc1g+CQdPnMFlCfU03xRV0pRIBeC9GQHDWKMXraO23aO/hkcirk8hLhEAhaK4zK
         QS286ARDxMxs2PuaYWhq5wM1uwfMnqs5b436+fNaa3mTRvu173WkcpSh3fLx83JOMc2w
         Tpn+lekmwl94YVtMH9tuBoJQ+wOqTksn21XG4mjw++0iXaq9icnQOko9RjO2Jf3nYowg
         eX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rbu9WW/S2zesXwUr08IfppzYLLSHptHN+GjBPeGUfVU=;
        b=O/Cd6qgor4+69rsQ7X2Sb6aD+Xk9JuoO6qsXoe5yR995GcT77MAlsQQRIZ4ZqnLW5n
         HIzixLEqrkEV3ORMA6tZNHaBWSN9Ryutvil7GoB8ED7KSW2enquVLTGmtUkLW1yStM98
         c6eAkb3Rqc1U8PFUsB+hy9Bro5Q0gXOnBnPtW6HS1FaE14r7NwUwuavdpbcN9eo7tlBT
         +Dw6F3Mc2k1txN2v+s/7cRhk8OhGglO+SmScjGQdkFym72w3NEKcsQv9GXtUzZarWm7v
         qGJUvhB03Rpcgf7aDCzcYETs8b2sZwYt4XfYAeSVxfwWYcGvvhkD5iAzdnnjD8km33gc
         qxIw==
X-Gm-Message-State: APjAAAVvSk+Zq1xOVSZtzlBYX7rGlQuRdkOPDTfRMlvjT+0954L8gaig
        qB7Aaj9oTTOn5GMasY3Dzp0jU6dG7Aw=
X-Google-Smtp-Source: APXvYqzVDWeZgfgCMpAjdgCpBZiDN50iVS7mz4VYscF9rvfj7OnG71Hyb+SV+apItGOjgS2DzYa4iw==
X-Received: by 2002:a63:3812:: with SMTP id f18mr23511597pga.320.1573399340742;
        Sun, 10 Nov 2019 07:22:20 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id i16sm11020998pfa.184.2019.11.10.07.22.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Nov 2019 07:22:19 -0800 (PST)
Subject: Re: [PATCH v4] io_uring: limit inflight IO
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
References: <8c57d694-6f73-4ac7-f390-ffbb3d780fea@kernel.dk>
 <f31d824c-a531-9d13-dcdc-f606de761693@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fae3fbac-b084-a08e-2306-19f75f5256c7@kernel.dk>
Date:   Sun, 10 Nov 2019 08:22:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <f31d824c-a531-9d13-dcdc-f606de761693@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/10/19 6:36 AM, Pavel Begunkov wrote:
>> @@ -2997,6 +2997,31 @@ static bool io_get_sqring(struct io_ring_ctx *ctx, struct sqe_submit *s)
>>   	return false;
>>   }
>>   
>> +static bool io_sq_over_limit(struct io_ring_ctx *ctx, unsigned to_submit)
>> +{
>> +	unsigned inflight;
>> +
>> +	if (!list_empty(&ctx->cq_overflow_list)) {
>> +		io_cqring_overflow_flush(ctx, false);
>> +		return true;
>> +	}
>> +
>> +	/*
>> +	 * This doesn't need to be super precise, so only check every once
>> +	 * in a while.
>> +	 */
>> +	if ((ctx->cached_sq_head & ~ctx->sq_mask) !=
>> +	    ((ctx->cached_sq_head + to_submit) & ~ctx->sq_mask))
>> +		return false;
> 
> Still not quite agree, with "!=" it will check almost every time.
> We want to continue with the checks only when we overrun sq_entries
> (i.e. changed higher bits).
> 
> 
> There is a simplified trace: let
> 1) mask == 3, ~mask == 4
> 2) head == 0,
> 3) submitting by one
> 
> 1: (0 & 4) != (1 & 4): false // do checks
> 2: (1 & 4) != (2 & 4): false // do checks
> 3: (2 & 4) != (3 & 4): false // do checks
> 4: (3 & 4) != (4 & 4): true // skip, return true

Huh yes, it's reversed, isn't it. Should be:

	if ((ctx->cached_sq_head & ~ctx->sq_mask) ==
	    ((ctx->cached_sq_head + to_submit) & ~ctx->sq_mask))
		return false;

> The rest looks good,
> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>

Thanks, I'll make the above change too.

-- 
Jens Axboe

