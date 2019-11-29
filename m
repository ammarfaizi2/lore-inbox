Return-Path: <SRS0=UBdq=ZV=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E322C43215
	for <io-uring@archiver.kernel.org>; Fri, 29 Nov 2019 17:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 421A3208E4
	for <io-uring@archiver.kernel.org>; Fri, 29 Nov 2019 17:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WisHMBSH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfK2RVs (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 29 Nov 2019 12:21:48 -0500
Received: from mail-pl1-f169.google.com ([209.85.214.169]:35498 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfK2RVs (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 29 Nov 2019 12:21:48 -0500
Received: by mail-pl1-f169.google.com with SMTP id s10so13109960plp.2
        for <io-uring@vger.kernel.org>; Fri, 29 Nov 2019 09:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6f/w8PkdHeJcppNJMf18+SNMJB+HQvEbVcOg9Nu0TgY=;
        b=WisHMBSHI+iu0ya8uNFjAifcPcKPkC+4YsX6KoOT9mZ7IlvboUpLMEgcOQrbbdIdBu
         cUxBLN14T/MUOxqK1KSd2MGJe04x5cE5q31TxBPj3tyXTA3WKga5ktjtcfv1meFA7QP7
         3jhieY/EfK/1Zx/VNGRRpGKQ1S3JUXxiyQxL4J3ohRoAjRsQRoBELVAtl6ttgGmr9JIC
         +hVtMvTdn1/UU2EfxeUcnREAo2JV96f0mzZghKNN5STytIMmgnrmpaeDKtV/qh2bAAhD
         MPaCrrB0kaRqBixpNLbIxk3dVGf0Xopi0KzuLD0ST/jSo/8091v8DFiHiirNoU/CXnVq
         bTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6f/w8PkdHeJcppNJMf18+SNMJB+HQvEbVcOg9Nu0TgY=;
        b=kKJ4TeKsL+FGSQHWwJEDnwZB212l7ur0sSWl+7nePidRxGu01dVwin6soXQvC0mPPS
         36I1P9vCC2B/hACw3sduAm/bMo1N+MYQnrICBLzHrgRav88xSPipqMRzEKEO2qOKP+N/
         KHbmNXeXNIVFsMPr4v6F7utMW0vkCjuSiQ3eecJPEVR9JeEz0aeNxV3yySxTHbw0KnsN
         qzA0VmcCcJ9NxcV0ghHDL+Fyaa/tNybcInKTPPV/avxxoquMktainoxc9vRtnmAmosIz
         fkX48W+8W5PTXw8xRHbKvebB7LwN6pZDP0+0MCLlrfMoq/mevWLPLZ+kT0ZjVIlLjPsb
         opJg==
X-Gm-Message-State: APjAAAUxSoQgrNWmHWKm2A40izRncRsYDUbkrdrpkfVbPBasXbjcZJF+
        /mvUSfVeEEPfmsaF/mg0iq+QvbgoHnVUoQ==
X-Google-Smtp-Source: APXvYqy4HEpHIbSG7lTkjOaawZfNDS45s9gv6alUNCSKHK1eoSCtitDm2xJEgfT2seASb5Ktjo8AGA==
X-Received: by 2002:a17:90a:7bcc:: with SMTP id d12mr19881269pjl.63.1575048104954;
        Fri, 29 Nov 2019 09:21:44 -0800 (PST)
Received: from ?IPv6:2605:e000:100e:8c61:c457:26a3:bdc5:9aed? ([2605:e000:100e:8c61:c457:26a3:bdc5:9aed])
        by smtp.gmail.com with ESMTPSA id g192sm24716123pgc.3.2019.11.29.09.21.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2019 09:21:42 -0800 (PST)
Subject: Re: delete unneeded int-type
To:     Jackie Liu <jackieliu@byteisland.com>,
        liming wu <wu860403@gmail.com>
Cc:     io-uring@vger.kernel.org
References: <CAPnMXWW=cV_H2xs=r21DOuhfKWcCaxgG2iXR9LaExuRMNGUvpA@mail.gmail.com>
 <743A423B-8270-4A31-ADF3-28E8A7EB8A72@byteisland.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5d5259dc-279a-f0f6-09b5-1dd2561ca010@kernel.dk>
Date:   Fri, 29 Nov 2019 09:21:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <743A423B-8270-4A31-ADF3-28E8A7EB8A72@byteisland.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/29/19 12:25 AM, Jackie Liu wrote:
> 2019年11月29日 16:19，liming wu <wu860403@gmail.com> 写道：
>>
>> Hi
>>
>> It can't buid successfully except use c99.
>>
>>
>> Subject: [PATCH] delete unneede int-type
>>
>> ---
>> test/accept-link.c | 2 +-
>> test/poll-link.c   | 2 +-
>> 2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/test/accept-link.c b/test/accept-link.c
>> index 2fbc12e..91dbc2b 100644
>> --- a/test/accept-link.c
>> +++ b/test/accept-link.c
>> @@ -131,7 +131,7 @@ void *recv_thread(void *arg)
>>
>>         assert(io_uring_submit(&ring) == 2);
>>
>> -       for (int i = 0; i < 2; i++) {
>> +       for (i = 0; i < 2; i++) {
>>                 struct io_uring_cqe *cqe;
>>                 int idx;
>>
>> diff --git a/test/poll-link.c b/test/poll-link.c
>> index 3cc2ca7..abddb71 100644
>> --- a/test/poll-link.c
>> +++ b/test/poll-link.c
>> @@ -127,7 +127,7 @@ void *recv_thread(void *arg)
>>
>>         assert(io_uring_submit(&ring) == 2);
>>
>> -       for (int i = 0; i < 2; i++) {
>> +       for (i = 0; i < 2; i++) {
>>                 struct io_uring_cqe *cqe;
>>                 int idx;
>>
>> --
>> <delete-unneede-int-type.patch>
> 
> I think it would be better for you to send patches using git send-email
> instead of using attachments.

Yeah, this one is small enough that I just hand apply it, but the
patches are clearly mangled.

-- 
Jens Axboe

