Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264480AbTLLF2O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 00:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264489AbTLLF2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 00:28:14 -0500
Received: from dp.samba.org ([66.70.73.150]:33222 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264480AbTLLF2N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 00:28:13 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@redhat.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Mark Wong <markw@osdl.org>
Subject: Re: [CFT][RFC] HT scheduler 
In-reply-to: Your message of "Thu, 11 Dec 2003 15:25:29 +1100."
             <3FD7F1B9.5080100@cyberone.com.au> 
Date: Fri, 12 Dec 2003 13:24:12 +1100
Message-Id: <20031212052812.E016B2C072@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <3FD7F1B9.5080100@cyberone.com.au> you write:
> http://www.kerneltrap.org/~npiggin/w26/
> Against 2.6.0-test11
> 
> This includes the SMT description for P4. Initial results shows comparable
> performance to Ingo's shared runqueue's patch on a dual P4 Xeon.

I'm still not convinced.  Sharing runqueues is simple, and in fact
exactly what you want for HT: you want to balance *runqueues*, not
CPUs.  In fact, it can be done without a CONFIG_SCHED_SMT addition.

Your patch is more general, more complex, but doesn't actually seem to
buy anything.  It puts a general domain structure inside the
scheduler, without putting it anywhere else which wants it (eg. slab
cache balancing).  My opinion is either (1) produce a general NUMA
topology which can then be used by the scheduler, or (2) do the
minimal change in the scheduler which makes HT work well.

Note: some of your changes I really like, it's just that I think this
is overkill.

I'll produce a patch so we can have something solid to talk about.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
