Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbWIHS6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWIHS6L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 14:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbWIHS6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 14:58:11 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:37319 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750878AbWIHS6J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 14:58:09 -0400
Date: Fri, 8 Sep 2006 11:58:42 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Dipankar Sarma <dipankar@in.ibm.com>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       Eric Dumazet <dada1@cosmosbay.com>,
       "David S. Miller" <davem@davemloft.net>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, josht@us.ibm.com
Subject: Re: [PATCH] simplify/improve rcu batch tuning
Message-ID: <20060908185842.GG1314@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060903163419.GA235@oleg> <20060907203727.GE1293@us.ibm.com> <20060908113930.GB250@oleg> <20060908160234.GE1314@us.ibm.com> <20060908163022.GA149@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060908163022.GA149@oleg>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2006 at 08:30:22PM +0400, Oleg Nesterov wrote:
> On 09/08, Paul E. McKenney wrote:
> > On Fri, Sep 08, 2006 at 03:39:30PM +0400, Oleg Nesterov wrote:
> > > > > @@ -297,6 +294,7 @@ static void rcu_start_batch(struct rcu_c
> > > > >  		smp_mb();
> > > > >  		cpus_andnot(rcp->cpumask, cpu_online_map, nohz_cpu_mask);
> > > > >
> > > > > +		rcp->signaled = 0;
> > > >
> > > > Would it make sense to invoke force_quiescent_state() here in the
> > > > case that rdp->qlen is still large?  The disadvantage is that qlen
> > > > still counts the number of callbacks that are already slated for
> > > > invocation.
> > > 
> > > This is not easy to do. rcu_start_batch() is "global", we need
> > > to scan all per-cpu 'struct rcu_data' and check it's ->qlen.
> > 
> > My thought was that it might make sense to check only this CPU's struct
> > rcu_data.  But I agree that the next approach seems more promising.
> 
> Yes, I understood this. And I don't say this is "bad", I just think this is
> "not perfect". Because the CPU which actually starts a new grace period and
> clears ->signaled may have ->qlen == 0, and the caller is cpu_quiet(), which
> is a "response" to some other CPU's force_quiescent_state().

Sounds good!

							Thanx, Paul
