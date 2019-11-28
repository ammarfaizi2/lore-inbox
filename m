Return-Path: <SRS0=GIeg=ZU=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0B9C432C0
	for <io-uring@archiver.kernel.org>; Thu, 28 Nov 2019 09:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 570AE2176D
	for <io-uring@archiver.kernel.org>; Thu, 28 Nov 2019 09:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="G6glzc+N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfK1JCs (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 28 Nov 2019 04:02:48 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37743 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfK1JCs (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 28 Nov 2019 04:02:48 -0500
Received: by mail-lj1-f194.google.com with SMTP id u17so242964lja.4
        for <io-uring@vger.kernel.org>; Thu, 28 Nov 2019 01:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=J0ArWTMK2M2cZ2zXfxSef0laglMj50lskLz/N/COoyI=;
        b=G6glzc+N9b1z4gASSZC5AEd2jFJOL3n0eIWVnAe5AFj6b9KL8p9l0fGtPjZWwqloVc
         MbFAw7gXgY7/o9XSopUwxaWCYsOW18S4HjAnf9itzbbDFUaNMz31hPcYOSVv9JEZ7K8h
         ktQw5DrGfazKfaU1IQ6XlCNocKnC3bQUx4EY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=J0ArWTMK2M2cZ2zXfxSef0laglMj50lskLz/N/COoyI=;
        b=bEuVnhTv6Tc2Kmpn7RCtq7iH6h6WhPgGZxlAl8vc6FIS6mNkIHRX5Xgkokvcnzxspq
         7xDCC7mwcHkgM5sEC8pBiZhYlFiuPiBlqoZnJs1V2qhBlSNjT/c7RWTotYEQRFsw6vL/
         K8MXStQs9+XH3aNa14uGbngSoTJfRLAbT300ozK7vSGYFjGAGoWZxJqVnYC0m4YnxNcR
         adwkR37hJEnRVDP06smR2HuuajmKhJ+YrW0S6Ves0jGltN7gUIc7WpLtTqc9jXpDQISz
         HWCEfJA6WKTQLGGWOV9KqAvmxu0jp8cWkh1gin1KQQOGxRrCtPE7nOBRlzHWVKfvXz5e
         ds6g==
X-Gm-Message-State: APjAAAUonWOaqdrqPaDe1gPT6slTMu+hxE9VuVfa2YsXPb3VnAaR70WS
        gKgEypZGwsVVQkY6dopp2CXhqg==
X-Google-Smtp-Source: APXvYqzK+0aH2OxqnNebVIbBxsAx+sVVUV5///KJSvWtCfimRUSUBpmooYcKVoc1aZPo9aQXeAPhvA==
X-Received: by 2002:a2e:9a12:: with SMTP id o18mr33630972lji.191.1574931766022;
        Thu, 28 Nov 2019 01:02:46 -0800 (PST)
Received: from [172.16.11.28] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id r125sm8265681lff.59.2019.11.28.01.02.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Nov 2019 01:02:45 -0800 (PST)
Subject: Re: [PATCH RFC] signalfd: add support for SFD_TASK
To:     Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>
Cc:     io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <254505c9-2b76-ebeb-306c-02aaf1704b88@kernel.dk>
 <CAG48ez33ewwQB26cag+HhjbgGfQCdOLt6CvfmV1A5daCJoXiZQ@mail.gmail.com>
 <1d3a458a-fa79-5e33-b5ce-b473122f6d1a@kernel.dk>
 <CAG48ez2VBS4bVJqdCU9cUhYePYCiUURvXZWneBx2KGkg3L9d4g@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <f4144a96-58ef-fba7-79f0-e5178147b6bb@rasmusvillemoes.dk>
Date:   Thu, 28 Nov 2019 10:02:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez2VBS4bVJqdCU9cUhYePYCiUURvXZWneBx2KGkg3L9d4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 28/11/2019 00.27, Jann Horn wrote:

> One more thing, though: We'll have to figure out some way to
> invalidate the fd when the target goes through execve(), in particular
> if it's a setuid execution. Otherwise we'll be able to just steal
> signals that were intended for the other task, that's probably not
> good.
> 
> So we should:
>  a) prevent using ->wait() on an old signalfd once the task has gone
> through execve()
>  b) kick off all existing waiters
>  c) most importantly, prevent ->read() on an old signalfd once the
> task has gone through execve()
> 
> We probably want to avoid using the cred_guard_mutex here, since it is
> quite broad and has some deadlocking issues; it might make sense to
> put the update of ->self_exec_id in fs/exec.c under something like the
> siglock,

What prevents one from exec'ing a trivial helper 2^32-1 times before
exec'ing into the victim binary?

Rasmus
