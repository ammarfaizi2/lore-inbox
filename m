Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281527AbRKQAcx>; Fri, 16 Nov 2001 19:32:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281552AbRKQAcn>; Fri, 16 Nov 2001 19:32:43 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:63689 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S281527AbRKQAca>; Fri, 16 Nov 2001 19:32:30 -0500
Date: Fri, 16 Nov 2001 16:32:24 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: lse-tech@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Real Time Runqueue
Message-ID: <20011116163224.H1152@w-mikek2.des.beaverton.ibm.com>
In-Reply-To: <20011116154701.G1152@w-mikek2.des.beaverton.ibm.com> <Pine.LNX.4.40.0111161620050.998-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.40.0111161620050.998-100000@blue1.dev.mcafeelabs.com>; from davidel@xmailserver.org on Fri, Nov 16, 2001 at 04:28:33PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2001 at 04:28:33PM -0800, Davide Libenzi wrote:
> On Fri, 16 Nov 2001, Mike Kravetz wrote:
> 
> > Suppose you have a 2 CPU system with 4 runnable tasks.  3 of these
> > tasks are realtime with the same realtime priority and the other is
> > an ordinary SCHED_OTHER task.  The task distribution on the runqueues
> > looks something like this.
> >
> > CPU 0             CPU 1
> > ---------         ---------
> > RT Task A         RT Task B
> > Other Task C      RT Task D
> >
> > Task A and Task B are currently running on the 2 CPUs.  Now, Task A
> > voluntarily gives up CPU 0 and Task B is still running on CPU 1.
> > At this point, Task D should be chosen to run on CPU 0.  Correct?
> > Isn't this a required RT semantic?  I'm curious how you plan on
> > accomplishing this.
> 
> Well I don't know how RT sematics apply to SMP systems.

Me either (not exactly).

> The easy solution ( == big common lock ) would be to have a single RT
> queue that is checked before the private one.
> Anyway, sometime it happens that the cure is worst than the disease and to
> solve a corner case you're going to punish common case performances (
> Linux is not an RT OS even with that fix ).

The reason I ask is that we went through the pains of a separate
realtime RQ in our MQ scheduler.  And yes, it does hurt the common
case, not to mention the extra/complex code paths.  I was hoping
that someone in the know could enlighten us as to how RT semantics
apply to SMP systems.  If the semantics I suggest above are required,
then it implies support must be added to any possible future
scheduler implementations.

-- 
Mike
