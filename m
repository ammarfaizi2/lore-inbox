Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262035AbTCRAjC>; Mon, 17 Mar 2003 19:39:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262052AbTCRAjC>; Mon, 17 Mar 2003 19:39:02 -0500
Received: from holomorphy.com ([66.224.33.161]:39132 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262035AbTCRAiZ> convert rfc822-to-8bit;
	Mon, 17 Mar 2003 19:38:25 -0500
Date: Mon, 17 Mar 2003 16:48:50 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Manfred Spraul <manfred@colorfullife.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] O(1) proc_pid_readdir
Message-ID: <20030318004850.GT20188@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Manfred Spraul <manfred@colorfullife.com>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
References: <20030316213516.GM20188@holomorphy.com> <Pine.LNX.4.44.0303170719410.15476-100000@localhost.localdomain> <20030317070334.GO20188@holomorphy.com> <3E761124.8060402@colorfullife.com> <20030318001405.GS20188@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20030318001405.GS20188@holomorphy.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>>> The NMI oopses are mostly decoded by hand b/c in-kernel (and other)
>>> backtrace decoders can't do it automatically. I might have to generate
>>> some fresh data, with some kind of hack (e.g. hand-coded NMI-based kind
>>> of smp_call_function) to trace the culprit and not just the victim.
>>> The victims were usually stuck in fork() or exit().

On Mon, Mar 17, 2003 at 07:17:08PM +0100, Manfred Spraul wrote:
>> Could you check if the attached test app triggers the NMI oopser?

On Mon, Mar 17, 2003 at 04:14:05PM -0800, William Lee Irwin III wrote:
> Sure, no problem.

Gee, this is bright. I think I remember why I haven't done testing of
tasklist_lock NMI oopses for several releases now.


Script started on Mon Mar 17 16:38:13 2003
$ sscreen -x
[?1049h[r[H[?7h[?1;4;6l[4l[?1h=(B[1;24r[H[H   lists possible command completions.  Anywhere else TAB lists the possible   
completions of a device/filename.  ESC at any time exits. ]

grub> dhcp
Found Digital Tulip Fast at 0xf880, ROM address 0x0000
Probing...[Digital Tulip Fast]
Digital Tulip Fast: [chip: Digital DS21140 Tulip] rev 33 at F880
Digital Tulip Fast: Vendor=1011  Device=0009
Digital Tulip Fast: 00:00:BC:0F:07:CF at ioaddr F880
Digital Tulip Fast:  EEPROM default media type Autosense.
Digital Tulip Fast:  Index #0 - Media 10baseT (#0) described by a 21140 non-MII (0) block.
Digital Tulip Fast:  Index #1 - Media 100baseTx (#3) described by a 21140 non-MII (0) block.
Digital Tulip Fast:  Index #2 - Media 10baseT-FDX (#4) described by a 21140 non-MII (0) block.
Digital Tulip Fast:  Index #3 - Media 100baseTx-FDX (#5) described by a 21140 non-MII (0) block.
Address: 9.47.67.221
Netmask: 255.255.255.0
Server: 9.47.67.96
Gateway: 9.47.67.1

grub> kernel (nd)/boot/vmlinuz-flush root=/dev/sda2 console=ttyS0,38400n8 nmi_>[73D<400n8 nmi_watchdog=2                                                          grub> kernel (nd)/boot/vmlinuz-flush root=/dev/sda2 console=ttyS0,38400n8 nmi_>
   [Linux-bzImage, setup=0xa00, size=0x15bb70]

grub>                                                                          boot
Linux version 2.5.64 (wli@elm3b96) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 SMP Sat Mar 15 16:58:05 PST 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 0000000000100000 - 00000000c0000000 (usable)
 BIOS-e820: 00000000fec00000 - 00000000fec09000 (reserved)
 BIOS-e820: 00000000ffe80000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000c00000000 (usable)
user-defined physical RAM map:
 user: 0000000000000000 - 000000000009fc00 (usable)
 user: 0000000000100000 - 00000000c0000000 (usable)
 user: 00000000fec00000 - 00000000fec09000 (reserved)
 user: 00000000ffe80000 - 0000000100000000 (reserved)
 user: 0000000100000000 - 0000000c00000000 (usable)
Reserving 3072 pages of KVA for lmem_map of node 1
Shrinking node 1 from 4194304 pages to 4191232 pages
Reserving 3072 pages of KVA for lmem_map of node 2
Shrinking node 2 from 6291456 pages to 6288384 pages
Reserving 3072 pages of KVA for lmem_map of node 3
Shrinking node 3 from 8388608 pages to 8385536 pages
Reserving 1536 pages of KVA for lmem_map of node 4
Shrinking node 4 from 9437184 pages to 9435648 pages
Reserving 1536 pages of KVA for lmem_map of node 5
Shrinking node 5 from 10485760 pages to 10484224 pages
Reserving 1536 pages of KVA for lmem_map of node 6
Shrinking node 6 from 11534336 pages to 11532800 pages
Reserving 1536 pages of KVA for lmem_map of node 7
Shrinking node 7 from 12582912 pages to 12581376 pages
Reserving total of 15360 pages for numa KVA remap
MAXMEM = 34200000
48318MB HIGHMEM available.
774MB LOWMEM available.
min_low_pfn = 1177, max_low_pfn = 198144, highstart_pfn = 213504
Low memory ends at vaddr f0600000
node 0 will remap to vaddr f4200000 - f4200000
node 1 will remap to vaddr f3600000 - f4200000
node 2 will remap to vaddr f2a00000 - f3600000
node 3 will remap to vaddr f1e00000 - f2a00000
node 4 will remap to vaddr f1800000 - f1e00000
node 5 will remap to vaddr f1200000 - f1800000
node 6 will remap to vaddr f0c00000 - f1200000
node 7 will remap to vaddr f0600000 - f0c00000
High memory starts at vaddr f4200000
vmallocspace = [0xf42c8000, 0xfc2ca000)
fixmapspace = [0xfc2cc000, 0xfffff000)
MAXMEM = 0x34200000
found SMP MP-table at 000f6040
hm, page 000f6000 reserved twice.
hm, page 000f7000 reserved twice.
On node 0 totalpages: 262144
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 194048 pages, LIFO batch:2
  HighMem zone: 1899008 pages, LIFO batch:2
On node 1 totalpages: 261760
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 2094080 pages, LIFO batch:2
On node 2 totalpages: 261760
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 2094080 pages, LIFO batch:2
On node 3 totalpages: 261760
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 2094080 pages, LIFO batch:2
On node 4 totalpages: 130880
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 1047040 pages, LIFO batch:2
On node 5 totalpages: 130880
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 1047040 pages, LIFO batch:2
On node 6 totalpages: 130880
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 1047040 pages, LIFO batch:2
On node 7 totalpages: 130880
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 1047040 pages, LIFO batch:2
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: IBM NUMA Product ID: SBB          <6>Found an OEM MPC table at   7012ec - parsing it ... 
Translation: record 0, type 1, quad 0, global 3, local 3
Translation: record 1, type 1, quad 0, global 1, local 1
Translation: record 2, type 1, quad 0, global 1, local 1
Translation: record 3, type 1, quad 0, global 1, local 1
Translation: record 4, type 1, quad 1, global 1, local 3
Translation: record 5, type 1, quad 1, global 1, local 1
Translation: record 6, type 1, quad 1, global 1, local 1
Translation: record 7, type 1, quad 1, global 1, local 1
Translation: record 8, type 1, quad 2, global 1, local 3
Translation: record 9, type 1, quad 2, global 1, local 1
Translation: record 10, type 1, quad 2, global 1, local 1
Translation: record 11, type 1, quad 2, global 1, local 1
Translation: record 12, type 1, quad 3, global 1, local 3
Translation: record 13, type 1, quad 3, global 1, local 1
Translation: record 14, type 1, quad 3, global 1, local 1
Translation: record 15, type 1, quad 3, global 1, local 1
Translation: record 16, type 1, quad 4, global 1, local 3
Translation: record 17, type 1, quad 4, global 1, local 1
Translation: record 18, type 1, quad 4, global 1, local 1
Translation: record 19, type 1, quad 4, global 1, local 1
Translation: record 20, type 1, quad 5, global 1, local 3
Translation: record 21, type 1, quad 5, global 1, local 1
Translation: record 22, type 1, quad 5, global 1, local 1
Translation: record 23, type 1, quad 5, global 1, local 1
Translation: record 24, type 1, quad 6, global 1, local 3
Translation: record 25, type 1, quad 6, global 1, local 1
Translation: record 26, type 1, quad 6, global 1, local 1
Translation: record 27, type 1, quad 6, global 1, local 1
Translation: record 28, type 1, quad 7, global 1, local 3
Translation: record 29, type 1, quad 7, global 1, local 1
Translation: record 30, type 1, quad 7, global 1, local 1
Translation: record 31, type 1, quad 7, global 1, local 1
Translation: record 32, type 3, quad 0, global 0, local 0
Translation: record 33, type 3, quad 0, global 1, local 1
Translation: record 34, type 3, quad 0, global 2, local 2
Translation: record 35, type 4, quad 0, global 20, local 18
Translation: record 36, type 3, quad 1, global 3, local 0
Translation: record 37, type 3, quad 1, global 4, local 1
Translation: record 38, type 4, quad 1, global 21, local 18
Translation: record 39, type 3, quad 2, global 5, local 0
Translation: record 40, type 3, quad 2, global 6, local 1
Translation: record 41, type 4, quad 2, global 22, local 18
Translation: record 42, type 3, quad 3, global 7, local 0
Translation: record 43, type 3, quad 3, global 8, local 1
Translation: record 44, type 4, quad 3, global 23, local 18
Translation: record 45, type 3, quad 4, global 9, local 0
Translation: record 46, type 3, quad 4, global 10, local 1
Translation: record 47, type 3, quad 4, global 11, local 2
Translation: record 48, type 4, quad 4, global 24, local 18
Translation: record 49, type 3, quad 5, global 12, local 0
Translation: record 50, type 3, quad 5, global 13, local 1
Translation: record 51, type 4, quad 5, global 25, local 18
Translation: record 52, type 3, quad 6, global 14, local 0
Translation: record 53, type 3, quad 6, global 15, local 1
Translation: record 54, type 3, quad 6, global 16, local 2
Translation: record 55, type 4, quad 6, global 26, local 18
Translation: record 56, type 3, quad 7, global 17, local 0
Translation: record 57, type 3, quad 7, global 18, local 1
Translation: record 58, type 3, quad 7, global 19, local 2
Translation: record 59, type 4, quad 7, global 27, local 18
Translation: record 60, type 2, quad 0, global 13, local 14
Translation: record 61, type 2, quad 0, global 14, local 13
Translation: record 62, type 2, quad 1, global 15, local 14
Translation: record 63, type 2, quad 1, global 16, local 13
Translation: record 64, type 2, quad 2, global 17, local 14
Translation: record 65, type 2, quad 2, global 18, local 13
Translation: record 66, type 2, quad 3, global 19, local 14
Translation: record 67, type 2, quad 3, global 20, local 13
Translation: record 68, type 2, quad 4, global 21, local 14
Translation: record 69, type 2, quad 4, global 22, local 13
Translation: record 70, type 2, quad 5, global 23, local 14
Translation: record 71, type 2, quad 5, global 24, local 13
Translation: record 72, type 2, quad 6, global 25, local 14
Translation: record 73, type 2, quad 6, global 26, local 13
Translation: record 74, type 2, quad 7, global 27, local 14
Translation: record 75, type 2, quad 7, global 28, local 13
APIC at: 0xFEC08000
Processor #0 6:10 APIC version 17 (quad 0, apic 1)
Processor #4 6:10 APIC version 17 (quad 0, apic 8)
Processor #1 6:10 APIC version 17 (quad 0, apic 2)
Processor #2 6:10 APIC version 17 (quad 0, apic 4)
Processor #0 6:10 APIC version 17 (quad 1, apic 17)
Processor #4 6:10 APIC version 17 (quad 1, apic 24)
Processor #1 6:10 APIC version 17 (quad 1, apic 18)
Processor #2 6:10 APIC version 17 (quad 1, apic 20)
Processor #0 6:10 APIC version 17 (quad 2, apic 33)
Processor #4 6:10 APIC version 17 (quad 2, apic 40)
Processor #1 6:10 APIC version 17 (quad 2, apic 34)
Processor #2 6:10 APIC version 17 (quad 2, apic 36)
Processor #0 6:10 APIC version 17 (quad 3, apic 49)
Processor #4 6:10 APIC version 17 (quad 3, apic 56)
Processor #1 6:10 APIC version 17 (quad 3, apic 50)
Processor #2 6:10 APIC version 17 (quad 3, apic 52)
Processor #0 6:10 APIC version 17 (quad 4, apic 65)
Processor #4 6:10 APIC version 17 (quad 4, apic 72)
Processor #1 6:10 APIC version 17 (quad 4, apic 66)
Processor #2 6:10 APIC version 17 (quad 4, apic 68)
Processor #0 6:10 APIC version 17 (quad 5, apic 81)
Processor #4 6:10 APIC version 17 (quad 5, apic 88)
Processor #1 6:10 APIC version 17 (quad 5, apic 82)
Processor #2 6:10 APIC version 17 (quad 5, apic 84)
Processor #0 6:10 APIC version 17 (quad 6, apic 97)
Processor #4 6:10 APIC version 17 (quad 6, apic 104)
Processor #1 6:10 APIC version 17 (quad 6, apic 98)
Processor #2 6:10 APIC version 17 (quad 6, apic 100)
Processor #0 6:10 APIC version 17 (quad 7, apic 113)
Processor #4 6:10 APIC version 17 (quad 7, apic 120)
Processor #1 6:10 APIC version 17 (quad 7, apic 114)
Processor #2 6:10 APIC version 17 (quad 7, apic 116)
Bus #0 is PCI    (node 0)
Bus #1 is PCI    (node 0)
Bus #2 is PCI    (node 0)
Bus #20 is EISA   (node 0)
Bus #3 is PCI    (node 1)
Bus #4 is PCI    (node 1)
Bus #21 is EISA   (node 1)
Bus #5 is PCI    (node 2)
Bus #6 is PCI    (node 2)
Bus #22 is EISA   (node 2)
Bus #7 is PCI    (node 3)
Bus #8 is PCI    (node 3)
Bus #23 is EISA   (node 3)
Bus #9 is PCI    (node 4)
Bus #10 is PCI    (node 4)
Bus #11 is PCI    (node 4)
Bus #24 is EISA   (node 4)
Bus #12 is PCI    (node 5)
Bus #13 is PCI    (node 5)
Bus #25 is EISA   (node 5)
Bus #14 is PCI    (node 6)
Bus #15 is PCI    (node 6)
Bus #16 is PCI    (node 6)
Bus #26 is EISA   (node 6)
Bus #17 is PCI    (node 7)
Bus #18 is PCI    (node 7)
Bus #19 is PCI    (node 7)
Bus #27 is EISA   (node 7)
I/O APIC #13 Version 17 at 0xFE800000.
I/O APIC #14 Version 17 at 0xFE801000.
I/O APIC #15 Version 17 at 0xFE840000.
I/O APIC #16 Version 17 at 0xFE841000.
I/O APIC #17 Version 17 at 0xFE880000.
I/O APIC #18 Version 17 at 0xFE881000.
I/O APIC #19 Version 17 at 0xFE8C0000.
I/O APIC #20 Version 17 at 0xFE8C1000.
I/O APIC #21 Version 17 at 0xFE900000.
I/O APIC #22 Version 17 at 0xFE901000.
I/O APIC #23 Version 17 at 0xFE940000.
I/O APIC #24 Version 17 at 0xFE941000.
I/O APIC #25 Version 17 at 0xFE980000.
I/O APIC #26 Version 17 at 0xFE981000.
I/O APIC #27 Version 17 at 0xFE9C0000.
I/O APIC #28 Version 17 at 0xFE9C1000.
Enabling APIC mode:  NUMA-Q.  Using 2 I/O APICs
Processors: 32
Building zonelist for node : 0
Building zonelist for node : 1
Building zonelist for node : 2
Building zonelist for node : 3
Building zonelist for node : 4
Building zonelist for node : 5
Building zonelist for node : 6
Building zonelist for node : 7
Kernel command line: root=/dev/sda2 console=ttyS0,38400n8 nmi_watchdog=2 mem=50331648K
__set_fixmap(2,fec08000)
__set_fixmap(3,fe800000)
__set_fixmap(4,fe801000)
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 700.380 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1380.35 BogoMIPS
bootmem: freed 5ebf pages in node 0
Initializing highpages for node 0
Initializing highpages for node 1
Initializing highpages for node 2
Initializing highpages for node 3
Initializing highpages for node 4
Initializing highpages for node 5
Initializing highpages for node 6
Initializing highpages for node 7
Memory: 49201600k/50331648k available (1822k kernel code, 16064k reserved, 1087k data, 284k init, 48429056k highmem)
MAXMEM=0x34200000
vmalloc: start = 0xf42c8000, end = 0xfc2ca000
fixaddr: start = 0xfc2cc000, end = 0xfffff000
Dentry cache hash table entries: 1048576 (order: 7, 4194304 bytes)
Inode-cache hash table entries: 1048576 (order: 7, 4194304 bytes)
Mount-cache hash table entries: 4096 (order: 0, 32768 bytes)
Failed to register 'sysfs' in sysfs
-> /dev
-> /dev/console
-> /root
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU0: Intel Pentium III (Cascades) stepping 00
per-CPU timeslice cutoff: 5846.34 usecs.
task migration cache decay timeout: 6 msecs.
enabled ExtINT on CPU#0
Leaving ESR disabled.
Mapping cpu 0 to node 0
Remapping cross-quad port I/O for 8 quads
vmalloc, returning [0xf42c8000, 0xf44c9000)
xquad_portio vaddr 0xf42c8000, len 00200000
Booting processor 1/2 eip 2000
Storing NMI vector
Initializing CPU#1
masked ExtINT on CPU#1
Leaving ESR disabled.
Mapping cpu 1 to node 0
Calibrating delay loop... 1396.73 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU1: Intel Pentium III (Cascades) stepping 00
Booting processor 2/4 eip 2000
Storing NMI vector
Initializing CPU#2
masked ExtINT on CPU#2
Leaving ESR disabled.
Mapping cpu 2 to node 0
Calibrating delay loop... 1396.73 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU2: Intel Pentium III (Cascades) stepping 00
Booting processor 3/8 eip 2000
Storing NMI vector
Initializing CPU#3
masked ExtINT on CPU#3
Leaving ESR disabled.
Mapping cpu 3 to node 0
Calibrating delay loop... 1388.54 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU3: Intel Pentium III (Cascades) stepping 00
Booting processor 4/17 eip 2000
Storing NMI vector
Initializing CPU#4
masked ExtINT on CPU#4
Leaving ESR disabled.
Mapping cpu 4 to node 1
Calibrating delay loop... 1388.54 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU4: Intel Pentium III (Cascades) stepping 00
Booting processor 5/18 eip 2000
Storing NMI vector
Initializing CPU#5
masked ExtINT on CPU#5
Leaving ESR disabled.
Mapping cpu 5 to node 1
Calibrating delay loop... 1384.44 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU5: Intel Pentium III (Cascades) stepping 00
Booting processor 6/20 eip 2000
Storing NMI vector
Initializing CPU#6
masked ExtINT on CPU#6
Leaving ESR disabled.
Mapping cpu 6 to node 1
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU6: Intel Pentium III (Cascades) stepping 00
Booting processor 7/24 eip 2000
Storing NMI vector
Initializing CPU#7
masked ExtINT on CPU#7
Leaving ESR disabled.
Mapping cpu 7 to node 1
Calibrating delay loop... 1388.54 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU7: Intel Pentium III (Cascades) stepping 00
Booting processor 8/33 eip 2000
Storing NMI vector
Initializing CPU#8
masked ExtINT on CPU#8
Leaving ESR disabled.
Mapping cpu 8 to node 2
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU8: Intel Pentium III (Cascades) stepping 00
Booting processor 9/34 eip 2000
Storing NMI vector
Initializing CPU#9
masked ExtINT on CPU#9
Leaving ESR disabled.
Mapping cpu 9 to node 2
Calibrating delay loop... 1384.44 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU9: Intel Pentium III (Cascades) stepping 00
Booting processor 10/36 eip 2000
Storing NMI vector
Initializing CPU#10
masked ExtINT on CPU#10
Leaving ESR disabled.
Mapping cpu 10 to node 2
Calibrating delay loop... 1384.44 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU10: Intel Pentium III (Cascades) stepping 00
Booting processor 11/40 eip 2000
Storing NMI vector
Initializing CPU#11
masked ExtINT on CPU#11
Leaving ESR disabled.
Mapping cpu 11 to node 2
Calibrating delay loop... 1384.44 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU11: Intel Pentium III (Cascades) stepping 00
Booting processor 12/49 eip 2000
Storing NMI vector
Initializing CPU#12
masked ExtINT on CPU#12
Leaving ESR disabled.
Mapping cpu 12 to node 3
Calibrating delay loop... 1384.44 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU12: Intel Pentium III (Cascades) stepping 01
Booting processor 13/50 eip 2000
Storing NMI vector
Initializing CPU#13
masked ExtINT on CPU#13
Leaving ESR disabled.
Mapping cpu 13 to node 3
Calibrating delay loop... 1384.44 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU13: Intel Pentium III (Cascades) stepping 00
Booting processor 14/52 eip 2000
Storing NMI vector
Initializing CPU#14
masked ExtINT on CPU#14
Leaving ESR disabled.
Mapping cpu 14 to node 3
Calibrating delay loop... 1384.44 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU14: Intel Pentium III (Cascades) stepping 00
Booting processor 15/56 eip 2000
Storing NMI vector
Initializing CPU#15
masked ExtINT on CPU#15
Leaving ESR disabled.
Mapping cpu 15 to node 3
Calibrating delay loop... 1384.44 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU15: Intel Pentium III (Cascades) stepping 01
Booting processor 16/65 eip 2000
Storing NMI vector
Initializing CPU#16
masked ExtINT on CPU#16
Leaving ESR disabled.
Mapping cpu 16 to node 4
Calibrating delay loop... 1384.44 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU16: Intel Pentium III (Cascades) stepping 04
Booting processor 17/66 eip 2000
Storing NMI vector
Initializing CPU#17
masked ExtINT on CPU#17
Leaving ESR disabled.
Mapping cpu 17 to node 4
Calibrating delay loop... 1388.54 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU17: Intel Pentium III (Cascades) stepping 04
Booting processor 18/68 eip 2000
Storing NMI vector
Initializing CPU#18
masked ExtINT on CPU#18
Leaving ESR disabled.
Mapping cpu 18 to node 4
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU18: Intel Pentium III (Cascades) stepping 00
Booting processor 19/72 eip 2000
Storing NMI vector
Initializing CPU#19
masked ExtINT on CPU#19
Leaving ESR disabled.
Mapping cpu 19 to node 4
Calibrating delay loop... 1388.54 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU19: Intel Pentium III (Cascades) stepping 04
Booting processor 20/81 eip 2000
Storing NMI vector
Initializing CPU#20
masked ExtINT on CPU#20
Leaving ESR disabled.
Mapping cpu 20 to node 5
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
CPU20: Intel Pentium III (Cascades) stepping 01
Booting processor 21/82 eip 2000
Storing NMI vector
Initializing CPU#21
masked ExtINT on CPU#21
Leaving ESR disabled.
Mapping cpu 21 to node 5
Calibrating delay loop... 1384.44 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
CPU21: Intel Pentium III (Cascades) stepping 01
Booting processor 22/84 eip 2000
Storing NMI vector
Initializing CPU#22
masked ExtINT on CPU#22
Leaving ESR disabled.
Mapping cpu 22 to node 5
Calibrating delay loop... 1384.44 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
CPU22: Intel Pentium III (Cascades) stepping 01
Booting processor 23/88 eip 2000
Storing NMI vector
Initializing CPU#23
masked ExtINT on CPU#23
Leaving ESR disabled.
Mapping cpu 23 to node 5
Calibrating delay loop... 1388.54 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
CPU23: Intel Pentium III (Cascades) stepping 01
Booting processor 24/97 eip 2000
Storing NMI vector
Initializing CPU#24
masked ExtINT on CPU#24
Leaving ESR disabled.
Mapping cpu 24 to node 6
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
CPU24: Intel Pentium III (Cascades) stepping 04
Booting processor 25/98 eip 2000
Storing NMI vector
Initializing CPU#25
masked ExtINT on CPU#25
Leaving ESR disabled.
Mapping cpu 25 to node 6
Calibrating delay loop... 1388.54 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
CPU25: Intel Pentium III (Cascades) stepping 04
Booting processor 26/100 eip 2000
Storing NMI vector
Initializing CPU#26
masked ExtINT on CPU#26
Leaving ESR disabled.
Mapping cpu 26 to node 6
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
CPU26: Intel Pentium III (Cascades) stepping 04
Booting processor 27/104 eip 2000
Storing NMI vector
Initializing CPU#27
masked ExtINT on CPU#27
Leaving ESR disabled.
Mapping cpu 27 to node 6
Calibrating delay loop... 1384.44 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU serial number disabled.
CPU27: Intel Pentium III (Cascades) stepping 04
Booting processor 28/113 eip 2000
Storing NMI vector
Initializing CPU#28
masked ExtINT on CPU#28
Leaving ESR disabled.
Mapping cpu 28 to node 7
Calibrating delay loop... 1384.44 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU28: Intel Pentium III (Cascades) stepping 00
Booting processor 29/114 eip 2000
Storing NMI vector
Initializing CPU#29
masked ExtINT on CPU#29
Leaving ESR disabled.
Mapping cpu 29 to node 7
Calibrating delay loop... 1384.44 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU29: Intel Pentium III (Cascades) stepping 04
Booting processor 30/116 eip 2000
Storing NMI vector
Initializing CPU#30
masked ExtINT on CPU#30
Leaving ESR disabled.
Mapping cpu 30 to node 7
Calibrating delay loop... 1384.44 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU30: Intel Pentium III (Cascades) stepping 00
Booting processor 31/120 eip 2000
Storing NMI vector
Initializing CPU#31
masked ExtINT on CPU#31
Leaving ESR disabled.
Mapping cpu 31 to node 7
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU serial number disabled.
CPU31: Intel Pentium III (Cascades) stepping 00
Total of 32 processors activated (44408.83 BogoMIPS).
ENABLING IO-APIC IRQs
got past setup_ioapic_ids_from_mpc()
got past sync_Arb_IDs()
got past setup_IO_APIC_irqs()
got past init_IO_APIC_traps()
..TIMER: vector=0x31 pin1=2 pin2=0
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer (IRQ0) through the 8259A ... 
..... (found pin 0) ... failed.
timer doesn't work through the IO-APIC - disabling NMI Watchdog!
...trying to set up timer as Virtual Wire IRQ...Uhhuh. NMI received for unknown reason 35 on CPU 0.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
Call Trace:
 [<c010a766>] unknown_nmi_error+0x36/0x3c
 [<c010a7aa>] default_do_nmi+0x3e/0xb4
 [<c010a866>] do_nmi+0x3a/0x4c
 [<c0109d0a>] nmi+0x1e/0x30
 [<c01e2c56>] serial_in+0x56/0x70
 [<c01e4ca8>] serial8250_console_write+0x58/0x1cc
 [<c011efe7>] __call_console_drivers+0x37/0x4c
 [<c011f04c>] _call_console_drivers+0x50/0x58
 [<c011f130>] call_console_drivers+0xdc/0xe8
 [<c011f453>] release_console_sem+0x93/0x124
 [<c011f329>] printk+0x181/0x1c8
 [<c01050f2>] init+0x66/0x1f4
 [<c010508c>] init+0x0/0x1f4
 [<c01071e5>] kernel_thread_helper+0x5/0xc

 works.
got past check_timer()
testing the IO APIC.......................


.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 699.0929 MHz.
..... host bus clock speed is 99.0989 MHz.
checking TSC synchronization across 32 CPUs: 
BIOS BUG: CPU#0 improperly initialized, has 121395 usecs TSC skew! FIXED.
BIOS BUG: CPU#1 improperly initialized, has 121396 usecs TSC skew! FIXED.
BIOS BUG: CPU#2 improperly initialized, has 121396 usecs TSC skew! FIXED.
BIOS BUG: CPU#3 improperly initialized, has 121396 usecs TSC skew! FIXED.
BIOS BUG: CPU#4 improperly initialized, has 163040 usecs TSC skew! FIXED.
BIOS BUG: CPU#5 improperly initialized, has 163040 usecs TSC skew! FIXED.
BIOS BUG: CPU#6 improperly initialized, has 163040 usecs TSC skew! FIXED.
BIOS BUG: CPU#7 improperly initialized, has 163040 usecs TSC skew! FIXED.
BIOS BUG: CPU#8 improperly initialized, has 77837 usecs TSC skew! FIXED.
BIOS BUG: CPU#9 improperly initialized, has 77837 usecs TSC skew! FIXED.
BIOS BUG: CPU#10 improperly initialized, has 77836 usecs TSC skew! FIXED.
BIOS BUG: CPU#11 improperly initialized, has 77837 usecs TSC skew! FIXED.
BIOS BUG: CPU#12 improperly initialized, has 59081 usecs TSC skew! FIXED.
BIOS BUG: CPU#13 improperly initialized, has 59082 usecs TSC skew! FIXED.
BIOS BUG: CPU#14 improperly initialized, has 59081 usecs TSC skew! FIXED.
BIOS BUG: CPU#15 improperly initialized, has 59081 usecs TSC skew! FIXED.
BIOS BUG: CPU#16 improperly initialized, has -176329 usecs TSC skew! FIXED.
BIOS BUG: CPU#17 improperly initialized, has -176329 usecs TSC skew! FIXED.
BIOS BUG: CPU#18 improperly initialized, has -176329 usecs TSC skew! FIXED.
BIOS BUG: CPU#19 improperly initialized, has -176330 usecs TSC skew! FIXED.
BIOS BUG: CPU#20 improperly initialized, has -137324 usecs TSC skew! FIXED.
BIOS BUG: CPU#21 improperly initialized, has -137325 usecs TSC skew! FIXED.
BIOS BUG: CPU#22 improperly initialized, has -137325 usecs TSC skew! FIXED.
BIOS BUG: CPU#23 improperly initialized, has -137325 usecs TSC skew! FIXED.
BIOS BUG: CPU#24 improperly initialized, has -71212 usecs TSC skew! FIXED.
BIOS BUG: CPU#25 improperly initialized, has -71212 usecs TSC skew! FIXED.
BIOS BUG: CPU#26 improperly initialized, has -71212 usecs TSC skew! FIXED.
BIOS BUG: CPU#27 improperly initialized, has -71212 usecs TSC skew! FIXED.
BIOS BUG: CPU#28 improperly initialized, has -36487 usecs TSC skew! FIXED.
BIOS BUG: CPU#29 improperly initialized, has -36487 usecs TSC skew! FIXED.
BIOS BUG: CPU#30 improperly initialized, has -36488 usecs TSC skew! FIXED.
BIOS BUG: CPU#31 improperly initialized, has -36488 usecs TSC skew! FIXED.
Starting migration thread for cpu 0
Bringing up 1
CPU 1 IS NOW UP!
Uhhuh. NMI received for unknown reason 25 on CPU 1.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
Call Trace:
 [<c010a766>] unknown_nmi_error+0x36/0x3c
 [<c010a7aa>] default_do_nmi+0x3e/0xb4
 [<c010a866>] do_nmi+0x3a/0x4c
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0109d0a>] nmi+0x1e/0x30
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0107020>] default_idle+0x2c/0x34
 [<c01070b6>] cpu_idle+0x3a/0x48

Starting migration thread for cpu 1
Bringing up 2
CPU 2 IS NOW UP!
Uhhuh. NMI received for unknown reason 35 on CPU 2.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
Call Trace:
 [<c010a766>] unknown_nmi_error+0x36/0x3c
 [<c010a7aa>] default_do_nmi+0x3e/0xb4
 [<c010a866>] do_nmi+0x3a/0x4c
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0109d0a>] nmi+0x1e/0x30
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0107020>] default_idle+0x2c/0x34
 [<c01070b6>] cpu_idle+0x3a/0x48

Starting migration thread for cpu 2
Bringing up 3
Uhhuh. NMI received for unknown reason 35 on CPU 3.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
Call Trace:
 [<c010a766>] unknown_nmi_error+0x36/0x3c
 [<c010a7aa>] default_do_nmi+0x3e/0xb4
 [<c010a866>] do_nmi+0x3a/0x4c
 [<c0109d0a>] nmi+0x1e/0x30

CPU 3 IS NOW UP!
Starting migration thread for cpu 3
Bringing up 4
CPU 4 IS NOW UP!
Uhhuh. NMI received for unknown reason 35 on CPU 4.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
Call Trace:
 [<c010a766>] unknown_nmi_error+0x36/0x3c
 [<c010a7aa>] default_do_nmi+0x3e/0xb4
 [<c010a866>] do_nmi+0x3a/0x4c
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0109d0a>] nmi+0x1e/0x30
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0107020>] default_idle+0x2c/0x34
 [<c01070b6>] cpu_idle+0x3a/0x48

Starting migration thread for cpu 4
Bringing up 5
CPU 5 IS NOW UP!
Uhhuh. NMI received for unknown reason 25 on CPU 5.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
Call Trace:
 [<c010a766>] unknown_nmi_error+0x36/0x3c
 [<c010a7aa>] default_do_nmi+0x3e/0xb4
 [<c010a866>] do_nmi+0x3a/0x4c
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0109d0a>] nmi+0x1e/0x30
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0107020>] default_idle+0x2c/0x34
 [<c01070b6>] cpu_idle+0x3a/0x48

Starting migration thread for cpu 5
Bringing up 6
CPU 6 IS NOW UP!
Uhhuh. NMI received for unknown reason 35 on CPU 6.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
Call Trace:
 [<c010a766>] unknown_nmi_error+0x36/0x3c
 [<c010a7aa>] default_do_nmi+0x3e/0xb4
 [<c010a866>] do_nmi+0x3a/0x4c
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0109d0a>] nmi+0x1e/0x30
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0107020>] default_idle+0x2c/0x34
 [<c01070b6>] cpu_idle+0x3a/0x48

Starting migration thread for cpu 6
Bringing up 7
CPU 7 IS NOW UP!
Uhhuh. NMI received for unknown reason 25 on CPU 7.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
Call Trace:
 [<c010a766>] unknown_nmi_error+0x36/0x3c
 [<c010a7aa>] default_do_nmi+0x3e/0xb4
 [<c010a866>] do_nmi+0x3a/0x4c
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0109d0a>] nmi+0x1e/0x30
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0107020>] default_idle+0x2c/0x34
 [<c01070b6>] cpu_idle+0x3a/0x48

Starting migration thread for cpu 7
Bringing up 8
CPU 8 IS NOW UP!
Uhhuh. NMI received for unknown reason 35 on CPU 8.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
Call Trace:
 [<c010a766>] unknown_nmi_error+0x36/0x3c
 [<c010a7aa>] default_do_nmi+0x3e/0xb4
 [<c010a866>] do_nmi+0x3a/0x4c
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0109d0a>] nmi+0x1e/0x30
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0107020>] default_idle+0x2c/0x34
 [<c01070b6>] cpu_idle+0x3a/0x48

Starting migration thread for cpu 8
Bringing up 9
CPU 9 IS NOW UP!
Uhhuh. NMI received for unknown reason 25 on CPU 9.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
Call Trace:
 [<c010a766>] unknown_nmi_error+0x36/0x3c
 [<c010a7aa>] default_do_nmi+0x3e/0xb4
 [<c010a866>] do_nmi+0x3a/0x4c
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0109d0a>] nmi+0x1e/0x30
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0107020>] default_idle+0x2c/0x34
 [<c01070b6>] cpu_idle+0x3a/0x48

Starting migration thread for cpu 9
Bringing up 10
CPU 10 IS NOW UP!
Uhhuh. NMI received for unknown reason 35 on CPU 10.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
Call Trace:
 [<c010a766>] unknown_nmi_error+0x36/0x3c
 [<c010a7aa>] default_do_nmi+0x3e/0xb4
 [<c010a866>] do_nmi+0x3a/0x4c
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0109d0a>] nmi+0x1e/0x30
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0107020>] default_idle+0x2c/0x34
 [<c01070b6>] cpu_idle+0x3a/0x48

Starting migration thread for cpu 10
Bringing up 11
CPU 11 IS NOW UP!
Uhhuh. NMI received for unknown reason 25 on CPU 11.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
Call Trace:
 [<c010a766>] unknown_nmi_error+0x36/0x3c
 [<c010a7aa>] default_do_nmi+0x3e/0xb4
 [<c010a866>] do_nmi+0x3a/0x4c
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0109d0a>] nmi+0x1e/0x30
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0107020>] default_idle+0x2c/0x34
 [<c01070b6>] cpu_idle+0x3a/0x48

Starting migration thread for cpu 11
Bringing up 12
CPU 12 IS NOW UP!
Uhhuh. NMI received for unknown reason 35 on CPU 12.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
Call Trace:
 [<c010a766>] unknown_nmi_error+0x36/0x3c
 [<c010a7aa>] default_do_nmi+0x3e/0xb4
 [<c010a866>] do_nmi+0x3a/0x4c
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0109d0a>] nmi+0x1e/0x30
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0107020>] default_idle+0x2c/0x34
 [<c01070b6>] cpu_idle+0x3a/0x48

Starting migration thread for cpu 12
Bringing up 13
CPU 13 IS NOW UP!
Uhhuh. NMI received for unknown reason 25 on CPU 13.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
Call Trace:
 [<c010a766>] unknown_nmi_error+0x36/0x3c
 [<c010a7aa>] default_do_nmi+0x3e/0xb4
 [<c010a866>] do_nmi+0x3a/0x4c
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0109d0a>] nmi+0x1e/0x30
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0107020>] default_idle+0x2c/0x34
 [<c01070b6>] cpu_idle+0x3a/0x48

Starting migration thread for cpu 13
Bringing up 14
CPU 14 IS NOW UP!
Uhhuh. NMI received for unknown reason 35 on CPU 14.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
Call Trace:
 [<c010a766>] unknown_nmi_error+0x36/0x3c
 [<c010a7aa>] default_do_nmi+0x3e/0xb4
 [<c010a866>] do_nmi+0x3a/0x4c
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0109d0a>] nmi+0x1e/0x30
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0107020>] default_idle+0x2c/0x34
 [<c01070b6>] cpu_idle+0x3a/0x48

Starting migration thread for cpu 14
Bringing up 15
CPU 15 IS NOW UP!
Uhhuh. NMI received for unknown reason 25 on CPU 15.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
Call Trace:
 [<c010a766>] unknown_nmi_error+0x36/0x3c
 [<c010a7aa>] default_do_nmi+0x3e/0xb4
 [<c010a866>] do_nmi+0x3a/0x4c
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0109d0a>] nmi+0x1e/0x30
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0107020>] default_idle+0x2c/0x34
 [<c01070b6>] cpu_idle+0x3a/0x48

Starting migration thread for cpu 15
Bringing up 16
CPU 16 IS NOW UP!
Uhhuh. NMI received for unknown reason 25 on CPU 16.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
Call Trace:
 [<c010a766>] unknown_nmi_error+0x36/0x3c
 [<c010a7aa>] default_do_nmi+0x3e/0xb4
 [<c010a866>] do_nmi+0x3a/0x4c
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0109d0a>] nmi+0x1e/0x30
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0107020>] default_idle+0x2c/0x34
 [<c01070b6>] cpu_idle+0x3a/0x48

Starting migration thread for cpu 16
Bringing up 17
CPU 17 IS NOW UP!
Uhhuh. NMI received for unknown reason 25 on CPU 17.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
Call Trace:
 [<c010a766>] unknown_nmi_error+0x36/0x3c
 [<c010a7aa>] default_do_nmi+0x3e/0xb4
 [<c010a866>] do_nmi+0x3a/0x4c
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0109d0a>] nmi+0x1e/0x30
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0107020>] default_idle+0x2c/0x34
 [<c01070b6>] cpu_idle+0x3a/0x48

Starting migration thread for cpu 17
Bringing up 18
CPU 18 IS NOW UP!
Uhhuh. NMI received for unknown reason 25 on CPU 18.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
Call Trace:
 [<c010a766>] unknown_nmi_error+0x36/0x3c
 [<c010a7aa>] default_do_nmi+0x3e/0xb4
 [<c010a866>] do_nmi+0x3a/0x4c
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0109d0a>] nmi+0x1e/0x30
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0107020>] default_idle+0x2c/0x34
 [<c01070b6>] cpu_idle+0x3a/0x48

Starting migration thread for cpu 18
Bringing up 19
CPU 19 IS NOW UP!
Uhhuh. NMI received for unknown reason 35 on CPU 19.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
Call Trace:
 [<c010a766>] unknown_nmi_error+0x36/0x3c
 [<c010a7aa>] default_do_nmi+0x3e/0xb4
 [<c010a866>] do_nmi+0x3a/0x4c
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0109d0a>] nmi+0x1e/0x30
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0107020>] default_idle+0x2c/0x34
 [<c01070b6>] cpu_idle+0x3a/0x48

Starting migration thread for cpu 19
Bringing up 20
CPU 20 IS NOW UP!
Uhhuh. NMI received for unknown reason 25 on CPU 20.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
Call Trace:
 [<c010a766>] unknown_nmi_error+0x36/0x3c
 [<c010a7aa>] default_do_nmi+0x3e/0xb4
 [<c010a866>] do_nmi+0x3a/0x4c
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0109d0a>] nmi+0x1e/0x30
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0107020>] default_idle+0x2c/0x34
 [<c01070b6>] cpu_idle+0x3a/0x48

Starting migration thread for cpu 20
Bringing up 21
CPU 21 IS NOW UP!
Uhhuh. NMI received for unknown reason 35 on CPU 21.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
Call Trace:
 [<c010a766>] unknown_nmi_error+0x36/0x3c
 [<c010a7aa>] default_do_nmi+0x3e/0xb4
 [<c010a866>] do_nmi+0x3a/0x4c
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0109d0a>] nmi+0x1e/0x30
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0107020>] default_idle+0x2c/0x34
 [<c01070b6>] cpu_idle+0x3a/0x48

Starting migration thread for cpu 21
Bringing up 22
CPU 22 IS NOW UP!
Uhhuh. NMI received for unknown reason 25 on CPU 22.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
Call Trace:
 [<c010a766>] unknown_nmi_error+0x36/0x3c
 [<c010a7aa>] default_do_nmi+0x3e/0xb4
 [<c010a866>] do_nmi+0x3a/0x4c
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0109d0a>] nmi+0x1e/0x30
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0107020>] default_idle+0x2c/0x34
 [<c01070b6>] cpu_idle+0x3a/0x48

Starting migration thread for cpu 22
Bringing up 23
CPU 23 IS NOW UP!
Uhhuh. NMI received for unknown reason 25 on CPU 23.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
Call Trace:
 [<c010a766>] unknown_nmi_error+0x36/0x3c
 [<c010a7aa>] default_do_nmi+0x3e/0xb4
 [<c010a866>] do_nmi+0x3a/0x4c
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0109d0a>] nmi+0x1e/0x30
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0107020>] default_idle+0x2c/0x34
 [<c01070b6>] cpu_idle+0x3a/0x48

Starting migration thread for cpu 23
Bringing up 24
CPU 24 IS NOW UP!
Uhhuh. NMI received for unknown reason 25 on CPU 24.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
Call Trace:
 [<c010a766>] unknown_nmi_error+0x36/0x3c
 [<c010a7aa>] default_do_nmi+0x3e/0xb4
 [<c010a866>] do_nmi+0x3a/0x4c
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0109d0a>] nmi+0x1e/0x30
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0107020>] default_idle+0x2c/0x34
 [<c01070b6>] cpu_idle+0x3a/0x48

Starting migration thread for cpu 24
Bringing up 25
CPU 25 IS NOW UP!
Uhhuh. NMI received for unknown reason 35 on CPU 25.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
Call Trace:
 [<c010a766>] unknown_nmi_error+0x36/0x3c
 [<c010a7aa>] default_do_nmi+0x3e/0xb4
 [<c010a866>] do_nmi+0x3a/0x4c
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0109d0a>] nmi+0x1e/0x30
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0107020>] default_idle+0x2c/0x34
 [<c01070b6>] cpu_idle+0x3a/0x48

Starting migration thread for cpu 25
Bringing up 26
CPU 26 IS NOW UP!
Uhhuh. NMI received for unknown reason 25 on CPU 26.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
Call Trace:
 [<c010a766>] unknown_nmi_error+0x36/0x3c
 [<c010a7aa>] default_do_nmi+0x3e/0xb4
 [<c010a866>] do_nmi+0x3a/0x4c
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0109d0a>] nmi+0x1e/0x30
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0107020>] default_idle+0x2c/0x34
 [<c01070b6>] cpu_idle+0x3a/0x48

Starting migration thread for cpu 26
Bringing up 27
CPU 27 IS NOW UP!
Uhhuh. NMI received for unknown reason 35 on CPU 27.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
Call Trace:
 [<c010a766>] unknown_nmi_error+0x36/0x3c
 [<c010a7aa>] default_do_nmi+0x3e/0xb4
 [<c010a866>] do_nmi+0x3a/0x4c
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0109d0a>] nmi+0x1e/0x30
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0107020>] default_idle+0x2c/0x34
 [<c01070b6>] cpu_idle+0x3a/0x48

Starting migration thread for cpu 27
Bringing up 28
CPU 28 IS NOW UP!
Uhhuh. NMI received for unknown reason 25 on CPU 28.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
Call Trace:
 [<c010a766>] unknown_nmi_error+0x36/0x3c
 [<c010a7aa>] default_do_nmi+0x3e/0xb4
 [<c010a866>] do_nmi+0x3a/0x4c
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0109d0a>] nmi+0x1e/0x30
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0107020>] default_idle+0x2c/0x34
 [<c01070b6>] cpu_idle+0x3a/0x48

Starting migration thread for cpu 28
Bringing up 29
CPU 29 IS NOW UP!
Uhhuh. NMI received for unknown reason 25 on CPU 29.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
Call Trace:
 [<c010a766>] unknown_nmi_error+0x36/0x3c
 [<c010a7aa>] default_do_nmi+0x3e/0xb4
 [<c010a866>] do_nmi+0x3a/0x4c
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0109d0a>] nmi+0x1e/0x30
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0107020>] default_idle+0x2c/0x34
 [<c01070b6>] cpu_idle+0x3a/0x48

Starting migration thread for cpu 29
Bringing up 30
CPU 30 IS NOW UP!
Uhhuh. NMI received for unknown reason 25 on CPU 30.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
Call Trace:
 [<c010a766>] unknown_nmi_error+0x36/0x3c
 [<c010a7aa>] default_do_nmi+0x3e/0xb4
 [<c010a866>] do_nmi+0x3a/0x4c
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0109d0a>] nmi+0x1e/0x30
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0107020>] default_idle+0x2c/0x34
 [<c01070b6>] cpu_idle+0x3a/0x48

Starting migration thread for cpu 30
Bringing up 31
CPU 31 IS NOW UP!
Uhhuh. NMI received for unknown reason 35 on CPU 31.
Dazed and confused, but trying to continue
Do you have a strange power saving mode enabled?
Call Trace:
 [<c010a766>] unknown_nmi_error+0x36/0x3c
 [<c010a7aa>] default_do_nmi+0x3e/0xb4
 [<c010a866>] do_nmi+0x3a/0x4c
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0109d0a>] nmi+0x1e/0x30
 [<c0106ff4>] default_idle+0x0/0x34
 [<c0107020>] default_idle+0x2c/0x34
 [<c01070b6>] cpu_idle+0x3a/0x48

Starting migration thread for cpu 31
CPUS done 32
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
about to call initcall 0xc03df8b8
mtrr: v2.0 (20020519)
about to call initcall 0xc03ea7ac
about to call initcall 0xc03eb434
about to call initcall 0xc03eb4a8
about to call initcall 0xc03dfa0c
about to call initcall 0xc03f0b3c
PCI: Using configuration type 1
about to call initcall 0xc03e5730
about to call initcall 0xc03e8110
BIO: pool of 256 setup, 15Kb (60 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
about to call initcall 0xc03ec480
block request queues:
 128 requests per read queue
 128 requests per write queue
 8 requests per batch
 enter congestion at 15
 exit congestion at 17
about to call initcall 0xc03ec4e0
about to call initcall 0xc03efd24
SCSI subsystem initialized
about to call initcall 0xc03f0e5c
PCI: Probing PCI hardware (bus 00)
PCI: Searching for i450NX host bridges on 00:10.0
about to call initcall 0xc03f11dc
PCI->APIC IRQ transform: (B0,I10,P0) -> 23
PCI->APIC IRQ transform: (B0,I11,P0) -> 19
PCI->APIC IRQ transform: (B2,I12,P0) -> 40
PCI->APIC IRQ transform: (B2,I13,P0) -> 36
PCI->APIC IRQ transform: (B2,I15,P0) -> 28
PCI->APIC IRQ transform: (B2,I15,P1) -> 27
PCI: using PPB(B0,I12,P0) to get irq 15
PCI->APIC IRQ transform: (B1,I4,P0) -> 15
PCI: using PPB(B0,I12,P1) to get irq 13
PCI->APIC IRQ transform: (B1,I5,P1) -> 13
PCI: using PPB(B0,I12,P2) to get irq 11
PCI->APIC IRQ transform: (B1,I6,P2) -> 11
PCI: using PPB(B0,I12,P3) to get irq 7
PCI->APIC IRQ transform: (B1,I7,P3) -> 7
about to call initcall 0xc03f13d4
about to call initcall 0xc03f19f0
about to call initcall 0xc03dbc10
about to call initcall 0xc03dbca0
about to call initcall 0xc010fc5c
about to call initcall 0xc03dd764
about to call initcall 0xc03e2b20
about to call initcall 0xc03e4460
__set_fixmap(1,2f9d0000)
Enabling SEP on CPU 1
Enabling SEP on CPU 2
Enabling SEP on CPU 3
Enabling SEP on CPU 12
Enabling SEP on CPU 14
Enabling SEP on CPU 8
Enabling SEP on CPU 10
Enabling SEP on CPU 11
Enabling SEP on CPU 9
Enabling SEP on CPU 25
Enabling SEP on CPU 13
Enabling SEP on CPU 15
Enabling SEP on CPU 22
Enabling SEP on CPU 23
Enabling SEP on CPU 18
Enabling SEP on CPU 4
Enabling SEP on CPU 30
Enabling SEP on CPU 21
Enabling SEP on CPU 17
Enabling SEP on CPU 24
Enabling SEP on CPU 27
Enabling SEP on CPU 26
Enabling SEP on CPU 20
Enabling SEP on CPU 16
Enabling SEP on CPU 19
Enabling SEP on CPU 6
Enabling SEP on CPU 7
Enabling SEP on CPU 5
Enabling SEP on CPU 28
Enabling SEP on CPU 29
Enabling SEP on CPU 31
Enabling SEP on CPU 0
about to call initcall 0xc03e55d0
Total HugeTLB memory allocated, 0
about to call initcall 0xc03e5d94
about to call initcall 0xc03e60a0
about to call initcall 0xc03e62e0
about to call initcall 0xc03e63a0
about to call initcall 0xc03e6600
about to call initcall 0xc03e6670
about to call initcall 0xc03e75a4
about to call initcall 0xc03e7690
about to call initcall 0xc03e7b78
about to call initcall 0xc03e7ca0
about to call initcall 0xc03e7cd0
about to call initcall 0xc03e7d20
highmem bounce pool size: 64 pages
about to call initcall 0xc03e7e50
about to call initcall 0xc03e7ee0
about to call initcall 0xc03e8290
about to call initcall 0xc03e82e0
about to call initcall 0xc03e8320
about to call initcall 0xc03e8640
about to call initcall 0xc03e88d0
aio_setup: sizeof(struct page) = 44
about to call initcall 0xc03e8960
about to call initcall 0xc03e8a50
about to call initcall 0xc03e8a64
about to call initcall 0xc03e8aa4
about to call initcall 0xc03e8ab8
about to call initcall 0xc03e8e2c
about to call initcall 0xc03e8e70
about to call initcall 0xc03e8ea4
about to call initcall 0xc03e8ecc
about to call initcall 0xc03e8f00
about to call initcall 0xc03e8f40
about to call initcall 0xc03e8f80
about to call initcall 0xc03e8ffc
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
about to call initcall 0xc03e909c
about to call initcall 0xc03e90b0
vmalloc, returning [0xf44c9000, 0xf44d6000)
vmalloc, returning [0xf44d6000, 0xf451b000)
about to call initcall 0xc03e9dfc
about to call initcall 0xc03ea7c0
about to call initcall 0xc03ead54
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
about to call initcall 0xc03eb228
about to call initcall 0xc03eb4e0
pty: 256 Unix98 ptys configured
about to call initcall 0xc03ec280
Generic RTC Driver v1.06
about to call initcall 0xc01fcac0
about to call initcall 0xc03ecd64
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
about to call initcall 0xc03ed2d0
loop: loaded (max 8 devices)
about to call initcall 0xc03edbc0
starfire.c:v1.03 7/26/2000  Written by Donald Becker <becker@scyld.com>
 (unofficial 2.2/2.4 kernel port, version 1.03+LK1.4.1, February 10, 2002)
vmalloc, returning [0xf451b000, 0xf459c000)
eth0: Adaptec Starfire 6915 at 0xf451b000, 00:00:d1:ed:d0:85, IRQ 15.
eth0: MII PHY found at address 1, status 0x7809 advertising 0x01e1.
eth0: scatter-gather and hardware TCP cksumming disabled.
vmalloc, returning [0xf459c000, 0xf461d000)
eth1: Adaptec Starfire 6915 at 0xf459c000, 00:00:d1:ed:d0:86, IRQ 13.
eth1: MII PHY found at address 1, status 0x7809 advertising 0x01e1.
eth1: scatter-gather and hardware TCP cksumming disabled.
vmalloc, returning [0xf461d000, 0xf469e000)
eth2: Adaptec Starfire 6915 at 0xf461d000, 00:00:d1:ed:d0:87, IRQ 11.
eth2: MII PHY found at address 1, status 0x7809 advertising 0x01e1.
eth2: scatter-gather and hardware TCP cksumming disabled.
vmalloc, returning [0xf469e000, 0xf471f000)
eth3: Adaptec Starfire 6915 at 0xf469e000, 00:00:d1:ed:d0:88, IRQ 7.
eth3: MII PHY found at address 1, status 0x7809 advertising 0x01e1.
eth3: scatter-gather and hardware TCP cksumming disabled.
about to call initcall 0xc03ede84
about to call initcall 0xc03ee8fc
about to call initcall 0xc03efc20
Linux Tulip driver version 1.1.13 (May 11, 2002)
vmalloc, returning [0xf471f000, 0xf4721000)
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media 10baseT (#0) described by a 21140 non-MII (0) block.
tulip0:  Index #1 - Media 100baseTx (#3) described by a 21140 non-MII (0) block.
tulip0:  Index #2 - Media 10baseT-FDX (#4) described by a 21140 non-MII (0) block.
  tulip0:  Index #3 - Media 100baseTx-FDX (#5) described by a 21140 non-MII (0) block.
eth4: Digital DS21140 Tulip rev 33 at 0xf471f000, 00:00:BC:0F:07:CF, IRQ 36.
about to call initcall 0xc03eff74
vmalloc, returning [0xf4721000, 0xf4723000)
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.28
        <Adaptec 2944 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

(scsi0:A:0): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
  Vendor: IBM       Model: DGHS18X           Rev: 0360
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
(scsi0:A:1): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
  Vendor: IBM       Model: DGHS18X           Rev: 0360
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:1:0: Tagged Queuing enabled.  Depth 253
(scsi0:A:3): 5.000MB/s transfers (5.000MHz, offset 8)
  Vendor: PLEXTOR   Model: CD-R   PX-R412C   Rev: 1.06
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: TANDBERG  Model:  TDC 3800         Rev: -08:
  Type:   Sequential-Access                  ANSI SCSI revision: 01
(scsi0:A:8): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
  Vendor: IBM       Model: DGHS18X           Rev: 0360
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:8:0: Tagged Queuing enabled.  Depth 253
(scsi0:A:9): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
  Vendor: IBM       Model: DGHS18X           Rev: 0360
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:9:0: Tagged Queuing enabled.  Depth 253
(scsi0:A:10): 20.000MB/s transfers (10.000MHz, offset 8, 16bit)
  Vendor: IBM       Model: DGHS18X           Rev: 0360
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:10:0: Tagged Queuing enabled.  Depth 253
about to call initcall 0xc03effa0
about to call initcall 0xc03f00c0
ERROR: SCSI host `isp1020' has no error handling
ERROR: This is not a safe way to run your SCSI host
ERROR: The error handling must be added to this driver
Call Trace:
 [<c0217592>] scsi_register+0x6e/0x3ac
 [<c0243eb7>] isp1020_detect+0x67/0x2c0
 [<c021790a>] scsi_register_host+0x3a/0x94
 [<c0105101>] init+0x75/0x1f4
 [<c010508c>] init+0x0/0x1f4
 [<c01071e5>] kernel_thread_helper+0x5/0xc

vmalloc, returning [0xf4723000, 0xf4725000)
qlogicisp : new isp1020 revision ID (5)
scsi1 : QLogic ISP1020 SCSI on PCI bus 00 device 58 irq 19 MEM base 0xf4723000
about to call initcall 0xc03f0100
scsi HBA driver Qlogic ISP 10X0/2X00 didn't set a release method, please fix the template
ISP SCSI and Fibre Channel Host Adapter Driver
      Linux Platform Version 2.1
      Common Core Code Version 2.7
      Built on Mar 15 2003, 16:57:43
about to call initcall 0xc03f0140
SCSI device sda: 35843670 512-byte hdwr sectors (18352 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 35843670 512-byte hdwr sectors (18352 MB)
SCSI device sdb: drive cache: write through
 sdb: sdb1 sdb2
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
SCSI device sdc: 35843670 512-byte hdwr sectors (18352 MB)
SCSI device sdc: drive cache: write through
 sdc: sdc1
Attached scsi disk sdc at scsi0, channel 0, id 8, lun 0
SCSI device sdd: 35843670 512-byte hdwr sectors (18352 MB)
SCSI device sdd: drive cache: write through
 sdd: sdd1
Attached scsi disk sdd at scsi0, channel 0, id 9, lun 0
SCSI device sde: 35843670 512-byte hdwr sectors (18352 MB)
SCSI device sde: drive cache: write through
 sde: sde1
Attached scsi disk sde at scsi0, channel 0, id 10, lun 0
about to call initcall 0xc03f0204
vmalloc, returning [0xf4725000, 0xf4727000)
vmalloc, returning [0xf4727000, 0xf4729000)
vmalloc, returning [0xf4729000, 0xf472b000)
vmalloc, returning [0xf472b000, 0xf472d000)
vmalloc, returning [0xf472d000, 0xf472f000)
vmalloc, returning [0xf472f000, 0xf4731000)
vmalloc, returning [0xf4731000, 0xf4733000)
vmalloc, returning [0xf4733000, 0xf4735000)
vmalloc, returning [0xf4725000, 0xf4727000)
about to call initcall 0xc03f0650
about to call initcall 0xc03f0718
input: PC Speaker
about to call initcall 0xc03f1590
oprofile: using NMI interrupt.
about to call initcall 0xc03f1d7c
about to call initcall 0xc03f2980
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 262144 buckets, 4096Kbytes
TCP: Hash tables configured (established 262144 bind 43690)
about to call initcall 0xc03f2ec4
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
about to call initcall 0xc03f2f44
about to call initcall 0xc03f2f84
about to call initcall 0xc03e42ec
EXT2-fs warning (device sd(8,2)): ext2_fill_super: mounting ext3 filesystem as ext2
   
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 256k freed
INIT: version 2.84 booting
Activating swap.
Checking root file system...
fsck 1.32 (09-Nov-2002)
/dev/sda2: clean, 98919/513024 files, 699056/1024143 blocks
System time was Tue Mar 18 00:41:14 UTC 2003.
Setting the System Clock using the Hardware Clock as reference...
System Clock set. System local time is now Tue Mar 18 00:41:16 UTC 2003.
Checking all file systems...
fsck 1.32 (09-Nov-2002)
/dev/sdb1: clean, 364520/1121664 files, 1741251/2239051 blocks
/dev/sdb2: clean, 119/1121664 files, 45327/2241067 blocks
/dev/sde1: clean, 187498/2240224 files, 467418/4480119 blocks
DAVE: clean, 694533/2240224 files, 2020646/4480119 blocks
Setting kernel variables..
Mounting local filesystems...
EXT2-fs warning (device sd(8,17)): ext2_fill_super: mounting ext3 filesystem as ext2

/dev/sdb1 on /home type ext2 (rwEXT2-fs warning (device sd(8,18)): ext2_fill_super: mounting ext3 filesystem as ext2
,errors=remount-
ro)
/dev/sdb2 on /results type ext2 EXT2-fs warning (device sd(8,49)): ext2_fill_super: mounting ext3 filesystem as ext2

(rw,errors=remount-ro)
/dev/sdd1 on /work type ext2 (rw,errors=remount-ro)
/dev/sde1 on /test type ext2 (rw,errors=remount-ro)
Running 0dns-down to make sure resolv.conf is ok...done.
Cleaning: /etc/network/ifstate.
Setting up IP spoofing protection: rp_filter.
Configuring network interfaces... done.
Starting portmap daemon: portmap.
Loading the saved-state of the serial devices... 
/dev/ttyS0 at 0x03f8 (irq = 4) is a 16550A
/dev/ttyS1 at 0x02f8 (irq = 3) is a 16550A
Setting up general console font...done.
cannot (un)set powersave mode

Setting the System Clock using the Hardware Clock as reference...
System Clock set. Local time: Mon Mar 17 16:41:19 PST 2003

Cleaning: /tmp /var/lock /var/run.
Initializing random number generator... done.
Recovering nvi editor sessions... done.
Setting up X server socket directory /tmp/.X11-unix...done.
INIT: Entering runlevel: 2
Starting system log daemon: syslogd.
Starting kernel log daemon: klogd.
Starting internet superserver: inetd.
Starting network benchmark server: netserver.
Not starting NFS kernel daemon: No exports.
Starting OpenBSD Secure Shell server: sshd.
Starting NFS common utilities: statd lockd.
Starting periodic command scheduler: cron.

Debian GNU/Linux testing/unstable curly ttyS0

curly login: root
Password: 
Last login: Sun Mar 16 22:52:34 2003 from sig-9-65-229-224.mts.ibm.com on pts/3
Linux curly 2.5.64 #1 SMP Sat Mar 15 16:58:05 PST 2003 i686 unknown unknown GNU/Linux
curly:~# s!set
set -o vi
curly:~# [?1l>[24;1H
[?1049l[detached]
$ 

Script done on Mon Mar 17 16:44:18 2003
