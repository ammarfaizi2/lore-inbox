Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130585AbRCEByS>; Sun, 4 Mar 2001 20:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130588AbRCEByI>; Sun, 4 Mar 2001 20:54:08 -0500
Received: from tomts8.bellnexxia.net ([209.226.175.52]:53384 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S130585AbRCEBx4>; Sun, 4 Mar 2001 20:53:56 -0500
Message-ID: <3AA2F08D.30E48B90@coplanar.net>
Date: Sun, 04 Mar 2001 20:49:01 -0500
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Erwin Six <Erwin.Six@rug.ac.be>
CC: linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: Slight Time drift in linux by division fault
In-Reply-To: <Pine.GSO.4.10.10103050127180.15575-100000@eduserv2.rug.ac.be>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erwin Six wrote:

> Hello,
>
> I'm a senior Student in electronic Engineering. A lot of my work takes
> place inside the network-part of the kernel, but now I'm confronted with
> time. I designed a hardware-board whitch trys to synchronize

I would study the xntpd daemon furthur before trying to reinvent the wheel.
PC clock oscillators are notoriously inaccurate, the ntp documentation
goes really in depth about the kernel and time, so try reading this first.

Good luck!

>
> network-monitors by GPS. Electronicly this board is tested, and it has an
> hardware resolution of about 1 usec (in phase, so in relative time). Now
> I'm writing the device-driver that synchronizes the Linux-time system. If
> I interrupt the kernel at the exact GPS-zero-time. And I watch the
> do_timeoftheday() the seconds increases, but there is also a extra
> increase of +-16 usec each second. So it seams that a linux second takes
> 16usec more than one GPS second. Can I explain this with math?
>
> the cristal inside the computer ticks with a frequency of 1193180 Hz this
> 16usec could be an fault of 16ppm whitch is rather big. But 2 diffrent
> systems have the allmost drift (+-2). Or it can be caused by the division
> inside the linux time-system (whitch is possible after you see this
> calculations)
>
> If HZ = 100 then the LATCH of the PIT = (1193180 + HZ/2) / HZ = 11932
> so in 1 sec we have 1193200 ticks of the PIT which causes 100
> timer-interrupts. 1193200 ticks instead of 1193180 means that there are 20
> ticks to mutch inside of each second. or 20 * 1/1193180 = 16.7619 usec. or
> 1 second to mutch every 16.5 hours (or 8.8 minutes a year). I've looked
> the PLL closely but I can't find a mechanisme that compensates for this
> problem, maybe I'm looking over it? Indeed 8.8 minutes is mutch, but I
> think if I hadn't use a GPS, I wouldn't notice it.
>
> Why do I suppose the second option? If you play a little bit with the HZ
> parameter, you can let your timeclock drift mutch faster just by taking a
> HZ that has a big 1193180 % HZ. eg. 5000 Hz gives a latch of 291 which
> causes 119500 instead of 1193180 or a drift of 1820 ticks = 1.525 ms!
>
> I have some solutions in mind to compensate this problem, but I have to
> be sure.
> Can somebody confirm this problem?

