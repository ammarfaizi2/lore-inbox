Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264257AbTGBSWW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 14:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264328AbTGBSWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 14:22:22 -0400
Received: from web40611.mail.yahoo.com ([66.218.78.148]:59004 "HELO
	web40611.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264257AbTGBSWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 14:22:20 -0400
Message-ID: <20030702183645.79164.qmail@web40611.mail.yahoo.com>
Date: Wed, 2 Jul 2003 11:36:45 -0700 (PDT)
From: Muthian Sivathanu <muthian_s@yahoo.com>
Subject: Re: scheduling with spinlocks held ?
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1057105149.1988.3381.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is there a version of Ingo Molnar's patch for the 2.4
line kernels ?

thanks,
Muthian.


--- Robert Love <rml@tech9.net> wrote:
> On Tue, 2003-07-01 at 17:10, Muthian Sivathanu
> wrote:
> 
> > Is it safe to assume that the kernel will not
> preempt
> > a process when its holding a spinlock ?  I know
> most
> > parts of the code make sure they dont yield the
> cpu
> > when they are holding spinlocks, but I was just
> > curious if there is any place that does that.
> 
> Correct.
> 
> > Basically, the context is, I need to change the
> > scheduler a bit to implement "perfect nice -19"
> > semantics, i.e. give cpu to nice 19 process only
> if no
> > other normal process is ready to run.  I am
> wondering
> > if there is a possibility of priority inversion if
> the
> > nice-d process happens to yield the cpu and then
> never
> > get scheduled because a normal process is spinning
> on
> > the lock.
> 
> You will hit priority inversion... not with
> spinlocks but with
> semaphores (and possibly more subtle issues).
> 
> The only safe way to do this safely is to boost the
> task's priority out
> of the "idle" class when the task is inside the
> kernel.
> 
> It is nontrivial to juggle user vs. kernel returns
> such as that. Google
> for Ingo Molnar's SCHED_BATCH addition to the O(1)
> scheduler.
> 
> 	Robert Love
> 
> 


__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com
