Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130581AbRCEBXm>; Sun, 4 Mar 2001 20:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130582AbRCEBXc>; Sun, 4 Mar 2001 20:23:32 -0500
Received: from dobit2.rug.ac.be ([157.193.42.8]:61633 "EHLO dobit2.rug.ac.be")
	by vger.kernel.org with ESMTP id <S130581AbRCEBXU>;
	Sun, 4 Mar 2001 20:23:20 -0500
Date: Mon, 5 Mar 2001 02:22:58 +0100 (MET)
From: Erwin Six <Erwin.Six@rug.ac.be>
To: linux-kernel@vger.kernel.org
cc: andrea@suse.de
Subject: Slight Time drift in linux by division fault 
Message-ID: <Pine.GSO.4.10.10103050127180.15575-100000@eduserv2.rug.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I'm a senior Student in electronic Engineering. A lot of my work takes
place inside the network-part of the kernel, but now I'm confronted with
time. I designed a hardware-board whitch trys to synchronize
network-monitors by GPS. Electronicly this board is tested, and it has an
hardware resolution of about 1 usec (in phase, so in relative time). Now
I'm writing the device-driver that synchronizes the Linux-time system. If
I interrupt the kernel at the exact GPS-zero-time. And I watch the
do_timeoftheday() the seconds increases, but there is also a extra
increase of +-16 usec each second. So it seams that a linux second takes 
16usec more than one GPS second. Can I explain this with math? 

the cristal inside the computer ticks with a frequency of 1193180 Hz this
16usec could be an fault of 16ppm whitch is rather big. But 2 diffrent
systems have the allmost drift (+-2). Or it can be caused by the division
inside the linux time-system (whitch is possible after you see this
calculations)

If HZ = 100 then the LATCH of the PIT = (1193180 + HZ/2) / HZ = 11932
so in 1 sec we have 1193200 ticks of the PIT which causes 100
timer-interrupts. 1193200 ticks instead of 1193180 means that there are 20
ticks to mutch inside of each second. or 20 * 1/1193180 = 16.7619 usec. or
1 second to mutch every 16.5 hours (or 8.8 minutes a year). I've looked
the PLL closely but I can't find a mechanisme that compensates for this
problem, maybe I'm looking over it? Indeed 8.8 minutes is mutch, but I
think if I hadn't use a GPS, I wouldn't notice it.

Why do I suppose the second option? If you play a little bit with the HZ
parameter, you can let your timeclock drift mutch faster just by taking a
HZ that has a big 1193180 % HZ. eg. 5000 Hz gives a latch of 291 which
causes 119500 instead of 1193180 or a drift of 1820 ticks = 1.525 ms!

I have some solutions in mind to compensate this problem, but I have to
be sure. 
Can somebody confirm this problem?

Erwin Six



