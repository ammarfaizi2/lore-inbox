Return-Path: <SRS0=AAoI=Z2=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91355C2BD09
	for <io-uring@archiver.kernel.org>; Wed,  4 Dec 2019 14:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67AE62084F
	for <io-uring@archiver.kernel.org>; Wed,  4 Dec 2019 14:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="E6EpPa9N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfLDO6c (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 4 Dec 2019 09:58:32 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:42032 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbfLDO6b (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 4 Dec 2019 09:58:31 -0500
Received: by mail-pj1-f65.google.com with SMTP id o11so3091404pjp.9
        for <io-uring@vger.kernel.org>; Wed, 04 Dec 2019 06:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PlepBchFn4YWFq+GZj1z9QxWWGhuD3eodX55fNztUSc=;
        b=E6EpPa9N18CCqWGTx8QCuEEHqhHzZCDJmNdfWjzbZt9gjjh5kMmtJEhGtoTAtx2pXb
         k2kr7dkI8JVU4o+t2yZVAv8yhbA3zwQAXq/ZIjpLp70b51nbhBmKX7WhHtUFG2cSaFDZ
         phIBOOfTNOUxT2fHT6r/UHECUYFBgeluo6bQGGZ+fZPNp+zj890GWD5L0d8JQWSdGNcc
         kSD2esHGhigXEPHuyrCr1r0Na6dCqaAp6OUVXnkYZDT82hTG9NGRq2nnWQ38IHHal0zw
         uiG9iyvV/gfCztBbS4YDHrEWNS0sh0oI7S/89LBpc1PoIGc90An0yKG89ZRDHYQvLIXr
         6PBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PlepBchFn4YWFq+GZj1z9QxWWGhuD3eodX55fNztUSc=;
        b=SXSP4YbUTNEBXSPonsKWbS2+JRWCAgUxg6XCiZn9QjlKHiMcPxPqf3AI+oUAboRUGI
         Naliols/7Iuow0gGYZqiwflnD2WOf1yW82aQqQjxdcRzhnUZ3Vz5fSimtCC6Z3HAvtAk
         94bfwCSqcA8f73Ed9ewY/T1AUiuOsmY8fbU1sTBugkSwqc5MOF8Fmu+1aRqUwUyWNff4
         p7viRZwP3U39ogNaewxQX4TWYZYEEhLa2aiCry5Mz4Fjafw58IzP13nc0x0G+RAtPiZw
         pD2ABw6WQ/+L7BV7CdUiRJGEPYQXsTJJJVbhr8zRuAXlOBG8tUR2Ek0ZiH48GHpg/ph4
         pQwQ==
X-Gm-Message-State: APjAAAX5t/mfOen1Xo8CRy4+dtoXxqXeWmDWnZi+BCtWi+EwrNn3fuGN
        eapcUcVanx6sVURhONX788odLUtM2MQ8bw==
X-Google-Smtp-Source: APXvYqy44STgWqDQA6jWUtlI6cNmSuuoIRsSt3ka8dSPa5P8y/gTayicWPEk+qSAL35l7IpUr8sP5A==
X-Received: by 2002:a17:90b:90e:: with SMTP id bo14mr3829682pjb.17.1575471510073;
        Wed, 04 Dec 2019 06:58:30 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id i4sm7996749pgc.51.2019.12.04.06.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2019 06:58:29 -0800 (PST)
Subject: Re: kernel (or fio) bug with IOSQE_IO_DRAIN
To:     Andres Freund <andres@anarazel.de>
Cc:     linux-block@vger.kernel.org, io-uring <io-uring@vger.kernel.org>
References: <20190913215846.uz4llevvdm5rpatf@alap3.anarazel.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <84b6083c-861c-c586-a5f2-09143d96b74c@kernel.dk>
Date:   Wed, 4 Dec 2019 07:58:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20190913215846.uz4llevvdm5rpatf@alap3.anarazel.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 9/13/19 3:58 PM, Andres Freund wrote:
> Hi Jens,
> 
> While I'm not absolutely certain, this looks like a kernel side bug. I
> modified fio to set DRAIN (because I'd need that in postgres, to not
> actually just loose data as my current prototype does).  But the
> submissions currently fail after a very short amount of time, as soon as
> I use a queue depth bigger than one.
> 
> I modified fio's master like (obviously not intended as an actual fio
> patch):
> 
> diff --git i/engines/io_uring.c w/engines/io_uring.c
> index e5edfcd2..a3fe461f 100644
> --- i/engines/io_uring.c
> +++ w/engines/io_uring.c
> @@ -181,16 +181,20 @@ static int fio_ioring_prep(struct thread_data *td, struct io_u *io_u)
>                          sqe->len = 1;
>                  }
>                  sqe->off = io_u->offset;
> +               sqe->flags |= IOSQE_IO_DRAIN;
>          } else if (ddir_sync(io_u->ddir)) {
>                  if (io_u->ddir == DDIR_SYNC_FILE_RANGE) {
>                          sqe->off = f->first_write;
>                          sqe->len = f->last_write - f->first_write;
>                          sqe->sync_range_flags = td->o.sync_file_range;
>                          sqe->opcode = IORING_OP_SYNC_FILE_RANGE;
> +
> +                       //sqe->flags |= IOSQE_IO_DRAIN;
>                  } else {
>                          if (io_u->ddir == DDIR_DATASYNC)
>                                  sqe->fsync_flags |= IORING_FSYNC_DATASYNC;
>                          sqe->opcode = IORING_OP_FSYNC;
> +                       //sqe->flags |= IOSQE_IO_DRAIN;
>                  }
>          }
>   
> 
> I pretty much immediately get failed requests back with a simple fio
> job:
> 
> [global]
> name=fio-drain-bug
> 
> size=1G
> nrfiles=1
> 
> iodepth=2
> ioengine=io_uring
> 
> [test]
> rw=write
> 
> 
> andres@alap4:~/src/fio$ ~/build/fio/install/bin/fio  ~/tmp/fio-drain-bug.fio
> test: (g=0): rw=randwrite, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=io_uring, iodepth=2
> fio-3.15
> Starting 1 process
> files=0
> fio: io_u error on file test.0.0: Invalid argument: write offset=794877952, buflen=4096
> fio: pid=3075, err=22/file:/home/andres/src/fio/io_u.c:1787, func=io_u error, error=Invalid argument
> 
> test: (groupid=0, jobs=1): err=22 (file:/home/andres/src/fio/io_u.c:1787, func=io_u error, error=Invalid argument): pid=3075: Fri Sep 13 12:45:19 2019
> 
> 
> Where I think the EINVAL might come from
> 
> 	if (unlikely(s->index >= ctx->sq_entries))
> 		return -EINVAL;
> 
> based on the stack trace a perf probe returns (hacketyhack):
> 
> kworker/u16:0-e  6304 [006] 28733.064781: probe:__io_submit_sqe: (ffffffff81356719)
>          ffffffff8135671a __io_submit_sqe+0xfa (/lib/modules/5.3.0-rc8-andres-00007-g3120b9a6a3f7-dirty/build/vmlinux)
>          ffffffff81356da0 io_sq_wq_submit_work+0xe0 (/lib/modules/5.3.0-rc8-andres-00007-g3120b9a6a3f7-dirty/build/vmlinux)
>          ffffffff81137392 process_one_work+0x1d2 (/lib/modules/5.3.0-rc8-andres-00007-g3120b9a6a3f7-dirty/build/vmlinux)
>          ffffffff8113758d worker_thread+0x4d (/lib/modules/5.3.0-rc8-andres-00007-g3120b9a6a3f7-dirty/build/vmlinux)
>          ffffffff8113d1e6 kthread+0x106 (/lib/modules/5.3.0-rc8-andres-00007-g3120b9a6a3f7-dirty/build/vmlinux)
>          ffffffff8200021a ret_from_fork+0x3a (/lib/modules/5.3.0-rc8-andres-00007-g3120b9a6a3f7-dirty/build/vmlinux
> 
> /home/andres/src/kernel/fs/io_uring.c:1800
> 
> which precisely the return:
> 	if (unlikely(s->index >= ctx->sq_entries))
> 		return -EINVAL;
> 
> This is with your change to limit the number of workqueue threads
> applied, but I don't think that should matter.
> 
> I suspect that this is hit due to ->index being unitialized, rather than
> actually too large. In io_sq_wq_submit_work() the sqe_submit embedded in
> io_kiocb is used.  ISTM that e.g. when
> io_uring_enter()->io_ring_submit()->io_submit_sqe()
> allocates the new io_kiocb and io_queue_sqe()->io_req_defer() and then
> submits that to io_sq_wq_submit_work() io_kiocb->submit.index (and some
> other fields?) is not initialized.

For some reason I completely missed this one. I just tested this with
the current tree, and I don't see any issues, but we also changed a few
things there in this area and could have fixed this one inadvertently.
I'll try 5.4/5.3, we might need a stable addition for this if it's still
an issue.

Also see:

https://github.com/axboe/liburing/issues/33

-- 
Jens Axboe

