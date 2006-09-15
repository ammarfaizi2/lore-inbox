Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751480AbWION7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbWION7M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 09:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbWION7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 09:59:11 -0400
Received: from opersys.com ([64.40.108.71]:54534 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S1751482AbWION7K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 09:59:10 -0400
Message-ID: <450AB408.8020904@opersys.com>
Date: Fri, 15 Sep 2006 10:09:12 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
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
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu>	<Pine.LNX.4.64.0609141537120.6762@scrub.home>	<20060914135548.GA24393@elte.hu>	<Pine.LNX.4.64.0609141623570.6761@scrub.home>	<20060914171320.GB1105@elte.hu>	<Pine.LNX.4.64.0609141935080.6761@scrub.home>	<20060914181557.GA22469@elte.hu> <4509A54C.1050905@opersys.com> <yq08xkleb9h.fsf@jaguar.mkp.net> <450A9EC9.9080307@opersys.com> <450A9D4B.1030901@sgi.com>
In-Reply-To: <450A9D4B.1030901@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jes Sorensen wrote:
> Except as I pointed out, that everyone wants their info slightly
> differently so even trace points in the scheduler will be contentious
> and we will end up with a stack of them if we are to satisfy everyone.
> So now, you didn't demonstrate anything.

There is in my view, and this is what this whole debate is really
about, a clear difference in between the type of instrumentation
being added. Clearly in the view of others there just isn't. But
bare with me. I submit to you that there are 3 classes of trace
points:

- OS-class: These are trace points which will be found in a given
  kernel regardless of how it is implemented if it belongs to a
  certain family of OSes. Linux being made to mimic Unix, it will
  always have key events. And if you look closely at the initial
  set of points added by ltt, these would be found in any Unix.
  It's not for nothing that my paper on ltt was accepted at Usenix
  2000 - and in fact during the question period somebody asked how
  easy it would be to port it to BSD, and the answer: trivial.

- Subsystem-class: These are trace points which are specific to
  a given implementation. Say block tracing, scsi tracing, etc. as
  they are implemented in Linux. The purpose of these is to allow
  a user of these given subsystems to get more in-depth understanding
  of what's happening inside the box.

- Debug-class: These are trace points required to find difficult
  problems such as race-conditions/etc. which are needed to debug
  the OS.

I'm not arguing for the inclusion of debug tracepoints. I can see
that within a given subsystem there can be disagreement over the
placement of specific tracepoints, and this is where I think your
argument lies and it is not without merit - IOW such tracepoints
should be more carefully scrutinized. However, there are OS-class
tracepoints for which I hardly see any possible debate either in
terms of usefulness or in terms of maintainability.

> Given that I have used this stuff to more than just debug code, then
> this obviously doesn't apply.
...
> You refuse to take the big picture into account and then claim that
> there is no cost of doing things your way. Point being that once you
> start maintaining a large project such as the kernel, or just parts of
> it, you realize how much those 'zero cost' additions really cost.

Someone else alluded to the parallel between in-code comments and
documentation maintained separately. There is a cost to in-code
instrumentation in the same way that there is to in-code documentation.
And they, in fact, are very much alike.

> And how does there not? If you want to add tracepoints to the syscall
> path, then you will make an impact. It's non trivial to validate, yes
> I have seen some scary attempts of adding LTT tracecalls to the ia64
> syscall path, and just because it might not be compiled in in most cases
> that doesn't mean it doesn't raise the complexity.

Again, this is an implementation issue. If we have a way to mark-up
code, then we can at least "hide" much of the scary stuff.

> As I said, kprobes are much more than kernel development! But you
> obviously haven't bothered looking at those properly! Been there done
> that!

I have, and taking an int3 on every tracepoint wasn't my liking, nor
was having to chase kernel versions for binary editing. If I was going
do maintenance I was much happier to work with source than binary.

> It will be a drag because next week someone else wants a tracepoint
> 5 lines further down the code! Again, I have seen people try and do
> that on top of the old LTT patchsets, so maybe *you* didn't want the
> tracepoint somewhere else, but some people did! Next?

Not if you understand the distinction I am making above.

Now, I can understand that you may think: Karim, nobody is going to
fsck'ing care about the distinction you're making once this is in
the kernel. But for me this is a separate, but yet entirely relevant,
part of the debate. The argument here has already been pointed out
elsewhere: There are already subsystem maintainers and they are more
than capable of taking the appropriate decisions. The distinction I
make above is not esoteric.

> You are once again ignoring the point that not everyone needs the exact
> same view of things that you are looking for. Dynamic probes allows for
> that, doing that with static probes is going to turn into maintenance
> hell. Guess what, some of us still try to look after code 8-10 years
> after we wrote it initially.

I'm not ignoring that people have different needs. I'm being depicted
as endorsing static traces all over the place, and I'm not advocating
such a course of action. The only reason any argument against static
instrumentation can be made is if you consider it from the debug
point of view and what drag such instrumentation would have. There is
a big difference of purpose and of persistent-relevance in between
debug instrumentation of os-class instrumentation. It's entirely
disingenuous to suggest otherwise.

Karim
