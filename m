Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWIVARg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWIVARg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 20:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932133AbWIVARg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 20:17:36 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:48067 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932132AbWIVARe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 20:17:34 -0400
Subject: [BUG] i386 2.6.18 cpu_up: attempt to bring up CPU 4 failed :
	kernel BUG at mm/slab.c:2698!
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Thu, 21 Sep 2006 17:17:31 -0700
Message-Id: <1158884252.5657.38.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wanted to just give 2.6.18 a spin and I tripped over something I
didn't expect. 


cpu_up: attempt to bring up CPU 4 failed
kfree_debugcheck: bad ptr c15f6000h.
------------[ cut here ]------------
kernel BUG at mm/slab.c:2698!
invalid opcode: 0000 [#1]
SMP
Modules linked in:
CPU:    0
EIP:    0060:[<c106ce51>]    Not tainted VLI
EFLAGS: 00010046   (2.6.18 #1)
EIP is at kfree_debugcheck+0x7f/0x90
eax: 00000028   ebx: 000015f6   ecx: c1025289   edx: c7653540
esi: c15f6000   edi: c15f6000   ebp: c764af38   esp: c764af28
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, ti=c764a000 task=c7653540 task.ti=c764a000)
Stack: c122c68d c15f6000 c1635000 00000004 c764af5c c106ef93 00000286
c76a77d0
       00000004 00000001 c1635000 00000004 00000004 c764af6c c10557f6
c1274eac
       c12743dc c764af84 c1207467 00000004 c12734c0 00000004 00000004
c764af98
Call Trace:
 [<c106ef93>] kfree+0x24/0x1d8
 [<c10557f6>] pageset_cpuup_callback+0x40/0x58
 [<c1207467>] notifier_call_chain+0x20/0x31
 [<c1031530>] blocking_notifier_call_chain+0x1d/0x2d
 [<c103f80c>] cpu_up+0xb5/0xcf
 [<c1000372>] init+0x78/0x296
 [<c1002005>] kernel_thread_helper+0x5/0xb
DWARF2 unwinder stuck at kernel_thread_helper+0x5/0xb
Leftover inexact backtrace:
 [<c1005076>] show_stack_log_lvl+0x8a/0x95
 [<c10051ae>] show_registers+0x12d/0x19a
 [<c100539c>] die+0x181/0x284
 [<c12062b2>] do_trap+0x7c/0x96
 [<c1005b83>] do_invalid_op+0x89/0x93
 [<c1004a79>] error_code+0x39/0x40
 [<c106ef93>] kfree+0x24/0x1d8
 [<c10557f6>] pageset_cpuup_callback+0x40/0x58
 [<c1207467>] notifier_call_chain+0x20/0x31
 [<c1031530>] blocking_notifier_call_chain+0x1d/0x2d
 [<c103f80c>] cpu_up+0xb5/0xcf
 [<c1000372>] init+0x78/0x296
 [<c1002005>] kernel_thread_helper+0x5/0xb
Code: 40 67 31 c1 8b 14 85 80 68 31 c1 2b 9a a0 0e 00 00 6b c3 34 03 82
98 0e 00 00 8b 00 84 c0 78 15 56 68 8d c6 22 c1 e8 f5 8a fb ff <0f> 0b
8a 0a f9 c5 22 c1 58 5a 8d 65 f8 5b 5e 5d c3 55 89 e5 57
EIP: [<c106ce51>] kfree_debugcheck+0x7f/0x90 SS:ESP 0068:c764af28
 <0>Kernel panic - not syncing: Attempted to kill init!
 BUG: warning at arch/i386/kernel/smp.c:547/smp_call_function()
 [<c1004eda>] show_trace_log_lvl+0x58/0x16a
 [<c10054d8>] show_trace+0xd/0x10
 [<c10055e8>] dump_stack+0x19/0x1b
 [<c10159a0>] smp_call_function+0x4f/0xbc
 [<c1015a23>] smp_send_stop+0x16/0x2a
 [<c1024eed>] panic+0x4d/0xec
 [<c1027a91>] do_exit+0x71/0x7c3
 [<c1005479>] die+0x25e/0x284
 [<c12062b2>] do_trap+0x7c/0x96
 [<c1005b83>] do_invalid_op+0x89/0x93
 [<c1004a79>] error_code+0x39/0x40
DWARF2 unwinder stuck at error_code+0x39/0x40
Leftover inexact backtrace:
 [<c10054d8>] show_trace+0xd/0x10
 [<c10055e8>] dump_stack+0x19/0x1b
 [<c10159a0>] smp_call_function+0x4f/0xbc
 [<c1015a23>] smp_send_stop+0x16/0x2a
 [<c1024eed>] panic+0x4d/0xec
 [<c1027a91>] do_exit+0x71/0x7c3
 [<c1005479>] die+0x25e/0x284
 [<c12062b2>] do_trap+0x7c/0x96
 [<c1005b83>] do_invalid_op+0x89/0x93
 [<c1004a79>] error_code+0x39/0x40
 [<c106ef93>] kfree+0x24/0x1d8
 [<c10557f6>] pageset_cpuup_callback+0x40/0x58
 [<c1207467>] notifier_call_chain+0x20/0x31
 [<c1031530>] blocking_notifier_call_chain+0x1d/0x2d
 [<c103f80c>] cpu_up+0xb5/0xcf
 [<c1000372>] init+0x78/0x296
 [<c1002005>] kernel_thread_helper+0x5/0xb


  This box was booting 2.6.18-rc6-mm2 with some help just fine.  There
are a few outstanding issues but I know about them already.  This looks
to be something else. 

  I haven't booted a non-mm tree on this box in a while (but I know
2.6.17 worked). Is this something all all ready sorted out and soon to
be pushed upstream?

Thanks,
  Keith 

Linux version 2.6.18 (root@elm3a25) (gcc version 4.1.1 20060817 (Red Hat
4.1.1-18)) #1 SMP Thu Sep 21 02:08:47 PDT 2006 BIOS-provided physical
RAM map:  BIOS-e820: 0000000000000000 - 000000000009c400 (usable)  BIOS-
e820: 000000000009c400 - 00000000000a0000 (reserved)  BIOS-e820:
00000000000e0000 - 0000000000100000 (reserved)  BIOS-e820:
0000000000100000 - 00000000eff91840 (usable)  BIOS-e820:
00000000eff91840 - 00000000eff9c340 (ACPI data)  BIOS-e820:
00000000eff9c340 - 00000000f0000000 (reserved)  BIOS-e820:
00000000fec00000 - 0000000100000000 (reserved)  BIOS-e820:
0000000100000000 - 00000001d0000000 (usable) Node: 0, start_pfn: 0,
end_pfn: 156 Node: 0, start_pfn: 256, end_pfn: 982929 Node: 0,
start_pfn: 1048576, end_pfn: 1900544
get_memcfg_from_srat: assigning address to rsdp
RSD PTR  v0 [IBM   ]
ACPI: RSDT signature incorrect
failed to get NUMA memory information from SRAT table
NUMA - single node, flat memory mode
Node: 0, start_pfn: 0, end_pfn: 156
Node: 0, start_pfn: 256, end_pfn: 982929
Node: 0, start_pfn: 1048576, end_pfn: 1900544
Node: 0, start_pfn: 0, end_pfn: 1900544
Reserving 512 pages of KVA for lmem_map of node 0
Shrinking node 0 from 1900544 pages to 1900032 pages
Reserving total of 512 pages for numa KVA remap
reserve_pages = 512 find_max_low_pfn() ~ 229376
max_pfn = 1900544
6530MB HIGHMEM available.
894MB LOWMEM available.
min_low_pfn = 5685, max_low_pfn = 228864, highstart_pfn = 228864
Low memory ends at vaddr f7e00000
node 0 will remap to vaddr f7e00000 - f8000000
High memory starts at vaddr f7e00000
found SMP MP-table at 0009c540
initrd extends beyond end of memory (0x37fef3e4 > 0x37e00000)
disabling initrd
DMI 2.3 present.
Using APIC driver default
ACPI: PM-Timer IO Port: 0x508
Switched to APIC driver `summit'.
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x02] enabled)
Processor #2 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x10] enabled)
Processor #16 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x05] lapic_id[0x12] enabled)
Processor #18 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x08] lapic_id[0x20] enabled)
Processor #32 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x09] lapic_id[0x22] enabled)
Processor #34 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x0c] lapic_id[0x30] enabled)
Processor #48 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x0d] lapic_id[0x32] enabled)
Processor #50 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x80] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x81] lapic_id[0x03] enabled)
Processor #3 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x84] lapic_id[0x11] enabled)
Processor #17 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x85] lapic_id[0x13] enabled)
Processor #19 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x88] lapic_id[0x21] enabled)
Processor #33 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x89] lapic_id[0x23] enabled)
Processor #35 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x8c] lapic_id[0x31] enabled)
Processor #49 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x8d] lapic_id[0x33] enabled)
Processor #51 15:2 APIC version 20
ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x04] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x05] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x08] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x09] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x0c] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x0d] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x80] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x81] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x84] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x85] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x88] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x89] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x8c] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x8d] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x0e] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 14, version 17, address 0xfec00000, GSI 0-43
ACPI: IOAPIC (id[0x0d] address[0xfec01000] gsi_base[44])
IOAPIC[1]: apic_id 13, version 17, address 0xfec01000, GSI 44-87
ACPI: INT_SRC_OVR (bus 0 bus_irq 8 global_irq 8 low edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 low level)
Enabling APIC mode:  Summit.  Using 2 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at f1000000 (gap: f0000000:0ec00000)
Detected 1996.225 MHz processor.
Built 1 zonelists.  Total pages: 1900032
Kernel command line: ro root=/dev/VolGroup00/LogVol00
console=ttyS0,115200 console=tty0
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c13f4000 soft=c13d4000
PID hash table entries: 4096 (order: 12, 16384 bytes)
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
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Initializing HighMem for node 0 (00037e00:001cfe00)
Memory: 7232676k/7602176k available (2082k kernel code, 104464k
reserved, 1080k data, 236k init, 6422084k highmem)
Checking if this processor honours the WP bit even in supervisor mode...
Ok.
Calibrating delay using timer specific routine.. 4000.84 BogoMIPS
(lpj=8001693)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Checking 'hlt' instruction... OK.
lockdep: not fixing up alternatives.
ACPI: Core revision 20060707
CPU0: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
Leaving ESR disabled.
Mapping cpu 0 to node 0
lockdep: not fixing up alternatives.
Booting processor 1/2 eip 3000
CPU 1 irqstacks, hard=c13f5000 soft=c13d5000
Initializing CPU#1
Leaving ESR disabled.
Mapping cpu 1 to node 0
Calibrating delay using timer specific routine.. 3992.16 BogoMIPS
(lpj=7984334)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 1
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
lockdep: not fixing up alternatives.
Booting processor 2/16 eip 3000
CPU 2 irqstacks, hard=c13f6000 soft=c13d6000
Initializing CPU#2
Leaving ESR disabled.
Mapping cpu 2 to node 0
Calibrating delay using timer specific routine.. 3992.19 BogoMIPS
(lpj=7984393)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 8
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#2.
CPU2: Intel P4/Xeon Extended MCE MSRs (12) available
CPU2: Thermal monitoring enabled
CPU2: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
lockdep: not fixing up alternatives.
Booting processor 3/18 eip 3000
CPU 3 irqstacks, hard=c13f7000 soft=c13d7000
Initializing CPU#3
Leaving ESR disabled.
Mapping cpu 3 to node 0
Calibrating delay using timer specific routine.. 3992.21 BogoMIPS
(lpj=7984431)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 9
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#3.
CPU3: Intel P4/Xeon Extended MCE MSRs (12) available
CPU3: Thermal monitoring enabled
CPU3: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
lockdep: not fixing up alternatives.
Booting processor 4/32 eip 3000
CPU 4 irqstacks, hard=c13f8000 soft=c13d8000
Initializing CPU#4
Leaving ESR disabled.
Mapping cpu 4 to node 1
Calibrating delay using timer specific routine.. 3992.55 BogoMIPS
(lpj=7985101)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 16
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#4.
CPU4: Intel P4/Xeon Extended MCE MSRs (12) available
CPU4: Thermal monitoring enabled
CPU4: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
lockdep: not fixing up alternatives.
Booting processor 5/34 eip 3000
CPU 5 irqstacks, hard=c13f9000 soft=c13d9000
Initializing CPU#5
Leaving ESR disabled.
Mapping cpu 5 to node 1
Calibrating delay using timer specific routine.. 3992.56 BogoMIPS
(lpj=7985132)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 1024K
CPU: Physical Processor ID: 17
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#5.
CPU5: Intel P4/Xeon Extended MCE MSRs (12) available
CPU5: Thermal monitoring enabled
CPU5: Intel(R) Xeon(TM) MP CPU 2.00GHz stepping 05
lockdep: not fixing up alternatives.
Booting processor 6/48 eip 3000
CPU 6 irqstacks, hard=c13fa000 soft=c13da000
Initializing CPU#6
Leaving ESR disabled.
Mapping cpu 6 to node 1
Calibrating delay using timer specific routine.. 3992.60 BogoMIPS
(lpj=7985209)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 24
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#6.
CPU6: Intel P4/Xeon Extended MCE MSRs (12) available
CPU6: Thermal monitoring enabled
CPU6: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
lockdep: not fixing up alternatives.
Booting processor 7/50 eip 3000
CPU 7 irqstacks, hard=c13fb000 soft=c13db000
Initializing CPU#7
Leaving ESR disabled.
Mapping cpu 7 to node 1
Calibrating delay using timer specific routine.. 3992.58 BogoMIPS
(lpj=7985160)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 1024K
CPU: Physical Processor ID: 25
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#7.
CPU7: Intel P4/Xeon Extended MCE MSRs (12) available
CPU7: Thermal monitoring enabled
CPU7: Intel(R) Xeon(TM) MP CPU 2.00GHz stepping 05
lockdep: not fixing up alternatives.
Booting processor 8/1 eip 3000
CPU 8 irqstacks, hard=c13fc000 soft=c13dc000
Initializing CPU#8
Leaving ESR disabled.
Mapping cpu 8 to node 0
Calibrating delay using timer specific routine.. 3991.95 BogoMIPS
(lpj=7983906)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 0
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#8.
CPU8: Intel P4/Xeon Extended MCE MSRs (12) available
CPU8: Thermal monitoring enabled
CPU8: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
lockdep: not fixing up alternatives.
Booting processor 9/3 eip 3000
CPU 9 irqstacks, hard=c13fd000 soft=c13dd000
Initializing CPU#9
Leaving ESR disabled.
Mapping cpu 9 to node 0
Calibrating delay using timer specific routine.. 3992.26 BogoMIPS
(lpj=7984534)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 1
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#9.
CPU9: Intel P4/Xeon Extended MCE MSRs (12) available
CPU9: Thermal monitoring enabled
CPU9: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
lockdep: not fixing up alternatives.
Booting processor 10/17 eip 3000
CPU 10 irqstacks, hard=c13fe000 soft=c13de000
Initializing CPU#10
Leaving ESR disabled.
Mapping cpu 10 to node 0
Calibrating delay using timer specific routine.. 3992.19 BogoMIPS
(lpj=7984397)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 8
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#10.
CPU10: Intel P4/Xeon Extended MCE MSRs (12) available
CPU10: Thermal monitoring enabled
CPU10: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
lockdep: not fixing up alternatives.
Booting processor 11/19 eip 3000
CPU 11 irqstacks, hard=c13ff000 soft=c13df000
Initializing CPU#11
Leaving ESR disabled.
Mapping cpu 11 to node 0
Calibrating delay using timer specific routine.. 3992.19 BogoMIPS
(lpj=7984386)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 9
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#11.
CPU11: Intel P4/Xeon Extended MCE MSRs (12) available
CPU11: Thermal monitoring enabled
CPU11: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
lockdep: not fixing up alternatives.
Booting processor 12/33 eip 3000
CPU 12 irqstacks, hard=c1400000 soft=c13e0000
Initializing CPU#12
Leaving ESR disabled.
Mapping cpu 12 to node 1
Calibrating delay using timer specific routine.. 3992.47 BogoMIPS
(lpj=7984957)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 16
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#12.
CPU12: Intel P4/Xeon Extended MCE MSRs (12) available
CPU12: Thermal monitoring enabled
CPU12: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
lockdep: not fixing up alternatives.
Booting processor 13/35 eip 3000
CPU 13 irqstacks, hard=c1401000 soft=c13e1000
Initializing CPU#13
Leaving ESR disabled.
Mapping cpu 13 to node 1
Calibrating delay using timer specific routine.. 3992.49 BogoMIPS
(lpj=7984994)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 1024K
CPU: Physical Processor ID: 17
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#13.
CPU13: Intel P4/Xeon Extended MCE MSRs (12) available
CPU13: Thermal monitoring enabled
CPU13: Intel(R) Xeon(TM) MP CPU 2.00GHz stepping 05
lockdep: not fixing up alternatives.
Booting processor 14/49 eip 3000
CPU 14 irqstacks, hard=c1402000 soft=c13e2000
Initializing CPU#14
Leaving ESR disabled.
Mapping cpu 14 to node 1
Calibrating delay using timer specific routine.. 3992.48 BogoMIPS
(lpj=7984978)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 2048K
CPU: Physical Processor ID: 24
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#14.
CPU14: Intel P4/Xeon Extended MCE MSRs (12) available
CPU14: Thermal monitoring enabled
CPU14: Intel(R) XEON(TM) MP CPU 2.00GHz stepping 02
lockdep: not fixing up alternatives.
Booting processor 15/51 eip 3000
CPU 15 irqstacks, hard=c1403000 soft=c13e3000
Initializing CPU#15
Leaving ESR disabled.
Mapping cpu 15 to node 1
Calibrating delay using timer specific routine.. 3992.57 BogoMIPS
(lpj=7985143)
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: L3 cache: 1024K
CPU: Physical Processor ID: 25
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#15.
CPU15: Intel P4/Xeon Extended MCE MSRs (12) available
CPU15: Thermal monitoring enabled
CPU15: Intel(R) Xeon(TM) MP CPU 2.00GHz stepping 05
Total of 16 processors activated (63886.37 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=0 apic2=-1 pin2=-1
checking TSC synchronization across 16 CPUs:
CPU#0 had 17654857 usecs TSC skew, fixed it up.
CPU#1 had 17654857 usecs TSC skew, fixed it up.
CPU#2 had 17654857 usecs TSC skew, fixed it up.
CPU#3 had 17654861 usecs TSC skew, fixed it up.
CPU#4 had -17654862 usecs TSC skew, fixed it up.
CPU#5 had -17654848 usecs TSC skew, fixed it up.
CPU#6 had -17654862 usecs TSC skew, fixed it up.
CPU#7 had -17654861 usecs TSC skew, fixed it up.
CPU#8 had 17654865 usecs TSC skew, fixed it up.
CPU#9 had 17654857 usecs TSC skew, fixed it up.
CPU#10 had 17654857 usecs TSC skew, fixed it up.
CPU#11 had 17654861 usecs TSC skew, fixed it up.
CPU#12 had -17654862 usecs TSC skew, fixed it up.
CPU#13 had -17654854 usecs TSC skew, fixed it up.
CPU#14 had -17654862 usecs TSC skew, fixed it up.
CPU#15 had -17654861 usecs TSC skew, fixed it up.
cpu_up: attempt to bring up CPU 4 failed
kfree_debugcheck: bad ptr c15f6000h.
------------[ cut here ]------------
kernel BUG at mm/slab.c:2698!
invalid opcode: 0000 [#1]
SMP
Modules linked in:
CPU:    0
EIP:    0060:[<c106ce51>]    Not tainted VLI
EFLAGS: 00010046   (2.6.18 #1)
EIP is at kfree_debugcheck+0x7f/0x90
eax: 00000028   ebx: 000015f6   ecx: c1025289   edx: c7653540
esi: c15f6000   edi: c15f6000   ebp: c764af38   esp: c764af28
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, ti=c764a000 task=c7653540 task.ti=c764a000)
Stack: c122c68d c15f6000 c1635000 00000004 c764af5c c106ef93 00000286
c76a77d0
       00000004 00000001 c1635000 00000004 00000004 c764af6c c10557f6
c1274eac
       c12743dc c764af84 c1207467 00000004 c12734c0 00000004 00000004
c764af98
Call Trace:
 [<c106ef93>] kfree+0x24/0x1d8
 [<c10557f6>] pageset_cpuup_callback+0x40/0x58
 [<c1207467>] notifier_call_chain+0x20/0x31
 [<c1031530>] blocking_notifier_call_chain+0x1d/0x2d
 [<c103f80c>] cpu_up+0xb5/0xcf
 [<c1000372>] init+0x78/0x296
 [<c1002005>] kernel_thread_helper+0x5/0xb
DWARF2 unwinder stuck at kernel_thread_helper+0x5/0xb
Leftover inexact backtrace:
 [<c1005076>] show_stack_log_lvl+0x8a/0x95
 [<c10051ae>] show_registers+0x12d/0x19a
 [<c100539c>] die+0x181/0x284
 [<c12062b2>] do_trap+0x7c/0x96
 [<c1005b83>] do_invalid_op+0x89/0x93
 [<c1004a79>] error_code+0x39/0x40
 [<c106ef93>] kfree+0x24/0x1d8
 [<c10557f6>] pageset_cpuup_callback+0x40/0x58
 [<c1207467>] notifier_call_chain+0x20/0x31
 [<c1031530>] blocking_notifier_call_chain+0x1d/0x2d
 [<c103f80c>] cpu_up+0xb5/0xcf
 [<c1000372>] init+0x78/0x296
 [<c1002005>] kernel_thread_helper+0x5/0xb
Code: 40 67 31 c1 8b 14 85 80 68 31 c1 2b 9a a0 0e 00 00 6b c3 34 03 82
98 0e 00 00 8b 00 84 c0 78 15 56 68 8d c6 22 c1 e8 f5 8a fb ff <0f> 0b
8a 0a f9 c5 22 c1 58 5a 8d 65 f8 5b 5e 5d c3 55 89 e5 57
EIP: [<c106ce51>] kfree_debugcheck+0x7f/0x90 SS:ESP 0068:c764af28
 <0>Kernel panic - not syncing: Attempted to kill init!
 BUG: warning at arch/i386/kernel/smp.c:547/smp_call_function()
 [<c1004eda>] show_trace_log_lvl+0x58/0x16a
 [<c10054d8>] show_trace+0xd/0x10
 [<c10055e8>] dump_stack+0x19/0x1b
 [<c10159a0>] smp_call_function+0x4f/0xbc
 [<c1015a23>] smp_send_stop+0x16/0x2a
 [<c1024eed>] panic+0x4d/0xec
 [<c1027a91>] do_exit+0x71/0x7c3
 [<c1005479>] die+0x25e/0x284
 [<c12062b2>] do_trap+0x7c/0x96
 [<c1005b83>] do_invalid_op+0x89/0x93
 [<c1004a79>] error_code+0x39/0x40
DWARF2 unwinder stuck at error_code+0x39/0x40
Leftover inexact backtrace:
 [<c10054d8>] show_trace+0xd/0x10
 [<c10055e8>] dump_stack+0x19/0x1b
 [<c10159a0>] smp_call_function+0x4f/0xbc
 [<c1015a23>] smp_send_stop+0x16/0x2a
 [<c1024eed>] panic+0x4d/0xec
 [<c1027a91>] do_exit+0x71/0x7c3
 [<c1005479>] die+0x25e/0x284
 [<c12062b2>] do_trap+0x7c/0x96
 [<c1005b83>] do_invalid_op+0x89/0x93
 [<c1004a79>] error_code+0x39/0x40
 [<c106ef93>] kfree+0x24/0x1d8
 [<c10557f6>] pageset_cpuup_callback+0x40/0x58
 [<c1207467>] notifier_call_chain+0x20/0x31
 [<c1031530>] blocking_notifier_call_chain+0x1d/0x2d
 [<c103f80c>] cpu_up+0xb5/0xcf
 [<c1000372>] init+0x78/0x296
 [<c1002005>] kernel_thread_helper+0x5/0xb



