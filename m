Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277382AbRJ3Sxd>; Tue, 30 Oct 2001 13:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277530AbRJ3SxW>; Tue, 30 Oct 2001 13:53:22 -0500
Received: from yktgi01e0-s1.watson.ibm.com ([198.81.209.16]:51967 "HELO
	ssm22.watson.ibm.com") by vger.kernel.org with SMTP
	id <S277382AbRJ3SxG>; Tue, 30 Oct 2001 13:53:06 -0500
Date: Tue, 30 Oct 2001 11:52:57 -0500
From: Hubertus Franke <frankeh@watson.ibm.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: lkml <linux-kernel@vger.kernel.org>, lse-tech@lists.sourceforge.net
Subject: Re: [PATCH][RFC] Proposal For A More Scalable Scheduler ...
Message-ID: <20011030115257.A16187@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
In-Reply-To: <20011030112937.A16154@watson.ibm.com> <Pine.LNX.4.40.0110301043040.1495-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <Pine.LNX.4.40.0110301043040.1495-100000@blue1.dev.mcafeelabs.com>; from Davide Libenzi on Tue, Oct 30, 2001 at 10:50:23AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Davide Libenzi <davidel@xmailserver.org> [20011030 13;50]:"
> On Tue, 30 Oct 2001, Hubertus Franke wrote:
> 
> > * Davide Libenzi <davidel@xmailserver.org> [20011030 12;19]:"
> > >
> > > I see the proposed implementation as a decisive cut with the try to have
> > > processes instantly moved across CPUs and stuff like na_goodness, etc..
> > > Inside each CPU the scheduler is _exactly_ the same as the UP one.
> > >
> >
> > Well, to that extent that what MQ does as too. We do a local decision
> > first and then compare across multiple queues. In the pooling approach
> > we limit that global check to some cpus within the proximity.
> > I think your CPU Weight history could fit into this model as well.
> > We don't care how the local decision was reached.
> 
> That's what I don't want to do, at least at every schedule().
> The main purpose of the proposed scheduler is to relax process movement
> policies.
> 

And I think that is a GOOD design point, no question. One of our next
steps is/was to relax the global decision making process that we pursued
to be able to compare A's with A's. Occasionally doing this every Nth time
might be something useful.

> 
> > There is however another problem that you haven't addressed yet, which
> > is realtime. As far as I can tell, the realtime semantics require a
> > strict ordering with respect to each other and their priorities.
> > General approach can be either to limit all RT processes to a single CPU
> > or, as we have done, declare a global RT runqueue.
> 
> Real time processes, when wakeup up fall calling reschedule_idle() that
> will either find the CPU idle or will be reschedule due a favorable
> preemption_goodness().
> One of balancing scheme I'm using tries to distribute RT tasks evenly on
> CPUs.
> 

I think that would be a problem. My understanding is that if two RT process
are globally runnable, then one must run the one with higher priority.
Am I missing something here ?
 
> 
> 
> On Tue, 30 Oct 2001, Hubertus Franke wrote:
> 
> > > > We do a periodic (configurable) call, which has also some drawbacks.
> > > > Another thing that needs to be thought about is the metric used
> > > > to determine <load> on a queue. For simplicity, runqueue length is
> > > > one indication, for fairness, maybe the sum of nice-value would be ok.
> > > > We experimented with both and didn't see to much of a difference, however
> > > > measuring fairness is difficult to do.
> > >
> > > Hey, ... that's part of Episode 2 " Balancing the world", where the evil
> > > Mr. MoveSoon fight with Hysteresis for the universe domination :)
> > >
> > >
> >
> > Well, one has to be careful, if the system is loaded and processes are
> > more long lived rather then come and go, Initial Placement and Idle-Loop
> > Load balancing doesn't get you very far with respect to decent load balancing.
> > In these kind of scenarios, one needs a feedback system. Trick is to come
> > up with an algorithm that is not too intrusive and that is not overcorrecting.
> > Take a look at the paper link, where we experimented with some of these
> > issues. We tolerated a difference tolerance around the runqueue length.
> 
> I'm currently trying an hysteresis approach with a tunable value of
> hysteresis to watch at the different performance/behavior.
> 
> 

That seems appropriate ... looking forward to see that.

> 
> - Davide
> 

-- Hubertus

