Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161051AbWBAOYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161051AbWBAOYQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 09:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161062AbWBAOYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 09:24:16 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:58285 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1161051AbWBAOYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 09:24:15 -0500
Date: Wed, 1 Feb 2006 15:22:49 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Avoid moving tasks when a schedule can be made.
Message-ID: <20060201142249.GB6277@elte.hu>
References: <1138736609.7088.35.camel@localhost.localdomain> <43E02CC2.3080805@bigpond.net.au> <1138797874.7088.44.camel@localhost.localdomain> <43E0B24E.8080508@yahoo.com.au> <43E0B342.6090700@yahoo.com.au> <20060201132054.GA31156@elte.hu> <43E0BBEC.3020209@yahoo.com.au> <20060201140041.GA5298@elte.hu> <43E0C127.8060401@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E0C127.8060401@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> >rwsems/rwlocks are not an issue in -rt because they have different 
> >semantics there - and thus readers cannot amass. I do think rwsems and 
> >rwlocks have pretty nasty characteristics [non-latency ones] for the 
> >mainline kernel's use too, but that's not being argued here ;)
> 
> But all I'm saying is that while there are equivalent magnitudes of 
> interrupts off regions in mainline, there is little point introducing 
> a hack like this to "solve" one of them.

nobody is arguing to have this hack included. Hacks are to be introduced 
into the scheduler only over my cold dead body ;-) Steve only sent this 
as an RFC thing, to raise the issue.

> If anyone is running hackbench 20 on their sound mixer, then they 
> deserve to have overruns.

just to give you an idea of what we have achieved with the -rt kernel so 
far: my regular -rt stress-test setup has a "hackbench 50" in its 
"deadly mix of SCHED_OTHER workloads", in addition to 40 parallel runs 
of LTP runalltests.sh, with flood pinging and other networking and IO 
stresstests, combined with a task that allocates and dirties a 1.5GB 
buffer in an infinite loop while there's only 1GB of RAM - and still 
during many hours of running this stress-test (which produces a load 
average of 200-500) the -rt kernel runs SCHED_FIFO tasks in 20 usecs, 
worst-case.

	Ingo
