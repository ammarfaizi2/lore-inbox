Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270726AbTHOTCO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 15:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270720AbTHOTBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 15:01:32 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:65284 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S270686AbTHOTAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 15:00:04 -0400
Subject: Re: [PATCH] O16int for interactivity
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       gaxt <gaxt@rogers.com>, Mike Galbraith <efault@gmx.de>
In-Reply-To: <200308160149.29834.kernel@kolivas.org>
References: <200308160149.29834.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1060974000.692.5.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Fri, 15 Aug 2003 21:00:00 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-15 at 17:49, Con Kolivas wrote:

> In O15 I mentioned that preventing parents from preempting their children 
> prevented starvation of applications where they would be busy on wait. Long 
> story to describe how, but I discovered the problem inducing starvation in 
> O15 was the same, but with wakers and their wakee. The wakee would preempt 
> the waker, and the waker could make no progress until it got rescheduled... 
> however if the wakee had better priority than the waker it preempted it until 
> it's own priority dropped enough for the waker to get scheduled. Because in 
> O15 the priority decayed slower we were able to see this happening in these 
> "busy on wait" applications... and they're not as rare as we'd like. In fact 
> this wakee preemption is going on at a mild level all the time even in the 
> vanilla scheduler. I've experimented with ways to improve the 
> performance/feel of these applications but I found it was to the detriment of 
> most other apps, so this patch simply makes them run without inducing 
> starvation at usable performance. I'm not convinced the scheduler should have 
> a workaround, but that the apps shouldn't busy on wait.

Well, I'm sorry to say there's something really wrong here with O16int.
2.6.0-test3-mm2 plus O16int takes exactly twice the time to boot than
vanilla 2.6.0-test3-mm2, and that's a lot of time. Let me explain.

I've made timings starting at the moment GRUB passes the control to the
kernel, and until mingetty displays the login prompt. The time it takes
for the kernel to boot until "init" is called is roughly the same on
both kernels (milisecond up or down).

2.6.0-test3-mm2: 16.30 seconds
2.6.0-test3-mm2 + O16int: 33.47 seconds

There must be something really damaged here as it's more than twice the
time. During boot, things that are almost immediate like applying
"iptables" on a RHL9 box, take ages when using a O16int-based kernel.

Is anyone experiencing those extreme delays? Is this a new kind of
starvation? Cause using exactly the same machine, Linux distribution,
disk partition, etc... but simply by changing kernels, almost everything
on boot takes twice the time to be done.

Also, logging to KDE takes ages compared with vanilla 2.6.0-test3-mm2.
Any ideas?

