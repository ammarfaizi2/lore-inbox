Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261947AbTKDTpH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 14:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbTKDTpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 14:45:07 -0500
Received: from 206-158-102-129.prx.blacksburg.ntc-com.net ([206.158.102.129]:25335
	"EHLO lemur") by vger.kernel.org with ESMTP id S261947AbTKDTpC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 14:45:02 -0500
From: Charles Lepple <clepple@ghz.cc>
To: Tony Lindgren <tony@atomide.com>, john stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH] amd76x_pm on 2.6.0-test9 cleanup
Date: Tue, 4 Nov 2003 14:44:56 -0500
User-Agent: KMail/1.5.4
Cc: lkml <linux-kernel@vger.kernel.org>, psavo@iki.fi
References: <20031104002243.GC1281@atomide.com> <1067971295.11436.66.camel@cog.beaverton.ibm.com> <20031104191504.GB1042@atomide.com>
In-Reply-To: <20031104191504.GB1042@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311041444.57464.clepple@ghz.cc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 November 2003 02:15 pm, Tony Lindgren wrote:
> I've heard of timing problems if it's compiled in, but supposedly they
> don't happen when loaded as module.

In some of the earlier testX versions of the kernel, I did not see any 
difference between compiling as a module, and compiling into the kernel. (It 
is currently a module on my system.)

I did, however, manage to keep ntpd happy by reducing HZ to 100. Even raising 
HZ to 200 is enough to throw off its PLL. The machine is idle for 90% of the 
day, though, so I don't know if the PLL is adapting to the fact that the 
system is idling, but the values for tick look reasonable.

> Then the 2.4 version does not load if i2c-amd756 is loaded, but this may
> have been already fixed by this patch, I have not verified it yet though.

Pasi's patch against test9 seems to work fine in this regard. I am running 
with i2c_amd756 and amd_k7_agp now, and neither one has trouble loading 
anymore (after a cold boot, anyway).

> I have problem where my S2460 goes into sleep for a while if compiled in,
> but this does not happen when loaded as module.

After a warm reboot on my S2460 motherboard, it seems as though the module 
occasionally needs to receive an interrupt from somewhere ACPI-related. Most 
of the time, this means that I have to press either the soft power button or 
the sleep button to get the system to continue booting (!).

I am using the default #defines (i.e. no C3, POS or NTH enabled).

Info on the northbridge:

$ lspci -vn -s 0:0
00:00.0 Class 0600: 1022:700c (rev 11)
...

and the southbridge:

$ lspci -vn -s 7:3
00:07.3 Class 0680: 1022:7413 (rev 01)
...

I looked through the chipset documentation again (specifically checking the 
errata for these revisions), and nothing jumped out at me. I won't be able to 
look at this in depth for another month or two, though.

-- 
Charles Lepple
ghz.cc!clepple

