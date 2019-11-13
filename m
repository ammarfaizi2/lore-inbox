Return-Path: <SRS0=KKPr=ZF=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F93C432C3
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 19:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C51206DC
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 19:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="N1Cu772v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfKMThu (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 13 Nov 2019 14:37:50 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:42023 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfKMThu (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 13 Nov 2019 14:37:50 -0500
Received: by mail-il1-f193.google.com with SMTP id n18so2893288ilt.9
        for <io-uring@vger.kernel.org>; Wed, 13 Nov 2019 11:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pI7piCtI6WYI9kIPI0gDMcrmyPRHl7iOrc9WhlQg160=;
        b=N1Cu772vrDyKSaos+ZmT2Lj5We36/Xc9BGltmRgEZigzIHLBDGifsSTdVdd/zdJ7xP
         lwB26GQPMoj6F22Jvtk25PgTQ0zZRSvRyCjTxIqRTtGQT7zXStgUAITaL76K3UjaOoJY
         3hAto0BcRKbNfvpHIaaWkQs3CS11VkDbCnU6YYr/uij898akocI/DIl4HnkvYfd4PaNs
         itPXDqrBJmC/CZUuChdfZABVVd/594KGV2VjIqFQRHZnTzJ/XOrDKa5vt5n9ptAL2OfX
         lUDkAcKsj00lJ5nY1krqEAl4L1Yqmeymv2QgMZg6n7vGVSI+SWgWYyV3eOP922tG5Ex9
         JDXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pI7piCtI6WYI9kIPI0gDMcrmyPRHl7iOrc9WhlQg160=;
        b=sYRdkRrAxH8hsUCHkD3hBciCgWTsv6kJKE8NfyZwEylVmpRMSxsQF4OPmqhf4ZLtZ0
         gfYfKG7u9XKnhzOziydaEeTfRK6q1opvaXxPc48L9EbVqHbsYD5LLTgTTApX62o1rAIY
         qvA2BCyi4mVcng5VqPxrWwFbR2MjbsC4+xVBmB2WfAZIyyMzffbsQPsjkDPWe+Z2w6PD
         NKDCZMEOhGaAU4NlILU+TGmHhNh1BiIGMguwhpL+zO4ge0HxgkJG1G/QjWPHKC/SZ2Vk
         LhSYVR6ViRtQP+qWiZFHMMEHoIsmHJL+zcGzj5xB9ZW03QmzR5AHnpViy/YLgEbpdCpr
         NhaQ==
X-Gm-Message-State: APjAAAXS8XIs9bweikDk1/X7D9d7MYvcOGgTT3nKmBS4gZRWhGpBYNm+
        hcatpQXtlOY0LvOyw6y1owqGH50sUM4=
X-Google-Smtp-Source: APXvYqwDISCSDXvfh8YSHjn7hSnuDEres9hGZyMmDTIGzK32JQz0jDj2a7Zv6vWYvwJQo7ekHa26RQ==
X-Received: by 2002:a92:814f:: with SMTP id e76mr5837245ild.163.1573673867809;
        Wed, 13 Nov 2019 11:37:47 -0800 (PST)
Received: from [192.168.1.163] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l205sm415938ill.50.2019.11.13.11.37.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 11:37:46 -0800 (PST)
Subject: Re: [PATCH 1/2] fs:io_uring: clean up io_uring_cancel_files
To:     Bob Liu <bob.liu@oracle.com>
Cc:     io-uring@vger.kernel.org
References: <20191113100625.10774-1-bob.liu@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <f7cc573e-e1db-1e13-1d6c-debd19a522fa@kernel.dk>
Date:   Wed, 13 Nov 2019 12:37:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191113100625.10774-1-bob.liu@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/13/19 3:06 AM, Bob Liu wrote:
> return val is not used, drop it.
> Also drop unnecessary if (cancel_req).

Applied both of these, reworded the commit messages a bit. Thanks for
sending them in. A few notes for next time:

- Please use a cover letter if you send more than 1 patch
- Patch subject should be "io_uring: bla bla", no fs, and use the same
  style for both (you have fs:io_uring and fs: io_uring

-- 
Jens Axboe

