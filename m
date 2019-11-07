Return-Path: <SRS0=nqv2=Y7=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24B1C5DF60
	for <io-uring@archiver.kernel.org>; Thu,  7 Nov 2019 13:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FA972187F
	for <io-uring@archiver.kernel.org>; Thu,  7 Nov 2019 13:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lxJ5Vrhk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfKGNQl (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:16:41 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39519 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfKGNQl (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 7 Nov 2019 08:16:41 -0500
Received: by mail-pg1-f194.google.com with SMTP id 29so2165611pgm.6
        for <io-uring@vger.kernel.org>; Thu, 07 Nov 2019 05:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6QjnBCQTxUtt0o5npapNIoHxcFFWQcZq1wOJ/hQRn0E=;
        b=lxJ5Vrhk2jZu3Ruvu7Zf6E2BhLa83KQ/QdRHIgykF10syN/Vjs00bZZGWuko/zWVNH
         Nav2yEW7RO+X0RjzhKGMMBhLXubYGL0wdjpmH/qpID+JWLyPiCFTNRMf6udcPt9SSAw3
         G/piOImitALYm3vvcZr8K4GiSBc/JY7upVAMALfuSzyxxvFEzIfVKBBUwcK3Ii9r4JgV
         WNn+ISyf5zfrPOnn5aooMRxYw3MutLkxQKB/VUwXFn8/3w4C0vk7yDRD5isVxC4EZ/yB
         6iD+QtbVUEImLdGCEoqpDZSvDcb34KMICSlA+GyVRSBEcpF6Tl/peuWtDdhrjQ/2sNsZ
         L3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6QjnBCQTxUtt0o5npapNIoHxcFFWQcZq1wOJ/hQRn0E=;
        b=hd9i9u+bsbdZwoZqQDM/TektTbC5jk0wu4Fz50sTgRm0i571O+Xv4iz5Av+DiSdXcX
         GIu7grNS2RZx2gB1s9vrligZ8C6GYN5thWnY1z8g1hBxt/QTMcKcaPzQMCeac3HThqRN
         arjN6MnQiFjO429XmF2oO6Nt3Ifc0UIq8kzCWOaFBTZ/Fcu5iJLFNqaTLYgmzKxpXiUx
         Egf0ge9lABAaoxngT6sZcSfag4GsWTtvKQs4uQORG7PRsvai0DR/GKBlaI2nxvUWkqTM
         /7hjOHBfumtOUNqqMWvVaIEndtdIpL648O7mit8e5BdvFvx74GgcMSJ0prJn0REw/v/s
         /vTA==
X-Gm-Message-State: APjAAAWZrMWyFCSecg/tp17QMopjM9QC2x9Kz3Ris4ywF5PvPs0xCchN
        0A7CaQUKGaeTqAQ/yjbRjnKl+w==
X-Google-Smtp-Source: APXvYqwgiE+3OpiuyuXB9dcHTUTkJgN5BIIL3J7KH3ngNzWH6yKL/eQkRBQsDnTFKhwBGi6qiF+Q1g==
X-Received: by 2002:a62:174d:: with SMTP id 74mr3906060pfx.145.1573132599684;
        Thu, 07 Nov 2019 05:16:39 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id l72sm2232942pjb.18.2019.11.07.05.16.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 05:16:38 -0800 (PST)
Subject: Re: [PATCH 2/3] io_uring: pass in io_kiocb to fill/add CQ handlers
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc:     linux-block@vger.kernel.org, jannh@google.com
References: <20191106235307.32196-1-axboe@kernel.dk>
 <20191106235307.32196-3-axboe@kernel.dk>
 <df4352ab-2670-e69f-cc92-5e72f1cd6229@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2a723bbc-f031-6d2a-ef8b-96f9a5cfc70e@kernel.dk>
Date:   Thu, 7 Nov 2019 06:16:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <df4352ab-2670-e69f-cc92-5e72f1cd6229@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/7/19 2:53 AM, Pavel Begunkov wrote:
>> @@ -804,8 +803,10 @@ static void io_fail_links(struct io_kiocb *req)
>>   		    link->submit.sqe->opcode == IORING_OP_LINK_TIMEOUT) {
>>   			io_link_cancel_timeout(ctx, link);
>>   		} else {
>> -			io_cqring_fill_event(ctx, link->user_data, -ECANCELED);
>> -			__io_free_req(link);
>> +			io_cqring_fill_event(link, -ECANCELED);
>> +			/* drop both submit and complete references */
>> +			io_put_req(link, NULL);
>> +			io_put_req(link, NULL);
> 
> io_put_req() -> ... -> io_free_req() -> io_fail_links() -> io_put_req()
> 
> It shouldn't recurse further, but probably it would be better to avoid
> it at all.

Not sure how to improve that. We could do something ala:

if (refcount_sub_and_test(2, &link->refs))
	__io_free_req(link);

to make it clear and more resistant against recursion.

I also think we need to put that link path out-of-line in io_free_req().
I'll make those two changes.

-- 
Jens Axboe

