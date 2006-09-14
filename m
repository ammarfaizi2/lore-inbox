Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751141AbWINUXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbWINUXb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 16:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWINUXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 16:23:31 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:10731 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751141AbWINUXa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 16:23:30 -0400
Date: Thu, 14 Sep 2006 22:14:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Martin Bligh <mbligh@mbligh.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>,
       fche@redhat.com
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060914201448.GA7357@elte.hu>
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu> <450971CB.6030601@mbligh.org> <20060914174306.GA18890@elte.hu> <4509B5A4.2070508@mbligh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4509B5A4.2070508@mbligh.org>
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


* Martin Bligh <mbligh@mbligh.org> wrote:

> an external patch is, indeed, pretty useless. Merging a few simple 
> tracepoints should not be a problem [...]

the problem is, LTT is not about a 'few' tracepoints: it adds a whopping 
350 tracepoints, a fair portion of it is multi-line with tons of 
arguments.

 $ diffstat patch-2.6.17-lttng-0.5.108-instrumentation*
 98 files changed, 1450 insertions(+), 64 deletions(-)

saying "it's just a few lightweight tracepoints" misses two points: it's 
not just a few, and it's not lightweight.

and the set of tracepoints never gets smaller. People who start to rely 
on a tracepoint will scream bloody murder if it goes away or breaks. 
Static tracepoints are a maintainance PITA that will rarely get smaller, 
and will easily grow ...

> [...] - see blktrace and schedstats, for instance.

yes, i do want to remove the 34 schedstats tracepoints too, once a 
feasible alternative is present. I already have to do two compilations 
when changing something substantial in the scheduler - once with and 
once without schedstats.

same for blktrace: once SystemTap can provide a compatible replacement, 
it should.

> It amuses me that we're so opposed to external patches to the tree 
> (for perfectly understandable reasons), but we somehow think 
> tracepoints are magically different and should be maintained out of 
> tree somehow.

i think you misunderstood what i meant. SystemTap should very much be 
integrated into the kernel proper, but i dont think the _rules_ (and 
scripts) should become part of the _source code files themselves_. So 
yes, there's advantage to kernel integration, but there's disadvantage 
to littering the kernel source with countless static tracepoints, if 
dynamic tracepoints can offer the same benefits (or more).

the question is: what is more maintainance, hundreds of static 
tracepoints (with long parameter lists) all around the (core) kernel, or 
hundreds of detached dynamic rules that need an update every now and 
then? [but of which most would still be usable even if some of them 
"broke"] To me the answer is clear: having hundreds of tracepoints 
_within_ the source code is higher cost. But please prove me wrong :-)

	Ingo
