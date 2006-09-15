Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751697AbWIOUQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbWIOUQF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 16:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751703AbWIOUQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 16:16:04 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:31697 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751697AbWIOUQB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 16:16:01 -0400
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: tglx@linutronix.de, karim@opersys.com, Paul Mundt <lethal@linux-sh.org>,
       Jes Sorensen <jes@sgi.com>, Roman Zippel <zippel@linux-m68k.org>,
       Ingo Molnar <mingo@elte.hu>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>
In-Reply-To: <20060915111644.c857b2cf.akpm@osdl.org>
References: <20060914181557.GA22469@elte.hu> <4509A54C.1050905@opersys.com>
	 <yq08xkleb9h.fsf@jaguar.mkp.net> <450A9EC9.9080307@opersys.com>
	 <20060915132052.GA7843@localhost.usen.ad.jp>
	 <Pine.LNX.4.64.0609151535030.6761@scrub.home>
	 <20060915135709.GB8723@localhost.usen.ad.jp> <450AB5F9.8040501@opersys.com>
	 <450AB506.30802@sgi.com> <450AB957.2050206@opersys.com>
	 <20060915142836.GA9288@localhost.usen.ad.jp> <450ABE08.2060107@opersys.com>
	 <1158332447.5724.423.camel@localhost.localdomain>
	 <20060915111644.c857b2cf.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 15 Sep 2006 21:37:13 +0100
Message-Id: <1158352633.29932.141.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-09-15 am 11:16 -0700, ysgrifennodd Andrew Morton:
> What Karim is sharing with us here (yet again) is the real in-field
> experience of real users (ie: not kernel developers).

A lot of us have plenty of experience helping customers and end users
trace bugs. Thats a good part of why we get paid in the first place.

> What I _am_ concerned about with this patchset is all the infrastructural
> goop which backs up those tracepoints.  I'd have thought that a better
> approach would be to make those explicit tracepoints be "helpers" for the
> existing kprobe code.

If you put explicit tracepoints in they will be compiled out for end
users. If you have a script which hits the standard tracepoint set it'll
be usable by end users.

> Of course, it they are properly designed, the one set of tracepoints could
> be used by different tracing backends - that allows us to separate the
> concepts of "tracepoints" and "tracing backends".

There are more than two layers. The first question is "how do I trace
event XYZ" which seems to be the big debate. The second is "how do I
find XYZ" which seems to have some commonality. The third is "what do I
do when the event is hit", which kprobes provides to all the existing
consumers such as systemtap and can field into arrays for graph plotting
and the like.

Ignoring the question of static compiled in trace points kprobes appears
to have solved the problem space. Everyone else can use the kprobes
interfaces to do pretty much anything computationally viable.

I am sceptical about static tracepoints in critical spots because if
they make the variable easy to access they will reduce optimisations and
that will cost a lot more than 5 or 6 clocks.

In addition ideally we want a mechanism that is also sufficient that
printk can be mangled into so that you can pull all the printk text
strings _out_ of the kernel and into the debug traces for embedded work.

[ie you want printk("Oh dear %s exploded.\n", foo->bar); to end up with
"Oh dear %s exploded.\n" out of kernel and in kernel

		tracepoint_printk(foo->bar);

maybe with minimal type info (although that can be pulled at debug time
from the string spat into the debug data).]

 
Alan

