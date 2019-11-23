Return-Path: <SRS0=JfP8=ZP=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50455C432C0
	for <io-uring@archiver.kernel.org>; Sat, 23 Nov 2019 22:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E38B2064B
	for <io-uring@archiver.kernel.org>; Sat, 23 Nov 2019 22:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="umVxDiOO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfKWWxg (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 23 Nov 2019 17:53:36 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35393 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfKWWxg (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 23 Nov 2019 17:53:36 -0500
Received: by mail-pj1-f67.google.com with SMTP id s8so4735171pji.2
        for <io-uring@vger.kernel.org>; Sat, 23 Nov 2019 14:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=jiZxXT1E7B694H4PHITbBBtth5SFMvT8DMla8FvvNB0=;
        b=umVxDiOOmmPEoOgWTWg1QoOxu19E7sTKKi+33E8Emw2dZn6iGsKfNCry/Zw8QIHptL
         15PPpIhzWvg6rmlWKH6b4GYv3/5G35C+BvLP8G5nbdbyrgqQ0bylQy0OgJir1TYBB59O
         q+mRHTFjk2btwCnbCnBc6VUsuxDdMkrV0Ki/EeT1f4eMQqEDVKeksZPfwNTZfQO9mB/m
         2wZQ9JBkmwh77pLzVojZ3nJuFWSfTElcyb9nOWnToaYjTQ8gDrSTYW7hPayC0Pil3EvQ
         JtkmgCkH4GyrfRYgIN34g11eq21o1BAWpXv6XQlinKvSJm8QEtTQIo1rySkCSiUEisEx
         +IdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jiZxXT1E7B694H4PHITbBBtth5SFMvT8DMla8FvvNB0=;
        b=ckymFS4Hx9ottatqWelhoDMZ1ldrIJqBkU8niYTcwdqAhd7dwuKEbH7t/kWes3qRZ9
         bJ3mpxCEs693ZJ+VKsQclMO3DnSjsjyYXJMgl8XlO5QAGaRbNHB2w2pOsIMBvO7u7wKk
         aQaRNtuJMqqqPFlewO+Y3KiWAXx5ppBeVt8ynt/lSDjKchxBSErL17jVCuxJg7lIKIvE
         5yCVZD2OJ4eUGd2LL8/Q54mQiIKbhcIhEMSQ+iGtCXjYqy2dpdeuMqDWKhUSCuQ5iOAk
         ETIOFYdhR0dZFZx0IdJO8d5gqOc6WF2vZifIPXyLhjrL6ZlWeVnm7drEoi2+68ZMLNzw
         M7yA==
X-Gm-Message-State: APjAAAUzEgNS9Lxy8oN6Y1lORLSTeVs5feC63dzPz5/e7mzQuprYvo6a
        sesf141tgZMWcqX1waxfeQFaaYk457T+lA==
X-Google-Smtp-Source: APXvYqwYFsut1/v433tkRVNruQFY4t555nHfg3f/OSMZ/46HCRHwCt0PhIncfrXZOSSQvu0jnNy3rQ==
X-Received: by 2002:a17:902:b945:: with SMTP id h5mr21442545pls.326.1574549615099;
        Sat, 23 Nov 2019 14:53:35 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id 21sm2776325pfy.67.2019.11.23.14.53.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Nov 2019 14:53:34 -0800 (PST)
Subject: Re: [RFC 0/2] fix in-kernel segfault
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
References: <cover.1574549055.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6627f75d-2b03-fc6f-997e-15e5700a642a@kernel.dk>
Date:   Sat, 23 Nov 2019 15:53:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <cover.1574549055.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/23/19 3:49 PM, Pavel Begunkov wrote:
> There is a bug hunging my system when run fixed-link with /dev/urandom
> instead of /dev/zero (see patch 1/2).
> 
> As for me, the easiest way to fix is to grab mm and use userspace
> address for this specific case (as it's done in patches). The other
> way is to kmap/vmap, but the first should be short-lived and the
> second needs mm anyway.
> 
> Ideas how to do it better way? Suggestions and corrections are welcome.
> 
> P.S. It seems for some reason it fails a bunch of unrelated tests,
> that's POC and not meant to be applied yet.

I'll take a look at this, but probably not until tomorrow afternoon
or Monday.

-- 
Jens Axboe

