Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbTKDXMD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 18:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261722AbTKDXMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 18:12:03 -0500
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:12037
	"EHLO muru.com") by vger.kernel.org with ESMTP id S261687AbTKDXMA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 18:12:00 -0500
Date: Tue, 4 Nov 2003 15:11:57 -0800
To: Charles Lepple <clepple@ghz.cc>
Cc: psavo@iki.fi, lkml <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH] amd76x_pm on 2.6.0-test9 cleanup
Message-ID: <20031104231157.GI1042@atomide.com>
References: <20031104200517.GD1042@atomide.com> <9F0055D6-0F17-11D8-A943-003065DC6B50@ghz.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9F0055D6-0F17-11D8-A943-003065DC6B50@ghz.cc>
User-Agent: Mutt/1.5.4i
From: Tony Lindgren <tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Charles Lepple <clepple@ghz.cc> [031104 14:40]:
> On Tuesday, November 4, 2003, at 03:05 PM, Tony Lindgren wrote:
> 
> >* Charles Lepple <clepple@ghz.cc> [031104 11:45]:
> >>On Tuesday 04 November 2003 02:15 pm, Tony Lindgren wrote:
> >>>I've heard of timing problems if it's compiled in, but supposedly 
> >>>they
> >>>don't happen when loaded as module.
> >>
> >>In some of the earlier testX versions of the kernel, I did not see any
> >>difference between compiling as a module, and compiling into the 
> >>kernel. (It
> >>is currently a module on my system.)
> >>
> >>I did, however, manage to keep ntpd happy by reducing HZ to 100. Even 
> >>raising
> >>HZ to 200 is enough to throw off its PLL. The machine is idle for 90% 
> >>of the
> >>day, though, so I don't know if the PLL is adapting to the fact that 
> >>the
> >>system is idling, but the values for tick look reasonable.
> >
> >Interesting, sounds like the idling causes missed timer interrupts? 
> >Can you
> >briefly describe what's the easiest way to reproduce the timer 
> >problem, just
> >change HZ to 200 and look at the system time?
> 
> Weird. On -test9-bk at HZ=1000, with amd76x_pm loaded as a module 
> (lazy_idle=800, the default), the system clock is running fast.
> 
> With ntpd running, the clock was stepped back 2.5 seconds twice in 20 
> minutes.
> 
> Here's what I get from adjtimexconfig (after stopping ntpd, of course):
> 
> # adjtimexconfig
> Comparing clocks (this will take 70 sec)... adjusting system time by  
> -126.211  sec/day
> Done
> 
> Now tick is 9985. I distinctly remember it being somewhat over 10,000 
> the last time I ran with HZ=1000 and amd_76x_pm active. With HZ=100, 
> adjtimexconfig sets tick=10002.
> 
> I'm not entirely sure what the "acpi" interrupt is doing-- it 
> increments about once every two seconds when the system is idle, and 
> various types of system activity make it happen more frequently. At 
> least I'm not getting any "irq 9: nobody cared!" messages anymore (the 
> button module is loaded, so I guess it is handling it). If I don't have 
> amd76x_pm loaded, the acpi interrupt is triggered a couple of times 
> after button is loaded, but then it doesn't happen again until I 
> actually press a button.

Weird. On my system the irq 9 count is still 0 0 since I started the
machine this morning. I have ACPI compiled into the kernel, and then load
amd76x_pm as module. But I have HZ=100, I'll try it with HZ=1000 at some
point.

But it sounds like the timer problem may be related to the snooze-on-load
problem on S2460, especially if the timer problem only happens on S2460.

Tony
