Return-Path: <SRS0=KDoC=Y5=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5463DC5DF62
	for <io-uring@archiver.kernel.org>; Tue,  5 Nov 2019 23:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F085B214B2
	for <io-uring@archiver.kernel.org>; Tue,  5 Nov 2019 23:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pjwu2L2F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbfKEXsL (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 5 Nov 2019 18:48:11 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45593 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729583AbfKEXsK (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 5 Nov 2019 18:48:10 -0500
Received: by mail-pf1-f196.google.com with SMTP id z4so11284788pfn.12
        for <io-uring@vger.kernel.org>; Tue, 05 Nov 2019 15:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=05dRAMF1Vz+FeHeAryqq0JNAWj1xNIZkNNmr4b7Ijcc=;
        b=pjwu2L2FqwbVncAYOc13kacX1Wxo19uCEBZf8Pdn6fDX0d3yQJxlH/Vd3/l9OUMTkw
         u8Hl+o6BAL2H0s/1O3Gy90bEDALTOWPzNhdYTc/GkGVz+dKZNngUg906iAIeMXa3mR9N
         O+0RCIxPNOZ1MpsB0Aj0sH7l0soIS9FcjDK5ik97ZVMXjncrr/0IQ9sHl2b4iRU2iFXP
         61lBECtPF8TjuqLh51OZO8dh1/I4EWiiyhNqA6j42DCjDT51uxKRDujS4o3X9SD2ww+8
         ibggvlQJlioiXf7IWG88BIjk8VOCoPklbbjjuBTLpGhth++gA6B9CqIzeP8sVmmuzkGN
         NmCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=05dRAMF1Vz+FeHeAryqq0JNAWj1xNIZkNNmr4b7Ijcc=;
        b=AZP6Ul7uzf8aGfE4gsjhmSKfUmMfTtFKA3MqWGf7T+vYdn8mmMaZ4Kroo6TNZERl9K
         kma2is5jvpGyJDFwqszEDXmuOItTTqBz/tknBoks+cNnahNkw6zG0CjnxmmBy0HRqj2E
         v8/HDut5qv2lCXxxqnxe0hSyDQ5ZWYK2UcinAgnbCF8DrsoHwtPpZwisbC1c372xzLF5
         pZXqpt9x95kwkCYNqrlOZYBOhjwcIeuZeUxAIChwFeZUewI/KfDlOmrx5O2zSxr3Imir
         Ng9ftyCSF5ysXNvfl0K+ULBF+dkibQSNhEH2xQcNZnCKx4GNE6Tv/NJEV35VMbbdeKZp
         gn/g==
X-Gm-Message-State: APjAAAVPwRXKcK57GpuF0v+9wZ6j7FUVbAWdhH4z7y04NUC8MRE/9xqj
        jSrPi1POx/uF/LZqfSiVkpilqw==
X-Google-Smtp-Source: APXvYqxIAfVX/SJs7cWhzrGFsFJ3v+s04NG9ZykHj1uKqqUrpDgGycujmu/RnMdSbp1PN21unVtHlw==
X-Received: by 2002:a63:ff46:: with SMTP id s6mr39577289pgk.337.1572997688645;
        Tue, 05 Nov 2019 15:48:08 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id a6sm541194pja.30.2019.11.05.15.48.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 15:48:07 -0800 (PST)
Subject: Re: [RFC 0/3] Inline sqe_submit
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
References: <cover.1572993994.git.asml.silence@gmail.com>
 <a0393f05-dff2-6c34-4ba1-f6dba67955d2@kernel.dk>
 <1cc9dc92-3468-a780-e8ca-cb0f559a053f@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c50819c1-9a0a-1f48-2a93-14f3a10bb819@kernel.dk>
Date:   Tue, 5 Nov 2019 16:48:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1cc9dc92-3468-a780-e8ca-cb0f559a053f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/5/19 4:45 PM, Pavel Begunkov wrote:
> On 06/11/2019 02:37, Jens Axboe wrote:
>> On 11/5/19 4:04 PM, Pavel Begunkov wrote:
>>> The proposal is to not pass struct sqe_submit as a separate entity,
>>> but always use req->submit instead, so there will be less stuff to
>>> care about. The reasoning begind is code simplification.
>>>
>>> Also, I've got steady +1% throughput improvement for nop tests.
>>> Though, it's highly system-dependent, and I wouldn't count on it.
>>>
>>> P.S. I'll double check the patches, if the idea is accepted.
>>
>> I like the idea (a lot), makes the whole thing easier to follow as well.
> 
> Great, than I'll prepare the patches properly and resend it

Perfect - doesn't look like it'll conflict with the submission path
cleanup (which also looks good), but if it does, just collate them into
a single series.

-- 
Jens Axboe

