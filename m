Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750942AbWINSn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbWINSn4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 14:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751015AbWINSn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 14:43:56 -0400
Received: from opersys.com ([64.40.108.71]:3088 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S1750942AbWINSnz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 14:43:55 -0400
Message-ID: <4509A54C.1050905@opersys.com>
Date: Thu, 14 Sep 2006 14:54:04 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8.0.6) Gecko/20060804 Fedora/1.0.4-0.5.1.fc5 SeaMonkey/1.0.4
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Roman Zippel <zippel@linux-m68k.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu> <Pine.LNX.4.64.0609141537120.6762@scrub.home> <20060914135548.GA24393@elte.hu> <Pine.LNX.4.64.0609141623570.6761@scrub.home> <20060914171320.GB1105@elte.hu> <Pine.LNX.4.64.0609141935080.6761@scrub.home> <20060914181557.GA22469@elte.hu>
In-Reply-To: <20060914181557.GA22469@elte.hu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo Molnar wrote:
> that's not true, and this is the important thing that i believe you are 
> missing. A dynamic tracepoint is _detached_ from the normal source code 
> and thus is zero maintainance overhead. You dont have to maintain it 
> during normal development - only if you need it. You dont see the 
> dynamic tracepoints in the source code.

And that's actually a problem for those who maintain such dynamic
trace points.

> a static tracepoint, once it's in the mainline kernel, is a nonzero 
> maintainance overhead _until eternity_. It is a constant visual 
> hindrance and a constant build-correctness and boot-correctness problem 
> if you happen to change the code that is being traced by a static 
> tracepoint. Again, I am talking out of actual experience with static 
> tracepoints: i frequently break my kernel via static tracepoints and i 
> have constant maintainance cost from them. So what i do is that i try to 
> minimize the number of static tracepoints to _zero_. I.e. i only add 
> them when i need them for a given bug.

Bzzt, wrong. This is your own personal experience with tracing. Marked
up code does not need to be active under all build conditions. In
fact trace points can be inactive by default at all times, except
when you choose to build them in.

And as I said elsewhere, the fact that your use of instrumentation is
solely for debugging ("i only add them when i need them for a given bug"),
I repeat that there are mortals out there that need this for their
applications.

> static tracepoints are inferior to dynamic tracepoints in almost every 
> way.

Sorry, orthogonal is the word.

> hundreds (or possibly thousands) of tracepoints? Have you ever tried to 
> maintain that? I have and it's a nightmare.

I have, and I've showed you that you're wrong. The only reason you can
make this argument is that you view these things from the point of view
of what use they are for you as a kernel developer and I will repeat
what I've said for years now: static instrumentation of the kernel
isn't meant to be useful for kernel developers. While it may indeed
be in some cases, in most cases it's likely useless, as you've been
very successfully arguing in this thread. Nevertheless there are very
legitimate uses for standardized instrumentation points.

> Even assuming a rich set of hundreds of static tracepoints, it doesnt 
> even solve the problems at hand: people want to do much more when they 
> probe the kernel - and today, with DTrace under Solaris people _know_ 
> that much better tracing _can be done_, and they _demand_ that Linux 
> adopts an intelligent solution. The clock is ticking for dinosaurs like 
> static printks and static tracepoints to debug the kernel...

Thank you, I couldn't have put it better. This paragraph, more than
any other snippet I've seen to date, clearly demonstrates why
tracing is such a contentious issue. Kernel developers use tracing
during their normal development process, and of course their gut
reaction is: why the hell would anybody need this for mainline? But
of course this misses the entire point. Kernel tracing for developers
is but a corner case of kernel tracing in general. There are very valid
and legitimate reasons for userspace to be able to obtain important
events. And of course any infrastructure developed with that in
mind should also be usable by kernel developers.

Karim
