Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751218AbVIXJFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbVIXJFT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 05:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbVIXJFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 05:05:19 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:7888 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S1751218AbVIXJFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 05:05:17 -0400
Message-ID: <433516A5.2050503@andrew.cmu.edu>
Date: Sat, 24 Sep 2005 05:04:37 -0400
From: James Bruce <bruce@andrew.cmu.edu>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, akpm@osdl.org, george@mvista.com, johnstul@us.ibm.com,
       paulmck@us.ibm.com
Subject: Re: [ANNOUNCE] ktimers subsystem
References: <20050919184834.1.patchmail@tglx.tec.linutronix.de>  <Pine.LNX.4.61.0509201247190.3743@scrub.home>  <1127342485.24044.600.camel@tglx.tec.linutronix.de>  <Pine.LNX.4.61.0509221816030.3728@scrub.home> <1127464041.24044.809.camel@tglx.tec.linutronix.de> <Pine.LNX.4.61.0509232258270.3728@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0509232258270.3728@scrub.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> On Fri, 23 Sep 2005, Thomas Gleixner wrote:
>>Each network connection, each disk I/O operation arms a timeout timer to
>>cover error conditions. Increasing the load on those increases the
>>number of armed timers. At the same time this increased load keeps the
>>timers longer active as it takes more time to detect that the "good"
>>condition arrived on time.
> 
> You're still rather vague here...
> Anyway, if the amount of active timer should be a problem, there are ways 
> to avoid them. <snip>

What does this have to do with the ktimers work itself?  It's true that 
other parts of the kernel shouldn't create more timers than necessary, 
but the timer subsystem should be able to handle a lot of timers 
regardless of that.  To put it in perspective: A server doesn't run very 
efficiently with a load of 1000, and that should be avoided by proper 
application design.  Yet we still test the scheduler on such workloads, 
don't we?  It's nice to know a subsystem doesn't fall over when its 
stressed.

If you really feel timers are overused, please bring it up with the 
maintainers of *those subsystems* which are overusing it.  There's no 
point in raising the issue with Thomas since he's not responsible for 
how other people use/misuse an existing API.

Perhaps the real issue is that you feel we should police the kernel 
usage of timers, instead of moving to a more scalable implementation. 
This is one of those rare cases however where we can have cleaner, more 
modular code, barely longer than before, which is also more scalable. 
The only thing left to measure is the performance impact, but the 
authors haven't gotten that far yet.  Instead of jumping to conclusions 
now, let's wait until we have some real numbers, shall we?

Jim Bruce
