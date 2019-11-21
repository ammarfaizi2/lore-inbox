Return-Path: <SRS0=BBHt=ZN=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925D1C432C0
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 20:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60B3E20672
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 20:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="1L1gTLsG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfKUUIG (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 21 Nov 2019 15:08:06 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:40333 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbfKUUIF (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 21 Nov 2019 15:08:05 -0500
Received: by mail-il1-f195.google.com with SMTP id v17so684624ilg.7
        for <io-uring@vger.kernel.org>; Thu, 21 Nov 2019 12:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=NKDcTuK8NWzxTUXuc1cYMnrTKr3uxpUvypiyzR+erOQ=;
        b=1L1gTLsGxrSZ7/dQFDjnuWnZ5dgSn4F748IO/5v4rAc0Kv0kgLUk4O0fsEN/+Ym1gT
         G0cjht0CEmm3BqAcdUIWDw5ZEPq2B80/t82LmdZuu8w4y8m3iJgnSRHpfQ4jOMQWarpe
         HH2G0buVua34LQx3da0FEO1NOP3zJAD2WzPCbuLeJpCTWCV7sONnSzVRX9WwJ20BwpJt
         HK7IL8pZkKxg0dhxHQI8cnBORDuoMTp1ejJYZzTEP71q8lIRH3tl0qdmJ1PQPACD44KV
         Iq66lxhBolge4ChIqU/dtwdrNl6YZZGdtHSf8s+k/ZnubIUNy7MfcagZG3na2Td3p6Av
         Hkrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NKDcTuK8NWzxTUXuc1cYMnrTKr3uxpUvypiyzR+erOQ=;
        b=Yb/cUCmZCR/SPKjaQjTV0kxUTnuqShuuPdekIeLXuvCQXXqNd4jGciUH8GyW2BZzG+
         eafBjek1QrxA/EMYs57s2myk2kByErJnX6oRQ56o7iwtT1kpczciu8WdpTaXJ6K4QfeL
         kKdRQKnGKBhO2UBWK8duuIprRk6shnhUHF5jV+H2CUpilgeqKVZ2o1bfLyi2+9ON62FN
         eFPs2V50LeZgieUML09kwsq/MeBe0ZKba68Rl9SH8NFbbPvFVoHarnuPPkTkNd6t5JuR
         HLl8VCca2xh8BFYGppm+/awqFEpz9GpfWBI2s1lfUHg4ykXZuPuOlwh5116MCl/hith3
         em7Q==
X-Gm-Message-State: APjAAAWLYZNBew/5xIR+UiXj1pThnCuEGl9ux+iNFkk3K/xCQf7tB3fA
        mtnvqUJWCbgIuT1JlibHk848yDOaiAKypQ==
X-Google-Smtp-Source: APXvYqxZSCjw8/Jex7TnHOsltD+U3Mfh7cZT7MZ6tubKsRvUxIj5bHizTfLAj6s/iz9pTLu/ln4t5Q==
X-Received: by 2002:a92:3cd7:: with SMTP id j84mr12297085ilf.29.1574366882931;
        Thu, 21 Nov 2019 12:08:02 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c83sm1303185iof.48.2019.11.21.12.08.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 12:08:01 -0800 (PST)
Subject: Re: [PATCH] io_uring: rename __io_submit_sqe()
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
References: <228a5ae5d63c61dd4f7349594012bfc7691028a7.1574360634.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <715c1f8f-ac3a-21b2-df1b-9fef23036dbd@kernel.dk>
Date:   Thu, 21 Nov 2019 13:08:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <228a5ae5d63c61dd4f7349594012bfc7691028a7.1574360634.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/21/19 11:24 AM, Pavel Begunkov wrote:
> __io_submit_sqe() is issuing requests, so call it as
> such. Moreover, it ends by calling io_iopoll_req_issued().
> 
> Rename it and make terminology clearer.

I'm fine with this (and the other patch), but will push them
to the back of the pile for once the merge window stuff is over.

-- 
Jens Axboe

