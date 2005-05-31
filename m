Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261950AbVEaQus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261950AbVEaQus (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 12:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbVEaQub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 12:50:31 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:22009 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261930AbVEaQSj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 12:18:39 -0400
Subject: Re: what is the -RT tree
From: Sven-Thorsten Dietrich <sdietrich@mvista.com>
To: Andi Kleen <ak@muc.de>
Cc: Ingo Molnar <mingo@elte.hu>, Takashi Iwai <tiwai@suse.de>,
       dwalker@mvista.com, bhuey@lnxw.com, nickpiggin@yahoo.com.au,
       hch@infradead.org, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050530124038.GM86087@muc.de>
References: <20050527123529.GD86087@muc.de> <20050527124837.GA7253@elte.hu>
	 <20050527125630.GE86087@muc.de> <20050527131317.GA11071@elte.hu>
	 <20050527133122.GF86087@muc.de> <s5hwtpkwz4z.wl@alsa2.suse.de>
	 <20050530095349.GK86087@muc.de> <20050530103347.GA13425@elte.hu>
	 <20050530105618.GL86087@muc.de> <20050530121031.GA26255@elte.hu>
	 <20050530124038.GM86087@muc.de>
Content-Type: text/plain
Date: Tue, 31 May 2005 09:18:06 -0700
Message-Id: <1117556286.9832.15.camel@sdietrich-xp.vilm.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-30 at 14:40 +0200, Andi Kleen wrote:
> On Mon, May 30, 2005 at 02:10:31PM +0200, Ingo Molnar wrote:
> > 
> > * Andi Kleen <ak@muc.de> wrote:
> > 
> > > 
> > > Yeah, but you did a lot of (often unrelated to rt preempt) latency 
> > > fixes in RT that are not yet merged into mainline. When they are all 
> > > merged things might be very different. And then there can be probably 
> > > more fixes.
> > 
> > your argument above == cond_resched() in might_sleep() [ == VP ] is the
> >                        only way to get practical (e.g. jack) latencies.
> 
> My argument was basically that we have no other choice than
> to fix it anyways, since the standard kernel has to be usable
> in this regard.
> 
> (it is similar to that we e.g. don't do separate "server VM" and "desktop VM"s
> although it would be sometimes tempting. after all one wants a kernel
> that works well on a variety of workloads and doesn't need to extensive
> hand tuning)


The cond_resched approach degenerates to basically "polling",
whether an RT task is ready to run.

This resembles the earliest RT systems, known as cyclic executive.

Folks moved away from that in the 1970s, because it was difficult
to maintain, since each time you add a big new feature, you have
to re-tune the system to make sure you are polling often enough.

In the long term, who is going to go through 10,000 non-preemptible
sections, and put the cond_resched's at exactly the same place?

Who is going to educate the driver folks, that they need to do
cond_resched() every so often to meet specs. 

Who is going to enforce that in 6 million lines of code ?

The Linux kernel is enjoying a very broad base of application
coverage, and the big server distros may not (yet) see the 
need for preemption.

The big distros and every Linux server system will be the minority
of Linux deployment when Linux takes a solid foothold in mobile
applications. (cell phones, pda's, music players, etc.)

All these gadgets are battery powered.

They have to balance weight(battery), size(device), power(CPU).

This combination of design contraints AUTOMATICALLY imposes RT
constraints on the software, since the CPU parts must be chosen
for minimal power consumption, so that you can minimize everything
else.

That means high CPU loads, which implies priorities and RT constraints,
especially in the presence of external connectivity. No one is going
to use a device for very long which drops its connections because
of transient overloads.

The RT patch provides tunability, which allows you to CHOOSE, what
level of preemption and locking you need, all the way to hard RT.

The folks who need hard RT would RATHER use Linux, but it doesn't
offer the performance at this time.

The RT work will allow that choice, without inconveniencing
the big distros, who can continue to run non-preemptable,
without impact.

When they do see the need for better preemption performance -
they would have stable technology to help them along the way.

Sven


