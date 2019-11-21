Return-Path: <SRS0=BBHt=ZN=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0947C432C3
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 20:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3887206CC
	for <io-uring@archiver.kernel.org>; Thu, 21 Nov 2019 20:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="aGvHH7dP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfKUUfB (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 21 Nov 2019 15:35:01 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:35155 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfKUUfB (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 21 Nov 2019 15:35:01 -0500
Received: by mail-io1-f66.google.com with SMTP id x21so5106824ior.2
        for <io-uring@vger.kernel.org>; Thu, 21 Nov 2019 12:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=R3YjJatjlQ+S1BuPurVu8qHvbm7bZe3Kq/Sm0Z4gV4I=;
        b=aGvHH7dPhFd+xoE3Beh+Tckunnjd2s3pfsNiRn8fTJMvokfjkMnThkeLbKhnl3Z0Tp
         AaXvNSIQh+2rdH1PWNCEkDZqxLVRaj4emTig37cuXIHZ++znQY58XGLmuUWgnj0j6akn
         EUMGRCws9LHhB3+q7t6suQDZZ/dww4WR+PflcaeAeVwnDB6deuXagHKSZ57WgPoLY4R5
         NBWoyC7tdf/EKZWR8Ktp1xX6Cv+VriydgWc3pJFneYn5Awg0xfpvozhhOzaOW3GhZ2Xo
         I//Tummpi3TASIYKaI5K4UIkhBGk44ELgKdGJ7mbxx+q1I62L0Y9EAXHYogUY+XuQgl+
         yMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R3YjJatjlQ+S1BuPurVu8qHvbm7bZe3Kq/Sm0Z4gV4I=;
        b=mIaza0DH6ILmudVWQbqFJNyddN9eKWoeVdxA8gjS3Kh6UK1++/kxRc0YKIXzoIqlXH
         PgZAZ1ldvoKsae1oCy5mQEf2GEMVQFC9S8bHo/BeQFq+tslh2ebFm4lCeGTfvD7bDo/7
         sKqF5KQSEZ0b7fwkJi9WXCePy3lKv7IhpDq6zLaVSNsB+s/k6Giy5DcWuii+d1l0eX8c
         1GUfWnL+Zo0XtjBwXjVVHcf8Wrn1A8s/2JrAC/Od2EvekknpTEZB6EqShB3SgRgd6siE
         3K96BOhVwnkNYb4GhhsIAq09/tj8jtAti2W8h1LOoSeM7bl0jujD8nXH7PPtOQBo3zsJ
         YMKw==
X-Gm-Message-State: APjAAAVx4W1/tWRlUWhGSmlVsCwzWJA6790eD0lnK92l8Qf910bAjFAT
        2fsyFr4hnlG5LYEtYGi40QJI0BtABgybqw==
X-Google-Smtp-Source: APXvYqx3rpYDGDskNT8kCQImm7MiARXfyyG9QbKTsfZACxfkiz71FusD3UAmOTJiCj5j57CJvNg/pA==
X-Received: by 2002:a5d:94ca:: with SMTP id y10mr9733926ior.104.1574368498428;
        Thu, 21 Nov 2019 12:34:58 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w75sm1713124ill.78.2019.11.21.12.34.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 12:34:57 -0800 (PST)
Subject: Re: [PATCH] io_uring: rename __io_submit_sqe()
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
References: <228a5ae5d63c61dd4f7349594012bfc7691028a7.1574360634.git.asml.silence@gmail.com>
 <715c1f8f-ac3a-21b2-df1b-9fef23036dbd@kernel.dk>
 <8b5be6c6-5160-24e5-ee41-a50690be93b6@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3155b873-c790-db01-22e0-068f06bcf82e@kernel.dk>
Date:   Thu, 21 Nov 2019 13:34:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <8b5be6c6-5160-24e5-ee41-a50690be93b6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/21/19 1:30 PM, Pavel Begunkov wrote:
> On 21/11/2019 23:08, Jens Axboe wrote:
>> On 11/21/19 11:24 AM, Pavel Begunkov wrote:
>>> __io_submit_sqe() is issuing requests, so call it as
>>> such. Moreover, it ends by calling io_iopoll_req_issued().
>>>
>>> Rename it and make terminology clearer.
>>
>> I'm fine with this (and the other patch), but will push them
>> to the back of the pile for once the merge window stuff is over.
>>
> Not a problem. Then, I'll send remaining patches later.

You can just keep piling them on, that's fine. Just keep in mind
that the merge window is opening this weekend, so it has to make
sense in that context.

-- 
Jens Axboe

