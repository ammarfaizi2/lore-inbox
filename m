Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261824AbVATSXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261824AbVATSXv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 13:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbVATSWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 13:22:21 -0500
Received: from pastinakel.tue.nl ([131.155.2.7]:15378 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S261720AbVATSP5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 13:15:57 -0500
Date: Thu, 20 Jan 2005 19:15:55 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: oom killer gone nuts
Message-ID: <20050120181555.GA11170@pclin040.win.tue.nl>
References: <20050120123402.GA4782@suse.de> <20050120131556.GC10457@pclin040.win.tue.nl> <20050120140033.GQ2240@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120140033.GQ2240@logos.cnet>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 12:00:34PM -0200, Marcelo Tosatti wrote:
> On Thu, Jan 20, 2005 at 02:15:56PM +0100, Andries Brouwer wrote:

> > Yes, the fact that the oom-killer exists is a serious problem.
> > People work on trying to tune it, instead of just removing it.
> > 
> > I am getting reports that also in overcommit mode 2 (no overcommit,
> > no oom-killer ever needed) processes are killed by the oom-killer
> > (on 2.6.10).
> 
> Hi Andries,
> 
> There is a user requirement for overcommit mode, you know. 
> 
> Saying "hey, there's no more overcommit mode in future v2.6 releases, you 
> run out of memory and get -ENOMEM" is not really an option is it?
> 
> You propose to remove the OOM killer and do what? Lockup solid?

Right now we have three overcommit modes.
They are specified by:
0: overcommit, but keep it reasonable (the current default)
1: overcommit, always say yes
2: keep track of all our obligations, do not overcommit

So, one has the right to expect that no OOM situation can occur
in overcommit mode 2. But in 2.6.10 it can. That is a bug.
The conclusion must be that bookkeeping is done incorrectly.
Perhaps also mode 0 is affected by that same bug.


Now you ask what I propose. There is no hurry worrying about that -
the first thing should be to fix the bookkeeping problem.


But assume that fixed. Then everybody can run in mode 2 and never
have any problems. That is what I do.

Yes, you say, but that is an inefficient use of memory. Perhaps.
That is the price I am willing to pay for the guarantee that my
processes are not killed at some random moment.

But if someone else does not do anything of importance and doesnt
care if his processes die at arbitrary moments if only things go
as fast as possible and use as much of his precious memory as possible,
then also for him overcommit mode 2 can be useful.
It is accompanied by the variable overcommit_ratio R - the amount
of memory that can be used is Swap + Memory*(R/100). Here R can be
larger than 100, so in overcommit mode 2 one can specify very precisely
what amount of overcommitment is considered acceptable.


Very few people run overcommit mode 2, and lots of things are
badly tested. It cannot become the default today.
But I would like to see it the default at some future moment.

Andries
