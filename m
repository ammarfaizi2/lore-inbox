Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbWINTij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbWINTij (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 15:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbWINTii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 15:38:38 -0400
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:27580 "EHLO
	outbound2-cpk-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1751075AbWINTih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 15:38:37 -0400
X-BigFish: V
Message-ID: <4509B03A.3070504@am.sony.com>
Date: Thu, 14 Sep 2006 12:40:42 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
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
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Roman Zippel <zippel@linux-m68k.org> wrote:
> 
>>> for me these are all _independent_ grounds for rejection, as a generic 
>>> kernel infrastructure.
>> Tracepoints of course need to be managed, but that's true for both 
>> dynamic and static tracepoints. [...]
> 
> that's not true, and this is the important thing that i believe you are 
> missing. A dynamic tracepoint is _detached_ from the normal source code 
> and thus is zero maintainance overhead. You dont have to maintain it
> during normal development - only if you need it. You dont see the
> dynamic tracepoints in the source code.

It's only zero maintenance overhead for you.  Someone has to
maintain it. The party line for years has been that in-tree
maintenance is easier than out-of-tree maintenance.

> 
> a static tracepoint, once it's in the mainline kernel, is a nonzero 
> maintainance overhead _until eternity_. It is a constant visual 
> hindrance and a constant build-correctness and boot-correctness problem 
> if you happen to change the code that is being traced by a static 
> tracepoint. Again, I am talking out of actual experience with static 
> tracepoints: i frequently break my kernel via static tracepoints and i 
> have constant maintainance cost from them. So what i do is that i try to 
> minimize the number of static tracepoints to _zero_. I.e. i only add 
> them when i need them for a given bug.

Ingo - I'm sure you are doing things at a level where static tracepoints
impose a significant perturbation to the code.  However, if you look
historically at the set of static tracepoints that people have used
with Linux (with LTT or LKST), they are really not too bad to maintain.  I'm
repeating what others have said, but I've been working with LTT and
LTTng for several years, and the tracepoints haven't changed very much
in that time.   Heck, I've even brought LTTng up on new kernel versions
and new architectures.  How hard could it be if I can do it? ;-)
(Of course, who knows if I did it right? - since it's out-of-tree it
doesn't get as much testing.)

The set of static tracepoints (or markers) that is envisioned is in the
range of about 30 to 40 key kernel events.  Dynamic tracepoints would
be used for other stuff.

I don't want to offend you, but I suspect your usage model for tracepoints
is different from what the expected (and historical) usage model
would be for LTTng-style static tracepoints.

> 
> static tracepoints are inferior to dynamic tracepoints in almost every 
> way.
>
>> [...]  Both have their advantages and disadvantages and just hammering 
>> on the possible problems of static ones [...]
> 
> how about giving a line by line rebuttal to the very real problems of 
> static tracepoints i listed (twice already), instead of calling them 
> "possible problems"?

I respect your experience, but I think it would be more productive
to have this debate when a patch is submitted with a static tracepoint (or marker)
implementation.  The patch in question, if I understand correctly, provides
infrastructure for tracing activities and should hopefully be useful for
either static or dynamic tracepoints.  I'm hoping someone from the SystemTAP
camp can speak up and give their opinion on whether this is useful.  If it is,
then the whole debate about static vs. dynamic tracepoints is less important.
If not, then that's a different debate.

I maintain Kernel Function Trace (KFT) out-of-tree.  This is a system which
uses compiler flags to instrument every kernel function entry and exit.  For obvious
reasons this type of instrumentation is used only during development, but it has
proven quite handy for certain development tasks (finding long-duration routines and
finding bloated call sequences).   I can imagine KFT using the infrastructure
that is provided by the LTTng-core patch (and relinquishing my own infrastructure
for activation, trace control, event handling etc.)

Regards,
 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================

