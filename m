Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbWIONVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbWIONVG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 09:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbWIONVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 09:21:06 -0400
Received: from smtp.ocgnet.org ([64.20.243.3]:24195 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S1751407AbWIONVE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 09:21:04 -0400
Date: Fri, 15 Sep 2006 22:20:53 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Karim Yaghmour <karim@opersys.com>
Cc: Jes Sorensen <jes@sgi.com>, Ingo Molnar <mingo@elte.hu>,
       Roman Zippel <zippel@linux-m68k.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, Tom Zanussi <zanussi@us.ibm.com>,
       ltt-dev@shafik.org, Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: [PATCH 0/11] LTTng-core (basic tracing infrastructure) 0.5.108
Message-ID: <20060915132052.GA7843@localhost.usen.ad.jp>
References: <20060914112718.GA7065@elte.hu> <Pine.LNX.4.64.0609141537120.6762@scrub.home> <20060914135548.GA24393@elte.hu> <Pine.LNX.4.64.0609141623570.6761@scrub.home> <20060914171320.GB1105@elte.hu> <Pine.LNX.4.64.0609141935080.6761@scrub.home> <20060914181557.GA22469@elte.hu> <4509A54C.1050905@opersys.com> <yq08xkleb9h.fsf@jaguar.mkp.net> <450A9EC9.9080307@opersys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <450A9EC9.9080307@opersys.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2006 at 08:38:33AM -0400, Karim Yaghmour wrote:
> If you'd care to read through the thread you'd notice I've demonstrated
> time and again that those static trace points we're mostly interested
> in a never-changing. Lest something fundamentally changes with the
> kernel, there will always be a scheduling change; etc. This
> "instrumentation is evil" mantra is only substantiated if you view
> it from the point of view of someone who's only used it to debug code.
> Yet, and I repeat this again, instrumentation for in-source debugging
> is but a corner case of instrumentation in general.
> 
I didn't get the "instrumentation is evil" mantra from this thread,
rather "static tracepoints are good, so long as someone else is
maintaining them". The issue comes down to who ends up maintaining the
trace points, and given with how intrusive LTT was in the past, I can't
see anyone wanting to suddenly start littering them around the kernel
now (at least in the areas that they're responsible for, particularly if
it's not something that's going to be useful to most people). Admittedly
LTTng is not as bad at this as LTT was in this regard, though.

If static tracepoints are something that's useful for you, then you
can continue maintaining them out of tree.

> Yes, Mr. Scrub, I mean kprobes is your answer. The only reason you can
> get away with this argument is if you view it exclusively from the
> point of view of kernel development. And that's why you're wrong.
> 
kprobes may not be the answer to all lifes problems, but it is
non-intrusive once the initial implementation pains are out of the way..

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
> 
For someone complaining about meaningless posturing on the list, posting
this as a representation for the isolated changes involved is rather
interesting. If it were down to a small handful of critical static
tracepoints in-tree and the rest left up to the people that really want
them in out-of-tree patches, I doubt LTT would have ever had half of the
resistance towards it.

It's the intrusiveness that becomes the maintenance burden, and if you
whittle it down to a point where the intrusiveness is not that big of a
deal, then I'm not sure I see what static points would buy you over
dynamic instrumentation.

It's easy to write off the maintenance overhead when you aren't the one
maintaining the code..
