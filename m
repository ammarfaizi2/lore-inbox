Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750955AbWIPKkm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955AbWIPKkm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 06:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWIPKkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 06:40:42 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:9649 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750955AbWIPKkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 06:40:40 -0400
Message-ID: <450BD4C7.8030000@sgi.com>
Date: Sat, 16 Sep 2006 12:41:11 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060907)
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
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu>	<Pine.LNX.4.64.0609141537120.6762@scrub.home>	<20060914135548.GA24393@elte.hu>	<Pine.LNX.4.64.0609141623570.6761@scrub.home>	<20060914171320.GB1105@elte.hu>	<Pine.LNX.4.64.0609141935080.6761@scrub.home>	<20060914181557.GA22469@elte.hu> <4509A54C.1050905@opersys.com> <yq08xkleb9h.fsf@jaguar.mkp.net> <450A9EC9.9080307@opersys.com> <450A9D4B.1030901@sgi.com> <450AB408.8020904@opersys.com> <450AB90C.9000403@sgi.com> <450AC2FA.70203@opersys.com>
In-Reply-To: <450AC2FA.70203@opersys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour wrote:
> Jes Sorensen wrote:
>> There very few tracepoints in this category,
> 
> Wow, that's progress.

Karim,

A personal question?, do you feel that being patronising and insulting
is in any way going to put your LTT project in a better light? It
certainly makes it a  lot harder for many of us to take your arguments
serious.

>> the only things you can claim are more or less generic are syscalls,
 >> and tracing syscall handling is tricky.
> 
> If there are implementation issue, I trust an adequate solution can be
> found by using the tested-and-proven method of posting stuff on the
> lkml for review.

And how is this going to solve the case where trace code in the syscall
path has a negative impact on cacheline utilization and alignment, even
when the trace data is not being used?

>> This is grossly over simplifying things and why the whole things doesn't
>> hold water. There is no such thing as 'the place' to put a specific
>> tracepoint.
[snip]
> I do not underestimate the difficulty of selecting such tracepoints.
> This is why I chose not to maintain other people's specific tracepoints.
> I realize this is a tough problem, but I also trust subsystem maintainers
> are smart enough to make the appropriate decision.

So you are back to saying that trace data other people wish to collect
are uninteresting and therefore should just be ignored? If not, what you
are saying there otherwise just backs up the argument that if LTT or
something similar goes into mainline, we will see the amount of
tracepoints grow significantly.

>> You seem to think that it's fine to add instrumentation in the syscall
>> path as an example as long as it's compiled out. Well on some
>> architectures, the syscall path is very sensitive to alignment and there
>> may be restrictions on how large the stub of code is allowed to be, like
>> a few hundred bytes. Just because things work one way on x86, doesn't
>> mean they work like that everywhere.
> 
> If ltt failed to implement such things appropriately, then we apologize.
> That fact doesn't preclude proper implementation in the future, however.

Please read what I wrote above! Touching the syscall path with static
tracepoints is costly and has side effects! The argument that things can
be compiled out is just pointless, end users do not recompile kernels at
random and many of the 'end user' cases where people wish to vizualize
trace data, are running on precompiled vendor kernels. Recompiling the
kernel and rebooting is not an option here!

In fact, the users who wish to trace data in self-compiled kernels are a
tiny subset of the potential userbase for this stuff which is primarily
useful to developers .... which in terms makes your argument about debug
tracepoints irrelevant since you are turning all the tracepoints into
debug tracepoints :)

Jes
