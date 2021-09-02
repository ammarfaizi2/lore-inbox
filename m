Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34615C432BE
	for <io-uring@archiver.kernel.org>; Thu,  2 Sep 2021 02:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10EF8610CC
	for <io-uring@archiver.kernel.org>; Thu,  2 Sep 2021 02:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243064AbhIBCm1 (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 1 Sep 2021 22:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbhIBCm1 (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 1 Sep 2021 22:42:27 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BC9C061575
        for <io-uring@vger.kernel.org>; Wed,  1 Sep 2021 19:41:29 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id z2so333806iln.0
        for <io-uring@vger.kernel.org>; Wed, 01 Sep 2021 19:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=2Z/61rddKOALqSmyi214lKgw583BGgGfhostANLM77s=;
        b=PpwDc1BIxkdIyJeJIpCniTAHXPA/SNHD0pDmZmGy9M+Hsid3Pkn09tgmv63L+suU2M
         Z/2UQj9yPLm7tiekcWdFyC/HW/Yp+R3nXF5IZjjm18XnPwriBOIDRDnGqhP2/1KnTHGs
         MRGBSCu4jw+gka2zkjrb3rcmy9l4XZUBubQyD/lzd1WRAfETaR7NtDT1x/ybd1WQHnlx
         j5cTQahvZrECfnQD819V2eYVUu3Gj5Mb21scDkzk2tL4Q5XYNu/BLMiQ/SzKf/C5fqln
         swHlwQ5MgWJ6wUQv4auCUXzkcwLs19ZKPb9UGU3XSccMEulNWdBHuynoJ+2A6elRs0do
         heZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2Z/61rddKOALqSmyi214lKgw583BGgGfhostANLM77s=;
        b=NFzp2AyvzjgNPS/w1izBfXrjK327Yus8BeIp+THOTp2cPcew4QoVd1avE+SUav6poN
         gOF2L7Bhr/ygDIbZ2+j1LqBAW1mqVI4sZI+F5TEXM95T7qQK3x2EVFdwd4dpxIAkP/U3
         AAdFt1UtSHXMs+ftmMJw+7hTJ+Qicvs6eRTbO7n3TVTSGusjFqSs4l/emgzSWR7HDo8r
         RVAwhI/vf9npEBdo5x4LrN0lD8hY+8vZg9g69gzMoDfPO0JdDFu15OYSykkw5Io4JGSI
         qiqR16VuBui2prZkEzxJpqcEUN2hAb6V9LEMH/sPCbgqhFeyZk+iI5pZLVGV8Q4N2Ji/
         rvRQ==
X-Gm-Message-State: AOAM531khuD4+ynu+iX3nk9gycqdgXEUZ5rFtvVwQUz28YeCi9Im8ZoO
        FqnhmULcW0GopecyeUOlsr4m0cZmldX2PA==
X-Google-Smtp-Source: ABdhPJx5K+3MUReaXVRQK5Bzl3Vb5gtKoBxlGAgfepS0cdNLabrDbDoEjjISIijsbJGhqUyMDTOmfg==
X-Received: by 2002:a92:c94e:: with SMTP id i14mr623907ilq.143.1630550489082;
        Wed, 01 Sep 2021 19:41:29 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id x13sm226729ilq.18.2021.09.01.19.41.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Sep 2021 19:41:28 -0700 (PDT)
Subject: Re: [PATCH 0/2] small optimisations
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
References: <cover.1630539342.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <bf7f5c4b-a8b6-60f6-0799-3218445f996c@kernel.dk>
Date:   Wed, 1 Sep 2021 20:41:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <cover.1630539342.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 9/1/21 5:38 PM, Pavel Begunkov wrote:
> I think it'd better to have at least the first patch in 5.15

Let's just shove both in, they are minor enough.

-- 
Jens Axboe

