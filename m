Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261471AbTCOPlN>; Sat, 15 Mar 2003 10:41:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261472AbTCOPlN>; Sat, 15 Mar 2003 10:41:13 -0500
Received: from mail.skjellin.no ([80.239.42.67]:52646 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id <S261471AbTCOPlC>;
	Sat, 15 Mar 2003 10:41:02 -0500
Subject: problems with DFE-580TX (sundance) in 2.4.20
From: Andre Tomt <andre@tomt.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-ja2kPmA12plzzfloh1AN"
Organization: 
Message-Id: <1047743481.7202.29.camel@slurv.ws.tomt.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2- 
Date: 15 Mar 2003 16:51:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ja2kPmA12plzzfloh1AN
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I recently got hold of a D-Link DFE-580TX 4 port Server Adapter for
testing, but we're having serious issues with it. It is a card with a
Intel PCI-to-PCI bridge on it, having 4 sundance chips on their "own"
bus.

I actually got it to work pretty well on a AMD k6-2 system with VIA
chipset for the few days it was in that machine, but all other systems
have so far failed. Another VIA worked for a while, but failed after a
cold boot. Even Intel ones, both cheap "home" mainboards, and more
expensive server mainboards have otherwise failed completely. That
means, I've tested in about 5-6 machines, one working, one partly
working, the rest fails.

This is what it prints out when bailing out:
eth2: D-Link DFE-580TX 4 port Server Adapter at 0xf88f1000,
6f:ef:6f:ef:6f:ef, IRQ 12.
eth2: No MII transceiver found, aborting.  ASIC status f000ef6f
eth2: D-Link DFE-580TX 4 port Server Adapter at 0xf88f1000,
6f:ef:6f:ef:6f:ef, IRQ 10.
eth2: No MII transceiver found, aborting.  ASIC status f000ef6f
eth2: D-Link DFE-580TX 4 port Server Adapter at 0xf88f1000,
6f:ef:6f:ef:6f:ef, IRQ 11.
eth2: No MII transceiver found, aborting.  ASIC status f000ef6f
eth2: D-Link DFE-580TX 4 port Server Adapter at 0xf88f1000,
6f:ef:6f:ef:6f:ef, IRQ 11.
eth2: No MII transceiver found, aborting.  ASIC status f000ef6f

then the module unloads.

More comprehensive information is attached in a text file, to avoid
linewrapping issues. The kernelversion shown in dmesg is "almost
vanilla" - it has some bugfixes from BK applied, mostly the ext3-stuff.
The card behaves exactly the same on a pristine kernel, so I don't think
it will be a issue.

--=-ja2kPmA12plzzfloh1AN
Content-Disposition: attachment; filename=typescript.txt
Content-Type: text/plain; name=typescript.txt; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Script started on Sun Mar 16 00:28:49 2003
# lspci -v -xxx
00:00.0 Host bridge: Intel Corp. 82845G/GL [Brookdale-G] Chipset Host Bridge (rev 03)
	Subsystem: Super Micro Computer Inc: Unknown device 3680
	Flags: bus master, fast devsel, latency 0
	Memory at e8000000 (32-bit, prefetchable) [size=4M]
	Capabilities: [e4] #09 [4105]
00: 86 80 60 25 06 00 90 20 03 00 00 06 00 00 00 00
10: 08 00 00 e8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 d9 15 80 36
30: 00 00 00 00 e4 00 00 00 00 00 00 00 00 00 00 00
40: bc 05 00 00 41 20 10 20 04 01 00 00 1b 08 10 00
50: 00 00 30 00 00 00 00 01 49 43 02 00 3b 36 39 38
60: 08 10 18 20 00 00 00 00 00 00 00 00 00 00 00 00
70: 22 22 00 00 00 00 00 00 05 84 41 2b 71 81 00 20
80: 69 01 af 00 ad 00 00 00 01 00 00 00 00 00 00 00
90: 10 11 01 00 00 11 11 00 45 04 00 00 00 0a 38 00
a0: 02 00 20 00 17 02 00 1f 00 00 00 00 00 00 00 00
b0: 00 00 00 00 3f 00 00 00 00 00 00 00 10 10 00 00
c0: 44 40 30 11 00 00 0c 08 00 00 00 00 00 00 00 00
d0: 02 28 04 0e 0b 0d 00 10 00 00 11 b3 00 00 20 00
e0: 00 00 00 00 09 00 05 41 21 00 00 00 00 00 00 00
f0: 00 00 00 00 74 f8 00 00 40 0f 00 00 04 00 00 00

00:02.0 VGA compatible controller: Intel Corp. 82845G/GL [Brookdale-G] Chipset Integrated Graphics Device (rev 03) (prog-if 00 [VGA])
	Subsystem: Super Micro Computer Inc: Unknown device 3680
	Flags: bus master, fast devsel, latency 0, IRQ 11
	Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Memory at e8600000 (32-bit, non-prefetchable) [size=512K]
	Capabilities: [d0] Power Management version 1
00: 86 80 62 25 07 00 90 00 03 00 00 03 00 00 00 00
10: 08 00 00 e0 00 00 60 e8 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 d9 15 80 36
30: 00 00 00 00 d0 00 00 00 00 00 00 00 0b 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 01 00 21 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 0a 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 01) (prog-if 00 [UHCI])
	Subsystem: Super Micro Computer Inc: Unknown device 3680
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at b800 [size=32]
00: 86 80 c2 24 05 00 80 02 01 00 03 0c 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 b8 00 00 00 00 00 00 00 00 00 00 d9 15 80 36
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 2f 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 60 0f 00 00 00 00 00 00

00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 01) (prog-if 00 [UHCI])
	Subsystem: Super Micro Computer Inc: Unknown device 3680
	Flags: bus master, medium devsel, latency 0, IRQ 11
	I/O ports at b000 [size=32]
00: 86 80 c4 24 05 00 80 02 01 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 b0 00 00 00 00 00 00 00 00 00 00 d9 15 80 36
30: 00 00 00 00 00 00 00 00 00 00 00 00 0b 02 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 2f 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 60 0f 00 00 00 00 00 00

00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 01) (prog-if 00 [UHCI])
	Subsystem: Super Micro Computer Inc: Unknown device 3680
	Flags: bus master, medium devsel, latency 0, IRQ 10
	I/O ports at b400 [size=32]
00: 86 80 c7 24 05 00 80 02 01 00 03 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 b4 00 00 00 00 00 00 00 00 00 00 d9 15 80 36
30: 00 00 00 00 00 00 00 00 00 00 00 00 0a 03 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 2f 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 60 0f 00 00 00 00 00 00

00:1d.7 USB Controller: Intel Corp. 82801DB USB EHCI Controller (rev 01) (prog-if 20 [EHCI])
	Subsystem: Super Micro Computer Inc: Unknown device 3680
	Flags: bus master, medium devsel, latency 0, IRQ 5
	Memory at e8680000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
00: 86 80 cd 24 06 00 90 02 01 20 03 0c 00 00 00 00
10: 00 00 68 e8 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 d9 15 80 36
30: 00 00 00 00 50 00 00 00 00 00 00 00 05 04 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 00 c2 c9 00 00 00 00 0a 00 80 20 00 00 00 00
60: 20 20 7f 00 00 00 00 00 01 00 00 00 00 00 00 c0
70: 00 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 3f 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 78 bf 1f 00 88 83 00 00 60 0f 00 00 06 00 00 00

00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB PCI Bridge (rev 81) (prog-if 00 [Normal decode])
	Flags: bus master, fast devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=02, sec-latency=32
	I/O behind bridge: 00009000-0000afff
	Memory behind bridge: e8400000-e85fffff
00: 86 80 4e 24 07 01 80 80 81 00 04 06 00 00 01 00
10: 00 00 00 00 00 00 00 00 00 01 02 20 90 a0 80 22
20: 40 e8 50 e8 f0 ff 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 06 00
40: 02 28 20 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 02 74 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 60 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 04 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 10 00 08 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 01 00 02 00 00 00 c0 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 60 0f 00 00 00 00 56 20

00:1f.0 ISA bridge: Intel Corp. 82801DB ISA Bridge (LPC) (rev 01)
	Flags: bus master, medium devsel, latency 0
00: 86 80 c0 24 0f 00 80 02 01 00 01 06 00 00 80 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 01 04 00 00 10 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 08 00 00 00 81 04 00 00 10 00 00 00
60: 0b 0c 0a 0b d0 00 00 00 80 80 09 05 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: f5 54 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 20 02 00 00 00 00 00 00 0d 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 55 55 41 05 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 86 21 00 00 02 04 00 00 04 00 00 00 00 00 00 00
e0: 10 00 00 c0 00 00 0f 34 33 22 11 00 91 02 67 45
f0: 0f 00 60 00 00 00 00 00 60 0f 02 00 00 00 81 00

00:1f.1 IDE interface: Intel Corp. 82801DB ICH4 IDE (rev 01) (prog-if 8a [Master SecP PriP])
	Subsystem: Super Micro Computer Inc: Unknown device 3680
	Flags: bus master, medium devsel, latency 0, IRQ 10
	I/O ports at bc00 [size=8]
	I/O ports at c000 [size=4]
	I/O ports at c400 [size=8]
	I/O ports at c800 [size=4]
	I/O ports at cc00 [size=16]
	Memory at e8681000 (32-bit, non-prefetchable) [size=1K]
00: 86 80 cb 24 07 00 80 02 01 8a 01 01 00 00 00 00
10: 01 bc 00 00 01 c0 00 00 01 c4 00 00 01 c8 00 00
20: 01 cc 00 00 00 10 68 e8 00 00 00 00 d9 15 80 36
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 01 00 00
40: 07 a3 07 a3 00 00 00 00 05 00 01 02 00 00 00 00
50: 00 00 00 00 f1 14 00 00 00 00 00 00 00 00 00 00
60: 08 00 00 00 00 00 00 00 08 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 60 0f 00 00 00 00 00 00

00:1f.3 SMBus: Intel Corp. 82801DB SMBus (rev 01)
	Subsystem: Super Micro Computer Inc: Unknown device 3680
	Flags: medium devsel, IRQ 12
	I/O ports at 0500 [size=32]
00: 86 80 c3 24 01 00 80 02 01 00 05 0c 00 00 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 05 00 00 00 00 00 00 00 00 00 00 d9 15 80 36
30: 00 00 00 00 00 00 00 00 00 00 00 00 0c 02 00 00
40: 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 60 0f 00 00 00 00 00 00

01:00.0 PCI bridge: Intel Corp. 21152 PCI-to-PCI Bridge (prog-if 00 [Normal decode])
	Flags: bus master, medium devsel, latency 32
	Bus: primary=01, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: e8400000-e84fffff
	Capabilities: [dc] Power Management version 2
00: 86 80 52 b1 07 01 90 02 00 00 04 06 08 20 01 00
10: 00 00 00 00 00 00 00 00 01 02 02 20 91 91 80 22
20: 40 e8 40 e8 f1 ff 01 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 00 00 06 00
40: 00 00 00 02 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 3e 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 00 02 00
e0: 00 00 c0 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

01:05.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet Controller (rev 02)
	Subsystem: Intel Corp.: Unknown device 004e
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 9
	Memory at e8500000 (32-bit, non-prefetchable) [size=128K]
	I/O ports at a000 [size=64]
	Capabilities: [dc] Power Management version 2
	Capabilities: [e4] PCI-X non-bridge device.
	Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
00: 86 80 0e 10 07 00 30 02 02 00 00 02 08 20 00 00
10: 00 00 50 e8 00 00 00 00 01 a0 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 4e 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 09 01 ff 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 e4 22 c8
e0: 00 20 00 28 07 f0 02 00 00 00 40 04 00 00 00 00
f0: 05 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00

01:06.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet Controller (rev 02)
	Subsystem: Intel Corp.: Unknown device 004e
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 5
	Memory at e8520000 (32-bit, non-prefetchable) [size=128K]
	I/O ports at a400 [size=64]
	Capabilities: [dc] Power Management version 2
	Capabilities: [e4] PCI-X non-bridge device.
	Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
00: 86 80 0e 10 07 00 30 02 02 00 00 02 08 20 00 00
10: 00 00 52 e8 00 00 00 00 01 a4 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 4e 00
30: 00 00 00 00 dc 00 00 00 00 00 00 00 05 01 ff 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 01 e4 22 c8
e0: 00 20 00 28 07 f0 02 00 00 00 40 04 00 00 00 00
f0: 05 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00

02:04.0 Ethernet controller: D-Link System Inc DL10050 Sundance Ethernet (rev 12)
	Subsystem: D-Link System Inc DFE-580TX
	Flags: bus master, medium devsel, latency 32, IRQ 12
	I/O ports at 9000 [size=128]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [50] Power Management version 2
00: 86 11 02 10 07 00 10 02 12 00 00 02 08 20 00 00
10: 01 90 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 11 12 10
30: 00 00 00 00 50 00 00 00 00 00 00 00 0c 01 0a 0a
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 00 02 f6 00 40 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

02:05.0 Ethernet controller: D-Link System Inc DL10050 Sundance Ethernet (rev 12)
	Subsystem: D-Link System Inc DFE-580TX
	Flags: bus master, medium devsel, latency 32, IRQ 10
	I/O ports at 9400 [size=128]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [50] Power Management version 2
00: 86 11 02 10 07 00 10 02 12 00 00 02 08 20 00 00
10: 01 94 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 11 12 10
30: 00 00 00 00 50 00 00 00 00 00 00 00 0a 01 0a 0a
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 00 02 f6 00 40 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

02:06.0 Ethernet controller: D-Link System Inc DL10050 Sundance Ethernet (rev 12)
	Subsystem: D-Link System Inc DFE-580TX
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at 9800 [size=128]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [50] Power Management version 2
00: 86 11 02 10 07 00 10 02 12 00 00 02 08 20 00 00
10: 01 98 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 11 12 10
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 0a 0a
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 00 02 f6 00 40 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

02:07.0 Ethernet controller: D-Link System Inc DL10050 Sundance Ethernet (rev 12)
	Subsystem: D-Link System Inc DFE-580TX
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at 9c00 [size=128]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [50] Power Management version 2
00: 86 11 02 10 07 00 10 02 12 00 00 02 08 20 00 00
10: 01 9c 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 11 12 10
30: 00 00 00 00 50 00 00 00 00 00 00 00 0b 01 0a 0a
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 01 00 02 f6 00 40 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

# dmesg
Linux version 2.4.20-s8 (root@gentoo) (gcc version 3.2.2) #4 Sun Mar 16 00:23:23 CET 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fef0000 (usable)
 BIOS-e820: 000000003fef0000 - 000000003fef3000 (ACPI NVS)
 BIOS-e820: 000000003fef3000 - 000000003ff00000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
896MB LOWMEM available.
On node 0 totalpages: 229376
zone(0): 4096 pages.
zone(1): 225280 pages.
zone(2): 0 pages.
Kernel command line: auto BOOT_IMAGE=Gentoo ro root=301
Initializing CPU#0
Detected 2400.477 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 4784.12 BogoMIPS
Memory: 905520k/917504k available (1040k kernel code, 11600k reserved, 229k data, 232k init, 0k highmem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
CPU: L1 I cache: 0K, L1 D cache: 8K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
CPU:             Common caps: 3febfbff 00000000 00000000 00000000
CPU: Intel(R) Pentium(R) 4 CPU 2.40GHz stepping 04
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb310, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
Transparent bridge - Intel Corp. 82801BA/CA/DB PCI Bridge
PCI: Using IRQ router PIIX [8086/24c0] at 00:1f.0
PCI: Found IRQ 10 for device 00:1f.1
PCI: Sharing IRQ 10 with 00:1d.2
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Detected PS/2 Mouse Port.
pty: 512 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Software Watchdog Timer: 0.05, timer margin: 60 sec
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller on PCI bus 00 dev f9
PCI: Found IRQ 10 for device 00:1f.1
PCI: Sharing IRQ 10 with 00:1d.2
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xcc00-0xcc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xcc08-0xcc0f, BIOS settings: hdc:DMA, hdd:pio
keyboard: Timeout - AT keyboard not present?(ed)
keyboard: Timeout - AT keyboard not present?(f4)
hda: WDC WD200EB-00CPF0, ATA DISK drive
hdc: MATSHITA CR-177, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
blk: queue c029f9e4, I/O limit 4095Mb (mask 0xffffffff)
hda: 39102336 sectors (20020 MB) w/2048KiB Cache, CHS=2434/255/63, UDMA(100)
hdc: ATAPI 24X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 232k freed
Adding Swap: 996020k swap-space (priority -1)
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,1), internal journal
Real Time Clock Driver v1.10e
inserting floppy driver for 2.4.20-s8
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 4.4.12-k1
Copyright (c) 1999-2002 Intel Corporation.
PCI: Found IRQ 9 for device 01:05.0
eth0: Intel(R) PRO/1000 Network Connection
PCI: Found IRQ 5 for device 01:06.0
PCI: Sharing IRQ 5 with 00:1d.7
eth1: Intel(R) PRO/1000 Network Connection
sundance.c:v1.01+LK1.06b 6-Nov-2002  Written by Donald Becker
  http://www.scyld.com/network/sundance.html
eth2: D-Link DFE-580TX 4 port Server Adapter at 0xf88f1000, 6f:ef:6f:ef:6f:ef, IRQ 12.
eth2: No MII transceiver found, aborting.  ASIC status f000ef6f
eth2: D-Link DFE-580TX 4 port Server Adapter at 0xf88f1000, 6f:ef:6f:ef:6f:ef, IRQ 10.
eth2: No MII transceiver found, aborting.  ASIC status f000ef6f
eth2: D-Link DFE-580TX 4 port Server Adapter at 0xf88f1000, 6f:ef:6f:ef:6f:ef, IRQ 11.
eth2: No MII transceiver found, aborting.  ASIC status f000ef6f
eth2: D-Link DFE-580TX 4 port Server Adapter at 0xf88f1000, 6f:ef:6f:ef:6f:ef, IRQ 11.
eth2: No MII transceiver found, aborting.  ASIC status f000ef6f
e1000: eth0 NIC Link is Up 100 Mbps Full Duplex

# cat /proc/interrupts
           CPU0       
  0:       9785          XT-PIC  timer
  1:          2          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          2          XT-PIC  rtc
  9:        363          XT-PIC  eth0
 14:        872          XT-PIC  ide0
 15:          3          XT-PIC  ide1
NMI:          0 
ERR:          0

# cat /proc/iomem
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-3feeffff : System RAM
  00100000-0020412e : Kernel code
  0020412f-0023d5bf : Kernel data
3fef0000-3fef2fff : ACPI Non-volatile Storage
3fef3000-3fefffff : ACPI Tables
e0000000-e7ffffff : Intel Corp. 82845G/GL [Brookdale-G] Chipset Integrated Graphics Device
e8000000-e83fffff : Intel Corp. 82845G/GL [Brookdale-G] Chipset Host Bridge
e8400000-e84fffff : PCI Bus #02
e8500000-e851ffff : Intel Corp. 82540EM Gigabit Ethernet Controller
  e8500000-e851ffff : e1000
e8520000-e853ffff : Intel Corp. 82540EM Gigabit Ethernet Controller (#2)
  e8520000-e853ffff : e1000
e8600000-e867ffff : Intel Corp. 82845G/GL [Brookdale-G] Chipset Integrated Graphics Device
e8680000-e86803ff : Intel Corp. 82801DB USB EHCI Controller
e8681000-e86813ff : Intel Corp. 82801DB ICH4 IDE
fec00000-ffffffff : reserved

# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0500-051f : Intel Corp. 82801DB SMBus
0cf8-0cff : PCI conf1
9000-9fff : PCI Bus #02
  9000-907f : D-Link System Inc DL10050 Sundance Ethernet
  9400-947f : D-Link System Inc DL10050 Sundance Ethernet (#2)
  9800-987f : D-Link System Inc DL10050 Sundance Ethernet (#3)
  9c00-9c7f : D-Link System Inc DL10050 Sundance Ethernet (#4)
a000-a03f : Intel Corp. 82540EM Gigabit Ethernet Controller
  a000-a03f : e1000
a400-a43f : Intel Corp. 82540EM Gigabit Ethernet Controller (#2)
  a400-a43f : e1000
b000-b01f : Intel Corp. 82801DB USB (Hub #2)
b400-b41f : Intel Corp. 82801DB USB (Hub #3)
b800-b81f : Intel Corp. 82801DB USB (Hub #1)
bc00-bc07 : Intel Corp. 82801DB ICH4 IDE
c000-c003 : Intel Corp. 82801DB ICH4 IDE
c400-c407 : Intel Corp. 82801DB ICH4 IDE
c800-c803 : Intel Corp. 82801DB ICH4 IDE
cc00-cc0f : Intel Corp. 82801DB ICH4 IDE
  cc00-cc07 : ide0
  cc08-cc0f : ide1

# 
Script done on Sun Mar 16 00:30:32 2003

--=-ja2kPmA12plzzfloh1AN--

