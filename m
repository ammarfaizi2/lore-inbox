Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265261AbTLZXYf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 18:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265260AbTLZXXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 18:23:50 -0500
Received: from gprs214-253.eurotel.cz ([160.218.214.253]:45184 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S265256AbTLZXWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 18:22:54 -0500
Date: Fri, 26 Dec 2003 23:56:52 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [PATCH] 2.6.0 batch scheduling, HT aware
Message-ID: <20031226225652.GE197@elf.ucw.cz>
References: <200312231138.21734.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312231138.21734.kernel@kolivas.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I've done a resync and update of my batch scheduling that is also hyper-thread 
> aware.
> 
> What is batch scheduling? Specifying a task as batch allows it to only use cpu 
> time if there is idle time available, rather than having a proportion of the 
> cpu time based on niceness.
> 
> Why do I need hyper-thread aware batch scheduling?
> 
> If you have a hyperthread (P4HT) processor and run it as two logical cpus you 
> can have a very low priority task running that can consume 50% of your 
> physical cpu's capacity no matter how high priority tasks you are running. 
> For example if you use the distributed computing client setiathome you will 
> be effectively be running at half your cpu's speed even if you run setiathome 
> at nice 20. Batch scheduling for normal cpus allows only idle time to be used 
> for batch tasks, and for HT cpus only allows idle time when both logical cpus 
> are idle.

BTW this is going to be an issue even on normal (non-HT)
systems. Imagine memory-bound scientific task on CPU0 and nice -20
memory-bound seti&home at CPU1. Even without hyperthreading, your
scientific task is going to run at 50% of speed and seti&home is going
to get second half. Oops.

Something similar can happen with disk, but we are moving out of
cpu-scheduler arena with that.

[I do not have SMP nearby to demonstrate it, anybody wanting to
benchmark a bit?] 
									Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
