Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268414AbTCCIBY>; Mon, 3 Mar 2003 03:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268428AbTCCIBY>; Mon, 3 Mar 2003 03:01:24 -0500
Received: from rzserv1.gsi.de ([140.181.96.11]:45491 "EHLO rzserv1.gsi.de")
	by vger.kernel.org with ESMTP id <S268414AbTCCIBP>;
	Mon, 3 Mar 2003 03:01:15 -0500
Message-ID: <3E630E3D.8060405@GSI.de>
Date: Mon, 03 Mar 2003 09:11:41 +0100
From: ChristopherHuhn <c.huhn@gsi.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: de-de, en-us, fr-fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel Bug at spinlock.h ?!
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

we have some problems with the 2.4.20 kernel on our linux farm, mainly - but 
not exclusivly - on our batch processing 2x2GHz Xeon (with hyperthreading), 
Intel e7500 supermicro P4-DPE boxes running - almost plain - Debian woody.

On these boxes (ca. 60) we sometimes get a kernel panic after an uptime of 2 
days or more. The process causing the panic is sometimes a users number 
crunching process but more often ksoftirqd_CPU0 or swapper.

Today we got this profound error msg:
Kernel Bug at /usr/src/kernel-source-2.4.20/include/asm/spinlock.h:105!

As I didn't find anything specifically related to this on google, I'm mailing right to this 
list. 
If you find any solutions, please cc: me as I'm not suscribed to the list.

With kind regards,

Christopher Huhn

Below is an excerpt of the kern.log:

Feb 24 14:44:56 lxb006 kernel: Linux version 2.4.20clone (root@lxdv10) (gcc 
version 2.95.4 20011002 (Debian prerelease))
#1 SMP Mon Feb 24 13:45:27 CET 2003
Feb 24 14:44:56 lxb006 kernel: BIOS-provided physical RAM map:
Feb 24 14:44:56 lxb006 kernel:  BIOS-e820: 0000000000000000 - 000000000009f800 
(usable)
Feb 24 14:44:56 lxb006 kernel:  BIOS-e820: 000000000009f800 - 00000000000a0000 
(reserved)
Feb 24 14:44:56 lxb006 kernel:  BIOS-e820: 00000000000d8000 - 00000000000e0000 
(reserved)
Feb 24 14:44:56 lxb006 kernel:  BIOS-e820: 00000000000e4000 - 0000000000100000 
(reserved)
Feb 24 14:44:56 lxb006 kernel:  BIOS-e820: 0000000000100000 - 000000003fefd000 
(usable)
Feb 24 14:44:56 lxb006 kernel:  BIOS-e820: 000000003fefd000 - 000000003ff00000 
(ACPI NVS)
Feb 24 14:44:56 lxb006 kernel:  BIOS-e820: 000000003ff00000 - 000000003ff80000 
(usable)
Feb 24 14:44:56 lxb006 kernel:  BIOS-e820: 000000003ff80000 - 0000000040000000 
(reserved)
Feb 24 14:44:56 lxb006 kernel:  BIOS-e820: 00000000fec00000 - 00000000fec10000 
(reserved)
Feb 24 14:44:56 lxb006 kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 
(reserved)
Feb 24 14:44:56 lxb006 kernel:  BIOS-e820: 00000000ff800000 - 00000000ffc00000 
(reserved)
Feb 24 14:44:56 lxb006 kernel:  BIOS-e820: 00000000fff00000 - 0000000100000000 
(reserved)
Feb 24 14:44:56 lxb006 kernel: 127MB HIGHMEM available.
Feb 24 14:44:56 lxb006 kernel: 896MB LOWMEM available.
Feb 24 14:44:56 lxb006 kernel: found SMP MP-table at 000f66c0
Feb 24 14:44:56 lxb006 kernel: hm, page 000f6000 reserved twice.
Feb 24 14:44:56 lxb006 kernel: hm, page 000f7000 reserved twice.
Feb 24 14:44:56 lxb006 kernel: hm, page 0009f000 reserved twice.
Feb 24 14:44:56 lxb006 kernel: hm, page 000a0000 reserved twice.
Feb 24 14:44:56 lxb006 kernel: On node 0 totalpages: 262016
Feb 24 14:44:56 lxb006 kernel: zone(0): 4096 pages.
Feb 24 14:44:56 lxb006 kernel: zone(1): 225280 pages.
Feb 24 14:44:56 lxb006 kernel: zone(2): 32640 pages.
Feb 24 14:44:56 lxb006 kernel: ACPI: Searched entire block, no RSDP was found.
Feb 24 14:44:56 lxb006 kernel: ACPI: Searched entire block, no RSDP was found.
Feb 24 14:44:56 lxb006 kernel: ACPI: System description tables not found
Feb 24 14:44:56 lxb006 kernel: Intel MultiProcessor Specification v1.4
Feb 24 14:44:56 lxb006 kernel:     Virtual Wire compatibility mode.
Feb 24 14:44:56 lxb006 kernel: OEM ID:   Product ID: Kings Canyon APIC at: 
0xFEE00000
Feb 24 14:44:56 lxb006 kernel: Processor #0 Pentium 4(tm) XEON(tm) APIC 
version 20
Feb 24 14:44:56 lxb006 kernel: Processor #6 Pentium 4(tm) XEON(tm) APIC 
version 20
Feb 24 14:44:56 lxb006 kernel: Processor #1 Pentium 4(tm) XEON(tm) APIC 
version 20
Feb 24 14:44:56 lxb006 kernel: Processor #7 Pentium 4(tm) XEON(tm) APIC 
version 20
Feb 24 14:44:56 lxb006 kernel: I/O APIC #2 Version 32 at 0xFEC00000.
Feb 24 14:44:56 lxb006 kernel: I/O APIC #3 Version 32 at 0xFEC80000.
Feb 24 14:44:56 lxb006 kernel: I/O APIC #4 Version 32 at 0xFEC80400.
Feb 24 14:44:56 lxb006 kernel: I/O APIC #5 Version 32 at 0xFEC81000.
Feb 24 14:44:56 lxb006 kernel: I/O APIC #8 Version 32 at 0xFEC81400.
Feb 24 14:44:56 lxb006 kernel: Processors: 4
Feb 24 14:44:56 lxb006 kernel: Kernel command line: rw root=/dev/nfs 
nfsroot=/SystemBoot/lxb006 ip=140.181.97.13:140.181.
97.209:140.181.96.1:255.255.192.0:
Feb 24 14:44:56 lxb006 kernel: Initializing CPU#0
Feb 24 14:44:56 lxb006 kernel: Detected 1996.646 MHz processor.
Feb 24 14:44:56 lxb006 kernel: Console: colour VGA+ 80x25
Feb 24 14:44:56 lxb006 kernel: Calibrating delay loop... 3984.58 BogoMIPS
Feb 24 14:44:56 lxb006 kernel: Memory: 1032124k/1048064k available (1763k 
kernel code, 15540k reserved, 746k data, 168k i
nit, 130548k highmem)
Feb 24 14:44:56 lxb006 kernel: Dentry cache hash table entries: 131072 (order: 
8, 1048576 bytes)
Feb 24 14:44:56 lxb006 kernel: Inode cache hash table entries: 65536 (order: 
7, 524288 bytes)
Feb 24 14:44:56 lxb006 kernel: Mount-cache hash table entries: 16384 (order: 
5, 131072 bytes)
eb 24 14:44:56 lxb006 kernel: Buffer-cache hash table entries: 65536 (order: 
6, 262144 bytes)
Feb 24 14:44:56 lxb006 kernel: Page-cache hash table entries: 262144 (order: 
8, 1048576 bytes)
Feb 24 14:44:56 lxb006 kernel: CPU: L1 I cache: 0K, L1 D cache: 8K
Feb 24 14:44:56 lxb006 kernel: CPU: L2 cache: 512K
Feb 24 14:44:56 lxb006 kernel: CPU: Physical Processor ID: 0
Feb 24 14:44:56 lxb006 kernel: Intel machine check architecture supported.
Feb 24 14:44:56 lxb006 kernel: Intel machine check reporting enabled on CPU#0.
Feb 24 14:44:56 lxb006 kernel: CPU:     After generic, caps: 3febfbff 00000000 
00000000 00000000
Feb 24 14:44:56 lxb006 kernel: CPU:             Common caps: 3febfbff 00000000 
00000000 00000000
Feb 24 14:44:56 lxb006 kernel: Enabling fast FPU save and restore... done.
Feb 24 14:45:00 lxb006 kernel: Enabling unmasked SIMD FPU exception support... 
done.
Feb 24 14:45:00 lxb006 kernel: Checking 'hlt' instruction... OK.
Feb 24 14:45:00 lxb006 kernel: POSIX conformance testing by UNIFIX
Feb 24 14:45:00 lxb006 kernel: mtrr: v1.40 (20010327) Richard Gooch 
(rgooch@atnf.csiro.au)
Feb 24 14:45:00 lxb006 kernel: mtrr: detected mtrr type: Intel
Feb 24 14:45:00 lxb006 kernel: CPU: L1 I cache: 0K, L1 D cache: 8K
Feb 24 14:45:00 lxb006 kernel: CPU: L2 cache: 512K
Feb 24 14:45:00 lxb006 kernel: CPU: Physical Processor ID: 0
Feb 24 14:45:00 lxb006 kernel: Intel machine check reporting enabled on CPU#0.
Feb 24 14:45:00 lxb006 kernel: CPU:     After generic, caps: 3febfbff 00000000 
00000000 00000000
Feb 24 14:45:00 lxb006 kernel: CPU:             Common caps: 3febfbff 00000000 
00000000 00000000
Feb 24 14:45:00 lxb006 kernel: CPU0: Intel(R) XEON(TM) CPU 2.00GHz stepping 04
Feb 24 14:45:00 lxb006 kernel: per-CPU timeslice cutoff: 1462.69 usecs.
Feb 24 14:45:00 lxb006 kernel: enabled ExtINT on CPU#0
Feb 24 14:45:00 lxb006 kernel: ESR value before enabling vector: 00000000
Feb 24 14:45:00 lxb006 kernel: ESR value after enabling vector: 00000000
Feb 24 14:45:00 lxb006 kernel: Booting processor 1/1 eip 2000
Feb 24 14:45:00 lxb006 kernel: Initializing CPU#1
Feb 24 14:45:00 lxb006 kernel: masked ExtINT on CPU#1
Feb 24 14:45:00 lxb006 kernel: ESR value before enabling vector: 00000000
Feb 24 14:45:00 lxb006 kernel: ESR value after enabling vector: 00000000
Feb 24 14:45:00 lxb006 kernel: Calibrating delay loop... 3984.58 BogoMIPS
Feb 24 14:45:00 lxb006 kernel: CPU: L1 I cache: 0K, L1 D cache: 8K
Feb 24 14:45:00 lxb006 kernel: CPU: L2 cache: 512K
Feb 24 14:45:00 lxb006 kernel: CPU: Physical Processor ID: 0
Feb 24 14:45:00 lxb006 kernel: Intel machine check reporting enabled on CPU#1.
Feb 24 14:45:00 lxb006 kernel: CPU:     After generic, caps: 3febfbff 00000000 
00000000 00000000
Feb 24 14:45:00 lxb006 kernel: CPU:             Common caps: 3febfbff 00000000 
00000000 00000000
Feb 24 14:45:00 lxb006 kernel: CPU1: Intel(R) XEON(TM) CPU 2.00GHz stepping 04
Feb 24 14:45:00 lxb006 kernel: Booting processor 2/6 eip 2000
Feb 24 14:45:00 lxb006 kernel: Initializing CPU#2
Feb 24 14:45:00 lxb006 kernel: masked ExtINT on CPU#2
Feb 24 14:45:00 lxb006 kernel: ESR value before enabling vector: 00000000
Feb 24 14:45:00 lxb006 kernel: ESR value after enabling vector: 00000000
Feb 24 14:45:00 lxb006 kernel: Calibrating delay loop... 3984.58 BogoMIPS
Feb 24 14:45:00 lxb006 kernel: CPU: L1 I cache: 0K, L1 D cache: 8K
Feb 24 14:45:00 lxb006 kernel: CPU: L2 cache: 512K
Feb 24 14:45:00 lxb006 kernel: CPU: Physical Processor ID: 3
Feb 24 14:45:00 lxb006 kernel: Intel machine check reporting enabled on CPU#2.
Feb 24 14:45:00 lxb006 kernel: CPU:     After generic, caps: 3febfbff 00000000 
00000000 00000000
Feb 24 14:45:00 lxb006 kernel: CPU:             Common caps: 3febfbff 00000000 
00000000 00000000
Feb 24 14:45:00 lxb006 kernel: CPU2: Intel(R) XEON(TM) CPU 2.00GHz stepping 04
Feb 24 14:45:00 lxb006 kernel: Booting processor 3/7 eip 2000
Feb 24 14:45:00 lxb006 kernel: Initializing CPU#3
Feb 24 14:45:00 lxb006 kernel: masked ExtINT on CPU#3
Feb 24 14:45:00 lxb006 kernel: ESR value before enabling vector: 00000000
Feb 24 14:45:00 lxb006 kernel: ESR value after enabling vector: 00000000
Feb 24 14:45:00 lxb006 kernel: Calibrating delay loop... 3984.58 BogoMIPS
Feb 24 14:45:00 lxb006 kernel: CPU: L1 I cache: 0K, L1 D cache: 8K
Feb 24 14:45:00 lxb006 kernel: CPU: L2 cache: 512K
Feb 24 14:45:00 lxb006 kernel: CPU: Physical Processor ID: 3
Feb 24 14:45:04 lxb006 kernel: Intel machine check reporting enabled on CPU#3.
Feb 24 14:45:04 lxb006 kernel: CPU:     After generic, caps: 3febfbff 00000000 
00000000 00000000
Feb 24 14:45:04 lxb006 kernel: CPU:             Common caps: 3febfbff 00000000 
00000000 00000000
Feb 24 14:45:04 lxb006 kernel: CPU3: Intel(R) XEON(TM) CPU 2.00GHz stepping 04
Feb 24 14:45:04 lxb006 kernel: Total of 4 processors activated (15938.35 
BogoMIPS).
Feb 24 14:45:04 lxb006 kernel: cpu_sibling_map[0] = 1
Feb 24 14:45:04 lxb006 kernel: cpu_sibling_map[1] = 0
Feb 24 14:45:04 lxb006 kernel: cpu_sibling_map[2] = 3
Feb 24 14:45:04 lxb006 kernel: cpu_sibling_map[3] = 2
Feb 24 14:45:04 lxb006 kernel: ENABLING IO-APIC IRQs
Feb 24 14:45:04 lxb006 kernel: Setting 2 in the phys_id_present_map
Feb 24 14:45:08 lxb006 kernel: ...changing IO-APIC physical APIC ID to 2 ... 
ok.
Feb 24 14:45:08 lxb006 kernel: Setting 3 in the phys_id_present_map
Feb 24 14:45:08 lxb006 kernel: ...changing IO-APIC physical APIC ID to 3 ... 
ok.
Feb 24 14:45:08 lxb006 kernel: Setting 4 in the phys_id_present_map
Feb 24 14:45:08 lxb006 kernel: ...changing IO-APIC physical APIC ID to 4 ... 
ok.
Feb 24 14:45:08 lxb006 kernel: Setting 5 in the phys_id_present_map
Feb 24 14:45:08 lxb006 kernel: ...changing IO-APIC physical APIC ID to 5 ... 
ok.
Feb 24 14:45:08 lxb006 kernel: Setting 8 in the phys_id_present_map
Feb 24 14:45:08 lxb006 kernel: ...changing IO-APIC physical APIC ID to 8 ... 
ok.
Feb 24 14:45:08 lxb006 kernel: init IO_APIC IRQs
Feb 24 14:45:08 lxb006 kernel:  IO-APIC (apicid-pin) 2-0, 2-10, 2-11, 2-20, 
2-21, 2-22, 2-23, 3-0, 3-1, 3-2, 3-3, 3-4, 3-
5, 3-6, 3-7, 3-8, 3-9, 3-10, 3-11, 3-12, 3-13, 3-14, 3-15, 3-16, 3-17, 3-18, 
3-19, 3-20, 3-21, 3-22, 3-23, 4-0, 4-1, 4-2,
 4-3, 4-4, 4-5, 4-6, 4-7, 4-8, 4-9, 4-10, 4-11, 4-12, 4-13, 4-14, 4-15, 4-16, 
4-17, 4-18, 4-19, 4-20, 4-21, 4-22, 4-23, 5
-0, 5-1, 5-2, 5-3, 5-4, 5-5, 5-6, 5-7, 5-8, 5-9, 5-10, 5-11, 5-12, 5-13, 5-14, 
5-15, 5-16, 5-17, 5-18, 5-19, 5-20, 5-21,
5-22, 5-23, 8-0, 8-1, 8-2, 8-3, 8-4, 8-5, 8-6, 8-7, 8-8, 8-9, 8-10, 8-11, 
8-12, 8-13, 8-14, 8-15, 8-16, 8-17, 8-18, 8-19,
 8-20, 8-21, 8-22, 8-23 not connected.
Feb 24 14:45:08 lxb006 kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
Feb 24 14:45:08 lxb006 kernel: number of MP IRQ sources: 19.
Feb 24 14:45:08 lxb006 kernel: number of IO-APIC #2 registers: 24.
Feb 24 14:45:12 lxb006 kernel: number of IO-APIC #3 registers: 24.
Feb 24 14:45:12 lxb006 kernel: number of IO-APIC #4 registers: 24.
Feb 24 14:45:12 lxb006 kernel: number of IO-APIC #5 registers: 24.
Feb 24 14:45:12 lxb006 kernel: number of IO-APIC #8 registers: 24.
Feb 24 14:45:12 lxb006 kernel: testing the IO APIC.......................
Feb 24 14:45:12 lxb006 kernel:
Feb 24 14:45:12 lxb006 kernel: IO APIC #2......
Feb 24 14:45:12 lxb006 kernel: .... register #00: 02008000
Feb 24 14:45:12 lxb006 kernel: .......    : physical APIC id: 02
Feb 24 14:45:12 lxb006 kernel:  WARNING: unexpected IO-APIC, please mail
Feb 24 14:45:12 lxb006 kernel:           to linux-smp@vger.kernel.org
Feb 24 14:45:12 lxb006 kernel: .... register #01: 00178020
Feb 24 14:45:12 lxb006 kernel: .......     : max redirection entries: 0017
Feb 24 14:45:12 lxb006 kernel: .......     : PRQ implemented: 1
Feb 24 14:45:12 lxb006 kernel: .......     : IO APIC version: 0020
Feb 24 14:45:12 lxb006 kernel: .... register #02: 00000000
Feb 24 14:45:12 lxb006 kernel: .......     : arbitration: 00
Feb 24 14:45:12 lxb006 kernel: .... IRQ redirection table:
Feb 24 14:45:12 lxb006 kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli 
Vect:
Feb 24 14:45:16 lxb006 kernel:  00 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:16 lxb006 kernel:  01 00F 0F  0    0    0   0   0    1    1    39
Feb 24 14:45:16 lxb006 kernel:  02 00F 0F  0    0    0   0   0    1    1    31
Feb 24 14:45:16 lxb006 kernel:  03 00F 0F  0    0    0   0   0    1    1    41
Feb 24 14:45:16 lxb006 kernel:  04 00F 0F  0    0    0   0   0    1    1    49
Feb 24 14:45:16 lxb006 kernel:  05 00F 0F  0    0    0   0   0    1    1    51
Feb 24 14:45:16 lxb006 kernel:  06 00F 0F  0    0    0   0   0    1    1    59
Feb 24 14:45:16 lxb006 kernel:  07 00F 0F  0    0    0   0   0    1    1    61
Feb 24 14:45:16 lxb006 kernel:  08 00F 0F  0    0    0   0   0    1    1    69
Feb 24 14:45:16 lxb006 kernel:  09 00F 0F  0    0    0   0   0    1    1    71
Feb 24 14:45:16 lxb006 kernel:  0a 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:16 lxb006 kernel:  0b 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:16 lxb006 kernel:  0c 00F 0F  0    0    0   0   0    1    1    79
Feb 24 14:45:16 lxb006 kernel:  0d 00F 0F  0    0    0   0   0    1    1    81
Feb 24 14:45:16 lxb006 kernel:  0e 00F 0F  0    0    0   0   0    1    1    89
Feb 24 14:45:16 lxb006 kernel:  0f 00F 0F  0    0    0   0   0    1    1    91
Feb 24 14:45:16 lxb006 kernel:  10 00F 0F  1    1    0   1   0    1    1    99
Feb 24 14:45:16 lxb006 kernel:  11 00F 0F  1    1    0   1   0    1    1    A1
Feb 24 14:45:16 lxb006 kernel:  12 00F 0F  1    1    0   1   0    1    1    A9
Feb 24 14:45:16 lxb006 kernel:  13 00F 0F  1    1    0   1   0    1    1    B1
Feb 24 14:45:16 lxb006 kernel:  14 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:16 lxb006 kernel:  15 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:16 lxb006 kernel:  16 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:16 lxb006 kernel:  17 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:16 lxb006 kernel:
Feb 24 14:45:16 lxb006 kernel: IO APIC #3......
Feb 24 14:45:16 lxb006 kernel: .... register #00: 03000000
Feb 24 14:45:16 lxb006 kernel: .......    : physical APIC id: 03
Feb 24 14:45:16 lxb006 kernel: .... register #01: 00178020
Feb 24 14:45:16 lxb006 kernel: .......     : max redirection entries: 0017
Feb 24 14:45:16 lxb006 kernel: .......     : PRQ implemented: 1
Feb 24 14:45:16 lxb006 kernel: .......     : IO APIC version: 0020
Feb 24 14:45:16 lxb006 kernel: .... register #02: 03000000
Feb 24 14:45:16 lxb006 kernel: .......     : arbitration: 03
Feb 24 14:45:16 lxb006 kernel: .... IRQ redirection table:
Feb 24 14:45:16 lxb006 kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli 
Vect:
Feb 24 14:45:16 lxb006 kernel:  00 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:20 lxb006 kernel:  01 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:20 lxb006 kernel:  02 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:20 lxb006 kernel:  03 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:20 lxb006 kernel:  04 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:20 lxb006 kernel:  05 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:20 lxb006 kernel:  06 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:20 lxb006 kernel:  07 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:20 lxb006 kernel:  08 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:20 lxb006 kernel:  09 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:20 lxb006 kernel:  0a 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:20 lxb006 kernel:  0b 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:20 lxb006 kernel:  0c 000 00  1    0    0   0   0    0    0    00
eb 24 14:45:20 lxb006 kernel:  0d 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:20 lxb006 kernel:  0e 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:20 lxb006 kernel:  0f 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:20 lxb006 kernel:  10 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:20 lxb006 kernel:  11 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:20 lxb006 kernel:  12 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:20 lxb006 kernel:  13 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:20 lxb006 kernel:  14 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:20 lxb006 kernel:  15 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:20 lxb006 kernel:  16 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:20 lxb006 kernel:  17 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:20 lxb006 kernel:
Feb 24 14:45:20 lxb006 kernel: IO APIC #4......
Feb 24 14:45:20 lxb006 kernel: .... register #00: 04000000
Feb 24 14:45:20 lxb006 kernel: .......    : physical APIC id: 04
Feb 24 14:45:20 lxb006 kernel: .... register #01: 00178020
Feb 24 14:45:20 lxb006 kernel: .......     : max redirection entries: 0017
Feb 24 14:45:20 lxb006 kernel: .......     : PRQ implemented: 1
Feb 24 14:45:20 lxb006 kernel: .......     : IO APIC version: 0020
Feb 24 14:45:20 lxb006 kernel: .... register #02: 04000000
Feb 24 14:45:20 lxb006 kernel: .......     : arbitration: 04
Feb 24 14:45:20 lxb006 kernel: .... IRQ redirection table:
Feb 24 14:45:20 lxb006 kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli 
Vect:
Feb 24 14:45:20 lxb006 kernel:  00 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:20 lxb006 kernel:  01 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:20 lxb006 kernel:  02 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:20 lxb006 kernel:  03 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:20 lxb006 kernel:  04 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:20 lxb006 kernel:  05 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:20 lxb006 kernel:  06 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:20 lxb006 kernel:  07 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:20 lxb006 kernel:  08 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:20 lxb006 kernel:  09 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:20 lxb006 kernel:  0a 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:20 lxb006 kernel:  0b 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:20 lxb006 kernel:  0c 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:20 lxb006 kernel:  0d 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:24 lxb006 kernel:  0e 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:24 lxb006 kernel:  0f 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:24 lxb006 kernel:  10 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:24 lxb006 kernel:  11 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:24 lxb006 kernel:  12 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:24 lxb006 kernel:  13 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:24 lxb006 kernel:  14 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:24 lxb006 kernel:  15 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:24 lxb006 kernel:  16 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:24 lxb006 kernel:  17 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:24 lxb006 kernel:
Feb 24 14:45:24 lxb006 kernel: IO APIC #5......
Feb 24 14:45:24 lxb006 kernel: .... register #00: 05000000
Feb 24 14:45:24 lxb006 kernel: .......    : physical APIC id: 05
Feb 24 14:45:24 lxb006 kernel: .... register #01: 00178020
Feb 24 14:45:24 lxb006 kernel: .......     : max redirection entries: 0017
Feb 24 14:45:24 lxb006 kernel: .......     : PRQ implemented: 1
Feb 24 14:45:24 lxb006 kernel: .......     : IO APIC version: 0020
Feb 24 14:45:24 lxb006 kernel: .... register #02: 05000000
Feb 24 14:45:24 lxb006 kernel: .......     : arbitration: 05
Feb 24 14:45:24 lxb006 kernel: .... IRQ redirection table:
Feb 24 14:45:24 lxb006 kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli 
Vect:
Feb 24 14:45:24 lxb006 kernel:  00 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:24 lxb006 kernel:  01 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:24 lxb006 kernel:  02 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:24 lxb006 kernel:  03 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:24 lxb006 kernel:  04 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:24 lxb006 kernel:  05 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:24 lxb006 kernel:  06 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:24 lxb006 kernel:  07 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:24 lxb006 kernel:  08 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:24 lxb006 kernel:  09 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:24 lxb006 kernel:  0a 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:24 lxb006 kernel:  0b 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:24 lxb006 kernel:  0c 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:24 lxb006 kernel:  0d 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:24 lxb006 kernel:  0e 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:24 lxb006 kernel:  0f 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:24 lxb006 kernel:  10 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:24 lxb006 kernel:  11 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:24 lxb006 kernel:  12 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:24 lxb006 kernel:  13 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:24 lxb006 kernel:  14 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:24 lxb006 kernel:  15 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:24 lxb006 kernel:  16 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:24 lxb006 kernel:  17 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:24 lxb006 kernel:
Feb 24 14:45:24 lxb006 kernel: IO APIC #8......
Feb 24 14:45:24 lxb006 kernel: .... register #00: 08000000
Feb 24 14:45:26 lxb006 kernel: .......    : physical APIC id: 08
Feb 24 14:45:26 lxb006 kernel: .... register #01: 00178020
Feb 24 14:45:26 lxb006 kernel: .......     : max redirection entries: 0017
Feb 24 14:45:26 lxb006 kernel: .......     : PRQ implemented: 1
Feb 24 14:45:26 lxb006 kernel: .......     : IO APIC version: 0020
Feb 24 14:45:26 lxb006 kernel: .... register #02: 08000000
Feb 24 14:45:26 lxb006 kernel: .......     : arbitration: 08
Feb 24 14:45:26 lxb006 kernel: .... IRQ redirection table:
Feb 24 14:45:26 lxb006 kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli 
Vect:
Feb 24 14:45:26 lxb006 kernel:  00 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:26 lxb006 kernel:  01 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:26 lxb006 kernel:  02 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:26 lxb006 kernel:  03 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:26 lxb006 kernel:  04 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:26 lxb006 kernel:  05 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:26 lxb006 kernel:  06 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:26 lxb006 kernel:  07 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:26 lxb006 kernel:  08 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:26 lxb006 kernel:  09 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:26 lxb006 kernel:  0a 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:26 lxb006 kernel:  0b 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:30 lxb006 kernel:  0c 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:30 lxb006 kernel:  0d 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:30 lxb006 kernel:  0e 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:30 lxb006 kernel:  0f 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:30 lxb006 kernel:  10 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:30 lxb006 kernel:  11 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:30 lxb006 kernel:  12 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:30 lxb006 kernel:  13 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:30 lxb006 kernel:  14 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:30 lxb006 kernel:  15 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:30 lxb006 kernel:  16 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:30 lxb006 kernel:  17 000 00  1    0    0   0   0    0    0    00
Feb 24 14:45:30 lxb006 kernel: IRQ to pin mappings:
Feb 24 14:45:30 lxb006 kernel: IRQ0 -> 0:2
Feb 24 14:45:30 lxb006 kernel: IRQ1 -> 0:1
Feb 24 14:45:30 lxb006 kernel: IRQ3 -> 0:3
Feb 24 14:45:30 lxb006 kernel: IRQ4 -> 0:4
Feb 24 14:45:30 lxb006 kernel: IRQ5 -> 0:5
Feb 24 14:45:30 lxb006 kernel: IRQ6 -> 0:6
Feb 24 14:45:30 lxb006 kernel: IRQ7 -> 0:7
Feb 24 14:45:30 lxb006 kernel: IRQ8 -> 0:8
Feb 24 14:45:30 lxb006 kernel: IRQ9 -> 0:9
Feb 24 14:45:30 lxb006 kernel: IRQ12 -> 0:12
Feb 24 14:45:30 lxb006 kernel: IRQ13 -> 0:13
Feb 24 14:45:30 lxb006 kernel: IRQ14 -> 0:14
Feb 24 14:45:30 lxb006 kernel: IRQ15 -> 0:15
Feb 24 14:45:30 lxb006 kernel: IRQ16 -> 0:16
Feb 24 14:45:30 lxb006 kernel: IRQ17 -> 0:17
Feb 24 14:45:30 lxb006 kernel: IRQ18 -> 0:18
Feb 24 14:45:30 lxb006 kernel: IRQ19 -> 0:19
Feb 24 14:45:30 lxb006 kernel: .................................... done.
Feb 24 14:45:30 lxb006 kernel: Using local APIC timer interrupts.
Feb 24 14:45:30 lxb006 kernel: calibrating APIC timer ...
Feb 24 14:45:30 lxb006 kernel: ..... CPU clock speed is 1996.6181 MHz.
Feb 24 14:45:30 lxb006 kernel: ..... host bus clock speed is 99.8308 MHz.
Feb 24 14:45:30 lxb006 kernel: cpu: 0, clocks: 998308, slice: 199661
Feb 24 14:45:30 lxb006 kernel: CPU0<T0:998304,T1:798640,D:3,S:199661,C:998308>
Feb 24 14:45:30 lxb006 kernel: cpu: 1, clocks: 998308, slice: 199661
Feb 24 14:45:30 lxb006 kernel: cpu: 3, clocks: 998308, slice: 199661
Feb 24 14:45:30 lxb006 kernel: cpu: 2, clocks: 998308, slice: 199661
Feb 24 14:45:30 lxb006 kernel: CPU1<T0:998304,T1:598976,D:6,S:199661,C:998308>
Feb 24 14:45:30 lxb006 kernel: CPU2<T0:998304,T1:399312,D:9,S:199661,C:998308>
Feb 24 14:45:30 lxb006 kernel: 
CPU3<T0:998304,T1:199648,D:12,S:199661,C:998308>
Feb 24 14:45:30 lxb006 kernel: checking TSC synchronization across CPUs: 
passed.
Feb 24 14:45:30 lxb006 kernel: Waiting on wait_init_idle (map = 0xe)
Feb 24 14:45:30 lxb006 kernel: All processors have done init_idle
Feb 24 14:45:30 lxb006 kernel: mtrr: your CPUs had inconsistent fixed MTRR 
settings
Feb 24 14:45:30 lxb006 kernel: mtrr: probably your BIOS does not setup all 
CPUs
eb 24 14:45:30 lxb006 kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd875, 
last bus=7
Feb 24 14:45:30 lxb006 kernel: PCI: Using configuration type 1
Feb 24 14:45:30 lxb006 kernel: PCI: Probing PCI hardware
Feb 24 14:45:30 lxb006 kernel: Transparent bridge - Intel Corp. 82801BA/CA/DB 
PCI Bridge
Feb 24 14:45:30 lxb006 kernel: PCI: Discovered primary peer bus 10 [IRQ]
Feb 24 14:45:30 lxb006 kernel: PCI: Discovered primary peer bus 11 [IRQ]
Feb 24 14:45:30 lxb006 kernel: PCI: Discovered primary peer bus 12 [IRQ]
Feb 24 14:45:34 lxb006 kernel: PCI: Using IRQ router PIIX [8086/2480] at 
00:1f.0
Feb 24 14:45:34 lxb006 kernel: PCI->APIC IRQ transform: (B0,I29,P0) -> 16
Feb 24 14:45:34 lxb006 kernel: PCI->APIC IRQ transform: (B0,I29,P1) -> 19
Feb 24 14:45:34 lxb006 kernel: PCI->APIC IRQ transform: (B0,I29,P2) -> 18
Feb 24 14:45:34 lxb006 kernel: PCI->APIC IRQ transform: (B7,I1,P0) -> 16
Feb 24 14:45:34 lxb006 kernel: PCI->APIC IRQ transform: (B7,I2,P0) -> 17
Feb 24 14:45:34 lxb006 kernel: isapnp: Scanning for PnP cards...
Feb 24 14:45:34 lxb006 kernel: isapnp: No Plug & Play device found
Feb 24 14:45:34 lxb006 kernel: Linux NET4.0 for Linux 2.4
Feb 24 14:45:34 lxb006 kernel: Based upon Swansea University Computer Society 
NET3.039
Feb 24 14:45:34 lxb006 kernel: Initializing RT netlink socket
Feb 24 14:45:34 lxb006 kernel: Starting kswapd
Feb 24 14:45:34 lxb006 kernel: allocated 32 pages and 32 bhs reserved for the 
highmem bounces
Feb 24 14:45:34 lxb006 kernel: VFS: Diskquotas version dquot_6.4.0 initialized
Feb 24 14:45:34 lxb006 kernel: Journalled Block Device driver loaded
Feb 24 14:45:34 lxb006 kernel: i2c-core.o: i2c core module
Feb 24 14:45:34 lxb006 kernel: i2c-proc.o version 2.6.1 (20010825)
Feb 24 14:45:34 lxb006 kernel: pty: 2048 Unix98 ptys configured
Feb 24 14:45:34 lxb006 kernel: Serial driver version 5.05c (2001-07-08) with 
MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabl
ed
Feb 24 14:45:34 lxb006 kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Feb 24 14:45:34 lxb006 kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
Feb 24 14:45:34 lxb006 kernel: Real Time Clock Driver v1.10e
Feb 24 14:45:34 lxb006 kernel: Uniform Multi-Platform E-IDE driver Revision: 
6.31
Feb 24 14:45:34 lxb006 kernel: ide: Assuming 33MHz system bus speed for PIO 
modes; override with idebus=xx
Feb 24 14:45:34 lxb006 kernel: ICH3: IDE controller on PCI bus 00 dev f9
Feb 24 14:45:34 lxb006 kernel: PCI: Device 00:1f.1 not available because of 
resource collisions
Feb 24 14:45:34 lxb006 kernel: PCI: No IRQ known for interrupt pin A of device 
00:1f.1. Probably buggy MP table.
Feb 24 14:45:34 lxb006 kernel: ICH3: BIOS setup was incomplete.
Feb 24 14:45:34 lxb006 kernel: ICH3: chipset revision 2
Feb 24 14:45:34 lxb006 kernel: ICH3: not 100%% native mode: will probe irqs 
later
Feb 24 14:45:34 lxb006 kernel:     ide0: BM-DMA at 0x1460-0x1467, BIOS 
settings: hda:pio, hdb:pio
Feb 24 14:45:34 lxb006 kernel:     ide1: BM-DMA at 0x1468-0x146f, BIOS 
settings: hdc:pio, hdd:pio
Feb 24 14:45:34 lxb006 kernel: hda: ST340016A, ATA DISK drive
Feb 24 14:45:34 lxb006 kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb 24 14:45:34 lxb006 kernel: hda: 78165360 sectors (40021 MB) w/2048KiB 
Cache, CHS=4865/255/63
Feb 24 14:45:34 lxb006 kernel: Partition check:
Feb 24 14:45:34 lxb006 kernel:  hda: hda1 hda4 < hda5 hda6 >
Feb 24 14:45:34 lxb006 kernel: Floppy drive(s): fd0 is 1.44M
Feb 24 14:45:34 lxb006 kernel: FDC 0 is a post-1991 82077
Feb 24 14:45:34 lxb006 kernel: RAMDISK driver initialized: 16 RAM disks of 
4096K size 1024 blocksize
Feb 24 14:45:34 lxb006 kernel: loop: loaded (max 8 devices)
Feb 24 14:45:34 lxb006 kernel: eepro100.c:v1.09j-t 9/29/99 Donald Becker 
http://www.scyld.com/network/eepro100.html
Feb 24 14:45:34 lxb006 kernel: eepro100.c: $Revision: 1.36 $ 2000/11/17 
Modified by Andrey V. Savochkin <saw@saw.sw.com.s
g> and others
Feb 24 14:45:34 lxb006 kernel: eth0: OEM i82557/i82558 10/100 Ethernet, 
00:30:48:23:4C:E9, IRQ 17.
Feb 24 14:45:34 lxb006 kernel:   Board assembly 000000-000, Physical 
connectors present: RJ45
Feb 24 14:45:34 lxb006 kernel:   Primary interface chip i82555 PHY #1.
Feb 24 14:45:34 lxb006 kernel:   General self-test: passed.
Feb 24 14:45:34 lxb006 kernel:   Serial sub-system self-test: passed.
Feb 24 14:45:38 lxb006 kernel:   Internal registers self-test: passed.
Feb 24 14:45:38 lxb006 kernel:   ROM checksum self-test: passed (0xb874c1d3).
Feb 24 14:45:38 lxb006 kernel: SCSI subsystem driver Revision: 1.00
Feb 24 14:45:38 lxb006 kernel: kmod: failed to exec /sbin/modprobe -s -k 
scsi_hostadapter, errno = 2
Feb 24 14:45:38 lxb006 kernel: kmod: failed to exec /sbin/modprobe -s -k 
scsi_hostadapter, errno = 2
Feb 24 14:45:38 lxb006 kernel: Linux Kernel Card Services 3.1.22
Feb 24 14:45:38 lxb006 kernel:   options:  [pci] [cardbus]
Feb 24 14:45:38 lxb006 kernel: I2O Core - (C) Copyright 1999 Red Hat Software
Feb 24 14:45:38 lxb006 kernel: I2O: Event thread created as pid 13
Feb 24 14:45:38 lxb006 kernel: I2O configuration manager v 0.04.
Feb 24 14:45:38 lxb006 kernel:   (C) Copyright 1999 Red Hat Software
Feb 24 14:45:38 lxb006 kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Feb 24 14:45:38 lxb006 kernel: IP Protocols: ICMP, UDP, TCP
Feb 24 14:45:38 lxb006 kernel: IP: routing cache hash table of 4096 buckets, 
64Kbytes
Feb 24 14:45:38 lxb006 kernel: TCP: Hash tables configured (established 131072 
bind 43690)
Feb 24 14:45:38 lxb006 kernel: IP-Config: Complete:
Feb 24 14:45:38 lxb006 kernel:       device=eth0, addr=140.181.97.13, 
mask=255.255.192.0, gw=140.181.96.1,
Feb 24 14:45:38 lxb006 kernel:      host=140.181.97.13, domain=, 
nis-domain=(none),
Feb 24 14:45:38 lxb006 kernel:      bootserver=140.181.97.209, 
rootserver=140.181.97.209, rootpath=
Feb 24 14:45:38 lxb006 kernel: NET4: Unix domain sockets 1.0/SMP for Linux 
NET4.0.
Feb 24 14:45:38 lxb006 kernel: ds: no socket drivers loaded!
Feb 24 14:45:38 lxb006 kernel: Looking up port of RPC 100003/2 on 
140.181.97.209
Feb 24 14:45:38 lxb006 kernel: Looking up port of RPC 100005/1 on 
140.181.97.209
Feb 24 14:45:38 lxb006 kernel: VFS: Mounted root (nfs filesystem).
Feb 24 14:45:38 lxb006 kernel: Freeing unused kernel memory: 168k freed
Feb 24 14:45:38 lxb006 kernel: Adding Swap: 2097136k swap-space (priority -1)
Feb 24 14:45:38 lxb006 kernel: sk98lin: Network Device Driver v4.06
Feb 24 14:45:38 lxb006 kernel: Copyright (C) 2000-2001 SysKonnect GmbH.
Feb 24 14:45:38 lxb006 kernel: No adapter found
Feb 24 14:45:38 lxb006 kernel: i2c-piix4.o version 2.6.3 (20020322)
Feb 24 14:45:38 lxb006 kernel: i2c-piix4.o: Error: Can't detect PIIX4 or 
compatible device!
Feb 24 14:45:38 lxb006 kernel: i2c-piix4.o: Device not detected, module not 
inserted.
Feb 24 14:45:38 lxb006 kernel: i2c-isa.o version 2.6.3 (20020322)
Feb 24 14:45:38 lxb006 kernel: i2c-core.o: adapter ISA main adapter registered 
as adapter 0.
Feb 24 14:45:38 lxb006 kernel: i2c-isa.o: ISA bus access for i2c modules 
initialized.
Feb 24 14:45:38 lxb006 kernel: w83781d.o version 2.6.3 (20020322)
Feb 24 14:45:38 lxb006 kernel: i2c-core.o: driver W83781D sensor driver 
registered.
Feb 24 14:45:38 lxb006 kernel: i2c-core.o: client [W83627HF chip] registered 
to adapter [ISA main adapter](pos. 0).
Feb 24 14:45:38 lxb006 kernel: eeprom.o version 2.6.3 (20020322)
Feb 24 14:45:38 lxb006 kernel: i2c-core.o: driver EEPROM READER registered.
Feb 24 14:45:38 lxb006 kernel: scsi0 : SCSI host adapter emulation for IDE 
ATAPI devices
Feb 24 14:45:38 lxb006 kernel: md: md driver 0.90.0 MAX_MD_DEVS=256, 
MD_SB_DISKS=27
Feb 24 14:45:38 lxb006 kernel: kjournald starting.  Commit interval 5 seconds
Feb 24 14:45:38 lxb006 kernel: EXT3 FS 2.4-0.9.19, 19 August 2002 on 
ide0(3,6), internal journal
Feb 24 14:45:38 lxb006 kernel: EXT3-fs: mounted filesystem with ordered data 
mode.
Feb 24 14:45:38 lxb006 kernel: Installing knfsd (copyright (C) 1996 
okir@monad.swb.de


