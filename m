Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277533AbRJ3TIE>; Tue, 30 Oct 2001 14:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277559AbRJ3THz>; Tue, 30 Oct 2001 14:07:55 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:53402 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S277533AbRJ3THj>;
	Tue, 30 Oct 2001 14:07:39 -0500
Date: Tue, 30 Oct 2001 11:08:06 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: Davide Libenzi <davidel@xmailserver.org>,
        lkml <linux-kernel@vger.kernel.org>, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: [PATCH][RFC] Proposal For A More Scalable Scheduler ...
Message-ID: <20011030110806.D1097@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <20011030112937.A16154@watson.ibm.com> <Pine.LNX.4.40.0110301043040.1495-100000@blue1.dev.mcafeelabs.com> <20011030115257.A16187@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011030115257.A16187@watson.ibm.com>; from frankeh@watson.ibm.com on Tue, Oct 30, 2001 at 11:52:57AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 11:52:57AM -0500, Hubertus Franke wrote:
> * Davide Libenzi <davidel@xmailserver.org> [20011030 13;50]:"
> > On Tue, 30 Oct 2001, Hubertus Franke wrote:
> > 
> > > There is however another problem that you haven't addressed yet, which
> > > is realtime. As far as I can tell, the realtime semantics require a
> > > strict ordering with respect to each other and their priorities.
> > > General approach can be either to limit all RT processes to a single CPU
> > > or, as we have done, declare a global RT runqueue.
> > 
> > Real time processes, when wakeup up fall calling reschedule_idle() that
> > will either find the CPU idle or will be reschedule due a favorable
> > preemption_goodness().
> > One of balancing scheme I'm using tries to distribute RT tasks evenly on
> > CPUs.
> > 
> 
> I think that would be a problem. My understanding is that if two RT process
> are globally runnable, then one must run the one with higher priority.
> Am I missing something here ?

It is not just the relative priorities of the realtime tasks, but
also the scheduling policy.  SCHED_FIFO (and to some extent SCHED_RR)
implies an ordering within the runqueue for tasks of the same priority.
This is difficult to achieve with multiple runqueues.  Most scheduler
implementations I am aware of, do something like what you suggested
above.

-- 
Mike
