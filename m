Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965159AbWGFDpr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965159AbWGFDpr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 23:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965156AbWGFDpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 23:45:47 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.59]:37777 "EHLO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S965159AbWGFDpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 23:45:45 -0400
From: Andrew Baumann <andrewb@cse.unsw.edu.au>
To: linux-kernel@vger.kernel.org
Date: Thu, 6 Jul 2006 13:45:31 +1000
X-CSE-Spam-Checker-Version: SpamAssassin 3.1.3 (2006-06-01) on 
	tone.orchestra.cse.unsw.EDU.AU
X-CSE-Spam-Level: 
X-CSE-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,UNPARSEABLE_RELAY 
	autolearn=ham version=3.1.3
Subject: PCI: Cannot allocate resource regions of bridge and device in ThinkPad dock
User-Agent: KMail/1.9.1
X-Operating-System: Mungi-1.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607061345.31486.andrewb@cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm unable to use a radeon card installed in the PCI slot of a thinkpad
docking station. This is from a clean boot in the dock (no hot dock/undock),
and appears on vendor-provided 2.6.16 and 2.6.17 kernels, as well as on a
self-built 2.6.17-git25 tree. First of all, here is dmesg from a normal boot:


Linux version 2.6.17-git25 (andrewb@desiato) (gcc version 4.1.1 20060525 (Red Hat 4.1.1-1)) #1 Thu Jul 6 11:00:29 EST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff60000 (usable)
 BIOS-e820: 000000001ff60000 - 000000001ff77000 (ACPI data)
 BIOS-e820: 000000001ff77000 - 000000001ff79000 (ACPI NVS)
 BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
On node 0 totalpages: 130912
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 126816 pages, LIFO batch:31
DMI present.
ACPI: RSDP (v002 IBM                                   ) @ 0x000f6d70
ACPI: XSDT (v001 IBM    TP-1Q    0x00003020  LTP 0x00000000) @ 0x1ff69e78
ACPI: FADT (v003 IBM    TP-1Q    0x00003020 IBM  0x00000001) @ 0x1ff69f00
ACPI: SSDT (v001 IBM    TP-1Q    0x00003020 MSFT 0x0100000e) @ 0x1ff6a0b4
ACPI: ECDT (v001 IBM    TP-1Q    0x00003020 IBM  0x00000001) @ 0x1ff76e11
ACPI: TCPA (v001 IBM    TP-1Q    0x00003020 PTL  0x00000001) @ 0x1ff76e63
ACPI: BOOT (v001 IBM    TP-1Q    0x00003020  LTP 0x00000001) @ 0x1ff76fd8
ACPI: DSDT (v001 IBM    TP-1Q    0x00003020 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
Allocating PCI resources starting at 30000000 (gap: 20000000:df800000)
Detected 1298.950 MHz processor.
Built 1 zonelists.  Total pages: 130912
Kernel command line: ro root=LABEL=/ single
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (0140e000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c04c5000 soft=c04c4000
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour VGA+ 80x25
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:    8
... MAX_LOCK_DEPTH:          30
... MAX_LOCKDEP_KEYS:        2048
... CLASSHASH_SIZE:           1024
... MAX_LOCKDEP_ENTRIES:     8192
... MAX_LOCKDEP_CHAINS:      8192
... CHAINHASH_SIZE:          4096
 memory used by lock dependency info: 696 kB
 per task-struct memory footprint: 1200 bytes
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 511928k/523648k available (2009k kernel code, 11112k reserved, 1136k data, 216k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 2600.03 BogoMIPS (lpj=5200079)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: a7e9f9bf 00000000 00000000 00000000 00000180 00000000 00000000
CPU: After vendor identify, caps: a7e9f9bf 00000000 00000000 00000000 00000180 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU: After all inits, caps: a7e9f9bf 00000000 00000000 00000040 00000180 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
CPU: Intel(R) Pentium(R) M processor 1300MHz stepping 05
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060623
ACPI: setting ELCR to 0200 (from 0800)
checking if image is initramfs... it is
Freeing initrd memory: 913k freed
PM: Adding info for No Bus:platform
NET: Registered protocol family 16
ACPI: ACPI Dock Station Driver 
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd8d6, last bus=15
Setting up standard PCI resources
ACPI: Found ECDT
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
PM: Adding info for acpi:acpi
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PM: Adding info for No Bus:pci0000:00
PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
PCI: Found IBM Dock II Cardbus Bridge applying quirk
PCI: Found IBM Dock II Cardbus Bridge applying quirk
PCI: Transparent bridge - 0000:02:03.0
PCI: Bus #10 (-#13) is hidden behind transparent bridge #02 (-#0f) (try 'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently
PCI: Bus #14 (-#17) is hidden behind transparent bridge #02 (-#0f) (try 'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
PM: Adding info for pci:0000:00:00.0
PM: Adding info for pci:0000:00:01.0
PM: Adding info for pci:0000:00:1d.0
PM: Adding info for pci:0000:00:1d.1
PM: Adding info for pci:0000:00:1d.2
PM: Adding info for pci:0000:00:1d.7
PM: Adding info for pci:0000:00:1e.0
PM: Adding info for pci:0000:00:1f.0
PM: Adding info for pci:0000:00:1f.1
PM: Adding info for pci:0000:00:1f.3
PM: Adding info for pci:0000:00:1f.5
PM: Adding info for pci:0000:00:1f.6
PM: Adding info for pci:0000:01:00.0
PM: Adding info for pci:0000:02:00.0
PM: Adding info for pci:0000:02:00.1
PM: Adding info for pci:0000:02:00.2
PM: Adding info for pci:0000:02:02.0
PM: Adding info for pci:0000:02:03.0
PM: Adding info for pci:0000:02:08.0
PM: Adding info for pci:0000:09:00.0
PM: Adding info for pci:0000:09:01.0
PM: Adding info for pci:0000:09:02.0
PM: Adding info for pci:0000:09:02.1
ACPI: Embedded Controller [EC] (gpe 28) interrupt mode.
ACPI: Power Resource [PUBS] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1.DOCK._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
PM: Adding info for No Bus:pnp0
PM: Adding info for pnp:00:00
PM: Adding info for pnp:00:01
PM: Adding info for pnp:00:02
PM: Adding info for pnp:00:03
PM: Adding info for pnp:00:04
PM: Adding info for pnp:00:05
PM: Adding info for pnp:00:06
PM: Adding info for pnp:00:07
PM: Adding info for pnp:00:08
PM: Adding info for pnp:00:09
PM: Adding info for pnp:00:0a
PM: Adding info for pnp:00:0b
pnp: PnP ACPI: found 12 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Cannot allocate resource region 7 of bridge 0000:02:03.0
PCI: Cannot allocate resource region 8 of bridge 0000:02:03.0
PCI: Cannot allocate resource region 9 of bridge 0000:02:03.0
PCI: Cannot allocate resource region 0 of device 0000:02:00.0
PCI: Bridge: 0000:00:01.0
  IO window: 3000-3fff
  MEM window: b0100000-b01fffff
  PREFETCH window: e0000000-e7ffffff
PCI: Bus 16, cardbus bridge: 0000:02:00.0
  IO window: 00005000-000050ff
  IO window: 00005400-000054ff
  PREFETCH window: e8000000-e9ffffff
  MEM window: b4000000-b5ffffff
PCI: Bus 20, cardbus bridge: 0000:02:00.1
  IO window: 00005800-000058ff
  IO window: 00005c00-00005cff
  PREFETCH window: ea000000-ebffffff
  MEM window: b6000000-b7ffffff
PCI: Bus 10, cardbus bridge: 0000:09:02.0
  IO window: 00004000-000040ff
  IO window: 00004400-000044ff
  PREFETCH window: 32000000-33ffffff
  MEM window: b8000000-b9ffffff
PCI: Bus 14, cardbus bridge: 0000:09:02.1
  IO window: 00004800-000048ff
  IO window: 00004c00-00004cff
  PREFETCH window: 34000000-35ffffff
  MEM window: ba000000-bbffffff
PCI: Bridge: 0000:02:03.0
  IO window: 4000-4fff
  MEM window: b8000000-bbffffff
  PREFETCH window: 31000000-35ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 4000-9fff
  MEM window: b0200000-c00fffff
  PREFETCH window: e8000000-f7ffffff


Notice the "Cannot allocate resource region" messages from PCI. Later,
when I try to start X on the card (note that there is a different radeon
on the internal AGP bus, this works fine), I get:


(II) PCI: PCI scan (all values are in hex)
(II) PCI: 00:00:0: chip 8086,3340 card 1014,0529 rev 03 class 06,00,00 hdr 00
(II) PCI: 00:01:0: chip 8086,3341 card 0000,0000 rev 03 class 06,04,00 hdr 01
(II) PCI: 00:1d:0: chip 8086,24c2 card 1014,052d rev 01 class 0c,03,00 hdr 80
(II) PCI: 00:1d:1: chip 8086,24c4 card 1014,052d rev 01 class 0c,03,00 hdr 00
(II) PCI: 00:1d:2: chip 8086,24c7 card 1014,052d rev 01 class 0c,03,00 hdr 00
(II) PCI: 00:1d:7: chip 8086,24cd card 1014,052e rev 01 class 0c,03,20 hdr 00
(II) PCI: 00:1e:0: chip 8086,2448 card 0000,0000 rev 81 class 06,04,00 hdr 01
(II) PCI: 00:1f:0: chip 8086,24cc card 0000,0000 rev 01 class 06,01,00 hdr 80
(II) PCI: 00:1f:1: chip 8086,24ca card 1014,052d rev 01 class 01,01,8a hdr 00
(II) PCI: 00:1f:3: chip 8086,24c3 card 1014,052d rev 01 class 0c,05,00 hdr 00
(II) PCI: 00:1f:5: chip 8086,24c5 card 1014,0534 rev 01 class 04,01,00 hdr 00
(II) PCI: 00:1f:6: chip 8086,24c6 card 1014,0524 rev 01 class 07,03,00 hdr 00
(II) PCI: 01:00:0: chip 1002,4c59 card 1014,052f rev 00 class 03,00,00 hdr 00
(II) PCI: 02:00:0: chip 1180,0476 card 5000,0000 rev aa class 06,07,00 hdr 82
(II) PCI: 02:00:1: chip 1180,0476 card 5800,0000 rev aa class 06,07,00 hdr 82
(II) PCI: 02:00:2: chip 1180,0552 card 1014,0533 rev 02 class 0c,00,10 hdr 80
(II) PCI: 02:02:0: chip 8086,1043 card 8086,2551 rev 04 class 02,80,00 hdr 00
(II) PCI: 02:03:0: chip 104c,ac22 card 0000,0000 rev 00 class 06,04,01 hdr 01
(II) PCI: 02:08:0: chip 8086,103d card 1014,0522 rev 81 class 02,00,00 hdr 00
(II) PCI: 09:00:0: chip 1002,5157 card 148c,2036 rev 00 class 03,00,00 hdr 00
(II) PCI: 09:01:0: chip 1095,0648 card 1095,0648 rev 01 class 01,01,8f hdr 00
(II) PCI: 09:02:0: chip 104c,ac51 card 4000,0000 rev 00 class 06,07,00 hdr 82
(II) PCI: 09:02:1: chip 104c,ac51 card 4800,0000 rev 00 class 06,07,00 hdr 82
(II) PCI: End of PCI scan
(II) Host-to-PCI bridge:
(II) Bus 0: bridge is at (0:0:0), (0,0,20), BCTRL: 0x0008 (VGA_EN is set)
(II) Bus 0 I/O range:
	[0] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) Bus 0 non-prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
(II) Bus 0 prefetchable memory range:
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
(II) PCI-to-PCI bridge:
(II) Bus 1: bridge is at (0:1:0), (0,1,1), BCTRL: 0x000c (VGA_EN is set)
(II) Bus 1 I/O range:
	[0] -1	0	0x00003000 - 0x000030ff (0x100) IX[B]
	[1] -1	0	0x00003400 - 0x000034ff (0x100) IX[B]
	[2] -1	0	0x00003800 - 0x000038ff (0x100) IX[B]
	[3] -1	0	0x00003c00 - 0x00003cff (0x100) IX[B]
(II) Bus 1 non-prefetchable memory range:
	[0] -1	0	0xb0100000 - 0xb01fffff (0x100000) MX[B]
(II) Bus 1 prefetchable memory range:
	[0] -1	0	0xe0000000 - 0xe7ffffff (0x8000000) MX[B]
(II) PCI-to-PCI bridge:
(II) Bus 2: bridge is at (0:30:0), (0,2,23), BCTRL: 0x0004 (VGA_EN is cleared)
(II) Bus 2 I/O range:
	[0] -1	0	0x00004000 - 0x000040ff (0x100) IX[B]
	[1] -1	0	0x00004400 - 0x000044ff (0x100) IX[B]
	[2] -1	0	0x00004800 - 0x000048ff (0x100) IX[B]
	[3] -1	0	0x00004c00 - 0x00004cff (0x100) IX[B]
	[4] -1	0	0x00005000 - 0x000050ff (0x100) IX[B]
	[5] -1	0	0x00005400 - 0x000054ff (0x100) IX[B]
	[6] -1	0	0x00005800 - 0x000058ff (0x100) IX[B]
	[7] -1	0	0x00005c00 - 0x00005cff (0x100) IX[B]
	[8] -1	0	0x00006000 - 0x000060ff (0x100) IX[B]
	[9] -1	0	0x00006400 - 0x000064ff (0x100) IX[B]
	[10] -1	0	0x00006800 - 0x000068ff (0x100) IX[B]
	[11] -1	0	0x00006c00 - 0x00006cff (0x100) IX[B]
	[12] -1	0	0x00007000 - 0x000070ff (0x100) IX[B]
	[13] -1	0	0x00007400 - 0x000074ff (0x100) IX[B]
	[14] -1	0	0x00007800 - 0x000078ff (0x100) IX[B]
	[15] -1	0	0x00007c00 - 0x00007cff (0x100) IX[B]
	[16] -1	0	0x00008000 - 0x000080ff (0x100) IX[B]
	[17] -1	0	0x00008400 - 0x000084ff (0x100) IX[B]
	[18] -1	0	0x00008800 - 0x000088ff (0x100) IX[B]
	[19] -1	0	0x00008c00 - 0x00008cff (0x100) IX[B]
	[20] -1	0	0x00009000 - 0x000090ff (0x100) IX[B]
	[21] -1	0	0x00009400 - 0x000094ff (0x100) IX[B]
	[22] -1	0	0x00009800 - 0x000098ff (0x100) IX[B]
	[23] -1	0	0x00009c00 - 0x00009cff (0x100) IX[B]
(II) Bus 2 non-prefetchable memory range:
	[0] -1	0	0xb0200000 - 0xc00fffff (0xff00000) MX[B]
(II) Bus 2 prefetchable memory range:
	[0] -1	0	0xe8000000 - 0xf7ffffff (0x10000000) MX[B]
(II) PCI-to-ISA bridge:
(II) Bus -1: bridge is at (0:31:0), (0,-1,-1), BCTRL: 0x0008 (VGA_EN is set)
(II) PCI-to-CardBus bridge:
(II) Bus 16: bridge is at (2:0:0), (2,16,19), BCTRL: 0x0580 (VGA_EN is cleared)
(II) Bus 16 I/O range:
	[0] -1	0	0x00005000 - 0x000050ff (0x100) IX[B]
	[1] -1	0	0x00005400 - 0x000054ff (0x100) IX[B]
(II) Bus 16 non-prefetchable memory range:
	[0] -1	0	0xb4000000 - 0xb5ffffff (0x2000000) MX[B]
(II) Bus 16 prefetchable memory range:
	[0] -1	0	0xe8000000 - 0xe9ffffff (0x2000000) MX[B]
(II) PCI-to-CardBus bridge:
(II) Bus 20: bridge is at (2:0:1), (2,20,23), BCTRL: 0x0580 (VGA_EN is cleared)
(II) Bus 20 I/O range:
	[0] -1	0	0x00005800 - 0x000058ff (0x100) IX[B]
	[1] -1	0	0x00005c00 - 0x00005cff (0x100) IX[B]
(II) Bus 20 non-prefetchable memory range:
	[0] -1	0	0xb6000000 - 0xb7ffffff (0x2000000) MX[B]
(II) Bus 20 prefetchable memory range:
	[0] -1	0	0xea000000 - 0xebffffff (0x2000000) MX[B]
(II) Subtractive PCI-to-PCI bridge:
(II) Bus 9: bridge is at (2:3:0), (2,9,15), BCTRL: 0x0004 (VGA_EN is cleared)
(II) Bus 9 I/O range:
	[0] -1	0	0x00004000 - 0x000040ff (0x100) IX[B]
	[1] -1	0	0x00004400 - 0x000044ff (0x100) IX[B]
	[2] -1	0	0x00004800 - 0x000048ff (0x100) IX[B]
	[3] -1	0	0x00004c00 - 0x00004cff (0x100) IX[B]
(II) Bus 9 non-prefetchable memory range:
	[0] -1	0	0xb8000000 - 0xbbffffff (0x4000000) MX[B]
(II) PCI-to-CardBus bridge:
(II) Bus 10: bridge is at (9:2:0), (9,10,13), BCTRL: 0x05c0 (VGA_EN is cleared)
(II) Bus 10 I/O range:
	[0] -1	0	0x00004000 - 0x000040ff (0x100) IX[B]
	[1] -1	0	0x00004400 - 0x000044ff (0x100) IX[B]
(II) Bus 10 non-prefetchable memory range:
	[0] -1	0	0xb8000000 - 0xb9ffffff (0x2000000) MX[B]
(II) PCI-to-CardBus bridge:
(II) Bus 14: bridge is at (9:2:1), (9,14,14), BCTRL: 0x05c0 (VGA_EN is cleared)
(II) Bus 14 I/O range:
	[0] -1	0	0x00004800 - 0x000048ff (0x100) IX[B]
	[1] -1	0	0x00004c00 - 0x00004cff (0x100) IX[B]
(II) Bus 14 non-prefetchable memory range:
	[0] -1	0	0xba000000 - 0xbbffffff (0x2000000) MX[B]
(--) PCI:*(1:0:0) ATI Technologies Inc Radeon Mobility M6 LY rev 0, Mem @ 0xe0000000/27, 0xb0100000/16, I/O @ 0x3000/8
(--) PCI: (9:0:0) ATI Technologies Inc Radeon RV200 QW [Radeon 7500] rev 0, Mem @ 0xf0000000/27, 0xc0000000/16, I/O @ 0x9400/8
(II) Addressable bus resource ranges are
	[0] -1	0	0x00000000 - 0xffffffff (0x0) MX[B]
	[1] -1	0	0x00000000 - 0x0000ffff (0x10000) IX[B]
(II) OS-reported resource ranges:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x3fffffff (0x3ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[6] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
(II) PCI Memory resource overlap reduced 0xd0000000 from 0xdfffffff to 0xcfffffff
(II) Active PCI resource ranges:
	[0] -1	0	0xb0201000 - 0xb0201fff (0x1000) MX[B]
	[1] -1	0	0xb0200000 - 0xb0200fff (0x1000) MX[B]
	[2] -1	0	0xb0202000 - 0xb02027ff (0x800) MX[B]
	[3] -1	0	0xb0000800 - 0xb00008ff (0x100) MX[B]
	[4] -1	0	0xb0000c00 - 0xb0000dff (0x200) MX[B]
	[5] -1	0	0x30000000 - 0x300003ff (0x400) MX[B]
	[6] -1	0	0xb0000000 - 0xb00003ff (0x400) MX[B]
	[7] -1	0	0xd0000000 - 0xcfffffff (0x0) MX[B]O
	[8] -1	0	0xb0100000 - 0xb010ffff (0x10000) MX[B](B)
	[9] -1	0	0xe0000000 - 0xe7ffffff (0x8000000) MX[B](B)
	[10] -1	0	0x00009000 - 0x0000900f (0x10) IX[B]
	[11] -1	0	0x00009010 - 0x00009013 (0x4) IX[B]
	[12] -1	0	0x00009018 - 0x0000901f (0x8) IX[B]
	[13] -1	0	0x00009014 - 0x00009017 (0x4) IX[B]
	[14] -1	0	0x00009020 - 0x00009027 (0x8) IX[B]
	[15] -1	0	0x00008000 - 0x0000803f (0x40) IX[B]
	[16] -1	0	0x00002000 - 0x0000207f (0x80) IX[B]
	[17] -1	0	0x00002400 - 0x000024ff (0x100) IX[B]
	[18] -1	0	0x000018c0 - 0x000018ff (0x40) IX[B]
	[19] -1	0	0x00001c00 - 0x00001cff (0x100) IX[B]
	[20] -1	0	0x00001880 - 0x0000189f (0x20) IX[B]
	[21] -1	0	0x00001860 - 0x0000186f (0x10) IX[B]
	[22] -1	0	0x00001840 - 0x0000185f (0x20) IX[B]
	[23] -1	0	0x00001820 - 0x0000183f (0x20) IX[B]
	[24] -1	0	0x00001800 - 0x0000181f (0x20) IX[B]
	[25] -1	0	0x00003000 - 0x000030ff (0x100) IX[B](B)
(II) Inactive PCI resource ranges:
	[0] -1	0	0xc0000000 - 0xc000ffff (0x10000) MX[B](B)
	[1] -1	0	0xf0000000 - 0xf7ffffff (0x8000000) MX[B](B)
	[2] -1	0	0x00009400 - 0x000094ff (0x100) IX[B](B)
(II) Active PCI resource ranges after removing overlaps:
	[0] -1	0	0xb0201000 - 0xb0201fff (0x1000) MX[B]
	[1] -1	0	0xb0200000 - 0xb0200fff (0x1000) MX[B]
	[2] -1	0	0xb0202000 - 0xb02027ff (0x800) MX[B]
	[3] -1	0	0xb0000800 - 0xb00008ff (0x100) MX[B]
	[4] -1	0	0xb0000c00 - 0xb0000dff (0x200) MX[B]
	[5] -1	0	0x30000000 - 0x300003ff (0x400) MX[B]
	[6] -1	0	0xb0000000 - 0xb00003ff (0x400) MX[B]
	[7] -1	0	0xd0000000 - 0xcfffffff (0x0) MX[B]O
	[8] -1	0	0xb0100000 - 0xb010ffff (0x10000) MX[B](B)
	[9] -1	0	0xe0000000 - 0xe7ffffff (0x8000000) MX[B](B)
	[10] -1	0	0x00009000 - 0x0000900f (0x10) IX[B]
	[11] -1	0	0x00009010 - 0x00009013 (0x4) IX[B]
	[12] -1	0	0x00009018 - 0x0000901f (0x8) IX[B]
	[13] -1	0	0x00009014 - 0x00009017 (0x4) IX[B]
	[14] -1	0	0x00009020 - 0x00009027 (0x8) IX[B]
	[15] -1	0	0x00008000 - 0x0000803f (0x40) IX[B]
	[16] -1	0	0x00002000 - 0x0000207f (0x80) IX[B]
	[17] -1	0	0x00002400 - 0x000024ff (0x100) IX[B]
	[18] -1	0	0x000018c0 - 0x000018ff (0x40) IX[B]
	[19] -1	0	0x00001c00 - 0x00001cff (0x100) IX[B]
	[20] -1	0	0x00001880 - 0x0000189f (0x20) IX[B]
	[21] -1	0	0x00001860 - 0x0000186f (0x10) IX[B]
	[22] -1	0	0x00001840 - 0x0000185f (0x20) IX[B]
	[23] -1	0	0x00001820 - 0x0000183f (0x20) IX[B]
	[24] -1	0	0x00001800 - 0x0000181f (0x20) IX[B]
	[25] -1	0	0x00003000 - 0x000030ff (0x100) IX[B](B)
(II) Inactive PCI resource ranges after removing overlaps:
	[0] -1	0	0xc0000000 - 0xc000ffff (0x10000) MX[B](B)
	[1] -1	0	0xf0000000 - 0xf7ffffff (0x8000000) MX[B](B)
	[2] -1	0	0x00009400 - 0x000094ff (0x100) IX[B](B)
(II) OS-reported resource ranges after removing overlaps with PCI:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x2fffffff (0x2ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[6] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
(II) All system resource ranges:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x2fffffff (0x2ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0xb0201000 - 0xb0201fff (0x1000) MX[B]
	[6] -1	0	0xb0200000 - 0xb0200fff (0x1000) MX[B]
	[7] -1	0	0xb0202000 - 0xb02027ff (0x800) MX[B]
	[8] -1	0	0xb0000800 - 0xb00008ff (0x100) MX[B]
	[9] -1	0	0xb0000c00 - 0xb0000dff (0x200) MX[B]
	[10] -1	0	0x30000000 - 0x300003ff (0x400) MX[B]
	[11] -1	0	0xb0000000 - 0xb00003ff (0x400) MX[B]
	[12] -1	0	0xd0000000 - 0xcfffffff (0x0) MX[B]O
	[13] -1	0	0xb0100000 - 0xb010ffff (0x10000) MX[B](B)
	[14] -1	0	0xe0000000 - 0xe7ffffff (0x8000000) MX[B](B)
	[15] -1	0	0xc0000000 - 0xc000ffff (0x10000) MX[B](B)
	[16] -1	0	0xf0000000 - 0xf7ffffff (0x8000000) MX[B](B)
	[17] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[18] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[19] -1	0	0x00009000 - 0x0000900f (0x10) IX[B]
	[20] -1	0	0x00009010 - 0x00009013 (0x4) IX[B]
	[21] -1	0	0x00009018 - 0x0000901f (0x8) IX[B]
	[22] -1	0	0x00009014 - 0x00009017 (0x4) IX[B]
	[23] -1	0	0x00009020 - 0x00009027 (0x8) IX[B]
	[24] -1	0	0x00008000 - 0x0000803f (0x40) IX[B]
	[25] -1	0	0x00002000 - 0x0000207f (0x80) IX[B]
	[26] -1	0	0x00002400 - 0x000024ff (0x100) IX[B]
	[27] -1	0	0x000018c0 - 0x000018ff (0x40) IX[B]
	[28] -1	0	0x00001c00 - 0x00001cff (0x100) IX[B]
	[29] -1	0	0x00001880 - 0x0000189f (0x20) IX[B]
	[30] -1	0	0x00001860 - 0x0000186f (0x10) IX[B]
	[31] -1	0	0x00001840 - 0x0000185f (0x20) IX[B]
	[32] -1	0	0x00001820 - 0x0000183f (0x20) IX[B]
	[33] -1	0	0x00001800 - 0x0000181f (0x20) IX[B]
	[34] -1	0	0x00003000 - 0x000030ff (0x100) IX[B](B)
	[35] -1	0	0x00009400 - 0x000094ff (0x100) IX[B](B)

[snip irrelevant X modules being loaded]

(II) Primary Device is: PCI 01:00:0
(WW) RADEON: No matching Device section for instance (BusID PCI:1:0:0) found
(--) Chipset ATI Radeon 7500 QW (AGP/PCI) found
(II) resource ranges after xf86ClaimFixedResources() call:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x2fffffff (0x2ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0xb0201000 - 0xb0201fff (0x1000) MX[B]
	[6] -1	0	0xb0200000 - 0xb0200fff (0x1000) MX[B]
	[7] -1	0	0xb0202000 - 0xb02027ff (0x800) MX[B]
	[8] -1	0	0xb0000800 - 0xb00008ff (0x100) MX[B]
	[9] -1	0	0xb0000c00 - 0xb0000dff (0x200) MX[B]
	[10] -1	0	0x30000000 - 0x300003ff (0x400) MX[B]
	[11] -1	0	0xb0000000 - 0xb00003ff (0x400) MX[B]
	[12] -1	0	0xd0000000 - 0xcfffffff (0x0) MX[B]O
	[13] -1	0	0xb0100000 - 0xb010ffff (0x10000) MX[B](B)
	[14] -1	0	0xe0000000 - 0xe7ffffff (0x8000000) MX[B](B)
	[15] -1	0	0xc0000000 - 0xc000ffff (0x10000) MX[B](B)
	[16] -1	0	0xf0000000 - 0xf7ffffff (0x8000000) MX[B](B)
	[17] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[18] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[19] -1	0	0x00009000 - 0x0000900f (0x10) IX[B]
	[20] -1	0	0x00009010 - 0x00009013 (0x4) IX[B]
	[21] -1	0	0x00009018 - 0x0000901f (0x8) IX[B]
	[22] -1	0	0x00009014 - 0x00009017 (0x4) IX[B]
	[23] -1	0	0x00009020 - 0x00009027 (0x8) IX[B]
	[24] -1	0	0x00008000 - 0x0000803f (0x40) IX[B]
	[25] -1	0	0x00002000 - 0x0000207f (0x80) IX[B]
	[26] -1	0	0x00002400 - 0x000024ff (0x100) IX[B]
	[27] -1	0	0x000018c0 - 0x000018ff (0x40) IX[B]
	[28] -1	0	0x00001c00 - 0x00001cff (0x100) IX[B]
	[29] -1	0	0x00001880 - 0x0000189f (0x20) IX[B]
	[30] -1	0	0x00001860 - 0x0000186f (0x10) IX[B]
	[31] -1	0	0x00001840 - 0x0000185f (0x20) IX[B]
	[32] -1	0	0x00001820 - 0x0000183f (0x20) IX[B]
	[33] -1	0	0x00001800 - 0x0000181f (0x20) IX[B]
	[34] -1	0	0x00003000 - 0x000030ff (0x100) IX[B](B)
	[35] -1	0	0x00009400 - 0x000094ff (0x100) IX[B](B)
(II) Loading sub module "radeon"
(II) LoadModule: "radeon"
(II) Reloading /usr/lib/xorg/modules/drivers/radeon_drv.so
(WW) ****INVALID IO ALLOCATION**** b: 0x9400 e: 0x94ff correcting
(II) window:
	[0] -1	0	0x00004000 - 0x000040ff (0x100) IX[B]
	[1] -1	0	0x00004400 - 0x000044ff (0x100) IX[B]
	[2] -1	0	0x00004800 - 0x000048ff (0x100) IX[B]
	[3] -1	0	0x00004c00 - 0x00004cff (0x100) IX[B]
	[4] -1	0	0x00005000 - 0x000050ff (0x100) IX[B]
	[5] -1	0	0x00005400 - 0x000054ff (0x100) IX[B]
	[6] -1	0	0x00005800 - 0x000058ff (0x100) IX[B]
	[7] -1	0	0x00005c00 - 0x00005cff (0x100) IX[B]
	[8] -1	0	0x00006000 - 0x000060ff (0x100) IX[B]
	[9] -1	0	0x00006400 - 0x000064ff (0x100) IX[B]
	[10] -1	0	0x00006800 - 0x000068ff (0x100) IX[B]
	[11] -1	0	0x00006c00 - 0x00006cff (0x100) IX[B]
	[12] -1	0	0x00007000 - 0x000070ff (0x100) IX[B]
	[13] -1	0	0x00007400 - 0x000074ff (0x100) IX[B]
	[14] -1	0	0x00007800 - 0x000078ff (0x100) IX[B]
	[15] -1	0	0x00007c00 - 0x00007cff (0x100) IX[B]
	[16] -1	0	0x00008000 - 0x000080ff (0x100) IX[B]
	[17] -1	0	0x00008400 - 0x000084ff (0x100) IX[B]
	[18] -1	0	0x00008800 - 0x000088ff (0x100) IX[B]
	[19] -1	0	0x00008c00 - 0x00008cff (0x100) IX[B]
	[20] -1	0	0x00009000 - 0x000090ff (0x100) IX[B]
	[21] -1	0	0x00009400 - 0x000094ff (0x100) IX[B]
	[22] -1	0	0x00009800 - 0x000098ff (0x100) IX[B]
	[23] -1	0	0x00009c00 - 0x00009cff (0x100) IX[B]
(II) resSize:
	[0] -1	0	0x00000000 - 0xffffffff (0x0) IX[B]
(II) window fixed:
	[0] -1	0	0x00004000 - 0x000040ff (0x100) IX[B]
	[1] -1	0	0x00004400 - 0x000044ff (0x100) IX[B]
	[2] -1	0	0x00004800 - 0x000048ff (0x100) IX[B]
	[3] -1	0	0x00004c00 - 0x00004cff (0x100) IX[B]
	[4] -1	0	0x00005000 - 0x000050ff (0x100) IX[B]
	[5] -1	0	0x00005400 - 0x000054ff (0x100) IX[B]
	[6] -1	0	0x00005800 - 0x000058ff (0x100) IX[B]
	[7] -1	0	0x00005c00 - 0x00005cff (0x100) IX[B]
	[8] -1	0	0x00006000 - 0x000060ff (0x100) IX[B]
	[9] -1	0	0x00006400 - 0x000064ff (0x100) IX[B]
	[10] -1	0	0x00006800 - 0x000068ff (0x100) IX[B]
	[11] -1	0	0x00006c00 - 0x00006cff (0x100) IX[B]
	[12] -1	0	0x00007000 - 0x000070ff (0x100) IX[B]
	[13] -1	0	0x00007400 - 0x000074ff (0x100) IX[B]
	[14] -1	0	0x00007800 - 0x000078ff (0x100) IX[B]
	[15] -1	0	0x00007c00 - 0x00007cff (0x100) IX[B]
	[16] -1	0	0x00008000 - 0x000080ff (0x100) IX[B]
	[17] -1	0	0x00008400 - 0x000084ff (0x100) IX[B]
	[18] -1	0	0x00008800 - 0x000088ff (0x100) IX[B]
	[19] -1	0	0x00008c00 - 0x00008cff (0x100) IX[B]
	[20] -1	0	0x00009000 - 0x000090ff (0x100) IX[B]
	[21] -1	0	0x00009400 - 0x000094ff (0x100) IX[B]
	[22] -1	0	0x00009800 - 0x000098ff (0x100) IX[B]
	[23] -1	0	0x00009c00 - 0x00009cff (0x100) IX[B]
Requesting insufficient memory window!: start: 0x4000 end: 0x40ff size 0x31000100
Requesting insufficient memory window!: start: 0x4400 end: 0x44ff size 0x31000100
Requesting insufficient memory window!: start: 0x4800 end: 0x48ff size 0x31000100
Requesting insufficient memory window!: start: 0x4c00 end: 0x4cff size 0x31000100
Requesting insufficient memory window!: start: 0x5000 end: 0x50ff size 0x31000100
Requesting insufficient memory window!: start: 0x5400 end: 0x54ff size 0x31000100
Requesting insufficient memory window!: start: 0x5800 end: 0x58ff size 0x31000100
Requesting insufficient memory window!: start: 0x5c00 end: 0x5cff size 0x31000100
Requesting insufficient memory window!: start: 0x6000 end: 0x60ff size 0x31000100
Requesting insufficient memory window!: start: 0x6400 end: 0x64ff size 0x31000100
Requesting insufficient memory window!: start: 0x6800 end: 0x68ff size 0x31000100
Requesting insufficient memory window!: start: 0x6c00 end: 0x6cff size 0x31000100
Requesting insufficient memory window!: start: 0x7000 end: 0x70ff size 0x31000100
Requesting insufficient memory window!: start: 0x7400 end: 0x74ff size 0x31000100
Requesting insufficient memory window!: start: 0x7800 end: 0x78ff size 0x31000100
Requesting insufficient memory window!: start: 0x7c00 end: 0x7cff size 0x31000100
Requesting insufficient memory window!: start: 0x8000 end: 0x80ff size 0x31000100
Requesting insufficient memory window!: start: 0x8400 end: 0x84ff size 0x31000100
Requesting insufficient memory window!: start: 0x8800 end: 0x88ff size 0x31000100
Requesting insufficient memory window!: start: 0x8c00 end: 0x8cff size 0x31000100
Requesting insufficient memory window!: start: 0x9000 end: 0x90ff size 0x31000100
Requesting insufficient memory window!: start: 0x9400 end: 0x94ff size 0x31000100
Requesting insufficient memory window!: start: 0x9800 end: 0x98ff size 0x31000100
Requesting insufficient memory window!: start: 0x9c00 end: 0x9cff size 0x31000100
(EE) Cannot find a replacement memory range
(II) resource ranges after probing:
	[0] -1	0	0xffe00000 - 0xffffffff (0x200000) MX[B](B)
	[1] -1	0	0x00100000 - 0x2fffffff (0x2ff00000) MX[B]E(B)
	[2] -1	0	0x000f0000 - 0x000fffff (0x10000) MX[B]
	[3] -1	0	0x000c0000 - 0x000effff (0x30000) MX[B]
	[4] -1	0	0x00000000 - 0x0009ffff (0xa0000) MX[B]
	[5] -1	0	0xb0201000 - 0xb0201fff (0x1000) MX[B]
	[6] -1	0	0xb0200000 - 0xb0200fff (0x1000) MX[B]
	[7] -1	0	0xb0202000 - 0xb02027ff (0x800) MX[B]
	[8] -1	0	0xb0000800 - 0xb00008ff (0x100) MX[B]
	[9] -1	0	0xb0000c00 - 0xb0000dff (0x200) MX[B]
	[10] -1	0	0x30000000 - 0x300003ff (0x400) MX[B]
	[11] -1	0	0xb0000000 - 0xb00003ff (0x400) MX[B]
	[12] -1	0	0xd0000000 - 0xcfffffff (0x0) MX[B]O
	[13] -1	0	0xb0100000 - 0xb010ffff (0x10000) MX[B](B)
	[14] -1	0	0xe0000000 - 0xe7ffffff (0x8000000) MX[B](B)
	[15] -1	0	0xc0000000 - 0xc000ffff (0x10000) MX[B](B)
	[16] -1	0	0xf0000000 - 0xf7ffffff (0x8000000) MX[B](B)
	[17] 0	0	0x000a0000 - 0x000affff (0x10000) MS[B]
	[18] 0	0	0x000b0000 - 0x000b7fff (0x8000) MS[B]
	[19] 0	0	0x000b8000 - 0x000bffff (0x8000) MS[B]
	[20] -1	0	0x0000ffff - 0x0000ffff (0x1) IX[B]
	[21] -1	0	0x00000000 - 0x000000ff (0x100) IX[B]
	[22] -1	0	0x00009000 - 0x0000900f (0x10) IX[B]
	[23] -1	0	0x00009010 - 0x00009013 (0x4) IX[B]
	[24] -1	0	0x00009018 - 0x0000901f (0x8) IX[B]
	[25] -1	0	0x00009014 - 0x00009017 (0x4) IX[B]
	[26] -1	0	0x00009020 - 0x00009027 (0x8) IX[B]
	[27] -1	0	0x00008000 - 0x0000803f (0x40) IX[B]
	[28] -1	0	0x00002000 - 0x0000207f (0x80) IX[B]
	[29] -1	0	0x00002400 - 0x000024ff (0x100) IX[B]
	[30] -1	0	0x000018c0 - 0x000018ff (0x40) IX[B]
	[31] -1	0	0x00001c00 - 0x00001cff (0x100) IX[B]
	[32] -1	0	0x00001880 - 0x0000189f (0x20) IX[B]
	[33] -1	0	0x00001860 - 0x0000186f (0x10) IX[B]
	[34] -1	0	0x00001840 - 0x0000185f (0x20) IX[B]
	[35] -1	0	0x00001820 - 0x0000183f (0x20) IX[B]
	[36] -1	0	0x00001800 - 0x0000181f (0x20) IX[B]
	[37] -1	0	0x00003000 - 0x000030ff (0x100) IX[B](B)
	[38] -1	0	0x00009400 - 0x000094ff (0x100) IX[B](B)
	[39] 0	0	0x310003b0 - 0x310003bb (0xc) IS[B]
	[40] 0	0	0x310003c0 - 0x310003df (0x20) IS[B]
(II) Setting vga for screen 0.
(II) RADEON(0): MMIO registers at 0xc0000000
(II) RADEON(0): PCI bus 9 card 0 func 0
(**) RADEON(0): Depth 24, (--) framebuffer bpp 32
(II) RADEON(0): Pixel depth = 24 bits stored in 4 bytes (32 bpp pixmaps)
(==) RADEON(0): Default visual is TrueColor
(**) RADEON(0): Option "EnablePageFlip" "true"
(II) Loading sub module "vgahw"
(II) LoadModule: "vgahw"
(II) Loading /usr/lib/xorg/modules/libvgahw.so
(II) Module vgahw: vendor="X.Org Foundation"
	compiled for 7.0.0, module version = 0.1.0
	ABI class: X.Org Video Driver, version 0.8
(II) RADEON(0): vgaHWGetIOBase: hwp->IOBase is 0x03b0, hwp->PIOOffset is 0x0000
(==) RADEON(0): RGB weight 888
(II) RADEON(0): Using 8 bits per RGB (8 bit DAC)
(II) Loading sub module "int10"
(II) LoadModule: "int10"
(II) Loading /usr/lib/xorg/modules/libint10.so
(II) Module int10: vendor="X.Org Foundation"
	compiled for 7.0.0, module version = 1.0.0
	ABI class: X.Org Video Driver, version 0.8
(II) RADEON(0): initializing int10
Requesting insufficient memory window!: start: 0xe8000000 end: 0xf7ffffff size 0x31020000
Requesting insufficient memory window!: start: 0xb8000000 end: 0xbbffffff size 0x31020000
Requesting insufficient memory window!: start: 0xe8000000 end: 0xf7ffffff size 0x31020000
Requesting insufficient memory window!: start: 0xb8000000 end: 0xbbffffff size 0x31020000
Requesting insufficient memory window!: start: 0xe8000000 end: 0xf7ffffff size 0x31020000
Requesting insufficient memory window!: start: 0xb8000000 end: 0xbbffffff size 0x31020000
(EE) RADEON(0): Cannot read V_BIOS
(--) RADEON(0): Chipset: "ATI Radeon 7500 QW (AGP/PCI)" (ChipID = 0x5157)
(--) RADEON(0): Linear framebuffer at 0xf0000000
(--) RADEON(0): VideoRAM: 8192 kByte (64 bit SDR SDRAM)
(II) RADEON(0): PCI card detected
(II) RADEON(0): Color tiling enabled by default
(II) Loading sub module "ddc"
(II) LoadModule: "ddc"
(II) Loading /usr/lib/xorg/modules/libddc.so
(II) Module ddc: vendor="X.Org Foundation"
	compiled for 7.0.0, module version = 1.0.0
	ABI class: X.Org Video Driver, version 0.8
(II) Loading sub module "i2c"
(II) LoadModule: "i2c"
(II) Loading /usr/lib/xorg/modules/libi2c.so
(II) Module i2c: vendor="X.Org Foundation"
	compiled for 7.0.0, module version = 1.2.0
	ABI class: X.Org Video Driver, version 0.8
(II) RADEON(0): I2C bus "DDC" initialized.
Requesting insufficient memory window!: start: 0xe8000000 end: 0xf7ffffff size 0x31020000
Requesting insufficient memory window!: start: 0xb8000000 end: 0xbbffffff size 0x31020000
Requesting insufficient memory window!: start: 0xe8000000 end: 0xf7ffffff size 0x31020000
Requesting insufficient memory window!: start: 0xb8000000 end: 0xbbffffff size 0x31020000
(WW) RADEON(0): Video BIOS not detected in PCI space!
(WW) RADEON(0): Attempting to read Video BIOS from legacy ISA space!
(II) RADEON(0): Legacy BIOS detected


... X struggles on and tries to start, but can't actually display anything.
I noticed the references to try pci=assign-busses, so I did that. The bus
numbers for the devices in the dock changed from 9 to 11, but otherwise the
error messages were the same. Here is the dmesg from using pci=assign-busses:


Linux version 2.6.17-git25 (andrewb@desiato) (gcc version 4.1.1 20060525 (Red Hat 4.1.1-1)) #1 Thu Jul 6 11:00:29 EST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff60000 (usable)
 BIOS-e820: 000000001ff60000 - 000000001ff77000 (ACPI data)
 BIOS-e820: 000000001ff77000 - 000000001ff79000 (ACPI NVS)
 BIOS-e820: 000000001ff80000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
On node 0 totalpages: 130912
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 126816 pages, LIFO batch:31
DMI present.
ACPI: RSDP (v002 IBM                                   ) @ 0x000f6d70
ACPI: XSDT (v001 IBM    TP-1Q    0x00003020  LTP 0x00000000) @ 0x1ff69e78
ACPI: FADT (v003 IBM    TP-1Q    0x00003020 IBM  0x00000001) @ 0x1ff69f00
ACPI: SSDT (v001 IBM    TP-1Q    0x00003020 MSFT 0x0100000e) @ 0x1ff6a0b4
ACPI: ECDT (v001 IBM    TP-1Q    0x00003020 IBM  0x00000001) @ 0x1ff76e11
ACPI: TCPA (v001 IBM    TP-1Q    0x00003020 PTL  0x00000001) @ 0x1ff76e63
ACPI: BOOT (v001 IBM    TP-1Q    0x00003020  LTP 0x00000001) @ 0x1ff76fd8
ACPI: DSDT (v001 IBM    TP-1Q    0x00003020 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
Allocating PCI resources starting at 30000000 (gap: 20000000:df800000)
Detected 1298.960 MHz processor.
Built 1 zonelists.  Total pages: 130912
Kernel command line: ro root=LABEL=/ pci=assign-busses single
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (0140e000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c04c5000 soft=c04c4000
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour VGA+ 80x25
Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
... MAX_LOCKDEP_SUBCLASSES:    8
... MAX_LOCK_DEPTH:          30
... MAX_LOCKDEP_KEYS:        2048
... CLASSHASH_SIZE:           1024
... MAX_LOCKDEP_ENTRIES:     8192
... MAX_LOCKDEP_CHAINS:      8192
... CHAINHASH_SIZE:          4096
 memory used by lock dependency info: 696 kB
 per task-struct memory footprint: 1200 bytes
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 511928k/523648k available (2009k kernel code, 11112k reserved, 1136k data, 216k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 2600.04 BogoMIPS (lpj=5200083)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: a7e9f9bf 00000000 00000000 00000000 00000180 00000000 00000000
CPU: After vendor identify, caps: a7e9f9bf 00000000 00000000 00000000 00000180 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU: After all inits, caps: a7e9f9bf 00000000 00000000 00000040 00000180 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Compat vDSO mapped to ffffe000.
CPU: Intel(R) Pentium(R) M processor 1300MHz stepping 05
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060623
ACPI: setting ELCR to 0200 (from 0800)
checking if image is initramfs... it is
Freeing initrd memory: 913k freed
PM: Adding info for No Bus:platform
NET: Registered protocol family 16
ACPI: ACPI Dock Station Driver 
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd8d6, last bus=15
Setting up standard PCI resources
ACPI: Found ECDT
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
PM: Adding info for acpi:acpi
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 *11)
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PM: Adding info for No Bus:pci0000:00
PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
PCI: Found IBM Dock II Cardbus Bridge applying quirk
PCI: Found IBM Dock II Cardbus Bridge applying quirk
PCI: Transparent bridge - 0000:02:03.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
PM: Adding info for pci:0000:00:00.0
PM: Adding info for pci:0000:00:01.0
PM: Adding info for pci:0000:00:1d.0
PM: Adding info for pci:0000:00:1d.1
PM: Adding info for pci:0000:00:1d.2
PM: Adding info for pci:0000:00:1d.7
PM: Adding info for pci:0000:00:1e.0
PM: Adding info for pci:0000:00:1f.0
PM: Adding info for pci:0000:00:1f.1
PM: Adding info for pci:0000:00:1f.3
PM: Adding info for pci:0000:00:1f.5
PM: Adding info for pci:0000:00:1f.6
PM: Adding info for pci:0000:01:00.0
PM: Adding info for pci:0000:02:00.0
PM: Adding info for pci:0000:02:00.1
PM: Adding info for pci:0000:02:00.2
PM: Adding info for pci:0000:02:02.0
PM: Adding info for pci:0000:02:03.0
PM: Adding info for pci:0000:02:08.0
PM: Adding info for pci:0000:0b:00.0
PM: Adding info for pci:0000:0b:01.0
PM: Adding info for pci:0000:0b:02.0
PM: Adding info for pci:0000:0b:02.1
ACPI: Embedded Controller [EC] (gpe 28) interrupt mode.
ACPI: Power Resource [PUBS] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGP_._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1.DOCK._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
PM: Adding info for No Bus:pnp0
PM: Adding info for pnp:00:00
PM: Adding info for pnp:00:01
PM: Adding info for pnp:00:02
PM: Adding info for pnp:00:03
PM: Adding info for pnp:00:04
PM: Adding info for pnp:00:05
PM: Adding info for pnp:00:06
PM: Adding info for pnp:00:07
PM: Adding info for pnp:00:08
PM: Adding info for pnp:00:09
PM: Adding info for pnp:00:0a
PM: Adding info for pnp:00:0b
pnp: PnP ACPI: found 12 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Cannot allocate resource region 7 of bridge 0000:02:03.0
PCI: Cannot allocate resource region 8 of bridge 0000:02:03.0
PCI: Cannot allocate resource region 9 of bridge 0000:02:03.0
PCI: Cannot allocate resource region 0 of device 0000:02:00.0
PCI: Bridge: 0000:00:01.0
  IO window: 3000-3fff
  MEM window: b0100000-b01fffff
  PREFETCH window: e0000000-e7ffffff
PCI: Bus 3, cardbus bridge: 0000:02:00.0
  IO window: 00005000-000050ff
  IO window: 00005400-000054ff
  PREFETCH window: e8000000-e9ffffff
  MEM window: b4000000-b5ffffff
PCI: Bus 7, cardbus bridge: 0000:02:00.1
  IO window: 00005800-000058ff
  IO window: 00005c00-00005cff
  PREFETCH window: ea000000-ebffffff
  MEM window: b6000000-b7ffffff
PCI: Bus 12, cardbus bridge: 0000:0b:02.0
  IO window: 00004000-000040ff
  IO window: 00004400-000044ff
  PREFETCH window: 32000000-33ffffff
  MEM window: b8000000-b9ffffff
PCI: Bus 16, cardbus bridge: 0000:0b:02.1
  IO window: 00004800-000048ff
  IO window: 00004c00-00004cff
  PREFETCH window: 34000000-35ffffff
  MEM window: ba000000-bbffffff
PCI: Bridge: 0000:02:03.0
  IO window: 4000-4fff
  MEM window: b8000000-bbffffff
  PREFETCH window: 31000000-35ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 4000-9fff
  MEM window: b0200000-c00fffff
  PREFETCH window: e8000000-f7ffffff


Finally, here is lspci output (with assign-busses used). Note that 0b:00.0
(the radeon card in the dock) has its resources disabled.


00:00.0 Host bridge: Intel Corporation 82855PM Processor to I/O Controller (rev 03)
	Subsystem: IBM Unknown device 0529
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [e4] Vendor Specific Information
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=x1

00:01.0 PCI bridge: Intel Corporation 82855PM Processor to AGP Controller (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 96
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: b0100000-b01fffff
	Prefetchable memory behind bridge: e0000000-e7ffffff
	Secondary status: 66MHz+ FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 01) (prog-if 00 [UHCI])
	Subsystem: IBM Unknown device 052d
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 4: I/O ports at 1800 [size=32]

00:1d.1 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 01) (prog-if 00 [UHCI])
	Subsystem: IBM Unknown device 052d
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 11
	Region 4: I/O ports at 1820 [size=32]

00:1d.2 USB Controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 01) (prog-if 00 [UHCI])
	Subsystem: IBM Unknown device 052d
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 11
	Region 4: I/O ports at 1840 [size=32]

00:1d.7 USB Controller: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) USB2 EHCI Controller (rev 01) (prog-if 20 [EHCI])
	Subsystem: IBM Unknown device 052e
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 11
	Region 0: Memory at b0000000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [58] Debug port

00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev 81) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 0
	Bus: primary=00, secondary=02, subordinate=13, sec-latency=64
	I/O behind bridge: 00004000-00009fff
	Memory behind bridge: b0200000-c00fffff
	Prefetchable memory behind bridge: e8000000-f7ffffff
	Secondary status: 66MHz- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corporation 82801DBM (ICH4-M) LPC Interface Bridge (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:1f.1 IDE interface: Intel Corporation 82801DBM (ICH4-M) IDE Controller (rev 01) (prog-if 8a [Master SecP PriP])
	Subsystem: IBM Unknown device 052d
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at 1860 [size=16]
	Region 5: Memory at 30000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) SMBus Controller (rev 01)
	Subsystem: IBM Unknown device 052d
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin B routed to IRQ 11
	Region 4: I/O ports at 1880 [size=32]

00:1f.5 Multimedia audio controller: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
	Subsystem: IBM Unknown device 0534
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 11
	Region 0: I/O ports at 1c00 [size=256]
	Region 1: I/O ports at 18c0 [size=64]
	Region 2: Memory at b0000c00 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at b0000800 (32-bit, non-prefetchable) [size=256]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1f.6 Modem: Intel Corporation 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) AC'97 Modem Controller (rev 01) (prog-if 00 [Generic])
	Subsystem: IBM Unknown device 0524
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 11
	Region 0: I/O ports at 2400 [size=256]
	Region 1: I/O ports at 2000 [size=128]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M6 LY (prog-if 00 [VGA])
	Subsystem: IBM Unknown device 052f
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR+ FastB2B+
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), Cache Line Size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 3000 [size=256]
	Region 2: Memory at b0100000 (32-bit, non-prefetchable) [size=64K]
	[virtual] Expansion ROM at b0120000 [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:00.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev aa)
	Subsystem: IBM Unknown device 0532
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at b0203000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
	Memory window 0: e8000000-e9fff000 (prefetchable)
	Memory window 1: b4000000-b5fff000
	I/O window 0: 00005000-000050ff
	I/O window 1: 00005400-000054ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

02:00.1 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev aa)
	Subsystem: IBM Unknown device 0532
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at b1000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
	Memory window 0: ea000000-ebfff000 (prefetchable)
	Memory window 1: b6000000-b7fff000
	I/O window 0: 00005800-000058ff
	I/O window 1: 00005c00-00005cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

02:00.2 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller (rev 02) (prog-if 10 [OHCI])
	Subsystem: IBM Unknown device 0533
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin C routed to IRQ 11
	Region 0: Memory at b0202000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME+

02:02.0 Network controller: Intel Corporation PRO/Wireless LAN 2100 3B Mini PCI Adapter (rev 04)
	Subsystem: Intel Corporation Unknown device 2551
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 8500ns max), Cache Line Size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at b0200000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-

02:03.0 PCI bridge: Texas Instruments PCI2032 PCI Docking Bridge (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, Cache Line Size 08
	Bus: primary=02, secondary=0b, subordinate=13, sec-latency=68
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: b8000000-bbffffff
	Prefetchable memory behind bridge: 31000000-35ffffff
	Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
		Bridge: PM- B3+

02:08.0 Ethernet controller: Intel Corporation 82801DB PRO/100 VE (MOB) Ethernet Controller (rev 81)
	Subsystem: IBM Unknown device 0522
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min, 14000ns max), Cache Line Size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at b0201000 (32-bit, non-prefetchable) [size=4K]
	Region 1: I/O ports at 8000 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

0b:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV200 QW [Radeon 7500] (prog-if 00 [VGA])
	Subsystem: C.P. Technology Co. Ltd RV200 QW [Radeon 7500 PCI Dual Display]
	Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), Cache Line Size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at f0000000 (32-bit, prefetchable) [disabled] [size=128M]
	Region 1: I/O ports at 9400 [disabled] [size=256]
	Region 2: Memory at c0000000 (32-bit, non-prefetchable) [disabled] [size=64K]
	[virtual] Expansion ROM at 31000000 [disabled] [size=128K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0b:01.0 IDE interface: Silicon Image, Inc. PCI0648 (rev 01) (prog-if 8f [Master SecP SecO PriP PriO])
	Subsystem: Silicon Image, Inc. PCI0648
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 9020 [size=8]
	Region 1: I/O ports at 9014 [size=4]
	Region 2: I/O ports at 9018 [size=8]
	Region 3: I/O ports at 9010 [size=4]
	Region 4: I/O ports at 9000 [size=16]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=3 PME-

0b:02.0 CardBus bridge: Texas Instruments PCI1420
	Subsystem: IBM Unknown device 0148
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size 20
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at b2000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=0b, secondary=0c, subordinate=0f, sec-latency=176
	Memory window 0: 32000000-33fff000 (prefetchable)
	Memory window 1: b8000000-b9fff000
	I/O window 0: 00004000-000040ff
	I/O window 1: 00004400-000044ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

0b:02.1 CardBus bridge: Texas Instruments PCI1420
	Subsystem: IBM Unknown device 0148
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168, Cache Line Size 20
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at b3000000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=0b, secondary=10, subordinate=13, sec-latency=176
	Memory window 0: 34000000-35fff000 (prefetchable)
	Memory window 1: ba000000-bbfff000
	I/O window 0: 00004800-000048ff
	I/O window 1: 00004c00-00004cff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001


Here are the (hopefully relevant) parts of my .config:

#
# Bus options (PCI, PCMCIA, EISA, MCA, ISA)
#
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GOMMCONFIG is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCIEPORTBUS=y
CONFIG_HOTPLUG_PCI_PCIE=m
# CONFIG_HOTPLUG_PCI_PCIE_POLL_EVENT_MODE is not set
CONFIG_PCI_MSI=y
# CONFIG_PCI_DEBUG is not set
CONFIG_ISA_DMA_API=y
CONFIG_ISA=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
# CONFIG_SCx200 is not set
CONFIG_K8_NB=y

#
# PCI Hotplug Support
#
CONFIG_HOTPLUG_PCI=y
# CONFIG_HOTPLUG_PCI_FAKE is not set
CONFIG_HOTPLUG_PCI_COMPAQ=m
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
CONFIG_HOTPLUG_PCI_IBM=m
CONFIG_HOTPLUG_PCI_ACPI=m
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
# CONFIG_HOTPLUG_PCI_CPCI is not set
# CONFIG_HOTPLUG_PCI_SHPC is not set


I hope someone is able to make something of this. I've also tried booting
with other pci= options, including bios, conf1, conf2, nommconf, and noacpi,
but this didn't help. I had a report from the previous owner of the dock
that it worked for them, however they were using an older version of Linux
(probably 2.4) with APM. I have tried using a PCMCIA card in the dock's
cardbus slot, and that works.

Please let me know if you need more info, and please CC me as I am not on
linux-kernel.

Thanks,
Andrew
