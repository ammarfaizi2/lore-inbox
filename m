Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267937AbTAMGag>; Mon, 13 Jan 2003 01:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267940AbTAMGag>; Mon, 13 Jan 2003 01:30:36 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:9409 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267937AbTAMGaf>;
	Mon, 13 Jan 2003 01:30:35 -0500
Date: Mon, 13 Jan 2003 12:11:31 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andi Kleen <ak@muc.de>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: Fixing the tty layer was Re: any chance of 2.6.0-test*?
Message-ID: <20030113064131.GB14996@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20030110165441$1a8a@gated-at.bofh.it> <20030110165505$38d9@gated-at.bofh.it> <20030112094007$1647@gated-at.bofh.it> <m3iswuk7xm.fsf_-_@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3iswuk7xm.fsf_-_@averell.firstfloor.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2003 at 09:59:15AM +0000, Andi Kleen wrote:
> > I've looked into this, and wow, it's not a simple fix :(

Oh, yes, I have spent hours and hours trying to untangle tty locking
and it isn't simple.

> 
> it has to be fixed for 2.6, no argument.
> 
> I took a look at it. I think the easiest strategy would be:
> 
> - Make sure all the process context code holds BKL
> (most of it does, but not all - sometimes it is buggy like in 
> disassociate_tty) 
> I have some patches for that for tty_io.c at least

What does that BKL protect ? I can't seem to ever figure our if
all the races are plugged or not.

> 
> The local_irq_save in there are buggy, they need to take 
> a lock.

Also a locking model w.r.t. the serial drivers ?

> 
> - Audit the data structures that are touched by interrupts
> and add spinlocks.
> At least for n_tty.c probably just tty->read_lock needs to be 
> extended.
> Perhaps some can be just "fixed" by ignoring latency and pushing
> softirq functions into keventd
> (modern CPUs should be fast enough for that) 
> 
> - Possibly disable module unloading for ldiscs (seems to be rather broken,
> although Rusty's new unload algorithm may avoid the worst - not completely
> sure)
> 
> Probably all doable with some concentrated effort.
> 
> Anyone interested in helping ?

Yes, I would like to help out. I was hoping to help rewrite the whole
thing in 2.7, but it needs help *now*. Perhaps I can take your list
of things to do and fix them as a starting point ?

Thanks
Dipankar
