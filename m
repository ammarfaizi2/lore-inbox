Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262817AbTLIE7a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 23:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbTLIE7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 23:59:30 -0500
Received: from dp.samba.org ([66.70.73.150]:33502 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262817AbTLIE73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 23:59:29 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Ingo Molnar <mingo@redhat.com>, Anton Blanchard <anton@samba.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Zwane Mwaikambo <zwane@zwane.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] make cpu_sibling_map a cpumask_t 
In-reply-to: Your message of "Mon, 08 Dec 2003 15:25:54 +1100."
             <3FD3FD52.7020001@cyberone.com.au> 
Date: Tue, 09 Dec 2003 10:46:48 +1100
Message-Id: <20031209045929.437362C002@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3FD3FD52.7020001@cyberone.com.au> you write:
> I'm not aware of any reason why the kernel should not become generally
> SMT aware. It is sufficiently different to SMP that it is worth
> specialising it, although I am only aware of P4 and POWER5 implementations.

To do it properly, it should be done within the NUMA framework.  That
would allow generic slab cache optimizations, etc.  We'd really need a
multi-level NUMA framework for this though.

But patch looks fine.

> I have an alternative to Ingo's HT scheduler which basically does
> the same thing. It is showing a 20% elapsed time improvement with a
> make -j3 on a 2xP4 Xeon (4 logical CPUs).

Me too.

My main argument with Ingo's patch (last I looked) was technical: the
code becomes clearer if the structures are explicitly split into the
"per-runqueue stuff" and the "per-cpu stuff" (containing a my_runqueue
pointer).

I'd be very interested in your patch though, Nick.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
