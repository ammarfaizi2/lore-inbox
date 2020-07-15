Return-Path: <SRS0=Bxfd=A2=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CBDC433E0
	for <io-uring@archiver.kernel.org>; Wed, 15 Jul 2020 00:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0558520674
	for <io-uring@archiver.kernel.org>; Wed, 15 Jul 2020 00:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgGOAmS (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 14 Jul 2020 20:42:18 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:47883 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgGOAmS (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 14 Jul 2020 20:42:18 -0400
X-Originating-IP: 50.39.163.217
Received: from localhost (50-39-163-217.bvtn.or.frontiernet.net [50.39.163.217])
        (Authenticated sender: josh@joshtriplett.org)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 662981BF207;
        Wed, 15 Jul 2020 00:42:13 +0000 (UTC)
Date:   Tue, 14 Jul 2020 17:42:09 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Clay Harris <bugs@claycon.org>
Cc:     Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org
Subject: Re: [WIP PATCH] io_uring: Support opening a file into the fixed-file
 table
Message-ID: <20200715004209.GA334456@localhost>
References: <5e04f8fc6b0a2e218ace517bc9acf0d44530c430.1594759879.git.josh@joshtriplett.org>
 <20200714225905.jqlvdvxx564rykxu@ps29521.dreamhostps.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714225905.jqlvdvxx564rykxu@ps29521.dreamhostps.com>
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On Tue, Jul 14, 2020 at 05:59:05PM -0500, Clay Harris wrote:
> I see IORING_OP_FIXED_FILE_TO_FD as a dup() function from fixed file
> to process descriptor space.

Exactly.

> It would be nice if it would take
> parameters to select the functionality of dup, dup2, dup3, F_DUPFD,
> and F_DUPFD_CLOEXEC.  As I recall, O_CLOFORK is on its way from
> Posix-land, so I'd think there will also be something like
> F_DUPFD_CLOFORK coming.

We should certainly have any applicable file-descriptor flags, yes. And
I'd expect to have three primary modes: "give me any unused file
descriptor", "give me this exact file descriptor (closing it if open)",
and "give me this exact file descriptor (erroring if it's already
taken)".

> It would be useful if IORING_REGISTER_xxx_UPDATE would accept a
> placeholder value to ask the kernel not to mess with that index.
> I think AT_FDCWD would be a good choice.

It does accept -1 for that exact purpose.
