Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbWIOMRy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbWIOMRy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 08:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWIOMRy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 08:17:54 -0400
Received: from opersys.com ([64.40.108.71]:18438 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S1751340AbWIOMRx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 08:17:53 -0400
Message-ID: <450A9EC9.9080307@opersys.com>
Date: Fri, 15 Sep 2006 08:38:33 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Jes Sorensen <jes@sgi.com>
CC: Ingo Molnar <mingo@elte.hu>, Roman Zippel <zippel@linux-m68k.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu>	<Pine.LNX.4.64.0609141537120.6762@scrub.home>	<20060914135548.GA24393@elte.hu>	<Pine.LNX.4.64.0609141623570.6761@scrub.home>	<20060914171320.GB1105@elte.hu>	<Pine.LNX.4.64.0609141935080.6761@scrub.home>	<20060914181557.GA22469@elte.hu> <4509A54C.1050905@opersys.com> <yq08xkleb9h.fsf@jaguar.mkp.net>
In-Reply-To: <yq08xkleb9h.fsf@jaguar.mkp.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jes Sorensen wrote:
> Karim> And that's actually a problem for those who maintain such
> Karim> dynamic trace points.
> 
> And who should pay here? The people who want the tracepoints or the
> people who are not interested in them?

If you'd care to read through the thread you'd notice I've demonstrated
time and again that those static trace points we're mostly interested
in a never-changing. Lest something fundamentally changes with the
kernel, there will always be a scheduling change; etc. This
"instrumentation is evil" mantra is only substantiated if you view
it from the point of view of someone who's only used it to debug code.
Yet, and I repeat this again, instrumentation for in-source debugging
is but a corner case of instrumentation in general.

> You have obviously never tried to maintain a codebase for a long
> time.

Please, this is not constructive. I've never really grasped the need
for posturing on LKML. Jes, I'm not going to fight a war of resumes
with you. If you think I'm incompetent then there's very little I can
do to change your mind.

> Not to mention that some of the classical places people wish to add
> those static tracepoints are in performance sensitive codepaths,
> syscalls for example.

And this argument ignores everything I said on how there does not need
be the limitation currently known to previous static tracing mechanisms.

> You can do pretty much everything you want to do with dynamic
> tracepoints, it's just a matter of whether you want to dump the burden
> of maintenance on someone else. Been there done that, had to show
> people in the past how to do with dynamic points what they insisted
> had to be done with static points.

Yes, Mr. Scrub, I mean kprobes is your answer. The only reason you can
get away with this argument is if you view it exclusively from the
point of view of kernel development. And that's why you're wrong.

> So you maintain the tracepoints in the kernel and you are offering to
> take over maintenance of all code that now contain these tracepoints?

Please explain, honestly, why the following instrumentation point is
going to be a maintenance drag on the person modifying the scheduler:
@@ -1709,6 +1712,7 @@ switch_tasks:
   		++*switch_count;

   		prepare_arch_switch(rq, next);
+		TRACE_SCHEDCHANGE(prev, next);
   		prev = context_switch(rq, prev, next);
   		barrier();

And please, don't bother complaining about the semantics, they can
be changed. I'm just arguing about location/meaning/content.

> You add your static tracepoints, next week someone else wants some
> very similar but slightly different points, the following week it's
> someone else. Thanks, but no thanks.

Obviously there's no point in me spelling any code of conduct to
anyone, Martin has already pointed out that it's up to the subsystem
maintainers to decide what's appropriate and what's not, as is
customary anyway. But the issue I'm putting forth here is that there
is value for allowing outsiders to understand the dynamic behavior of
your code and the only person who can do that best is the person
writing the code. It is then that person's responsibility to
distinguish between instrumentation they may find important to debug
their code and instrumentation that would be relevant to those using
their code. And if you've maintained code long enough, and I trust
you do, you would see that there is a clear difference between both.

Thanks,

Karim
-- 
President  / Opersys Inc.
Embedded Linux Training and Expertise
www.opersys.com  /  1.866.677.4546
