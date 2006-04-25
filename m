Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932112AbWDYF10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbWDYF10 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 01:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932113AbWDYF10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 01:27:26 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:55650 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S932112AbWDYF1Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 01:27:25 -0400
Date: Tue, 25 Apr 2006 07:27:21 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: dipankar@in.ibm.com, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org, davem@davemloft.net,
       schwidefsky@de.ibm.com, "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: Re: [patch] RCU: introduce rcu_soon_pending() interface
Message-ID: <20060425052721.GA9458@osiris.boeblingen.de.ibm.com>
References: <20060424111141.GC16007@osiris.boeblingen.de.ibm.com> <20060424160943.4bbdb788.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060424160943.4bbdb788.akpm@osdl.org>
User-Agent: mutt-ng/devel-r802 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
> 
> There's probably a reason why neither of these symbols are exported to
> modules.  Once they're actually documented I mught be able to work out what
> that reason is ;)

Maybe rcu_batch_pending() would be a better name for rcu_soon_pending(). Also
rcu_batch_in_work() would be a more descriptive name for rcu_pending() as far
as I can tell.
Actually I was hoping for a better solution from the rcu experts, since I
don't like this too, but couldn't find something better.
