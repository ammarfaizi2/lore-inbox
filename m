Return-Path: <SRS0=KKPr=ZF=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8425C432C3
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 22:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A43206EE
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 22:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wzkmV5EC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbfKMW1Q (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 13 Nov 2019 17:27:16 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44658 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfKMW1Q (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 13 Nov 2019 17:27:16 -0500
Received: by mail-pf1-f195.google.com with SMTP id q26so2600864pfn.11
        for <io-uring@vger.kernel.org>; Wed, 13 Nov 2019 14:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Frwr8WyTar0hSUlnZY2Ud4CHXZGbjsASfDSvdQkXR0w=;
        b=wzkmV5ECqM/lyCfFslFk397dJFk1FmpZrod4s04jDBfJtAeEAvwA4OCD2hmP8vQy8R
         eEQvyetq14aIeOQsERfb5ZTbHtFcZlKrlvwWrOMRIxuMJP7cU94u4nEjBMULsEp9IiMg
         9MIqvOOgoFmPBeLl9FWolGEdxD2IFy5aTBLXHRGh1cIwnjGlmOE6hX9veK8xn3N9nCRZ
         TK0OF7WKM8CbCA1BeR9Q+yJ4cU7lGw9/xkkMqR7B1XTwpele7Le6+yBp4t6q9XPA1/tw
         HXmSGsRXG3zydETGH1noCh8qfj9JZUEc2yhhWFbZzzr1oI7VM+FL1etsKpUjtFt3vDeF
         KhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Frwr8WyTar0hSUlnZY2Ud4CHXZGbjsASfDSvdQkXR0w=;
        b=T2yNr7OVCgl+Jwn6s0UJ6icLwtOAuQ1b2e1jFq7sDiAO5oJXM77pu+lvegGu0w47K9
         iNLoTl8MU5/7hFewOqcNH1P9Rp0dTVLsAftSZNNk67AEiIs9f/kKa7UQ4HQQhqpfvbvk
         GtOdvX+Xdh7lHul5TQF3x+L/1OxT8fGulpwxyIp+7GEXskEUEG0yR/6/bP9NrZPAOb9c
         1fs0VNHXgxZKkblapoHVl24WwfysrmDcJYzVQjBkVgnlH/aTDVqZwYug4e0yu7+oh4jX
         GCvmGg5OY4Kzlg6Z/C/lNzSQrEj7S/ViDEJ1XZezMYmGD/sIDQpQ6JpaMsP896sRy3p4
         m4zw==
X-Gm-Message-State: APjAAAWExsPzNvJPujt86RlA283KXmAB5DRLO/dvQFW6mn5iufcTD4Hu
        31kqzqTaMI4lkd1WopEx+dCIUjYyQyY=
X-Google-Smtp-Source: APXvYqxx8NlqxQmC3GLDH6pdTy0eKvURAxh2E7IeiSRXEHEMfzqm/MAA+tZWqERE5JHyUvPIEIebwA==
X-Received: by 2002:a17:90a:25a1:: with SMTP id k30mr8470670pje.9.1573684033400;
        Wed, 13 Nov 2019 14:27:13 -0800 (PST)
Received: from [192.168.1.182] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id k24sm4817495pfk.63.2019.11.13.14.27.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 14:27:12 -0800 (PST)
Subject: Re: [PATCH] io_uring: Fix getting file for timeout
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     io-uring@vger.kernel.org
References: <5b145d14-59e8-041e-9b8a-21ec1d71e082@gmail.com>
 <22C89598-0237-49ED-B020-9DD01D7EA31E@kernel.dk>
 <05f9e5fd-c60b-d483-381f-ad66cd3723e7@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2265e1a4-b0b0-49d5-3eff-c8d309031b89@kernel.dk>
Date:   Wed, 13 Nov 2019 15:27:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <05f9e5fd-c60b-d483-381f-ad66cd3723e7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/13/19 3:05 PM, Pavel Begunkov wrote:
> On 14/11/2019 00:54, Jens Axboe wrote:
>> On Nov 13, 2019, at 2:48 PM, Pavel Begunkov <asml.silence@gmail.com> wrote:
>>>
>>> ﻿On 14/11/2019 00:37, Jens Axboe wrote:
>>>>> On 11/13/19 2:33 PM, Jens Axboe wrote:
>>>>> On 11/13/19 2:11 PM, Pavel Begunkov wrote:
>>>>>> For timeout requests and bunch of others io_uring tries to grab a file
>>>>>> with specified fd, which is usually stdin/fd=0.
>>>>>> Update io_op_needs_file()
>>>>>
>>>>> Good catch, thanks, applied.
>>>>
>>>> Care to send one asap for 5.4 as well? It'd just be TIMEOUT for that
>>>> one, but we need it fixed there, too.
>>>>
>>> Sure, I'll split this into 2 incremental patches then
>>
>> Just one patch is fine, it’ll be a conflict anyway. So no point in doing two patches for 5.5.
>>
> Ahh, didn't see the message.
> 
> I assumed you would drop the first one, and apply new 2 without a
> conflict. Either way, just skip whatever you don't need

That's fine, I'm keeping the one I have for 5.5 but making sure
the commit message reflects what it does, right now they both
just say 'timeout' which is only correct for the 5.4 variant.

I applied the 5.4 one, thanks.

-- 
Jens Axboe

