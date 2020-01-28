Return-Path: <SRS0=4B3G=3R=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAA0C2D0DB
	for <io-uring@archiver.kernel.org>; Tue, 28 Jan 2020 15:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E184420716
	for <io-uring@archiver.kernel.org>; Tue, 28 Jan 2020 15:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="CYC6PrsH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgA1PYZ (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 28 Jan 2020 10:24:25 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:36261 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgA1PYZ (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 28 Jan 2020 10:24:25 -0500
Received: by mail-io1-f67.google.com with SMTP id d15so14696209iog.3
        for <io-uring@vger.kernel.org>; Tue, 28 Jan 2020 07:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DlYLkBZ9VdehWxXvy4wfxbhHF71ir6ovCcdGzPzRuV0=;
        b=CYC6PrsHQnUV7tW96lbDxOoajNzWwnYkOzDxoSwK9Xrhg8R67EBSVzaOGGhis2S7+U
         NZmASQUAW9FpQAdw4wwM16abyWu668E2bhpyFrth4xZDLsZ2L+ZOCuohY7Z/BFBAdM9z
         DVxoaBgOrtC9QcoAGH0rrAC1qtg1W+Q2b7wY5KvpqdvzN47XG+ghpMAXRkxwVj1K3jlh
         Xb2Riydi7gtENM5PSSw8cv7LUuf8baJ7v0Zmkwdu42llE0Gx0b9Lnxuqw/kTaU3dp/yi
         GIuh1XfT+hmYUBb3mVi1AMSKnZEkzpqCbW/QBMA4cE4kuwuT82BMVy5z0dLcG5+lgRg7
         OC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DlYLkBZ9VdehWxXvy4wfxbhHF71ir6ovCcdGzPzRuV0=;
        b=mmv61wrz/J2IeU+vL9TAXxwigutd23HQdV4QTTp3ueN0svJ5aBRWbp533RqfpKtYV4
         4PibLp0IuTjo8I4qvy8jDWAbp4U3dIofBLsaVTmW+Twyytxr9xr3bNyg7Ipr6w7gQlwe
         rfN1xer4P9EpIKasThzuT6WYbYe7igmBhzwk3Cdi1bN2aWMW9kBU4ljO4XhDGe+ME+G7
         1CoD3b5IepVbqleKuyU4OxsJvftxawrIbrQPA0MsCcCZR8zCn2639P9MyKzkeoPwtURJ
         bZ4LHGBhU0ODgaU1rKGAdygCB4WRa7qhjHLpBZJ0GO8Xo9yEEqdqksW67d13FesVZm40
         30NA==
X-Gm-Message-State: APjAAAVWZx8iGUTnndWlwkFg9P+42OtoQrjjhiAchveKhvteOcAcJQjk
        B6cLCq5DUJmsuHadWuOUwYzK/ffKsVU=
X-Google-Smtp-Source: APXvYqyC85KTDHfnYnZzUbcCjPGoWVT1O2XnWIsQWxvRzuohofYI+yAufmqW9+/Q8X/QGSrBA9IKXA==
X-Received: by 2002:a02:7fd0:: with SMTP id r199mr18506395jac.126.1580225064516;
        Tue, 28 Jan 2020 07:24:24 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o83sm5994037ild.13.2020.01.28.07.24.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 07:24:24 -0800 (PST)
Subject: Re: [PATCH liburing] test/read-write: fixed output, and added
 'nonvec', when VERBOSE
To:     "Simon A. F. Lund" <simon.lund@samsung.com>
Cc:     io-uring@vger.kernel.org
References: <CGME20200128132022eucas1p1e94fc561550c26d2c880282fd9ad9c62@eucas1p1.samsung.com>
 <20200128132005.2234-1-simon.lund@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f7b8c977-714b-ad6c-a485-d29804f5fabe@kernel.dk>
Date:   Tue, 28 Jan 2020 08:24:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200128132005.2234-1-simon.lund@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 1/28/20 6:20 AM, Simon A. F. Lund wrote:
> Signed-off-by: Simon A. F. Lund <simon.lund@samsung.com>
> ---
>  test/read-write.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/test/read-write.c b/test/read-write.c
> index face66b..64f8fd5 100644
> --- a/test/read-write.c
> +++ b/test/read-write.c
> @@ -62,9 +62,10 @@ static int test_io(const char *file, int write, int buffered, int sqthread,
>  	static int warned;
>  
>  #ifdef VERBOSE
> -	fprintf(stdout, "%s: start %d/%d/%d/%d/%d: ", __FUNCTION__, write,
> +	fprintf(stdout, "%s: start %d/%d/%d/%d/%d/%d: ", __FUNCTION__, write,
>  							buffered, sqthread,
> -							fixed, mixed_fixed);
> +							fixed, mixed_fixed,
> +							nonvec);
>  #endif
>  	if (sqthread && geteuid()) {
>  #ifdef VERBOSE
> @@ -212,7 +213,7 @@ static int test_io(const char *file, int write, int buffered, int sqthread,
>  	return 0;
>  err:
>  #ifdef VERBOSE
> -	print("FAILED\n");
> +	printf("FAILED\n");
>  #endif
>  	if (fd != -1)
>  		close(fd);

Applied, thanks.

-- 
Jens Axboe

