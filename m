Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317328AbSGUU5S>; Sun, 21 Jul 2002 16:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317345AbSGUU5R>; Sun, 21 Jul 2002 16:57:17 -0400
Received: from hoochie.linux-support.net ([216.207.245.2]:31412 "EHLO
	hoochie.linux-support.net") by vger.kernel.org with ESMTP
	id <S317328AbSGUU5R>; Sun, 21 Jul 2002 16:57:17 -0400
Date: Sun, 21 Jul 2002 16:00:22 -0500 (CDT)
From: Mark Spencer <markster@linux-support.net>
To: Daniel Phillips <phillips@arcor.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Zaptel Pseudo TDM Bus
In-Reply-To: <E17WNan-0002b5-00@starship>
Message-ID: <Pine.LNX.4.33.0207211551350.25617-100000@hoochie.linux-support.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> See the other poster's comment about providing a clear separation of kernel
> and userspace components in your source tree.  It just makes it easier to
> get oriented.

*nods* Actually the kernel and user packages are in different projects
(zaptel is the kernel level interface, with only a couple of user tools
for its configuration, while zapata is the library interface).  Perhaps
some people might want to contact me off-list to suggest cleaner ways of
organizing the code.

> Hard realtime isn't about efficiency, it's about meeting deadlines.  While
> you may be seeing very good average interrupt response latency in Linux, it's
> well known that response times on the order of milliseconds are not uncommon,
> and there is no way to prove that you won't get the occasional spike into the
> tens or hundreds of milliseconds, even with low latency patches applied to
> spinlocks and preemption enabled.  Hard realtime is about being able to prove
> that such spikes never happen.  As a bonus, you can work with much smaller
> packet sizes because you have confidence that you'll be able to service the
> interrupts on time.

Hard realtime would presumably make sense here, but again the beauty of it
is that the current system works reasonably well without it.  With 1khz
interrupts, I've been unable to generate misses (except with DMA turned
off on IDE) on most modern systems.  In telephony systems, a miss every
now would not be noticed, but in data systems it could represent a dropped
frame.

> That said, Adeos does offer what appears to be an very efficient model for
> handling interrupts.  (Caveat: I haven't tried it myself yet, much less
> measured it, just eyeballed the code)  You can load a module directly into
> the interrupt pipeline and bypass all of Linux's interrupt machinery, even
> bypass cli (it just sets a flag in Adeos).

If someone involved with, or familiar with, this project would care to
contact me, I'd be happy to talk about RT enabling zaptel / asterisk.

> In any event, it's not clear to me how you are going to be able to do echo
> cancelation reliably unless you are able to provide guaranteed response
> latency.

Just look at the code and you'll see.

> An interrupt rate of 20 KHz is no problem on modern hardware, in fact I
> was able to that with a 20 MHz 386.  What is your sample rate?

8khz of course like all conventional telephony.  Right now we run at 1khz
for a number of reasons (less stringent requirement, better CPU
utilization, and ability to use USB telephony interfaces easily), but
there are good reasons to push it up to 8khz in some situations.

Mark

