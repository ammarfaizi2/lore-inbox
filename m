Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbTKDUGr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 15:06:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbTKDUGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 15:06:47 -0500
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:33554
	"EHLO muru.com") by vger.kernel.org with ESMTP id S261982AbTKDUGp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 15:06:45 -0500
Date: Tue, 4 Nov 2003 12:05:17 -0800
To: Charles Lepple <clepple@ghz.cc>
Cc: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       psavo@iki.fi
Subject: Re: [PATCH] amd76x_pm on 2.6.0-test9 cleanup
Message-ID: <20031104200517.GD1042@atomide.com>
References: <20031104002243.GC1281@atomide.com> <1067971295.11436.66.camel@cog.beaverton.ibm.com> <20031104191504.GB1042@atomide.com> <200311041444.57464.clepple@ghz.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311041444.57464.clepple@ghz.cc>
User-Agent: Mutt/1.5.4i
From: Tony Lindgren <tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Charles Lepple <clepple@ghz.cc> [031104 11:45]:
> On Tuesday 04 November 2003 02:15 pm, Tony Lindgren wrote:
> > I've heard of timing problems if it's compiled in, but supposedly they
> > don't happen when loaded as module.
> 
> In some of the earlier testX versions of the kernel, I did not see any 
> difference between compiling as a module, and compiling into the kernel. (It 
> is currently a module on my system.)
> 
> I did, however, manage to keep ntpd happy by reducing HZ to 100. Even raising 
> HZ to 200 is enough to throw off its PLL. The machine is idle for 90% of the 
> day, though, so I don't know if the PLL is adapting to the fact that the 
> system is idling, but the values for tick look reasonable.

Interesting, sounds like the idling causes missed timer interrupts? Can you
briefly describe what's the easiest way to reproduce the timer problem, just
change HZ to 200 and look at the system time?

> > Then the 2.4 version does not load if i2c-amd756 is loaded, but this may
> > have been already fixed by this patch, I have not verified it yet though.
> 
> Pasi's patch against test9 seems to work fine in this regard. I am running 
> with i2c_amd756 and amd_k7_agp now, and neither one has trouble loading 
> anymore (after a cold boot, anyway).

OK

> > I have problem where my S2460 goes into sleep for a while if compiled in,
> > but this does not happen when loaded as module.
> 
> After a warm reboot on my S2460 motherboard, it seems as though the module 
> occasionally needs to receive an interrupt from somewhere ACPI-related. Most 
> of the time, this means that I have to press either the soft power button or 
> the sleep button to get the system to continue booting (!).
>
> I am using the default #defines (i.e. no C3, POS or NTH enabled).

I had this problem when compiled in, but not as module though. I've been
using kexec for reboots recently though as the bios reboot is soo slow.

But just to verify: 2.6.0-test9 & amd76x_pm as module, and the system drops
into sleep mode when the module is loaded for the first time until power is
pressed? And this does not happen after cold reboots or when the amd76x_pm
is reloaded?

> I looked through the chipset documentation again (specifically checking the 
> errata for these revisions), and nothing jumped out at me. I won't be able to 
> look at this in depth for another month or two, though.

I'm thinking this one is a BIOS bug in S2460, as it does not happen on other
boards AFAIK. Anybody have a working linuxbios config for S2460?

Tony
