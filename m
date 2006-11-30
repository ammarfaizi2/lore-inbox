Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030816AbWK3ROL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030816AbWK3ROL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 12:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030820AbWK3ROL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 12:14:11 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:5329 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030816AbWK3ROK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 12:14:10 -0500
Date: Thu, 30 Nov 2006 09:15:33 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: paulmck@linux.vnet.ibm.com, Andrew Morton <akpm@osdl.org>,
       Dipankar Sarma <dipankar@in.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [RCU] adds a prefetch() in rcu_do_batch()
Message-ID: <20061130171533.GB1869@us.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <a769871e0611211233n20eb9d74j661cd73e9315fade@mail.gmail.com> <200611221602.29597.dada1@cosmosbay.com> <20061130012528.GJ2335@us.ibm.com> <200611300955.52293.dada1@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611300955.52293.dada1@cosmosbay.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2006 at 09:55:52AM +0100, Eric Dumazet wrote:
> On Thursday 30 November 2006 02:25, Paul E. McKenney wrote:
> > On Wed, Nov 22, 2006 at 04:02:29PM +0100, Eric Dumazet wrote:
> > > On some workloads, (for example when lot of close() syscalls are done),
> > > RCU qlen can be quite large, and RCU heads are no longer in cpu cache
> > > when rcu_do_batch() is called.
> > >
> > > This patches adds a prefetch() in rcu_do_batch() to give CPU a hint to
> > > bring back cache lines containing 'struct rcu_head's.
> > >
> > > Most list manipulations macros include prefetch(), but not open coded
> > > ones (at least with current C compilers :) )
> > >
> > > I got a nice speedup on a trivial benchmark  (3.48 us per iteration
> > > instead of 3.95 us on a 1.6 GHz Pentium-M)
> > > while (1) { pipe(p); close(fd[0]); close(fd[1]);}
> >
> > Interesting!  How much of the speedup was due to the prefetch() and how
> > much to removing the extra store to rdp->donelist?
> 
> I only benchmarked the prefetch() case.
> 
> Then, when cooking the patch I found I could do the rdp->donelist affectation
> after the loop. I am not sure it's worth to do another benchmark for this
> trivial optimization (Please dont tell me its not a valid one :) )

It would be a good idea to check it out.  Modern CPUs can be a bit
on the tricky side.  I have seen cases where removing instructions
slowed things down.  And it can't be -that- hard to run the other
two cases!

							Thanx, Paul
