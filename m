Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbWI0Im1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbWI0Im1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 04:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbWI0Im1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 04:42:27 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:19605 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750817AbWI0Im0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 04:42:26 -0400
Date: Wed, 27 Sep 2006 10:34:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: 2.6.18-rt1
Message-ID: <20060927083419.GC12149@elte.hu>
References: <20060920141907.GA30765@elte.hu> <20060925161215.GA19230@w-mikek2.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060925161215.GA19230@w-mikek2.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Mike Kravetz <kravetz@us.ibm.com> wrote:

> On Wed, Sep 20, 2006 at 04:19:07PM +0200, Ingo Molnar wrote:
> > In particular, a nasty softirq performance bug has been fixed, which 
> > caused the "5x slowdown under TCP" bug reported to lkml - those TCP 
> > performance figures are now on par with vanilla performance.
> 
> Just curious about the cause and fix for this issue.  I tried 
> searching the mail lists for discussion but came up empty.  The patch 
> it too big for me to determine what specific changes addressed this 
> issue.  If anyone can point me in the right direction, that would be 
> appreciated.

i /think/ it's this bit of code commented out in kernel/softirq.c:

        //if (!in_interrupt() && local_softirq_pending())
        //      invoke_softirq();

try to uncomment that. (this should i think do the trick on PREEMPT_RT - 
but no guarantees. It might cause problems on !PREEMPT_RT configs, i had 
to juggle around some code here. Maybe the easiest would be if you tried 
to take the new softirq.c, sans the lockdep changes. Not sure how 
feasible that is though.)

	Ingo
