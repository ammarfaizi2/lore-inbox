Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277380AbRJ3SoC>; Tue, 30 Oct 2001 13:44:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277382AbRJ3Snw>; Tue, 30 Oct 2001 13:43:52 -0500
Received: from [208.129.208.52] ([208.129.208.52]:38410 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S277380AbRJ3Snc>;
	Tue, 30 Oct 2001 13:43:32 -0500
Date: Tue, 30 Oct 2001 10:50:23 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Hubertus Franke <frankeh@watson.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, <lse-tech@lists.sourceforge.net>
Subject: Re: [PATCH][RFC] Proposal For A More Scalable Scheduler ...
In-Reply-To: <20011030112937.A16154@watson.ibm.com>
Message-ID: <Pine.LNX.4.40.0110301043040.1495-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Oct 2001, Hubertus Franke wrote:

> * Davide Libenzi <davidel@xmailserver.org> [20011030 12;19]:"
> >
> > I see the proposed implementation as a decisive cut with the try to have
> > processes instantly moved across CPUs and stuff like na_goodness, etc..
> > Inside each CPU the scheduler is _exactly_ the same as the UP one.
> >
>
> Well, to that extent that what MQ does as too. We do a local decision
> first and then compare across multiple queues. In the pooling approach
> we limit that global check to some cpus within the proximity.
> I think your CPU Weight history could fit into this model as well.
> We don't care how the local decision was reached.

That's what I don't want to do, at least at every schedule().
The main purpose of the proposed scheduler is to relax process movement
policies.


> There is however another problem that you haven't addressed yet, which
> is realtime. As far as I can tell, the realtime semantics require a
> strict ordering with respect to each other and their priorities.
> General approach can be either to limit all RT processes to a single CPU
> or, as we have done, declare a global RT runqueue.

Real time processes, when wakeup up fall calling reschedule_idle() that
will either find the CPU idle or will be reschedule due a favorable
preemption_goodness().
One of balancing scheme I'm using tries to distribute RT tasks evenly on
CPUs.



On Tue, 30 Oct 2001, Hubertus Franke wrote:

> > > We do a periodic (configurable) call, which has also some drawbacks.
> > > Another thing that needs to be thought about is the metric used
> > > to determine <load> on a queue. For simplicity, runqueue length is
> > > one indication, for fairness, maybe the sum of nice-value would be ok.
> > > We experimented with both and didn't see to much of a difference, however
> > > measuring fairness is difficult to do.
> >
> > Hey, ... that's part of Episode 2 " Balancing the world", where the evil
> > Mr. MoveSoon fight with Hysteresis for the universe domination :)
> >
> >
>
> Well, one has to be careful, if the system is loaded and processes are
> more long lived rather then come and go, Initial Placement and Idle-Loop
> Load balancing doesn't get you very far with respect to decent load balancing.
> In these kind of scenarios, one needs a feedback system. Trick is to come
> up with an algorithm that is not too intrusive and that is not overcorrecting.
> Take a look at the paper link, where we experimented with some of these
> issues. We tolerated a difference tolerance around the runqueue length.

I'm currently trying an hysteresis approach with a tunable value of
hysteresis to watch at the different performance/behavior.



- Davide


