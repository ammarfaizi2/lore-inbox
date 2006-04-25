Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbWDYMIi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWDYMIi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 08:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbWDYMIi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 08:08:38 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:62389 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750721AbWDYMIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 08:08:37 -0400
Date: Tue, 25 Apr 2006 05:08:54 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, dipankar@in.ibm.com,
       manfred@colorfullife.com, linux-kernel@vger.kernel.org,
       davem@davemloft.net, schwidefsky@de.ibm.com
Subject: Re: [patch] RCU: introduce rcu_soon_pending() interface
Message-ID: <20060425120854.GF16719@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060424111141.GC16007@osiris.boeblingen.de.ibm.com> <20060424160943.4bbdb788.akpm@osdl.org> <20060425052721.GA9458@osiris.boeblingen.de.ibm.com> <20060425114656.GA16719@us.ibm.com> <20060425115226.GA9421@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060425115226.GA9421@osiris.boeblingen.de.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2006 at 01:52:26PM +0200, Heiko Carstens wrote:
> > OK, got a look at your patch.
> > 
> > You are using this internally, as part of the RCU -implementation-.
> > You are determining whether this CPU will still be needed by RCU,
> > or whether it can be turned off.  So how 'bout calling the (internal)
> > API something like rcu_needs_cpu()?
> > 
> > int rcu_needs_cpu(int cpu)
> > {
> > 	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
> > 	struct rcu_data *rdp_bh = &per_cpu(rcu_bh_data, cpu);
> > 
> > 	return (!!rdp->curlist || !!rdp_bh->curlist || rcu_pending(cpu));
> > }
> > 
> > Then you can drop the rcu_pending() check from your 390 patch.
> > 
> > Seem reasonable?
> 
> Looks fine to me! Will you post a patch or should I?

Given that I am getting 24Kbps right now, could you please post it?

							Thanx, Paul
