Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWIPTbZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWIPTbZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 15:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWIPTbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 15:31:25 -0400
Received: from opersys.com ([64.40.108.71]:18182 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S1751182AbWIPTbY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 15:31:24 -0400
Message-ID: <450C55DF.2090206@opersys.com>
Date: Sat, 16 Sep 2006 15:51:59 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Jes Sorensen <jes@sgi.com>, Roman Zippel <zippel@linux-m68k.org>,
       Andrew Morton <akpm@osdl.org>, tglx@linutronix.de,
       Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org> <20060915181907.GB17581@elte.hu> <Pine.LNX.4.64.0609152111030.6761@scrub.home> <20060915200559.GB30459@elte.hu> <20060915202233.GA23318@Krystal> <450BCAF1.2030205@sgi.com> <20060916172419.GA15427@Krystal> <20060916173552.GA7362@elte.hu> <20060916175606.GA2837@Krystal> <20060916191043.GA22558@elte.hu>
In-Reply-To: <20060916191043.GA22558@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
> i have done a bit of kprobes and djprobes testing on a 2160 MHz Athlon64 
> CPU, UP. I have tested 2 types of almost-NOP tracepoints (on 2.6.17), 
> where the probe function only increases a counter:
> 
>  static int counter;
> 
>  static void probe_func(struct djprobe *djp, struct pt_regs *regs)
>  {
>          counter++;
>  }
> 
> and have measured the overhead of an unmodified, kprobes-probed and 
> djprobes-probed sys_getpid() system-call:
> 
>  sys_getpid() unmodified latency:    317 cycles   [ 0.146 usecs ]
>  sys_getpid() kprobes latency:       815 cycles   [ 0.377 usecs ]
>  sys_getpid() djprobes latency:      380 cycles   [ 0.176 usecs ]
> 
> i.e. the kprobes overhead is +498 cycles (+0.231 usecs), the djprobes 
> overhead is +63 cycles (+0.029 usecs).

But that's an entirely hypothetical benchmark. Mathieu was asked for
real-workload benchmarks and he gave you those. In turn, you set up
a simplistic test and then go on to conclude that the measurements
are far less than advertised. You ask that ltt replace its static
instrumentation by what kprobes provides and Mathieu demonstrated
that that's not realistic. If you want to change his mind, at least
reproduce the exact information ltt can provide and then we'll
talk.

> what do these numbers tell us? Firstly, on this CPU the kprobes overhead 
> is not 1000-2000 cycles but 500 cycles. Secondly, if that's not fast 
> enough, the "next-gen kprobes" code, djprobes have a really small 
> overhead of 63 cycles.

But djprobe isn't even here yet. If you insist on keeping ltt's
_current_ limitations as your single most powerful justification to
reject it, how you hold kprobes to a different standard with a
straight face? You're only perpetuating the fallacy found
throughout this thread that somehow the shortcomings of dynamic
editing are "easy" to fix while those of static instrumentation are
inherently unrecoverable. That's just plain not true, as I've
demonstrated now countless times in this thread.

And please Ingo, I'm still waiting for your feedback on the static
markup mechanism I proposed earlier. I believe it avoids every
single problem you alluded to with regards to the problems generated
by inline markup.

Thanks,

Karim
-- 
President  / Opersys Inc.
Embedded Linux Training and Expertise
www.opersys.com  /  1.866.677.4546
