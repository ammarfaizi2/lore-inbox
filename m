Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751522AbWDYLW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751522AbWDYLW4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 07:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751523AbWDYLW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 07:22:56 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:48573 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751521AbWDYLWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 07:22:55 -0400
Date: Tue, 25 Apr 2006 04:23:10 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, dipankar@in.ibm.com,
       manfred@colorfullife.com, linux-kernel@vger.kernel.org,
       davem@davemloft.net, schwidefsky@de.ibm.com
Subject: Re: [patch] RCU: introduce rcu_soon_pending() interface
Message-ID: <20060425112310.GA16612@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060424111141.GC16007@osiris.boeblingen.de.ibm.com> <20060424160943.4bbdb788.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060424160943.4bbdb788.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2006 at 04:09:43PM -0700, Andrew Morton wrote:
> Heiko Carstens <heiko.carstens@de.ibm.com> wrote:
> >
> > @@ -485,6 +485,14 @@ int rcu_pending(int cpu)
> >  		__rcu_pending(&rcu_bh_ctrlblk, &per_cpu(rcu_bh_data, cpu));
> >  }
> >  
> > +int rcu_soon_pending(int cpu)
> > +{
> > +	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
> > +	struct rcu_data *rdp_bh = &per_cpu(rcu_bh_data, cpu);
> > +
> > +	return (!!rdp->curlist || !!rdp_bh->curlist);
> > +}
> 
> This patch sets my nerves a-jangling.
> 
> What are the units of soonness?  It's awfully waffly.  Can we specify this
> more tightly?
> 
> Neither rcu_pending() nor rcu_soon_pending() are commented or documented. 
> Pity the poor user trying to work out what they do, and how they differ. 
> They're global symbols and they form part of the RCU API - they should be
> kernel docified, please.

Please note that the rcu_pending() interface was never intended for
external use -- it is purely internal to the RCU infrastructure.
If there is a new external use for rcu_pending(), then it would need to
be documented.  But I would rather this one stay internal -- different
RCU implementations might need different things.

So, what are we trying to do here?

> There's probably a reason why neither of these symbols are exported to
> modules.  Once they're actually documented I mught be able to work out what
> that reason is ;)

The reason for rcu_pending() was that it is a private interface.

					Thanx, Paul
