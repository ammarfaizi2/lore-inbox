Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132349AbQKZQhi>; Sun, 26 Nov 2000 11:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132348AbQKZQh3>; Sun, 26 Nov 2000 11:37:29 -0500
Received: from sneaker.sch.bme.hu ([152.66.226.5]:20745 "EHLO
        sneaker.sch.bme.hu") by vger.kernel.org with ESMTP
        id <S132144AbQKZQhM>; Sun, 26 Nov 2000 11:37:12 -0500
Date: Sun, 26 Nov 2000 17:06:59 +0100 (CET)
From: "Mr. Big" <mrbig@sneaker.sch.bme.hu>
Reply-To: "Mr. Big" <mrbig@sneaker.sch.bme.hu>
To: Andrew Morton <andrewm@uow.edu.au>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PROBLEM: crashing kernels
In-Reply-To: <3A20501E.32EEB3C8@uow.edu.au>
Message-ID: <Pine.LNX.3.96.1001126164611.8011A-100000@sneaker.sch.bme.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Previous day I followed the hint of Alan, and made a 2.2.14 kernel, with
the DAC960 driver taken from the 2.2.17, for these changes I've copied
the:
drivers/block/DAC960.c
drivers/block/DAC960.h
drivers/pci/oldrpoc.c
include/linux/pci.h
from the 2.2.17 sourcetree into the 2.2.14. Ok, it compiled.
We also borrowed another mainboard, cpu's and ram for test. We changed
them all, but the borrowed ram was just 512Mb, so we had to do a hard cut
back on the services, for could fit into it. I think I didn't mention yet,
we're using an intel L440GX+ mainboard. For the CPU's see my original
mail. The new CPU's were the same speed (550Mhz) but Katmai's insted of
the Coppermine's.
We removed the Eepros also, just left a 3Com, and a dlink card. This one
isn't the best, but with it's own driver in another computer it's working
with the 2.2.14 kernel since months ago without any troubles.

The kernel booted up. Just the 3Com driver throwed some errors, and warned
that the cheksum isn't good, so I decided to take the driver from the
2.2.17 also, for this I copied the
drivers/net/3c59x.c

For the boot I also followed Andrew's hint, and booted with the noapic
option.
This one is much newer, and this way the 2.2.14 worked well the whole
night.

In the afternoon we decided to put back the original mainboard+ram+cpu.
We booted the kernel described above.
I just noticed then, that all the interrupts went to the CPU1, while the
CPU0 didn't get any. Is this because of the noapic option?

The worst is, that after two hours same black crash again. (no ping, no
console, no keyboard leds)

I believe we face a kind of hardware problem, or some hardware specific
software problem. Any idea wich of the hardware components could be bad,
or wich are badly supported by some drivers?

> This is caused by the APIC(s) forgetting how to deliver interrupts
> for a particular IRQ.  Normally, reloading the driver doesn't help.
> But in your case it did.  This is odd.

How could an APIC 'forget' how to deliver the interrupts? Could this mean
a problem with the mainboard, or with the CPU?

Thanks for Your help.

+--------------------------------------------+
| Nagy Attila                                |
|   mailto:mrbig@sneaker.sch.bme.hu          |
+--------------------------------------------+



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
