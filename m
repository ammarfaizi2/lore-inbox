Return-Path: <SRS0=cPsQ=ZA=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6647BFA372C
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 14:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3817E20679
	for <io-uring@archiver.kernel.org>; Fri,  8 Nov 2019 14:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="TA8wsZpS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbfKHOr6 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 8 Nov 2019 09:47:58 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:43412 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfKHOr5 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 8 Nov 2019 09:47:57 -0500
Received: by mail-il1-f193.google.com with SMTP id r9so5326092ilq.10
        for <io-uring@vger.kernel.org>; Fri, 08 Nov 2019 06:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nTL5amYmRsMSjTIu04RckLx0DIpLdXi24EpaCzT9e3U=;
        b=TA8wsZpSSLrTxJ95yPLGEUegdqMfBqv3N9kqAOXCpwMEaKGM2lJdtJnJFgecUErDeA
         V4L/qIW6i68ZilJFOdRWIDPxujSDp9myM/0vb/7xPCkfxZv0vGB51sZlSZJ48dvoBv6M
         8+21ClPTl3qu8Zah6NUTGwt3rVX06exBOUD3Q3Z7Kj1BkYzstiNbOv0YY7c7z+KtYQva
         qAvaORXrq0DuhZrhUx0MmUOjIiR01FZZUnGBClbWa3Q2Wlcj5LWCDhEqGkWaNyzOZyCg
         lEqjznNKYyWsZWhp7Ir2iTa57UbGp9c/JkUEOdk3lX6bBWSqncnzdjfQMNavdf4AiOOt
         cV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nTL5amYmRsMSjTIu04RckLx0DIpLdXi24EpaCzT9e3U=;
        b=kyU2kupP4XyALm9rFAKAmVnDI5K8VoTkJ/X5yK7H1M8bMXat1FfuhGgoxtRktPWqlN
         zdNNd2WQkFH7SU+abqBch4kPL7mMzziYehmSPJ1ZfM3uU/vrF1vkBCECaxxHRIvRJfKe
         K0Vp99J928J3DW4JCGeTjwta91v/DSMcNUqh2wKlEOhsERwTVqwdXyRhXNlypRIpi9qJ
         qiOfxqQzvGxb2Jq5UTAdB6NMI0CTi/7kQppZpTycYLikzrS9JVTqHoJKctJ61bWe2sRE
         9x00tSqumc7FCW9+PsLUI4zk/zmMSRUaPVO4R51ToXxe+hzjUzkI2/x+PI20FPEA/zlU
         Ogwg==
X-Gm-Message-State: APjAAAXATS4j1jmA56Yr07hTPh9wmh45n9UkJqsg1PAs7C4Vikl9TNmr
        +LRa2BV9mP99chFTQPAoFmVryVg6p/k=
X-Google-Smtp-Source: APXvYqz9Sqrn1+kUUzD7Ct98oUB6qD1Ivbn93YL+CBiSq5VXGEPFZkJdUu5Lwzm4Tch4vtf5ILSshQ==
X-Received: by 2002:a92:17ce:: with SMTP id 75mr12824954ilx.88.1573224475322;
        Fri, 08 Nov 2019 06:47:55 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m7sm484309ioc.75.2019.11.08.06.47.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 06:47:54 -0800 (PST)
Subject: Re: [PATCH v2] io_uring: reduced function parameter ctx if possible
To:     Jackie Liu <liuyun01@kylinos.cn>
Cc:     io-uring@vger.kernel.org
References: <1573198177-177651-1-git-send-email-liuyun01@kylinos.cn>
 <5c685b0e-077a-9472-0f2b-982ecfffe9d9@kernel.dk>
 <6a0624b5-9348-769d-c7f5-1f9bd224a8ae@kernel.dk>
 <5dc57d18.1c69fb81.78a44.b83dSMTPIN_ADDED_BROKEN@mx.google.com>
 <7035bfd7-2192-0da0-715c-b86f86c26953@kernel.dk>
 <5dc57f27.1c69fb81.27d15.ccf4SMTPIN_ADDED_BROKEN@mx.google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2d23521a-d9fa-8047-596e-55ef3676aaef@kernel.dk>
Date:   Fri, 8 Nov 2019 07:47:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <5dc57f27.1c69fb81.27d15.ccf4SMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/8/19 7:43 AM, Jackie Liu wrote:
> 
> 
> 在 2019/11/8 22:39, Jens Axboe 写道:
>> On 11/8/19 7:33 AM, Jackie Liu wrote:
>>>
>>>
>>> 在 2019/11/8 22:16, Jens Axboe 写道:
>>>> On 11/8/19 7:11 AM, Jens Axboe wrote:
>>>>> On 11/8/19 12:29 AM, Jackie Liu wrote:
>>>>>> Many times, the core of the function is req, and req has already set
>>>>>> req->ctx at initialization time, so there is no need to pass in from
>>>>>> outside.
>>>>>>
>>>>>> Cleanup, no function change.
>>>>>
>>>>> I was curious if this patch netted us any improvements as well, but it
>>>>> actually blows up the text segment a lot on my laptop. Before the
>>>>> patch:
>>>>>
>>>>>         text	   data	    bss	    dec	    hex	filename
>>>>>        87504	  17588	    256	 105348	  19b84	fs/io_uring.o
>>>>>
>>>>> and after:
>>>>>
>>>>>         text	   data	    bss	    dec	    hex	filename
>>>>>        99098	  17876	    256	 117230	  1c9ee	fs/io_uring.o
>>>>>
>>>>> which seems really odd. I double checked just to be sure!
>>>>>
>>>>> axboe@x1:~ $ gcc --version
>>>>> gcc (Ubuntu 9.2.1-17ubuntu1~18.04.1) 9.2.1 20191102
>>>>
>>>> I took a look at the generated code, and it looks like it's just
>>>> enabling gcc to inline a lot more aggressively.
>>>>
>>>
>>> Hum... I don't have a lot of attention to the size of the generated
>>> code, just to make the code look easier to understand. Will this affect
>>> performance?
>>
>> Seems to be an extreme case on the laptop since I have various debug
>> options enabled for testing in qemu, but it's an increase on my
>> test box with gcc 7.2 as well. I don't think it's anything to worry
>> about, it's just inlining what it should inline. I did a quick perf
>> run and we're not down, so I'm going to apply this one as it cleans
>> up the code and that's always the most important.
>>
> 
> Please wait a moment, I will send the third version, although this patch
> has not been modified, but there is a separate series of patches sent
> together, please reviewed them for me.

OK, will do.

-- 
Jens Axboe

