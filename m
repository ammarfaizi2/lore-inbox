Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263232AbVBCVpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263232AbVBCVpT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 16:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263248AbVBCVpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 16:45:07 -0500
Received: from out007pub.verizon.net ([206.46.170.107]:41088 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S263203AbVBCVmM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 16:42:12 -0500
Message-Id: <200502032141.j13Lf6FG009881@localhost.localdomain>
To: Ingo Molnar <mingo@elte.hu>
cc: Con Kolivas <kernel@kolivas.org>, "Bill Huey (hui)" <bhuey@lnxw.com>,
       "Jack O'Quin" <joq@io.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature 
In-reply-to: Your message of "Thu, 03 Feb 2005 22:28:05 +0100."
             <20050203212805.GA27255@elte.hu> 
Date: Thu, 03 Feb 2005 16:41:05 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [151.197.43.196] at Thu, 3 Feb 2005 15:42:08 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>(it would be cleaner to use POSIX semaphores for this, but you mentioned
>the requirement for the mechanism to work on 2.4 kernels too - pthread
>spinlocks will work inter-process on 2.4 too, and will schedule nicely.)

can't work. pthread interprocess spinlocks are hopelessly non-RT safe
in 2.4/linuxthreads. or they were the last time i looked - they rely
on sending signals and passing through the whole pthread layer.

this is why we use FIFO's right now: fast, portable (though not to OSX
<grin> - we have to use Mach ports to get enough speed there), and a
PITA :)

>well, no. Unless i misunderstood your application model, you want
>threads to sleep until they are woken up. So you want a very basic
>sleep/wake mechanism. But yield_to() does not achieve that! yield_to()
>will yield to _already running_ (i.e. in the runqueue) threads. Using
>yield() (or yield_to()) for this is really suboptimal. By using a futex
>based mechanism you get a very nice schedule/sleep pattern.

i mentioned earlier today in a message to bill huey that JACK is
really a user-space cooperative scheduler. JACK's "scheduler" knows
who is doing what and when, and if it doesn't then it can't work at
all. so the scenario you describe is impossible and/or broken.

please keep in mind this description of JACK. there is no doubt some
remnant of the work i did on scheduler activations in the mid-90's
left floating around in my head and shaping JACK in mysterious ways :)

--p "kernel-to-user-space: thread <tid> blocked on disk i/o. please advise."


