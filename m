Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262725AbSJGUbb>; Mon, 7 Oct 2002 16:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262710AbSJGUba>; Mon, 7 Oct 2002 16:31:30 -0400
Received: from ophelia.ess.nec.de ([193.141.139.8]:44672 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S262725AbSJGUaj> convert rfc822-to-8bit; Mon, 7 Oct 2002 16:30:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: Michael Hohnbaum <hohnbaum@us.ibm.com>
Subject: Re: [RFC] NUMA schedulers benchmark results
Date: Mon, 7 Oct 2002 22:35:13 +0200
User-Agent: KMail/1.4.1
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <200210061851.45401.efocht@ess.nec.de> <1034008671.1280.82.camel@dyn9-47-17-164.beaverton.ibm.com>
In-Reply-To: <1034008671.1280.82.camel@dyn9-47-17-164.beaverton.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210072235.13738.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,
On Monday 07 October 2002 18:37, Michael Hohnbaum wrote:
> These numbers look pretty good for your scheduler.  It would be good
> if you could post numbers against 2.5.x where x is the same for all
> tests.  I thought you had your scheduler working on 2.5.x recently.
I had it running under 2.5.35, but some of the important peripherals
of the machine didn't work with that and I hate doing experiments
when I only have the serial console. I'll get the node affine stuff
finished tomorrow and will try to find a testing slot (that's another
problem :-(  )

> Running numa_test on my systems I find a lot of variation (as much
> as 10%) between identical runs.  Are all of these results averaged
> over multiple runs?  Any idea why the hackbench times vary so widely?
No, they are not averaged. I often made 2-3 runs and they usually didn't
differ significantly (within 2-3% of average user time), so I just took
one. Would be cool to have a script for averaging several results, I'll
make that if I get some time, but then we can't look at the distribution
over the nodes. And that's what I find most useful for understanding
what's going on.

> Looking at the results for my scheduler, it is real obvious what the
> algorithm is that I use for selecting a cpu for a process.  This has
> not been quite as apparent on my systems, probably due to other tasks
> running in the background.  The code in your scheduler that causes a
> different node to start the search for a cpu really pays off here.
Yes, but it's not perfect, as it cannot predict how long the processes
will live. Also it takes into account every running task, no matter
whether it's just a shortly running migration_thread or something else.
A running average might be better, but I have no experience with that.
Any ideas?

Regarding the hackbench times: it forks 20 tasks which fork 20 tasks
each, these are sending messages to each other. Depending on the load
balancing (which is not really predictible) it could happen that you end
up with bad distributions of senders/receivers sometimes.

Best regards,
Erich

