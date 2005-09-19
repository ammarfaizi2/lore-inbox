Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932359AbVISHhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932359AbVISHhS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 03:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbVISHhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 03:37:18 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:49291 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932359AbVISHhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 03:37:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Subject:From:To:Cc:In-Reply-To:References:Content-Type:Date:Message-Id:Mime-Version:X-Mailer:Content-Transfer-Encoding;
  b=oaUoM0R7nkmprJL3BcSpleeABs880AO653khDife9zyVv2TChet/LNEiDqbLfROho7b2IOigWnj/2K9FifltoyJEARUki11rsA/LoPYLcH9HavfGsJG0bwF8QTsfep3EbJiJcR9G6ZnCKW5xuVd708dyb3unl/Erwu0xRgzosOo=  ;
Subject: Re: PATCH: Fix race in cpu_down (hotplug cpu)
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: Shaohua Li <shaohua.li@intel.com>, vatsa@in.ibm.com,
       Nigel Cunningham <ncunningham@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       lkml <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
In-Reply-To: <20050919072842.GA11293@elte.hu>
References: <59D45D057E9702469E5775CBB56411F171F7E0@pdsmsx406>
	 <20050919051024.GA8653@in.ibm.com>
	 <1127107887.3958.9.camel@linux-hp.sh.intel.com>
	 <20050919055715.GE8653@in.ibm.com> <1127110271.9696.97.camel@localhost>
	 <20050919062336.GA9466@in.ibm.com>
	 <1127111830.4087.3.camel@linux-hp.sh.intel.com>
	 <1127111784.5272.10.camel@npiggin-nld.site>
	 <1127113930.4087.6.camel@linux-hp.sh.intel.com>
	 <1127114538.5272.16.camel@npiggin-nld.site>
	 <20050919072842.GA11293@elte.hu>
Content-Type: text/plain
Date: Mon, 19 Sep 2005 17:37:05 +1000
Message-Id: <1127115425.5272.21.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-19 at 09:28 +0200, Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> > Oh really? I think yes, the latency should be taken care of because we 
> > want to be able to provide good latency even for !preempt kernels. If 
> > a solution can be found for acpi_processor_idle, that would be ideal.
> 
> the ACPI idle code runs with irqs disabled anyway, so there's no issue 
> here. If something takes long there, we can do little about it. (but in 
> practice ACPI sleep latencies are pretty ok - the only latencies i found 
> in the past were due to need_resched bugs in the ACPI idle routine)
> 

Ah, in that case I agree: we have nothing to worry about by merging
such a patch then.

> > IMO it always felt kind of hackish to run the idle threads with 
> > preempt on.
> 
> Yes, idle threads can have preemption disabled. There's not any big 
> difference in terms of latencies, the execution paths are all very 
> short.
> 

Thanks for the confirmation Ingo. This is part of my "cleanup resched
and cpu_idle" patch FYI. It should already be in -mm, but has some
trivial EM64T bug in it that Andrew hits but I can't reproduce.

I'll dust it off and send it out, hopefully someone will be able to
reproduce the problem!

-- 
SUSE Labs, Novell Inc.



Send instant messages to your online friends http://au.messenger.yahoo.com 
