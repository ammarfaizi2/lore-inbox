Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265648AbSJXUe6>; Thu, 24 Oct 2002 16:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265649AbSJXUe6>; Thu, 24 Oct 2002 16:34:58 -0400
Received: from dsl093-058-082.blt1.dsl.speakeasy.net ([66.93.58.82]:33529 "EHLO
	beohost.scyld.com") by vger.kernel.org with ESMTP
	id <S265648AbSJXUez>; Thu, 24 Oct 2002 16:34:55 -0400
Date: Thu, 24 Oct 2002 16:41:14 -0400 (EDT)
From: Donald Becker <becker@scyld.com>
To: Dionysius Wilson Almeida <dwilson@yenveedu.com>
cc: vortex-bug@scyld.com, <linux-kernel@vger.kernel.org>
Subject: Re: [vortex-bug] 3Com Cardbus 3CXFE575CT IRQ Problems
In-Reply-To: <1035482672.1957.82.camel@debianlap>
Message-ID: <Pine.LNX.4.44.0210241633550.1190-100000@beohost.scyld.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Oct 2002, Dionysius Wilson Almeida wrote:

> I'm running Debian Woody with kernel 2.4.19 with cardbus and hotplug
> support.  I've a 3Com 3CXFE575CT pcmcia card and I'm trying to get it to
> work on my system. It seems that the card is unable to find a usable
> IRQ.

As you likely already know, this is a kernel / BIOS issue, not a 3Com
driver issue.  This problem will exist with any CardBus card that uses
interrupts (almost every device).

> I've disabled Plug-n-Play in the BIOS of my Sony VAIO PCG-FX140
> Laptop but still the card is not able to get any usable IRQs. I also
> booted with pci=biosirq but still no progress.

You can also try "noapic", although that's almost never a issue on a
laptop.  (It's more likely to be an issue on a desktop with a
PCI-CardBus adapter.) 

> Oct 24 19:11:40 debianlap kernel: Linux Kernel Card Services 3.1.22
> Oct 24 19:11:40 debianlap kernel:   options:  [pci] [cardbus] [pm]
> Oct 24 19:11:40 debianlap kernel: PCI: No IRQ known for interrupt pin A
> of device 01:02.0.
> Oct 24 19:11:40 debianlap kernel: PCI: No IRQ known for interrupt pin B
> of device 01:02.1.

Yup, I'm guessing this is one of them thar' VAIO-ACPI issues.

> Unfortunately the BIOS does not have any options to manually set IRQ for
> the pcmica.  Also most times when the card is inserted, the system just
> freezes (i.e. mouse, keyboard display just locks up) until i remove the 
> card at which point every get back to normal.  This is really strange.
...
> 00:00.0 Host bridge: Intel Corp. 82815 815 Chipset Host Bridge and
> Memory Controller Hub (rev 11)
> 	Subsystem: Sony Corporation: Unknown device 80df
...
> 00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 03)
> (prog-if 00 [Normal decode])
> 	Flags: bus master, fast devsel, latency 0
> 	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
...
> 01:00.0 FireWire (IEEE 1394): Texas Instruments TSB43AA22 IEEE-1394

Does the FireWire work properly?  It's sitting on the same secondary PCI
bus as the CardBus.

> 01:02.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
> 	Subsystem: Sony Corporation: Unknown device 80df
...
> 	Bus: primary=01, secondary=02, subordinate=05, sec-latency=176
> 01:02.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev 80)
> 	Subsystem: Sony Corporation: Unknown device 80df
..
> 01:08.0 Ethernet controller: Intel Corp. 82801BA/BAM/CA/CAM Ethernet
> Controller (rev 03)
> 	Subsystem: Intel Corp.: Unknown device 3013
> 	Flags: bus master, medium devsel, latency 66, IRQ 9

Presumably this is work fine as well.

-- 
Donald Becker				becker@scyld.com
Scyld Computing Corporation		http://www.scyld.com
410 Severn Ave. Suite 210		Scyld Beowulf cluster system
Annapolis MD 21403			410-990-9993

