Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbTI3Q6a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 12:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbTI3Q6a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 12:58:30 -0400
Received: from mail.convergence.de ([212.84.236.4]:51119 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261605AbTI3Q61
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 12:58:27 -0400
Message-ID: <3F79B630.8070308@convergence.de>
Date: Tue, 30 Sep 2003 18:58:24 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.4) Gecko/20030715
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: IDE I/O disturbes other PCI busmasters on VIA platforms
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I'm currently playing with on of those neat VIA Epia based x86 platforms.

One problem that annoyed my on other VIA based systems before is that 
IDE I/O disturbes other PCI busmasters.

I did my latest tests with 2.4.22-ac2 and ide dma enabled for both the 
hdd and the dvd drive.

The effect is visible when you use a TV card with busmastering 
capabilities (simple saa7146 based tv card) and use the overlay facility 
of "xawtv" for example. As you all know, the tv picture is written 
directly to the framebuffer with busmaster dma.

If you start "updatedb" now, for example, you'll notice heavy pixel 
dropouts in the frame. They're "best" visible if there's look of motion 
in the picture.

If you disable dma, you'll notice frozen pictures, which will last up to 
several seconds.

I tried the following
- use latest 2.4 kernel
- set latencies for the different PCI devices with "setpci"
- play with burst and threshold settings of the saa7146 busmaster

Unfortunately, non of these things really helped. I was able to make 
things worse (by setting latencies very low or by lowering the burst 
size of the transfers), but I did not get rid of the problem.

Does anyone know a solution for this problem? Any help is appreciated.

Below I attached the lspci output of the box.

CU
Michael.

lspciroot@micro:~# lspci -v
00:00.0 Host bridge: VIA Technologies, Inc. VT8623 [Apollo CLE266]
         Subsystem: VIA Technologies, Inc.: Unknown device aa01
         Flags: bus master, 66Mhz, medium devsel, latency 8
         Memory at d0000000 (32-bit, prefetchable) [size=128M]
         Capabilities: [a0] AGP version 2.0
         Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP] 
(prog-if 00 [Normal decode])
         Flags: bus master, 66Mhz, medium devsel, latency 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         Memory behind bridge: dc000000-ddffffff
         Prefetchable memory behind bridge: d8000000-dbffffff
         Capabilities: [80] Power Management version 2

00:0d.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host 
Controller (rev 80) (prog-if 10 [OHCI])
         Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
         Flags: bus master, medium devsel, latency 32, IRQ 12
         Memory at de000000 (32-bit, non-prefetchable) [size=2K]
         I/O ports at d000 [size=128]
         Capabilities: [50] Power Management version 2

00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 
[UHCI])
         Subsystem: VIA Technologies, Inc. USB
         Flags: bus master, medium devsel, latency 32, IRQ 11
         I/O ports at d400 [size=32]
         Capabilities: [80] Power Management version 2

00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 
[UHCI])
         Subsystem: VIA Technologies, Inc. USB
         Flags: bus master, medium devsel, latency 32, IRQ 12
         I/O ports at d800 [size=32]
         Capabilities: [80] Power Management version 2

00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 
[UHCI])
         Subsystem: VIA Technologies, Inc. USB
         Flags: bus master, medium devsel, latency 32, IRQ 10
         I/O ports at dc00 [size=32]
         Capabilities: [80] Power Management version 2

00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 
20 [EHCI])
         Subsystem: VIA Technologies, Inc. USB 2.0
         Flags: bus master, medium devsel, latency 32, IRQ 5
         Memory at de001000 (32-bit, non-prefetchable) [size=256]
         Capabilities: [80] Power Management version 2

00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
         Subsystem: VIA Technologies, Inc.: Unknown device aa01
         Flags: bus master, stepping, medium devsel, latency 0
         Capabilities: [c0] Power Management vesion 2

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97 
Audio Controller (rev 50)
         Subsystem: VIA Technologies, Inc.: Unknown device aa01
         Flags: medium devsel, IRQ 10
         I/O ports at e400 [size=256]
         Capabilities: [c0] Power Management version 2

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] 
(rev 74)
         Subsystem: VIA Technologies, Inc. VT6102 [Rhine II] Embeded 
Ethernet Controller on VT8235
         Flags: bus master, medium devsel, latency 32, IRQ 11
         I/O ports at ec00 [size=256]
         Memory at de002000 (32-bit, non-prefetchable) [size=256]
         Capabilities: [40] Power Management version 2

00:14.0 Multimedia controller: Philips Semiconductors SAA7146 (rev 01)
         Subsystem: Technotrend Systemtechnik GmbH: Unknown device 0003
         Flags: bus master, medium devsel, latency 32, IRQ 12
         Memory at de003000 (32-bit, non-prefetchable) [size=512]

01:00.0 VGA compatible controller: VIA Technologies, Inc. VT8623 [Apollo 
CLE266] integrated CastleRock graphics (rev 03) (prog-if 00 [VGA])
         Subsystem: VIA Technologies, Inc. VT8623 [Apollo CLE266] 
integrated CastleRock graphics
         Flags: bus master, medium devsel, latency 32, IRQ 11
         Memory at d8000000 (32-bit, prefetchable) [size=64M]
         Memory at dc000000 (32-bit, non-prefetchable) [size=16M]
         Expansion ROM at <unassigned> [disabled] [size=64K]
         Capabilities: [60] Power Management version 2
         Capabilities: [70] AGP version 2.0

