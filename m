Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbTFAHFq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 03:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbTFAHFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 03:05:46 -0400
Received: from ifup.net ([217.160.130.191]:49587 "HELO sit0.ifup.net")
	by vger.kernel.org with SMTP id S261450AbTFAHFo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 03:05:44 -0400
Date: Sun, 1 Jun 2003 09:19:07 +0200
From: Karsten Desler <kdesler@soohrt.org>
To: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: OOPS: 2.4.21-rc6 NULL pointer dereference at boot
Message-ID: <20030601071907.GA13041@sit0.ifup.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

after running 2.4.20-ac2 for quite some time, I wanted to give
2.4.21-rc6 a try, but I got the following OOPS (copied by hand).
I tried noapic/apic with the same result.

The Mainboard is a EPOX 8K5A3+ with 2 HPT374 controllers onboard, the
RAM is memtested.
lspci -v is attached beneath and I can provide more information if needed.

pikelot:~# ksymoops oops.txt -o /lib/modules/2.4.21-rc6 -m /boot/System.map -KL
ksymoops 2.4.8 on i686 2.4.20-ac2.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.21-rc6 (specified)
     -m /boot/System.map (specified)

No modules in ksyms, skipping objects
*pde = 00000000
CPU:    0
EIP:    0010:[<c01b7c39>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010292
eax:    0000000c   ebx: 00000051     ecx: 0000000c       edx: 00000000
esi:    30070000   edi: 00000000     ebp: c1593400       esp: c159bf10
ds: 0018        es: 0018       ss: 0018
Stack:  c01b7b8a 0000000c 00000000 00000000 0c400008 00000000 00000008 c1593400
	c0309358 00000000 00000001 c01b8049 c0309358 0000000c 0c000005 c0309358
	c03092a8 c01baf95 c0309358 0000000c 00000246 00000002 c03092a8 c0105000
Call Trace: [<c01b7b8a>] [<c01b8049>] [<c01baf95>] [<c0105000>] [<c01bbb38>]
            [<c0105053>] [<c0105000>] [<c0105040>]
Code: 0f b6 02 84 c0 74 0e 38 c8 74 0a 83 c2 08 0f b6 02 84 c0 75


>>EIP; c01b7c39 <pci_bus_clock_list+9/30>   <=====

Trace; c01b7b8a <hpt3xx_ratefilter+16a/170>
Trace; c01b8049 <hpt3xx_tune_chipset+49/100>
Trace; c01baf95 <probe_hwif+1c5/2b0>
Trace; c0105000 <_stext+0/0>
Trace; c01bbb38 <ideprobe_init+b8/c0>
Trace; c0105053 <init+13/130>
Trace; c0105000 <_stext+0/0>
Trace; c0105040 <init+0/130>

Code;  c01b7c39 <pci_bus_clock_list+9/30>
00000000 <_EIP>:
Code;  c01b7c39 <pci_bus_clock_list+9/30>   <=====
   0:   0f b6 02                  movzbl (%edx),%eax   <=====
Code;  c01b7c3c <pci_bus_clock_list+c/30>
   3:   84 c0                     test   %al,%al
Code;  c01b7c3e <pci_bus_clock_list+e/30>
   5:   74 0e                     je     15 <_EIP+0x15>
Code;  c01b7c40 <pci_bus_clock_list+10/30>
   7:   38 c8                     cmp    %cl,%al
Code;  c01b7c42 <pci_bus_clock_list+12/30>
   9:   74 0a                     je     15 <_EIP+0x15>
Code;  c01b7c44 <pci_bus_clock_list+14/30>
   b:   83 c2 08                  add    $0x8,%edx
Code;  c01b7c47 <pci_bus_clock_list+17/30>
   e:   0f b6 02                  movzbl (%edx),%eax
Code;  c01b7c4a <pci_bus_clock_list+1a/30>
  11:   84 c0                     test   %al,%al
Code;  c01b7c4c <pci_bus_clock_list+1c/30>
  13:   75 00                     jne    15 <_EIP+0x15>


00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Memory at e4000000 (32-bit, prefetchable) [size=16M]
        Capabilities: [a0] AGP version 2.0
        Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP] (prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, medium devsel, latency 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        Capabilities: [80] Power Management version 2

00:08.0 VGA compatible controller: S3 Inc. 86c764/765 [Trio32/64/64V+] (rev 54) (prog-if 00 [VGA])
        Flags: VGA palette snoop, medium devsel, IRQ 16
        Memory at e0000000 (32-bit, non-prefetchable) [size=64M]
        Expansion ROM at <unassigned> [disabled] [size=64K]

00:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Flags: bus master, medium devsel, latency 32, IRQ 18
        I/O ports at 9000 [size=256]
        Memory at e6000000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [50] Power Management version 2

00:0e.0 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
        Subsystem: Triones Technologies, Inc.: Unknown device 0001
        Flags: bus master, 66Mhz, medium devsel, latency 120, IRQ 17
        I/O ports at 9400 [size=8]
        I/O ports at 9800 [size=4]
        I/O ports at 9c00 [size=8]
        I/O ports at a000 [size=4]
        I/O ports at a400 [size=256]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [60] Power Management version 2

00:0e.1 RAID bus controller: Triones Technologies, Inc. HPT374 (rev 07)
        Subsystem: Triones Technologies, Inc.: Unknown device 0001
        Flags: bus master, 66Mhz, medium devsel, latency 120, IRQ 17
        I/O ports at a800 [size=8]
        I/O ports at ac00 [size=4]
        I/O ports at b000 [size=8]
        I/O ports at b400 [size=4]
        I/O ports at b800 [size=256]
        Capabilities: [60] Power Management version 2

00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
        Subsystem: VIA Technologies, Inc. VT8235 ISA Bridge
        Flags: bus master, stepping, medium devsel, latency 0
        Capabilities: [c0] Power Management version 2

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. VT8235 Bus Master ATA133/100/66/33 IDE
        Flags: bus master, medium devsel, latency 32, IRQ 16
        I/O ports at c800 [size=16]
        Capabilities: [c0] Power Management version 2

Thanks in advance,
 Karsten
