Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965169AbWIRAfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965169AbWIRAfU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 20:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965171AbWIRAfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 20:35:20 -0400
Received: from opersys.com ([64.40.108.71]:51727 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S965169AbWIRAfT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 20:35:19 -0400
Message-ID: <450DEEA5.7080808@opersys.com>
Date: Sun, 17 Sep 2006 20:56:05 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Nicholas Miell <nmiell@comcast.net>, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       "Frank Ch. Eigler" <fche@redhat.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: tracepoint maintainance models
References: <450D182B.9060300@opersys.com> <20060917112128.GA3170@localhost.usen.ad.jp> <20060917143623.GB15534@elte.hu> <1158524390.2471.49.camel@entropy> <20060917230623.GD8791@elte.hu>
In-Reply-To: <20060917230623.GD8791@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been following the evolution of this thread from a distance and must
point out that this "static" vs. "dynamic" issue has been cleared up
numerous times already. Your persistence in further continuing this
prompts me to provide the casual reader -- as if anyone is still
reading any of this -- with a least a minimum of correct semantics.

Ingo Molnar wrote:
> what is being proposed here is entirely different from dprobes though: 
> Roman suggests that he doesnt want to implement kprobes on his arch, and 
> he wants LTT to remain an _all-static_ tracer. That's the point where i 
> beg to differ: static markers are fine (but they should be kept to a 
> minimum), but generic static /tracers/ need alot more than just a few 
> static markers to be meaningful.
> 
> So if we accepted static tracers into the kernel, we'd automatically 
> commit (for a long period of time) to a much larger body of static 
> markers - and i'm highly uncomfortable about that. (for the many reasons 
> outlined before)
> 
> Even if the LTT folks proposed to "compromise" to 50 tracepoints - users 
> of static tracers would likely _not_ be willing to compromise, so there 
> would be a constant (and I say unnecessary) battle going on for the 
> increase of the number of static markers. Static markers, if done for 
> static tracers, have "viral" (Roman: here i mean "auto-spreading", not 
> "disease") properties in that sense - they want to spread to alot larger 
> area of code than they start out from.

The distinction you make is not substantiated by the factual record. See
overlap between lket list of events and *old* ltt list of events:
http://sourceware.org/systemtap/man5/lket.5.html

There is, actually, no reason to believe that end-users of dynamic trace
infrastructures are any more tolerant to breakage than, say, those of
the *old* ltt. In fact, Jose's feedback as a maintainer is exactly the
opposite. So, then, is Jose's SystemTap-based LKET a "static tracer"?
Based on your logic I would have to conclude that it is indeed so. In
fact, if some of SystemTap's important scripts get mainlined, then so
will SystemTap be "static" according to your benchmark.

There are in fact at least three parts to this, and for the life of me
I can't find any trace of an explanation of why you choose to persist
in claiming that it's the same puddle: a) the markup, b) the mechanism,
c) the events list.

You have agreed, up to this point, that static markup is needed. Good,
let's build on that. Because what I, at least, and Roman I believe
seems to want the same thing, have been advocating is that for a given
marker A, let there be a choice to the person building that kernel of
whether A resolves into probe-information or direct call to a direct
inline function. Granted, how either of these is implemented has not
yet been figured out, and neither need be implemented with the type of
limitations known to such things in the passed; as has been explained
to you many times.

And, in my opinion, this is as far as the discussion need to go for
now: let the mechanism not be tied to the markup.

But, you insist in going further and claim that a given trigger
mechanism implies a given dependency on a list of events. That is
where I'm completely lost. While it is true that the *old* ltt
rigidly implemented such a dependency, this is no *inherent* link
between mechanism and dependency on a given event list -- LKET being
a prime counter-example to your logic.

If you would care to actually investigate the *new* ltt, you would
actually see an entirely different picture, as has been clearly
explained to you by Mathieu. The thing is but an engine to deal
with the interpretation of large event streams -- I said it in
my other post: it inherits from my work but the name. It, in
fact, supports the injection of new event set definitions at
every new trace. Do you understand this fact? LTTng will allow
you to feed it definitions for the events you actually have in
a trace so that it can render them to you. IOW it will *not*
break because a static tracepoint went away. The importance of
such things, and the substantial interest from SystemTap folks
and LKET folks for such features of LTTng, is of course lost on
you because you're *convinced* that you're an expert on every
kind of tracing just because you personally implemented a couple
of basic highly-customized static tracers. It evades you that
some people out there may have actually put a lot more thought in
streamlining much of the irritants of basic tracing mechanisms.
The importance of this is lost on you: You are *convinced* that
what exists is only what you were personally able to make of
tracing mechanisms. I will let casual readers decide what this means
about everything you said up to this point, especially in the
light of the fact that you *never* showed at any Linux tracing
event, gathering or project which is represented by those projects
you so desperately wish to dictate the integration of.

For my part, I think it's much too early to discuss event lists.
In fact, no such thing was ever posted by Mathieu. The only
reason set event lists were discussed was discussion surrounding
the *old* ltt. And, if anything, the last few days should have made
it clear to the educated reader that, at this point in time, the
*old* ltt is but a case for academic study.

So please, of a) markup, b) mechanism, c) event list, let's
concentrate on a generic markup first.

And again, much of this has already been said elsewhere numerous
times. This is just a semantic addition to previous explanations.

Karim
-- 
President  / Opersys Inc.
Embedded Linux Training and Expertise
www.opersys.com  /  1.866.677.4546
