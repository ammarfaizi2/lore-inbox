Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbTKOQk6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 11:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTKOQk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 11:40:58 -0500
Received: from mail.uni-kl.de ([131.246.137.52]:50066 "EHLO mail.uni-kl.de")
	by vger.kernel.org with ESMTP id S261840AbTKOQkr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 11:40:47 -0500
Date: Sat, 15 Nov 2003 17:40:15 +0100
From: Eduard Bloch <edi@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22 SMP kernel build for hyper threading P4
Message-ID: <20031115164015.GA24824@zombie.inka.de>
References: <20031115153950.41EB38407D1@gateway.mailvault.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031115153950.41EB38407D1@gateway.mailvault.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#include <hallo.h>
* Job 317 [Sat, Nov 15 2003, 04:40:19PM]:

> I have a new P4 Hyperthreading PC that I have installed RedHat9 on. I am
> trying to add some features to my kernel (e.g. NTFS read support, crypto
> api, etc.) but when I build my new 2.4.22 kernel with CONFIG_SMP=y set
> then reboot, I am seeing only one processor in /proc/cpuinfo. When I
> boot with my stock RH9 2.4.20-20.9smp kernel I see two virtual
> processors show up in /proc/cpuinfo.
> 
> I've even build a 2.4.22 kernel with the config-2.4.20-20.9smp
> configuration that came with RH9.

I see a very similar behaviour on a dual Xeon system here. But it began
with 2.4.22. After upgrading from 2.4.21 to 2.4.22, HT was disabled. It
became even worse, the mainboard (some Serverworks board in Siemends
Primergy F250 server) decided to disable the second CPU completely (I
don't have the logs from that moment, sorry).

After upgrading to 2.4.23-pre9 and enabling the second CPU in the
mainboard BIOS, I see HT only working on the second CPU. There only a
message about the first: WARNING: No sibling found for CPU 0. I tried
compiling with or without ACPI, it makes no difference. I can live with
3 virtual CPUs but idealy it should be fixed before 2.4.23 release.
Needles to say that it still works with 4 virtual CPUs using 2.4.21.

Kernel messages for those who are interessted:

Nov  9 12:39:00 dialogsrv kernel: WARM shutting down of: CB... afs... BkG... CTrunc... AFSDB... RxEvent... RxListener... 
Nov  9 12:39:03 dialogsrv kernel: Kernel logging (proc) stopped.
Nov  9 12:39:03 dialogsrv kernel: Kernel log daemon terminating.
Nov  9 13:18:09 dialogsrv kernel: klogd 1.4.1#10, log source = /proc/kmsg started.
Nov  9 13:18:09 dialogsrv kernel: Inspecting /boot/System.map-2.4.23-pre9
Nov  9 13:18:09 dialogsrv kernel: Loaded 22548 symbols from /boot/System.map-2.4.23-pre9.
Nov  9 13:18:09 dialogsrv kernel: Symbols match kernel version 2.4.23-pre9.
Nov  9 13:18:09 dialogsrv kernel: Loaded 45 symbols from 8 modules.
Nov  9 13:18:09 dialogsrv kernel: Linux version 2.4.23-pre9 (root@dialogsrv) (gcc version 2.95.4 20011002 (Debian prerelease)) #5 SMP Fre Nov 7 01:14:29 CET 2003
Nov  9 13:18:09 dialogsrv kernel: BIOS-provided physical RAM map:
Nov  9 13:18:09 dialogsrv kernel:  BIOS-e820: 0000000000000000 - 0000000000099c00 (usable)
Nov  9 13:18:09 dialogsrv kernel:  BIOS-e820: 0000000000099c00 - 00000000000a0000 (reserved)
Nov  9 13:18:09 dialogsrv kernel:  BIOS-e820: 00000000000ca000 - 00000000000d0000 (reserved)
Nov  9 13:18:09 dialogsrv kernel:  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
Nov  9 13:18:09 dialogsrv kernel:  BIOS-e820: 0000000000100000 - 000000007fef0000 (usable)
Nov  9 13:18:09 dialogsrv kernel:  BIOS-e820: 000000007fef0000 - 000000007feff000 (ACPI data)
Nov  9 13:18:09 dialogsrv kernel:  BIOS-e820: 000000007feff000 - 000000007ff00000 (ACPI NVS)
Nov  9 13:18:09 dialogsrv kernel:  BIOS-e820: 000000007ff00000 - 0000000080000000 (usable)
Nov  9 13:18:09 dialogsrv kernel:  BIOS-e820: 00000000fec00000 - 00000000fed00000 (reserved)
Nov  9 13:18:09 dialogsrv kernel:  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
Nov  9 13:18:09 dialogsrv kernel:  BIOS-e820: 00000000ffc00000 - 0000000100000000 (reserved)
Nov  9 13:18:09 dialogsrv kernel: 1152MB HIGHMEM available.
Nov  9 13:18:09 dialogsrv kernel: 896MB LOWMEM available.
Nov  9 13:18:09 dialogsrv kernel: ACPI: have wakeup address 0xc0002000
Nov  9 13:18:09 dialogsrv kernel: found SMP MP-table at 000f6ae0
Nov  9 13:18:09 dialogsrv kernel: hm, page 000f6000 reserved twice.
Nov  9 13:18:09 dialogsrv kernel: hm, page 000f7000 reserved twice.
Nov  9 13:18:09 dialogsrv kernel: hm, page 0009a000 reserved twice.
Nov  9 13:18:09 dialogsrv kernel: hm, page 0009b000 reserved twice.
Nov  9 13:18:09 dialogsrv kernel: On node 0 totalpages: 524288
Nov  9 13:18:09 dialogsrv kernel: zone(0): 4096 pages.
Nov  9 13:18:09 dialogsrv kernel: zone(1): 225280 pages.
Nov  9 13:18:09 dialogsrv kernel: zone(2): 294912 pages.
Nov  9 13:18:09 dialogsrv kernel: ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f6a70
Nov  9 13:18:09 dialogsrv kernel: ACPI: RSDT (v001 PTLTD    RSDT   0x06040001  LTP 0x00000000) @ 0x7fefc0c5
Nov  9 13:18:09 dialogsrv kernel: ACPI: FADT (v001 FSC    D1309    0x06040001      0x000f4240) @ 0x7fefc0f9
Nov  9 13:18:09 dialogsrv kernel: ACPI: SPCR (v001 PTLTD  $UCRTBL$ 0x06040001 PTL  0x00000001) @ 0x7fefeef8
Nov  9 13:18:09 dialogsrv kernel: ACPI: MADT (v001 PTLTD  ^I APIC   0x06040001  LTP 0x00000000) @ 0x7fefef48
Nov  9 13:18:09 dialogsrv kernel: ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040001  LTP 0x00000001) @ 0x7fefefd8
Nov  9 13:18:09 dialogsrv kernel: ACPI: DSDT (v001 FSC    D1204    0x06040001 MSFT 0x0100000c) @ 0x00000000
Nov  9 13:18:09 dialogsrv kernel: ACPI: Local APIC address 0xfee00000
Nov  9 13:18:09 dialogsrv kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x06] enabled)
Nov  9 13:18:09 dialogsrv kernel: Processor #6 Pentium 4(tm) XEON(tm) APIC version 20
Nov  9 13:18:09 dialogsrv kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Nov  9 13:18:09 dialogsrv kernel: Processor #0 Pentium 4(tm) XEON(tm) APIC version 20
Nov  9 13:18:09 dialogsrv kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Nov  9 13:18:09 dialogsrv kernel: Processor #1 Pentium 4(tm) XEON(tm) APIC version 20
Nov  9 13:18:09 dialogsrv kernel: ACPI: LAPIC (acpi_id[0x03] lapic_id[0x07] enabled)
Nov  9 13:18:09 dialogsrv kernel: Processor #7 Pentium 4(tm) XEON(tm) APIC version 20
Nov  9 13:18:09 dialogsrv kernel: ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
Nov  9 13:18:09 dialogsrv kernel: ACPI: LAPIC_NMI (acpi_id[0x01] polarity[0x1] trigger[0x1] lint[0x1])
Nov  9 13:18:09 dialogsrv kernel: ACPI: LAPIC_NMI (acpi_id[0x02] polarity[0x1] trigger[0x1] lint[0x1])
Nov  9 13:18:09 dialogsrv kernel: ACPI: LAPIC_NMI (acpi_id[0x03] polarity[0x1] trigger[0x1] lint[0x1])
Nov  9 13:18:09 dialogsrv kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
Nov  9 13:18:09 dialogsrv kernel: IOAPIC[0]: Assigned apic_id 2
Nov  9 13:18:09 dialogsrv kernel: IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-15
Nov  9 13:18:09 dialogsrv kernel: ACPI: IOAPIC (id[0x03] address[0xfec10000] global_irq_base[0x10])
Nov  9 13:18:09 dialogsrv kernel: IOAPIC[1]: Assigned apic_id 3
Nov  9 13:18:09 dialogsrv kernel: IOAPIC[1]: apic_id 3, version 17, address 0xfec10000, IRQ 16-31
Nov  9 13:18:09 dialogsrv kernel: ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x1] trigger[0x1])
Nov  9 13:18:09 dialogsrv kernel: ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x3] trigger[0x3])
Nov  9 13:18:09 dialogsrv kernel: Using ACPI (MADT) for SMP configuration information
Nov  9 13:18:09 dialogsrv kernel: Kernel command line: auto BOOT_IMAGE=Linux(4xSMP) ro root=3a03 acpismp=force
Nov  9 13:18:09 dialogsrv kernel: Initializing CPU#0
Nov  9 13:18:09 dialogsrv kernel: Detected 1996.185 MHz processor.
Nov  9 13:18:09 dialogsrv kernel: Console: colour VGA+ 80x25
Nov  9 13:18:09 dialogsrv kernel: Calibrating delay loop... 3984.58 BogoMIPS
Nov  9 13:18:09 dialogsrv kernel: Memory: 2067628k/2097152k available (2012k kernel code, 29048k reserved, 785k data, 140k init, 1179584k highmem)
Nov  9 13:18:09 dialogsrv kernel: Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Nov  9 13:18:09 dialogsrv kernel: Inode cache hash table entries: 131072 (order: 8, 1048576 bytes)
Nov  9 13:18:09 dialogsrv kernel: Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Nov  9 13:18:09 dialogsrv kernel: Buffer cache hash table entries: 131072 (order: 7, 524288 bytes)
Nov  9 13:18:09 dialogsrv kernel: Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
Nov  9 13:18:09 dialogsrv kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Nov  9 13:18:09 dialogsrv kernel: CPU: L2 cache: 512K
Nov  9 13:18:09 dialogsrv kernel: CPU: Physical Processor ID: 3
Nov  9 13:18:09 dialogsrv kernel: Intel machine check architecture supported.
Nov  9 13:18:09 dialogsrv kernel: Intel machine check reporting enabled on CPU#0.
Nov  9 13:18:09 dialogsrv kernel: CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
Nov  9 13:18:09 dialogsrv kernel: CPU:             Common caps: 3febfbff 00000000 00000000 00000000
Nov  9 13:18:09 dialogsrv kernel: Enabling fast FPU save and restore... done.
Nov  9 13:18:09 dialogsrv kernel: Enabling unmasked SIMD FPU exception support... done.
Nov  9 13:18:09 dialogsrv kernel: Checking 'hlt' instruction... OK.
Nov  9 13:18:09 dialogsrv kernel: POSIX conformance testing by UNIFIX
Nov  9 13:18:09 dialogsrv kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
Nov  9 13:18:09 dialogsrv kernel: mtrr: detected mtrr type: Intel
Nov  9 13:18:09 dialogsrv kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Nov  9 13:18:09 dialogsrv kernel: CPU: L2 cache: 512K
Nov  9 13:18:09 dialogsrv kernel: CPU: Physical Processor ID: 3
Nov  9 13:18:09 dialogsrv kernel: Intel machine check reporting enabled on CPU#0.
Nov  9 13:18:09 dialogsrv kernel: CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
Nov  9 13:18:09 dialogsrv kernel: CPU:             Common caps: 3febfbff 00000000 00000000 00000000
Nov  9 13:18:09 dialogsrv kernel: CPU0: Intel(R) XEON(TM) CPU 2.00GHz stepping 04
Nov  9 13:18:09 dialogsrv kernel: per-CPU timeslice cutoff: 1462.69 usecs.
Nov  9 13:18:09 dialogsrv kernel: enabled ExtINT on CPU#0
Nov  9 13:18:09 dialogsrv kernel: ESR value before enabling vector: 00000000
Nov  9 13:18:09 dialogsrv kernel: ESR value after enabling vector: 00000000
Nov  9 13:18:09 dialogsrv kernel: Booting processor 1/0 eip 3000
Nov  9 13:18:09 dialogsrv kernel: Initializing CPU#1
Nov  9 13:18:09 dialogsrv kernel: masked ExtINT on CPU#1
Nov  9 13:18:09 dialogsrv kernel: ESR value before enabling vector: 00000000
Nov  9 13:18:09 dialogsrv kernel: ESR value after enabling vector: 00000000
Nov  9 13:18:09 dialogsrv kernel: Calibrating delay loop... 3984.58 BogoMIPS
Nov  9 13:18:09 dialogsrv kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Nov  9 13:18:09 dialogsrv kernel: CPU: L2 cache: 512K
Nov  9 13:18:09 dialogsrv kernel: CPU: Physical Processor ID: 0
Nov  9 13:18:09 dialogsrv kernel: Intel machine check reporting enabled on CPU#1.
Nov  9 13:18:09 dialogsrv kernel: CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
Nov  9 13:18:09 dialogsrv kernel: CPU:             Common caps: 3febfbff 00000000 00000000 00000000
Nov  9 13:18:09 dialogsrv kernel: CPU1: Intel(R) XEON(TM) CPU 2.00GHz stepping 04
Nov  9 13:18:09 dialogsrv kernel: Booting processor 2/1 eip 3000
Nov  9 13:18:09 dialogsrv kernel: Initializing CPU#2
Nov  9 13:18:09 dialogsrv kernel: masked ExtINT on CPU#2
Nov  9 13:18:09 dialogsrv kernel: ESR value before enabling vector: 00000000
Nov  9 13:18:09 dialogsrv kernel: ESR value after enabling vector: 00000000
Nov  9 13:18:09 dialogsrv kernel: Calibrating delay loop... 3984.58 BogoMIPS
Nov  9 13:18:09 dialogsrv kernel: CPU: Trace cache: 12K uops, L1 D cache: 8K
Nov  9 13:18:09 dialogsrv kernel: CPU: L2 cache: 512K
Nov  9 13:18:09 dialogsrv kernel: CPU: Physical Processor ID: 0
Nov  9 13:18:09 dialogsrv kernel: Intel machine check reporting enabled on CPU#2.
Nov  9 13:18:09 dialogsrv kernel: CPU:     After generic, caps: 3febfbff 00000000 00000000 00000000
Nov  9 13:18:09 dialogsrv kernel: CPU:             Common caps: 3febfbff 00000000 00000000 00000000
Nov  9 13:18:09 dialogsrv kernel: CPU2: Intel(R) XEON(TM) CPU 2.00GHz stepping 04
Nov  9 13:18:09 dialogsrv kernel: Total of 3 processors activated (11953.76 BogoMIPS).
Nov  9 13:18:09 dialogsrv kernel: WARNING: No sibling found for CPU 0.
Nov  9 13:18:09 dialogsrv kernel: cpu_sibling_map[1] = 2
Nov  9 13:18:09 dialogsrv kernel: cpu_sibling_map[2] = 1
Nov  9 13:18:09 dialogsrv kernel: ENABLING IO-APIC IRQs
Nov  9 13:18:09 dialogsrv kernel: init IO_APIC IRQs
Nov  9 13:18:09 dialogsrv kernel:  IO-APIC (apicid-pin) 2-0, 3-0, 3-1, 3-2, 3-3, 3-4, 3-5, 3-6, 3-7, 3-8, 3-9, 3-10, 3-11, 3-12, 3-13, 3-14, 3-15 not connected.
Nov  9 13:18:09 dialogsrv kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
Nov  9 13:18:09 dialogsrv kernel: number of MP IRQ sources: 16.
Nov  9 13:18:09 dialogsrv kernel: number of IO-APIC #2 registers: 16.
Nov  9 13:18:09 dialogsrv kernel: number of IO-APIC #3 registers: 16.
Nov  9 13:18:09 dialogsrv kernel: testing the IO APIC.......................
Nov  9 13:18:09 dialogsrv kernel: 
Nov  9 13:18:09 dialogsrv kernel: IO APIC #2......
Nov  9 13:18:09 dialogsrv kernel: .... register #00: 02000000
Nov  9 13:18:09 dialogsrv kernel: .......    : physical APIC id: 02
Nov  9 13:18:09 dialogsrv kernel: .......    : Delivery Type: 0
Nov  9 13:18:09 dialogsrv kernel: .......    : LTS          : 0
Nov  9 13:18:09 dialogsrv kernel: .... register #01: 000F0011
Nov  9 13:18:09 dialogsrv kernel: .......     : max redirection entries: 000F
Nov  9 13:18:09 dialogsrv kernel: .......     : PRQ implemented: 0
Nov  9 13:18:09 dialogsrv kernel: .......     : IO APIC version: 0011
Nov  9 13:18:09 dialogsrv kernel: .... register #02: 02000000
Nov  9 13:18:09 dialogsrv kernel: .......     : arbitration: 02
Nov  9 13:18:09 dialogsrv kernel: .... IRQ redirection table:
Nov  9 13:18:09 dialogsrv kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
Nov  9 13:18:09 dialogsrv kernel:  00 000 00  1    0    0   0   0    0    0    00
Nov  9 13:18:09 dialogsrv kernel:  01 007 07  0    0    0   0   0    1    1    39
Nov  9 13:18:09 dialogsrv kernel:  02 007 07  0    0    0   0   0    1    1    31
Nov  9 13:18:09 dialogsrv kernel:  03 007 07  0    0    0   0   0    1    1    41
Nov  9 13:18:09 dialogsrv kernel:  04 007 07  0    0    0   0   0    1    1    49
Nov  9 13:18:09 dialogsrv kernel:  05 007 07  0    0    0   0   0    1    1    51
Nov  9 13:18:09 dialogsrv kernel:  06 007 07  0    0    0   0   0    1    1    59
Nov  9 13:18:09 dialogsrv kernel:  07 007 07  0    0    0   0   0    1    1    61
Nov  9 13:18:09 dialogsrv kernel:  08 007 07  0    0    0   0   0    1    1    69
Nov  9 13:18:09 dialogsrv kernel:  09 007 07  1    1    0   1   0    1    1    71
Nov  9 13:18:09 dialogsrv kernel:  0a 007 07  0    0    0   0   0    1    1    79
Nov  9 13:18:09 dialogsrv kernel:  0b 007 07  0    0    0   0   0    1    1    81
Nov  9 13:18:09 dialogsrv kernel:  0c 007 07  0    0    0   0   0    1    1    89
Nov  9 13:18:09 dialogsrv kernel:  0d 007 07  0    0    0   0   0    1    1    91
Nov  9 13:18:09 dialogsrv kernel:  0e 007 07  0    0    0   0   0    1    1    99
Nov  9 13:18:09 dialogsrv kernel:  0f 007 07  0    0    0   0   0    1    1    A1
Nov  9 13:18:09 dialogsrv kernel: 
Nov  9 13:18:09 dialogsrv kernel: IO APIC #3......
Nov  9 13:18:09 dialogsrv kernel: .... register #00: 03000000
Nov  9 13:18:09 dialogsrv kernel: .......    : physical APIC id: 03
Nov  9 13:18:09 dialogsrv kernel: .......    : Delivery Type: 0
Nov  9 13:18:09 dialogsrv kernel: .......    : LTS          : 0
Nov  9 13:18:09 dialogsrv kernel: .... register #01: 000F0011
Nov  9 13:18:09 dialogsrv kernel: .......     : max redirection entries: 000F
Nov  9 13:18:09 dialogsrv kernel: .......     : PRQ implemented: 0
Nov  9 13:18:09 dialogsrv kernel: .......     : IO APIC version: 0011
Nov  9 13:18:09 dialogsrv kernel: .... register #02: 03000000
Nov  9 13:18:09 dialogsrv kernel: .......     : arbitration: 03
Nov  9 13:18:09 dialogsrv kernel: .... IRQ redirection table:
Nov  9 13:18:09 dialogsrv kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
Nov  9 13:18:09 dialogsrv kernel:  00 000 00  1    0    0   0   0    0    0    00
Nov  9 13:18:09 dialogsrv kernel:  01 000 00  1    0    0   0   0    0    0    00
Nov  9 13:18:09 dialogsrv kernel:  02 000 00  1    0    0   0   0    0    0    00
Nov  9 13:18:09 dialogsrv kernel:  03 000 00  1    0    0   0   0    0    0    00
Nov  9 13:18:09 dialogsrv kernel:  04 000 00  1    0    0   0   0    0    0    00
Nov  9 13:18:09 dialogsrv kernel:  05 000 00  1    0    0   0   0    0    0    00
Nov  9 13:18:09 dialogsrv kernel:  06 000 00  1    0    0   0   0    0    0    00
Nov  9 13:18:09 dialogsrv kernel:  07 000 00  1    0    0   0   0    0    0    00
Nov  9 13:18:09 dialogsrv kernel:  08 000 00  1    0    0   0   0    0    0    00
Nov  9 13:18:09 dialogsrv kernel:  09 000 00  1    0    0   0   0    0    0    00
Nov  9 13:18:09 dialogsrv kernel:  0a 000 00  1    0    0   0   0    0    0    00
Nov  9 13:18:09 dialogsrv kernel:  0b 000 00  1    0    0   0   0    0    0    00
Nov  9 13:18:09 dialogsrv kernel:  0c 000 00  1    0    0   0   0    0    0    00
Nov  9 13:18:09 dialogsrv kernel:  0d 000 00  1    0    0   0   0    0    0    00
Nov  9 13:18:09 dialogsrv kernel:  0e 000 00  1    0    0   0   0    0    0    00
Nov  9 13:18:09 dialogsrv kernel:  0f 000 00  1    0    0   0   0    0    0    00
Nov  9 13:18:09 dialogsrv kernel: IRQ to pin mappings:
Nov  9 13:18:09 dialogsrv kernel: IRQ0 -> 0:2
Nov  9 13:18:09 dialogsrv kernel: IRQ1 -> 0:1
Nov  9 13:18:09 dialogsrv kernel: IRQ3 -> 0:3
Nov  9 13:18:09 dialogsrv kernel: IRQ4 -> 0:4
Nov  9 13:18:09 dialogsrv kernel: IRQ5 -> 0:5
Nov  9 13:18:09 dialogsrv kernel: IRQ6 -> 0:6
Nov  9 13:18:09 dialogsrv kernel: IRQ7 -> 0:7
Nov  9 13:18:09 dialogsrv kernel: IRQ8 -> 0:8
Nov  9 13:18:09 dialogsrv kernel: IRQ9 -> 0:9
Nov  9 13:18:09 dialogsrv kernel: IRQ10 -> 0:10
Nov  9 13:18:09 dialogsrv kernel: IRQ11 -> 0:11
Nov  9 13:18:09 dialogsrv kernel: IRQ12 -> 0:12
Nov  9 13:18:09 dialogsrv kernel: IRQ13 -> 0:13
Nov  9 13:18:09 dialogsrv kernel: IRQ14 -> 0:14
Nov  9 13:18:09 dialogsrv kernel: IRQ15 -> 0:15
Nov  9 13:18:09 dialogsrv kernel: .................................... done.
Nov  9 13:18:09 dialogsrv kernel: Using local APIC timer interrupts.
Nov  9 13:18:09 dialogsrv kernel: calibrating APIC timer ...
Nov  9 13:18:09 dialogsrv kernel: ..... CPU clock speed is 1996.1680 MHz.
Nov  9 13:18:09 dialogsrv kernel: ..... host bus clock speed is 99.8081 MHz.
Nov  9 13:18:09 dialogsrv kernel: cpu: 0, clocks: 998081, slice: 249520
Nov  9 13:18:09 dialogsrv kernel: CPU0<T0:998080,T1:748560,D:0,S:249520,C:998081>
Nov  9 13:18:09 dialogsrv kernel: cpu: 2, clocks: 998081, slice: 249520
Nov  9 13:18:09 dialogsrv kernel: cpu: 1, clocks: 998081, slice: 249520
Nov  9 13:18:09 dialogsrv kernel: CPU1<T0:998080,T1:499040,D:0,S:249520,C:998081>
Nov  9 13:18:09 dialogsrv kernel: CPU2<T0:998080,T1:249520,D:0,S:249520,C:998081>
Nov  9 13:18:09 dialogsrv kernel: checking TSC synchronization across CPUs: passed.
Nov  9 13:18:09 dialogsrv kernel: Waiting on wait_init_idle (map = 0x6)
Nov  9 13:18:09 dialogsrv kernel: All processors have done init_idle
Nov  9 13:18:09 dialogsrv kernel: ACPI: Subsystem revision 20031002
Nov  9 13:18:09 dialogsrv kernel: PCI: PCI BIOS revision 2.10 entry at 0xfd9aa, last bus=2
Nov  9 13:18:09 dialogsrv kernel: PCI: Using configuration type 1
Nov  9 13:18:09 dialogsrv kernel:  tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Nov  9 13:18:09 dialogsrv kernel: Parsing all Control Methods:........................................................................................................
Nov  9 13:18:09 dialogsrv kernel: Table [DSDT](id F004) - 375 Objects with 41 Devices 104 Methods 7 Regions
Nov  9 13:18:09 dialogsrv kernel: ACPI Namespace successfully loaded at root c040dd1c
Nov  9 13:18:09 dialogsrv kernel: IOAPIC[0]: Set PCI routing entry (2-9 -> 0x71 -> IRQ 9 Mode:1 Active:1)
Nov  9 13:18:09 dialogsrv kernel: evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
Nov  9 13:18:09 dialogsrv kernel: evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 31 [_GPE] 4 regs at 000000000000F014 on int 9
Nov  9 13:18:09 dialogsrv kernel: evgpeblk-0748 [06] ev_create_gpe_block   : GPE 32 to 47 [_GPE] 2 regs at 0000000000000E7C on int 9
Nov  9 13:18:09 dialogsrv kernel: Completing Region/Field/Buffer/Package initialization:....................................................
Nov  9 13:18:09 dialogsrv kernel: Initialized 7/7 Regions 0/0 Fields 33/33 Buffers 12/12 Packages (383 nodes)
Nov  9 13:18:09 dialogsrv kernel: Executing all Device _STA and_INI methods:..........................................
Nov  9 13:18:09 dialogsrv kernel: 42 Devices found containing: 42 _STA, 2 _INI methods
Nov  9 13:18:09 dialogsrv kernel: ACPI: Interpreter enabled
Nov  9 13:18:09 dialogsrv kernel: ACPI: Using IOAPIC for interrupt routing
Nov  9 13:18:09 dialogsrv kernel: ACPI: System [ACPI] (supports S0 S1 S4 S5)
Nov  9 13:18:09 dialogsrv kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Nov  9 13:18:09 dialogsrv kernel: PCI: Probing PCI hardware (bus 00)
Nov  9 13:18:09 dialogsrv kernel: PCI: Ignoring BAR0-3 of IDE controller 00:0f.1
Nov  9 13:18:09 dialogsrv kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Nov  9 13:18:09 dialogsrv kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Nov  9 13:18:09 dialogsrv kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Nov  9 13:18:09 dialogsrv kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Nov  9 13:18:09 dialogsrv kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Nov  9 13:18:09 dialogsrv kernel: ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Nov  9 13:18:09 dialogsrv kernel: ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Nov  9 13:18:09 dialogsrv kernel: ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Nov  9 13:18:09 dialogsrv kernel: ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Nov  9 13:18:09 dialogsrv kernel: ACPI: PCI Interrupt Link [LNKI] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Nov  9 13:18:09 dialogsrv kernel: ACPI: PCI Interrupt Link [LNKJ] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Nov  9 13:18:09 dialogsrv kernel: ACPI: PCI Interrupt Link [LNKK] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Nov  9 13:18:09 dialogsrv kernel: ACPI: PCI Interrupt Link [LNKL] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Nov  9 13:18:09 dialogsrv kernel: ACPI: PCI Interrupt Link [LNKM] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
Nov  9 13:18:09 dialogsrv kernel: ACPI: PCI Interrupt Link [LNKN] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
Nov  9 13:18:09 dialogsrv kernel: ACPI: PCI Interrupt Link [LNKO] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
Nov  9 13:18:09 dialogsrv kernel: ACPI: PCI Interrupt Link [LNKP] (IRQs 3 4 5 6 7 9 10 11 12 14 15)
Nov  9 13:18:09 dialogsrv kernel: ACPI: PCI Root Bridge [PCIA] (00:01)
Nov  9 13:18:09 dialogsrv kernel: PCI: Probing PCI hardware (bus 01)
Nov  9 13:18:09 dialogsrv kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCIA._PRT]
Nov  9 13:18:09 dialogsrv kernel: ACPI: PCI Root Bridge [PCIB] (00:02)
Nov  9 13:18:09 dialogsrv kernel: PCI: Probing PCI hardware (bus 02)
Nov  9 13:18:09 dialogsrv kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCIB._PRT]
Nov  9 13:18:09 dialogsrv kernel: PCI: Probing PCI hardware
Nov  9 13:18:09 dialogsrv kernel: IOAPIC[1]: Set PCI routing entry (3-0 -> 0xa9 -> IRQ 16 Mode:1 Active:1)
Nov  9 13:18:09 dialogsrv kernel: 00:00:08[A] -> 3-0 -> IRQ 16
Nov  9 13:18:09 dialogsrv kernel: IOAPIC[1]: Set PCI routing entry (3-1 -> 0xb1 -> IRQ 17 Mode:1 Active:1)
Nov  9 13:18:09 dialogsrv kernel: 00:00:08[B] -> 3-1 -> IRQ 17
Nov  9 13:18:09 dialogsrv kernel: IOAPIC[1]: Set PCI routing entry (3-2 -> 0xb9 -> IRQ 18 Mode:1 Active:1)
Nov  9 13:18:09 dialogsrv kernel: 00:00:08[C] -> 3-2 -> IRQ 18
Nov  9 13:18:09 dialogsrv kernel: IOAPIC[1]: Set PCI routing entry (3-3 -> 0xc1 -> IRQ 19 Mode:1 Active:1)
Nov  9 13:18:09 dialogsrv kernel: 00:00:08[D] -> 3-3 -> IRQ 19
Nov  9 13:18:09 dialogsrv kernel: Pin 3-2 already programmed
Nov  9 13:18:09 dialogsrv kernel: Pin 3-3 already programmed
Nov  9 13:18:09 dialogsrv kernel: Pin 3-0 already programmed
Nov  9 13:18:09 dialogsrv kernel: Pin 3-1 already programmed
Nov  9 13:18:09 dialogsrv kernel: ACPI: PCI Interrupt Link [LNKM] enabled at IRQ 9
Nov  9 13:18:09 dialogsrv kernel: IOAPIC[1]: Set PCI routing entry (3-14 -> 0xc9 -> IRQ 30 Mode:1 Active:1)
Nov  9 13:18:09 dialogsrv kernel: 00:00:05[A] -> 3-14 -> IRQ 30
Nov  9 13:18:09 dialogsrv kernel: IOAPIC[1]: Set PCI routing entry (3-8 -> 0xd1 -> IRQ 24 Mode:1 Active:1)
Nov  9 13:18:09 dialogsrv kernel: 00:01:08[A] -> 3-8 -> IRQ 24
Nov  9 13:18:09 dialogsrv kernel: IOAPIC[1]: Set PCI routing entry (3-9 -> 0xd9 -> IRQ 25 Mode:1 Active:1)
Nov  9 13:18:09 dialogsrv kernel: 00:01:08[B] -> 3-9 -> IRQ 25
Nov  9 13:18:09 dialogsrv kernel: IOAPIC[1]: Set PCI routing entry (3-10 -> 0xe1 -> IRQ 26 Mode:1 Active:1)
Nov  9 13:18:09 dialogsrv kernel: 00:01:08[C] -> 3-10 -> IRQ 26
Nov  9 13:18:09 dialogsrv kernel: IOAPIC[1]: Set PCI routing entry (3-11 -> 0xe9 -> IRQ 27 Mode:1 Active:1)
Nov  9 13:18:09 dialogsrv kernel: 00:01:08[D] -> 3-11 -> IRQ 27
Nov  9 13:18:09 dialogsrv kernel: Pin 3-10 already programmed
Nov  9 13:18:09 dialogsrv kernel: Pin 3-11 already programmed
Nov  9 13:18:09 dialogsrv kernel: Pin 3-8 already programmed
Nov  9 13:18:09 dialogsrv kernel: Pin 3-9 already programmed
Nov  9 13:18:09 dialogsrv kernel: Pin 3-11 already programmed
Nov  9 13:18:09 dialogsrv kernel: Pin 3-8 already programmed
Nov  9 13:18:09 dialogsrv kernel: Pin 3-9 already programmed
Nov  9 13:18:09 dialogsrv kernel: Pin 3-10 already programmed
Nov  9 13:18:09 dialogsrv kernel: Pin 3-8 already programmed
Nov  9 13:18:09 dialogsrv kernel: Pin 3-9 already programmed
Nov  9 13:18:09 dialogsrv kernel: Pin 3-10 already programmed
Nov  9 13:18:09 dialogsrv kernel: Pin 3-11 already programmed
Nov  9 13:18:09 dialogsrv kernel: Pin 3-9 already programmed
Nov  9 13:18:09 dialogsrv kernel: Pin 3-10 already programmed
Nov  9 13:18:09 dialogsrv kernel: Pin 3-11 already programmed
Nov  9 13:18:09 dialogsrv kernel: Pin 3-8 already programmed
Nov  9 13:18:09 dialogsrv kernel: IOAPIC[1]: Set PCI routing entry (3-4 -> 0x32 -> IRQ 20 Mode:1 Active:1)
Nov  9 13:18:09 dialogsrv kernel: 00:02:08[A] -> 3-4 -> IRQ 20
Nov  9 13:18:09 dialogsrv kernel: IOAPIC[1]: Set PCI routing entry (3-5 -> 0x3a -> IRQ 21 Mode:1 Active:1)
Nov  9 13:18:09 dialogsrv kernel: 00:02:08[B] -> 3-5 -> IRQ 21
Nov  9 13:18:09 dialogsrv kernel: IOAPIC[1]: Set PCI routing entry (3-6 -> 0x42 -> IRQ 22 Mode:1 Active:1)
Nov  9 13:18:09 dialogsrv kernel: 00:02:08[C] -> 3-6 -> IRQ 22
Nov  9 13:18:09 dialogsrv kernel: IOAPIC[1]: Set PCI routing entry (3-7 -> 0x4a -> IRQ 23 Mode:1 Active:1)
Nov  9 13:18:09 dialogsrv kernel: 00:02:08[D] -> 3-7 -> IRQ 23
Nov  9 13:18:09 dialogsrv kernel: Pin 3-6 already programmed
Nov  9 13:18:09 dialogsrv kernel: Pin 3-7 already programmed
Nov  9 13:18:09 dialogsrv kernel: Pin 3-4 already programmed
Nov  9 13:18:09 dialogsrv kernel: Pin 3-5 already programmed
Nov  9 13:18:09 dialogsrv kernel: IOAPIC[1]: Set PCI routing entry (3-13 -> 0x52 -> IRQ 29 Mode:1 Active:1)
Nov  9 13:18:09 dialogsrv kernel: 00:02:0a[A] -> 3-13 -> IRQ 29
Nov  9 13:18:09 dialogsrv kernel: PCI: Using ACPI for IRQ routing

And /proc/cpuinfo:

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) XEON(TM) CPU 2.00GHz
stepping        : 4
cpu MHz         : 1996.220
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 3984.58

<exactly the same for cpu 1 and 2>

MfG,
Eduard.
