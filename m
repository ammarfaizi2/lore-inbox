Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129231AbQKAWHu>; Wed, 1 Nov 2000 17:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131377AbQKAWHl>; Wed, 1 Nov 2000 17:07:41 -0500
Received: from smtp3.xs4all.nl ([194.109.127.132]:20741 "EHLO smtp3.xs4all.nl")
	by vger.kernel.org with ESMTP id <S129231AbQKAWHf>;
	Wed, 1 Nov 2000 17:07:35 -0500
Message-ID: <3A009557.135DF15E@xs4all.nl>
Date: Wed, 01 Nov 2000 23:12:39 +0100
From: Pieter van Prooijen <pprooi@xs4all.nl>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0-test6 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.4.0-test10 locks up during kernel compiles on Toshiba CDT
 	1640
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 	
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

During kernel compilation (or other heavy use of the machine), the
machine
locks up. No oops, no alt-sysreq, only a hardware reset is
possible. 

Machine is a Toshiba CDT 1640 laptop: 475 MHz K6-II+, 128KB cache, 64 MB
ram, Aladdin V chipset, 6 GB Fujitsu hd.

Observations:

The standard RedHat kernel (2.2.16) and Windows work fine, so it doesn't
seem to be a hardware problem.

When the machine locks up, the little fan begins running immediately,
which means the processor is getting very hot (doing what ?)

I've tried various settings of the IDE driver (disabling dma etc.) 
thinking it might be an ide problem, but this didn't make a difference.

"make bzImage" reliably locks up the machine after a few minutes, but
not
at same the point in the compilation.

I don't know if the problem is related, but the audio driver for the
cs4281
sometimes "stutters" during playback. 

Let me know if I need to supply more information, apply patches etc.

Many thanks,

Pieter van Prooijen.


Environment: (slightly hacked RedHat 7.0, but 6.2 had the same problems)

kernel modules         2.3.14
Gnu C                  2.91.66 ("kgcc" from RedHat 7.0)
Binutils               2.10.0.18
Linux C Library        2.1.92
Dynamic linker         ldd (GNU libc) 2.1.92
cardmgr                3.1.19

Loaded modules:

cs4281                 25608   0 (unused)
soundcore               3876   3 [cs4281]
3c589_cs                8040   1
ds                      6732   2 [3c589_cs]
// i82365 is really a symlink to yenta_socket, to keep the 2.2 pcmcia
// config happy.
i82365                  9996   4
pcmcia_core            41248   0 [3c589_cs ds i82365]
mousedev                3956   1
hid                    11872   0 (unused)
input                   3360   0 [mousedev hid]
usb-ohci               16468   0 (unused)
usbcore                47616   1 [hid usb-ohci]

PCI Devices:

00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1541 (rev 04)
	Subsystem: Acer Laboratories Inc. [ALi] ALI M1541 Aladdin V/V+ AGP
System Controller
	Flags: bus master, slow devsel, latency 32
	Memory at e0000000 (32-bit, non-prefetchable) [size=64M]
	Capabilities: [b0] AGP version 1.0

00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5243 (rev 04) (prog-if
00 [Normal decode])
	Flags: bus master, slow devsel, latency 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000e000-0000efff
	Memory behind bridge: fd000000-fecfffff

00:04.0 CardBus bridge: Texas Instruments PCI1420
	Subsystem: Toshiba America Info Systems: Unknown device ff00
	Flags: bus master, medium devsel, latency 168, IRQ 11
	Memory at 68000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=176
	Memory window 0: 10000000-103ff000 (prefetchable)
	Memory window 1: 10400000-107ff000
	I/O window 0: 00001000-000010ff
	I/O window 1: 00001400-000014ff
	16-bit legacy interface ports at 0001

00:04.1 CardBus bridge: Texas Instruments PCI1420
	Subsystem: Toshiba America Info Systems: Unknown device ff00
	Flags: bus master, medium devsel, latency 168, IRQ 11
	Memory at 68001000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=00, secondary=06, subordinate=06, sec-latency=176
	Memory window 0: 10800000-10bff000 (prefetchable)
	Memory window 1: 10c00000-10fff000
	I/O window 0: 00001800-000018ff
	I/O window 1: 00001c00-00001cff
	16-bit legacy interface ports at 0001

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge
[Aladdin IV] (rev 0a)
	Subsystem: Toshiba America Info Systems: Unknown device ff00
	Flags: bus master, medium devsel, latency 0

00:08.0 Multimedia audio controller: Cirrus Logic Crystal CS4281 PCI
Audio (rev 01)
	Subsystem: Toshiba America Info Systems: Unknown device ff00
	Flags: bus master, medium devsel, latency 64, IRQ 11
	Memory at feddf000 (32-bit, non-prefetchable) [size=4K]
	Memory at fedf0000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [40] Power Management version 2

00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev 20)
(prog-if fa)
	Subsystem: Acer Laboratories Inc. [ALi] M5229 IDE
	Flags: bus master, medium devsel, latency 32
	I/O ports at fcf0 [size=16]

00:10.0 Communication controller: Rockwell International: Unknown device
2013 (rev 01)
	Subsystem: Toshiba America Info Systems: Unknown device ff00
	Flags: medium devsel, IRQ 10
	Memory at fede0000 (32-bit, non-prefetchable) [size=64K]
	I/O ports at fce8 [size=8]
	Capabilities: [40] Power Management version 2

00:11.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU (rev 09)
	Subsystem: Toshiba America Info Systems: Unknown device ff00
	Flags: medium devsel

00:13.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03)
(prog-if 10 [OHCI])
	Flags: bus master, medium devsel, latency 64, IRQ 9
	Memory at fedde000 (32-bit, non-prefetchable) [size=4K]

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage LT Pro
AGP-133 (rev dc) (prog-if 00 [VGA])
	Subsystem: Toshiba America Info Systems: Unknown device ff00
	Flags: bus master, stepping, medium devsel, latency 66, IRQ 11
	Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
	I/O ports at e800 [size=256]
	Memory at fecff000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [50] AGP version 1.0
	Capabilities: [5c] Power Management version 1
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
