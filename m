Return-Path: <SRS0=cPsQ=ZA=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FE6C5DF60
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 15:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21885215EA
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 15:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="yunoFjie"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfKHPLJ (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 8 Nov 2019 10:11:09 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:42342 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfKHPLJ (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 8 Nov 2019 10:11:09 -0500
Received: by mail-io1-f66.google.com with SMTP id g15so6704228iob.9
        for <io-uring@vger.kernel.org>; Fri, 08 Nov 2019 07:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VCCDEAWlZWorAzknf5Gv0FT/GHdPUXgQseNB97qxKHg=;
        b=yunoFjieCzz261kl5hvYsv18Bq3HQqV65NElAXIlM8UduinUEra7XcNUo6mTcTH9Rz
         GB5uo83pJyBEYj+5PTjYI97X1oXPAJvHcTe3n+9BnqjCPh6a877sQiLOWO1a9Yoxab8N
         wBoQcy4fuX9CVSIqcOVjB36x7J3MIpOhS1rXu57YHH+uUOHjK36eQSB4YPrkh+ndxYL6
         kI68F5fl21WEjpnePcK2FkTnJpcnuhylh7oSaQLphWfC84ChhDAyBl7kpfetWAEi3++h
         EeRUL7NtuyI18GpSNm/HYkua5ZVYDzGKE1o+fTjDCkPl1+o4QMQgyaMLVrVP842Yuc4m
         +W9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VCCDEAWlZWorAzknf5Gv0FT/GHdPUXgQseNB97qxKHg=;
        b=E+Bmf+84jQmpEKhcRE3EfTmfxLMyrPVTKPHqEEjz4wtsoxDJF62cblBKJ8pgrVCpdc
         UgpWR/ZgiIaVYSPhVIih2jOkqqWY+LLOMIq3DFPd2p7BmcbAYnEJxMA9i/LXFx52WHae
         xJ4VgzuDo1aehtqqhLWQnlYxyba1kL0vqyxPMg6C+2bHPahrRVEsYKm8W+09afzGyxI1
         saSwR2+DoayMu7nB3cmoENiCLhr0HXG6nRh4dzkCSZpMSTUcAchLkbBB0Ugi0X326AN/
         rDYKacyzDRJfDhfxXTMALF30o7xfg0V75SqrIMO6+Jp+NbIJIyXzz1gWyU4AxhVvEnYl
         6DWg==
X-Gm-Message-State: APjAAAUOAUVyIoUEAhfhxvzh+LnB4za6/i4ENiZSppIMxe0NFffYnf5U
        y0SrX3VeoMAAIJTEQfRPZt3rmfET+MY=
X-Google-Smtp-Source: APXvYqw+XTR0bX6sC6dZ4KwDGGgfE7nM4vFU88sgEiTPIwHAokNmyWWOVWSSGL21B67CNGm6yZS7fA==
X-Received: by 2002:a6b:c8cf:: with SMTP id y198mr10148583iof.213.1573225868343;
        Fri, 08 Nov 2019 07:11:08 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id u6sm532635ilm.22.2019.11.08.07.11.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 07:11:07 -0800 (PST)
Subject: Re: [PATCH v3 2/2] io_uring: keep io_put_req only responsible for
 release and put req
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     io-uring@vger.kernel.org
References: <1573224479-59295-1-git-send-email-liuyun01@kylinos.cn>
 <1573224479-59295-2-git-send-email-liuyun01@kylinos.cn>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <99d18631-3afb-d59f-04a1-67ca2a1e2bd0@kernel.dk>
Date:   Fri, 8 Nov 2019 08:11:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1573224479-59295-2-git-send-email-liuyun01@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/8/19 7:47 AM, Jackie Liu wrote:
> We already have io_put_req_find_next to find the next req of the link.
> we should not use the io_put_req function to find them. They should be
> functions of the same level.

I like this cleanup, but it doesn't apply to for-5.5/io_uring-test. This
is where I stage things that are still in testing, then I move them to
for-5.5/io_uring once they are good to go.

I applied patch 1 and pushed it out, can you re-generate this one against
the above branch?

-- 
Jens Axboe

