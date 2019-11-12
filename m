Return-Path: <SRS0=vuSH=ZE=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECB2C43331
	for <io-uring@archiver.kernel.org>; Tue, 12 Nov 2019 23:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198B8206B7
	for <io-uring@archiver.kernel.org>; Tue, 12 Nov 2019 23:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="dALg1Zd0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKLX7q (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 12 Nov 2019 18:59:46 -0500
Received: from mail-pg1-f175.google.com ([209.85.215.175]:35229 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKLX7q (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 12 Nov 2019 18:59:46 -0500
Received: by mail-pg1-f175.google.com with SMTP id q22so93556pgk.2
        for <io-uring@vger.kernel.org>; Tue, 12 Nov 2019 15:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=OHR+x59bo8qfnAuFGPAxuv4ERXNVJbP5v0ZrpKehsdo=;
        b=dALg1Zd0s/tHiLlCTtZLkvqCziI/64j+LgiwAkftmyeh62VzYOrUKDWNIGsxNjcHIX
         Tp2WH4ht/Z+HhFjvWj88qH4+Kj3dk1Sc9CkKxZLFND3LWaiconUnUmUPmqPXHqjVHU3h
         KGezmsQUmwtB3s997+/T8jJjkCrLqlYYkmEdea2oE7LpVu9SQQWW7zVLBWaWLfBzmrmd
         24b2IvfMzzZzMdfbWk2Q/R/PFzZN1XC5QE9KSq6TwG58nkL4d5OqxsDJ/X0+qCWXYD7z
         uBmrzV3Zkw0cPnqYD1eyHVdokuS+S/Dc9iUF1QhBODSdDxxhp3NzSldyF4glMwSs67zD
         hzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OHR+x59bo8qfnAuFGPAxuv4ERXNVJbP5v0ZrpKehsdo=;
        b=X8Fl96eq55jI4goE2FqjHJreweq87Z/VduH2/cTqbOiVI2aZYK1MpOq7jrm59EyBf9
         bv8oHtZaWkWaWt42WbKWgCBp1JEwsPSxnfvafiMlBuHPeermycPdeiXspGeGJpodQ7+G
         iG1NBTYBqZSUkDlPWMq2rn+Ap9UNPsLBWhhkHTuHge1aPMtyyLanEOA7ztPR2DyBMqyE
         Eu51zmYWkQXtgiTmkDeq7APLHtJA8vTgR+lO+1fOvgzJ2e8G2TOJk60JnPbGs/NgUsSA
         qloC7RWd0IC20VY990VNKnfl2mKc8VShKUNQJydK+FLfEGzr1Q9Rlu7pMVF1K21mVesZ
         uPeg==
X-Gm-Message-State: APjAAAXZQtAgDighb1F8o0ttF+Qq9gFofptDnKWCY43L2ehO+tpKWRid
        Hw55bA0ARPNKoNltUn+7njOl1mh6HV8=
X-Google-Smtp-Source: APXvYqwE3EMtDJJ88BKkdWhohbgHYYFT7L+cfodIG5StimRw3v9r/lDehJYqkUykFYe5Z6X0ITlp+Q==
X-Received: by 2002:a63:a05c:: with SMTP id u28mr200504pgn.333.1573603185352;
        Tue, 12 Nov 2019 15:59:45 -0800 (PST)
Received: from [192.168.1.182] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id z18sm115673pgv.90.2019.11.12.15.59.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 15:59:44 -0800 (PST)
Subject: Re: [liburing patch] test: fix up dead code bugs
To:     Jeff Moyer <jmoyer@redhat.com>, io-uring@vger.kernel.org
References: <x49eeycirmq.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e5b2d365-cb99-7a40-f8fe-dd8b301c741b@kernel.dk>
Date:   Tue, 12 Nov 2019 16:59:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <x49eeycirmq.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/12/19 3:47 PM, Jeff Moyer wrote:
> Coverity pointed out some dead code.  Fix it.
> 
> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
> 
> diff --git a/test/fsync.c b/test/fsync.c
> index e6e0898..3c67190 100644
> --- a/test/fsync.c
> +++ b/test/fsync.c
> @@ -96,14 +96,14 @@ static int test_barrier_fsync(struct io_uring *ring)
>   	io_uring_sqe_set_flags(sqe, IOSQE_IO_DRAIN);
>   
>   	ret = io_uring_submit(ring);
> -	if (ret < 5) {
> -		printf("Submitted only %d\n", ret);
> -		goto err;
> -	} else if (ret < 0) {
> +	if (ret < 0) {
>   		printf("sqe submit failed\n");
>   		if (ret == EINVAL)
>   			printf("kernel may not support barrier fsync yet\n");
>   		goto err;
> +	} else if (ret < 0) {
> +		printf("Submitted only %d\n", ret);
> +		goto err;
>   	}

Looks like you're adding new dead code :-)

-- 
Jens Axboe

