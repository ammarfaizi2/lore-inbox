Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751556AbWDYLdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbWDYLdf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 07:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751561AbWDYLdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 07:33:35 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:51809 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751520AbWDYLde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 07:33:34 -0400
Subject: Re: [patch] RCU: introduce rcu_soon_pending() interface
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: paulmck@us.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, Heiko Carstens <heiko.carstens@de.ibm.com>,
       dipankar@in.ibm.com, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org, davem@davemloft.net
In-Reply-To: <20060425112310.GA16612@us.ibm.com>
References: <20060424111141.GC16007@osiris.boeblingen.de.ibm.com>
	 <20060424160943.4bbdb788.akpm@osdl.org> <20060425112310.GA16612@us.ibm.com>
Content-Type: text/plain
Organization: IBM Corporation
Date: Tue, 25 Apr 2006 13:33:37 +0200
Message-Id: <1145964817.5282.66.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-04-25 at 04:23 -0700, Paul E. McKenney wrote:
> > Neither rcu_pending() nor rcu_soon_pending() are commented or documented. 
> > Pity the poor user trying to work out what they do, and how they differ. 
> > They're global symbols and they form part of the RCU API - they should be
> > kernel docified, please.
> 
> Please note that the rcu_pending() interface was never intended for
> external use -- it is purely internal to the RCU infrastructure.
> If there is a new external use for rcu_pending(), then it would need to
> be documented.  But I would rather this one stay internal -- different
> RCU implementations might need different things.
> 
> So, what are we trying to do here?

We are trying to find out if an idle cpu needs to continue to tick every
HZ or if we can put it into deep sleep. If there is any kind of rcu work
pending that requires the idle cpu to call in later via a timer
interrupt, we need to know.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


