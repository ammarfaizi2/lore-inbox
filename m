Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWHWAj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWHWAj4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 20:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWHWAj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 20:39:56 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:31880 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932087AbWHWAjz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 20:39:55 -0400
Subject: [Bug] 2.6.18-rc4-mm2 panic in __unix_insert_socket x86_64
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: andrew <akpm@osdl.org>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Tue, 22 Aug 2006 17:39:52 -0700
Message-Id: <1156293593.11365.12.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  Something from mm1 to mm2 brought this bug out. I didn't see any
change in the unix socket code so I am not sure where to start. I am
going to start bisecting patches. 2.6.18-rc4-mm1 was working as
expected.  I have already stepped around afs and smp alternatives errors
but I haven't seen any errors related to this posted yet. 

 Any ideas?

Unable to handle kernel NULL pointer dereference at 0000000000000007
RIP:
 [<ffffffff803d45b0>] __unix_insert_socket+0x49/0x5a
PGD 115c934067 PUD 115c935067 PMD 0
Oops: 0002 [1] SMP
last sysfs file:
CPU 14
Modules linked in:
Pid: 1, comm: init Not tainted 2.6.18-rc4-mm2-smp #3
RIP: 0010:[<ffffffff803d45b0>]  [<ffffffff803d45b0>]
__unix_insert_socket+0x49/0x5a
RSP: 0018:ffff810460605eb8  EFLAGS: 00010286
RAX: ffffffffffffffff RBX: ffff81115c171c80 RCX: 0000000000000000
RDX: ffff81115c171c88 RSI: ffff81115c171c80 RDI: ffffffff806656e0
RBP: ffffffff806656e0 R08: ffff81115c069200 R09: ffff8110700b4000
R10: 0000000000000000 R11: 0000000000000002 R12: ffff81115c170d00
R13: 0000000000000001 R14: 0000000000000001 R15: 0000000000000000
FS:  00002b793a4fd6d0(0000) GS:ffff81115c910e40(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000007 CR3: 000000115c92d000 CR4: 00000000000006e0
Process init (pid: 1, threadinfo ffff810460604000, task
ffff81115cb10040)
Stack:  0000000100000001 00000000ffffffff ffff81115c171c80
ffffffff803d58e9
 ffffffff8045bb30 0000000180298f61 ffffffff80498080 0000000000000001
 ffff81115c170d00 ffffffff803d595d 0000000000000004 ffffffff80376061
Call Trace:
 [<ffffffff803d58e9>] unix_create1+0xf3/0x107
 [<ffffffff803d595d>] unix_create+0x60/0x6b
 [<ffffffff80376061>] __sock_create+0x12f/0x227
 [<ffffffff80376429>] sys_socket+0xf/0x37
 [<ffffffff8020968e>] system_call+0x7e/0x83


Code: 48 89 50 08 48 89 55 00 48 89 6a 08 41 58 5b 5d c3 c7 47 08
RIP  [<ffffffff803d45b0>] __unix_insert_socket+0x49/0x5a
 RSP <ffff810460605eb8>
CR2: 0000000000000007
 <0>Kernel panic - not syncing: Attempted to kill init!


See full dmesg below. 

disabling early console
Linux version 2.6.18-rc4-mm2-smp (root@elm3a153) (gcc version 4.1.0
(SUSE Linux)) #3 SMP Tue Aug 22 17:58:53 EDT 2006
Command line: root=/dev/sda3
ip=9.47.66.153:9.47.66.169:9.47.66.1:255.255.255.0 resume=/dev/sda2
showopts earlyprintk=ttyS0,115200 console=ttyS0,115200 console=tty0
debug
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 0000000000098400 (usable)
 BIOS-e820: 0000000000098400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007ff85e00 (usable)
 BIOS-e820: 000000007ff85e00 - 000000007ff98880 (ACPI data)
 BIOS-e820: 000000007ff98880 - 0000000080000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 0000000470000000 (usable)
 BIOS-e820: 0000001070000000 - 0000001160000000 (usable)
DMI 2.3 present.
ACPI: RSDP (v000 IBM                                   ) @
0x00000000000fdcf0
ACPI: RSDT (v001 IBM    EXA01ZEU 0x00001000 IBM  0x45444f43) @
0x000000007ff98800
ACPI: FADT (v001 IBM    EXA01ZEU 0x00001000 IBM  0x45444f43) @
0x000000007ff98780
ACPI: MADT (v001 IBM    EXA01ZEU 0x00001000 IBM  0x45444f43) @
0x000000007ff98600
ACPI: SRAT (v001 IBM    EXA01ZEU 0x00001000 IBM  0x45444f43) @
0x000000007ff983c0
ACPI: HPET (v001 IBM    EXA01ZEU 0x00001000 IBM  0x45444f43) @
0x000000007ff98380
ACPI: SSDT (v001 IBM    VIGSSDT0 0x00001000 INTL 0x20030122) @
0x000000007ff90780
ACPI: SSDT (v001 IBM    VIGSSDT1 0x00001000 INTL 0x20030122) @
0x000000007ff88bc0
ACPI: DSDT (v001 IBM    EXA01ZEU 0x00001000 INTL 0x20030122) @
0x0000000000000000
SRAT: PXM 0 -> APIC 0 -> Node 0
SRAT: PXM 0 -> APIC 1 -> Node 0
SRAT: PXM 0 -> APIC 2 -> Node 0
SRAT: PXM 0 -> APIC 3 -> Node 0
SRAT: PXM 0 -> APIC 38 -> Node 0
SRAT: PXM 0 -> APIC 39 -> Node 0
SRAT: PXM 0 -> APIC 36 -> Node 0
SRAT: PXM 0 -> APIC 37 -> Node 0
SRAT: PXM 1 -> APIC 64 -> Node 1
SRAT: PXM 1 -> APIC 65 -> Node 1
SRAT: PXM 1 -> APIC 66 -> Node 1
SRAT: PXM 1 -> APIC 67 -> Node 1
SRAT: PXM 1 -> APIC 102 -> Node 1
SRAT: PXM 1 -> APIC 103 -> Node 1
SRAT: PXM 1 -> APIC 100 -> Node 1
SRAT: PXM 1 -> APIC 101 -> Node 1
SRAT: Node 0 PXM 0 0-80000000
SRAT: Node 0 PXM 0 0-470000000
SRAT: Node 1 PXM 1 1070000000-1160000000
NUMA: Using 36 for the hash shift.
Bootmem setup node 0 0000000000000000-0000000470000000
Bootmem setup node 1 0000001070000000-0000001160000000
On node 0 totalpages: 4063507
  DMA zone: 2518 pages, LIFO batch:0
  DMA32 zone: 505789 pages, LIFO batch:31
  Normal zone: 3555200 pages, LIFO batch:31
On node 1 totalpages: 969600
  Normal zone: 969600 pages, LIFO batch:31
ACPI: PM-Timer IO Port: 0x9c
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
Processor #2 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
Processor #3 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x26] enabled)
Processor #38 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x27] enabled)
Processor #39 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x06] lapic_id[0x24] enabled)
Processor #36 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x07] lapic_id[0x25] enabled)
Processor #37 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x10] lapic_id[0x40] enabled)
Processor #64 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x11] lapic_id[0x41] enabled)
Processor #65 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x12] lapic_id[0x42] enabled)
Processor #66 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x13] lapic_id[0x43] enabled)
Processor #67 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x14] lapic_id[0x66] enabled)
Processor #102 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x15] lapic_id[0x67] enabled)
Processor #103 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x16] lapic_id[0x64] enabled)
Processor #100 15:4 APIC version 20
ACPI: LAPIC (acpi_id[0x17] lapic_id[0x65] enabled)
Processor #101 15:4 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x04] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x05] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x06] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x07] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x10] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x11] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x12] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x13] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x14] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x15] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x16] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x17] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x0f] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 15, version 17, address 0xfec00000, GSI 0-35
ACPI: IOAPIC (id[0x0e] address[0xfec01000] gsi_base[36])
IOAPIC[1]: apic_id 14, version 17, address 0xfec01000, GSI 36-71
ACPI: IOAPIC (id[0x0d] address[0xfec02000] gsi_base[72])
IOAPIC[2]: apic_id 13, version 17, address 0xfec02000, GSI 72-107
ACPI: IOAPIC (id[0x0c] address[0xfec03000] gsi_base[108])
IOAPIC[3]: apic_id 12, version 17, address 0xfec03000, GSI 108-143
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 8 global_irq 8 low edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 low edge)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ8 used by override.
ACPI: IRQ9 used by override.
ACPI: IRQ14 used by override.
Setting APIC routing to clustered
ACPI: HPET id: 0x10142201 base: 0xfde84000
Using ACPI (MADT) for SMP configuration information
Nosave address range: 0000000000098000 - 0000000000099000
Nosave address range: 0000000000099000 - 00000000000a0000
Nosave address range: 00000000000a0000 - 00000000000e0000
Nosave address range: 00000000000e0000 - 0000000000100000
Nosave address range: 000000007ff85000 - 000000007ff86000
Nosave address range: 000000007ff86000 - 000000007ff98000
Nosave address range: 000000007ff98000 - 000000007ff99000
Nosave address range: 000000007ff99000 - 0000000080000000
Nosave address range: 0000000080000000 - 00000000fec00000
Nosave address range: 00000000fec00000 - 0000000100000000
Nosave address range: 0000000470000000 - 0000001070000000
Allocating PCI resources starting at 88000000 (gap: 80000000:7ec00000)
SMP: Allowing 16 CPUs, 0 hotplug CPUs
PERCPU: Allocating 49792 bytes of per cpu data
Built 2 zonelists.  Total pages: 5033107
Kernel command line: root=/dev/sda3
ip=9.47.66.153:9.47.66.169:9.47.66.1:255.255.255.0 resume=/dev/sda2
showopts earlyprintk=ttyS0,115200 console=ttyS0,115200 console=tty0
debug
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
disabling early console
Console: colour VGA+ 80x25
Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes)
Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes)
Checking aperture...
PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
Placing software IO TLB between 0x409d000 - 0x809d000
Memory: 20013348k/72876032k available (1922k kernel code, 432976k
reserved, 928k data, 184k init)
Calibrating delay using timer specific routine.. 6011.54 BogoMIPS
(lpj=12023094)Security Framework v1.0.0 initialized
Mount-cache hash table entries: 256
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU 0/0 -> Node 0
using mwait in idle threads.
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU0: Thermal monitoring enabled (TM1)
SMP alternatives: switching to UP code
ACPI: Core revision 20060707
..MP-BIOS bug: 8254 timer not connected to IO-APIC
Using local APIC timer interrupts.
result 10425670
Detected 10.425 MHz APIC timer.
SMP alternatives: switching to SMP code
Booting processor 1/16 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 6005.42 BogoMIPS
(lpj=12010849)CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU 1/1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
CPU1: Thermal monitoring enabled (TM1)
                   Genuine Intel(R) CPU 3.00GHz stepping 08
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff -103 cycles, maxerr 936
cycles)
SMP alternatives: switching to SMP code
Booting processor 2/16 APIC 0x2
Initializing CPU#2
Calibrating delay using timer specific routine.. 6005.62 BogoMIPS
(lpj=12011251)CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU 2/2 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU2: Thermal monitoring enabled (TM1)
                   Genuine Intel(R) CPU 3.00GHz stepping 08
CPU 2: Syncing TSC to CPU 0.
CPU 2: synchronized TSC with CPU 0 (last diff 90 cycles, maxerr 1620
cycles)
SMP alternatives: switching to SMP code
Booting processor 3/16 APIC 0x3
Initializing CPU#3
Calibrating delay using timer specific routine.. 6005.69 BogoMIPS
(lpj=12011390)CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU 3/3 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
CPU3: Thermal monitoring enabled (TM1)
                   Genuine Intel(R) CPU 3.00GHz stepping 08
CPU 3: Syncing TSC to CPU 0.
CPU 3: synchronized TSC with CPU 0 (last diff 40 cycles, maxerr 1611
cycles)
SMP alternatives: switching to SMP code
Booting processor 4/16 APIC 0x26
Initializing CPU#4
Calibrating delay using timer specific routine.. 6005.56 BogoMIPS
(lpj=12011139)CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU 4/26 -> Node 0
CPU: Physical Processor ID: 9
CPU: Processor Core ID: 1
CPU4: Thermal monitoring enabled (TM1)
                   Genuine Intel(R) CPU 3.00GHz stepping 08
CPU 4: Syncing TSC to CPU 0.
CPU 4: synchronized TSC with CPU 0 (last diff -23 cycles, maxerr 1593
cycles)
SMP alternatives: switching to SMP code
Booting processor 5/16 APIC 0x27
Initializing CPU#5
Calibrating delay using timer specific routine.. 6005.64 BogoMIPS
(lpj=12011290)CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU 5/27 -> Node 0
CPU: Physical Processor ID: 9
CPU: Processor Core ID: 1
CPU5: Thermal monitoring enabled (TM1)
                   Genuine Intel(R) CPU 3.00GHz stepping 08
CPU 5: Syncing TSC to CPU 0.
CPU 5: synchronized TSC with CPU 0 (last diff 72 cycles, maxerr 1584
cycles)
SMP alternatives: switching to SMP code
Booting processor 6/16 APIC 0x24
Initializing CPU#6
Calibrating delay using timer specific routine.. 6005.71 BogoMIPS
(lpj=12011431)CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU 6/24 -> Node 0
CPU: Physical Processor ID: 9
CPU: Processor Core ID: 0
CPU6: Thermal monitoring enabled (TM1)
                   Genuine Intel(R) CPU 3.00GHz stepping 08
CPU 6: Syncing TSC to CPU 0.
CPU 6: synchronized TSC with CPU 0 (last diff 40 cycles, maxerr 1593
cycles)
SMP alternatives: switching to SMP code
Booting processor 7/16 APIC 0x25
Initializing CPU#7
Calibrating delay using timer specific routine.. 6005.73 BogoMIPS
(lpj=12011473)CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU 7/25 -> Node 0
CPU: Physical Processor ID: 9
CPU: Processor Core ID: 0
CPU7: Thermal monitoring enabled (TM1)
                   Genuine Intel(R) CPU 3.00GHz stepping 08
CPU 7: Syncing TSC to CPU 0.
CPU 7: synchronized TSC with CPU 0 (last diff 144 cycles, maxerr 1782
cycles)
SMP alternatives: switching to SMP code
Booting processor 8/16 APIC 0x40
Initializing CPU#8
Calibrating delay using timer specific routine.. 6005.91 BogoMIPS
(lpj=12011838)CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU 8/40 -> Node 1
CPU: Physical Processor ID: 16
CPU: Processor Core ID: 0
CPU8: Thermal monitoring enabled (TM1)
                   Genuine Intel(R) CPU 3.00GHz stepping 08
CPU 8: Syncing TSC to CPU 0.
CPU 8: synchronized TSC with CPU 0 (last diff 102 cycles, maxerr 4356
cycles)
SMP alternatives: switching to SMP code
Booting processor 9/16 APIC 0x41
Initializing CPU#9
Calibrating delay using timer specific routine.. 6005.99 BogoMIPS
(lpj=12011998)CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU 9/41 -> Node 1
CPU: Physical Processor ID: 16
CPU: Processor Core ID: 0
CPU9: Thermal monitoring enabled (TM1)
                   Genuine Intel(R) CPU 3.00GHz stepping 08
CPU 9: Syncing TSC to CPU 0.
CPU 9: synchronized TSC with CPU 0 (last diff 283 cycles, maxerr 4275
cycles)
SMP alternatives: switching to SMP code
Booting processor 10/16 APIC 0x42
Initializing CPU#10
Calibrating delay using timer specific routine.. 6005.76 BogoMIPS
(lpj=12011532)CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU 10/42 -> Node 1
CPU: Physical Processor ID: 16
CPU: Processor Core ID: 1
CPU10: Thermal monitoring enabled (TM1)
                   Genuine Intel(R) CPU 3.00GHz stepping 08
CPU 10: Syncing TSC to CPU 0.
CPU 10: synchronized TSC with CPU 0 (last diff 272 cycles, maxerr 4338
cycles)
SMP alternatives: switching to SMP code
Booting processor 11/16 APIC 0x43
Initializing CPU#11
Calibrating delay using timer specific routine.. 6005.85 BogoMIPS
(lpj=12011702)CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU 11/43 -> Node 1
CPU: Physical Processor ID: 16
CPU: Processor Core ID: 1
CPU11: Thermal monitoring enabled (TM1)
                   Genuine Intel(R) CPU 3.00GHz stepping 08
CPU 11: Syncing TSC to CPU 0.
CPU 11: synchronized TSC with CPU 0 (last diff 125 cycles, maxerr 4716
cycles)
SMP alternatives: switching to SMP code
Booting processor 12/16 APIC 0x66
Initializing CPU#12
Calibrating delay using timer specific routine.. 6005.93 BogoMIPS
(lpj=12011875)CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU 12/66 -> Node 1
CPU: Physical Processor ID: 25
CPU: Processor Core ID: 1
CPU12: Thermal monitoring enabled (TM1)
                   Genuine Intel(R) CPU 3.00GHz stepping 08
CPU 12: Syncing TSC to CPU 0.
CPU 12: synchronized TSC with CPU 0 (last diff -14 cycles, maxerr 4689
cycles)
SMP alternatives: switching to SMP code
Booting processor 13/16 APIC 0x67
Initializing CPU#13
Calibrating delay using timer specific routine.. 6006.06 BogoMIPS
(lpj=12012123)CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU 13/67 -> Node 1
CPU: Physical Processor ID: 25
CPU: Processor Core ID: 1
CPU13: Thermal monitoring enabled (TM1)
                   Genuine Intel(R) CPU 3.00GHz stepping 08
CPU 13: Syncing TSC to CPU 0.
CPU 13: synchronized TSC with CPU 0 (last diff 110 cycles, maxerr 4725
cycles)
SMP alternatives: switching to SMP code
Booting processor 14/16 APIC 0x64
Initializing CPU#14
Calibrating delay using timer specific routine.. 6005.67 BogoMIPS
(lpj=12011349)CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU 14/64 -> Node 1
CPU: Physical Processor ID: 25
CPU: Processor Core ID: 0
CPU14: Thermal monitoring enabled (TM1)
                   Genuine Intel(R) CPU 3.00GHz stepping 08
CPU 14: Syncing TSC to CPU 0.
CPU 14: synchronized TSC with CPU 0 (last diff 64 cycles, maxerr 4698
cycles)
SMP alternatives: switching to SMP code
Booting processor 15/16 APIC 0x65
Initializing CPU#15
Calibrating delay using timer specific routine.. 6005.80 BogoMIPS
(lpj=12011600)CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 2048K
CPU 15/65 -> Node 1
CPU: Physical Processor ID: 25
CPU: Processor Core ID: 0
CPU15: Thermal monitoring enabled (TM1)
                   Genuine Intel(R) CPU 3.00GHz stepping 08
CPU 15: Syncing TSC to CPU 0.
CPU 15: synchronized TSC with CPU 0 (last diff 275 cycles, maxerr 4356
cycles)
Brought up 16 CPUs
testing NMI watchdog ... OK.
time.c: Using 333.333333 MHz WALL PIT GTOD PIT/HPET timer.
time.c: Detected 3002.613 MHz processor.
migration_cost=15,1006,15011
checking if image is initramfs... it is
Freeing initrd memory: 2769k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [VP00] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:01.0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:0f.1
ACPI: PCI Interrupt Routing Table [\_SB_.VP00._PRT]
ACPI: PCI Root Bridge [VP01] (0000:01)
PCI: Probing PCI hardware (bus 01)
ACPI: PCI Interrupt Routing Table [\_SB_.VP01._PRT]
ACPI: PCI Root Bridge [VP02] (0000:02)
PCI: Probing PCI hardware (bus 02)
ACPI: PCI Interrupt Routing Table [\_SB_.VP02._PRT]
ACPI: PCI Root Bridge [VP03] (0000:04)
PCI: Probing PCI hardware (bus 04)
ACPI: PCI Interrupt Routing Table [\_SB_.VP03._PRT]
ACPI: PCI Root Bridge [VP04] (0000:06)
PCI: Probing PCI hardware (bus 06)
ACPI: PCI Interrupt Routing Table [\_SB_.VP04._PRT]
ACPI: PCI Root Bridge [VP05] (0000:08)
PCI: Probing PCI hardware (bus 08)
ACPI: PCI Interrupt Routing Table [\_SB_.VP05._PRT]
ACPI: PCI Root Bridge [VP06] (0000:0a)
PCI: Probing PCI hardware (bus 0a)
ACPI: PCI Interrupt Routing Table [\_SB_.VP06._PRT]
ACPI: PCI Root Bridge [VP07] (0000:0c)
PCI: Probing PCI hardware (bus 0c)
ACPI: PCI Interrupt Routing Table [\_SB_.VP07._PRT]
ACPI: PCI Root Bridge [VP10] (0000:0e)
PCI: Probing PCI hardware (bus 0e)
ACPI: PCI Interrupt Routing Table [\_SB_.VP10._PRT]
ACPI: PCI Root Bridge [VP11] (0000:0f)
PCI: Probing PCI hardware (bus 0f)
ACPI: PCI Interrupt Routing Table [\_SB_.VP11._PRT]
ACPI: PCI Root Bridge [VP12] (0000:10)
PCI: Probing PCI hardware (bus 10)
ACPI: PCI Interrupt Routing Table [\_SB_.VP12._PRT]
ACPI: PCI Root Bridge [VP13] (0000:12)
PCI: Probing PCI hardware (bus 12)
ACPI: PCI Interrupt Routing Table [\_SB_.VP13._PRT]
ACPI: PCI Root Bridge [VP14] (0000:14)
PCI: Probing PCI hardware (bus 14)
ACPI: PCI Interrupt Routing Table [\_SB_.VP14._PRT]
ACPI: PCI Root Bridge [VP15] (0000:16)
PCI: Probing PCI hardware (bus 16)
ACPI: PCI Interrupt Routing Table [\_SB_.VP15._PRT]
ACPI: PCI Root Bridge [VP16] (0000:18)
PCI: Probing PCI hardware (bus 18)
ACPI: PCI Interrupt Routing Table [\_SB_.VP16._PRT]
ACPI: PCI Root Bridge [VP17] (0000:1a)
PCI: Probing PCI hardware (bus 1a)
ACPI: PCI Interrupt Routing Table [\_SB_.VP17._PRT]
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a
report
hpet0: at MMIO 0xfde84000, IRQs 2, 8, 0
hpet0: 3 64-bit timers, 3707069 Hz
PCI-GART: No AMD northbridge found.
NET: Registered protocol family 2
IP route cache hash table entries: 524288 (order: 10, 4194304 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
audit: initializing netlink socket (disabled)
audit(1156286435.128:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Hotplug Mem Device
System RAM resource 400000000 - 46fffffff cannot be added
System RAM resource 380000000 - 3ffffffff cannot be added
System RAM resource 300000000 - 37fffffff cannot be added
System RAM resource 280000000 - 2ffffffff cannot be added
System RAM resource 200000000 - 27fffffff cannot be added
System RAM resource 180000000 - 1ffffffff cannot be added
System RAM resource 100000000 - 17fffffff cannot be added
System RAM resource 100000 - 7fffffff cannot be added
ACPI: add_memory failed
Hotplug Mem Device
System RAM resource 10f0000000 - 115fffffff cannot be added
System RAM resource 1070000000 - 10efffffff cannot be added
ACPI: add_memory failed
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing
disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 128000K size 1024 blocksize
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input0
input: AT Translated Set 2 keyboard as /class/input/input1
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
NET: Registered protocol family 1
ACPI: (supports S0 S5)
input: ImExPS/2 Generic Explorer Mouse as /class/input/input2
IP-Config: No network devices available.
Freeing unused kernel memory: 184k freed
Unable to handle kernel NULL pointer dereference at 0000000000000007
RIP:
 [<ffffffff803d45b0>] __unix_insert_socket+0x49/0x5a
PGD 115c934067 PUD 115c935067 PMD 0
Oops: 0002 [1] SMP
last sysfs file:
CPU 14
Modules linked in:
Pid: 1, comm: init Not tainted 2.6.18-rc4-mm2-smp #3
RIP: 0010:[<ffffffff803d45b0>]  [<ffffffff803d45b0>]
__unix_insert_socket+0x49/0x5a
RSP: 0018:ffff810460605eb8  EFLAGS: 00010286
RAX: ffffffffffffffff RBX: ffff81115c171c80 RCX: 0000000000000000
RDX: ffff81115c171c88 RSI: ffff81115c171c80 RDI: ffffffff806656e0
RBP: ffffffff806656e0 R08: ffff81115c069200 R09: ffff8110700b4000
R10: 0000000000000000 R11: 0000000000000002 R12: ffff81115c170d00
R13: 0000000000000001 R14: 0000000000000001 R15: 0000000000000000
FS:  00002b793a4fd6d0(0000) GS:ffff81115c910e40(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000000007 CR3: 000000115c92d000 CR4: 00000000000006e0
Process init (pid: 1, threadinfo ffff810460604000, task
ffff81115cb10040)
Stack:  0000000100000001 00000000ffffffff ffff81115c171c80
ffffffff803d58e9
 ffffffff8045bb30 0000000180298f61 ffffffff80498080 0000000000000001
 ffff81115c170d00 ffffffff803d595d 0000000000000004 ffffffff80376061
Call Trace:
 [<ffffffff803d58e9>] unix_create1+0xf3/0x107
 [<ffffffff803d595d>] unix_create+0x60/0x6b
 [<ffffffff80376061>] __sock_create+0x12f/0x227
 [<ffffffff80376429>] sys_socket+0xf/0x37
 [<ffffffff8020968e>] system_call+0x7e/0x83


Code: 48 89 50 08 48 89 55 00 48 89 6a 08 41 58 5b 5d c3 c7 47 08
RIP  [<ffffffff803d45b0>] __unix_insert_socket+0x49/0x5a
 RSP <ffff810460605eb8>
CR2: 0000000000000007
 <0>Kernel panic - not syncing: Attempted to kill init!

-- 
keith mannthey <kmannth@us.ibm.com>
Linux Technology Center IBM

