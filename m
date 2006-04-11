Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbWDKXh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbWDKXh0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 19:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWDKXh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 19:37:26 -0400
Received: from mail.gmx.de ([213.165.64.20]:13795 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751358AbWDKXhZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 19:37:25 -0400
X-Authenticated: #16598666
From: Andreas Schnaiter <schnaiter@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.16 -  SATA read performance drop ~50% on Intel 82801GB/GR/GH
Date: Wed, 12 Apr 2006 01:36:28 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_81DPEOn28+7/fbt"
Message-Id: <200604120136.28681.schnaiter@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_81DPEOn28+7/fbt
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

after upgrading from linux 2.6.15.7 to 2.6.16.2 I noticed an extreme slowdown 
of the SATA disks on my system. Writing/reading a 8GB file showed that 
reading performes with less than half the speed on 2.6.16 (strangely hdparm 
shows almost no difference).
The two affected disks are connected to the Intel 82801GB/GR/GH (ICH7 Family)  
Serial ATA Controller.
Disks on the Silicon Image/Intel IDE Controllers are not affected.
I didn't have the chance yet to test if this problem also exists on the 
Silicon Image SATA Controller.

Please tell me if there is any other useful information I can provide =)


Linux 2.6.15.7
---
# time dd if=/dev/zero of=/benchfile bs=1M count=8192
8192+0 records in
8192+0 records out
8589934592 bytes (8.6 GB) copied, 132.224 seconds, 65.0 MB/s

real	2m12.347s
user	0m0.018s
sys	0m18.398s

# time dd if=/benchfile of=/dev/null bs=1M
8192+0 records in
8192+0 records out
8589934592 bytes (8.6 GB) copied, 130.547 seconds, 65.8 MB/s

real	2m10.670s
user	0m0.023s
sys	0m14.238s

# hdparm -tT /dev/sdb

/dev/sdb:
 Timing cached reads:   4488 MB in  2.00 seconds = 2244.34 MB/sec
 Timing buffered disk reads:  212 MB in  3.02 seconds =  70.30 MB/sec


Linux 2.6.16.2
---
# time dd if=/dev/zero of=/benchfile bs=1M count=8192
8192+0 records in
8192+0 records out
8589934592 bytes (8.6 GB) copied, 122.256 seconds, 70.3 MB/s

real	2m2.460s
user	0m0.013s
sys	0m17.971s

# time dd if=/benchfile of=/dev/null bs=1M
8192+0 records in
8192+0 records out
8589934592 bytes (8.6 GB) copied, 302.452 seconds, 28.4 MB/s

real	5m3.100s
user	0m0.021s
sys	0m40.521s

# hdparm -tT /dev/sdb

/dev/sdb:
 Timing cached reads:   4520 MB in  2.00 seconds = 2264.99 MB/sec
 Timing buffered disk reads:  212 MB in  3.03 seconds =  70.03 MB/sec


# lspci -v
00:00.0 Host bridge: Intel Corporation 955X Memory Controller Hub
        Subsystem: Intel Corporation: Unknown device 4b42
        Flags: bus master, fast devsel, latency 0
        Capabilities: [e0] #09 [2109]

00:01.0 PCI bridge: Intel Corporation 955X PCI Express Graphics Port (prog-if 
00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Memory behind bridge: 90000000-91ffffff
        Prefetchable memory behind bridge: 0000000080000000-000000008ff00000
        Capabilities: [88] #0d [0000]
        Capabilities: [80] Power Management version 2
        Capabilities: [90] Message Signalled Interrupts: 64bit- Queue=0/0 
Enable-
        Capabilities: [a0] #10 [0141]

00:1b.0 Class 0403: Intel Corporation 82801G (ICH7 Family) High Definition 
Audio Controller (rev 01)
        Subsystem: Intel Corporation: Unknown device 0013
        Flags: bus master, fast devsel, latency 0, IRQ 19
        Memory at 92200000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+ Queue=0/0 
Enable-
        Capabilities: [70] #10 [0091]

00:1c.0 PCI bridge: Intel Corporation 82801G (ICH7 Family) PCI Express Port 1 
(rev 01) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        Memory behind bridge: 92300000-923fffff
        Capabilities: [40] #10 [0141]
        Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 
Enable-
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2

00:1c.4 PCI bridge: Intel Corporation 82801GR/GH/GHM (ICH7 Family) PCI Express 
Port 5 (rev 01) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
        Memory behind bridge: 92400000-924fffff
        Capabilities: [40] #10 [0141]
        Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 
Enable-
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2

00:1c.5 PCI bridge: Intel Corporation 82801GR/GH/GHM (ICH7 Family) PCI Express 
Port 6 (rev 01) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=04, subordinate=04, sec-latency=0
        I/O behind bridge: 00002000-00002fff
        Memory behind bridge: 92100000-921fffff
        Capabilities: [40] #10 [0141]
        Capabilities: [80] Message Signalled Interrupts: 64bit- Queue=0/0 
Enable-
        Capabilities: [90] #0d [0000]
        Capabilities: [a0] Power Management version 2

00:1d.0 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #1 
(rev 01) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation: Unknown device 4b42
        Flags: bus master, medium devsel, latency 0, IRQ 21
        I/O ports at 3080 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #2 
(rev 01) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation: Unknown device 4b42
        Flags: bus master, medium devsel, latency 0, IRQ 20
        I/O ports at 3060 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #3 
(rev 01) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation: Unknown device 4b42
        Flags: bus master, medium devsel, latency 0, IRQ 18
        I/O ports at 3040 [size=32]

00:1d.3 USB Controller: Intel Corporation 82801G (ICH7 Family) USB UHCI #4 
(rev 01) (prog-if 00 [UHCI])
        Subsystem: Intel Corporation: Unknown device 4b42
        Flags: bus master, medium devsel, latency 0, IRQ 16
        I/O ports at 3020 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801G (ICH7 Family) USB2 EHCI 
Controller (rev 01) (prog-if 20 [EHCI])
        Subsystem: Intel Corporation: Unknown device 4b42
        Flags: bus master, medium devsel, latency 0, IRQ 21
        Memory at 92204400 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] #0a [20a0]

00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev e1) (prog-if 01 
[Subtractive decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=05, subordinate=05, sec-latency=32
        I/O behind bridge: 00001000-00001fff
        Memory behind bridge: 92000000-920fffff
        Prefetchable memory behind bridge: 0000000092500000-0000000092500000
        Capabilities: [50] #0d [0000]

00:1f.0 ISA bridge: Intel Corporation 82801GB/GR (ICH7 Family) LPC Interface 
Bridge (rev 01)
        Subsystem: Intel Corporation: Unknown device 4b42
        Flags: bus master, medium devsel, latency 0
        Capabilities: [e0] #09 [100c]

00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE Controller 
(rev 01) (prog-if 8a [Master SecP PriP])
        Subsystem: Intel Corporation: Unknown device 4b42
        Flags: bus master, medium devsel, latency 0, IRQ 18
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at 30b0 [size=16]

00:1f.2 IDE interface: Intel Corporation 82801GB/GR/GH (ICH7 Family) Serial 
ATA Storage Controllers cc=IDE (rev 01) (prog-if 8f [Master SecP SecO PriP 
PriO])
        Subsystem: Intel Corporation: Unknown device 4b42
        Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 20
        I/O ports at 30c8 [size=8]
        I/O ports at 30e4 [size=4]
        I/O ports at 30c0 [size=8]
        I/O ports at 30e0 [size=4]
        I/O ports at 30a0 [size=16]
        Memory at 92204000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [70] Power Management version 2

00:1f.3 SMBus: Intel Corporation 82801G (ICH7 Family) SMBus Controller (rev 
01)
        Subsystem: Intel Corporation: Unknown device 4b42
        Flags: medium devsel, IRQ 9
        I/O ports at 3000 [size=32]

01:00.0 VGA compatible controller: nVidia Corporation GeForce 6200 
TurboCache(TM) (rev a1) (prog-if 00 [VGA])
        Subsystem: nVidia Corporation: Unknown device 025d
        Flags: bus master, fast devsel, latency 0, IRQ 16
        Memory at 91000000 (32-bit, non-prefetchable) [size=16M]
        Memory at 80000000 (64-bit, prefetchable) [size=256M]
        Memory at 90000000 (64-bit, non-prefetchable) [size=16M]
        Capabilities: [60] Power Management version 2
        Capabilities: [68] Message Signalled Interrupts: 64bit+ Queue=0/0 
Enable-
        Capabilities: [78] #10 [0001]

04:00.0 Ethernet controller: Intel Corporation 82573V Gigabit Ethernet 
Controller (Copper) (rev 03)
        Subsystem: Intel Corporation: Unknown device 3083
        Flags: bus master, fast devsel, latency 0, IRQ 17
        Memory at 92100000 (32-bit, non-prefetchable) [size=128K]
        I/O ports at 2000 [size=32]
        Capabilities: [c8] Power Management version 2
        Capabilities: [d0] Message Signalled Interrupts: 64bit+ Queue=0/0 
Enable-
        Capabilities: [e0] #10 [0001]

05:00.0 Multimedia audio controller: Creative Labs SB Audigy (rev 04)
        Subsystem: Creative Labs SB Audigy 2 ZS (SB0350)
        Flags: bus master, medium devsel, latency 32, IRQ 22
        I/O ports at 1100 [size=64]
        Capabilities: [dc] Power Management version 2

05:00.1 Input device controller: Creative Labs SB Audigy MIDI/Game port (rev 
04)
        Subsystem: Creative Labs SB Audigy MIDI/Game Port
        Flags: bus master, medium devsel, latency 32
        I/O ports at 1180 [size=8]
        Capabilities: [dc] Power Management version 2

05:00.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port (rev 04) 
(prog-if 10 [OHCI])
        Subsystem: Creative Labs SB Audigy FireWire Port
        Flags: bus master, medium devsel, latency 32, IRQ 19
        Memory at 92008800 (32-bit, non-prefetchable) [size=2K]
        Memory at 92004000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2

05:01.0 RAID bus controller: Silicon Image, Inc. PCI0680 Ultra ATA-133 Host 
Controller (rev 02)
        Subsystem: Silicon Image, Inc. Winic W-680 (Silicon Image 680 based)
        Flags: bus master, medium devsel, latency 32, IRQ 19
        I/O ports at 1178 [size=8]
        I/O ports at 1194 [size=4]
        I/O ports at 1170 [size=8]
        I/O ports at 1190 [size=4]
        I/O ports at 1150 [size=16]
        Memory at 92009500 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at fff80000 [disabled] [size=512K]
        Capabilities: [60] Power Management version 2

05:02.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Flags: bus master, medium devsel, latency 32, IRQ 18
        I/O ports at 1000 [size=256]
        Memory at 92009400 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at 92580000 [disabled] [size=64K]
        Capabilities: [50] Power Management version 2

05:04.0 FireWire (IEEE 1394): Texas Instruments TSB82AA2 IEEE-1394b Link Layer 
Controller (rev 01) (prog-if 10 [OHCI])
        Subsystem: Intel Corporation: Unknown device 4b42
        Flags: bus master, medium devsel, latency 32, IRQ 18
        Memory at 92008000 (32-bit, non-prefetchable) [size=2K]
        Memory at 92000000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2

05:05.0 RAID bus controller: Silicon Image, Inc. SiI 3114 [SATALink/SATARaid] 
Serial ATA Controller (rev 02)
        Subsystem: Intel Corporation: Unknown device 7114
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 17
        I/O ports at 1168 [size=8]
        I/O ports at 118c [size=4]
        I/O ports at 1160 [size=8]
        I/O ports at 1188 [size=4]
        I/O ports at 1140 [size=16]
        Memory at 92009000 (32-bit, non-prefetchable) [size=1K]
        Expansion ROM at 92500000 [disabled] [size=512K]
        Capabilities: [60] Power Management version 2


---
regards,
Andreas

--Boundary-00=_81DPEOn28+7/fbt
Content-Type: application/x-gzip;
  name="config-2.6.15.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="config-2.6.15.gz"

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
9WB/bwOw70rwnW71CPH/A8xFnvfCpwAA

--Boundary-00=_81DPEOn28+7/fbt
Content-Type: application/x-gzip;
  name="config-2.6.16.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="config-2.6.16.gz"

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

--Boundary-00=_81DPEOn28+7/fbt--
