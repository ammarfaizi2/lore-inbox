Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266425AbRGOM7V>; Sun, 15 Jul 2001 08:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266428AbRGOM7L>; Sun, 15 Jul 2001 08:59:11 -0400
Received: from lilly.ping.de ([62.72.90.2]:19461 "HELO lilly.ping.de")
	by vger.kernel.org with SMTP id <S266425AbRGOM6v>;
	Sun, 15 Jul 2001 08:58:51 -0400
Date: 15 Jul 2001 14:58:30 +0200
Message-ID: <20010715125830.9309.qmail@toyland.ping.de>
From: "Michael Stiller" <michael@toyland.ping.de>
To: linux-kernel@vger.kernel.org
X-Mailer: exmh version 2.0.2 2/24/98
Subject: Cardbus Bridge no IRQ in 2.4.6
X-Url: http://www.ping.de/~michael
X-Face: "wBy`XBjk-b]Wks].wV-RmZmir({Qfv85d&!VDrjx+4Ra(/ZyXjaV-x^QXX-Ab5X#3Eap^/
  W^Zo.K9=py=t6/F&p3cl/.zrgKH)0uxy{#5Y(_dD=ftF*Q}-lp\&Z-563qR3X5qv^o9~iP(pw3_1q!
  ti@9"V[C?^iW\BVArF#(YjjLJ/[R%Ri*sw
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

i have a PCI Cardbus Bridge which is getting no interrupt from
the bios and during kernel boot. Is it possible to use the card anyway ?
Maybe assign an interrupt manually ?

The details:

kernel 2.4.6 smp machine

device in question:

00:0e.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller 
(rev 01)
        Subsystem: SCM Microsystems: Unknown device 3000
        Flags: bus master, medium devsel, latency 168
        Memory at 20000000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
        Memory window 0: 20400000-207ff000 (prefetchable)
        Memory window 1: 20800000-20bff000
        I/O window 0: 00001000-000010ff
        I/O window 1: 00001400-000014ff
        16-bit legacy interface ports at 0001

I enabled DEBUG in pci-i386.h and get the following messages:

PCI: BIOS32 Service Directory structure at 0xc00fdb60
PCI: BIOS32 Service Directory entry at 0xfdb70
PCI: BIOS probe returned s=00 hw=01 ver=02.10 l=01
PCI: PCI BIOS revision 2.10 entry at 0xfdb91, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: IDE base address fixup for 00:07.1
PCI: Scanning for ghost devices on bus 0
PCI: Scanning for ghost devices on bus 1
PCI: IRQ init
PCI: Interrupt Routing Table found at 0xc00f8100
00:01 slot=00 0:60/deb8 1:61/deb8 2:00/deb8 3:00/deb8
00:07 slot=00 0:fe/4000 1:ff/8000 2:00/0000 3:63/deb8
00:0e slot=01 0:61/deb8 1:62/deb8 2:63/deb8 3:60/deb8
00:0f slot=02 0:62/deb8 1:63/deb8 2:60/deb8 3:61/deb8
00:10 slot=03 0:63/deb8 1:60/deb8 2:61/deb8 3:62/deb8
00:12 slot=04 0:60/deb8 1:61/deb8 2:62/deb8 3:63/deb8
00:13 slot=05 0:60/deb8 1:61/deb8 2:62/deb8 3:63/deb8
00:09 slot=00 0:60/deb8 1:60/deb8 2:00/deb8 3:00/deb8
PCI: Attempting to find IRQ router for 8086:7110
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
PCI: IRQ fixup
00:0e.0: ignoring bogus IRQ 255

^^^

querying PCI -> IRQ mapping bus:0, slot:7, pin:3.
PCI->APIC IRQ transform: (B0,I7,P3) -> 19
querying PCI -> IRQ mapping bus:0, slot:14, pin:0.

^^^

querying PCI -> IRQ mapping bus:0, slot:15, pin:0.
PCI->APIC IRQ transform: (B0,I15,P0) -> 18
querying PCI -> IRQ mapping bus:0, slot:16, pin:0.
PCI->APIC IRQ transform: (B0,I16,P0) -> 19
querying PCI -> IRQ mapping bus:0, slot:16, pin:0.
PCI->APIC IRQ transform: (B0,I16,P0) -> 19
querying PCI -> IRQ mapping bus:0, slot:18, pin:0.
PCI->APIC IRQ transform: (B0,I18,P0) -> 16
querying PCI -> IRQ mapping bus:1, slot:0, pin:0.
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
PCI: Allocating resources
PCI: Resource e8000000-ebffffff (f=1208, d=0, p=0)
PCI: Resource 0000ffa0-0000ffaf (f=101, d=0, p=0)
PCI: Resource 0000dc00-0000dc1f (f=101, d=0, p=0)
PCI: Resource effff000-efffffff (f=200, d=0, p=0)
PCI: Resource efe00000-efefffff (f=200, d=0, p=0)
PCI: Resource edbfe000-edbfefff (f=1208, d=0, p=0)
PCI: Resource edbff000-edbfffff (f=1208, d=0, p=0)
PCI: Resource 0000d800-0000d81f (f=101, d=0, p=0)
PCI: Resource ee000000-eeffffff (f=200, d=0, p=0)
PCI: Resource e4000000-e4ffffff (f=1208, d=0, p=0)
  got res[20000000:20000fff] for resource 0 of Texas Instruments PCI1410 PC 
card
 Cardbus Controller

Any clues ? Should i send more details ? If yes, which ones ?

Cheers,

-Michael



