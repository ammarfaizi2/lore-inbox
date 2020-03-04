Return-Path: <SRS0=iUzr=4V=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDD4C3F2CE
	for <io-uring@archiver.kernel.org>; Wed,  4 Mar 2020 19:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F50B2166E
	for <io-uring@archiver.kernel.org>; Wed,  4 Mar 2020 19:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbgCDTDo (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Wed, 4 Mar 2020 14:03:44 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:39087 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbgCDTDo (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Wed, 4 Mar 2020 14:03:44 -0500
X-Originating-IP: 92.243.9.8
Received: from localhost (joshtriplett.org [92.243.9.8])
        (Authenticated sender: josh@joshtriplett.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 0039E60005;
        Wed,  4 Mar 2020 19:03:41 +0000 (UTC)
Date:   Wed, 4 Mar 2020 11:03:41 -0800
From:   Josh Triplett <josh@joshtriplett.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, jlayton@kernel.org
Subject: Re: [PATCHSET v2 0/6] Support selectable file descriptors
Message-ID: <20200304190341.GB16251@localhost>
References: <20200304180016.28212-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200304180016.28212-1-axboe@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

On Wed, Mar 04, 2020 at 11:00:10AM -0700, Jens Axboe wrote:
> One of the fabled features with chains has long been the desire to
> support things like:
> 
> <open fileX><read from fileX><close fileX>
> 
> in a single chain. This currently doesn't work, since the read/close
> depends on what file descriptor we get on open.
> 
> The original attempt at solving this provided a means to pass
> descriptors between chains in a link, this version takes a different
> route. Based on Josh's support for O_SPECIFIC_FD, we can instead control
> what fd value we're going to get out of open (or accept). With that in
> place, we don't need to do any magic to make this work. The above chain
> then becomes:
> 
> <open fileX with fd Y><read from fd Y><close fd Y>
> 
> which is a lot more useful, and allows any sort of weird chains without
> needing to nest "last open" file descriptors.
> 
> Updated the test program to use this approach:
> 
> https://git.kernel.dk/cgit/liburing/plain/test/orc.c?h=fd-select
> 
> which forces the use of fd==89 for the open, and then uses that for the
> read and close.
> 
> Outside of this adaptation, fixed a few bugs and cleaned things up.

I posted one comment about an issue in patch 6.

Patches 2-5 look great; for those:
Reviewed-by: Josh Triplett <josh@joshtriplett.org>

Thanks for picking this up and running with it!
