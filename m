Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbWIOVlR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWIOVlR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 17:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWIOVlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 17:41:16 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:59845 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932298AbWIOVlQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 17:41:16 -0400
Date: Fri, 15 Sep 2006 23:32:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       tglx@linutronix.de, karim@opersys.com, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060915213213.GA12789@elte.hu>
References: <450AB506.30802@sgi.com> <450AB957.2050206@opersys.com> <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com> <1158332447.5724.423.camel@localhost.localdomain> <20060915111644.c857b2cf.akpm@osdl.org> <20060915181907.GB17581@elte.hu> <Pine.LNX.4.64.0609152111030.6761@scrub.home> <20060915200559.GB30459@elte.hu> <20060915202233.GA23318@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060915202233.GA23318@Krystal>
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


* Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca> wrote:

> * Ingo Molnar (mingo@elte.hu) wrote:
> > sorry, but i disagree. There _is_ a solution that is superior in every 
> > aspect: kprobes + SystemTap. (or any other equivalent dynamic tracer)
> > 
> 
> I am sorry to have to repeat myself, but this is not true for heavy 
> loads.

djprobes?

> > > At this point you've been rather uncompromising [...]
> > 
> > yes, i'm rather uncompromising when i sense attempts to push inferior 
> > concepts into the core kernel _when_ a better concept exists here and 
> > today. Especially if the concept being pushed adds more than 350 
> > tracepoints that expose something to user-space that amounts to a 
> > complex external API, which tracepoints we have little chance of ever 
> > getting rid of under a static tracing concept.
> > 
> From an earlier email from Tim bird :
> 
> "I still think that this is off-topic for the patch posted.  I think 
> we should debate the implementation of tracepoints/markers when 
> someone posts a patch for some.  I think it's rather scurrilous to 
> complain about code NOT submitted.  Ingo has even mis-characterized 
> the not-submitted instrumentation patch, by saying it has 350 
> tracepoints when it has no such thing.  I counted 58 for one 
> architecture (with only 8 being arch-specific)."

i missed that (way too many mails in this thread).

Here is how i counted them:

 $ grep "\<trace_.*(" * | wc -l
 359

some of those are not true tracepoints, but there's at least this many 
of them:

 $ grep "\<trace_.*(" *instrumentation* | wc -l
 235

so the real number is somewhere between.

 patch-2.6.17-lttng-0.5.108-instrumentation-arm.diff
 patch-2.6.17-lttng-0.5.108-instrumentation.diff
 patch-2.6.17-lttng-0.5.108-instrumentation-i386.diff
 patch-2.6.17-lttng-0.5.108-instrumentation-mips.diff
 patch-2.6.17-lttng-0.5.108-instrumentation-powerpc.diff
 patch-2.6.17-lttng-0.5.108-instrumentation-ppc.diff
 patch-2.6.17-lttng-0.5.108-instrumentation-s390.diff
 patch-2.6.17-lttng-0.5.108-instrumentation-sh.diff
 patch-2.6.17-lttng-0.5.108-instrumentation-x86_64.diff

when judging kernel maintainance overhead, the sum of all patches 
matters. And i considered all the other patches too (the ones that add 
actual tracepoints) that will come after the currently offered ones, not 
just the ones you submitted to lkml.

	Ingo
