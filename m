Return-Path: <io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB773C4320A
	for <io-uring@archiver.kernel.org>; Tue, 10 Aug 2021 13:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C178E61008
	for <io-uring@archiver.kernel.org>; Tue, 10 Aug 2021 13:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbhHJNdy (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 10 Aug 2021 09:33:54 -0400
Received: from cloud48395.mywhc.ca ([173.209.37.211]:37724 "EHLO
        cloud48395.mywhc.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbhHJNdy (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 10 Aug 2021 09:33:54 -0400
Received: from modemcable064.203-130-66.mc.videotron.ca ([66.130.203.64]:54438 helo=[192.168.1.179])
        by cloud48395.mywhc.ca with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <olivier@trillion01.com>)
        id 1mDRsp-0000Hg-6k; Tue, 10 Aug 2021 09:33:31 -0400
Message-ID: <a65c7dc0e836b90fa0dd67e26ed2f14f6831c262.camel@trillion01.com>
Subject: Re: [PATCH 1/2] io_uring: clear TIF_NOTIFY_SIGNAL when running task
 work
From:   Olivier Langlois <olivier@trillion01.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Date:   Tue, 10 Aug 2021 09:33:30 -0400
In-Reply-To: <A4DC14BA-74CA-41DB-BE08-D7B693C11AE0@gmail.com>
References: <20210808001342.964634-1-namit@vmware.com>
         <20210808001342.964634-2-namit@vmware.com>
         <fdd54421f4d4e825152192e327c838d035352945.camel@trillion01.com>
         <A4DC14BA-74CA-41DB-BE08-D7B693C11AE0@gmail.com>
Organization: Trillion01 Inc
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cloud48395.mywhc.ca
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - trillion01.com
X-Get-Message-Sender-Via: cloud48395.mywhc.ca: authenticated_id: olivier@trillion01.com
X-Authenticated-Sender: cloud48395.mywhc.ca: olivier@trillion01.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On Tue, 2021-08-10 at 01:28 -0700, Nadav Amit wrote:
> 
> Happy it could help.
> 
> Unfortunately, there seems to be yet another issue (unless my code
> somehow caused it). It seems that when SQPOLL is used, there are
> cases
> in which we get stuck in io_uring_cancel_sqpoll() when
> tctx_inflight()
> never goes down to zero.
> 
> Debugging... (while also trying to make some progress with my code)

You are on something. io_uring starts to be very solid but it isn't
100% flawless yet.

I am a heavy user of SQPOLL which now run flawlessly for me with 5.13.9
(Was running flawlessly since 5.12 minus few patches I did submit
recently) with my simple use-case (my SQPOLL thread isn't spawning any
threads like in your use-case).

The best is yet to come. I'm salivating by seeing all the performance
optimizations that Jens and Pavel are putting in place lately...


