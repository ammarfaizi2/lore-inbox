Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbTKDUwb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 15:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262558AbTKDUwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 15:52:31 -0500
Received: from 206-158-102-129.prx.blacksburg.ntc-com.net ([206.158.102.129]:55204
	"EHLO wombat.ghz.cc") by vger.kernel.org with ESMTP id S262546AbTKDUw2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 15:52:28 -0500
Date: Tue, 4 Nov 2003 15:52:14 -0500
Subject: Re: [PATCH] amd76x_pm on 2.6.0-test9 cleanup
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: lkml <linux-kernel@vger.kernel.org>
To: Tony Lindgren <tony@atomide.com>
From: Charles Lepple <clepple@ghz.cc>
In-Reply-To: <20031104200517.GD1042@atomide.com>
Message-Id: <C4D11E6F-0F08-11D8-A943-003065DC6B50@ghz.cc>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, November 4, 2003, at 03:05 PM, Tony Lindgren wrote:

> * Charles Lepple <clepple@ghz.cc> [031104 11:45]:
>> On Tuesday 04 November 2003 02:15 pm, Tony Lindgren wrote:
>>> I've heard of timing problems if it's compiled in, but supposedly 
>>> they
>>> don't happen when loaded as module.
>>
>> In some of the earlier testX versions of the kernel, I did not see any
>> difference between compiling as a module, and compiling into the 
>> kernel. (It
>> is currently a module on my system.)
>>
>> I did, however, manage to keep ntpd happy by reducing HZ to 100. Even 
>> raising
>> HZ to 200 is enough to throw off its PLL. The machine is idle for 90% 
>> of the
>> day, though, so I don't know if the PLL is adapting to the fact that 
>> the
>> system is idling, but the values for tick look reasonable.
>
> Interesting, sounds like the idling causes missed timer interrupts? 
> Can you
> briefly describe what's the easiest way to reproduce the timer 
> problem, just
> change HZ to 200 and look at the system time?

At HZ=200, it would take a while to notice. I used adjtimexconfig, 
which counts the number of kernel ticks which occur in 70 seconds 
(according to the RTC). The RTC is pretty stable without power 
management, so I tend to trust it. I think I ended up with a value of 
tick=11000 (compensation for a 10% slow clock), and if I left the 
machine idle, ntpd would converge based on the new tick value.

Then again, I don't think I tried HZ>=200 on -test9. (When I got Pasi's 
-test9 patch, I applied it to a -test8-bk kernel with HZ=1000-- I don't 
remember exactly which one.) Based on his followup email, timekeeping 
may be better in -test9. I'll check.

> I've been using kexec for reboots recently though as the bios reboot 
> is soo slow.

The slowness on my system is supposedly related to ECC initialization, 
but it's only ~30 seconds for 512MB. Still, if I upgrade the memory, 
that's a good tip.

> But just to verify: 2.6.0-test9 & amd76x_pm as module, and the system 
> drops
> into sleep mode when the module is loaded for the first time until 
> power is
> pressed? And this does not happen after cold reboots or when the 
> amd76x_pm
> is reloaded?

Correct.

-- 
Charles Lepple
clepple@ghz.cc

