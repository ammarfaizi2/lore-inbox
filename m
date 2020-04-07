Return-Path: <SRS0=kClH=5X=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF305C2D0EC
	for <io-uring@archiver.kernel.org>; Tue,  7 Apr 2020 22:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A89F6206C0
	for <io-uring@archiver.kernel.org>; Tue,  7 Apr 2020 22:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="w2Y5L5j3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgDGWEd (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 7 Apr 2020 18:04:33 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33838 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgDGWEd (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 7 Apr 2020 18:04:33 -0400
Received: by mail-pf1-f194.google.com with SMTP id v23so2084324pfm.1
        for <io-uring@vger.kernel.org>; Tue, 07 Apr 2020 15:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zGNyGCQzwewKS9B0wqSZYVQ5j9Z5+W9C/ZvjsyYyPY8=;
        b=w2Y5L5j3rfIRkUZfj+5+qtpEHdecipu7yG+NeSWyIXGn9dGt4EmHnRKvbcQzlNO+d/
         yquZWELyxsJif0RqMqg+I76vRuSFIBoKP9yafxdT2ubY073HsrA62EUv1/QkHkuvCB25
         DiADXtGQmokp6kgbA+Ot0DpMQ8fzVNs+hTcJR3Fml4w7jCAI11DAIJTGaq+NzyvIhO2W
         GCviRNSeSEMohQw9b0lIK+t4nzNvpA0ebS7+4gcPo2TvxjSrcMh/L/FuRJISy64N0nrU
         SLz6k8sa5NSkyAaJb0CZa08D3jAcvjuHw3fO8EPZmFtdBLiIrlIxM++9z5J0bDexNC24
         4RoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zGNyGCQzwewKS9B0wqSZYVQ5j9Z5+W9C/ZvjsyYyPY8=;
        b=OWFR7OsEAOPNVVr+Xj5qsaaPOGzV+toO1NRImDlXjs5d4LkBfZ3xQqgRMsjWS0YJmr
         6ILF50BLoZ1iAmloHlOPfchZn3UGfrX7sBTDoUuSsJodvNq+whxDL6HgrqliI89oY9e3
         MJzHsJXI7e31pdyX8sH61eOUGe9Cn9alE/2V2f5H4A5SGXkwb52umd3o2TuMjvExS2O2
         A1/nDW+Uj3pk9hrBSUN2zloJMFetODxI1gT+oGBh24x6DjBsCJE1PdZsAmtJfg9a9/OP
         Xv/p9HQucaq+hIpvTNCY/t5K7yKhkdn7UmX+IIfr5JLj+tFt3QD1b6AUrPmfkKIBNQo9
         sMHQ==
X-Gm-Message-State: AGi0Pubg//4U9rsXm/sGoiMQ3XV/0tsMys9SzOD0Ev4Zq8xrbnc2/+pP
        aQO4T63x8kkFpgbqzHGUElcd0k4waarM6Q==
X-Google-Smtp-Source: APiQypIxFPaKBTpUoBsmn5LGzBcT9VM5IStfJQ0hrpaik8cQlJ3XQATIYbXSbU2Dr0qyhMyEUIylng==
X-Received: by 2002:a63:f13:: with SMTP id e19mr3894574pgl.135.1586297072469;
        Tue, 07 Apr 2020 15:04:32 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:ec7d:96d3:6e2d:dcab? ([2605:e000:100e:8c61:ec7d:96d3:6e2d:dcab])
        by smtp.gmail.com with ESMTPSA id c14sm2030028pgi.54.2020.04.07.15.04.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 15:04:31 -0700 (PDT)
Subject: Re: [PATCH] io_uring:IORING_SETUP_SQPOLL don't need to enter
 io_cqring_wait
To:     wu860403@gmail.com, io-uring@vger.kernel.org
Cc:     Liming Wu <19092205@suning.com>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
References: <1586249075-14649-1-git-send-email-wu860403@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b50140b3-d5a7-ed5e-434c-6bf004a4869d@kernel.dk>
Date:   Tue, 7 Apr 2020 15:04:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1586249075-14649-1-git-send-email-wu860403@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 4/7/20 1:44 AM, wu860403@gmail.com wrote:
> From: Liming Wu <19092205@suning.com>
> 
> When SETUP_IOPOLL and SETUP_SQPOLL are both enabled, app don't
> need to enter io_cqring_wait too. If I misunderstand, please give
> me some advise.

The logic should be as follows:

flags			method
---------------------------------------------
0			io_cqring_wait()
IOPOLL			io_iopoll_check()
IOPOLL | SQPOLL		io_cqring_wait()
SQPOLL			io_cqring_wait()

The reasoning being that we do want to enter cqring_wait() for SQPOLL,
as the application may want to wait for completions. Even with IOPOLL
set. As far as I can tell, the current code is correct, as long as we
know SQPOLL will always poll for events for us.

So I'm curious why you think your patch is needed? Leaving it below and
CC'ing Xiaoguang, who made the most recent change, so he can comment.

> Signed-off-by Liming Wu <19092205@suning.com>
> ---
>  io_uring.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/io_uring.c b/io_uring.c
> index b12d33b..36e884f 100644
> --- a/io_uring.c
> +++ b/io_uring.c
> @@ -7418,11 +7418,12 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
>  		 * polling again, they can rely on io_sq_thread to do polling
>  		 * work, which can reduce cpu usage and uring_lock contention.
>  		 */
> -		if (ctx->flags & IORING_SETUP_IOPOLL &&
> -		    !(ctx->flags & IORING_SETUP_SQPOLL)) {
> -			ret = io_iopoll_check(ctx, &nr_events, min_complete);
> -		} else {
> -			ret = io_cqring_wait(ctx, min_complete, sig, sigsz);
> +		if (!(ctx->flags & IORING_SETUP_SQPOLL)) {
> +		    if (ctx->flags & IORING_SETUP_IOPOLL) {
> +		    	ret = io_iopoll_check(ctx, &nr_events, min_complete);
> +		    } else {
> +		    	ret = io_cqring_wait(ctx, min_complete, sig, sigsz);
> +		    }
>  		}
>  	}
>  
> 


-- 
Jens Axboe

