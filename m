Return-Path: <SRS0=nqv2=Y7=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8968CFC6194
	for <io-uring@archiver.kernel.org>; Thu,  7 Nov 2019 00:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD85217F5
	for <io-uring@archiver.kernel.org>; Thu,  7 Nov 2019 00:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BGAcJgjX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfKGADa (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 6 Nov 2019 19:03:30 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36664 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbfKGAD3 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 6 Nov 2019 19:03:29 -0500
Received: by mail-pl1-f194.google.com with SMTP id g9so63102plp.3
        for <io-uring@vger.kernel.org>; Wed, 06 Nov 2019 16:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EfTV2nySn0dQPWozz7DdsL1TBah2KOE2tXIoG8Pilcc=;
        b=BGAcJgjXjoD4bAZ8+lB6h8NvA1ryVhNkACK06MW8wQLqZPKizO1Y75L82a9osZ2yjl
         7He5bgZG9bAm0M5Gcck9/ETWCCi/LK+ZaM5A3XQCSF7URdxflS9ldYzP9HfLzuifLbq5
         Tv3ZMVOPkqryujQx5isvZ/pIsveFFG4NNHTcJb5JIOGzaDJcx4ekTVZynQhhBZLHN6Gv
         MUDCW0QxLyxb2WDM7Z0VZXJ8opexZG0CoZBcgzBIF53YA4fgc0LJBX2ObB0lc9xN1emf
         uMOqyXH9vQRC05PjcAAJnXEWz5pje3+n4f897sE+bnB3yTfCJCDgm+ZKU1p6ZK/QaUqP
         kt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EfTV2nySn0dQPWozz7DdsL1TBah2KOE2tXIoG8Pilcc=;
        b=g+nCDTd8sCwopspEjScddyfch/8J+2dI/aURTre3mMFWNbj90YgQUr4ha9hFDN0VZ7
         brf0ztSwNVr2vIbUq+zYgVlNNEQGMX9To7Hu6EDslWAN/U+4s9fLgF7uEyFXJbUR9P5N
         SwepceRZrgbdQu3BDlOKbihw557u0KP3U1P93cbhmqHlyTZLMDHPjo8BbpzXI3wYDlJD
         dW3idnSFlORjVVW/FNjEMWFrAFu56XGrxHx79lxX7KW+F6KBK9ltdLBQI3MSK8mihqgY
         vjm19E7fO2dt0zLk3PhCpVy9daE1jcn4zQYmub3Phs+llnsFTGRzpriSPeTwQxpq4jtr
         C/dw==
X-Gm-Message-State: APjAAAUO1nNQY3KZ3+WC+wM3bO9k7tW4J44xM9bqEaS/ll5OjfmtwAm2
        ZHsXsW9AoWRvNkVSKkq7Preo/Q==
X-Google-Smtp-Source: APXvYqy25sg+zACyp9THYGNHjSseAa1a+UNtF79RWGlQVhbNMOVRvwI44b5ml6JBe5k4EOz8NdiRJw==
X-Received: by 2002:a17:902:6b88:: with SMTP id p8mr382705plk.336.1573085007445;
        Wed, 06 Nov 2019 16:03:27 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id r184sm123049pfc.106.2019.11.06.16.03.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 16:03:26 -0800 (PST)
Subject: Re: [PATCH] io_uring: fixup a few spots where link failure isn't
 flagged
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <b10f96d7-ecc4-e835-555e-739f22d3e505@kernel.dk>
 <ee474592-8e97-eb11-0f95-84607bed033d@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <29607ed7-a8a5-0208-b50a-f9feabcaa7fb@kernel.dk>
Date:   Wed, 6 Nov 2019 17:03:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ee474592-8e97-eb11-0f95-84607bed033d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/6/19 11:44 AM, Pavel Begunkov wrote:
> On 06/11/2019 06:32, Jens Axboe wrote:
>> If a request fails, we need to ensure we set REQ_F_FAIL_LINK on it if
>> REQ_F_LINK is set. Any failure in the chain should break the chain.
>>
>> We were missing a few spots where this should be done. It might be nice
>> to generalize this somewhat at some point, as long as we factor in the
>> fact that failure looks different for each request type.
>>
> 
> The completion path also starts to get complicated, especially
> non-uniform handling of links there.
> 
> i.e. io_put_req() -> io_put_req_find_next() ->
> 	io_free_req() -> __io_free_req()
> Plus, io_free_req_many(), which can be used only in some cases.

The many case is just for polling, I actually think that one is pretty
clean and self explanatory. But I agree on the proliferation of them
otherwise, at least the patches today cleaned it up a little.
 
> My compiler didn't even inlined it, so there are 4 CALLs.
> Though, still in TODO list.

Huh, that's odd!

-- 
Jens Axboe

