Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262271AbULMOOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbULMOOv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 09:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262270AbULMOOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 09:14:51 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8464 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262271AbULMOOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 09:14:23 -0500
Date: Mon, 13 Dec 2004 14:14:20 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Stefan Seyfried <seife@suse.de>, Con Kolivas <kernel@kolivas.org>,
       Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: dynamic-hz
Message-ID: <20041213141420.C24748@flint.arm.linux.org.uk>
Mail-Followup-To: Stefan Seyfried <seife@suse.de>,
	Con Kolivas <kernel@kolivas.org>, Pavel Machek <pavel@suse.cz>,
	linux-kernel@vger.kernel.org, Andrea Arcangeli <andrea@suse.de>
References: <20041211142317.GF16322@dualathlon.random> <20041212163547.GB6286@elf.ucw.cz> <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org> <41BD483B.1000704@suse.de> <20041213135820.A24748@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041213135820.A24748@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Mon, Dec 13, 2004 at 01:58:20PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2004 at 01:58:20PM +0000, Russell King wrote:
> On Mon, Dec 13, 2004 at 08:43:55AM +0100, Stefan Seyfried wrote:
> > Con Kolivas wrote:
> > > Just being devils advocate here...
> > > 
> > > I had variable Hz in my tree for a while and found there was one 
> > > solitary purpose to setting Hz to 100; to silence cheap capacitors.
> > 
> > power savings? Having the cpu wake up 1000 times per second if the
> > machine is idle cannot be better than only waking it up 100 times.
> > 
> > Yes, i am always on the quest for the 5 extra minutes on battery :-)
> 
> This is an easy thing to grab hold of, but rather pointless in the
> overall scheme of things.  Those of us who have done power usage
> measurements know this already.
> 
> The only case where this really makes sense is where the CPU power
> usage outweighs the power consumption of all other peripherals by
> at least an order of magnitude such that the rest of the system is
> insignificant compared to the CPU power.
> 
> Lets take an example.  Lets say that:
> * a CPU runs at about 245mA when active
> * 90mA when inactive
> * the timer interrupt takes 2us to execute 1000 times a second
> * no other processing is occuring
> 
> This means that the average current consumption is about:
> 	245mA * 2 * 10^-6 + 90mA * (1 - 2 * 10^-6) = 90.00031mA

Sorry, missed out the 1000 times a second.  Grumble.

	245mA * 1000 * 2 * 10^-6 + 90mA * (1 - 2 * 10^-6 * 1000) = 90.31mA

> This means that the timer interrupt has increased CPU power by
> 0.00034%.

0.34%

> Now, lets factor in the rest of a system.  Lets the rest of the
> system takes 84mA.  Recalculating (by increasing each figure by
> 84mA) gives us 174.00031mA, or an increase in overall system

174.31mA

> power by about 0.00018%.

0.18%

> Assuming your battery normally lasts exactly 24 hours on a current
> drain of 174.00031mA, completely eliminating the tick gives you

174.31mA

> an extra 0.15 seconds battery life.

2mins 30secs

> Note: the above CPU power consumption figures were taken from
> the Intel PXA255 processor electrical specifications, and the
> "rest of the system" current consumption taken from a real life
> device.  The timer interrupt taking 2us is probably an over-
> estimation.  Only the battery lifetime of 24 hours is ficticious.
> 
> And yes, from time to time I keep thinking that it would be nice
> to eliminate the timer tick to save some power.  However, I've
> never been able to justify the extra code complexity against the
> power savings.  It really only makes sense if you can essentially
> _power off_ your system until the next timer interrupt (thereby,
> in the above example, reducing the power consumption by some 174mA)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
