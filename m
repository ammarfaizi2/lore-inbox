Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030405AbVLWESY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030405AbVLWESY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 23:18:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030406AbVLWESY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 23:18:24 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:36013 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030405AbVLWESY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 23:18:24 -0500
Subject: Re: 2.6.14-rt22 (and mainline) excessive latency
From: Lee Revell <rlrevell@joe-job.com>
To: paulmck@us.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20051223040746.GB12179@us.ibm.com>
References: <1135039244.28649.41.camel@mindpipe>
	 <20051220042442.GA32039@elte.hu> <20051221014747.GB5741@us.ibm.com>
	 <1135135970.28229.0.camel@mindpipe> <20051221133641.GA7613@us.ibm.com>
	 <1135194859.31433.6.camel@mindpipe>  <20051223040746.GB12179@us.ibm.com>
Content-Type: text/plain
Date: Thu, 22 Dec 2005 23:22:46 -0500
Message-Id: <1135311766.4473.8.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-22 at 20:07 -0800, Paul E. McKenney wrote:
> On Wed, Dec 21, 2005 at 02:54:18PM -0500, Lee Revell wrote:
> > On Wed, 2005-12-21 at 05:36 -0800, Paul E. McKenney wrote:
> > > On Tue, Dec 20, 2005 at 10:32:48PM -0500, Lee Revell wrote:
> > > > On Tue, 2005-12-20 at 17:47 -0800, Paul E. McKenney wrote:
> > > > > On Tue, Dec 20, 2005 at 05:24:42AM +0100, Ingo Molnar wrote:
> > > > > > 
> > > > > > * Lee Revell <rlrevell@joe-job.com> wrote:
> > > > > > 
> > > > > > > I captured this 3+ ms latency trace when killing a process with a few 
> > > > > > > thousand threads.  Can a cond_resched be added to this code path?
> > > > > > 
> > > > > > >     bash-17992 0.n.1   29us : eligible_child (do_wait)
> > > > > > > 
> > > > > > >     [ 3000+ of these deleted ]
> > > > > > > 
> > > > > > >     bash-17992 0.n.1 3296us : eligible_child (do_wait)
> > > > > > 
> > > > > > Atomicity of signal delivery is pretty much a must, so i'm not sure this 
> > > > > > particular latency can be fixed, short of running PREEMPT_RT. Paul E.  
> > > > > > McKenney is doing some excellent stuff by RCU-ifying the task lookup and 
> > > > > > signal code, but i'm not sure whether it could cover do_wait().
> > > > > 
> > > > > Took a quick break from repeatedly shooting myself in the foot with
> > > > > RCU read-side priority boosting (still have a few toes left) to take
> > > > > a quick look at this.  The TASK_TRACED and TASK_STOPPED cases seem
> > > > > non-trivial, and I am concerned about races with exit.
> > > > > 
> > > > > Any thoughts on whether the latency is due to contention on the
> > > > > tasklist lock vs. the "goto repeat" in do_wait()?
> > > > 
> > > > It's a UP system so I'd be surprised if there were any contention.
> > > 
> > > Couldn't there be contention due to preemption of someone holding
> > > the tasklist lock?
> > 
> > But I'm running with PREEMPT_DESKTOP (specifically I configured a system
> > to have the exact same preemption model as mainline - PREEMPT_DESKTOP
> > with no soft/hardirq preemption) so holding a spinlock will disable
> > preemption.
> 
> My head just exploded.  I will see about getting you a
> CONFIG_FREAKING_INSANE patch, if you are willing to test it.

I'm not sure I know what you mean but sure, I'll try whatever you come
up with.

Lee 

