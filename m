Return-Path: <SRS0=pC3Y=ZR=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD9DC43215
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 16:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147A02068E
	for <io-uring@archiver.kernel.org>; Mon, 25 Nov 2019 16:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hPowQ0tf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfKYQvz (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 25 Nov 2019 11:51:55 -0500
Received: from mail-il1-f181.google.com ([209.85.166.181]:39141 "EHLO
        mail-il1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728915AbfKYQvz (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 25 Nov 2019 11:51:55 -0500
Received: by mail-il1-f181.google.com with SMTP id a7so14802622ild.6
        for <io-uring@vger.kernel.org>; Mon, 25 Nov 2019 08:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=6YAdictTv78sv0smEqxdkP8f765s1GvJi2plN9HRZYs=;
        b=hPowQ0tfYCw2wGQNWn7dZXJtlBOB48RJ2KTWxGuKNLHBFBvdtPzmAS3HcqfEoIsyxc
         29B1U4YmhpFxOZUxc5WSC5+O+liZ6wLK1LYAYqPxhSZxoeEFPUgfEMmPamBO0YMHKhYD
         9smNHHQIw8KPlrZIgpAGQabwVtgnNgClWNX7DPXwPh5ye/kyoR5HnXvBb3B44rqqPGlI
         geAxiROMtKVzccUR8Vid80jxaF+xJET4HzzgVTvFQV3aYyw4JbRkKjUlxTyhH8NCYgD8
         68GIRCO1vr8A8IMxADO64E5Q7cOlzyIjsoF8P7caaOEZDaibSCyDdspbTIumAtYev06h
         PmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6YAdictTv78sv0smEqxdkP8f765s1GvJi2plN9HRZYs=;
        b=hzAW+hmBXzR+tgC9SpTcmcQbRsSy3naIvoDUebgeeHPs+fj0QSR58waXevQtEWHGp8
         2cprTtd25rskqWApvcGb4TtNAcZQcT7HgSa3TmBySg3tc+OY8TqLPNvfM16Y39sHgg0j
         Hs715V2tM60ecdFw9lG+Z8lIwFAqxGcl9JSK+fxiji6ZhWGK5ZDe+lnkjfnsdTJd1Kpm
         G/h+x/mNi6/k94qUG4fFCM+ff3t0XxmHcdTO1JMCcXyBTwCx2bl0GKLKmcisRxOvuEpN
         LUCXhvNfZW75vZ7xBdXZZlLNgnHGURsREgoikGJ75N4+5LEWZb3earQAFQmPgbT+zhDQ
         l5IQ==
X-Gm-Message-State: APjAAAXKDOVbQoufeF2XWi6lDP2Bv11Y8d+rdbZm3+V1in9PKieoKVmQ
        6OsEVJAIO5HWzPgoctpvwtHHulwj0PZTmg==
X-Google-Smtp-Source: APXvYqx8/QbjXOJCRRZop0QvksBFzDrywaIjamuvoa7yhBHVAgtvkuaJ4K4LXGPnh1KpGvyMDoAp5w==
X-Received: by 2002:a92:9f1c:: with SMTP id u28mr31600837ili.97.1574700712777;
        Mon, 25 Nov 2019 08:51:52 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o7sm1958032iob.70.2019.11.25.08.51.51
        for <io-uring@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Nov 2019 08:51:52 -0800 (PST)
Subject: Re: [PATCHSET 0/2] io_uring: ensure we inherit task creds
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
References: <20191125164818.16414-1-axboe@kernel.dk>
Message-ID: <5ab60ee2-e045-93aa-ab23-3090f2d21fbd@kernel.dk>
Date:   Mon, 25 Nov 2019 09:51:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191125164818.16414-1-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/25/19 9:48 AM, Jens Axboe wrote:
> As referenced in patch #2, fuse + fsync fails with aio because of the
> async punt of fsync not inheriting the original task creds. Apply the
> same sort of fix for io_uring, and apply it globally to all requests
> so we ensure we always present the rights creds when offloaded.
> 
>   fs/io-wq.c    | 24 ++++++++++++++++--------
>   fs/io-wq.h    | 13 ++++++++++---
>   fs/io_uring.c | 23 +++++++++++++++++++++--
>   3 files changed, 47 insertions(+), 13 deletions(-)

I'll resend this, by mistake a 5.4 backport also got included in this
series, should just be 5.5.

-- 
Jens Axboe

