Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129932AbQK0UF1>; Mon, 27 Nov 2000 15:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129992AbQK0UFR>; Mon, 27 Nov 2000 15:05:17 -0500
Received: from sneaker.sch.bme.hu ([152.66.226.5]:19728 "EHLO
        sneaker.sch.bme.hu") by vger.kernel.org with ESMTP
        id <S129932AbQK0UFG>; Mon, 27 Nov 2000 15:05:06 -0500
Date: Mon, 27 Nov 2000 20:35:00 +0100 (CET)
From: "Mr. Big" <mrbig@sneaker.sch.bme.hu>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: crashing kernels
In-Reply-To: <Pine.GSO.3.96.1001127193828.13774W-100000@delta.ds2.pg.gda.pl>
Message-ID: <Pine.LNX.3.96.1001127203333.9821A-100000@sneaker.sch.bme.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2000, Maciej W. Rozycki wrote:

> On Mon, 27 Nov 2000, Mr. Big wrote:
> 
> > But maybe the /proc/interrupts could be usefull:
> >            CPU0       CPU1       
> >   0:     413111          0          XT-PIC  timer
> >   1:        687          0          XT-PIC  keyboard
> >   2:          0          0          XT-PIC  cascade
> >   7:     751660          0          XT-PIC  eth1
> >  10:    7377626          0          XT-PIC  eth0
> >  11:     238981          0          XT-PIC  Mylex AcceleRAID 352, aic7xxx, aic7xxx
> >  13:          1          0          XT-PIC  fpu
> >  14:         10          0          XT-PIC  ide0
> > NMI:          0
> > ERR:          0
> 
>  Hmm, nothing special.  Getting this in the APIC mode would possibly be
> more useful.  Isn't there anything that's sharing the IRQ with eth0 that's
> unhandled?  An unhandled onboard device?  What IRQs are reported by
> `/sbin/lspci -v'? 

We've disabled the apic, because there was a hint, that maybe there's some
bug with the hardware or software on it. I belive that it's could be
better to use the apic.

The output of lspci -v:

00:00.0 Host bridge: Intel Corporation 440GX - 82443GX Host bridge
        Flags: bus master, medium devsel, latency 64
        Memory at f8000000 (32-bit, prefetchable)
        Capabilities: [a0] AGP version 1.0

00:01.0 PCI bridge: Intel Corporation 440GX - 82443GX AGP bridge (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=02, sec-latency=64

00:0b.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 74)
        Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
        Flags: bus master, medium devsel, latency 64, IRQ 10
        I/O ports at 2080
        Memory at f4101000 (32-bit, non-prefetchable)
        Capabilities: [dc] Power Management version 2

00:0c.0 SCSI storage controller: Adaptec 7896
        Subsystem: Adaptec: Unknown device 0053
        Flags: bus master, medium devsel, latency 64, IRQ 11
        BIST result: 00
        I/O ports at 2400
        Memory at f4102000 (64-bit, non-prefetchable)
        Capabilities: [dc] Power Management version 1

00:0c.1 SCSI storage controller: Adaptec 7896
        Subsystem: Adaptec: Unknown device 0053
        Flags: bus master, medium devsel, latency 64, IRQ 11
        BIST result: 00
        I/O ports at 2800
        Memory at f4103000 (64-bit, non-prefetchable)
        Capabilities: [dc] Power Management version 1

00:0d.0 PCI bridge: Intel Corporation: Unknown device 0964 (rev 02) (prog-if 00 [Normal decode])
        Flags: bus master, medium devsel, latency 64
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=64

00:0d.1 RAID bus controller: Mylex Corporation: Unknown device 0050 (rev 02)
        Subsystem: Mylex Corporation: Unknown device 0050
        Flags: bus master, medium devsel, latency 64, IRQ 11
        Memory at f4106000 (32-bit, prefetchable)
        Capabilities: [80] Power Management version 2

00:0e.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 08)
        Subsystem: Intel Corporation 82559 Fast Ethernet LAN on Motherboard
        Flags: bus master, medium devsel, latency 64, IRQ 5
        Memory at f4100000 (32-bit, non-prefetchable)
        I/O ports at 2000
        Memory at f4000000 (32-bit, non-prefetchable)
        Capabilities: [dc] Power Management version 2

00:10.0 Ethernet controller: D-Link System Inc: Unknown device 1002
        Subsystem: D-Link System Inc: Unknown device 1002
        Flags: bus master, medium devsel, latency 64, IRQ 7
        I/O ports at 2c00
        Memory at f4101400 (32-bit, non-prefetchable)
        Capabilities: [50] Power Management version 1

00:12.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
        Flags: bus master, medium devsel, latency 0

00:12.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
        Flags: bus master, medium devsel, latency 64
        I/O ports at 2040

00:12.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
        Flags: bus master, medium devsel, latency 64, IRQ 5
        I/O ports at 2060

00:12.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
        Flags: medium devsel

00:14.0 VGA compatible controller: Cirrus Logic GD 5480 (rev 23) (prog-if 00 [VGA])
        Subsystem: Cirrus Logic CL-GD5480
        Flags: bus master, medium devsel, latency 64
        Memory at f6000000 (32-bit, prefetchable)
        Memory at f4104000 (32-bit, non-prefetchable)

01:0f.0 PCI bridge: Digital Equipment Corporation DECchip 21150 (rev 06) (prog-if 00 [Normal decode])
        Flags: bus master, fast Back2Back, 66Mhz, medium devsel, latency 240
        Bus: primary=01, secondary=02, subordinate=02, sec-latency=68
        Capabilities: [dc] Power Management version 1



+--------------------------------------------+
| Nagy Attila                                |
|   mailto:mrbig@sneaker.sch.bme.hu          |
+--------------------------------------------+

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
