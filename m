Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317320AbSFRE7B>; Tue, 18 Jun 2002 00:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317321AbSFRE67>; Tue, 18 Jun 2002 00:58:59 -0400
Received: from mx1.elte.hu ([157.181.1.137]:39397 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317320AbSFRE6v>;
	Tue, 18 Jun 2002 00:58:51 -0400
Date: Tue, 18 Jun 2002 06:55:48 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: David Schwartz <davids@webmaster.com>
Cc: mgix@mgix.com, <linux-kernel@vger.kernel.org>
Subject: Re: Question about sched_yield()
In-Reply-To: <20020618004630.AAA28082@shell.webmaster.com@whenever>
Message-ID: <Pine.LNX.4.44.0206180650001.2834-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 Jun 2002, David Schwartz wrote:

> >I am seeing some strange linux scheduler behaviours,
> >and I thought this'd be the best place to ask.
> >
> >I have two processes, one that loops forever and
> >does nothing but calling sched_yield(), and the other
> >is basically benchmarking how fast it can compute
> >some long math calculation.

> [...] It is not a replacement for blocking or a scheduling priority
> adjustment. It simply lets other ready-to-run tasks be scheduled before
> returning to the current task.

and this is what the scheduler didnt do properly, it actually didnt
schedule valid ready-to-run processes for long milliseconds, it switched
between two sched_yield processes, starving the CPU-intensive process. I
posted a patch for 2.5 that fixes this, and the 2.4.19-pre10-ac2 backport
i did includes this fix as well:

    http://redhat.com/~mingo/O(1)-scheduler/sched-2.4.19-pre10-ac2-A4

a good sched_yield() implementation should give *all* other tasks a chance
to run, instead of switching between multiple sched_yield()-ing tasks. I
don think this is specified anywhere, but it's a quality of implementation
issue.

	Ingo

