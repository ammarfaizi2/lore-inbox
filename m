Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312162AbSC2VtV>; Fri, 29 Mar 2002 16:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312169AbSC2VtJ>; Fri, 29 Mar 2002 16:49:09 -0500
Received: from [195.39.17.254] ([195.39.17.254]:48775 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S312162AbSC2Vsx>;
	Fri, 29 Mar 2002 16:48:53 -0500
Date: Fri, 29 Mar 2002 22:42:52 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Robert Love <rml@tech9.net>
Cc: Wessel Dankers <wsl@fruit.eu.org>, linux-kernel@vger.kernel.org
Subject: Re: Scheduler priorities
Message-ID: <20020329214252.GA9974@elf.ucw.cz>
In-Reply-To: <20020327125828.U2343-100000@angelina.sl.pt> <1017236512.16546.116.camel@phantasy> <20020327202335.GA514@fruit.eu.org> <1017263732.17510.204.camel@phantasy> <20020328070855.GB514@fruit.eu.org> <1017300610.17515.229.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well evidently it should be root-only, just like SCHED_RR and SCHED_FIFO.
> > If the priority inversion issues are worked out this restriction could be
> > removed. I remember discussing this problem with Rik van Riel.
> > The kernel-preempt patch seems to be able to detect when a process holds a
> > lock; perhaps the process scheduler can temporarily revert to SCHED_NORMAL
> > when this is the case? Preferably with a large nice value.
> 
> The preempt-kernel patch does keep track of the lock count, but it does
> not include semaphores and those are what we need to worry about.
> 
> I also don't think it is enough that SCHED_IDLE only be settable by
> root.  Regardless of what permissions it takes to set the scheduling
> class, a "SCHED_IDLE" task should never be capable of harming an RT
> task.

On each entry of kernel, promote SCHED_IDLE task to SCHED_NORMAL, and
demote it at exit. This can be done with 0 overhad on hot paths.


> One solution I have come across is checking whether the task is
> returning to kernel or user mode and acting appropriately.  As needed,
> the task can be scheduled as SCHED_NORMAL.  This situation could even be
> special-cased like ptrace and not impact normal scheduling.  Perhaps
> this is what Ingo had in mind ... I hope he is still interested and
> presents some code.
> 
> I know all this because I tried to implement SCHED_IDLE about a year
> ago.  There were arguments against every approach, and SCHED_IDLE will
> never be accepted until they are all satisfied.  If we want it, it needs
> to be done right.

What's the problem with "promote at enter" approach? Using ptrace
trick, it can be 0 overhead. [Was that your code that cleverly used
ptrace?] What is problem with it?
									Pavel

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
