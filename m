Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289377AbSAODDu>; Mon, 14 Jan 2002 22:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289376AbSAODDl>; Mon, 14 Jan 2002 22:03:41 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:2034 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S289377AbSAODDa>; Mon, 14 Jan 2002 22:03:30 -0500
Message-ID: <3C439B96.76C0DDD1@mvista.com>
Date: Mon, 14 Jan 2002 19:01:42 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver.Neukum@lrz.uni-muenchen.de
CC: Robert Love <rml@tech9.net>, Momchil Velikov <velco@fadata.bg>,
        yodaiken@fsmlabs.com, Daniel Phillips <phillips@bonn-fries.net>,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <16QDdD-1EqtSyC@fwd03.sul.t-online.com> <1011040605.4604.26.camel@phantasy> <16QFsj-206pZgC@fwd03.sul.t-online.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:
> 
> > Well, semaphores block.  And we have these races right now with
> > SCHED_FIFO tasks.  I still contend preempt does not change the nature of
> > the problem and it certainly doesn't introduce a new one.
> 
> But it does:
> 
> down(&sem);
> do_something_that_cannot_block();
> up(&sem);
> 
> Will stop a SCHED_FIFO task for a definite amount of time. Only
> until it returns from the kernel to user space at worst.
> 
> If do_something_that_cannot_block() can be preempted, a SCHED_FIFO
> task can block indefinitely long on the semaphore, because you have
> no guarantee that the scheduler will ever again select the the preempted task.
> In fact it must never again select the preempted task as long as there's
> another runnable SCHED_FIFO task.
> 
This is not true, and if it is is a scheduler bug.  When a task (any
task) gets preempted it is not moved from the front of its queue, thus,
in this case, the FIFO task will still be the fitst task at its prioity
to run.  Also, it can only be preempted by another real time task of
higher priority.  Now it is possible that that task may block on the
same sem, but this is simple priority inversion and has nothing to do
with the sem holder being FIFO, RR or any thing else.  In other words
preemption does NOT change a FIFO (or any other) task's position in the
dispatch queue.


-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
