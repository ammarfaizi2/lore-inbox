Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261741AbUK2P6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbUK2P6W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 10:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261745AbUK2P6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 10:58:22 -0500
Received: from mx2.elte.hu ([157.181.151.9]:55510 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261741AbUK2P4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 10:56:51 -0500
Date: Mon, 29 Nov 2004 16:56:42 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Priority Inheritance Test (Real-Time Preemption)
Message-ID: <20041129155642.GA17663@elte.hu>
References: <20041129095941.GD7868@elte.hu> <Pine.OSF.4.05.10411291152050.14592-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10411291152050.14592-100000@da410.ifa.au.dk>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Esben Nielsen <simlo@phys.au.dk> wrote:

> On Mon, 29 Nov 2004, Ingo Molnar wrote:
> 
> > [...] 
> > To give you an extreme example: you cannot run OpenOffice.org with
> > SCHED_FIFO prio 99 and expect it to have any sane deterministic latency
> > bounds. The simpler the app, the easier it is to control latencies.
> 
> No, but I want to have my RT-subsystem to be not affected even if the
> users choose to run 1000 soffice.bin at SCHED_NORMAL!! [...]

that is still the case, as long as it doesnt 'interact' with
soffice.bin.  Note that the same qualification holds for every hard-RT
OS as well, with varying levels of 'interaction'. Interaction depends on
what kind of synchronization the hard-RT task does, and depends on how
the kernel itself implements various kernel features.

> [...] The problem is that a raw spinlock is used to lock for a
> iteration over a list which can be O(number of waiters * locking
> depth) long. As long as we are in the kernel both is "controlled",
> i.e. one can see the worst-case number in stress test and know it
> can't get worse. *

which list do you mean? Note that the pi_list depends on the number of
_RT-tasks_, not on the number of SCHED_NORMAL tasks. So you can create
an arbitrary number of SCHED_NORMAL tasks, they wont impact the overhead
of mutexes!

i very intentionally made it independent of nr-of-non-RT-tasks.

	Ingo
