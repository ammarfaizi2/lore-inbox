Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbWINTr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWINTr4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 15:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWINTr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 15:47:56 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:15773 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750830AbWINTrz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 15:47:55 -0400
Date: Thu, 14 Sep 2006 21:47:32 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Ingo Molnar <mingo@elte.hu>
cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
In-Reply-To: <20060914181557.GA22469@elte.hu>
Message-ID: <Pine.LNX.4.64.0609142038570.6761@scrub.home>
References: <20060914033826.GA2194@Krystal> <20060914112718.GA7065@elte.hu>
 <Pine.LNX.4.64.0609141537120.6762@scrub.home> <20060914135548.GA24393@elte.hu>
 <Pine.LNX.4.64.0609141623570.6761@scrub.home> <20060914171320.GB1105@elte.hu>
 <Pine.LNX.4.64.0609141935080.6761@scrub.home> <20060914181557.GA22469@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 14 Sep 2006, Ingo Molnar wrote:

> > > for me these are all _independent_ grounds for rejection, as a generic 
> > > kernel infrastructure.
> > 
> > Tracepoints of course need to be managed, but that's true for both 
> > dynamic and static tracepoints. [...]
> 
> that's not true, and this is the important thing that i believe you are 
> missing. A dynamic tracepoint is _detached_ from the normal source code 
> and thus is zero maintainance overhead. You dont have to maintain it 
> during normal development - only if you need it. You dont see the 
> dynamic tracepoints in the source code.
> 
> a static tracepoint, once it's in the mainline kernel, is a nonzero 
> maintainance overhead _until eternity_.

I hope you do realize that this a rather selfish point of view. The zero 
maintainance overhead is a myth, only because _you_ don't have to do it.
OTOH maintaining the trace points along with the corresponding source is 
a barely noticable noise and is certainly less work than having them to 
maintain separately.

> It is a constant visual 
> hindrance and a constant build-correctness and boot-correctness problem 
> if you happen to change the code that is being traced by a static 
> tracepoint. Again, I am talking out of actual experience with static 
> tracepoints: i frequently break my kernel via static tracepoints and i 
> have constant maintainance cost from them.

Sorry, but you're not the only one with actual experience and in my 
experience the value far outweighs the occasional need for adjustments. If 
you don't use them, they are of course a nuisance, but is your personal 
dislike really reason enough to deny others a useful tool?

> i am giving a line by line rebuttal of all arguments that come up. 
> Please be fair and do the same. Here are the arguments again, for a 
> third time. Thanks!

Ingo, maybe you should try to understand the point I'm trying to make?
You mostly emphasize your personal dislike of static tracepoints.

> > > also, the other disadvantages i listed very much count too. Static 
> > > tracepoints are fundamentally limited because:
> > > 
> > >   - they can only be added at the source code level
> > > 
> > >   - modifying them requires a reboot which is not practical in a
> > >     production environment
> > > 
> > >   - there can only be a limited set of them, while many problems need
> > >     finegrained tracepoints tailored to the problem at hand
> > > 
> > >   - conditional tracepoints are typically either nonexistent or very
> > >     limited.

Sorry, but I fail to see the point you're trying to make (beside your 
personal preferences), none of this is a unsolvable problem, which would 
prevent making good use of static tracepoints.

> > > the kprobes infrastructure, despite being fairly young, is widely 
> > > available: powerpc, i386, x86_64, ia64 and sparc64. The other 
> > > architectures are free to implement them too, there's nothing 
> > > hardware-specific about kprobes and the "porting overhead" is in 
> > > essence a one-time cost - while for static tracepoints the 
> > > maintainance overhead goes on forever and scales linearly with the 
> > > number of tracepoints added.
> > 
> > kprobes are not trivial to implement [...]
> 
> nor are smp-alternatives, which was suggested as a solution to reduce 
> the overhead of static tracepoints. So what's the point? It's a one-off 
> development overhead that has already been done for all the major 
> arches. If another arch needs it they can certainly implement it.

Static tracepoints don't have to be implemented via alternatives and
you continue to ignore that kprobes are nontrivial, you continue to ignore 
that both can coexist just fine. You just want to force your personal 
preferences onto others. :-(

> it's like arguing against ptrace on the grounds of: "application 
> developers can add printf if they want to debug their apps, or they can 
> add static tracepoints too, and besides, ptrace is hard to implement".

Sorry, I don't understand this point. Ptrace support would match kernel 
gdb support, which would be a complete different discussion...

> > I also think you highly exaggerate the maintaince overhead of static 
> > tracepoints, once added they hardly need any maintainance, most of the 
> > time you can just ignore them. [...]
> 
> hundreds (or possibly thousands) of tracepoints? Have you ever tried to 
> maintain that? I have and it's a nightmare.

_This_ discussion is about a core set of trace points! Yes, you can have 
thousands of trace points in drivers, but they don't have to be enabled by 
default and are no reason at all against a few core trace point, which 
can be used by _all_ archs to trace core events as _cheaply_ as possible.

> Even assuming a rich set of hundreds of static tracepoints, it doesnt 
> even solve the problems at hand: people want to do much more when they 
> probe the kernel - and today, with DTrace under Solaris people _know_ 
> that much better tracing _can be done_, and they _demand_ that Linux 
> adopts an intelligent solution. The clock is ticking for dinosaurs like 
> static printks and static tracepoints to debug the kernel...

Huh? How exactly do static tracepoints prevent you from doing this?
Different problems require different solutions, nobody is taking Kprobes 
away, but why should Kprobes be the only solution?

bye, Roman
