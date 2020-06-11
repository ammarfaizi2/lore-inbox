Return-Path: <SRS0=oBCy=7Y=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00FCC433DF
	for <io-uring@archiver.kernel.org>; Thu, 11 Jun 2020 15:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EFA4206C3
	for <io-uring@archiver.kernel.org>; Thu, 11 Jun 2020 15:46:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="a5K17ewC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgFKPqX (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 11 Jun 2020 11:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728675AbgFKPqW (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 11 Jun 2020 11:46:22 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649CFC08C5C2
        for <io-uring@vger.kernel.org>; Thu, 11 Jun 2020 08:46:21 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y18so2470027plr.4
        for <io-uring@vger.kernel.org>; Thu, 11 Jun 2020 08:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2f3tW9HBmOoXFPNLoVb9FslaVcq4vCF5hduK4aKYehk=;
        b=a5K17ewCL1zQB6gW7JuXppbwOcQ689VvV+pORLooaK/gM/JtQkx/olQ167P8udg3ZL
         Wnj2nDYgGhm+zGAkLzIZRQ8/F3tcn8yK+Y3cnD+SpOUlS1OIUGgf+kqL/CPStgV3V6Se
         uDa3VXWYNoiO1/m1QRpLaEepgLyzg+LkWjuDIoAHpUcaoW9ymo7jAT2Ez050u1YHquzo
         KONJ7r5gnf9rAnNp8VWs+JGibGRRM6l6BXfskfTOE0fHAOXIBO0EmOiMLWXWjJ0aBRAi
         urzV0qr56Z4MJhm6Cgx/2rvjmwwjTALIuqAWft7+0IxkFy9Y4nyxd3CwvlFC6XJ7T3s3
         uUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2f3tW9HBmOoXFPNLoVb9FslaVcq4vCF5hduK4aKYehk=;
        b=Hyp6u6G+7PioOUT67nP8YDcM/gC0hfKAic4pwisLZXBtG9YJEVwU0WODr4PJu1EdQB
         5I2Be2cQMIOkQzqxA9X96IKB8tyddxuYJ7n6ZxWMK7zUC+/8C4CyyHudnlZ1CPhxYd5T
         D80hc8AMaJlgLeKCEsEbeEbI5iuYjBE8kjwAaNJd7GScCjDPA6+WYbH6fm9EENgf0GCT
         knq8B0DN9UgUnVxtIC5v/3xXD5oX5hO0oGRjKhV6m8qf22fryyaMfi06cCEpcq74FoF7
         3PEMHdhWjAvUJB4huoENk9iWbYJ3knw42zes9hdX16tZh5ZqIZlHZ/oIoQzWD6IPkDU8
         T5+Q==
X-Gm-Message-State: AOAM532UsQFsCQjZXcO8FGq3XLzrrgaX5vvUzwq/e/P4X9ABq8IPzMTA
        5adaOhfjvzbsq6eywGOK34VCAA==
X-Google-Smtp-Source: ABdhPJyXqdRxDwc6M/669INToHN2Xph4LZlQoZygFrLyBJRKGH/ffn7YoSMzGtiG9uLYvDllxego7A==
X-Received: by 2002:a17:902:e9d2:: with SMTP id 18mr8023697plk.56.1591890380666;
        Thu, 11 Jun 2020 08:46:20 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 12sm3555324pfj.149.2020.06.11.08.46.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 08:46:19 -0700 (PDT)
Subject: Re: [PATCH v2] io_uring: fix io_kiocb.flags modification race in
 IOPOLL mode
To:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        io-uring@vger.kernel.org
Cc:     asml.silence@gmail.com, joseph.qi@linux.alibaba.com
References: <20200611153936.19012-1-xiaoguang.wang@linux.alibaba.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4c553854-dfe9-1529-7c07-37ba2bafb0bc@kernel.dk>
Date:   Thu, 11 Jun 2020 09:46:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200611153936.19012-1-xiaoguang.wang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 6/11/20 9:39 AM, Xiaoguang Wang wrote:
> While testing io_uring in arm, we found sometimes io_sq_thread() keeps
> polling io requests even though there are not inflight io requests in
> block layer. After some investigations, found a possible race about
> io_kiocb.flags, see below race codes:
>   1) in the end of io_write() or io_read()
>     req->flags &= ~REQ_F_NEED_CLEANUP;
>     kfree(iovec);
>     return ret;
> 
>   2) in io_complete_rw_iopoll()
>     if (res != -EAGAIN)
>         req->flags |= REQ_F_IOPOLL_COMPLETED;
> 
> In IOPOLL mode, io requests still maybe completed by interrupt, then
> above codes are not safe, concurrent modifications to req->flags, which
> is not protected by lock or is not atomic modifications. I also had
> disassemble io_complete_rw_iopoll() in arm:
>    req->flags |= REQ_F_IOPOLL_COMPLETED;
>    0xffff000008387b18 <+76>:    ldr     w0, [x19,#104]
>    0xffff000008387b1c <+80>:    orr     w0, w0, #0x1000
>    0xffff000008387b20 <+84>:    str     w0, [x19,#104]
> 
> Seems that the "req->flags |= REQ_F_IOPOLL_COMPLETED;" is  load and
> modification, two instructions, which obviously is not atomic.
> 
> To fix this issue, add a new iopoll_completed in io_kiocb to indicate
> whether io request is completed.

Looks good, applied, thanks.

-- 
Jens Axboe

