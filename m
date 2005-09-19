Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbVISH3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbVISH3N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 03:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbVISH3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 03:29:13 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:26569 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932358AbVISH3M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 03:29:12 -0400
Date: Mon, 19 Sep 2005 09:28:42 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Shaohua Li <shaohua.li@intel.com>, vatsa@in.ibm.com,
       Nigel Cunningham <ncunningham@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: PATCH: Fix race in cpu_down (hotplug cpu)
Message-ID: <20050919072842.GA11293@elte.hu>
References: <59D45D057E9702469E5775CBB56411F171F7E0@pdsmsx406> <20050919051024.GA8653@in.ibm.com> <1127107887.3958.9.camel@linux-hp.sh.intel.com> <20050919055715.GE8653@in.ibm.com> <1127110271.9696.97.camel@localhost> <20050919062336.GA9466@in.ibm.com> <1127111830.4087.3.camel@linux-hp.sh.intel.com> <1127111784.5272.10.camel@npiggin-nld.site> <1127113930.4087.6.camel@linux-hp.sh.intel.com> <1127114538.5272.16.camel@npiggin-nld.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127114538.5272.16.camel@npiggin-nld.site>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> On Mon, 2005-09-19 at 15:12 +0800, Shaohua Li wrote:
> > On Mon, 2005-09-19 at 16:36 +1000, Nick Piggin wrote:
> 
> > > Ah, actually I have a patch which makes all CPU idle threads
> > > run with preempt disabled and only enable preempt when scheduling.
> > > Would that help?
> > It should solve the issue to me. Should we take care of the latency?
> > acpi_processor_idle might execute for a long time.
> > 
> 
> Oh really? I think yes, the latency should be taken care of because we 
> want to be able to provide good latency even for !preempt kernels. If 
> a solution can be found for acpi_processor_idle, that would be ideal.

the ACPI idle code runs with irqs disabled anyway, so there's no issue 
here. If something takes long there, we can do little about it. (but in 
practice ACPI sleep latencies are pretty ok - the only latencies i found 
in the past were due to need_resched bugs in the ACPI idle routine)

> IMO it always felt kind of hackish to run the idle threads with 
> preempt on.

Yes, idle threads can have preemption disabled. There's not any big 
difference in terms of latencies, the execution paths are all very 
short.

	Ingo
