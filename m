Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbWIOWKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbWIOWKJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 18:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbWIOWKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 18:10:09 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:65191 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932311AbWIOWKH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 18:10:07 -0400
Message-ID: <450B22F0.6090504@us.ibm.com>
Date: Fri, 15 Sep 2006 17:02:24 -0500
From: "Jose R. Santos" <jrs@us.ibm.com>
Reply-To: jrs@us.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
CC: Ingo Molnar <mingo@elte.hu>, Roman Zippel <zippel@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>, tglx@linutronix.de, karim@opersys.com,
       Paul Mundt <lethal@linux-sh.org>, Jes Sorensen <jes@sgi.com>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <450AB957.2050206@opersys.com> <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com> <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org> <20060915181907.GB17581@elte.hu> <Pine.LNX.4.64.0609152111030.6761@scrub.home> <20060915200559.GB30459@elte.hu> <20060915202233.GA23318@Krystal> <450B164B.7090404@us.ibm.com> <20060915212541.GA18958@Krystal>
In-Reply-To: <20060915212541.GA18958@Krystal>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers wrote:
> * Jose R. Santos (jrs@us.ibm.com) wrote:
> > To some people performance is the #1 priority and to other it is 
> > flexibility.  I would like to come up with a list of those probe point 
> > that absolutely need to be inserted into the code statically.  Those 
> > that are not absolutely critical to have statically should be 
> > implemented dynamically.
> > 
>
> I agree with you that only very specific parts of the kernel have this kind of
> high throughput. Using kprobes for lower thoughput tracepoints if perfectly
> acceptable from my point of view, as it does not perturb the system too much.
>
> I would suggest (as a beginning) those "standard" hi event rate tracepoints :
>
> (taken from the highest rates in
> http://sourceware.org/ml/systemtap/2005-q4/msg00451.html)
>
> - syscall entry/exit
> - irq entry/exit
> - softirq entry/exit
> - tasklet entry/exit
> - trap entry/exit
> - scheduler change
> - wakeup
> - network traffic (packet in/out)
> - "select" and "poll" system calls
> - page_alloc/page_free
>
> (be warned : this list is probably incomplete, too exhaustive or can cause
> dizziness under stress condition) :)
>
> However, a tracing infrastructure should still provide the ability for
> developers to instrument their own high traffic interrupt handler with a very
> low overhead.
>   
This is base on a single scenario, which is wrong.  A criteria needs to 
be establish that describes the justification for a static trace hook.  
Base on the previous comments on the thread, this list is already seems 
to big.

If a user of the trace tool absolutely need to have the best 
performance, then the propose tool should be smart enough to use static 
hooks if available but revert back to dynamic probes if there is no 
available static counter part.  This performance static tracepoint patch 
can be maintained outside of the kernel tree without bloating the 
kernel.  This way he can have mostly dynamic trace point but at least 
provide some sort of mechanism for those that absolutely must have 
static hooks in order to get useful data out of the trace tool.

-JRS


