Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314444AbSDRUaL>; Thu, 18 Apr 2002 16:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314450AbSDRUaK>; Thu, 18 Apr 2002 16:30:10 -0400
Received: from boink.boinklabs.com ([162.33.131.250]:42765 "EHLO
	boink.boinklabs.com") by vger.kernel.org with ESMTP
	id <S314444AbSDRUaK>; Thu, 18 Apr 2002 16:30:10 -0400
Date: Thu, 18 Apr 2002 16:29:43 -0400
From: Charlie Wilkinson <cwilkins@boinklabs.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hard lock-ups on RH7.2 install - Via Chipset?
Message-ID: <20020418162943.A7808@boink.boinklabs.com>
In-Reply-To: <20020221105756.A9728@boink.boinklabs.com> <E16dw9r-0007R1-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
X-Home-Sweet-Home: RedHat 6.0 / Linux 2.2.12 on an AMD K6-225
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2002 at 04:33:23PM +0000, Alan Cox waxed eloquent:
>.
> > I can confirm that it still locks up.  :/  What can I do to help?
>.
> I'm assuming its a hardware issue. It works on non VIA for multiple people
> it fails on VIA for multiple people

I think I found a solution.  At the very least, I've found something
that drastically affects reliability of this hardware combo.

The combo in question is a KT133 chipset (Phoenix BIOS), Athlon 1.3GHz,
2 Promise Ultra100 IDE controllers with an IBM 75gb drive on each channel
(4 drives).  Doing anything that beat on all 4 drives sufficiently
(such as software RAID5) would hang the system hard.

The magic settings that had a drastic impact on reliability were the PCI
device latency timers.  The early settings I tried just changed how long
the system would run before it crashed (in some cases making things *much*
worse).  Then after more of something one could loosely term "research", I
hit on some settings that seem to have resulted in a fully stable system!

Forthwith and to wit:

setpci -v -d *:* latency_timer=b0
setpci -v -d 105a:* latency_timer=ff

Yes, that's a baseline setting of 176 for everything, then max settings
for the two Promise cards.  Rather drastic?  Perhaps, but it works.
More research and tweaking is probably in order.

I wanted to get the news out -- even if a bit premature -- in hopes that
it might relieve someone else's grief.  It's really sucked having all
this hardware for three months and not being able to put it to good use
(unless crash testing counts...)

-cw-
