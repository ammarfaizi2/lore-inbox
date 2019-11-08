Return-Path: <SRS0=cPsQ=ZA=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CD9FA372C
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 14:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 838A621924
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 14:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hPgY0FT8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbfKHOQi (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 8 Nov 2019 09:16:38 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:45440 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfKHOQi (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 8 Nov 2019 09:16:38 -0500
Received: by mail-io1-f65.google.com with SMTP id v17so5423493iol.12
        for <io-uring@vger.kernel.org>; Fri, 08 Nov 2019 06:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NeeyEBL2r7Ur6MKtDiKSOvghboGFHcCegqzJIx9eOBs=;
        b=hPgY0FT8hG9ICGU28uzhEO4auY31A+96lAm2xRpW7tOtPN3sAIKl1EcNoWPsrq6jGi
         5sMmvjFFyYKOi4qIw9/ivClk4lKBl2VpeTguac+tHoYj9HTWHcC4PAX6SxzOAQYi7OFp
         7jrcP1p6V+LDCScshBxY4X0AfF1ARGjpTfxXzmUjE4cI156eGDJhX6qO+FYgxp5wzpYU
         HKDU+9CLkYwgTe3KbM9AFBFymaVV9R8K1ttX95G0Qfolf11EoYkinVC1F2VmWlZkhWSc
         qSfPX6KAjxZu9IO95V7J/zWDD87WyJsE8w7ZfNjmfXC4o5yO6nu4VaKMM449s01FKIRg
         B+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NeeyEBL2r7Ur6MKtDiKSOvghboGFHcCegqzJIx9eOBs=;
        b=FHbUjcpYvY3CE3mAdWBzl2LFDNlSfXIVFDUUF8Po5JjDstMX9bvRImUwsNDT2O2Y9t
         fCIeOxNetT8ChaZaVSnrK7xzhT7/FHVZlTo/4MrJ5VNUmfoyOVKJa9BxXyCeb1QukByu
         F3wAZx8/yNrhVfgep+lu/VFOJrmZ1XvfJhse5Y8H/LWFCRc6U6uD/flRjF6oeWdtbiFM
         46XQI3nU/5u964izzQiQ2rMOQJ/T6/OvG2GaOUNfONvIttKy3PIrQEDhsXLdBuG3u/jf
         KR3TtAzpGdbJkLW1KhuaVLg3YnfL328RWJsrvLsH0VvCWmcevOlu+YnSrBuw4V64pTRw
         wuSw==
X-Gm-Message-State: APjAAAVOWopdcYWZZZp+8YKWKFvkTcIVN2KX6pVKtMsUCRvsH5OcbT85
        BBtlkwAWUO9wu77L6LRqtqjj66fWn98=
X-Google-Smtp-Source: APXvYqwkWIoMR4KbB8RA44dA6UbxnkpIQaD5kUkiMgK8luQGmXqaRF+R9GCPUII8VpF87jK+ZlcQzQ==
X-Received: by 2002:a5e:8c0a:: with SMTP id n10mr11094239ioj.78.1573222595287;
        Fri, 08 Nov 2019 06:16:35 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s90sm790012ill.40.2019.11.08.06.16.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 06:16:33 -0800 (PST)
Subject: Re: [PATCH v2] io_uring: reduced function parameter ctx if possible
From:   Jens Axboe <axboe@kernel.dk>
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     io-uring@vger.kernel.org
References: <1573198177-177651-1-git-send-email-liuyun01@kylinos.cn>
 <5c685b0e-077a-9472-0f2b-982ecfffe9d9@kernel.dk>
Message-ID: <6a0624b5-9348-769d-c7f5-1f9bd224a8ae@kernel.dk>
Date:   Fri, 8 Nov 2019 07:16:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5c685b0e-077a-9472-0f2b-982ecfffe9d9@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/8/19 7:11 AM, Jens Axboe wrote:
> On 11/8/19 12:29 AM, Jackie Liu wrote:
>> Many times, the core of the function is req, and req has already set
>> req->ctx at initialization time, so there is no need to pass in from
>> outside.
>>
>> Cleanup, no function change.
> 
> I was curious if this patch netted us any improvements as well, but it
> actually blows up the text segment a lot on my laptop. Before the
> patch:
> 
>     text	   data	    bss	    dec	    hex	filename
>    87504	  17588	    256	 105348	  19b84	fs/io_uring.o
> 
> and after:
> 
>     text	   data	    bss	    dec	    hex	filename
>    99098	  17876	    256	 117230	  1c9ee	fs/io_uring.o
> 
> which seems really odd. I double checked just to be sure!
> 
> axboe@x1:~ $ gcc --version
> gcc (Ubuntu 9.2.1-17ubuntu1~18.04.1) 9.2.1 20191102

I took a look at the generated code, and it looks like it's just
enabling gcc to inline a lot more aggressively.

-- 
Jens Axboe

