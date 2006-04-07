Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbWDGIjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWDGIjj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 04:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWDGIjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 04:39:39 -0400
Received: from adsl-69-232-92-238.dsl.sndg02.pacbell.net ([69.232.92.238]:59042
	"EHLO gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id S932388AbWDGIji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 04:39:38 -0400
Date: Fri, 7 Apr 2006 01:39:31 -0700
To: Ingo Molnar <mingo@elte.hu>
Cc: Darren Hart <darren@dvhart.com>, linux-kernel@vger.kernel.org,
       Thomas Gleixner <tglx@linutronix.de>,
       "Stultz, John" <johnstul@us.ibm.com>,
       Peter Williams <pwil3058@bigpond.net.au>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: RT task scheduling
Message-ID: <20060407083931.GA11393@gnuppy.monkey.org>
References: <200604052025.05679.darren@dvhart.com> <20060406073753.GA18349@elte.hu> <20060407030713.GA9623@gnuppy.monkey.org> <20060407071125.GA2563@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060407071125.GA2563@elte.hu>
User-Agent: Mutt/1.5.11+cvs20060126
From: Bill Huey (hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2006 at 09:11:25AM +0200, Ingo Molnar wrote:
> * Bill Huey <billh@gnuppy.monkey.org> wrote:
> 
> > On Thu, Apr 06, 2006 at 09:37:53AM +0200, Ingo Molnar wrote:
> > > do "global" decisions for what RT tasks to run on which CPU. To put even 
> > > less overhead on the mainstream kernel, i plan to introduce a new 
> > > SCHED_FIFO_GLOBAL scheduling policy to trigger this behavior. [it doesnt 
> > > make much sense to extend SCHED_RR in that direction.]
> > 
> > You should consider for a moment to allow for the binding of a thread 
> > to a CPU to determine the behavior of a SCHED_FIFO class task instead 
> > of creating a new run category. [...]
> 
> That is already possible and has been possible for years.

I know that this is already the case. What I'm saying is that the creation
of new globally scheduled run case isn't necessarly if you have a robust
thread to CPU binding mechanism, the key here is "robust". I'm suggesting
that you and the gang think in terms of that, in a first-class manner, for
app development instead of creating a new run category that would be almost
certainly abused by naive developers. IMO, the discussion should be about
that as well as setting aside a CPU for a dedicated task, popularly termed
"CPU isolations", that excludes any other task from running on it. This
something that was used fairly heavily under IRIX and is highly useful in
RT development.

The RT rebalancing discussion should be oriented toward manual techniques
for dealing with this on an app basis and not automatic load balancing
stuff or anything like that. IMO, going down this direction is basically
trying to solve a problem with the wrong tool set.

bill

