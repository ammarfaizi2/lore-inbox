Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262468AbUKRQXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262468AbUKRQXz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 11:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262778AbUKRQXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 11:23:54 -0500
Received: from dvhart.com ([64.146.134.43]:47745 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S262468AbUKRQWV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 11:22:21 -0500
Subject: Re: [patch] scheduler: rebalance_tick interval update
From: Darren Hart <darren@dvhart.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Matt Dobson <colpatch@us.ibm.com>,
       Martin J Bligh <mbligh@aracnet.com>,
       Rick Lindsley <ricklind@us.ibm.com>
In-Reply-To: <1100620602.14742.36.camel@farah.beaverton.ibm.com>
References: <1100558313.17202.58.camel@localhost.localdomain>
	 <4199550E.1030704@cyberone.com.au> <1100569992.30259.20.camel@arrakis>
	 <41996353.1060604@cyberone.com.au>
	 <1100576400.14742.12.camel@farah.beaverton.ibm.com>
	 <4199957C.1020804@cyberone.com.au>
	 <1100620602.14742.36.camel@farah.beaverton.ibm.com>
Content-Type: text/plain
Date: Thu, 18 Nov 2004 08:22:16 -0800
Message-Id: <1100794936.21255.7.camel@farah.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-16 at 07:56 -0800, Darren Hart wrote:
> > >This example didn't take into account:
> > >	unsigned long j = jiffies + CPU_OFFSET(this_cpu);
> > >Which, even if the last_balance's were equal and intervals were the same
> > >(unlikely since each CPU has it's own domain and the intervals are
> > >adjusted independently?),
> > >
> > 
> > That is correct.
> > 
> > > would prevent them from both running on the
> > >same timer tick.  So I don't think this example is accurate.  On the
> > >other hand, even if it was valid, I would prefer this to running the
> > >load_balance code on the same CPU and domain several ticks in a row
> > >(which obviously accomplishes nothing).
> > >
> > 
> > It is valid because the CPU_OFFSET basically just adds a constant amount
> > to each CPU's 'jiffies'. My example took that into account already and
> > used the absolute jiffies value. If that doesn't convince you, pretend
> > that the delay were to occur to CPU0, whos CPU_OFFSET == 0.
> 
> 
> Heh, I thought of exactly that case when I rolled out of bed this
> morning.  Funny how that happens sometimes, you can be sitting in front
> of the code and make what you think is a perfectly valid analysis and
> then wake up the next morning with no context at all and realize you
> were wrong.  That happens to me anyway :-), I can't be the only one...
> 
> Nevertheless, that is a pretty unlikely corner case.  They double up
> only when last_balance+interval is the same and one of the CPUs involved
> is CPU 0.
> 


Hey Nick,

I haven't heard anything on this thread in a couple of days, do you
agree we should me the change?  I feel there are legitimate reasons to
use =jiffies instead of +=interval for the ->last_balanced assignment.
I have already elaborated on these and provided counter arguments to the
ones you posted that I think make a strong case.  If you still oppose
the change, what would I need to provide to convince you?


-- 
Darren Hart <darren@dvhart.com>

