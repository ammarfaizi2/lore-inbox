Return-Path: <SRS0=J1zN=5F=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81056C4332B
	for <io-uring@archiver.kernel.org>; Fri, 20 Mar 2020 04:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C2120722
	for <io-uring@archiver.kernel.org>; Fri, 20 Mar 2020 04:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgCTEnJ (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 20 Mar 2020 00:43:09 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46926 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgCTEnJ (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 20 Mar 2020 00:43:09 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2D2C31590E020;
        Thu, 19 Mar 2020 21:43:09 -0700 (PDT)
Date:   Thu, 19 Mar 2020 21:43:08 -0700 (PDT)
Message-Id: <20200319.214308.1025834695282023924.davem@davemloft.net>
To:     axboe@kernel.dk
Cc:     io-uring@vger.kernel.org, netdev@vger.kernel.org,
        dkadashev@gmail.com
Subject: Re: [PATCH 1/2] io_uring: make sure openat/openat2 honor rlimit
 nofile
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200320022216.20993-2-axboe@kernel.dk>
References: <20200320022216.20993-1-axboe@kernel.dk>
        <20200320022216.20993-2-axboe@kernel.dk>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 19 Mar 2020 21:43:09 -0700 (PDT)
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>
Date: Thu, 19 Mar 2020 20:22:15 -0600

> Dmitry reports that a test case shows that io_uring isn't honoring a
> modified rlimit nofile setting. get_unused_fd_flags() checks the task
> signal->rlimi[] for the limits. As this isn't easily inheritable,
> provide a __get_unused_fd_flags() that takes the value instead. Then we
> can grab it when the request is prepared (from the original task), and
> pass that in when we do the async part part of the open.
> 
> Reported-by: Dmitry Kadashev <dkadashev@gmail.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Acked-by: David S. Miller <davem@davemloft.net>
