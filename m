Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278867AbRJ1XLR>; Sun, 28 Oct 2001 18:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278868AbRJ1XLH>; Sun, 28 Oct 2001 18:11:07 -0500
Received: from trillium-hollow.org ([209.180.166.89]:26895 "EHLO
	trillium-hollow.org") by vger.kernel.org with ESMTP
	id <S278867AbRJ1XKv>; Sun, 28 Oct 2001 18:10:51 -0500
To: linux-kernel@vger.kernel.org
cc: Raphael Manfredi <Raphael_Manfredi@pobox.com>
Subject: APM disable broken (was -> Re: 8139too on ABIT BP6 causes "eth0: transmit timed out" )
In-Reply-To: Your message of "Sun, 28 Oct 2001 23:30:12 +0100."
             <16095.1004308212@nice.ram.loc> 
Date: Sun, 28 Oct 2001 15:11:27 -0800
From: erich@uruk.org
Message-Id: <E15xz5T-0008SA-00@trillium-hollow.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Raphael Manfredi <Raphael_Manfredi@pobox.com> wrote:

...[recent 2.4-based kernel]...

> but this problem is not specific to that kernel.  I've been having
> it for a looong time.
> 
> Specifically, I get:
> 
>  NETDEV WATCHDOG: eth0: transmit timed out
...
> and then the machine is dead, network-wise.  I have to reboot (reset).
> 
> Note that I am on an ABIT BP6 board, and I do get a lot of APIC errors
> under heavy network traffic, which is what raises the above.
> By heavy network traffic, I mean a 7 Mb/s full duplex (it's a 100 Mb/s
> LAN).

I had what looks like exactly this problem with my ABIT BP6 -based machine
running RH 7.1, and the problem turned out to be the interaction between
SMP and the APM BIOS, when APM is turned on.  A different network card,
but the same symptom.  Another symptom I would occasionally see was a
certain kind of hard-disk hang, but only on the integrated HPT366
controller.

I suggest you try either:

  --  adding the "noapic" line to your kernel command-line (which will
      lose you some I/O performance since normal interrupts will not be
      handled APIC-style)
  --  completely disabling APM from your kernel configuration.  Using
      "apm=off/disabled" (I can't remember the exact one you're supposed
      to use here) does not totally disable APM usage.


This brings me to my other point.  During the Linux kernel startup
code (in the early assembly), the APM BIOS checking code leaves the
BIOS in the "connected" state even if the kernel option for disabling
APM or the SMP forced disable of APM is triggered.

This makes various motherboards (such as the ABIT BP6) unstable.

The Right Thing to do would be to disconnect the APM BIOS if it is
determined that APM support should be disabled.

I could probably generate a patch to fix this if it looked like it would
be accepted by the folks maintaining APM support...

--
    Erich Stefan Boleyn     <erich@uruk.org>     http://www.uruk.org/
"Reality is truly stranger than fiction; Probably why fiction is so popular"
