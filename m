Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751563AbWDYLsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbWDYLsc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 07:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbWDYLsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 07:48:32 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:10654 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751515AbWDYLsb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 07:48:31 -0400
Date: Tue, 25 Apr 2006 04:48:54 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Heiko Carstens <heiko.carstens@de.ibm.com>,
       dipankar@in.ibm.com, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: [patch] RCU: introduce rcu_soon_pending() interface
Message-ID: <20060425114854.GB16719@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20060424111141.GC16007@osiris.boeblingen.de.ibm.com> <20060424160943.4bbdb788.akpm@osdl.org> <20060425112310.GA16612@us.ibm.com> <1145964817.5282.66.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145964817.5282.66.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2006 at 01:33:37PM +0200, Martin Schwidefsky wrote:
> On Tue, 2006-04-25 at 04:23 -0700, Paul E. McKenney wrote:
> > > Neither rcu_pending() nor rcu_soon_pending() are commented or documented. 
> > > Pity the poor user trying to work out what they do, and how they differ. 
> > > They're global symbols and they form part of the RCU API - they should be
> > > kernel docified, please.
> > 
> > Please note that the rcu_pending() interface was never intended for
> > external use -- it is purely internal to the RCU infrastructure.
> > If there is a new external use for rcu_pending(), then it would need to
> > be documented.  But I would rather this one stay internal -- different
> > RCU implementations might need different things.
> > 
> > So, what are we trying to do here?
> 
> We are trying to find out if an idle cpu needs to continue to tick every
> HZ or if we can put it into deep sleep. If there is any kind of rcu work
> pending that requires the idle cpu to call in later via a timer
> interrupt, we need to know.

OK, this confirms my guess that you are acting as part of the RCU
implementation rather than as a normal user of the RCU API.

						Thanx, Paul
