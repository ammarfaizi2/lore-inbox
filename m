Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbWIXOcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWIXOcZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 10:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbWIXOcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 10:32:25 -0400
Received: from smtprelay05.ispgateway.de ([80.67.18.43]:62148 "EHLO
	smtprelay05.ispgateway.de") by vger.kernel.org with ESMTP
	id S1750952AbWIXOcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 10:32:25 -0400
From: Matthias Dahl <mlkernel@mortal-soul.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: Re: sluggish system responsiveness under higher IO load
Date: Sun, 24 Sep 2006 16:32:11 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
References: <200608061200.37701.mlkernel@mortal-soul.de> <200609031315.04308.mlkernel@mortal-soul.de> <20060915181709.GA15333@kernel.dk>
In-Reply-To: <20060915181709.GA15333@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609241632.11126.mlkernel@mortal-soul.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 September 2006 20:17, Jens Axboe wrote:

> Sounds like a hardware issue, someone could be hogging the bus. You
> could try and play with the pci latency setting.

Is there a way I can debug this...? I really would like to get to the bottom 
of this somehow. I did one more test: installed and started enemy territory 
because it's free and heavily uses OpenGL... works fine so far. But simply 
starting an untar process in the background while et is running causes quite 
distorted sound and even the mouse pointer won't react in time anymore until 
the untar process is finished. This can't be right. IO load shouldn't cause 
sluggish responsiveness...

What bus are you referring to? As far as I remember only one or two devices 
are connected through the PCI bus... all the rest uses point to point 
connections. (PCI Express)

lspci -v shows the following: (most of the devices have a latency of 0)

00:00.0 Memory controller: nVidia Corporation CK804 Memory Controller (rev a3)
	Subsystem: Giga-byte Technology GA-K8N Ultra-9 Mainboard
	Flags: bus master, 66MHz, fast devsel, latency 0
	Capabilities: [44] HyperTransport: Slave or Primary Interface
	Capabilities: [e0] HyperTransport: MSI Mapping

00:01.0 ISA bridge: nVidia Corporation CK804 ISA Bridge (rev a3)
	Subsystem: Giga-byte Technology GA-K8N Ultra-9 Mainboard
	Flags: bus master, 66MHz, fast devsel, latency 0

00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
	Subsystem: Giga-byte Technology GA-K8N Ultra-9 Mainboard
	Flags: 66MHz, fast devsel, IRQ 12
	I/O ports at ec00 [size=32]
	I/O ports at 1c00 [size=64]
	I/O ports at 1c40 [size=64]
	Capabilities: [44] Power Management version 2

00:02.0 USB Controller: nVidia Corporation CK804 USB Controller (rev a2) 
(prog-if 10 [OHCI])
	Subsystem: Giga-byte Technology GA-K8N Ultra-9 Mainboard
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 217
	Memory at f2101000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2

00:02.1 USB Controller: nVidia Corporation CK804 USB Controller (rev a3) 
(prog-if 20 [EHCI])
	Subsystem: Giga-byte Technology GA-K8N Ultra-9 Mainboard
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 50
	Memory at feb00000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [44] Debug port
	Capabilities: [80] Power Management version 2

00:04.0 Multimedia audio controller: nVidia Corporation CK804 AC'97 Audio 
Controller (rev a2)
	Subsystem: Giga-byte Technology Unknown device ae01
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 225
	I/O ports at b800 [size=256]
	I/O ports at bc00 [size=256]
	Memory at f2104000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2

00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f2) (prog-if 8a 
[Master SecP PriP])
	Subsystem: Giga-byte Technology GA-K8N Ultra-9 Mainboard
	Flags: bus master, 66MHz, fast devsel, latency 0
	I/O ports at f000 [size=16]
	Capabilities: [44] Power Management version 2

00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev f3) 
(prog-if 85 [Master SecO PriO])
	Subsystem: Giga-byte Technology GA-K8N Ultra-9 Mainboard
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 225
	I/O ports at 09f0 [size=8]
	I/O ports at 0bf0 [size=4]
	I/O ports at 0970 [size=8]
	I/O ports at 0b70 [size=4]
	I/O ports at d000 [size=16]
	Memory at f2105000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2

00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev f3) 
(prog-if 85 [Master SecO PriO])
	Subsystem: Giga-byte Technology GA-K8N Ultra-9 Mainboard
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 233
	I/O ports at 09e0 [size=8]
	I/O ports at 0be0 [size=4]
	I/O ports at 0960 [size=8]
	I/O ports at 0b60 [size=4]
	I/O ports at e400 [size=16]
	Memory at f2100000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [44] Power Management version 2

00:09.0 PCI bridge: nVidia Corporation CK804 PCI Bridge (rev a2) (prog-if 01 
[Subtractive decode])
	Flags: bus master, 66MHz, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	Memory behind bridge: f2000000-f20fffff

00:0a.0 Bridge: nVidia Corporation CK804 Ethernet Controller (rev a3)
	Subsystem: Giga-byte Technology GA-K8N Ultra-9 Mainboard
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 217
	Memory at f2102000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at e800 [size=8]
	Capabilities: [44] Power Management version 2

00:0b.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3) (prog-if 00 
[Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	I/O behind bridge: 0000a000-0000afff
	Memory behind bridge: f0000000-f1ffffff
	Prefetchable memory behind bridge: 0000000050000000-0000000050000000
	Capabilities: [40] Power Management version 2
	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable+
	Capabilities: [58] HyperTransport: MSI Mapping
	Capabilities: [80] Express Root Port (Slot+) IRQ 0
	Capabilities: [100] Virtual Channel

00:0c.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3) (prog-if 00 
[Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 00009000-00009fff
	Capabilities: [40] Power Management version 2
	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable+
	Capabilities: [58] HyperTransport: MSI Mapping
	Capabilities: [80] Express Root Port (Slot+) IRQ 0
	Capabilities: [100] Virtual Channel

00:0d.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3) (prog-if 00 
[Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
	I/O behind bridge: 00008000-00008fff
	Capabilities: [40] Power Management version 2
	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable+
	Capabilities: [58] HyperTransport: MSI Mapping
	Capabilities: [80] Express Root Port (Slot+) IRQ 0
	Capabilities: [100] Virtual Channel

00:0e.0 PCI bridge: nVidia Corporation CK804 PCIE Bridge (rev a3) (prog-if 00 
[Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=05, subordinate=05, sec-latency=0
	Memory behind bridge: e8000000-efffffff
	Prefetchable memory behind bridge: 00000000e0000000-00000000e7f00000
	Capabilities: [40] Power Management version 2
	Capabilities: [48] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable+
	Capabilities: [58] HyperTransport: MSI Mapping
	Capabilities: [80] Express Root Port (Slot+) IRQ 0
	Capabilities: [100] Virtual Channel

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
HyperTransport Technology Configuration
	Flags: fast devsel
	Capabilities: [80] HyperTransport: Host or Secondary Interface

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Address Map
	Flags: fast devsel

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] DRAM 
Controller
	Flags: fast devsel

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
Miscellaneous Control
	Flags: fast devsel

01:07.0 Multimedia controller: Philips Semiconductors SAA7134/SAA7135HL Video 
Broadcast Decoder (rev 01)
	Subsystem: TERRATEC Electronic GmbH Terratec Cinergy 400 TV
	Flags: bus master, medium devsel, latency 32, IRQ 58
	Memory at f2005000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [40] Power Management version 1

01:0a.0 FireWire (IEEE 1394): Texas Instruments TSB82AA2 IEEE-1394b Link Layer 
Controller (rev 01) (prog-if 10 [OHCI])
	Subsystem: Giga-byte Technology GA-K8N Ultra-9 Mainboard
	Flags: bus master, medium devsel, latency 32, IRQ 7
	Memory at f2004000 (32-bit, non-prefetchable) [size=2K]
	Memory at f2000000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2

02:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8053 PCI-E 
Gigabit Ethernet Controller (rev 19)
	Subsystem: Giga-byte Technology Marvell 88E8053 Gigabit Ethernet Controller 
(Gigabyte)
	Flags: bus master, fast devsel, latency 0, IRQ 5
	Memory at f1000000 (64-bit, non-prefetchable) [size=16K]
	I/O ports at a000 [size=256]
	[virtual] Expansion ROM at 50000000 [disabled] [size=128K]
	Capabilities: [48] Power Management version 2
	Capabilities: [50] Vital Product Data
	Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable-
	Capabilities: [e0] Express Legacy Endpoint IRQ 0
	Capabilities: [100] Advanced Error Reporting

05:00.0 VGA compatible controller: nVidia Corporation NV43 [GeForce 6600 GT] 
(rev a2) (prog-if 00 [VGA])
	Subsystem: LeadTek Research Inc. Unknown device 2009
	Flags: bus master, fast devsel, latency 0, IRQ 66
	Memory at e8000000 (32-bit, non-prefetchable) [size=64M]
	Memory at e0000000 (64-bit, prefetchable) [size=128M]
	Memory at ec000000 (64-bit, non-prefetchable) [size=16M]
	[virtual] Expansion ROM at ed000000 [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
	Capabilities: [68] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
	Capabilities: [78] Express Endpoint IRQ 0
	Capabilities: [100] Virtual Channel
	Capabilities: [128] Power Budgeting

Best regards,
Matthias Dahl
