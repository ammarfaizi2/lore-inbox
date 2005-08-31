Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbVHaPO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbVHaPO5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 11:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964827AbVHaPO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 11:14:57 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:9467 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S964826AbVHaPO4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 11:14:56 -0400
Subject: Re: [FYI] 2.6.13-rt3  and a nanosleep jitter test.
From: Daniel Walker <dwalker@mvista.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       george anzinger <george@mvista.com>, Adrian Bunk <bunk@stusta.de>,
       Sven-Thorsten Dietrich <sven@mvista.com>,
       LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>
In-Reply-To: <1125500514.5714.12.camel@localhost.localdomain>
References: <1124704837.5208.22.camel@localhost.localdomain>
	 <20050822101632.GA28803@elte.hu>
	 <1124710309.5208.30.camel@localhost.localdomain>
	 <20050822113858.GA1160@elte.hu>
	 <1124715755.5647.4.camel@localhost.localdomain>
	 <20050822183355.GB13888@elte.hu>
	 <1124739657.5809.6.camel@localhost.localdomain>
	 <1124739895.5809.11.camel@localhost.localdomain>
	 <1124981238.5350.6.camel@localhost.localdomain>
	 <1124982413.5350.19.camel@localhost.localdomain>
	 <20050825174732.GA23774@elte.hu>
	 <1125000563.6264.10.camel@localhost.localdomain>
	 <1125023010.5365.4.camel@localhost.localdomain>
	 <1125064334.5365.39.camel@localhost.localdomain>
	 <1125414039.5675.42.camel@localhost.localdomain>
	 <1125417156.6355.13.camel@localhost.localdomain>
	 <1125500514.5714.12.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 31 Aug 2005 08:12:08 -0700
Message-Id: <1125501128.28697.5.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is already a suite HRT of tests they include a nanosleep jitter
test with 8 or 9 other tests..

find them inside the hrt-support patch at http://high-res-timer.sf.net

Daniel

On Wed, 2005-08-31 at 11:01 -0400, Steven Rostedt wrote:
> Thomas,
> 
> I just was wondering how the HR Timers were in the latest -rtX patch and
> wrote my own little jitter test using nanosleep.  Here's the results:
> 
> On vanilla 2.6.13-rc7-git1  (Yes I need to get over to 2.6.13)
> 
> # ./jitter
> starting calibrate
> finished calibrate: 2133.9060MHz 2133906034
> time slept: 0.010000000 sec: 0 nsec: 10000000
> max: 0.011997701
> min: 0.011890522
> avg: 0.011993485
> greatest time over: 1997.701 usecs
> never ran under (good!)
> average time over: 1993.485 usecs
> 
> On 2.6.13-rt3:
> 
> # ./jitter
> starting calibrate
> finished calibrate: 2133.2960MHz 2133295991
> time slept: 0.010000000 sec: 0 nsec: 10000000
> max: 0.010034857
> min: 0.010006309
> avg: 0.010009213
> greatest time over: 34.857 usecs
> never ran under (good!)
> average time over: 9.213 usecs
> 
> 
> Not bad.  I then ran a clean kernel compile as root with a -j3 (this is
> an 2x SMP machine), and tried the test again.
> 
> # ./jitter
> starting calibrate
> finished calibrate: 2133.3005MHz 2133300491
> time slept: 0.010000000 sec: 0 nsec: 10000000
> max: 0.010044836
> min: 0.010014244
> avg: 0.010030741
> greatest time over: 44.836 usecs
> never ran under (good!)
> average time over: 30.741 usecs
> 
> 
> Since the ticks per second is also calculated here, I ran it again using
> the calibration of the first run (still running that make):
> 
> ./jitter -c 2133295991
> passed in calibrate: 2133.2960MHz 2133295991
> time slept: 0.010000000 sec: 0 nsec: 10000000
> max: 0.010051293
> min: 0.010012155
> avg: 0.010030237
> greatest time over: 51.293 usecs
> never ran under (good!)
> average time over: 30.237 usecs
> 
> And once more using the calibration found by 2.6.13-rc7-git1 (still
> running that make):
> 
> # ./jitter -c 2133906034
> passed in calibrate: 2133.9060MHz 2133906034
> time slept: 0.010000000 sec: 0 nsec: 10000000
> max: 0.010058339
> min: 0.010016418
> avg: 0.010025571
> greatest time over: 58.339 usecs
> never ran under (good!)
> average time over: 25.571 usecs
> 
> 
> Some info on my machine:
> 
> $ cat /proc/cpuinfo
> processor       : 0
> vendor_id       : AuthenticAMD
> cpu family      : 6
> model           : 10
> model name      : AMD Athlon(tm) MP 2800+
> stepping        : 0
> cpu MHz         : 2133.286
> cache size      : 512 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
> bogomips        : 4259.84
> 
> processor       : 1
> vendor_id       : AuthenticAMD
> cpu family      : 6
> model           : 10
> model name      : AMD Athlon(tm) Processor
> stepping        : 0
> cpu MHz         : 2133.286
> cache size      : 512 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 1
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
> bogomips        : 4259.84
> 
> And attached is the jitter.c test. Must be run as root since it ups the
> priority to the max.
> 
> Have fun,
> 
> -- Steve
> 

