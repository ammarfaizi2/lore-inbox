Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277398AbRJEOuE>; Fri, 5 Oct 2001 10:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277400AbRJEOty>; Fri, 5 Oct 2001 10:49:54 -0400
Received: from robur.slu.se ([130.238.98.12]:46602 "EHLO robur.slu.se")
	by vger.kernel.org with ESMTP id <S277398AbRJEOtp>;
	Fri, 5 Oct 2001 10:49:45 -0400
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15293.51488.280808.469262@robur.slu.se>
Date: Fri, 5 Oct 2001 16:52:16 +0200
To: Andreas Dilger <adilger@turbolabs.com>
Cc: Robert Olsson <Robert.Olsson@data.slu.se>, mingo@elte.hu,
        jamal <hadi@cyberus.ca>, linux-kernel@vger.kernel.org,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Benjamin LaHaise <bcrl@redhat.com>, netdev@oss.sgi.com,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <20011003162210.L8954@turbolinux.com>
In-Reply-To: <Pine.GSO.4.30.0110031138150.4833-100000@shell.cyberus.ca>
	<Pine.LNX.4.33.0110031828060.8633-100000@localhost.localdomain>
	<15291.32311.499838.886628@robur.slu.se>
	<20011003162210.L8954@turbolinux.com>
X-Mailer: VM 6.92 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andreas Dilger writes:

 > If you get to the stage where you are turning off IRQs and going to a
 > polling mode, then don't turn IRQs back on until you have a poll (or
 > two or whatever) that there is no work to be done.  This will at worst
 > give you 50% polling success, but in practise you wouldn't start polling
 > until there is lots of work to be done, so the real success rate will
 > be much higher.
 > 
 > At this point (no work to be done when polling) there are clearly no
 > interrupts would be generated (because no packets have arrived), so it
 > should be reasonable to turn interrupts back on and stop polling (assuming
 > non-broken hardware).  You now go back to interrupt-driven work until
 > the rate increases again.  This means you limit IRQ rates when needed,
 > but only do one or two excess polls before going back to IRQ-driven work.

 Hello!

 Yes this has been considered and actually I think Jamal did this in one of
 the pre NAPI patch. I tried something similar... but instead of using a number
 of excess polls I was doing excess polls for a short time (a jiffie). This 
 was the showstopper mentioned the previous mails. :-) 

 Anyway it up to driver to decide this policy. If the driver returns 
 "not_done" it is simply polled again. So low-rate network drivers can have 
 a different policy compared to an OC-48 driver. Even continues polling is
 therefore possible and even showstoppers. :-)  There are protection for
 polling livelocks.

 Cheers.
						--ro
