Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbVH3EDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbVH3EDl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 00:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbVH3EDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 00:03:41 -0400
Received: from relay02.pair.com ([209.68.5.16]:9478 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S1751132AbVH3EDl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 00:03:41 -0400
X-pair-Authenticated: 67.187.99.138
From: Chase Venters <chase.venters@clientec.com>
To: linux-kernel@vger.kernel.org
Subject: Second "CPU" of 1-core HyperThreading CPU not found in 2.6.13
Date: Mon, 29 Aug 2005 23:03:52 -0500
User-Agent: KMail/1.8.1
Organization: Clientec, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508292303.52735.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings kind hackers...
	I recently switched to 2.6.13 on my desktop. I noticed that the second 
"CPU" (is there a better term to use in this HyperThreading scenario?) that 
used to be listed in /proc/cpuinfo is no longer present. Browsing over the 
archives, it appears as if someone else had this problem... their solution 
was to enable CONFIG_PM, but I already have CONFIG_PM enabled.
	I have to boot with 'noapic' because I have my CD-Writer hanging off an 
aic7xxx, and that driver goes into a nice error loop if I boot without it. 
	I'll include some lspci output below in case it is useful. There's one more 
thing I noticed in the transition to 2.6.13, but I'm really not sure where I 
could start diagnosing it, and so any suggestions would be marvelous. 
	As I mentioned, this machine is my desktop. In the past, I've been able to 
run compilers / other intensive tasks while listening to music in XMMS - the 
playback is never disrupted (indeed, on this P4 3.2ghz XMMS takes virtually 
none of the processor). Yet I've noticed enough momentary stops in sound 
output now to begin to suspect I've got some kind of problem. 
	Last kernels that were functional in both regards were 2.6.12.4 and 2.6.11.7. 
Please note that I have not compiled with the new default tick rate of 250Hz 
- I'm running 1000Hz, and I have also enabled the Preemptible kernel and BKL 
Preemption as I have in earlier kernels.

turbotaz linux-2.6.13 # lspci -v
0000:00:00.0 Host bridge: Intel Corporation 915G/P/GV/GL/PL/910GL Processor to 
I/O Controller (rev 04)
        Subsystem: Intel Corporation 915G/P/GV/GL/PL/910GL Processor to I/O 
Controller
        Flags: bus master, fast devsel, latency 0
        Capabilities: [e0] #09 [2109]

0000:00:01.0 PCI bridge: Intel Corporation 915G/P/GV/GL/PL/910GL PCI Express 
Root Port (rev 04) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
        I/O behind bridge: 0000e000-0000efff
        Memory behind bridge: cdf00000-cfffffff
        Prefetchable memory behind bridge: d0000000-dfffffff
        Expansion ROM at 0000e000 [disabled] [size=4K]
        Capabilities: [88] #0d [0000]
        Capabilities: [80] Power Management version 2
        Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0 
Enable+
        Capabilities: [a0] #10 [0141]

0000:00:1b.0 Class 0403: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
High Definition Audio Controller (rev 03)
        Subsystem: ASUSTeK Computer Inc.: Unknown device 813d
        Flags: bus master, fast devsel, latency 0, IRQ 10
        Memory at cdbf4000 (64-bit, non-prefetchable)
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 
Enable-
        Capabilities: [70] #10 [0091]

0000:00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
PCI Express Port 1 (rev 03) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
        I/O behind bridge: 0000d000-0000dfff
        Expansion ROM at 0000d000 [disabled] [size=4K]
        Capabilities: [40] #10 [0141]
        Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 
Enable+
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2

0000:00:1c.1 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
PCI Express Port 2 (rev 03) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 0000c000-0000cfff
        Memory behind bridge: cde00000-cdefffff
        Prefetchable memory behind bridge: 0000000040000000-0000000040000000
        Expansion ROM at 0000c000 [disabled] [size=4K]
        Capabilities: [40] #10 [0141]
        Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 
Enable+
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2

0000:00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB UHCI #1 (rev 03) (prog-if 00 [UHCI])
        Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
        Flags: bus master, medium devsel, latency 0, IRQ 11
        I/O ports at 9880 [size=32]

0000:00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB UHCI #2 (rev 03) (prog-if 00 [UHCI])
        Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
        Flags: bus master, medium devsel, latency 0, IRQ 3
        I/O ports at 9c00 [size=32]

0000:00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB UHCI #3 (rev 03) (prog-if 00 [UHCI])
        Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
        Flags: bus master, medium devsel, latency 0, IRQ 5
        I/O ports at a000 [size=32]

0000:00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB UHCI #4 (rev 03) (prog-if 00 [UHCI])
        Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
        Flags: bus master, medium devsel, latency 0, IRQ 10
        I/O ports at a080 [size=32]

0000:00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) USB2 EHCI Controller (rev 03) (prog-if 20 [EHCI])
        Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
        Flags: bus master, medium devsel, latency 0, IRQ 11
        Memory at cdbff800 (32-bit, non-prefetchable)
        Capabilities: [50] Power Management version 2
        Capabilities: [58] #0a [20a0]

0000:00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev d3) (prog-if 
01 [Subtractive decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000b000-0000bfff
        Memory behind bridge: cdc00000-cddfffff
        Prefetchable memory behind bridge: 0000000040100000-0000000040100000
        Expansion ROM at 0000b000 [disabled] [size=4K]
        Capabilities: [50] #0d [0000]

0000:00:1f.0 ISA bridge: Intel Corporation 82801FB/FR (ICH6/ICH6R) LPC 
Interface Bridge (rev 03)
        Flags: bus master, medium devsel, latency 0

0000:00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 
Family) IDE Controller (rev 03) (prog-if 8a [Master SecP PriP])
        Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
        Flags: bus master, medium devsel, latency 0, IRQ 5
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at ffa0 [size=16]

0000:00:1f.2 IDE interface: Intel Corporation 82801FR/FRW (ICH6R/ICH6RW) SATA 
Controller (rev 03) (prog-if 8f [Master SecP SecO PriP PriO])
        Subsystem: ASUSTeK Computer Inc.: Unknown device 2601
        Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 3
        I/O ports at ac00
        I/O ports at a880 [size=4]
        I/O ports at a800 [size=8]
        I/O ports at a480 [size=4]
        I/O ports at a400 [size=16]
        Memory at cdbffc00 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [70] Power Management version 2

0000:00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
SMBus Controller (rev 03)
        Subsystem: ASUSTeK Computer Inc.: Unknown device 80a6
        Flags: medium devsel
        I/O ports at 0400 [size=32]

0000:01:03.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A 
IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
        Subsystem: ASUSTeK Computer Inc.: Unknown device 808b
        Flags: bus master, medium devsel, latency 64, IRQ 7
        Memory at cddfe800 (32-bit, non-prefetchable)
        Memory at cddf8000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2

0000:01:04.0 Unknown mass storage controller: Integrated Technology Express, 
Inc. IT/ITE8212 Dual channel ATA RAID controller (PCI version seems to be 
IT8212, embedded seems (rev 13)
        Subsystem: ASUSTeK Computer Inc.: Unknown device 813a
        Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 11
        I/O ports at bc00 [size=1025M]
        I/O ports at b480 [size=4]
        I/O ports at b400 [size=8]
        I/O ports at b080 [size=4]
        I/O ports at b000 [size=16]
        Expansion ROM at 00020000 [disabled]
        Capabilities: [80] Power Management version 2

0000:01:09.0 Multimedia controller: Sigma Designs, Inc. REALmagic Hollywood 
Plus DVD Decoder (rev 02)
        Flags: bus master, medium devsel, latency 64, IRQ 4
        Memory at cdc00000 (32-bit, non-prefetchable)
        Capabilities: [40] Power Management version 1

0000:01:0a.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)
        Subsystem: Adaptec AHA-2904/Integrated AIC-7850
        Flags: bus master, medium devsel, latency 64, IRQ 7
        I/O ports at b800 [disabled] [size=1025M]
        Memory at cddff000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at 00010000 [disabled]
        Capabilities: [dc] Power Management version 1

0000:02:00.0 Ethernet controller: Marvell Technology Group Ltd. Gigabit 
Ethernet Controller (rev 15)
        Subsystem: ASUSTeK Computer Inc. Marvell 88E8053 Gigabit Ethernet 
Controller (Asus)
        Flags: bus master, fast devsel, latency 0, IRQ 4
        Memory at cdefc000 (64-bit, non-prefetchable) [size=1024M]
        I/O ports at c800 [size=256]
        Expansion ROM at 00020000 [disabled]
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Vital Product Data
        Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/1 
Enable-
        Capabilities: [e0] #10 [0011]

0000:04:00.0 VGA compatible controller: nVidia Corporation NV40 [GeForce 6800 
Ultra/GeForce 6800 GT] (rev a2) (prog-if 00 [VGA])
        Subsystem: XFX Pine Group Inc. GEFORCE 6800 GT PCI-E
        Flags: bus master, fast devsel, latency 0, IRQ 10
        Memory at cf000000 (32-bit, non-prefetchable) [size=cdf00000]
        Memory at d0000000 (32-bit, prefetchable) [size=256M]
        Memory at ce000000 (32-bit, non-prefetchable) [size=16M]
        Expansion ROM at 00020000 [disabled]
        Capabilities: [60] Power Management version 2
        Capabilities: [68] Message Signalled Interrupts: 64bit+ Queue=0/0 
Enable-
        Capabilities: [78] #10 [0011]


Thanks,
Chase Venters
