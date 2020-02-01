Return-Path: <SRS0=qhL4=3V=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2BAC33CB3
	for <io-uring@archiver.kernel.org>; Sat,  1 Feb 2020 16:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8FA206D3
	for <io-uring@archiver.kernel.org>; Sat,  1 Feb 2020 16:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="yB4T4q+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgBAQ2n (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Sat, 1 Feb 2020 11:28:43 -0500
Received: from mail-pj1-f41.google.com ([209.85.216.41]:39860 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbgBAQ2m (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Sat, 1 Feb 2020 11:28:42 -0500
Received: by mail-pj1-f41.google.com with SMTP id e9so4398860pjr.4
        for <io-uring@vger.kernel.org>; Sat, 01 Feb 2020 08:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=mklDpQSOx56X51WlKAqZtd/5MRjLcpIQ1Es0sl44ojw=;
        b=yB4T4q+3CDaLF5gscpyaw7VYcN/mkrBVX/QUVuJUuq5NgF7YDZ6B9YyskYhdsQTy3Y
         Q/+D8IPZQMwTQ3WPcOttfsUiaq5IPmRoBjVyM20ycxSsu+jYBd/E4wAj5RpeC//j5RYO
         HRw/YUK6w39O3os/xVXdU56+QZzRONXEyVksu/YBNfzyqFZ8+lhCxfPQmcMiRHOKxdql
         XxzcV7ZpCwtFE600P3319Nw0SdhrnZikoftK8l4eGL4xcpI5/Q/iOG14reK0/NYnyruE
         qGFIoNGm9FjmAInisKQlxgaEUOzDlugnqW5G4GbowI+ujF9ZhVIvq2WFKlVWnmQOWO6h
         2pOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mklDpQSOx56X51WlKAqZtd/5MRjLcpIQ1Es0sl44ojw=;
        b=Xlv4bY+gp9s+6mk7yqF4MSL7nlyeksJZgxbUNzSjlAeomchR02wE0uCG0VvJxmLEyc
         GuKGwWIVARfKO01ruCZPTE7IfEbUqBhp9HA2xArOv+aOgatiIItf9zt1UDAqfITioPQF
         xdzyCO8YlyosH7jWMFktWKdOPmwkRiykJ5/WwMSQog8OcTVXKmvW81NTzUB8I/M2xODt
         Ps9ZThmLhDoojiWTljEnDVfoFFsnqoe7wRDm6IjKWjnZm7VlZK/kBmmZu7s+wAZ822uR
         g6l4iftpXiJJLk7j0mwtaxWIwRi0I46isYDfqRViHfzll0hVm8+F7b05LGNitnUrFzXf
         BBmQ==
X-Gm-Message-State: APjAAAWMlAT4+QyOaMEoxrEx9IVsw/wXztXyI3JiccnmwzQZGLOmoYa1
        K8oaiVlS1h0WpRI7kUvU2sWtjQ==
X-Google-Smtp-Source: APXvYqw/QG5gDF0pKFlbvpJQEm36bImGmIPJu96GNWoWMb+fe9yK00CFpy7m5H7D3TUwi+iTfcoHpw==
X-Received: by 2002:a17:902:968c:: with SMTP id n12mr15906957plp.144.1580574522316;
        Sat, 01 Feb 2020 08:28:42 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id v4sm15364475pgo.63.2020.02.01.08.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2020 08:28:41 -0800 (PST)
Subject: Re: [PATCH 1/1] io_uring: place close flag changing code
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <aebc542fb8d3625178fa02c6a8c6a5b2b89466c4.1580518533.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9dd02612-5c5b-9508-d7cd-39212d526e14@kernel.dk>
Date:   Sat, 1 Feb 2020 09:28:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <aebc542fb8d3625178fa02c6a8c6a5b2b89466c4.1580518533.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 1/31/20 5:58 PM, Pavel Begunkov wrote:
> Both iocb_flags() and kiocb_set_rw_flags() are inline and modify
> kiocb->ki_flags. Place them close, so they can be potentially better
> optimised.

Applied, thanks.

-- 
Jens Axboe

