Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbWIOMeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWIOMeZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 08:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWIOMeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 08:34:24 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:56546 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751352AbWIOMeX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 08:34:23 -0400
Message-ID: <450A9D4B.1030901@sgi.com>
Date: Fri, 15 Sep 2006 14:32:11 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: karim@opersys.com
Cc: Ingo Molnar <mingo@elte.hu>, Roman Zippel <zippel@linux-m68k.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu>	<Pine.LNX.4.64.0609141537120.6762@scrub.home>	<20060914135548.GA24393@elte.hu>	<Pine.LNX.4.64.0609141623570.6761@scrub.home>	<20060914171320.GB1105@elte.hu>	<Pine.LNX.4.64.0609141935080.6761@scrub.home>	<20060914181557.GA22469@elte.hu> <4509A54C.1050905@opersys.com> <yq08xkleb9h.fsf@jaguar.mkp.net> <450A9EC9.9080307@opersys.com>
In-Reply-To: <450A9EC9.9080307@opersys.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour wrote:
> Jes Sorensen wrote:
>>> And who should pay here? The people who want the tracepoints or the
>> people who are not interested in them?
> 
> If you'd care to read through the thread you'd notice I've demonstrated
> time and again that those static trace points we're mostly interested
> in a never-changing. Lest something fundamentally changes with the
> kernel, there will always be a scheduling change; etc.

Except as I pointed out, that everyone wants their info slightly
differently so even trace points in the scheduler will be contentious
and we will end up with a stack of them if we are to satisfy everyone.
So now, you didn't demonstrate anything.

> This
> "instrumentation is evil" mantra is only substantiated if you view
> it from the point of view of someone who's only used it to debug code.
> Yet, and I repeat this again, instrumentation for in-source debugging
> is but a corner case of instrumentation in general.

Given that I have used this stuff to more than just debug code, then
this obviously doesn't apply.

>> You have obviously never tried to maintain a codebase for a long
>> time.
> 
> Please, this is not constructive. I've never really grasped the need
> for posturing on LKML. Jes, I'm not going to fight a war of resumes
> with you. If you think I'm incompetent then there's very little I can
> do to change your mind.

You refuse to take the big picture into account and then claim that
there is no cost of doing things your way. Point being that once you
start maintaining a large project such as the kernel, or just parts of
it, you realize how much those 'zero cost' additions really cost.

>> Not to mention that some of the classical places people wish to add
>> those static tracepoints are in performance sensitive codepaths,
>> syscalls for example.
> 
> And this argument ignores everything I said on how there does not need
> be the limitation currently known to previous static tracing mechanisms.

And how does there not? If you want to add tracepoints to the syscall
path, then you will make an impact. It's non trivial to validate, yes
I have seen some scary attempts of adding LTT tracecalls to the ia64
syscall path, and just because it might not be compiled in in most cases
that doesn't mean it doesn't raise the complexity.

>> You can do pretty much everything you want to do with dynamic
>> tracepoints, it's just a matter of whether you want to dump the burden
>> of maintenance on someone else. Been there done that, had to show
>> people in the past how to do with dynamic points what they insisted
>> had to be done with static points.
> 
> Yes, Mr. Scrub, I mean kprobes is your answer. The only reason you can
> get away with this argument is if you view it exclusively from the
> point of view of kernel development. And that's why you're wrong.

As I said, kprobes are much more than kernel development! But you
obviously haven't bothered looking at those properly! Been there done
that!

>> So you maintain the tracepoints in the kernel and you are offering to
>> take over maintenance of all code that now contain these tracepoints?
> 
> Please explain, honestly, why the following instrumentation point is
> going to be a maintenance drag on the person modifying the scheduler:
> @@ -1709,6 +1712,7 @@ switch_tasks:
>    		++*switch_count;
> 
>    		prepare_arch_switch(rq, next);
> +		TRACE_SCHEDCHANGE(prev, next);
>    		prev = context_switch(rq, prev, next);
>    		barrier();
> 
> And please, don't bother complaining about the semantics, they can
> be changed. I'm just arguing about location/meaning/content.

It will be a drag because next week someone else wants a tracepoint
5 lines further down the code! Again, I have seen people try and do
that on top of the old LTT patchsets, so maybe *you* didn't want the
tracepoint somewhere else, but some people did! Next?

>> You add your static tracepoints, next week someone else wants some
>> very similar but slightly different points, the following week it's
>> someone else. Thanks, but no thanks.
> 
> Obviously there's no point in me spelling any code of conduct to
> anyone, Martin has already pointed out that it's up to the subsystem
> maintainers to decide what's appropriate and what's not, as is
> customary anyway. But the issue I'm putting forth here is that there
> is value for allowing outsiders to understand the dynamic behavior of
> your code and the only person who can do that best is the person
> writing the code. It is then that person's responsibility to
> distinguish between instrumentation they may find important to debug
> their code and instrumentation that would be relevant to those using
> their code. And if you've maintained code long enough, and I trust
> you do, you would see that there is a clear difference between both.

You are once again ignoring the point that not everyone needs the exact
same view of things that you are looking for. Dynamic probes allows for
that, doing that with static probes is going to turn into maintenance
hell. Guess what, some of us still try to look after code 8-10 years
after we wrote it initially.

Jes
