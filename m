Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965012AbVKOT0p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965012AbVKOT0p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 14:26:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965013AbVKOT0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 14:26:44 -0500
Received: from 0x3e42fe9a.adsl.cybercity.dk ([62.66.254.154]:18149 "EHLO
	fw.fugmann.net") by vger.kernel.org with ESMTP id S965012AbVKOT0o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 14:26:44 -0500
Message-ID: <437A3672.9000002@fugmann.net>
Date: Tue, 15 Nov 2005 20:26:42 +0100
From: Anders Peter Fugmann <afu@fugmann.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: forcedeth probems using linux 2.6.15-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The forcedeth driver occasionally hangs, sometimes after several hours,
sometimes after just a few minutes of traffic. Hardware is a Nvidia NForce3 motherboard with onboard LAN
(Linux compiled for 64 bit, using gcc 4.0.3 prerelease). Removing and inserting resolves to problem for
a short period of time. The driver works without complaints on Linux 2.6.14.

The following is being printed to the kernel logs repeatably:

Nov 14 22:12:32 gw kernel: NETDEV WATCHDOG: eth1: transmit timed out
Nov 14 22:12:32 gw kernel: eth1: Got tx_timeout. irq: 00000000
Nov 14 22:12:32 gw kernel: eth1: Ring at 1ee38000: next 271242 nic 271178
Nov 14 22:12:32 gw kernel: eth1: Dumping tx registers
Nov 14 22:12:32 gw kernel:   0: 00000200 000000ff 00000003 012b03ca 00000040 00000000 00000000 00000000
Nov 14 22:12:32 gw kernel:  20: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Nov 14 22:12:32 gw kernel:  40: 0420e20e 00000855 00000000 00000000 00000000 00000000 00000000 00000000
Nov 14 22:12:32 gw kernel:  60: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Nov 14 22:12:32 gw kernel:  80: 003b0f3c 00000001 00040000 007f0028 0000061c 00000001 00000000 00002d3f
Nov 14 22:12:32 gw kernel:  a0: 0016070f 00000016 69d81100 00000b48 00000001 00000000 9600cccd 0000f4b7
Nov 14 22:12:32 gw kernel:  c0: 10000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001
Nov 14 22:12:32 gw kernel:  e0: 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001
Nov 14 22:12:32 gw kernel: 100: 1ee38400 1ee38000 007f003f 00000000 00010064 00000000 0000003e 1ee38440
Nov 14 22:12:32 gw kernel: 120: 1ee38380 1eb093c0 a00002e7 1eb13810 8000061c 1ee38454 1ee38304 00200010
Nov 14 22:12:32 gw kernel: 140: 003041c0 00002500 00000000 00000000 00000000 00000000 00000000 00000000
Nov 14 22:12:32 gw kernel: 160: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Nov 14 22:12:32 gw kernel: 180: 00000016 00000008 0194796d 00008103 00000025 000045e1 0194796d 0000c5e3
Nov 14 22:12:32 gw kernel: 1a0: 00000016 00000008 0194796d 00008103 00000025 000045e1 0194796d 0000c5e3
Nov 14 22:12:32 gw kernel: 1c0: 00000016 00000008 0194796d 00008103 00000025 000045e1 0194796d 0000c5e3
Nov 14 22:12:32 gw kernel: 1e0: 00000016 00000008 0194796d 00008103 00000025 000045e1 0194796d 0000c5e3
Nov 14 22:12:32 gw kernel: 200: 00007770 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Nov 14 22:12:32 gw kernel: 220: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Nov 14 22:12:32 gw kernel: 240: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Nov 14 22:12:32 gw kernel: 260: 00000000 00000000 fe020001 00000100 00000000 00000000 fe020001 00000100
Nov 14 22:12:32 gw kernel: 280: 0e424b11 00041674 00000000 00000000 00000000 00000000 00000000 00000000
Nov 14 22:12:32 gw kernel: 2a0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Nov 14 22:12:32 gw kernel: 2c0: 00000000 00000000 00036e63 00000004 0000000c 00000001 00000001 00000001
Nov 14 22:12:32 gw kernel: 2e0: 00000001 00000001 00000001 00000001 00000001 00000001 00000001 00000001
Nov 14 22:12:32 gw kernel: 300: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Nov 14 22:12:32 gw kernel: 320: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Nov 14 22:12:32 gw kernel: 340: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Nov 14 22:12:32 gw kernel: 360: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Nov 14 22:12:32 gw kernel: 380: 00000000 00000000 00000000 00000000 ffffffff ffffffff ffffffff ffffffff
Nov 14 22:12:32 gw kernel: 3a0: ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff
Nov 14 22:12:32 gw kernel: 3c0: ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff
Nov 14 22:12:32 gw kernel: 3e0: ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff ffffffff
Nov 14 22:12:32 gw kernel: eth1: Dumping tx ring
Nov 14 22:12:32 gw kernel: 000: 0d8ca892 a000004d // 08ae0012 a0000041 // 08ae0e12 a0000041 // 0624aa02 a0000029
Nov 14 22:12:32 gw kernel: 004: 0d8ca4b2 8000004d // 0344ca97 a000002f // 0624a002 a0000029 // 04741402 a0000029
Nov 14 22:12:32 gw kernel: 008: 0d8ca092 a000004d // 04741002 a0000029 // 11fef0be a00001e1 // 10dc00be b16a1139
Nov 14 22:12:32 gw kernel: 00c: 027340be b16a1139 // 0a33e0be b16a1c89 // 1eb090be a00005e9 // 0cf410be b16a0b91
Nov 14 22:12:32 gw kernel: 010: 0fcce0be b16a1139 // 0ebca8be a00005e9 // 1a9880be b16a16e1 // 143390be a00001e1
Nov 14 22:12:32 gw kernel: 014: 03f8d8be 80000041 // 0da08000 a0000073 // 03f8d492 a000004d // 03f8d0be a00001e1
Nov 14 22:12:32 gw kernel: 018: 0f1a9c92 a000004d // 1eb17812 a0000189 // 0f1a98be a00001e1 // 0f276812 a0000189
Nov 14 22:12:32 gw kernel: 01c: 0f1a9492 a000004d // 1e84d812 a0000189 // 1d9afcbe a00001e1 // 0f1a9092 a000004d
Nov 14 22:12:32 gw kernel: 020: 1d9af4be a0000087 // 1d9af092 a000004d // 1e89f012 a0000189 // 04e56c92 a000004d
Nov 14 22:12:32 gw kernel: 024: 04e56892 a000004d // 04e564be a00001e1 // 04e56092 a000004d // 04396c92 a000004d
Nov 14 22:12:32 gw kernel: 028: 1eadb812 a0000189 // 04741612 a0000041 // 128f7412 a0000041 // 0735de12 a0000041
Nov 14 22:12:32 gw kernel: 02c: 060b4812 a0000041 // 14473c12 a0000041 // 0735d612 a0000041 // 04396892 a000004d
Nov 14 22:12:32 gw kernel: 030: 1d8cae12 a0000041 // 128f7012 a0000041 // 0e281812 a0000189 // 043960be a00001e1
Nov 14 22:12:32 gw kernel: 034: 04396492 a000004d // 0735d402 a0000045 // 0735d202 a0000029 // 0bf0e8be 80000041
Nov 14 22:12:32 gw kernel: 038: 0344ca07 a000002f // 0bf0e0be 80000041 // 0344ca37 a000002f // 0ef0a8be 80000041
Nov 14 22:12:32 gw kernel: 03c: 0344ca67 a000002f // 0ef0a092 a000004d // 0d8cacbe 80000041 // 0344ca07 a000002f

Relevant output of lspci -v:

0000:00:05.0 Bridge: nVidia Corporation CK8S Ethernet Controller (rev a2)
	Subsystem: ASUSTeK Computer Inc.: Unknown device 80a7
	Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 18
	Memory at febfc000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at ec00 [size=8]
	Capabilities: [44] Power Management version 2

Regards
Anders Fugmann


