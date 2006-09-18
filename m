Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965555AbWIRIOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965555AbWIRIOt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 04:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965556AbWIRIOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 04:14:49 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:39096 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S965555AbWIRIOs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 04:14:48 -0400
Message-ID: <450E5540.4080205@sgi.com>
Date: Mon, 18 Sep 2006 10:13:52 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: karim@opersys.com
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       tglx@linutronix.de, Paul Mundt <lethal@linux-sh.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060915132052.GA7843@localhost.usen.ad.jp>	<Pine.LNX.4.64.0609151535030.6761@scrub.home>	<20060915135709.GB8723@localhost.usen.ad.jp>	<450AB5F9.8040501@opersys.com>	<450AB506.30802@sgi.com>	<450AB957.2050206@opersys.com>	<20060915142836.GA9288@localhost.usen.ad.jp>	<450ABE08.2060107@opersys.com>	<1158332447.5724.423.camel@localhost.localdomain>	<20060915111644.c857b2cf.akpm@osdl.org>	<20060915181907.GB17581@elte.hu> <20060915131317.aaadf568.akpm@osdl.org> <450BCF97.3000901@sgi.com> <450C20C7.30604@opersys.com>
In-Reply-To: <450C20C7.30604@opersys.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour wrote:
> Jes Sorensen wrote:
> Good. So give me concrete examples of those cases that you saw and tell
> me exactly what those people you were working with were attempting to
> achieve.

I don't have all the details at hand, but it included syscalls and
scheduler points amongst others.

> Either ltt had a userbase or it didn't. To say that all its users went
> out and added their own tracepoints is to not know enough about the project
> and so too is it to say that none of its users could actually just use
> it out of the box without modifying it. Now, as an outsider, trying to
> measure how many users were using it without modifying it is like
> trying to figure out how many Linux users there are out there. There's
> a silent majority and there's those that need customization. Guess
> who you've been talking to?

Or maybe people start looking at it not knowing whether the want to
pursue it to the end for their product.

> Strange, come to think of it I don't remember *ever* getting an
> email from you while being the maintainer or seing *any* emails by you
> on the ltt lists -- that's indicative of mindset, namely that you
> personally assumed you knew all about tracing and didn't need us to make
> suggestions to help you AND that you personally never found it relevant
> to contribute back.

There's a word for that: *plonk*

Maybe the code was used to evaluate it as an option, maybe they realized
it wasn't worth using in the end, maybe they decided they could make it
work. Maybe the LTT mailing list had been *dead* for 18 months by the
time? You know, reading C code isn't that hard, and it didn't state
anywhere in the LTT license that one is required to take out a paying
contract with a certain Mr. Yaghmour just to be allowed to compile the
code.

> The semantics are primitive at this stage, and they could definitely
> benefit from lkml input, but essentially we have a build-time parser
> that goes around the code and automagically does one of two things:
> a) create information for binary editors to use
> b) generate an alternative C file (foo-trace.c) with inlined static
>    function calls.

You intend to handle inline assembly how? You plan to handle the issue
of debugging the code when the markup is present how?

> And there might be other possibilities I haven't thought of.
> 
> This beats every argument I've seen to date on static instrumentation.
> Namely:
> - It isn't visually offensive: it's a comment.
> - It's not a maintenance drag: outdated comments are not alien.
> - It doesn't use weird function names or caps: it's a comment.
> - There is precedent: kerneldoc.
> And it does preserve most of the key things those who've asked for
> static markup are looking for. Namely:
> - Static instrumentation
> - Mainline maintainability
> - Contextualized variables

And it doesn't address the following issues:

a) The static community providing actual evidence that dynamic tracing
   is noticably slower.
b) It will not be enabled per default in vendor kernels so in practice
   the information will not be available anywhere, only in debug
   kernels.
c) The point that we will end up with markups all over the place to
   satisfy everybody's needs.

>> The other part is the constantly repeated performance claim, which to
>> this point hasn't been backed up by any hard evidence. If we are to take
>> that argument serious, then I strongly encourage the LTT community to
>> present some real numbers, but until then it can be classified as
>> nothing but FUD.
> 
> Hmm... beats me why even the systemtap folks would themselves admit
> to performance limitations.

Everything has performance limitations, you keep running around touting
that static is the only thing thats not a problem. Now show us the
numbers!

>> I shall be the first to point out that kprobes are less than ideal,
>> especially the current ia64 implementation suffers from some tricky
>> limitations, but thats an implementation issue.
> 
> Ah, so it's ok for kprobes to have implementation issues, but not ltt.
> Somehow there's this magic thought recurring throughout this thread
> that the limitations of dynamic instrumentation are trivial to fix,
> but those of static instrumentation are unrecoverable. *That* is a
> fallacy if I ever saw one. I'm willing to admit that a combination of
> dynamic editing and static instrumentation is a good balance, but Jes
> please drop this discourse, it's not constructive.

Oh so bringing fact into a discussion is not allowed. Karim, maybe you
should try using some real arguments. What I am saying about the ia64
implementation is that there are limitations but I am also saying they
can be fixed, it's an implementation issue, not a problem with the
concept.

The problems pointed out with LTT are *conceptual*, but of course you
keep ignoring the facts and refusing to provide real numbers.

Says it all really ....

Jes
