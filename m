Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263840AbTKMLBs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 06:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263887AbTKMLBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 06:01:48 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:2213 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263840AbTKMLBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 06:01:44 -0500
Date: Thu, 13 Nov 2003 12:01:43 +0100
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: AS spin lock bugs
Message-ID: <20031113110143.GE4441@suse.de>
References: <20031113103823.GB4441@suse.de> <20031113105223.GC4441@suse.de> <3FB36419.2040101@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FB36419.2040101@cyberone.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 13 2003, Nick Piggin wrote:
> 
> 
> Jens Axboe wrote:
> 
> >On Thu, Nov 13 2003, Jens Axboe wrote:
> >
> >>@@ -959,12 +960,12 @@
> >>	if (!aic)
> >>		return;
> >>
> >>-	spin_lock(&aic->lock);
> >>+	spin_lock_irqsave(&aic->lock, flags);
> >>	if (arq->is_sync == REQ_SYNC) {
> >>		set_bit(AS_TASK_IORUNNING, &aic->state);
> >>		aic->last_end_request = jiffies;
> >>	}
> >>-	spin_unlock(&aic->lock);
> >>+	spin_unlock_irqrestore(&aic->lock, flags);
> >>
> >>	put_io_context(arq->io_context);
> >>}
> >>
> >
> >BTW, this looks bogus. Why do you need any locking there?
> >
> 
> To prevent a request completion on another queue on another CPU from
> racing with request insertion: last_end_request is undefined if the
> flag is not set. I guess you could flip the statements and put a
> smp_mb between them. Probably not worth the trouble though.

No better to make it explicit, probably doesn't matter much in
real-life. Thanks for the clarifications.

-- 
Jens Axboe

