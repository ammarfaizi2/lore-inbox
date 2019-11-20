Return-Path: <SRS0=jdTg=ZM=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2009FC432C0
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 20:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC7982075E
	for <io-uring@archiver.kernel.org>; Wed, 20 Nov 2019 20:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="f8G6wYS7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfKTULF (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 20 Nov 2019 15:11:05 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:40973 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfKTULF (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 20 Nov 2019 15:11:05 -0500
Received: by mail-io1-f66.google.com with SMTP id r144so617174iod.8
        for <io-uring@vger.kernel.org>; Wed, 20 Nov 2019 12:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Nt2uK4ZdKX4za/Z0SkNF3sZurJVmnqnZFMyu8q36wko=;
        b=f8G6wYS775czTTYjmq12AT6yS4+7SRdjkEfE17a+pkIULBDyAamOhb7azO9rgx2Ygy
         VlED9hP0L/teC82PGz5cqziK3pE9XzxhUtaSePVlJPFaXeJmvj8L0Nu/nzWLQIFVObJW
         HVOteb8vwkEh+L++QA51DVzEnh7pc0HaYLDVg5UJ5qmuxzLvr5PkSPko2v/Pl1RSTAdH
         3GeCKxIFuki1Ak/GVC3QvIOhH9QsJ+J1KUH578jgfk3u633/YvWceQS9usOOXy/FR/+z
         i1bM6VNd08HGgYx0LJj0Ojv2DDLu5hMGsmSyyUgIkPifgp+PXOrnTe5kRrDpr9Ff+QGA
         A+rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nt2uK4ZdKX4za/Z0SkNF3sZurJVmnqnZFMyu8q36wko=;
        b=ah0xWX3v5yAiM7+GwBNjLHjAdfjb8BJ77Yvj0Mxxl3vICMiledJazMndCnyE4zzz3Q
         Hr/GaarQLbMnE7vKieO9It3S6DNN+RlFHMCn7J4ml3Qyqm7X70T6yROEdj2E7eLOcRtd
         bGMcazN0kFRexHkVVgP10hwFaXJ7ZFg7MHSJscxBKFTSWbDWdyERYj6OBf7AudDA47rO
         zuLfwdErq90cR0g4VlAakAZjoAc6R3tAZeakKNzSqIOUX8lyrriqT2rEsj3UggLD/6mE
         KeWcJCVkSGzd+ODSbrgRKUL4sgl60iMfdtSf12TJHho2HOrahojoHnn6gxsuQFl+JRV1
         2rUg==
X-Gm-Message-State: APjAAAWRgjuXGMY5vfDGMm6E3gLq3KI969DunUioFkAbOvNruXwe0oGB
        Fu0VQVtGYR5zlYkExpEBnDEvaQ==
X-Google-Smtp-Source: APXvYqxP/mEWBunldzbCY8XQrcrG4DVRyFE5J0gaj1xMk1IsAv1oF9lmfAzk8Mte8n2YFcE8PDIpIA==
X-Received: by 2002:a6b:7e0b:: with SMTP id i11mr3807933iom.245.1574280662990;
        Wed, 20 Nov 2019 12:11:02 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p19sm56245ili.56.2019.11.20.12.11.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Nov 2019 12:11:02 -0800 (PST)
Subject: Re: [PATCHSET 0/2] io_uring: close lookup gap for dependent work
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     asml.silence@gmail.com
References: <20191120200936.22588-1-axboe@kernel.dk>
Message-ID: <92ff0dc9-b652-d9e5-e4c8-20d7ea4e7a9e@kernel.dk>
Date:   Wed, 20 Nov 2019 13:11:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191120200936.22588-1-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/20/19 1:09 PM, Jens Axboe wrote:
> As discussed earlier today on this list, there's a gap between finding
> dependent work and ensuring we can look it up for cancellation purposes.
> On top of that, we also currently NEVER find dependent work due to how
> we do lookups of it, so that is fixed in patch 1 while patch 2
> implements the fix for the lookup gap.
> 
> Patches are against for-5.5/io_uring-post
> 
>   fs/io-wq.c    |  3 +++
>   fs/io-wq.h    | 12 +++++++++++-
>   fs/io_uring.c | 34 +++++++++++++++++++++++++++-------
>   3 files changed, 41 insertions(+), 8 deletions(-)

Gah, disregard this posting, there were older patches in that dir too.
Re-sending a correct one.

-- 
Jens Axboe

