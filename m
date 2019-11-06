Return-Path: <SRS0=PUae=Y6=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231A2C5DF64
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 14:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B5D2067B
	for <io-uring@archiver.kernel.org>; Wed,  6 Nov 2019 14:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="drMejIE+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731910AbfKFOKF (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 6 Nov 2019 09:10:05 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:34108 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727958AbfKFOKF (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 6 Nov 2019 09:10:05 -0500
Received: by mail-io1-f68.google.com with SMTP id q83so5899058iod.1
        for <io-uring@vger.kernel.org>; Wed, 06 Nov 2019 06:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=3wrtEF/Rzlh75tZwEt9oiPqiKdXJjmpMQ9Y7AZzRq0Q=;
        b=drMejIE+n44EQB/7Y8f0aFSCwCUnxKnblRpdGjLXV9d/F0RagTG1Q/2EfJL91/9e71
         3buO3nJeh37HEJZDuQNuu2tOgGj9y/jAEcWJ63i7mK5myctJnWHq9Cuelez2yOBtXvkl
         RsdXm1PxJ6PanTxZR+kZQ5x49lx4jkMAd0AXg+t/tRc3dN6r7xrQQhq2nj7HcEhGzFKN
         eUm5FHQ8FE7ewHnRkjt8LpD35sb48jCaSlqKu3Ed9BD2SFT312otwLgVf5wzbyOLMGWh
         dGyJRDsWKYs0LxDrYydIoUbfQFyrrqti2CysKVWTuESSapkMBTyqdDJ4Zoy6ITJDE5P3
         Y1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3wrtEF/Rzlh75tZwEt9oiPqiKdXJjmpMQ9Y7AZzRq0Q=;
        b=HfGh7Agw0TxUKrCmub8od3yBhGjfnSBuhl6HQeJCFMXVstVXrsqtmv9YCfbAt+zNzs
         I0p88mSqLHLfU9FsNwP46md85zg48m4fWhSWbvwi9lt1cMzdczFaB5ZO+4G8bbIYYZqZ
         5NBmL9GZsADri+w4FuA9PfwquhqmF40nmlvIkzH3qi05t/aRVvS2/9WWAeori30W4mq/
         XlwMimdp/un/DZ2EyI0yr6b5nJ7tcVxr5AY0MKdLT7POClCCpjnWiBJ3+CiOixCArc/t
         S+iZwAbDA7RE7WEnX5Tr8V1qcx2VdkYBqgE8JE3IPCw4IYl3OALMYjINRbhTNxLGk6/c
         xr+A==
X-Gm-Message-State: APjAAAVeMML+ADBWOerHDd2kRB4nClclE3QptXKb4U1I94iOJ+qM1k/T
        dTG7AE0/+DfTZfyyYj2jSPjX/g==
X-Google-Smtp-Source: APXvYqzu6A1QOsFkaiXnwKhhauiHvp45yIxCn7YcXr9lkZvvYsm7nX83dqhE4BkhYs4Ixy7Te3y/oQ==
X-Received: by 2002:a6b:f306:: with SMTP id m6mr2378847ioh.172.1573049403353;
        Wed, 06 Nov 2019 06:10:03 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id r17sm3544372ill.19.2019.11.06.06.10.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 06:10:02 -0800 (PST)
Subject: Re: [PATCH v2 0/2] cleanup of submission path
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1572988512.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9456fb9c-956d-62da-807c-498d2885f968@kernel.dk>
Date:   Wed, 6 Nov 2019 07:10:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <cover.1572988512.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/5/19 2:22 PM, Pavel Begunkov wrote:
> A minor cleanup of io_submit_sqes() and io_ring_submit().
> 
> v2: rebased
>      move io_queue_link_head()
> 
> Pavel Begunkov (2):
>    io_uring: Merge io_submit_sqes and io_ring_submit
>    io_uring: io_queue_link*() right after submit
> 
>   fs/io_uring.c | 110 +++++++++++++-------------------------------------
>   1 file changed, 28 insertions(+), 82 deletions(-)

Applied this series, thanks Pavel.

-- 
Jens Axboe

