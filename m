Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946033AbWJaV2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946033AbWJaV2M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 16:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946036AbWJaV2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 16:28:12 -0500
Received: from moci.net4u.de ([217.7.64.195]:1485 "EHLO moci.net4u.de")
	by vger.kernel.org with ESMTP id S1946033AbWJaV2I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 16:28:08 -0500
From: Ernst Herzberg <list-lkml@net4u.de>
Reply-To: earny@net4u.de
To: linux-kernel@vger.kernel.org
Subject: 2.6.19-rc[1-4]: boot fail with (lapic && on_battery)
Date: Tue, 31 Oct 2006 22:27:54 +0100
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610312227.54617.list-lkml@net4u.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Moin.

With 2.6.18.x everything works fine.

But 2.16.19-rc does not boot if the laptop runs on battery _and_ lapic is 
defined as boot parameter.

The kernel loads and starts, for a fraction of a second some messages appears,
then the screen goes blank and nothing more happens.

I'm unable to read the last message, screen blanking is to fast, but the
'picture' looks like that he stops near the messages where at the normal
boot demsg "Local APIC disabled by BIOS -- you can enable it with "lapic""
appears. 

Netconsole is not started at this point, and the laptop doesn't have a 
serial port.

dmesg on_battery without lpapic:

Linux version 2.6.19-rc4 (root@halso) (gcc version 4.1.1 (Gentoo 4.1.1)) #1 PREEMPT Tue Oct 31 21:42:25 CET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f000 (usable)
 BIOS-e820: 000000000009f000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d2000 - 00000000000d4000 (reserved)
 BIOS-e820: 00000000000dc000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ff50000 (usable)
 BIOS-e820: 000000003ff50000 - 000000003ff67000 (ACPI data)
 BIOS-e820: 000000003ff67000 - 000000003ff79000 (ACPI NVS)
 BIOS-e820: 000000003ff80000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ff800000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
Entering add_active_range(0, 0, 261968) 0 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  Normal       4096 ->   229376
  HighMem    229376 ->   261968
early_node_map[1] active PFN ranges
    0:        0 ->   261968
On node 0 totalpages: 261968
  DMA zone: 32 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 4064 pages, LIFO batch:0
  Normal zone: 1760 pages used for memmap
  Normal zone: 223520 pages, LIFO batch:31
  HighMem zone: 254 pages used for memmap
  HighMem zone: 32338 pages, LIFO batch:7
DMI present.
ACPI: RSDP (v002 IBM                                   ) @ 0x000f6d70
ACPI: XSDT (v001 IBM    TP-1R    0x00003210  LTP 0x00000000) @ 0x3ff5a6bd
ACPI: FADT (v003 IBM    TP-1R    0x00003210 IBM  0x00000001) @ 0x3ff5a800
ACPI: SSDT (v001 IBM    TP-1R    0x00003210 MSFT 0x0100000e) @ 0x3ff5a9b4
ACPI: ECDT (v001 IBM    TP-1R    0x00003210 IBM  0x00000001) @ 0x3ff66ecc
ACPI: TCPA (v001 IBM    TP-1R    0x00003210 PTL  0x00000001) @ 0x3ff66f1e
ACPI: BOOT (v001 IBM    TP-1R    0x00003210  LTP 0x00000001) @ 0x3ff66fd8
ACPI: DSDT (v001 IBM    TP-1R    0x00003210 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
Allocating PCI resources starting at 50000000 (gap: 40000000:bf800000)
Detected 598.086 MHz processor.
Built 1 zonelists.  Total pages: 259922
Kernel command line: root=/dev/sda4 netconsole=4444@217.7.64.201/eth0,6666@217.7.64.224/00:30:1B:B2:40:0C
netconsole: local port 4444
netconsole: local IP 217.7.64.201
netconsole: interface eth0
netconsole: remote port 6666
netconsole: remote IP 217.7.64.224
netconsole: remote ethernet address 00:30:1b:b2:40:0c
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01803000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c0468000 soft=c0467000
PID hash table entries: 4096 (order: 12, 16384 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1034196k/1047872k available (2498k kernel code, 13064k reserved, 772k data, 188k init, 130368k highmem)
virtual kernel memory layout:
    fixmap  : 0xfffaa000 - 0xfffff000   ( 340 kB)
    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
      .init : 0xc0433000 - 0xc0462000   ( 188 kB)
      .data : 0xc0370837 - 0xc0431994   ( 772 kB)
      .text : 0xc0100000 - 0xc0370837   (2498 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1196.94 BogoMIPS (lpj=5984714)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: a7e9f9bf 00000000 00000000 00000000 00000180 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU: After all inits, caps: a7e9f9bf 00000000 00000000 00000040 00000180 00000000 00000000
[..... and so on ....]


diff to on_ac with lapic:

--- dm_batt     2006-10-31 21:53:36.000000000 +0100
+++ dm_pwr      2006-10-31 22:15:42.000000000 +0100
@@ -37,17 +37,18 @@
 ACPI: DSDT (v001 IBM    TP-1R    0x00003210 MSFT 0x0100000e) @ 0x00000000
 ACPI: PM-Timer IO Port: 0x1008
 Allocating PCI resources starting at 50000000 (gap: 40000000:bf800000)
-Detected 598.086 MHz processor.
+Detected 1694.558 MHz processor.
 Built 1 zonelists.  Total pages: 259922
-Kernel command line: root=/dev/sda4 netconsole=4444@217.7.64.201/eth0,6666@217.7.64.224/00:30:1B:B2:40:0C
+Kernel command line: root=/dev/sda4 lapic netconsole=4444@217.7.64.201/eth0,6666@217.7.64.224/00:30:1B:B2:40:0C
 netconsole: local port 4444
 netconsole: local IP 217.7.64.201
 netconsole: interface eth0
 netconsole: remote port 6666
 netconsole: remote IP 217.7.64.224
 netconsole: remote ethernet address 00:30:1b:b2:40:0c
-Local APIC disabled by BIOS -- you can enable it with "lapic"
-mapped APIC to ffffd000 (01803000)
+Local APIC disabled by BIOS -- reenabling.
+Found and enabled local APIC!
+mapped APIC to ffffd000 (fee00000)
 Enabling fast FPU save and restore... done.
 Enabling unmasked SIMD FPU exception support... done.
 Initializing CPU#0
@@ -56,7 +57,7 @@
 Console: colour VGA+ 80x25
 Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
 Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
-Memory: 1034196k/1047872k available (2498k kernel code, 13064k reserved, 772k data, 188k init, 130368k highmem)
+Memory: 1034196k/1047872k available (2498k kernel code, 13060k reserved, 772k data, 188k init, 130368k highmem)
 virtual kernel memory layout:
     fixmap  : 0xfffaa000 - 0xfffff000   ( 340 kB)
     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
@@ -66,12 +67,12 @@
       .data : 0xc0370837 - 0xc0431994   ( 772 kB)
       .text : 0xc0100000 - 0xc0370837   (2498 kB)
 Checking if this processor honours the WP bit even in supervisor mode... Ok.
-Calibrating delay using timer specific routine.. 1196.94 BogoMIPS (lpj=5984714)
+Calibrating delay using timer specific routine.. 3390.66 BogoMIPS (lpj=16953345)
 Mount-cache hash table entries: 512
-CPU: After generic identify, caps: a7e9f9bf 00000000 00000000 00000000 00000180 00000000 00000000
+CPU: After generic identify, caps: a7e9fbbf 00000000 00000000 00000000 00000180 00000000 00000000
 CPU: L1 I cache: 32K, L1 D cache: 32K
 CPU: L2 cache: 1024K
-CPU: After all inits, caps: a7e9f9bf 00000000 00000000 00000040 00000180 00000000 00000000
+CPU: After all inits, caps: a7e9fbbf 00000000 00000000 00000040 00000180 00000000 00000000
[...]

Patches welcome;)

<earny>

