Return-Path: <SRS0=hnZG=7V=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D98C433DF
	for <io-uring@archiver.kernel.org>; Mon,  8 Jun 2020 20:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEFF9206D5
	for <io-uring@archiver.kernel.org>; Mon,  8 Jun 2020 20:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="f7Ee9XLZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgFHUAN (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Mon, 8 Jun 2020 16:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgFHUAM (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Mon, 8 Jun 2020 16:00:12 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF177C08C5C2
        for <io-uring@vger.kernel.org>; Mon,  8 Jun 2020 13:00:12 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id a127so8995976pfa.12
        for <io-uring@vger.kernel.org>; Mon, 08 Jun 2020 13:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oOAfGaCLyEUmL6SML8rpJlmgZSVIZCkEfuNXlz3UUno=;
        b=f7Ee9XLZ/qoZncV84bKI+UlSMiA38ED5NpPzvnN/+cYHOas1fDpre0f9sncyvxVCkY
         YACG1gQ9hr6+aZYWwiQDRgkxzqpU6CPbTjnWXzdw4gSH84vVzB26LnbFzzBiUw7ppthP
         uvqq/+ixcFLYX/lhoJH+mlMrMY6fYycyB9DwWVA20a5Kwy9WOXCGdyzkD7eH548c/oTd
         qfyeb2eVASZ5IkbIeVzpCvd3L0kw0tc0wHdnfU5+ufhZ1XfoF1VJvwT69PcgkdUBu9Nc
         TS+6OerPHLNHfL/OwdJbCgexeHB1DnY72mO6Zt9a2KpIe/GtSn1uVfmb0nTcH3aM0tOz
         OcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oOAfGaCLyEUmL6SML8rpJlmgZSVIZCkEfuNXlz3UUno=;
        b=hKm/A+xU2DQosiB+M9VHPCd4XTIOqoZFX4DsEVYgcmX5IdpMWcDEUytMV3vSWmfqho
         1OSfpXQI5P3+4hKhHhFuWvbqn875TFgwDjS/2MgbOnrjxsnQkjZ9L966KEHn3OpG0Zo2
         3CcjNGOkpXvVh4/csIxCams+DQYAdbivwJp7GpeVldOt4Sf+CsEoTzdF3Gg43Zux7x1E
         sp2zntq9lB7OBRX2vOe5Ok+6RMVAMpp8ogpLAN6s7gAFH9pZkW2Ic1jH1wHZG2NICvjw
         Pjc3bS+hRK8Ux+v5oLZjRUGUjvvwwGItfk3ZF0y299F4MZiFDk++8wPXvRIM8gas0mFD
         fZsA==
X-Gm-Message-State: AOAM530LSr1/ICoRN7g3YdSxykxbxCXMfGyGPGB4apa0qQarLgiRlWTz
        cLKAoMdTkF9hSZ1uCCFZe+w4pg==
X-Google-Smtp-Source: ABdhPJzmO8ZaQECGWYliMy3c7Gp9GaQH545GdTTqpojLKX/I2fkL6+a3GH9HaonlYGo87d64G1nz3w==
X-Received: by 2002:a63:c407:: with SMTP id h7mr21097365pgd.174.1591646412020;
        Mon, 08 Jun 2020 13:00:12 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id x1sm7675474pfn.76.2020.06.08.13.00.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 13:00:11 -0700 (PDT)
Subject: Re: [PATCH 0/4] remove work.func
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     xiaoguang.wang@linux.alibaba.com
References: <cover.1591637070.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <8092bb08-a6ef-a1b1-31e9-5a545304460b@kernel.dk>
Date:   Mon, 8 Jun 2020 14:00:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <cover.1591637070.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 6/8/20 12:08 PM, Pavel Begunkov wrote:
> As discussed, removing ->func from io_wq_work and moving
> it into io-wq.
> 
> Pavel Begunkov (4):
>   io_uring: don't derive close state from ->func
>   io_uring: remove custom ->func handlers
>   io_uring: don't arm a timeout through work.func
>   io_wq: add per-wq work handler instead of per work

Thanks, this looks good and also nicely enable us to build on it to
eliminate that extra overhead. I have applied it for 5.8.

-- 
Jens Axboe

