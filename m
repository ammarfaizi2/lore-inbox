Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161055AbWBAOC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161055AbWBAOC0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 09:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161058AbWBAOC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 09:02:26 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:31131 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161055AbWBAOCZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 09:02:25 -0500
Date: Wed, 1 Feb 2006 15:00:41 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Avoid moving tasks when a schedule can be made.
Message-ID: <20060201140041.GA5298@elte.hu>
References: <1138736609.7088.35.camel@localhost.localdomain> <43E02CC2.3080805@bigpond.net.au> <1138797874.7088.44.camel@localhost.localdomain> <43E0B24E.8080508@yahoo.com.au> <43E0B342.6090700@yahoo.com.au> <20060201132054.GA31156@elte.hu> <43E0BBEC.3020209@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E0BBEC.3020209@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> >>So it is not a nice thing to tinker with unless there is good reason.
> >
> >unbound latencies with hardirqs off are obviously a good reason - but i 
> >agree that the solution is not good enough, yet.
> 
> Ah, so this is an RT tree thing where the scheduler lock turns off 
> "hard irqs"? [...]

no, this is about the mainline kernel turning off hardirqs for a long 
time. (i used the hardirqs-off terminology instead of irqs-off to 
differentiate it from softirqs-off a'ka local_bh_disable(). It's a 
side-effect of working on the lock validator i guess ;).

> [...] As opposed to something like the rwsem lock that only turns off 
> your "soft irqs" (sorry, I'm not with the terminlogy)?

rwsems/rwlocks are not an issue in -rt because they have different 
semantics there - and thus readers cannot amass. I do think rwsems and 
rwlocks have pretty nasty characteristics [non-latency ones] for the 
mainline kernel's use too, but that's not being argued here ;)

	Ingo
