Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbUKPDuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbUKPDuT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 22:50:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbUKPDuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 22:50:19 -0500
Received: from dvhart.com ([64.146.134.43]:40577 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261766AbUKPDuL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 22:50:11 -0500
Subject: Re: [patch] scheduler: rebalance_tick interval update
From: Darren Hart <darren@dvhart.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Matt Dobson <colpatch@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Martin J Bligh <mbligh@aracnet.com>,
       Rick Lindsley <ricklind@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <41996584.5080306@cyberone.com.au>
References: <1100558313.17202.58.camel@localhost.localdomain>
	 <4199550E.1030704@cyberone.com.au> <1100569992.30259.20.camel@arrakis>
	 <41996353.1060604@cyberone.com.au>  <41996584.5080306@cyberone.com.au>
Content-Type: text/plain
Date: Mon, 15 Nov 2004 19:50:04 -0800
Message-Id: <1100577004.14742.25.camel@farah.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-16 at 13:27 +1100, Nick Piggin wrote: 
> 
> Nick Piggin wrote:
> 
> >
> > Another example, in some ticks, a CPU won't see the updated 'jiffies', 
> > other
> > times it will (at least on Altix systems, this can happen).
> >
> >
> 
> Note that if you didn't want to have this rash of balancing attempted after
> a CPU wasn't able to run the rebalance for a long time, the solution would
> be to keep adding the balance interval until it becomes greater than the
> current jiffies.

As I mentioned in my last post, I don't think the "synchronized
rebalancing" is a real concern since the interval isn't likely to be the
same and the CPU_OFFSET macro is already in place to prevent this "rash
of balancing" (nice term :-).

> I actually prefer it to try to make up the lost balances, just from the
> perspective of gathering scheduler statistics. 

IMO, scheduler statistics are not worth running load_balance() for no
reason.  (And running it two or three times in a row is clearly not
accomplishing anything)

> I don't suspect it happens
> enough to justify adding the extra logic - Darren, are you actually seeing
> problems?

Not seeing in obvious problems, but the existing logic seems incorrect
to me (and the term last_balanced is currently misleading).  Running
load_balance() multiple times in order to catch up seems wasteful to me
as well.  The current code says something like: run load_balance() 10
times in a second.  If the second is almost up and you have only run it
6 times, it will run it 4 times in a row, that just seems wrong to me.


-- 
Darren Hart <darren@dvhart.com>

