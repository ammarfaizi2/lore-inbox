Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132241AbRCVX3j>; Thu, 22 Mar 2001 18:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132242AbRCVX3c>; Thu, 22 Mar 2001 18:29:32 -0500
Received: from mail-oak-2.pilot.net ([198.232.147.17]:44537 "EHLO
	mail02-oak.pilot.net") by vger.kernel.org with ESMTP
	id <S132246AbRCVX11>; Thu, 22 Mar 2001 18:27:27 -0500
Message-ID: <973C11FE0E3ED41183B200508BC7774C0124F077@csexchange.crystal.cirrus.com>
From: "Woller, Thomas" <twoller@crystal.cirrus.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, andrew.grover@intel.com
Cc: "Woller, Thomas" <twoller@crystal.cirrus.com>,
        linux-kernel@vger.kernel.org
Subject: RE: Incorrect mdelay() results on Power Managed Machines x86
Date: Thu, 22 Mar 2001 17:26:05 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I wonder if there is a way to modify mdelay to use a kernel timer if
> > interval > 10msec? I am not familiar with this section of the kernel,
> but I
> > do know that Microsoft's similar function KeStallExecutionProcessor is
> not
> > recommended for more than 50 *micro*seconds.
> 
	>>Basically the same kind of recommendation applies. But as with all
rules its
	>>sometimes appropriate to break it

	thanks, i just tested the "notsc" option (.config has CONFIG_X86_TSC
enabled=y, but CONFIG_M586TSC is not enabled.. if that's ok), but this time
I booted and kept the machine on battery power the ENTIRE time, i had not
tried this before.  the MHZ value Detected in time.c is 132Mhz (down from
500Mhz if not on battery power).  but the interesting thing that i just
noticed is that the mdelay() wait time, is STILL about 25% of what it should
delay.  i use 10000 (for a 10 second delay) and get only about 2-3 seconds
out of it.  this smaller delay occurs with or without "notsc" on the boot
line.  now, i did not expect this behaviour if i did not plug in to get more
CPU speed, with the calculated cpu rate when on battery power.  i expected
that mdelay() would function properly with the appropriate wait time if i
booted and stayed on battery power, at the same reduced CPU frequency.
Alan, you might have answered this in your first post but i don't under the
INTEL speedstep logic to understand if this is expected behaviour.  but the
bottom line is that my delay of 700 milleseconds in the driver fails if i
boot and stay on battery power exclusively.  did anyone else expect this
behaviour?  
