Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750830AbVIJN0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbVIJN0n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 09:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbVIJN0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 09:26:43 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:61591 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S1750830AbVIJN0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 09:26:42 -0400
Message-ID: <4322DF10.9080204@vc.cvut.cz>
Date: Sat, 10 Sep 2005 15:26:40 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: clameter@engr.sgi.com
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: BUG at mm/slab.c:662 - current 2.6.13-git (commit 87fc...) crashes
 on x86-64
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christoph,
   I'm not 100% sure yet that your NUMA V5 change is responsible for that, but 
my single processor Amd64 box commits suicide on boot, saying that somebody 
called kmem_find_general_cachep without first initializing caches.  Stack trace is:

kmem_find_general_cachep + 17  (BUG at mm/slab.c:662)
kmalloc_node + 23              (mm/slab.c:2870)
kmem_cache_create + 1840       (mm/slab.c:1764)
kmem_cache_init + 737          (mm/slab.c:1081)
start_kernel + 261
x86_64_start_kernel + 361

Box has single processor with one core, so I'm rather surprised.  Messages from 
~week old kernel are below.  If you want messages from this kernel, I'll have to 
resurrect console on parallel printer port and then write messages down from 
paper :-(  Kernel is SMP, with K8 NUMA support, with Discontigiuous memory.
						Thanks,
							Petr Vandrovec


Bootdata ok (command line is BOOT_IMAGE=2.6.13-f505-64 ro root=807 
video=matroxfb:vesa:0x11E,left:64,right:8,hslen:88,upper:32,lower:1,vslen:2 
nmi_watchdog=1 devfs=nomount)
Linux version 2.6.13-f505 (root@ppc) (gcc version 3.3.3 (Debian 20040401)) #2 
SMP Sat Sep 3 20:20:54 CEST 2005
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000007ffb0000 (usable)
  BIOS-e820: 000000007ffb0000 - 000000007ffc0000 (ACPI data)
  BIOS-e820: 000000007ffc0000 - 000000007fff0000 (ACPI NVS)
  BIOS-e820: 000000007fff0000 - 0000000080000000 (reserved)
  BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
ACPI: RSDP (v002 ACPIAM                                ) @ 0x00000000000fa7c0
ACPI: XSDT (v001 A M I  OEMXSDT  0x06000530 MSFT 0x00000097) @ 0x000000007ffb0100
ACPI: FADT (v003 A M I  OEMFACP  0x06000530 MSFT 0x00000097) @ 0x000000007ffb0290
ACPI: MADT (v001 A M I  OEMAPIC  0x06000530 MSFT 0x00000097) @ 0x000000007ffb0390
ACPI: OEMB (v001 A M I  OEMBIOS  0x06000530 MSFT 0x00000097) @ 0x000000007ffc0040
ACPI: DSDT (v001  A0036 A0036001 0x00000001 MSFT 0x0100000d) @ 0x0000000000000000
Scanning NUMA topology in Northbridge 24
Number of nodes 1
Node 0 MemBase 0000000000000000 Limit 000000007ffb0000
Using 24 for the hash shift. Max adder is 7ffb0000
Using node hash shift of 24
Bootmem setup node 0 0000000000000000-000000007ffb0000
On node 0 totalpages: 524111
   DMA zone: 3999 pages, LIFO batch:1
   Normal zone: 520112 pages, LIFO batch:31
   HighMem zone: 0 pages, LIFO batch:1
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:15 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x81] disabled)
ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 1, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 80000000 (gap: 80000000:7f780000)
Checking aperture...
CPU 0: aperture @ d0000000 size 256 MB
Built 1 zonelists
Kernel command line: BOOT_IMAGE=2.6.13-f505-64 ro root=807 
video=matroxfb:vesa:0x11E,left:64,right:8,hslen:88,upper:32,lower:1,vslen:2 
nmi_watchdog=1 devfs=nomount
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 2002.659 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Memory: 2056016k/2096832k available (2449k kernel code, 0k reserved, 2177k data, 
228k init)
Calibrating delay using timer specific routine.. 4012.73 BogoMIPS (lpj=20063666)

