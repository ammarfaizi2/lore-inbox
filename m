Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274647AbRITUsH>; Thu, 20 Sep 2001 16:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274641AbRITUr5>; Thu, 20 Sep 2001 16:47:57 -0400
Received: from smtp10.atl.mindspring.net ([207.69.200.246]:3383 "EHLO
	smtp10.atl.mindspring.net") by vger.kernel.org with ESMTP
	id <S274647AbRITUrr> convert rfc822-to-8bit; Thu, 20 Sep 2001 16:47:47 -0400
Subject: Re: [PATCH] Significant performace improvements on reiserfs systems
From: Robert Love <rml@tech9.net>
To: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Beau Kuiper <kuib-kl@ljbc.wa.edu.au>, Chris Mason <mason@suse.com>,
        Andrea Arcangeli <andrea@suse.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <200109201708.f8KH8sG15617@zero.tech9.net>
In-Reply-To: <200109201708.f8KH8sG15617@zero.tech9.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Evolution-Format: text/plain
X-Mailer: Evolution/0.13.99+cvs.2001.09.19.21.54 (Preview Release)
Date: 20 Sep 2001 16:48:00 -0400
Message-Id: <1001018883.6050.129.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-09-20 at 13:08, Dieter Nützel wrote:
> I examined that ReiserFS suffer from kupdated since 2.4.7-ac3.
> When ever I do "kill -STOP kupdated" the performance is much better.
> I know this is unsafe...

The patches that are going around in this thread (stuff from Andrew
Morton and Andrea) should address some of the ReiserFS issues.  Have you
tried them?

Note that many of the patches will _not_ improve recorded latency,
because anytime current->need_resched is unset, the spinlocks will not
be unlocked and thus preemption will not be enabled.  The patches only
measure the time premption is not enabled.

Of course, true latency will decrease, so see if your `hiccups'
decrease.

Perhaps if we start putting in some conditional schedules like this, I
can write a macro to use the instrumentation stuff to report the shorter
latencies.

> Please have a look at Robert Love's Linux kernel preemption patches and the 
> conversation about my reported latency results.
> 
> It seems that ReiserFS is involved in the poor audio behavior (hiccups during 
> MP2/MP3/Ogg-Vorbis playback).
> 
> Re: [PATCH] Preemption Latency Measurement Tool
> http://marc.theaimsgroup.com/?l=linux-kernel&m=100097432006605&w=2

> Taken from Andrea's latest post:
> 
> I can (with Randy Dunlap's ksysmap, 
> http://www.osdlab.org/sw_resources/scripts/ksysmap).
> 
> SunWave1>./ksysmap /boot/System.map c0114db3
> ksysmap: searching '/boot/System.map' for 'c0114db3'
> 
> c0114d60 T preempt_schedule
> c0114db3 ..... <<<<<
> c0114e10 T wake_up_process

Its really just as easy if not easier to lookup the file and line number
that /proc/latencytimes reports.

> Unneeded kernel locks/stalls which hurt latency and (global) throughput.
> 
> I will do some benchmarks against Andrea's VM
> 2.4.10-pre12 + patch-rml-2.4.10-pre12-preempt-kernel-1 + 
> patch-rml-2.4.10-pre12-preempt-stats-1
> 
> Hope this post isn't to long and nonbody feels offended.

No, thank you for it.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

