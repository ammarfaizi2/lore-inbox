Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284147AbRLWXQp>; Sun, 23 Dec 2001 18:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284176AbRLWXQf>; Sun, 23 Dec 2001 18:16:35 -0500
Received: from berta.E-Technik.Uni-Dortmund.DE ([129.217.182.12]:1797 "HELO
	kt.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S284147AbRLWXQc>; Sun, 23 Dec 2001 18:16:32 -0500
Date: Mon, 24 Dec 2001 00:16:30 +0100
From: Wolfgang Wegner <ww@kt.e-technik.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: es1371/SB64PCI does not work behind bridge
Message-ID: <20011224001630.A13751@bigmac.e-technik.uni-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

just "found out" that my SB64/es1371 card does not work on the PCI
bus behind a DECchip 21152 on a TYAN thunder 100. The card generates
interrupts but the driver does not react because the interrupt status
it gets from the card does not trigger it.

Is there anybody else seeing this, or can comment on this? What can I
try to prove that it is a card/driver bug or find a solution?
I would exclude mainboard or BIOS problems because an SBlive in the
same slot worked flawlessly, as do all the other devices behind the
bridge.
The workaround was swapping network and sound card, as can be seen
from lspci below...

Thanks,
Wolfgang

Here is lspci -v output:
laura:~ # lspci -v
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge (rev 02)
        Flags: bus master, medium devsel, latency 64
        Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge (rev 02) (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: fc500000-fe5fffff
        Prefetchable memory behind bridge: f0200000-f42fffff

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
        Flags: bus master, medium devsel, latency 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01) (prog-if 80 [Master])
        Flags: bus master, medium devsel, latency 64
        I/O ports at ffa0 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
        Flags: bus master, medium devsel, latency 64, IRQ 19
        I/O ports at ef80 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
        Flags: medium devsel, IRQ 9

00:10.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03) (prog-if 00 [Normal decode])
        Flags: bus master, medium devsel, latency 64
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fe600000-feafffff
        Prefetchable memory behind bridge: 00000000f4300000-00000000f4300000
        Capabilities: [dc] Power Management version 1

00:12.0 SCSI storage controller: Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895 (rev 04)
        Subsystem: Adaptec AHA-2940U/2940UW Dual AHA-394xAU/AUW/AUWD AIC-7895B
        Flags: bus master, medium devsel, latency 64, IRQ 16
        I/O ports at e400 [disabled] [size=256]
        Memory at febfe000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at febe0000 [disabled] [size=64K]
        Capabilities: [dc] Power Management version 1

00:12.1 SCSI storage controller: Adaptec AHA-2940U/UW / AHA-39xx / AIC-7895 (rev 04)
        Subsystem: Adaptec AHA-2940U/2940UW Dual AHA-394xAU/AUW/AUWD AIC-7895B
        Flags: bus master, medium devsel, latency 64, IRQ 16
        I/O ports at e800 [disabled] [size=256]
        Memory at febff000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 1

00:14.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06)
        Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
        Flags: bus master, slow devsel, latency 64, IRQ 17
        I/O ports at ef00 [size=64]
        Capabilities: [dc] Power Management version 1

01:00.0 VGA compatible controller: nVidia Corporation Riva TnT2 Ultra [NV5] (rev 11) (prog-if 00 [VGA])
        Subsystem: Asustek Computer, Inc. AGP-V3800 Deluxe
        Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 16
        Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
        Memory at f2000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at fe5f0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
        Capabilities: [44] AGP version 2.0

02:04.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev 05)
        Subsystem: Intel Corporation EtherExpress PRO/100+
        Flags: bus master, medium devsel, latency 64, IRQ 16
        Memory at f43ff000 (32-bit, prefetchable) [size=4K]
        I/O ports at df80 [size=32]
        Memory at fea00000 (32-bit, non-prefetchable) [size=1M]
        Expansion ROM at fe900000 [disabled] [size=1M]
        Capabilities: [dc] Power Management version 1

02:05.0 Multimedia video controller: Zoran Corporation ZR36120 (rev 03)
        Subsystem: Teles AG: Unknown device 4721
        Flags: bus master, fast devsel, latency 64, IRQ 17
        Memory at fe8ff000 (32-bit, non-prefetchable) [size=4K]

02:06.0 Multimedia video controller: Brooktree Corporation Bt848 TV with DMA push (rev 12)
        Flags: bus master, medium devsel, latency 64, IRQ 18
        Memory at f43fe000 (32-bit, prefetchable) [size=4K]

02:07.0 FireWire (IEEE 1394): Texas Instruments OHCI Compliant FireWire Controller (rev 01) (prog-if 10 [OHCI])
        Subsystem: Texas Instruments: Unknown device 8010
        Flags: bus master, medium devsel, latency 64, IRQ 19
        Memory at fe8fe800 (32-bit, non-prefetchable) [size=2K]
        Memory at fe8f8000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 1


