Return-Path: <SRS0=S5qu=ZQ=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E96C432C0
	for <io-uring@archiver.kernel.org>; Sun, 24 Nov 2019 16:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B5A2075E
	for <io-uring@archiver.kernel.org>; Sun, 24 Nov 2019 16:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="OG+zch5Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfKXQmr (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sun, 24 Nov 2019 11:42:47 -0500
Received: from mail-pl1-f175.google.com ([209.85.214.175]:40990 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfKXQmr (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sun, 24 Nov 2019 11:42:47 -0500
Received: by mail-pl1-f175.google.com with SMTP id t8so5280780plr.8
        for <io-uring@vger.kernel.org>; Sun, 24 Nov 2019 08:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=df30z9YIGKLreBgBiGWjse9E1w2t3F+nB0DaUFK6wLM=;
        b=OG+zch5YiEt5kOPpFjAahRhJUnLqBDghFn89vyYiQsJY2+uiC9XbY2PlViJLXHORj6
         myMCrYPpck7WBfskfh7WNZOIxD4wkgaUBjMMPYimDDnGxuKCbdJUhUZG696y001Nd68T
         U8QFUDG32sMB4bnITLNwVusEzBN9OShVA4MkCRr68Xe01izLeFYEfzi1tq//GWD6s+3w
         LANXi+TLrLXiNoHQEt+4Jkprjuz7ecA+dRRIY/lM+ihGQcTHEeyLIv0QwzNWuxIpqkqe
         xzkmUjn1RpPlkyZ6bob21F2cTRRIOAAEm0ZMgglxH5gSn059fE3pvPeaNzxHbxQUBHqw
         qFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=df30z9YIGKLreBgBiGWjse9E1w2t3F+nB0DaUFK6wLM=;
        b=t7u1EHxYaCwKamGrlolELevsOgKGvq8qRdmE1PFA2bP7WKZcrY6ZxZ8VdOLuK2Ko67
         L2qRlxGBj/EqBOszEI25AHOu035uujVhp/NHTG4qFPHKMdqK7nSOb4XDdLi/0ZiBIWLR
         wxT270wcc30uQCp1bWdpTXuJQAsdhOfPSFmSnKLQPY+SDB5FGKZofVKmlBcrUPEhxg7b
         f2Gm4sHG3YzPRcSPchCAwOMExx8kKZRSmNN7DeDWtAbF04aw15m7yYe4ptYFCv9k68CD
         3jhk1a0urWfQ9x8Rrww3asoiis1YF81PFKdAfwfiJJDEBYRQWf+LxBJ2FhS1uBulyg/q
         +DUw==
X-Gm-Message-State: APjAAAXtKNKPE27HbcTtYQjPctrxNKQNqpp0iLXLAQTa8aI3fZ+BtTnS
        eygujM09gwVT2oO6XUg29zVtCMMoaEG1qA==
X-Google-Smtp-Source: APXvYqyDRtXq7YrBcYK+gi/80pAXE9YZfPQm0P33TTzeRmHeQLzpI10gSQHAz6Xhp+pa7cXiiIOM0A==
X-Received: by 2002:a17:902:70c1:: with SMTP id l1mr24615623plt.109.1574613764127;
        Sun, 24 Nov 2019 08:42:44 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id h195sm5280135pfe.88.2019.11.24.08.42.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Nov 2019 08:42:43 -0800 (PST)
Subject: Re: io_uring_prep_writev
To:     Mark Reed <mark@untilfluent.com>,
        io-uring <io-uring@vger.kernel.org>
References: <16e9e0c80e0.10e8cb6351147499.7149684061226631446@untilfluent.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <2f3dc6f4-4e0d-7ac3-1f50-41f9bc2f7f09@kernel.dk>
Date:   Sun, 24 Nov 2019 09:42:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <16e9e0c80e0.10e8cb6351147499.7149684061226631446@untilfluent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/24/19 8:34 AM, Mark Reed wrote:
> 
> Jens et al,
> 
> I wrote a C event loop library based on io_uring and a KV store
> similar to memcached using it.  Mrcache is 4x faster using io_uring vs
> epoll so thank you guys for the work on this. I'm looking forward to
> 5.5 and am testing on 5.2.14 right now.
> 
> https://github.com/MarkReedZ/mrloop
> https://github.com/MarkReedZ/mrcache

Nifty! Thanks for sharing.

> I'm currently using write instead of io_uring_prep_writev when writing
> to the socket and have a couple questions:
> 
> 1.  If I queue up 50 writevs to a socket will they write in order?

Since it's a ring, they will be consumed in order. But with async
execution etc, there's no guarantee that they end up being done in
order. If you have dependencies like that, you probably what to use
links (IOSQE_IO_LINK).

> 2.  If the client backs up will those writevs return or will they
> simply wait?

They will do they same as a regular writev() would do, there should be
no difference there.

> 3.  Would you expect io_uring_prep_writev to be faster than using
> write on the socket?  My initial benchmarks had a 50 deep GET pipeline
> which would do a single writev with 50 iovs and that was slower than
> copying to an output buffer and looping on write when full.  Perhaps I
> had something wrong with the benchmark at the time - if you think so
> I'll try again.

That result does sound a bit odd, but would probably need to take a
closer look to render any real opinion on that.

-- 
Jens Axboe

