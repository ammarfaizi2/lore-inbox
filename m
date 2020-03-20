Return-Path: <SRS0=J1zN=5F=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3FDC4332D
	for <io-uring@archiver.kernel.org>; Fri, 20 Mar 2020 04:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A2720722
	for <io-uring@archiver.kernel.org>; Fri, 20 Mar 2020 04:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgCTEna (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Fri, 20 Mar 2020 00:43:30 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46932 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgCTEna (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Fri, 20 Mar 2020 00:43:30 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4DD841590E027;
        Thu, 19 Mar 2020 21:43:30 -0700 (PDT)
Date:   Thu, 19 Mar 2020 21:43:29 -0700 (PDT)
Message-Id: <20200319.214329.1659736613337215790.davem@davemloft.net>
To:     axboe@kernel.dk
Cc:     io-uring@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] io_uring: make sure accept honor rlimit nofile
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200320022216.20993-3-axboe@kernel.dk>
References: <20200320022216.20993-1-axboe@kernel.dk>
        <20200320022216.20993-3-axboe@kernel.dk>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 19 Mar 2020 21:43:30 -0700 (PDT)
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>
Date: Thu, 19 Mar 2020 20:22:16 -0600

> Just like commit 21ec2da35ce3, this fixes the fact that
> IORING_OP_ACCEPT ends up using get_unused_fd_flags(), which checks
> current->signal->rlim[] for limits.
> 
> Add an extra argument to __sys_accept4_file() that allows us to pass
> in the proper nofile limit, and grab it at request prep time.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Acked-by: David S. Miller <davem@davemloft.net>
