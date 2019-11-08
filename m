Return-Path: <SRS0=cPsQ=ZA=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D9AC5DF60
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 14:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6824E214DB
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 14:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kDZtkLeB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfKHOjb (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 8 Nov 2019 09:39:31 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:44649 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfKHOjb (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 8 Nov 2019 09:39:31 -0500
Received: by mail-il1-f193.google.com with SMTP id i6so5302174ilr.11
        for <io-uring@vger.kernel.org>; Fri, 08 Nov 2019 06:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qyi7ViWRjPaat90ylQYSJbq1fLyIkQpqOzieSnrVaAE=;
        b=kDZtkLeBiBLzSLgI5AXQ8IO2uFBQZeFeBaMI8GulOLMKtC1ALgKR4/WS+qBWZJ0avf
         5zr0RwgBD/mjcoYnhOfmgjlThJwpkeY+EUN2FFH5v3PSda6BvpplofczPRftY6xIEhFN
         mwNB3+pddsNou6jb/+E9Vxm7kkZThWCZnuf5yPPZJXtXU/UQs7RqqhOpN1Y2HGlbiny6
         yn/QbsINNsMJ2wR0nlqm4pAfrkjsmLzaXE9DbJR0XnIGeXa+iLACp5wBEQfN9jVb0mrQ
         ETHeZjPPpgU08k1/O3gdqEmRadCR4HhLvXE0bakyvx6BF7wo8P4eFXFHvnHMjvhU7lCY
         iAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qyi7ViWRjPaat90ylQYSJbq1fLyIkQpqOzieSnrVaAE=;
        b=KhebAeqg9BXChb04Ed1j/za+5kSeEoWWAPquLiwRWwhf4RdF3ckAdMmGT7dkqgdPfr
         7FaDZWO7uRX2uWVV2fbJlgtyGXhdCEkc/lhxB/lggjMxWT5282Q5vX6U4szxF9rBpjCA
         KfzdZPPD8CLH5+GrfzS1T4OlHPkfwesckFlTIO8DZN7on7W3OlUxG6dx9lczN1DKDxzu
         hmEWreLwgcoZiNxHI2lfdw2V0T9NiLJ7BJ6MyAyhhk9tchA8FBbyl2cBz2y3HH48UbbG
         W/rMOqiV7hEIha16UHPZPkp/lM7lDmtuHi57kXtTHFw2hKHe7uuny5h2Ehu0HQoooX5v
         h+/Q==
X-Gm-Message-State: APjAAAV6j+VvsSUo9bdxQ6uslLjihkZiWKUgEYaiwDdHN731IzGdIaTe
        O6221dnqXADca3ULlCSyjcGDRQ61SJw=
X-Google-Smtp-Source: APXvYqzm/7aNe9fK/XJUz0yOF4CKdo46DOq6MfO7PQ+7qh4wVdmnMNdNtCty0RAEUzEkoA1GAl0reA==
X-Received: by 2002:a92:af19:: with SMTP id n25mr13771688ili.138.1573223969474;
        Fri, 08 Nov 2019 06:39:29 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id 133sm785790ila.25.2019.11.08.06.39.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 06:39:28 -0800 (PST)
Subject: Re: [PATCH v2] io_uring: reduced function parameter ctx if possible
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     io-uring@vger.kernel.org
References: <1573198177-177651-1-git-send-email-liuyun01@kylinos.cn>
 <5c685b0e-077a-9472-0f2b-982ecfffe9d9@kernel.dk>
 <6a0624b5-9348-769d-c7f5-1f9bd224a8ae@kernel.dk>
 <5dc57d18.1c69fb81.78a44.b83dSMTPIN_ADDED_BROKEN@mx.google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7035bfd7-2192-0da0-715c-b86f86c26953@kernel.dk>
Date:   Fri, 8 Nov 2019 07:39:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5dc57d18.1c69fb81.78a44.b83dSMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/8/19 7:33 AM, Jackie Liu wrote:
> 
> 
> 在 2019/11/8 22:16, Jens Axboe 写道:
>> On 11/8/19 7:11 AM, Jens Axboe wrote:
>>> On 11/8/19 12:29 AM, Jackie Liu wrote:
>>>> Many times, the core of the function is req, and req has already set
>>>> req->ctx at initialization time, so there is no need to pass in from
>>>> outside.
>>>>
>>>> Cleanup, no function change.
>>>
>>> I was curious if this patch netted us any improvements as well, but it
>>> actually blows up the text segment a lot on my laptop. Before the
>>> patch:
>>>
>>>       text	   data	    bss	    dec	    hex	filename
>>>      87504	  17588	    256	 105348	  19b84	fs/io_uring.o
>>>
>>> and after:
>>>
>>>       text	   data	    bss	    dec	    hex	filename
>>>      99098	  17876	    256	 117230	  1c9ee	fs/io_uring.o
>>>
>>> which seems really odd. I double checked just to be sure!
>>>
>>> axboe@x1:~ $ gcc --version
>>> gcc (Ubuntu 9.2.1-17ubuntu1~18.04.1) 9.2.1 20191102
>>
>> I took a look at the generated code, and it looks like it's just
>> enabling gcc to inline a lot more aggressively.
>>
> 
> Hum... I don't have a lot of attention to the size of the generated
> code, just to make the code look easier to understand. Will this affect
> performance?

Seems to be an extreme case on the laptop since I have various debug
options enabled for testing in qemu, but it's an increase on my
test box with gcc 7.2 as well. I don't think it's anything to worry
about, it's just inlining what it should inline. I did a quick perf
run and we're not down, so I'm going to apply this one as it cleans
up the code and that's always the most important.

-- 
Jens Axboe

