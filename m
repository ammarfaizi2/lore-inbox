Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265755AbTL3L3H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 06:29:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265756AbTL3L3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 06:29:07 -0500
Received: from lde1508.emirates.net.ae ([217.165.123.238]:12292 "EHLO athena")
	by vger.kernel.org with ESMTP id S265755AbTL3L3B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 06:29:01 -0500
Date: Tue, 30 Dec 2003 03:59:16 +0400 (GST)
From: Amit Gurdasani <amitg@alumni.cmu.edu>
X-X-Sender: amitg@athena
To: Adam Belay <ambx1@neo.rr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: EISA ID for PnP modem and resource allocation
In-Reply-To: <20031229143711.GA3176@neo.rr.com>
Message-ID: <Pine.LNX.4.56.0312300338360.1163@athena>
References: <Pine.LNX.4.56.0312261610200.1798@athena> <20031229143711.GA3176@neo.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

:Without special hardware modifications, it is usually unsafe to share irqs
:between isa devices.

Ah. So 2.4's behavior was broken then?

:> The reason I ask is that I also have a jumpered SB16 on IRQ 5, and loading
:> the 8250 driver before the snd_sb16 driver results in the SB16's IRQ being
:> allocated for the modem, which prevents the SB16 driver from loading.
:> Loading the SB16 driver first results in resource starvation for the modem,
:> and the 8250 driver is only able to set up the onboard serial ports ttyS0
:> and ttyS1.
:
:You may want to try changing the jumper on your SB16 to allow for PnP
:autoconfiguration.

It's a pre-PnP SB16 from 1994, as far as I can tell -- IRQ, I/O port and DMA
channels can be set only by setting jumpers. I suppose I could pull the card
out and set its IRQ setting to something the modem won't claim.

:> In the meantime, I'm using the isapnptools to set up the modem with IRQ 4
:> before loading either driver. The result is that the SB16 driver gets IRQ 5
:> as needed, and ttyS0 is set up with IRQ 0 (is this OK?), but I'd really like
:> to use the kernel ISA PnP support.
:
:Could I please see a copy of your /proc/interrupts.

           CPU0
  0:     314288          XT-PIC  timer
  1:       1024          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:       7444          XT-PIC  SoundBlaster
  8:          1          XT-PIC  rtc
  9:       4675          XT-PIC  ide2
 10:         41          XT-PIC  eth0
 11:      89930          XT-PIC  i91u
 12:      10092          XT-PIC  i8042
 15:         57          XT-PIC  ide1
NMI:          0
LOC:          0
ERR:          0
MIS:          0

Apart from these, dmesg output shows these IRQs allocated:

ttyS0 at I/O 0x3f8 (irq = 0) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
parport0: irq 7 detected

Additionally, pnpdump says the modem can only claim an IRQ line from among
3, 4, 5, 7, 9, 10, 11, 12 or 15 in various configurations.

:The 2.4 series was not always aware of motherboard devices such as serial
:ports. Were you able to use ttyS0 and your modem at the same time?

Come to think of it, I didn't try this.

[...]

OK, testing with 2.4.23, it seems that indeed, an old Mouse
Systems-compatible mouse attached to ttyS0 won't work (no events received
over the port), but will attached to ttyS1. (Modem was not in use.)

[...]

Testing with 2.6.0 produces the same results. (A conflict with the timer?)
However, I'm not certain the port is itself physically OK. (It's one of
those bracket configurations that should be connected to the motherboard --
I'll have to check if its connector's fallen off the motherboard header.)

Thanks,

Amit
