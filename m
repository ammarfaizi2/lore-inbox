Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267466AbUJBSVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267466AbUJBSVm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 14:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267478AbUJBSVm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 14:21:42 -0400
Received: from gyre.weather.fi ([193.94.59.26]:8103 "EHLO gyre.weather.fi")
	by vger.kernel.org with ESMTP id S267466AbUJBSVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 14:21:13 -0400
Date: Sat, 2 Oct 2004 21:21:00 +0300 (EEST)
From: =?ISO-8859-1?Q?Jaakko_Hyv=E4tti?= <jaakko@hyvatti.iki.fi>
X-X-Sender: jaakko@gyre.weather.fi
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm2
In-Reply-To: <20041002004938.175203ba.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0410022049100.25679@gyre.weather.fi>
References: <20040922131210.6c08b94c.akpm@osdl.org>
 <Pine.LNX.4.58.0410021038060.25679@gyre.weather.fi> <20041002004938.175203ba.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Oct 2004, Andrew Morton wrote:
> It was wait_on_bit-must-loop.patch.
>
> But that simply fixes a bug which was introduced into an earlier
> 2.6.9-rcX-mmY kernel.  The bug is certainly not present in any Linus
> kernel, nor in any 2.6.6/7/8 kernel.
>
> So you're seeing something different.  Please send a full report.

Got another, this is the kernel log starting from the fault, and including
the following boot.  Obviously, no inode 4294967167 (== 0xFFFFFF7F)
remains after I had to fsck the disk.  How do I find directory #3342351..
Oh that is the inum of directory, isn't it?  Found it.  That one was not
even active at the time, I think.  e2fsck output was lost. e2fsck -y
option was needed to get out of the situation, e2fsck -a is not enough.

The machine is dual AMD Opteron 240 (1.4GHz), MSI K8D motherboard, 3G
mem, disks in raid configuration with 3ware SATA adapter, so they show
up as scsi devices.  Kernel is updated Fedora Core 2 2.6.8-1.521smp,
but the same happened with 2.6.6 at least.  Disks are shared over
nfsv3 to a few very very busy clients, some running Linux, some
running IRIX.

This error probably happens in next 24 hours again, so if you can suggest
an additional way to debug I'll do it.

Oct  2 19:39:30 sun kernel: EXT3-fs error (device sda3): ext3_delete_entry: bad entry in directory #3342351: inode out of bounds - offset=0, inode=4294967167, rec_len=12, name_len=1
Oct  2 19:39:30 sun kernel: Aborting journal on device sda3.
Oct  2 19:39:30 sun kernel: ext3_abort called.
Oct  2 19:39:30 sun kernel: EXT3-fs abort (device sda3): ext3_journal_start: Detected aborted journal
Oct  2 19:39:30 sun kernel: Remounting filesystem read-only
Oct  2 19:39:30 sun kernel: EXT3-fs error (device sda3) in start_transaction: Journal has aborted
Oct  2 19:39:30 sun kernel: EXT3-fs error (device sda3) in ext3_unlink: IO failure
Oct  2 19:39:30 sun kernel: __journal_remove_journal_head: freeing b_committed_data
Oct  2 19:39:30 sun last message repeated 3 times
Oct  2 19:39:30 sun kernel: EXT3-fs error (device sda3) in start_transaction: Journal has aborted
Oct  2 19:40:05 sun last message repeated 24 times
Oct  2 19:41:07 sun last message repeated 58 times
Oct  2 19:42:14 sun last message repeated 67 times
Oct  2 19:43:19 sun last message repeated 113 times
Oct  2 19:44:20 sun last message repeated 17 times
Oct  2 19:45:21 sun last message repeated 150 times
Oct  2 20:36:44 sun kernel: klogd 1.4.1, log source = /proc/kmsg started.
Oct  2 20:36:44 sun kernel: Bootdata ok (command line is ro root=LABEL=/ rhgb quiet)
Oct  2 20:36:44 sun kernel: Linux version 2.6.8-1.521smp (bhcompile@thor.perf.redhat.com) (gcc version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #1 SMP Mon Aug 16 09:32:47 EDT 2004
Oct  2 20:36:44 sun kernel: BIOS-provided physical RAM map:
Oct  2 20:36:44 sun kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Oct  2 20:36:44 sun kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Oct  2 20:36:44 sun kernel:  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
Oct  2 20:36:44 sun kernel:  BIOS-e820: 0000000000100000 - 00000000bfff0000 (usable)
Oct  2 20:36:44 sun kernel:  BIOS-e820: 00000000bfff0000 - 00000000bffff000 (ACPI data)
Oct  2 20:36:44 sun kernel:  BIOS-e820: 00000000bffff000 - 00000000c0000000 (ACPI NVS)
Oct  2 20:36:44 sun kernel:  BIOS-e820: 00000000ff7c0000 - 0000000100000000 (reserved)
Oct  2 20:36:44 sun kernel: Scanning NUMA topology in Northbridge 24
Oct  2 20:36:44 sun kernel: Number of nodes 2 (10010)
Oct  2 20:36:44 sun kernel: Node 0 MemBase 0000000000000000 Limit 000000003fffffff
Oct  2 20:36:44 sun kernel: Node 1 MemBase 0000000040000000 Limit 00000000bfff0000
Oct  2 20:36:44 sun kernel: Using node hash shift of 24
Oct  2 20:36:44 sun kernel: Bootmem setup node 0 0000000000000000-000000003fffffff
Oct  2 20:36:44 sun kernel: Bootmem setup node 1 0000000040000000-00000000bfff0000
Oct  2 20:36:44 sun kernel: No mptable found.
Oct  2 20:36:44 sun kernel: On node 0 totalpages: 262143
Oct  2 20:36:44 sun kernel:   DMA zone: 4096 pages, LIFO batch:1
Oct  2 20:36:44 sun kernel:   Normal zone: 258047 pages, LIFO batch:16
Oct  2 20:36:44 sun kernel:   HighMem zone: 0 pages, LIFO batch:1
Oct  2 20:36:44 sun kernel: On node 1 totalpages: 524272
Oct  2 20:36:44 sun kernel:   DMA zone: 0 pages, LIFO batch:1
Oct  2 20:36:44 sun kernel:   Normal zone: 524272 pages, LIFO batch:16
Oct  2 20:36:44 sun kernel:   HighMem zone: 0 pages, LIFO batch:1
Oct  2 20:36:44 sun kernel: ACPI: RSDP (v000 ACPIAM                                    ) @ 0x00000000000f4530
Oct  2 20:36:44 sun kernel: ACPI: RSDT (v001 A M I  OEMRSDT  0x07000304 MSFT 0x00000097) @ 0x00000000bfff0000
Oct  2 20:36:44 sun kernel: ACPI: FADT (v001 A M I  OEMFACP  0x07000304 MSFT 0x00000097) @ 0x00000000bfff0200
Oct  2 20:36:44 sun kernel: ACPI: MADT (v001 A M I  OEMAPIC  0x07000304 MSFT 0x00000097) @ 0x00000000bfff0380
Oct  2 20:36:44 sun kernel: ACPI: SPCR (v001 A M I  OEMSPCR  0x07000304 MSFT 0x00000097) @ 0x00000000bfff0400
Oct  2 20:36:44 sun kernel: ACPI: OEMB (v001 A M I  OEMBIOS  0x07000304 MSFT 0x00000097) @ 0x00000000bffff040
Oct  2 20:36:44 sun kernel: ACPI: ASF! (v001 AMIASF AMDSTRET 0x00000001 INTL 0x02002026) @ 0x00000000bfff2d90
Oct  2 20:36:44 sun kernel: ACPI: DSDT (v001  0ABCF 0ABCF008 0x00000008 INTL 0x02002026) @ 0x0000000000000000
Oct  2 20:36:44 sun kernel: ACPI: Local APIC address 0xfee00000
Oct  2 20:36:44 sun kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Oct  2 20:36:44 sun kernel: Processor #0 15:5 APIC version 16
Oct  2 20:36:44 sun kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Oct  2 20:36:44 sun kernel: Processor #1 15:5 APIC version 16
Oct  2 20:36:44 sun kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
Oct  2 20:36:44 sun kernel: IOAPIC[0]: Assigned apic_id 2
Oct  2 20:36:44 sun kernel: IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
Oct  2 20:36:44 sun kernel: ACPI: IOAPIC (id[0x03] address[0xfebfe000] gsi_base[24])
Oct  2 20:36:44 sun kernel: IOAPIC[1]: Assigned apic_id 3
Oct  2 20:36:44 sun kernel: IOAPIC[1]: apic_id 3, version 17, address 0xfebfe000, GSI 24-27
Oct  2 20:36:44 sun kernel: ACPI: IOAPIC (id[0x04] address[0xfebff000] gsi_base[28])
Oct  2 20:36:44 sun kernel: IOAPIC[2]: Assigned apic_id 4
Oct  2 20:36:44 sun kernel: IOAPIC[2]: apic_id 4, version 17, address 0xfebff000, GSI 28-31
Oct  2 20:36:44 sun kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Oct  2 20:36:44 sun kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Oct  2 20:36:44 sun kernel: ACPI: IRQ0 used by override.
Oct  2 20:36:44 sun kernel: ACPI: IRQ2 used by override.
Oct  2 20:36:44 sun kernel: ACPI: IRQ9 used by override.
Oct  2 20:36:44 sun kernel: Using ACPI (MADT) for SMP configuration information
Oct  2 20:36:44 sun kernel: Checking aperture...
Oct  2 20:36:44 sun kernel: CPU 0: aperture @ ffd4000000 size 32 MB
Oct  2 20:36:44 sun kernel: Aperture from northbridge cpu 0 too small (32 MB)
Oct  2 20:36:44 sun kernel: No AGP bridge found
Oct  2 20:36:44 sun kernel: Built 2 zonelists
Oct  2 20:36:44 sun kernel: Kernel command line: ro root=LABEL=/ rhgb quiet console=tty0
Oct  2 20:36:44 sun kernel: Initializing CPU#0
Oct  2 20:36:44 sun kernel: PID hash table entries: 1024 (order 10: 16384 bytes)
Oct  2 20:36:44 sun kernel: time.c: Using 1.193182 MHz PIT timer.
Oct  2 20:36:44 sun kernel: time.c: Detected 1395.673 MHz processor.
Oct  2 20:36:44 sun kernel: Console: colour VGA+ 80x25
Oct  2 20:36:44 sun kernel: Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Oct  2 20:36:44 sun kernel: Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Oct  2 20:36:44 sun kernel: Memory: 3095016k/3145664k available (2161k kernel code, 0k reserved, 1409k data, 176k init)
Oct  2 20:36:44 sun kernel: Calibrating delay loop... 2744.32 BogoMIPS
Oct  2 20:36:44 sun kernel: Security Scaffold v1.0.0 initialized
Oct  2 20:36:44 sun kernel: SELinux:  Initializing.
Oct  2 20:36:44 sun kernel: SELinux:  Starting in permissive mode
Oct  2 20:36:44 sun kernel: There is already a security framework initialized, register_security failed.
Oct  2 20:36:44 sun kernel: selinux_register_security:  Registering secondary module capability
Oct  2 20:36:44 sun kernel: Capability LSM initialized as secondary
Oct  2 20:36:44 sun kernel: Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
Oct  2 20:36:44 sun kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Oct  2 20:36:44 sun kernel: CPU: L2 Cache: 1024K (64 bytes/line)
Oct  2 20:36:44 sun kernel: Using local APIC NMI watchdog using perfctr0
Oct  2 20:36:44 sun kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Oct  2 20:36:44 sun kernel: CPU: L2 Cache: 1024K (64 bytes/line)
Oct  2 20:36:44 sun kernel: CPU0: AMD Opteron(tm) Processor 240 stepping 01
Oct  2 20:36:44 sun kernel: per-CPU timeslice cutoff: 1023.77 usecs.
Oct  2 20:36:44 sun kernel: task migration cache decay timeout: 2 msecs.
Oct  2 20:36:44 sun kernel: Booting processor 1/1 rip 6000 rsp 10041d67f58
Oct  2 20:36:44 sun kernel: Initializing CPU#1
Oct  2 20:36:44 sun kernel: Calibrating delay loop... 2785.28 BogoMIPS
Oct  2 20:36:44 sun kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Oct  2 20:36:44 sun kernel: CPU: L2 Cache: 1024K (64 bytes/line)
Oct  2 20:36:44 sun kernel: AMD Opteron(tm) Processor 240 stepping 01
Oct  2 20:36:44 sun kernel: Total of 2 processors activated (5529.60 BogoMIPS).
Oct  2 20:36:44 sun kernel: ENABLING IO-APIC IRQs
Oct  2 20:36:44 sun kernel: init IO_APIC IRQs
Oct  2 20:36:44 sun kernel:  IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23, 3-0, 3-1, 3-2, 3-3, 4-0, 4-1, 4-2, 4-3 not connected.
Oct  2 20:36:44 sun kernel: ..TIMER: vector=0x31 pin1=2 pin2=-1
Oct  2 20:36:44 sun kernel: Using local APIC timer interrupts.
Oct  2 20:36:44 sun kernel: Detected 12.461 MHz APIC timer.
Oct  2 20:36:44 sun kernel: checking TSC synchronization across 2 CPUs: passed.
Oct  2 20:36:44 sun kernel: time.c: Using PIT/TSC based timekeeping.
Oct  2 20:36:44 sun kernel: Brought up 2 CPUs
Oct  2 20:36:44 sun kernel: checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
Oct  2 20:36:45 sun kernel: NET: Registered protocol family 16
Oct  2 20:36:45 sun kernel: PCI: Using configuration type 1
Oct  2 20:36:45 sun kernel: mtrr: v2.0 (20020519)
Oct  2 20:36:45 sun kernel: ACPI: Subsystem revision 20040326
Oct  2 20:36:45 sun kernel: ACPI: Interpreter enabled
Oct  2 20:36:45 sun kernel: ACPI: Using IOAPIC for interrupt routing
Oct  2 20:36:45 sun kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Oct  2 20:36:45 sun kernel: PCI: Probing PCI hardware (bus 00)
Oct  2 20:36:45 sun kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Oct  2 20:36:45 sun kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Oct  2 20:36:45 sun kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.GOLA._PRT]
Oct  2 20:36:45 sun kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.GOLB._PRT]
Oct  2 20:36:45 sun kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
Oct  2 20:36:45 sun kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
Oct  2 20:36:45 sun kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
Oct  2 20:36:45 sun kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
Oct  2 20:36:45 sun kernel: ACPI: Power Resource [GFAN] (on)
Oct  2 20:36:45 sun kernel: ACPI: Power Resource [LFAN] (on)
Oct  2 20:36:45 sun kernel: usbcore: registered new driver usbfs
Oct  2 20:36:45 sun kernel: usbcore: registered new driver hub
Oct  2 20:36:45 sun kernel: PCI: Using ACPI for IRQ routing
Oct  2 20:36:45 sun kernel: IOAPIC[0]: Set PCI routing entry (2-19 -> 0xa9 -> IRQ 19 Mode:1 Active:1)
Oct  2 20:36:45 sun kernel: ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 19 (level, low) -> IRQ 169
Oct  2 20:36:45 sun kernel: ACPI: PCI interrupt 0000:03:00.0[D] -> GSI 19 (level, low) -> IRQ 169
Oct  2 20:36:45 sun kernel: ACPI: PCI interrupt 0000:03:00.1[D] -> GSI 19 (level, low) -> IRQ 169
Oct  2 20:36:45 sun kernel: IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb1 -> IRQ 18 Mode:1 Active:1)
Oct  2 20:36:45 sun kernel: ACPI: PCI interrupt 0000:03:06.0[A] -> GSI 18 (level, low) -> IRQ 177
Oct  2 20:36:45 sun kernel: IOAPIC[2]: Set PCI routing entry (4-0 -> 0xb9 -> IRQ 28 Mode:1 Active:1)
Oct  2 20:36:45 sun kernel: ACPI: PCI interrupt 0000:01:01.0[A] -> GSI 28 (level, low) -> IRQ 185
Oct  2 20:36:45 sun kernel: IOAPIC[2]: Set PCI routing entry (4-1 -> 0xc1 -> IRQ 29 Mode:1 Active:1)
Oct  2 20:36:45 sun kernel: ACPI: PCI interrupt 0000:01:02.0[A] -> GSI 29 (level, low) -> IRQ 193
Oct  2 20:36:45 sun kernel: IOAPIC[2]: Set PCI routing entry (4-2 -> 0xc9 -> IRQ 30 Mode:1 Active:1)
Oct  2 20:36:45 sun kernel: ACPI: PCI interrupt 0000:01:02.1[B] -> GSI 30 (level, low) -> IRQ 201
Oct  2 20:36:45 sun kernel: number of MP IRQ sources: 16.
Oct  2 20:36:45 sun kernel: number of IO-APIC #2 registers: 24.
Oct  2 20:36:45 sun kernel: number of IO-APIC #3 registers: 4.
Oct  2 20:36:45 sun kernel: number of IO-APIC #4 registers: 4.
Oct  2 20:36:45 sun kernel: testing the IO APIC.......................
Oct  2 20:36:45 sun kernel:
Oct  2 20:36:45 sun kernel: IO APIC #2......
Oct  2 20:36:45 sun kernel: .... register #00: 02000000
Oct  2 20:36:45 sun kernel: .......    : physical APIC id: 02
Oct  2 20:36:45 sun kernel: .... register #01: 00170011
Oct  2 20:36:45 sun kernel: .......     : max redirection entries: 0017
Oct  2 20:36:45 sun kernel: .......     : PRQ implemented: 0
Oct  2 20:36:45 sun kernel: .......     : IO APIC version: 0011
Oct  2 20:36:45 sun kernel: .... register #02: 02000000
Oct  2 20:36:45 sun kernel: .......     : arbitration: 02
Oct  2 20:36:45 sun kernel: .... IRQ redirection table:
Oct  2 20:36:45 sun kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
Oct  2 20:36:45 sun kernel:  00 000 00  1    0    0   0   0    0    0    00
Oct  2 20:36:45 sun kernel:  01 001 01  0    0    0   0   0    1    1    39
Oct  2 20:36:45 sun kernel:  02 001 01  0    0    0   0   0    1    1    31
Oct  2 20:36:45 sun kernel:  03 001 01  0    0    0   0   0    1    1    41
Oct  2 20:36:45 sun kernel:  04 001 01  0    0    0   0   0    1    1    49
Oct  2 20:36:45 sun kernel:  05 001 01  0    0    0   0   0    1    1    51
Oct  2 20:36:45 sun kernel:  06 001 01  0    0    0   0   0    1    1    59
Oct  2 20:36:45 sun kernel:  07 001 01  0    0    0   0   0    1    1    61
Oct  2 20:36:45 sun kernel:  08 001 01  0    0    0   0   0    1    1    69
Oct  2 20:36:45 sun kernel:  09 001 01  0    1    0   1   0    1    1    71
Oct  2 20:36:45 sun kernel:  0a 001 01  0    0    0   0   0    1    1    79
Oct  2 20:36:45 sun kernel:  0b 001 01  0    0    0   0   0    1    1    81
Oct  2 20:36:45 sun kernel:  0c 001 01  0    0    0   0   0    1    1    89
Oct  2 20:36:45 sun kernel:  0d 001 01  0    0    0   0   0    1    1    91
Oct  2 20:36:45 sun kernel:  0e 001 01  0    0    0   0   0    1    1    99
Oct  2 20:36:45 sun kernel:  0f 001 01  0    0    0   0   0    1    1    A1
Oct  2 20:36:45 sun kernel:  10 000 00  1    0    0   0   0    0    0    00
Oct  2 20:36:45 sun kernel:  11 000 00  1    0    0   0   0    0    0    00
Oct  2 20:36:45 sun kernel:  12 001 01  1    1    0   1   0    1    1    B1
Oct  2 20:36:45 sun kernel:  13 001 01  1    1    0   1   0    1    1    A9
Oct  2 20:36:45 sun kernel:  14 000 00  1    0    0   0   0    0    0    00
Oct  2 20:36:45 sun kernel:  15 000 00  1    0    0   0   0    0    0    00
Oct  2 20:36:45 sun kernel:  16 000 00  1    0    0   0   0    0    0    00
Oct  2 20:36:45 sun kernel:  17 000 00  1    0    0   0   0    0    0    00
Oct  2 20:36:45 sun kernel:
Oct  2 20:36:45 sun kernel: IO APIC #3......
Oct  2 20:36:45 sun kernel: .... register #00: 03000000
Oct  2 20:36:45 sun kernel: .......    : physical APIC id: 03
Oct  2 20:36:45 sun kernel: .... register #01: 00030011
Oct  2 20:36:45 sun kernel: .......     : max redirection entries: 0003
Oct  2 20:36:45 sun kernel: .......     : PRQ implemented: 0
Oct  2 20:36:45 sun kernel: .......     : IO APIC version: 0011
Oct  2 20:36:45 sun kernel: .... register #02: 00000000
Oct  2 20:36:45 sun kernel: .......     : arbitration: 00
Oct  2 20:36:45 sun kernel: .... IRQ redirection table:
Oct  2 20:36:45 sun kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
Oct  2 20:36:45 sun kernel:  00 000 00  1    0    0   0   0    0    0    00
Oct  2 20:36:45 sun kernel:  01 000 00  1    0    0   0   0    0    0    00
Oct  2 20:36:45 sun kernel:  02 000 00  1    0    0   0   0    0    0    00
Oct  2 20:36:45 sun kernel:  03 000 00  1    0    0   0   0    0    0    00
Oct  2 20:36:45 sun kernel:
Oct  2 20:36:45 sun kernel: IO APIC #4......
Oct  2 20:36:45 sun kernel: .... register #00: 04000000
Oct  2 20:36:45 sun kernel: .......    : physical APIC id: 04
Oct  2 20:36:45 sun kernel: .... register #01: 00030011
Oct  2 20:36:45 sun kernel: .......     : max redirection entries: 0003
Oct  2 20:36:45 sun kernel: .......     : PRQ implemented: 0
Oct  2 20:36:45 sun kernel: .......     : IO APIC version: 0011
Oct  2 20:36:45 sun kernel: .... register #02: 00000000
Oct  2 20:36:45 sun kernel: .......     : arbitration: 00
Oct  2 20:36:45 sun kernel: .... IRQ redirection table:
Oct  2 20:36:45 sun kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
Oct  2 20:36:45 sun kernel:  00 001 01  1    1    0   1   0    1    1    B9
Oct  2 20:36:45 sun kernel:  01 001 01  1    1    0   1   0    1    1    C1
Oct  2 20:36:45 sun kernel:  02 001 01  1    1    0   1   0    1    1    C9
Oct  2 20:36:45 sun kernel:  03 000 00  1    0    0   0   0    0    0    00
Oct  2 20:36:45 sun kernel: Using vector-based indexing
Oct  2 20:36:45 sun kernel: IRQ to pin mappings:
Oct  2 20:36:45 sun kernel: IRQ0 -> 0:2
Oct  2 20:36:45 sun kernel: IRQ1 -> 0:1
Oct  2 20:36:45 sun kernel: IRQ3 -> 0:3
Oct  2 20:36:45 sun kernel: IRQ4 -> 0:4
Oct  2 20:36:45 sun kernel: IRQ5 -> 0:5
Oct  2 20:36:45 sun kernel: IRQ6 -> 0:6
Oct  2 20:36:45 sun kernel: IRQ7 -> 0:7
Oct  2 20:36:45 sun kernel: IRQ8 -> 0:8
Oct  2 20:36:45 sun kernel: IRQ9 -> 0:9
Oct  2 20:36:45 sun kernel: IRQ10 -> 0:10
Oct  2 20:36:45 sun kernel: IRQ11 -> 0:11
Oct  2 20:36:45 sun kernel: IRQ12 -> 0:12
Oct  2 20:36:45 sun kernel: IRQ13 -> 0:13
Oct  2 20:36:45 sun kernel: IRQ14 -> 0:14
Oct  2 20:36:45 sun kernel: IRQ15 -> 0:15
Oct  2 20:36:45 sun kernel: IRQ177 -> 0:18
Oct  2 20:36:45 sun kernel: IRQ169 -> 0:19
Oct  2 20:36:45 sun kernel: IRQ185 -> 2:0
Oct  2 20:36:45 sun kernel: IRQ193 -> 2:1
Oct  2 20:36:45 sun kernel: IRQ201 -> 2:2
Oct  2 20:36:45 sun kernel: .................................... done.
Oct  2 20:36:45 sun kernel: PCI-DMA: Disabling IOMMU.
Oct  2 20:36:45 sun kernel: vesafb: probe of vesafb0 failed with error -6
Oct  2 20:36:45 sun kernel: IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Oct  2 20:36:45 sun kernel: audit: initializing netlink socket (disabled)
Oct  2 20:36:45 sun kernel: audit(1096738578.465:0): initialized
Oct  2 20:36:45 sun kernel: Total HugeTLB memory allocated, 0
Oct  2 20:36:45 sun kernel: VFS: Disk quotas dquot_6.5.1
Oct  2 20:36:45 sun kernel: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
Oct  2 20:36:45 sun kernel: SELinux:  Registering netfilter hooks
Oct  2 20:36:45 sun kernel: Initializing Cryptographic API
Oct  2 20:36:45 sun kernel: ksign: Installing public key data
Oct  2 20:36:45 sun kernel: Loading keyring
Oct  2 20:36:45 sun kernel: - Added public key 9BD64214C19BFDB0
Oct  2 20:36:45 sun kernel: - User ID: Red Hat, Inc. (Kernel Module GPG key)
Oct  2 20:36:45 sun kernel: ksign: invalid packet (ctb=00)
Oct  2 20:36:45 sun kernel: Unable to load default keyring: error=74
Oct  2 20:36:45 sun kernel: pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Oct  2 20:36:45 sun kernel: ACPI: Fan [FN00] (on)
Oct  2 20:36:45 sun kernel: ACPI: Fan [FN01] (on)
Oct  2 20:36:45 sun kernel: ACPI: Processor [CPU1] (supports C1, 8 throttling states)
Oct  2 20:36:45 sun kernel: ACPI: Processor [CPU2] (supports C1)
Oct  2 20:36:45 sun kernel: ACPI: Thermal Zone [THRM] (45 C)
Oct  2 20:36:45 sun kernel: Real Time Clock Driver v1.12
Oct  2 20:36:45 sun kernel: Linux agpgart interface v0.100 (c) Dave Jones
Oct  2 20:36:45 sun kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
Oct  2 20:36:45 sun kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Oct  2 20:36:45 sun kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Oct  2 20:36:45 sun kernel: RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Oct  2 20:36:45 sun kernel: divert: not allocating divert_blk for non-ethernet device lo
Oct  2 20:36:45 sun kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Oct  2 20:36:45 sun kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Oct  2 20:36:45 sun kernel: AMD8111: IDE controller at PCI slot 0000:00:07.1
Oct  2 20:36:45 sun kernel: AMD8111: chipset revision 3
Oct  2 20:36:45 sun kernel: AMD8111: not 100%% native mode: will probe irqs later
Oct  2 20:36:45 sun kernel: AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
Oct  2 20:36:45 sun kernel:     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
Oct  2 20:36:45 sun kernel:     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
Oct  2 20:36:45 sun kernel: ide-floppy driver 0.99.newide
Oct  2 20:36:45 sun kernel: usbcore: registered new driver hiddev
Oct  2 20:36:45 sun kernel: usbcore: registered new driver usbhid
Oct  2 20:36:45 sun kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Oct  2 20:36:45 sun kernel: mice: PS/2 mouse device common for all mice
Oct  2 20:36:45 sun kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Oct  2 20:36:45 sun kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Oct  2 20:36:45 sun kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Oct  2 20:36:45 sun kernel: md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Oct  2 20:36:45 sun kernel: NET: Registered protocol family 2
Oct  2 20:36:45 sun kernel: IP: routing cache hash table of 16384 buckets, 256Kbytes
Oct  2 20:36:45 sun kernel: TCP: Hash tables configured (established 262144 bind 65536)
Oct  2 20:36:45 sun kernel: Initializing IPsec netlink socket
Oct  2 20:36:45 sun kernel: NET: Registered protocol family 1
Oct  2 20:36:45 sun kernel: NET: Registered protocol family 17
Oct  2 20:36:45 sun kernel: powernow-k8: Power state transitions not supported
Oct  2 20:36:45 sun kernel: powernow-k8: Power state transitions not supported
Oct  2 20:36:45 sun kernel: ACPI: (supports S0 S1 S4 S5)
Oct  2 20:36:45 sun kernel: BIOS EDD facility v0.16 2004-Jun-25, 3 devices found
Oct  2 20:36:45 sun kernel: CPU0:  online
Oct  2 20:36:45 sun kernel:  domain 0: span 01
Oct  2 20:36:45 sun kernel:   groups: 01
Oct  2 20:36:45 sun kernel:   domain 1: span 03
Oct  2 20:36:45 sun kernel:    groups: 01 02
Oct  2 20:36:45 sun kernel: CPU1:  online
Oct  2 20:36:45 sun kernel:  domain 0: span 02
Oct  2 20:36:45 sun kernel:   groups: 02
Oct  2 20:36:45 sun kernel:   domain 1: span 03
Oct  2 20:36:45 sun kernel:    groups: 02 01
Oct  2 20:36:45 sun kernel: md: Autodetecting RAID arrays.
Oct  2 20:36:46 sun kernel: md: autorun ...
Oct  2 20:36:46 sun kernel: md: ... autorun DONE.
Oct  2 20:36:46 sun kernel: RAMDISK: Compressed image found at block 0
Oct  2 20:36:46 sun kernel: VFS: Mounted root (ext2 filesystem).
Oct  2 20:36:46 sun kernel: SCSI subsystem initialized
Oct  2 20:36:46 sun kernel: 3ware Storage Controller device driver for Linux v1.26.00.039.
Oct  2 20:36:46 sun kernel: ACPI: PCI interrupt 0000:01:01.0[A] -> GSI 28 (level, low) -> IRQ 185
Oct  2 20:36:46 sun kernel: scsi0 : Found a 3ware Storage Controller at 0x8c00, IRQ: 185, P-chip: 1.3
Oct  2 20:36:46 sun kernel: scsi0 : 3ware Storage Controller
Oct  2 20:36:46 sun kernel: Using cfq io scheduler
Oct  2 20:36:46 sun kernel:   Vendor: 3ware     Model: Logical Disk 0    Rev: 1.2
Oct  2 20:36:46 sun kernel:   Type:   Direct-Access                      ANSI SCSI revision: 00
Oct  2 20:36:46 sun kernel: SCSI device sda: 145224064 512-byte hdwr sectors (74355 MB)
Oct  2 20:36:46 sun kernel: SCSI device sda: drive cache: write back
Oct  2 20:36:46 sun kernel:  sda: sda1 sda2 sda3
Oct  2 20:36:46 sun kernel: Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Oct  2 20:36:46 sun kernel:   Vendor: 3ware     Model: Logical Disk 2    Rev: 1.2
Oct  2 20:36:46 sun kernel:   Type:   Direct-Access                      ANSI SCSI revision: 00
Oct  2 20:36:46 sun kernel: SCSI device sdb: 145224064 512-byte hdwr sectors (74355 MB)
Oct  2 20:36:46 sun kernel: SCSI device sdb: drive cache: write back
Oct  2 20:36:46 sun kernel:  sdb: sdb1
Oct  2 20:36:46 sun kernel: Attached scsi disk sdb at scsi0, channel 0, id 2, lun 0
Oct  2 20:36:46 sun kernel:   Vendor: 3ware     Model: Logical Disk 4    Rev: 1.2
Oct  2 20:36:46 sun kernel:   Type:   Direct-Access                      ANSI SCSI revision: 00
Oct  2 20:36:46 sun kernel: SCSI device sdc: 145224064 512-byte hdwr sectors (74355 MB)
Oct  2 20:36:46 sun kernel: SCSI device sdc: drive cache: write back
Oct  2 20:36:46 sun kernel:  sdc: sdc1
Oct  2 20:36:46 sun kernel: Attached scsi disk sdc at scsi0, channel 0, id 4, lun 0
Oct  2 20:36:46 sun kernel: kjournald starting.  Commit interval 5 seconds
Oct  2 20:36:46 sun kernel: EXT3-fs: mounted filesystem with ordered data mode.
Oct  2 20:36:46 sun kernel: Freeing unused kernel memory: 176k freed
Oct  2 20:36:46 sun kernel: SELinux:  Disabled at runtime.
Oct  2 20:36:46 sun kernel: SELinux:  Unregistering netfilter hooks
Oct  2 20:36:46 sun kernel: ACPI: Power Button (FF) [PWRF]
Oct  2 20:36:46 sun kernel: ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
Oct  2 20:36:46 sun kernel: ohci_hcd: block sizes: ed 80 td 96
Oct  2 20:36:46 sun kernel: ACPI: PCI interrupt 0000:03:00.0[D] -> GSI 19 (level, low) -> IRQ 169
Oct  2 20:36:46 sun kernel: ohci_hcd 0000:03:00.0: OHCI Host Controller
Oct  2 20:36:46 sun kernel: ohci_hcd 0000:03:00.0: irq 169, pci mem ffffff0000017000
Oct  2 20:36:46 sun kernel: ohci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 1
Oct  2 20:36:46 sun kernel: hub 1-0:1.0: USB hub found
Oct  2 20:36:46 sun kernel: hub 1-0:1.0: 3 ports detected
Oct  2 20:36:46 sun kernel: ACPI: PCI interrupt 0000:03:00.1[D] -> GSI 19 (level, low) -> IRQ 169
Oct  2 20:36:46 sun kernel: ohci_hcd 0000:03:00.1: OHCI Host Controller
Oct  2 20:36:46 sun kernel: ohci_hcd 0000:03:00.1: irq 169, pci mem ffffff0000019000
Oct  2 20:36:46 sun kernel: ohci_hcd 0000:03:00.1: new USB bus registered, assigned bus number 2
Oct  2 20:36:46 sun kernel: hub 2-0:1.0: USB hub found
Oct  2 20:36:46 sun kernel: hub 2-0:1.0: 3 ports detected
Oct  2 20:36:46 sun kernel: EXT3 FS on sda3, internal journal
Oct  2 20:36:46 sun kernel: device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
Oct  2 20:36:46 sun kernel: Adding 8385920k swap on /dev/sda2.  Priority:-1 extents:1
Oct  2 20:36:46 sun kernel: kjournald starting.  Commit interval 5 seconds
Oct  2 20:36:46 sun kernel: EXT3 FS on sda1, internal journal
Oct  2 20:36:46 sun kernel: EXT3-fs: mounted filesystem with ordered data mode.
Oct  2 20:36:46 sun kernel: kjournald starting.  Commit interval 5 seconds
Oct  2 20:36:46 sun kernel: EXT3 FS on sdb1, internal journal
Oct  2 20:36:46 sun kernel: EXT3-fs: mounted filesystem with ordered data mode.
Oct  2 20:36:46 sun kernel: kjournald starting.  Commit interval 5 seconds
Oct  2 20:36:46 sun kernel: EXT3 FS on sdc1, internal journal
Oct  2 20:36:46 sun kernel: EXT3-fs: mounted filesystem with writeback data mode.
Oct  2 20:36:46 sun kernel: ip_tables: (C) 2000-2002 Netfilter core team
Oct  2 20:36:46 sun kernel: ip_conntrack version 2.1 (8192 buckets, 65536 max) - 440 bytes per conntrack
Oct  2 20:36:46 sun kernel: tg3.c:v3.8 (July 14, 2004)
Oct  2 20:36:46 sun kernel: ACPI: PCI interrupt 0000:01:02.0[A] -> GSI 29 (level, low) -> IRQ 193
Oct  2 20:36:46 sun kernel: divert: allocating divert_blk for eth0
Oct  2 20:36:46 sun kernel: eth0: Tigon3 [partno(BCM95704A6) rev 2003 PHY(5704)] (PCI:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:0c:76:26:f9:6d
Oct  2 20:36:46 sun kernel: eth0: HostTXDS[1] RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1]
Oct  2 20:36:46 sun kernel: ACPI: PCI interrupt 0000:01:02.1[B] -> GSI 30 (level, low) -> IRQ 201
Oct  2 20:36:46 sun kernel: divert: allocating divert_blk for eth1
Oct  2 20:36:46 sun kernel: eth1: Tigon3 [partno(BCM95704A6) rev 2003 PHY(5704)] (PCI:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:0c:76:26:f9:6c
Oct  2 20:36:46 sun kernel: eth1: HostTXDS[1] RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1]
Oct  2 20:36:46 sun kernel: tg3: eth0: Link is up at 100 Mbps, full duplex.
Oct  2 20:36:46 sun kernel: tg3: eth0: Flow control is on for TX and on for RX.
Oct  2 20:36:46 sun kernel: tg3: eth1: Link is up at 1000 Mbps, full duplex.
Oct  2 20:36:46 sun kernel: tg3: eth1: Flow control is on for TX and on for RX.
Oct  2 20:36:46 sun kernel: lp: driver loaded but no devices found
Oct  2 20:36:47 sun kernel: NET: Registered protocol family 10
Oct  2 20:36:47 sun kernel: Disabled Privacy Extensions on device ffffffff804287c0(lo)
Oct  2 20:36:47 sun kernel: IPv6 over IPv4 tunneling driver
Oct  2 20:36:47 sun kernel: divert: not allocating divert_blk for non-ethernet device sit0
Oct  2 20:36:48 sun kernel: Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Oct  2 20:36:57 sun kernel: eth0: no IPv6 routers present
Oct  2 20:36:58 sun kernel: eth1: no IPv6 routers present


-- 
Jaakko.Hyvatti@iki.fi         http://www.iki.fi/hyvatti/        +358 40 5011222
echo 'movl $36,%eax;int $128;movl $0,%ebx;movl $1,%eax;int $128'|as -o/bin/sync
