Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263799AbUE1S6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263799AbUE1S6l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 14:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263800AbUE1S6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 14:58:41 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:33479 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263799AbUE1S6i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 14:58:38 -0400
Date: Fri, 28 May 2004 11:57:24 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Arjan van de Ven <arjanv@redhat.com>
cc: "Nakajima, Jun" <jun.nakajima@intel.com>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
       linux-kernel@vger.kernel.org
Subject: Re: CONFIG_IRQBALANCE for AMD64?
Message-ID: <4160000.1085770644@flay>
In-Reply-To: <20040528184411.GE9898@devserv.devel.redhat.com>
References: <7F740D512C7C1046AB53446D372001730182BB40@scsmsx402.amr.corp.intel.com> <2750000.1085769212@flay> <20040528184411.GE9898@devserv.devel.redhat.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Here's my start at a list ... I'm sure it's woefully incomplete.
>> 
>> 1. Utilize all CPUs roughly evenly for IRQ processing load (anything that's
>> not measured by the scheduler at least, because it's unfair to other 
>> processes).
> 
> yep; irqbalance approximates irq processing load by irq count, which seems
> to be ok-ish so far.

Isn't that exactly what the in-kernel one does though? which people were
complaining about (wrt network backend (softirq?) processing)? And some interrupts are much heavier than others, surely?
 
>> Also, we may well have more than 1 CPU's worth of traffic to
>> process in a large network server.
> 
> One NIC? I've yet to see that ;)

No, multiple NICs. but if I shove 8 gigabit adaptors in a machine, we need
more than 1 cpu to process it ... 
 
>> 2. Provide some sort of cache-affinity for network interrupt processing,
>> which also helps us not get into out-of-order packet situations.
> 
> yep; irqbalance does that 
> 
>> 3. Utilize idle CPUs where possible to shoulder the load.
> 
> this is in direct conflict with 2; esp since cpus are idle very short times
> all the time in busy scenarios (and non-busy scenarios are boring wrt irq
> loadf ;)

Mmmm. for benchmarking scenarios, maybe ... but I do believe than machines
aren't maxed out all the time. definitely a problem to determine how long
the idle interval is though. Past history might be a clue, but ... yes, not
easy.

>> 4. Provide such a solution for all architectures.
> 
> irqbalanced in principle arch independent since the /proc interface is quite
> generic..

In principle either way *could* be arch independant ... though the in-kernel
one certainly isn't right now. 

Is there actually any algorithmic difference between the user-space and
in-kernel ones? or is this just a philosophical debate about user vs kernel
placement of code? ;-)

M.



