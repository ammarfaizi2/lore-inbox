Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316659AbSHOJUn>; Thu, 15 Aug 2002 05:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316662AbSHOJUn>; Thu, 15 Aug 2002 05:20:43 -0400
Received: from mail.arcor.net ([145.253.32.2]:50635 "EHLO mail.arcor.net")
	by vger.kernel.org with ESMTP id <S316659AbSHOJUm>;
	Thu, 15 Aug 2002 05:20:42 -0400
X-Lotus-FromDomain: ARCOR
From: Holger.Woehle@arcor.net
To: Matthew Hall <matt@ecsc.co.uk>
cc: linux-kernel@vger.kernel.org
Message-ID: <41256C16.00398630.00@ffm-hq-gtw01.Arcor.net>
Date: Thu, 15 Aug 2002 11:23:41 +0100
Subject: Re: Re: sundance.o only two ports working
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>matt@ecsc.co.uk wrote:
>I experienced problems with the sundance on the dfe580tx a while back
>too, and I made a patch for 2.4.18 a while back (it on my site (in the
>sig)), donald becker then released v1.08 on his site a while back
>(www.scyld.com) which fixed the problem (my patch now includes this).
>Please apply this patch and try again, (or try db's original version).
>Fyi, the dfe580tx doesn't support mii-diag afaik. The best error check
>was to check the output of ifconfig and see whether the RX bytes
>equalled the TX bytes (unless running lo, these shouldn't be the same,
>and they were the first time I had a problem).
>Hope this helps,
>Matt

>On Wed, 2002-08-14 at 18:37, Holger.Woehle@arcor.net wrote:
> Hello,
> i have a strange problem with two of my machines:
> They are identical P4 systems with Intel Chipset with two epro100 adapters
> onboard and a d-link dfe-580TX quad ethernet card.
> I am using Kernel 2.4.18 and sundance.o v1.07a 7/9/2002.

Hello,
i used the new V1.09 driver but nothing changed.
I have the suspicion that i run into a irq problem with the D-LINK being a
PCI-PCI bridge.
Can that be the reason ?

# cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 4).
      Prefetchable 32 bit memory at 0xe4000000 [0xe43fffff].
  Bus  0, device   1, function  0:
    PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 4).
      Master Capable.  Latency=64.  Min Gnt=6.
  Bus  0, device  30, function  0:
    PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (rev 5).
      Master Capable.  No bursts.  Min Gnt=14.
  Bus  0, device  31, function  0:
    ISA bridge: Intel Corp. 82820 820 (Camino 2) Chipset ISA Bridge (ICH2) (rev
5).
  Bus  0, device  31, function  1:
    IDE interface: Intel Corp. 82820 820 (Camino 2) Chipset IDE U100 (rev 5).
      I/O at 0xf000 [0xf00f].
  Bus  0, device  31, function  2:
    USB Controller: Intel Corp. 82820 820 (Camino 2) Chipset USB (Hub A) (rev
5).
      IRQ 5.
      I/O at 0xb000 [0xb01f].
  Bus  0, device  31, function  3:
    SMBus: Intel Corp. 82820 820 (Camino 2) Chipset SMBus (rev 5).
      IRQ 3.
      I/O at 0x500 [0x50f].
  Bus  0, device  31, function  4:
    USB Controller: Intel Corp. 82820 820 (Camino 2) Chipset USB (Hub B) (rev
5).
      IRQ 11.
      I/O at 0xb800 [0xb81f].
  Bus  2, device   1, function  0:
    PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 3).
      Master Capable.  Latency=32.  Min Gnt=6.
  Bus  2, device   6, function  0:
    Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (rev 8).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xe3200000 [0xe3200fff].
      I/O at 0xa000 [0xa03f].
      Non-prefetchable 32 bit memory at 0xe3100000 [0xe31fffff].
  Bus  2, device   7, function  0:
    Ethernet controller: Intel Corp. 82557 [Ethernet Pro 100] (#2) (rev 8).
      IRQ 9.
      Master Capable.  Latency=32.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xe3201000 [0xe3201fff].
      I/O at 0xa400 [0xa43f].
      Non-prefetchable 32 bit memory at 0xe3000000 [0xe30fffff].
  Bus  2, device   8, function  0:
    VGA compatible controller: ATI Technologies Inc Rage XL (rev 39).
      IRQ 9.
      Master Capable.  Latency=32.  Min Gnt=8.
      Non-prefetchable 32 bit memory at 0xe2000000 [0xe2ffffff].
      I/O at 0xa800 [0xa8ff].
      Non-prefetchable 32 bit memory at 0xe3202000 [0xe3202fff].
  Bus  3, device   4, function  0:
    Ethernet controller: D-Link System Inc Sundance Ethernet (rev 18).
      IRQ 3.
      Master Capable.  Latency=32.  Min Gnt=10.Max Lat=10.
      I/O at 0x9000 [0x907f].
  Bus  3, device   5, function  0:
    Ethernet controller: D-Link System Inc Sundance Ethernet (#2) (rev 18).
      IRQ 7.
      Master Capable.  Latency=32.  Min Gnt=10.Max Lat=10.
      I/O at 0x9400 [0x947f].
  Bus  3, device   6, function  0:
    Ethernet controller: D-Link System Inc Sundance Ethernet (#3) (rev 18).
      IRQ 5.
      Master Capable.  Latency=32.  Min Gnt=10.Max Lat=10.
      I/O at 0x9800 [0x987f].
  Bus  3, device   7, function  0:
    Ethernet controller: D-Link System Inc Sundance Ethernet (#4) (rev 18).
      IRQ 10.
      Master Capable.  Latency=32.  Min Gnt=10.Max Lat=10.
      I/O at 0x9c00 [0x9c7f].

# pci-config
pci-config.c:v2.02 1/8/2001 Donald Becker (becker@scyld.com)
 http://www.scyld.com/diag/index.html
Device #1 at bus 0 device/function 0/0, 1a308086.
Device #2 at bus 0 device/function 1/0, 1a318086.
Device #3 at bus 0 device/function 30/0, 244e8086.
Device #4 at bus 0 device/function 31/0, 24408086.
Device #5 at bus 0 device/function 31/1, 244b8086.
Device #6 at bus 0 device/function 31/2, 24428086.
Device #7 at bus 0 device/function 31/3, 24438086.
Device #8 at bus 0 device/function 31/4, 24448086.

with regards

Holger







