Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129408AbQK1TMU>; Tue, 28 Nov 2000 14:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130423AbQK1TML>; Tue, 28 Nov 2000 14:12:11 -0500
Received: from sneaker.sch.bme.hu ([152.66.226.5]:8722 "EHLO
        sneaker.sch.bme.hu") by vger.kernel.org with ESMTP
        id <S129408AbQK1TME>; Tue, 28 Nov 2000 14:12:04 -0500
Date: Tue, 28 Nov 2000 19:34:22 +0100 (CET)
From: "Mr. Big" <mrbig@sneaker.sch.bme.hu>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: crashing kernels
In-Reply-To: <Pine.GSO.3.96.1001128091924.23460A-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.3.96.1001128192620.1786A-100000@sneaker.sch.bme.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > The output of lspci -v:
> [...]
> > 00:0e.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
> >         Subsystem: Intel Corporation 82559 Fast Ethernet LAN on Motherboard
> >         Flags: bus master, medium devsel, latency 64, IRQ 5
> 
>  Hmm, this is the device you reported you have a problem initially, isn't
> it?  If it is, then...
> 
> > 00:12.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
> >         Flags: bus master, medium devsel, latency 64, IRQ 5
> 
>  ... it shares its IRQ with an USB host adapter as I suspected.  And you
> don't have an USB driver installed.  Does the following patch help?  (Hmm,
> since you tested 2.4.0-test* as well -- it might not as it's just a
> backport...  Then again -- you might hit a different problem with
> 2.4.0-test*.) 

Yes You are right. This Ether Express is integrated on the motherboard, so
we couldn't get it out totally :( But there isn't any cable connected to
it, we also doesn't have the driver in the kernel. This is the same with
the USB too. Do You mind, that they could have some kind of conflict just
on they own, without being really used?

Currently after changing the processors to Katmais, and disabling the
apic, and some of the other unused peripheries, it seems, that the system
is more stable. If the errors come again, I'll try to compile the USB
driver also.


>  It's not impossible for an I/O APIC to lose an EOI message if there are
> severe errors during the transmission -- since you already tried
> 2.4.0-test*: have you seen any APIC errors in the syslog? 

Nope, specially we didn't get errors from the APIC himself. But both
network cards (except the EtherExpress) were saying errors considering to
interrupts.
3Com:
kernel: eth0: Interrupt posted but not delivered -- IRQ blocked by another
device?
kernel:   Flags; bus-master 1, full 0; dirty 112(0) current 112(0).
kernel:   Transmit list 00000000 vs. f20ac200.
kernel:   0: @f20ac200  length 80000036 status
...
kernel:   15: @f20ac2f0  length 80000042 status
kernel: eth0: Resetting the Tx ring pointer.


DLink:
Kernel Panic: skput:over: a00f8d9b: 1526 put: 66 dev: eth1
In interrupt handler - not syncing

after SysRQ+ALT+u:
Aiee, killing interrupt handler
Unable to handle kernel NULL pointer dereference

Thanx for the USB patch, I'll try it also.


+--------------------------------------------+
| Nagy Attila                                |
|   mailto:mrbig@sneaker.sch.bme.hu          |
+--------------------------------------------+

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
