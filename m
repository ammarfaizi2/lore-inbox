Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbVCaTNL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbVCaTNL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 14:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbVCaTNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 14:13:11 -0500
Received: from smtp6.wanadoo.fr ([193.252.22.25]:53637 "EHLO smtp6.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261655AbVCaTMm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 14:12:42 -0500
X-ME-UUID: 20050331191238216.34CF11C00244@mwinf0608.wanadoo.fr
Subject: Re: Clock 3x too fast on AMD64 laptop [WAS Re: Various issues
	after rebooting]
From: Olivier Fourdan <fourdan@xfce.org>
To: john stultz <johnstul@us.ibm.com>,
       Dominik Brodowski <linux@dominikbrodowski.net>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1112134312.17854.55.camel@cog.beaverton.ibm.com>
References: <1112039799.6106.16.camel@shuttle>
	 <20050328192054.GV30052@alpha.home.local> <1112038226.6626.3.camel@shuttle>
	 <20050328193921.GW30052@alpha.home.local>
	 <1112131714.14248.8.camel@shuttle>  <1112133731.14248.14.camel@shuttle>
	 <1112134312.17854.55.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Organization: http://www.xfce.org
Date: Thu, 31 Mar 2005 21:12:37 +0200
Message-Id: <1112296357.6027.20.camel@shuttle>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John, Dominik,


On Tue, 2005-03-29 at 14:11 -0800, john stultz wrote:
> Yea. From your description this is most likely the cause of the issue.
> Currently the time of day is still tick-based, using the tsc/pmtmr/hpet
> only for interpolating between ticks. 

Sorry for the late follow up. Unfortunately, a quick hack to disable the
"pmtmr" check shows that even when "trusting" the PM-Timer, the clock
and interrupts still run 3x too fast. That makes no difference.

> Well, if you tried the time of day re-work I've been working on it would
> mask the issue somewhat, but you'd still have the problem that you are
> taking too many timer interrupts.

Where could I get that patch from ? I'd be glad to do some testing for
you if you need it.

> One thing you could try is playing with the CLOCK_TICK_RATE value to see
> if you just have very unique hardware. 

Problem is that the issue shows exactly after one quick power off/power
on sequence. It doesn't show after a real cold start (leaving the laptop
off for a  couple of hours) or even after a reboot.

> A similar sounding issue has also been reported here:
> http://bugme.osdl.org/show_bug.cgi?id=3927

Not sure if that's the exact same problem. What I can say, after reading
that bug report, is that disabling ACPI and/or APIC makes no difference.
Specifying the clock=... makes no difference either. It doesn't seem
related to the AMD64 part of the kernel since it shows equally when
using a 64bit kernel and a 32bit kernel.

Moreover, when that bug shows, there are other different problems
showing (such as the cdrom not being to mount anything, or ndiswrapper
crashing the system with a MCE error).

At first, I thought the issue might be related to the nforce3, but the
bug refers to an ATI chipset so I guess it's not related to the nforce.

Anyway, it doesn't seem to be an uncommon issue with AMD64 based
hardware. I don't know where to start from though.

Cheers,
Olivier.



