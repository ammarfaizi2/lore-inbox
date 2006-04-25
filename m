Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751548AbWDYLwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbWDYLwa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 07:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbWDYLwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 07:52:30 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:44646 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751515AbWDYLw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 07:52:29 -0400
Date: Tue, 25 Apr 2006 13:52:26 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, dipankar@in.ibm.com,
       manfred@colorfullife.com, linux-kernel@vger.kernel.org,
       davem@davemloft.net, schwidefsky@de.ibm.com
Subject: Re: [patch] RCU: introduce rcu_soon_pending() interface
Message-ID: <20060425115226.GA9421@osiris.boeblingen.de.ibm.com>
References: <20060424111141.GC16007@osiris.boeblingen.de.ibm.com> <20060424160943.4bbdb788.akpm@osdl.org> <20060425052721.GA9458@osiris.boeblingen.de.ibm.com> <20060425114656.GA16719@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060425114656.GA16719@us.ibm.com>
User-Agent: mutt-ng/devel-r802 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, got a look at your patch.
> 
> You are using this internally, as part of the RCU -implementation-.
> You are determining whether this CPU will still be needed by RCU,
> or whether it can be turned off.  So how 'bout calling the (internal)
> API something like rcu_needs_cpu()?
> 
> int rcu_needs_cpu(int cpu)
> {
> 	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
> 	struct rcu_data *rdp_bh = &per_cpu(rcu_bh_data, cpu);
> 
> 	return (!!rdp->curlist || !!rdp_bh->curlist || rcu_pending(cpu));
> }
> 
> Then you can drop the rcu_pending() check from your 390 patch.
> 
> Seem reasonable?

Looks fine to me! Will you post a patch or should I?
