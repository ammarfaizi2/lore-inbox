Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275237AbTHGJWr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 05:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275250AbTHGJWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 05:22:47 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:21440 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S275237AbTHGJWo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 05:22:44 -0400
Date: Thu, 7 Aug 2003 11:22:37 +0200
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: queue reference counting
Message-ID: <20030807092237.GB858@suse.de>
References: <20030806232810.GA1623@elf.ucw.cz> <20030806234036.GA209@elf.ucw.cz> <20030807080251.GY7982@suse.de> <3F3219DC.4070608@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F3219DC.4070608@cyberone.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 07 2003, Nick Piggin wrote:
> 
> 
> Jens Axboe wrote:
> 
> >On Thu, Aug 07 2003, Pavel Machek wrote:
> >
> >>Hi!
> >>
> >>
> >>>I ported `subj` to 2.6.0-test2. I do not yet have idea if it works,
> >>>but it compiles ;-).
> >>>
> >>It compiles, it event boots, but it does not seem to have much effect
> >>:-(.
> >>
> >
> >Now that the queue reference counting is in the current bk tree, we are
> >that much closer to real modular io schedulers. I'll post the cfq with
> >priorities for that.
> >
> 
> OK, the QUEUE_FLAG_DEAD. I assume that will be set in blk_cleanup_queue?
> Then all remaining requests are flushed out of the queue?
> 
> This requires that a driver must be able to continue to process requests
> during the call to blk_cleanup_queue, and that blk_cleanup_queue might
> block, right? Is this acceptable, or should there be an earlier call to
> set QUEUE_FLAG_DEAD and ensure queue is flushed?

The plan was to add blk_shutdown_queue() to do this. And then make sure
AS checks the dead flag and doesn't hold back any requests.

-- 
Jens Axboe

