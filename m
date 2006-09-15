Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbWIOXRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbWIOXRb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 19:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWIOXRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 19:17:31 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:65242 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932363AbWIOXRa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 19:17:30 -0400
Message-ID: <450B3481.9060500@us.ibm.com>
Date: Fri, 15 Sep 2006 18:17:21 -0500
From: "Jose R. Santos" <jrs@us.ibm.com>
Reply-To: jrs@us.ibm.com
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       tglx@linutronix.de, karim@opersys.com, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <450AB957.2050206@opersys.com> <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com> <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org> <20060915181907.GB17581@elte.hu> <Pine.LNX.4.64.0609152111030.6761@scrub.home> <20060915200559.GB30459@elte.hu> <20060915202233.GA23318@Krystal> <450B164B.7090404@us.ibm.com> <20060915220345.GC12789@elte.hu>
In-Reply-To: <20060915220345.GC12789@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Jose R. Santos <jrs@us.ibm.com> wrote:
>
> > [...]  While it is true that static probes will provide less overhead 
> > compared to dynamic probes, [...]
>
> that is not true at all. Yes, an INT3 based kprobe might be expensive if 
> +0.5 usecs per tracepoint (on a 1GHz CPU) is an issue to you - but that 
> is "only" an implementation detail, not a conceptual property. 
> Especially considering that help (djprobes) is on the way. And in the 
> future, as more and more code gets generated (and regenerated) on the 
> fly, dynamic probes will be _faster_ than static probes - plainly 
> because they adapt better to the environment they plug into.
>   
Agree.  And they are details that can be fixed.

One such detail we still see issue with is kretprobes though (which we 
use on LKET for systemcall exit).  These have problem scaling due to 
spinlock issues even on small smp systems.  Its an implementation issue 
that can be fixed but I've been told that the fix is not trivial and 
should not expect it anytime soon.
> so there's basically nothing to balance. My point is that dynamic probes 
> have won or will win on every front, and we shouldnt tie us down with 
> static tracers. 5 years ago with no kprobes, had someone submitted a 
> clean static tracer patchset, we could probably not have resisted it (i 
> though probably would have resisted it on the grounds of maintainance 
> overhead) and would have added it because tracing makes sense in 
> general. But today there's just no reason to add static tracers anymore.
>
> NOTE: i still accept the temporary (or non-temporary) introduction of 
> static markers, to help dynamic tracing. But my expectation is that 
> these markers will be less intrusive than static tracepoints, and a lot 
> more flexible.
>   
Agree here as well.  Sorry, I was also counting static markers as  
static  tracepoint as well.  Even with static markers, there need to be 
balance of what thing need to be implemented with markers vs those that 
can just be done dynamically.

-JRS
