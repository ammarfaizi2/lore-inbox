Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265267AbTLZXnK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 18:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265272AbTLZXnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 18:43:10 -0500
Received: from c211-28-147-198.thoms1.vic.optusnet.com.au ([211.28.147.198]:17641
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S265267AbTLZXnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 18:43:00 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] 2.6.0 batch scheduling, HT aware
Date: Sat, 27 Dec 2003 10:42:55 +1100
User-Agent: KMail/1.5.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Nick Piggin <piggin@cyberone.com.au>
References: <200312231138.21734.kernel@kolivas.org> <20031226225652.GE197@elf.ucw.cz>
In-Reply-To: <20031226225652.GE197@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312271042.55989.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Dec 2003 09:56, Pavel Machek wrote:
> Hi!
>
> > I've done a resync and update of my batch scheduling that is also
> > hyper-thread aware.
> >
> > What is batch scheduling? Specifying a task as batch allows it to only
> > use cpu time if there is idle time available, rather than having a
> > proportion of the cpu time based on niceness.
> >
> > Why do I need hyper-thread aware batch scheduling?
> >
> > If you have a hyperthread (P4HT) processor and run it as two logical cpus
> > you can have a very low priority task running that can consume 50% of
> > your physical cpu's capacity no matter how high priority tasks you are
> > running. For example if you use the distributed computing client
> > setiathome you will be effectively be running at half your cpu's speed
> > even if you run setiathome at nice 20. Batch scheduling for normal cpus
> > allows only idle time to be used for batch tasks, and for HT cpus only
> > allows idle time when both logical cpus are idle.
>
> BTW this is going to be an issue even on normal (non-HT)
> systems. Imagine memory-bound scientific task on CPU0 and nice -20
> memory-bound seti&home at CPU1. Even without hyperthreading, your
> scientific task is going to run at 50% of speed and seti&home is going
> to get second half. Oops.
>
> Something similar can happen with disk, but we are moving out of
> cpu-scheduler arena with that.
>
> [I do not have SMP nearby to demonstrate it, anybody wanting to
> benchmark a bit?]

This is definitely the case but there is one huge difference. If you have 
2x1Ghz non HT processors then the fastest a single threaded task can run is 
at 1Ghz. If you have 1x2Ghz HT processor the fastest a single threaded task 
can run is 2Ghz. 

Con

