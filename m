Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129137AbRBVHTZ>; Thu, 22 Feb 2001 02:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130144AbRBVHTP>; Thu, 22 Feb 2001 02:19:15 -0500
Received: from delta.Colorado.EDU ([128.138.139.9]:55300 "EHLO
	ibg.colorado.edu") by vger.kernel.org with ESMTP id <S129137AbRBVHTB>;
	Thu, 22 Feb 2001 02:19:01 -0500
Message-Id: <200102220719.AAA398825@ibg.colorado.edu>
To: linux-kernel@vger.kernel.org
Subject: PCI oddities on Dell Inspiron 5000e w/ 2.4.x
Organization: Institute for Behavioral Genetics
              University of Colorado
              Boulder, CO  80309-0447
X-Phone: +1 303 492 2843
X-FAX: +1 303 492 0852
X-URL: http://ibgwww.Colorado.EDU/~lessem/
X-Copyright: All original content is copyright 2001 Jeff Lessem.
X-Copyright: Quoted and non-original content may be copyright the
X-Copyright: original author or others.
Date: Thu, 22 Feb 2001 00:18:59 -0700
From: Jeff Lessem <Jeff.Lessem@Colorado.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a Dell Inspiron 5000e which shows some odd behavior related to
the PCI and PCMCIA systems.  I believe this problem is related to the
kernel more than the PCMCIA modules, because the "fix" involves
booting the system to 2.2 and then into 2.4.  Though I am now using
different PCMCIA versions under 2.2 and 2.4, when the problem
originally appeared I was using the same PCMCIA version under both
kernels and it exhibited the same behavior I describe below.

After a power-off cold-boot into a 2.4 kernel the PCMCIA modules from
David Hind's external PCMCIA package are not able to load.  This
problem is present in the latest 2.4.2 and has been present through
the pre-2.4 series.  The error given is:

Linux PCMCIA Card Services 3.1.24
  kernel build: 2.4.2 unknown
  options:  [pci] [cardbus] [apm]
Intel PCIC probe: PCI: Found IRQ 11 for device 00:04.0
PCI: The same IRQ used for device 00:04.1
PCI: The same IRQ used for device 01:00.0

  Bad bridge mapping at 0x13ff0000!
not found.
ds: no socket drivers loaded!

To re-enable PCMCIA I have to power off, boot 2.2.17, load the PCMCIA
modules (version 3.1.21), and then reboot without a power off to
2.4.x.  This setup will continue to work across reboots as long as the
machines is not turned off.  As best I can tell, none of these steps
are superstitious, because if I leave one out then things do not
work.  I am not as confident about the importance of the version
numbers, because I have not tried anything past 2.2.17 and 3.1.21 to
do the "reset".  I have tried BIOS, Direct, and Any PCI access with
identical results.

The output from the loading of PCMCIA under 2.2.17 is:

Linux PCMCIA Card Services 3.1.21
  kernel build: 2.2.17 unknown
  options:  [pci] [cardbus] [apm]
PCI routing table version 1.0 at 0xfdf50
  00:04.0 -> irq 11
  00:04.1 -> irq 11
Intel PCIC probe: 
  TI 1225 rev 01 PCI-to-CardBus at slot 00:04, mem 0x68000000
 host opts [0]: [ring] [serial pci & irq] [pci irq 11] [lat 168/32] [bus 32/34]
 host opts [1]: [ring] [serial pci & irq] [pci irq 11] [lat 168/32] [bus 35/37]
    ISA irqs (scanned) = 3,4,7,9,10,15 PCI status changes

and when the PCMCIA modules properly load under 2.4.2 I get:

Linux PCMCIA Card Services 3.1.24
  kernel build: 2.4.2 unknown
  options:  [pci] [cardbus] [apm]
Intel PCIC probe: PCI: Found IRQ 11 for device 00:04.0
PCI: The same IRQ used for device 00:04.1
PCI: The same IRQ used for device 01:00.0
PCI: Found IRQ 11 for device 00:04.1
PCI: The same IRQ used for device 00:04.0
PCI: The same IRQ used for device 01:00.0
  TI 1225 rev 01 PCI-to-CardBus at slot 00:04, mem 0x68000000
  host opts [0]: [ring] [serial pci & irq] [pci irq 11] [lat 168/32] [bus 2/5]
  host opts [1]: [ring] [serial pci & irq] [pci irq 11] [lat 168/32] [bus 6/9]
    ISA irqs (scanned) = 3,4,7,10,15 PCI status changes

The PCI messages I get from the kernel during boot are:

PCI: PCI BIOS revision 2.10 entry at 0xfd9ae, last bus=1
PCI: Probing PCI hardware
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
PCI: Found IRQ 11 for device 00:04.0
PCI: The same IRQ used for device 00:04.1
PCI: The same IRQ used for device 01:00.0
PCI: Cannot allocate resource region 4 of device 00:07.1
  got res[1080:108f] for resource 4 of Intel Corporation 82371AB PIIX4 IDE
Limiting direct PCI/PCI transfers.

and lspci -v:

00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
	Flags: bus master, medium devsel, latency 64
	Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 1.0

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 03) (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 128
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: f4000000-f40fffff
	Prefetchable memory behind bridge: f8000000-fbffffff

00:04.0 CardBus bridge: Texas Instruments PCI1225 (rev 01)
	Subsystem: COMPAL Electronics Inc: Unknown device 0011
	Flags: bus master, medium devsel, latency 168, IRQ 11
	Memory at 68000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=05, sec-latency=32
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	16-bit legacy interface ports at 0001

00:04.1 CardBus bridge: Texas Instruments PCI1225 (rev 01)
	Subsystem: COMPAL Electronics Inc: Unknown device 0011
	Flags: bus master, medium devsel, latency 168, IRQ 11
	Memory at 68001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=09, sec-latency=32
	I/O window 0: 00000000-00000003
	I/O window 1: 00000000-00000003
	16-bit legacy interface ports at 0001

00:07.0 Bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
	Flags: bus master, medium devsel, latency 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	Flags: bus master, medium devsel, latency 64
	I/O ports at 1080 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	Flags: bus master, medium devsel, latency 64, IRQ 5
	I/O ports at 1060 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 03)
	Flags: medium devsel

00:08.0 Multimedia audio controller: ESS Technology ES1978 Maestro 2E (rev 10)
	Subsystem: COMPAL Electronics Inc: Unknown device 0011
	Flags: bus master, medium devsel, latency 64, IRQ 5
	I/O ports at 1400 [size=256]
	Capabilities: [c0] Power Management version 2

01:00.0 VGA compatible controller: ATI Technologies Inc Mobility M3 AGP 2x (rev 02) (prog-if 00 [VGA])
	Subsystem: COMPAL Electronics Inc: Unknown device 0011
	Flags: bus master, stepping, fast Back2Back, 66Mhz, medium devsel, latency 66, IRQ 11
	Memory at f8000000 (32-bit, prefetchable) [size=64M]
	I/O ports at 2000 [size=256]
	Memory at f4000000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [50] AGP version 2.0
	Capabilities: [5c] Power Management version 2

If any additional information would be useful in tracking down this
problem please let me know.  This might be apocryphal, but I don't
believe the problem occured until after the first time I used a
32-bit PC-CARD ethernet card.  It is my recollection that I had no
problems during the first months I owned the machine when I only used
16-bit cards.

--
Thanks,
Jeff Lessem.
