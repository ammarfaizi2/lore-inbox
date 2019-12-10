Return-Path: <SRS0=l6sb=2A=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB11CC43603
	for <io-uring@archiver.kernel.org>; Tue, 10 Dec 2019 19:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C795A20652
	for <io-uring@archiver.kernel.org>; Tue, 10 Dec 2019 19:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfLJThB (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 10 Dec 2019 14:37:01 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:47598 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfLJThB (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 10 Dec 2019 14:37:01 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B710E147F764C;
        Tue, 10 Dec 2019 11:37:00 -0800 (PST)
Date:   Tue, 10 Dec 2019 11:37:00 -0800 (PST)
Message-Id: <20191210.113700.2038253518329326443.davem@davemloft.net>
To:     axboe@kernel.dk
Cc:     io-uring@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 10/11] net: make socket read/write_iter() honor
 IOCB_NOWAIT
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191210155742.5844-11-axboe@kernel.dk>
References: <20191210155742.5844-1-axboe@kernel.dk>
        <20191210155742.5844-11-axboe@kernel.dk>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 10 Dec 2019 11:37:00 -0800 (PST)
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>
Date: Tue, 10 Dec 2019 08:57:41 -0700

> The socket read/write helpers only look at the file O_NONBLOCK. not
> the iocb IOCB_NOWAIT flag. This breaks users like preadv2/pwritev2
> and io_uring that rely on not having the file itself marked nonblocking,
> but rather the iocb itself.
> 
> Cc: David Miller <davem@davemloft.net>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

I guess this should be OK:

Acked-by: David S. Miller <davem@davemloft.net>
