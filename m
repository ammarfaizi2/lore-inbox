Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261856AbUK2XUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbUK2XUZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 18:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261883AbUK2XTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 18:19:05 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:10669 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S261881AbUK2XQt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 18:16:49 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-13
Date: Mon, 29 Nov 2004 18:16:43 -0500
User-Agent: KMail/1.7
References: <36536.195.245.190.93.1101471176.squirrel@195.245.190.93> <20041129143316.GA3746@elte.hu> <20041129152344.GA9938@elte.hu>
In-Reply-To: <20041129152344.GA9938@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411291816.43591.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [151.205.42.91] at Mon, 29 Nov 2004 17:16:43 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 November 2004 10:23, Ingo Molnar wrote:
>* Ingo Molnar <mingo@elte.hu> wrote:
>> but please try to the -31-10 kernel that i've just uploaded, it
>> has a number of tracer enhancements:
>
>make that -31-13 (or later). Earlier kernels had a bug in where the
>process name tracking only worked for the first latency trace saved,
>subsequent traces showed 'unknown' for the process name. In -13 i've
>also added a printk that shows the latest user latency in a one-line
>printk - just like the built-in latency tracing modes do:
>
> (gettimeofday/3671/CPU#0): new 3068 us user-latency.
> (gettimeofday/3784/CPU#0): new 1008627 us user-latency.
>
>(this should also make it easier for helper scripts to save the
> traces, whenever they happen.)
>
> Ingo

I just built this to see how much blood it would draw, which isn't 
much.  I don't have jack here, so I don't have your standard torture 
test.  Instead, I run tvtime, which runs at a -19 priority.

I let it run about 30 seconds (untimed), noted that the frame error 
slippage wasn't improved, and got this output histogram when I quit 
it.

Its (tvtime) is running here of course.
--------------------
Nov 29 18:05:45 coyote kernel: Read missed before next interrupt
Nov 29 18:05:45 coyote kernel: wow!  That was a 22 millisec bump
Nov 29 18:05:45 coyote kernel: `IRQ 8'[846] is being piggy. 
need_resched=0, cpu=0
Nov 29 18:05:45 coyote kernel: Read missed before next interrupt
Nov 29 18:05:45 coyote kernel: wow!  That was a 22 millisec bump
Nov 29 18:05:45 coyote kernel: `IRQ 8'[846] is being piggy. 
need_resched=0, cpu=0
Nov 29 18:05:45 coyote kernel: Read missed before next interrupt
Nov 29 18:05:45 coyote kernel: wow!  That was a 21 millisec bump
Nov 29 18:05:45 coyote kernel: `IRQ 8'[846] is being piggy. 
need_resched=0, cpu=0
Nov 29 18:05:45 coyote kernel: Read missed before next interrupt
Nov 29 18:05:45 coyote kernel: wow!  That was a 21 millisec bump
Nov 29 18:05:45 coyote kernel: `IRQ 8'[846] is being piggy. 
need_resched=0, cpu=0
Nov 29 18:05:45 coyote kernel: Read missed before next interrupt
Nov 29 18:05:45 coyote kernel:

And was stopped here. 

Nov 29 18:05:45 coyote kernel: rtc latency histogram of {tvtime/3398, 
10609 samples}:
Nov 29 18:05:45 coyote kernel: 4 11
Nov 29 18:05:45 coyote kernel: 5 1716
Nov 29 18:05:45 coyote kernel: 6 4827
Nov 29 18:05:45 coyote kernel: 7 1495
Nov 29 18:05:45 coyote kernel: 8 382
Nov 29 18:05:45 coyote kernel: 9 193
Nov 29 18:05:45 coyote kernel: 10 206
Nov 29 18:05:45 coyote kernel: 11 188
Nov 29 18:05:45 coyote kernel: 12 148
Nov 29 18:05:45 coyote kernel: 13 202
Nov 29 18:05:45 coyote kernel: 14 195
Nov 29 18:05:45 coyote kernel: 15 95
Nov 29 18:05:45 coyote kernel: 16 70
Nov 29 18:05:45 coyote kernel: 17 23
Nov 29 18:05:45 coyote kernel: 18 18
Nov 29 18:05:45 coyote kernel: 19 8
Nov 29 18:05:45 coyote kernel: 20 9
Nov 29 18:05:45 coyote kernel: 21 1
Nov 29 18:05:45 coyote kernel: 22 1
Nov 29 18:05:45 coyote kernel: 26 1
--------------------
And I note that the 1-26 column of numbers does not seem to add up to 
whats being logged above there, which are all 21 and 22 ms bumps 
(whatever a bump is)

Is this a helpfull report, or just noise?  Subjectively, tvtime is 
running with far fewer visible frame glitches than before I started 
playing with these patches.  A marked improvement IMO.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.29% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
