Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTHBKZz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 06:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbTHBKZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 06:25:55 -0400
Received: from mail.broadpark.no ([217.13.4.2]:57802 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S262116AbTHBKZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 06:25:50 -0400
From: Frank Aune <faune@stud.ntnu.no>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test2: Badness in pci_find_subsys at drivers/pci/search.c:132
Date: Sat, 2 Aug 2003 12:23:48 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308021223.48920.faune@stud.ntnu.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Sat and enjoyed a game of Enemy Territory, and the game locked up after 
awhile. I was able to ssh in and kill the process, and here is the recorded 
info I found after the incident:

Mainboard:
Gigabyte GA-7DPXDW+ AMD-760MPX board

Periperals connected to the PCI bus (output of lspci -v):
--------------------------
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System 
Controller (rev 11)
	Flags: bus master, 66Mhz, medium devsel, latency 32
	Memory at d0000000 (32-bit, prefetchable) [size=256M]
	Memory at f4000000 (32-bit, prefetchable) [size=4K]
	I/O ports at c000 [disabled] [size=4]
	Capabilities: [a0] AGP version 2.0

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP 
Bridge (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	Memory behind bridge: f0000000-f1ffffff
	Prefetchable memory behind bridge: e0000000-efffffff

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 05)
	Flags: bus master, 66Mhz, medium devsel, latency 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE (rev 
04) (prog-if 8a [Master SecP PriP])
	Flags: bus master, medium devsel, latency 32
	I/O ports at f000 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 03)
	Flags: medium devsel

00:07.5 Multimedia audio controller: Advanced Micro Devices [AMD] AMD-768 
[Opus] Audio (rev 03)
	Flags: bus master, medium devsel, latency 32, IRQ 17
	I/O ports at b000 [size=256]
	I/O ports at b400 [size=64]

00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev 05) 
(prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 32
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
	I/O behind bridge: 00009000-0000afff
	Memory behind bridge: f2000000-f3ffffff

01:05.0 VGA compatible controller: nVidia Corporation NV25 [GeForce4 Ti4400] 
(rev a2) (prog-if 00 [VGA])
	Subsystem: Micro-star International Co Ltd: Unknown device 8711
	Flags: bus master, 66Mhz, medium devsel, latency 248, IRQ 17
	Memory at f0000000 (32-bit, non-prefetchable) [size=16M]
	Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Memory at e8000000 (32-bit, prefetchable) [size=512K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
	Capabilities: [44] AGP version 2.0

02:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-768 [Opus] USB (rev 
07) (prog-if 10 [OHCI])
	Flags: bus master, medium devsel, latency 32, IRQ 19
	Memory at f3025000 (32-bit, non-prefetchable) [size=4K]

02:04.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 04)
	Subsystem: Creative Labs CT4850 SBLive! Value
	Flags: bus master, medium devsel, latency 32, IRQ 16
	I/O ports at 9000 [size=32]
	Capabilities: [dc] Power Management version 1

02:04.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 
01)
	Subsystem: Creative Labs Gameport Joystick
	Flags: bus master, medium devsel, latency 32
	I/O ports at 9400 [size=8]
	Capabilities: [dc] Power Management version 1

02:07.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 0d)
	Subsystem: Intel Corp. EtherExpress PRO/100 Server Adapter
	Flags: bus master, medium devsel, latency 32, IRQ 16
	Memory at f3024000 (32-bit, non-prefetchable) [size=4K]
	I/O ports at 9800 [size=64]
	Memory at f3000000 (32-bit, non-prefetchable) [size=128K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2

02:08.0 RAID bus controller: Promise Technology, Inc. PDC20276 IDE (rev 01) 
(prog-if 85)
	Subsystem: Promise Technology, Inc.: Unknown device 1275
	Flags: bus master, 66Mhz, slow devsel, latency 32, IRQ 18
	I/O ports at 9c00 [size=8]
	I/O ports at a000 [size=4]
	I/O ports at a400 [size=8]
	I/O ports at a800 [size=4]
	I/O ports at ac00 [size=16]
	Memory at f3020000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [60] Power Management version 1

---------------------------

This is the dmesg output run through ksymoops:

-------------------------
ksymoops 2.4.9 on i686 2.6.0-test2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-test2/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
CPU 1 IS NOW UP!
Machine check exception polling timer started.
e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection
e100: eth0 NIC Link is Up 100 Mbps Full duplex
UDF-fs DEBUG fs/udf/lowlevel.c:57:udf_get_last_session: XA disk: no, 
vol_desc_start=0
UDF-fs DEBUG fs/udf/super.c:1477:udf_fill_super: Multi-session=0
UDF-fs DEBUG fs/udf/super.c:465:udf_vrs: Starting at sector 16 (2048 byte 
sectors)
UDF-fs DEBUG fs/udf/super.c:492:udf_vrs: ISO9660 Primary Volume Descriptor 
found
UDF-fs DEBUG fs/udf/super.c:501:udf_vrs: ISO9660 Volume Descriptor Set 
Terminator found
UDF-fs DEBUG fs/udf/lowlevel.c:57:udf_get_last_session: XA disk: no, 
vol_desc_start=0
UDF-fs DEBUG fs/udf/super.c:1477:udf_fill_super: Multi-session=0
UDF-fs DEBUG fs/udf/super.c:465:udf_vrs: Starting at sector 16 (2048 byte 
sectors)
UDF-fs DEBUG fs/udf/super.c:492:udf_vrs: ISO9660 Primary Volume Descriptor 
found
UDF-fs DEBUG fs/udf/super.c:501:udf_vrs: ISO9660 Volume Descriptor Set 
Terminator found
Call Trace:
 [<c01cb9e6>] pci_find_subsys+0x116/0x120
 [<c01cba1f>] pci_find_device+0x2f/0x40
 [<c01cb8a8>] pci_find_slot+0x28/0x50
 [<e0c81348>] os_pci_init_handle+0x3a/0x67 [nvidia]
 [<e0c93c6f>] __nvsym00057+0x1f/0x24 [nvidia]
 [<e0da41c8>] __nvsym04875+0xf8/0x170 [nvidia]
 [<e0da3f9a>] __nvsym00780+0x21a/0x224 [nvidia]
 [<e0d3bb94>] __nvsym03928+0x70/0x98 [nvidia]
 [<e0d3b854>] __nvsym00610+0x7ac/0x954 [nvidia]
 [<e0cc6cea>] __nvsym00803+0x16/0x1c [nvidia]
 [<e0db6421>] __nvsym05234+0x1d/0x278 [nvidia]
 [<e0cb0f71>] __nvsym01822+0x19/0xf4 [nvidia]
 [<e0cae7b5>] __nvsym00805+0x11/0x228 [nvidia]
 [<e0d6ab7a>] __nvsym00688+0x16a/0x338 [nvidia]
 [<e0c96379>] __nvsym00827+0xd/0x1c [nvidia]
 [<e0c97a14>] rm_isr_bh+0xc/0x10 [nvidia]
 [<c0124312>] tasklet_action+0x72/0xc0
 [<c0124045>] do_softirq+0xd5/0xe0
 [<c010bcec>] do_IRQ+0x14c/0x1b0
 [<c0109d88>] common_interrupt+0x18/0x20
Call Trace:
 [<c01cb9e6>] pci_find_subsys+0x116/0x120
 [<c01cba1f>] pci_find_device+0x2f/0x40
 [<c01cb8a8>] pci_find_slot+0x28/0x50
 [<e0c81348>] os_pci_init_handle+0x3a/0x67 [nvidia]
 [<e0c93c6f>] __nvsym00057+0x1f/0x24 [nvidia]
 [<e0d282a2>] __nvsym03763+0x72/0xe0 [nvidia]
 [<e0d6cdb1>] __nvsym04466+0x15/0x78 [nvidia]
 [<e0da41f7>] __nvsym04875+0x127/0x170 [nvidia]
 [<e0da3f9a>] __nvsym00780+0x21a/0x224 [nvidia]
 [<e0d3bb94>] __nvsym03928+0x70/0x98 [nvidia]
 [<e0d3b854>] __nvsym00610+0x7ac/0x954 [nvidia]
 [<e0cc6cea>] __nvsym00803+0x16/0x1c [nvidia]
 [<e0db6421>] __nvsym05234+0x1d/0x278 [nvidia]
 [<e0cb0f71>] __nvsym01822+0x19/0xf4 [nvidia]
 [<e0cae7b5>] __nvsym00805+0x11/0x228 [nvidia]
 [<e0d6ab7a>] __nvsym00688+0x16a/0x338 [nvidia]
 [<e0c96379>] __nvsym00827+0xd/0x1c [nvidia]
 [<e0c97a14>] rm_isr_bh+0xc/0x10 [nvidia]
 [<c0124312>] tasklet_action+0x72/0xc0
 [<c0124045>] do_softirq+0xd5/0xe0
 [<c010bcec>] do_IRQ+0x14c/0x1b0
 [<c0109d88>] common_interrupt+0x18/0x20
Warning (Oops_read): Code line not seen, dumping what data is available

Trace; c01cb9e6 <pci_find_subsys+116/120>
Trace; c01cba1f <pci_find_device+2f/40>
Trace; c01cb8a8 <pci_find_slot+28/50>
Trace; e0c81348 <_end+208cc498/3fc49150>
Trace; e0c93c6f <_end+208dedbf/3fc49150>
Trace; e0da41c8 <_end+209ef318/3fc49150>
Trace; e0da3f9a <_end+209ef0ea/3fc49150>
Trace; e0d3bb94 <_end+20986ce4/3fc49150>
Trace; e0d3b854 <_end+209869a4/3fc49150>
Trace; e0cc6cea <_end+20911e3a/3fc49150>
Trace; e0db6421 <_end+20a01571/3fc49150>
Trace; e0cb0f71 <_end+208fc0c1/3fc49150>
Trace; e0cae7b5 <_end+208f9905/3fc49150>
Trace; e0d6ab7a <_end+209b5cca/3fc49150>
Trace; e0c96379 <_end+208e14c9/3fc49150>
Trace; e0c97a14 <_end+208e2b64/3fc49150>
Trace; c0124312 <tasklet_action+72/c0>
Trace; c0124045 <do_softirq+d5/e0>
Trace; c010bcec <do_IRQ+14c/1b0>
Trace; c0109d88 <common_interrupt+18/20>
Trace; c01cb9e6 <pci_find_subsys+116/120>
Trace; c01cba1f <pci_find_device+2f/40>
Trace; c01cb8a8 <pci_find_slot+28/50>
Trace; e0c81348 <_end+208cc498/3fc49150>
Trace; e0c93c6f <_end+208dedbf/3fc49150>
Trace; e0d282a2 <_end+209733f2/3fc49150>
Trace; e0d6cdb1 <_end+209b7f01/3fc49150>
Trace; e0da41f7 <_end+209ef347/3fc49150>
Trace; e0da3f9a <_end+209ef0ea/3fc49150>
Trace; e0d3bb94 <_end+20986ce4/3fc49150>
Trace; e0d3b854 <_end+209869a4/3fc49150>
Trace; e0cc6cea <_end+20911e3a/3fc49150>
Trace; e0db6421 <_end+20a01571/3fc49150>
Trace; e0cb0f71 <_end+208fc0c1/3fc49150>
Trace; e0cae7b5 <_end+208f9905/3fc49150>
Trace; e0d6ab7a <_end+209b5cca/3fc49150>
Trace; e0c96379 <_end+208e14c9/3fc49150>
Trace; e0c97a14 <_end+208e2b64/3fc49150>
Trace; c0124312 <tasklet_action+72/c0>
Trace; c0124045 <do_softirq+d5/e0>
Trace; c010bcec <do_IRQ+14c/1b0>
Trace; c0109d88 <common_interrupt+18/20>

2 warnings and 1 error issued.  Results may not be reliable.
-------------------

Seems to me the problem is related to every kernel devs "favourite" binary 
driver; nvidia. Its version 4496 if that matters... Let me know if you need 
more information.

Cheers!

