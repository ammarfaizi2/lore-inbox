Return-Path: <SRS0=vuSH=ZE=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746DAC17440
	for <io-uring@archiver.kernel.org>; Tue, 12 Nov 2019 12:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB972084E
	for <io-uring@archiver.kernel.org>; Tue, 12 Nov 2019 12:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQnarPXi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfKLMXF (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 12 Nov 2019 07:23:05 -0500
Received: from mail-lj1-f181.google.com ([209.85.208.181]:40240 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbfKLMXE (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 12 Nov 2019 07:23:04 -0500
Received: by mail-lj1-f181.google.com with SMTP id q2so17575033ljg.7
        for <io-uring@vger.kernel.org>; Tue, 12 Nov 2019 04:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=cOhd36LYAlPhWey6V6cGpEWzMcAlk6F9GfUHLeE3NZo=;
        b=HQnarPXi46kqrzzxTNrlRN15vlXldLc/w7MHKKqdzVN7nfbkUX5RJ0ZGIhMlH4kJaB
         YBYWTgG3P5NgUGXa0F7LcIeeQ5Eby/mNVdaQFCMmja11Pgll79H7diegfsWGFDFhNyFA
         5SE+KHbvd6OABu+6foDlO6OV+EZg6Lnim3CQjpwzHXtuJcvupnlkJbE5r6sSnczypxzM
         6v9wBd7oLGIIEAYWJH/UtUezFaRLt7XuGV1itx2tbY/wQYI/ZyVvEunHL8Xjc8PUoD4o
         QyI3n768Fs9GrfY6W21qEChS/Mdf0fJr7X+UVHw0Nd8xzJ2RbFOxs6IE7cCc7oqUA8bU
         XlrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cOhd36LYAlPhWey6V6cGpEWzMcAlk6F9GfUHLeE3NZo=;
        b=XKSae3EE5xYo0EYb7osjO01kGhqGC7f7bNL6pL2U+axB0lJQozwb05NXaSGyrLNhw9
         7KRuO+BDzQR9RqbdyyEHr2jG2qOEgeWFbZniKyK6bRtl/3fdZA9H4wfxiHHMKJP1tOpN
         OkqGs1o87KHzd6mPLckzRvYkt7Ui2Njf+15e++bFSToqdq/ZlMiQGcUDAskwCjbpnDU2
         wzuOvWAE/Ty1rm9DgBSwS+ZCVYRac5NmQncwMZHQHhR4qS4ZUcAuV1j6gTdx99qeJHw4
         CtF8AZZnF4M2pI1X2aINpBE8gGeHe7RoZ+WqQ0/AtlVhn5NRuiYELkhrydam6kwc/mw/
         zp7g==
X-Gm-Message-State: APjAAAVPImOzg8jUrkeu5vmRXFrNwRNMowJ8gfz3PstdcsCsqxw+mh0g
        RHPlKfX0nCF3mPlAVFhZ6a3jDalO
X-Google-Smtp-Source: APXvYqw+fXsdfPgR3f6+WVAWrggjM+Jsq/WOFb1mUmpihCbBeOohk5XCyzctgfhcQ6AX1AEKbua97w==
X-Received: by 2002:a2e:99c2:: with SMTP id l2mr19918555ljj.145.1573561382760;
        Tue, 12 Nov 2019 04:23:02 -0800 (PST)
Received: from [172.31.190.83] ([86.57.146.226])
        by smtp.gmail.com with ESMTPSA id g26sm8104400lfh.1.2019.11.12.04.23.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 04:23:02 -0800 (PST)
Subject: Re: [RFC] migrating mm
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
References: <6e4c0f3f-745e-c8ed-3dca-2a763e5841ee@gmail.com>
Message-ID: <6b296733-f62b-49be-74f1-e9f94b387b99@gmail.com>
Date:   Tue, 12 Nov 2019 15:23:00 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <6e4c0f3f-745e-c8ed-3dca-2a763e5841ee@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On 11/12/2019 2:14 PM, Pavel Begunkov wrote:
> There is a case I'm not sure about, but which bothers me.
> What would happen, if we try to use io_uring with offloading (i.e.
> IORING_SETUP_SQPOLL), after its creator is gone? The thing is that
> io_sq_thread() is getting mm by using ctx->sqo_mm, which is current->mm
> of the creator process, which potentially may be released.
> 

Please ignore this. The answer is obvious, I just missed
mmgrab(current->mm) right at the beginning of io_sq_offload_start().


> 
> The case in mind:
> let: @parent has a @child process
> 
> @child:
>     uring_fd = io_uring_create(IORING_SETUP_SQPOLL)
>     pass_fd_via_pipe(uring_fd, to=@parent);
>     exit()
> 
> @parent:
>     uring_fd = get_fd_from_pipe()
>     wait(@child)
> 
>     sqe = create_sqe_which_needs_mm();
>     io_submit_sqe(uring_fd, sqe)
>     // io_uring tries to grab mm of @child, which is gone.
> 
> 
> 
> What do you think?
> 
