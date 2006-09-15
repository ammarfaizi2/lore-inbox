Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWIOJVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWIOJVB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 05:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWIOJVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 05:21:01 -0400
Received: from jaguar.mkp.net ([192.139.46.146]:50587 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S1750772AbWIOJVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 05:21:00 -0400
To: karim@opersys.com
Cc: Ingo Molnar <mingo@elte.hu>, Roman Zippel <zippel@linux-m68k.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu>
	<Pine.LNX.4.64.0609141537120.6762@scrub.home>
	<20060914135548.GA24393@elte.hu>
	<Pine.LNX.4.64.0609141623570.6761@scrub.home>
	<20060914171320.GB1105@elte.hu>
	<Pine.LNX.4.64.0609141935080.6761@scrub.home>
	<20060914181557.GA22469@elte.hu> <4509A54C.1050905@opersys.com>
From: Jes Sorensen <jes@sgi.com>
Date: 15 Sep 2006 05:20:58 -0400
In-Reply-To: <4509A54C.1050905@opersys.com>
Message-ID: <yq08xkleb9h.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Karim" == Karim Yaghmour <karim@opersys.com> writes:

Karim> Ingo Molnar wrote:
>> that's not true, and this is the important thing that i believe you
>> are missing. A dynamic tracepoint is _detached_ from the normal
>> source code and thus is zero maintainance overhead. You dont have
>> to maintain it during normal development - only if you need it. You
>> dont see the dynamic tracepoints in the source code.

Karim> And that's actually a problem for those who maintain such
Karim> dynamic trace points.

And who should pay here? The people who want the tracepoints or the
people who are not interested in them?

>> a static tracepoint, once it's in the mainline kernel, is a nonzero
>> maintainance overhead _until eternity_. It is a constant visual
>> hindrance and a constant build-correctness and boot-correctness
>> problem if you happen to change the code that is being traced by a
>> static tracepoint. Again, I am talking out of actual experience
>> with static tracepoints: i frequently break my kernel via static
>> tracepoints and i have constant maintainance cost from them. So
>> what i do is that i try to minimize the number of static
>> tracepoints to _zero_. I.e. i only add them when i need them for a
>> given bug.

Karim> Bzzt, wrong. This is your own personal experience with
Karim> tracing. Marked up code does not need to be active under all
Karim> build conditions. In fact trace points can be inactive by
Karim> default at all times, except when you choose to build them in.

You have obviously never tried to maintain a codebase for a long
time. Even if the code is not activated, you make a change and
something breaks and people come running and screaming, or the thing
is in the way for the structural code change you want to make.

Not to mention that some of the classical places people wish to add
those static tracepoints are in performance sensitive codepaths,
syscalls for example.

>> static tracepoints are inferior to dynamic tracepoints in almost
>> every way.

Karim> Sorry, orthogonal is the word.

You can do pretty much everything you want to do with dynamic
tracepoints, it's just a matter of whether you want to dump the burden
of maintenance on someone else. Been there done that, had to show
people in the past how to do with dynamic points what they insisted
had to be done with static points.

>> hundreds (or possibly thousands) of tracepoints? Have you ever
>> tried to maintain that? I have and it's a nightmare.

Karim> I have, and I've showed you that you're wrong. The only reason
Karim> you can make this argument is that you view these things from
Karim> the point of view of what use they are for you as a kernel
Karim> developer and I will repeat what I've said for years now:
Karim> static instrumentation of the kernel isn't meant to be useful
Karim> for kernel developers.

So you maintain the tracepoints in the kernel and you are offering to
take over maintenance of all code that now contain these tracepoints?
You add your static tracepoints, next week someone else wants some
very similar but slightly different points, the following week it's
someone else. Thanks, but no thanks.

Karim> Nevertheless there are
Karim> very legitimate uses for standardized instrumentation points.

Some evidence would be useful here, so far you haven't provided any.

Jes
