Return-Path: <SRS0=PUae=Y6=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664A6FC6194
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 22:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B3B217D7
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 22:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zVJQE8iQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfKFWrT (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 6 Nov 2019 17:47:19 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:46076 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbfKFWrS (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 6 Nov 2019 17:47:18 -0500
Received: by mail-il1-f193.google.com with SMTP id o18so11077273ils.12
        for <io-uring@vger.kernel.org>; Wed, 06 Nov 2019 14:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=H1aaCpP9OlAmaxxqu9H6y46feF/NAefAvferbzr7zCM=;
        b=zVJQE8iQkAv6wOotaD8OxnutkloaI40iV6xJJgLgY8JXxfvjHOdsC66k2jWNCPslub
         nS39zPh4KElQDdogTsS6pndP9HaZGBAkvBh23zRQpYirote3wX/ctzILIHb0VMnx3Bra
         MOQBJ8nByFxM3Yp6Qa9YaWdQgyknFLZkkCk2GNAwxQ3bMSY70qOrNpT2EhQO6K1Bd8T1
         NWPd/ovaBB9yjKtlHvQJQ2ObQ26CYIYGyfopGEe0Y+ni+UZIIcEFfBMwS5d87TaQoLE7
         0MId5RleDnaov1lTblCgXDZ9xUK0nDPSOwsBMrjYGRDHpag7whOD8yBHYSUOleZjLLCD
         Jl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H1aaCpP9OlAmaxxqu9H6y46feF/NAefAvferbzr7zCM=;
        b=CJY5H/8H3SBRlkvvsMKtmOrkpWiXVcKt0XSH0lOHjvNXTvNdk9LtYJtD/waFmLW1Yt
         ezvsb7SGceXXVpSzE7Pkrk5PKHkbKRKAcm5O2ZZKpKmTjKYsWO70E1jn/qOeYR99ieTm
         xtpyh7SscpIQKmx5fYAA0gTsw7IeNyM+lwC50WPQPTqSxnTHkvqCF36SMABtK2jDZD3e
         yv3b6osEBm/4Q0blLZPft32TZwMEM07Pdeblpem4xJI2EaODAkzXLE3rwgKPpmaCVFK0
         w9XwcbPFISGGXUk46OyIlT+/lY7RQx4cR+uIXvl5guNQVal//qv2tr3ttg+7JoiNSed0
         /UCw==
X-Gm-Message-State: APjAAAVhDqtB+URA4yc9rFfWYaMmssKueMt/Z/WLrk0wZUqI98nCOkLH
        lWNn1uDDoNpEQp3Fvf6IBYHOog==
X-Google-Smtp-Source: APXvYqy4RfqiV4GNOhb33unylJwViAvUPRgWjrCTO0BEanJB/l65Il/9sXEGhZHyL74sMwgomBsJLg==
X-Received: by 2002:a92:100a:: with SMTP id y10mr297735ill.170.1573080436391;
        Wed, 06 Nov 2019 14:47:16 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id e13sm10653iom.50.2019.11.06.14.47.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 14:47:15 -0800 (PST)
Subject: Re: [PATCH v3 0/3] Inline sqe_submit
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org
References: <cover.1573079844.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <6b571653-4ae1-a5cf-49a9-5ee5e1e5caa5@kernel.dk>
Date:   Wed, 6 Nov 2019 15:47:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <cover.1573079844.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/6/19 3:41 PM, Pavel Begunkov wrote:
> The idea is to not pass struct sqe_submit as a separate entity,
> but always use req->submit instead, so there will be less stuff to
> care about.
> 
> Also, I've got steady +1% throughput improvement for nop tests.
> Though, it's highly system-dependent, and I wouldn't count on it.
> 
> v2: fix use-after-free catched by Jens
> 
> v3: -EAGAIN, in case submission failed
> 
> Pavel Begunkov (3):
>    io_uring: allocate io_kiocb upfront
>    io_uring: Use submit info inlined into req
>    io_uring: use inlined struct sqe_submit
> 
>   fs/io_uring.c | 134 +++++++++++++++++++++++++-------------------------
>   1 file changed, 67 insertions(+), 67 deletions(-)

This looks good to me now, thanks! Applied.

-- 
Jens Axboe

