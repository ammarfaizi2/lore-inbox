Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291900AbSBASQr>; Fri, 1 Feb 2002 13:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291901AbSBASQh>; Fri, 1 Feb 2002 13:16:37 -0500
Received: from ns.snowman.net ([63.80.4.34]:19212 "EHLO ns.snowman.net")
	by vger.kernel.org with ESMTP id <S291900AbSBASQX>;
	Fri, 1 Feb 2002 13:16:23 -0500
Date: Fri, 1 Feb 2002 13:16:15 -0500 (EST)
From: <nick@snowman.net>
To: "Edward S. Marshall" <esm@logic.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: PCI Problems [was Re: NIC lockup in 2.4.17 (SMP/APIC/Intel
 82557)]
In-Reply-To: <1012585929.1843.45.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.21.0202011315040.12736-100000@ns>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Odd, I've got an HP LPr with an     Ethernet controller: Intel Corporation
82557 [Ethernet Pro 100] (rev 8). on the riser.  Works fine for me under
the debian SMP kernel Linux version 2.4.5-686-smp (herbert@gondolin) (gcc
version 2.95.4 20010319 (Debian prerelease)) #1 SMP Sun May 27 18:32:54
EST 2001.  If you'd like me to test a workload or similar let me know, the
system is relativly low memory though.
	Nick

On 1 Feb 2002, Edward S. Marshall wrote:

> On Thu, 2002-01-31 at 11:54, Ben Greear wrote:
> > The only lockup problems I have run into are connecting some eepro nics to
> > a 10bt hub, and using (cheap arsed, it appears) PCI riser cards.  I have
> > heard of some SMP related issues, but nothing concrete, and I don't
> > have any SMP systems personally.  You could try the e100, but I have
> > no idea if it will be better or worse for your particular problem.
> 
> I was running into the same problems here; SMP system w/PCI riser card
> (HP NetServer LPr), connected to a 10/100 switch. I'd get
> "wait_for_command_timeout" errors all the time under moderate network
> load. Switching to the e100 driver didn't help in the slightest.
> Eventually, I'd experience a complete system lockup.
> 
> Replacing the card with a 3c59x-based card put the machine back in
> service (I've completely written eepro100s off as a viable cards now),
> although I still saw occasional PCI-related issues. Specifically:
> 
> Jan 23 10:11:37 x kernel: Uhhuh. NMI received. Dazed and confused, but
> trying to continue
> Jan 23 10:11:37 x kernel: eth0: Host error, FIFO diagnostic register
> 0000.
> Jan 23 10:11:37 x kernel: eth0: PCI bus error, bus status 80000020
> Jan 23 10:11:37 x kernel: You probably have a hardware problem with your
> RAM chips
> Jan 23 10:11:37 x kernel: eth0: Host error, FIFO diagnostic register
> 0000.
> Jan 23 10:11:37 x kernel: eth0: PCI bus error, bus status 80000020
> 
> The last two messages will repeat indefinitely, usually with a hit to
> the dist for each pair of log entries (resulting in a very distinctive
> drive grinding). Memory problems don't seem to be the issue; with a
> fairly extensive run of memtest86, everything came back clean.
> 
> Taking a few minutes to try and rectify the situation, I started
> shutting down services and manually unloading modules to see what was
> causing the problem. Unloading usbcore did the trick:
> 
> Jan 26 18:41:24 x kernel: eth0: Host error, FIFO diagnostic register
> 0000.
> Jan 26 18:41:24 x kernel: eth0: PCI bus error, bus status 80000020
> Jan 26 18:41:24 x kernel: eth0: Too much work in interrupt, status e003.
> Jan 26 18:41:24 x kernel: usb.c: USB disconnect on device 1
> Jan 26 18:41:24 x kernel: USB bus 1 deregistered
> 
> I've rebooted the machine since then, but have always unloaded usb-uhci
> and usbcore after booting. The issue hasn't cropped up again, although
> it happened every couple of days previously.
> 
> The kernel in question is Red Hat's kernel-smp-2.4.9-21 build.
> 
> -- 
> Edward S. Marshall <esm@logic.net>                       
> http://esm.logic.net/
> -------------------------------------------------------------------------------
> [                  Felix qui potuit rerum cognoscere causas.            
> ]
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

