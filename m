Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267524AbRGMS3u>; Fri, 13 Jul 2001 14:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267526AbRGMS3k>; Fri, 13 Jul 2001 14:29:40 -0400
Received: from yktgi01e0-s1.watson.ibm.com ([198.81.209.16]:56108 "HELO
	ssm22.watson.ibm.com") by vger.kernel.org with SMTP
	id <S267524AbRGMS3X>; Fri, 13 Jul 2001 14:29:23 -0400
Message-ID: <3B4F3DA4.9465C144@watson.ibm.com>
Date: Fri, 13 Jul 2001 14:27:48 -0400
From: Hubertus Frnake <frankeh@watson.ibm.com>
Reply-To: frankeh@us.ibm.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: CPU affinity & IPI latency
In-Reply-To: <OF408C990D.63BC0397-ON85256A88.005CF33B@pok.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Davide Libenzi <davidel@xmailserver.org>@lists.sourceforge.net on
> 07/13/2001 12:41:44 PM
>
> Sent by:  lse-tech-admin@lists.sourceforge.net
>
> To:   Larry McVoy <lm@bitmover.com>
> cc:   linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
>       lse-tech@lists.sourceforge.net, Mike Kravetz <mkravetz@sequent.com>
> Subject:  [Lse-tech] Re: CPU affinity & IPI latency
>
> On 13-Jul-2001 Larry McVoy wrote:
> > Be careful tuning for LMbench (says the author :-)
> >
> > Especially this benchmark.  It's certainly possible to get dramatically
> > better
> > SMP numbers by pinning all the lat_ctx processes to a single CPU, because
> > the benchmark is single threaded.  In other words, if we have 5
> processes,
> > call them A, B, C, D, and E, then the benchmark is passing a token from
> > A to B to C to D to E and around again.
> >
> > If the amount of data/instructions needed by all 5 processes fits in the
> > cache and you pin all the processes to the same CPU you'll get much
> > better performance than simply letting them float.
> >
> > But making the system do that naively is a bad idea.
>
> Agree.
>
> >
> > This is a really hard area to get right but you can take a page from all
> > the failed process migration efforts.  In general, moving stuff is a bad
> > idea, it's much better to leave it where it is.  Everything scales better
> > if there is a process queue per CPU and the default is that you leave the
> > processes on the queue on which they last run.  However, if the load
> average
> > for a queue starts going up and there is another queue with a
> substantially
> > lower load average, then and ONLY then, should you move the process.
>
> I personally think that a standard scheduler/cpu is the way to go for SMP.
> I saw the one IBM guys did and I think that the wrong catch there is trying
> always to grab the best task to run over all CPUs.
> I think that this concept could be relaxed introducing less chains between
> each
> CPU scheduler.
> A cheap load balancer should run, "time to time"(tm), to move tasks when a
> certain level of unbalancing has been reached.
> This will give each scheduler more independence and will make it more
> scalable,
> IMVHO.

Davide, this is exactly what we do with the LoadBalancing extentions to the MQ

scheduler. We subdivide into smaller sets, do the scheduling in there and from

"time to time" (tm), we move tasks over from set to set in order to ensure
loadbalancing.
The frequency and loadbalancing is configurable (module).
http://lse.sourceforge.net/scheduling

>
>
> > This is an area in which I've done a pile of work and I'd be interested
> > in keeping a finger in any efforts to fix up the scheduler.
>
> We've, somehow, understood it :)
>
> - Davide
>
> _______________________________________________
> Lse-tech mailing list
> Lse-tech@lists.sourceforge.net
> http://lists.sourceforge.net/lists/listinfo/lse-tech

