Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266807AbUGVFlk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266807AbUGVFlk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 01:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266627AbUGVFlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 01:41:39 -0400
Received: from h004005a8a3c2.ne.client2.attbi.com ([24.61.15.239]:44027 "EHLO
	lips.xiph.org") by vger.kernel.org with ESMTP id S266807AbUGVFlA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 01:41:00 -0400
Date: Wed, 21 Jul 2004 16:40:50 -0400
To: linux-kernel@vger.kernel.org
Cc: monty@xiph.org
Subject: large, spurious[?] TSC skews on AMD 760MPX boards
Message-ID: <20040721204050.GA4913@xiph.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
From: xiphmont@xiph.org (Monty)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[Please keep me in the CC: I apologize for the lack of netiquette in
not subbing to the list but I have enough trouble keeping up with the
deluge of user support on my own lists ;-]

Hello folks,

short background: 

Ever since getting my first dual Athlon, the system timer was 'not
quite right' when running at stock speed.  Selects, alarms, etc, had a
strange way of firing fractions of a second or several seconds 'too
late'.  I discovered that overclocking by about 10% made the problem
magically go away.  I've never been entirely comfortable doing that,
but three dual athlons later (all 760MPX-B2 based boards of different
makes), it was always the only way to make the problem disappear and I
didn't think more about it.

Now that I'm on #3, it is not stable at the overclock I need to make
the system timer problem disappear, so I finally started hunting for
the cause.  Whenever I run the system stock, I see:

Jul 20 21:48:26 Snotfish kernel: checking TSC synchronization across CPUs: 
Jul 20 21:48:26 Snotfish kernel: BIOS BUG: CPU#0 improperly initialized, has 6282588 usecs TSC skew! FIXED.
Jul 20 21:48:26 Snotfish kernel: BIOS BUG: CPU#1 improperly initialized, has -6282588 usecs TSC skew! FIXED.

When the system is running 'properly', that is to say, overclocked:

Jul 21 22:08:01 Snotfish kernel: checking TSC synchronization across CPUs: passed.

This behavior is reproducable on all three of my 760MPX systems (One
Gigabyte GA-7DPXDW-P, and two MSI K7D Master-L).  The amount of the
reported skew varies in the stock case, but it's always large.  Note
that once in a blue moon, the system will come up with no TSC skew at
stock timings, and the system timer issues seem to disappear.

What is the proper route to go about debugging this problem, as I have
it bottled up here in a reproducability cage?

I'm attaching the syslog from a 'bad' and a 'good' boot (the good boot
manufactured from a multiplier/FSB combo that AMD would not approve
of) as well as /proc/cpu info from this 'good' boot.

(BTW, these are true and correct Athlon MPs; no cheapo XP-modding
going on here.  Also, all motherboards in question are running most
recent BIOSes and officially support the CPUs they're using.  The K7Ds
are using MP2400s, the Gigabyte is running MP2800s)

Thanks,
Monty


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="bad.txt"

Jul 20 22:25:36 Snotfish syslogd 1.4.1#11: restart.
Jul 20 22:25:36 Snotfish kernel: klogd 1.4.1#11, log source = /proc/kmsg started.
Jul 20 22:25:37 Snotfish kernel: Inspecting /boot/System.map-2.4.27-rc3
Jul 20 22:25:37 Snotfish named[455]: starting (/etc/bind/named.conf).  named 8.3.3-REL-NOESW Tue Jul  2 12:00:28 CEST 2002 ^Iwakkerma@satie:/home/wakkerma/NMU/bind-8.3.3/src/bin/named
Jul 20 22:25:37 Snotfish kernel: Loaded 23663 symbols from /boot/System.map-2.4.27-rc3.
Jul 20 22:25:37 Snotfish kernel: Symbols match kernel version 2.4.27.
Jul 20 22:25:37 Snotfish kernel: Loaded 90 symbols from 6 modules.
Jul 20 22:25:37 Snotfish kernel: Linux version 2.4.27-rc3 (root@Snotfish) (gcc version 3.3.3 (Debian 20040320)) #7 SMP Tue Jul 20 22:10:06 EDT 2004
Jul 20 22:25:37 Snotfish kernel: BIOS-provided physical RAM map:
Jul 20 22:25:37 Snotfish kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Jul 20 22:25:37 Snotfish kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Jul 20 22:25:37 Snotfish kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Jul 20 22:25:37 Snotfish kernel:  BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
Jul 20 22:25:37 Snotfish kernel:  BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
Jul 20 22:25:37 Snotfish kernel:  BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
Jul 20 22:25:37 Snotfish kernel:  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
Jul 20 22:25:37 Snotfish kernel: 127MB HIGHMEM available.
Jul 20 22:25:37 Snotfish kernel: 896MB LOWMEM available.
Jul 20 22:25:37 Snotfish kernel: found SMP MP-table at 000f4df0
Jul 20 22:25:37 Snotfish kernel: hm, page 000f4000 reserved twice.
Jul 20 22:25:37 Snotfish kernel: hm, page 000f5000 reserved twice.
Jul 20 22:25:37 Snotfish kernel: hm, page 000f0000 reserved twice.
Jul 20 22:25:37 Snotfish kernel: hm, page 000f1000 reserved twice.
Jul 20 22:25:37 Snotfish kernel: On node 0 totalpages: 262128
Jul 20 22:25:37 Snotfish kernel: zone(0): 4096 pages.
Jul 20 22:25:37 Snotfish kernel: zone(1): 225280 pages.
Jul 20 22:25:37 Snotfish kernel: zone(2): 32752 pages.
Jul 20 22:25:37 Snotfish kernel: ACPI: RSDP (v000 AMD2P                                     ) @ 0x000f6830
Jul 20 22:25:37 Snotfish kernel: ACPI: RSDT (v001 AMD2P  AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x3fff3000
Jul 20 22:25:37 Snotfish kernel: ACPI: FADT (v001 AMD2P  AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x3fff3040
Jul 20 22:25:37 Snotfish kernel: ACPI: MADT (v001 AMD2P  AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x3fff6300
Jul 20 22:25:37 Snotfish kernel: ACPI: DSDT (v001 AMD2P  AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
Jul 20 22:25:37 Snotfish kernel: ACPI: Local APIC address 0xfee00000
Jul 20 22:25:37 Snotfish kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Jul 20 22:25:37 Snotfish kernel: Processor #0 Pentium(tm) Pro APIC version 16
Jul 20 22:25:37 Snotfish kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Jul 20 22:25:37 Snotfish kernel: Processor #1 Pentium(tm) Pro APIC version 16
Jul 20 22:25:37 Snotfish kernel: ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
Jul 20 22:25:37 Snotfish kernel: ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
Jul 20 22:25:37 Snotfish kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
Jul 20 22:25:37 Snotfish kernel: IOAPIC[0]: Assigned apic_id 2
Jul 20 22:25:37 Snotfish kernel: IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-23
Jul 20 22:25:37 Snotfish kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Jul 20 22:25:37 Snotfish kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Jul 20 22:25:37 Snotfish kernel: Using ACPI (MADT) for SMP configuration information
Jul 20 22:25:37 Snotfish kernel: Kernel command line: BOOT_IMAGE=Linux ro root=801 hda=ide-scsi hdb=ide-scsi hdc=ide-scsi hdd=ide-scsi
Jul 20 22:25:37 Snotfish kernel: ide_setup: hda=ide-scsi
Jul 20 22:25:37 Snotfish kernel: ide_setup: hdb=ide-scsi
Jul 20 22:25:37 Snotfish kernel: ide_setup: hdc=ide-scsi
Jul 20 22:25:37 Snotfish kernel: ide_setup: hdd=ide-scsi
Jul 20 22:25:37 Snotfish kernel: Initializing CPU#0
Jul 20 22:25:37 Snotfish kernel: Detected 2133.468 MHz processor.
Jul 20 22:25:37 Snotfish kernel: Console: colour VGA+ 80x25
Jul 20 22:25:37 Snotfish kernel: Calibrating delay loop... 4259.84 BogoMIPS
Jul 20 22:25:37 Snotfish kernel: Memory: 1032004k/1048512k available (2503k kernel code, 16120k reserved, 728k data, 164k init, 131008k highmem)
Jul 20 22:25:37 Snotfish kernel: Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Jul 20 22:25:37 Snotfish kernel: Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Jul 20 22:25:37 Snotfish kernel: Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Jul 20 22:25:37 Snotfish kernel: Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
Jul 20 22:25:37 Snotfish kernel: Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
Jul 20 22:25:37 Snotfish kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Jul 20 22:25:37 Snotfish kernel: CPU: L2 Cache: 512K (64 bytes/line)
Jul 20 22:25:37 Snotfish kernel: Intel machine check architecture supported.
Jul 20 22:25:37 Snotfish kernel: Intel machine check reporting enabled on CPU#0.
Jul 20 22:25:37 Snotfish kernel: CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
Jul 20 22:25:37 Snotfish kernel: CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
Jul 20 22:25:37 Snotfish kernel: Enabling fast FPU save and restore... done.
Jul 20 22:25:37 Snotfish kernel: Enabling unmasked SIMD FPU exception support... done.
Jul 20 22:25:37 Snotfish kernel: Checking 'hlt' instruction... OK.
Jul 20 22:25:37 Snotfish kernel: POSIX conformance testing by UNIFIX
Jul 20 22:25:37 Snotfish kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
Jul 20 22:25:37 Snotfish kernel: mtrr: detected mtrr type: Intel
Jul 20 22:25:37 Snotfish kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Jul 20 22:25:37 Snotfish kernel: CPU: L2 Cache: 512K (64 bytes/line)
Jul 20 22:25:37 Snotfish kernel: Intel machine check reporting enabled on CPU#0.
Jul 20 22:25:37 Snotfish kernel: CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
Jul 20 22:25:37 Snotfish kernel: CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
Jul 20 22:25:37 Snotfish kernel: CPU0: AMD Athlon(tm) MP 2800+ stepping 00
Jul 20 22:25:37 Snotfish kernel: per-CPU timeslice cutoff: 1462.85 usecs.
Jul 20 22:25:37 Snotfish kernel: enabled ExtINT on CPU#0
Jul 20 22:25:37 Snotfish kernel: ESR value before enabling vector: 00000000
Jul 20 22:25:37 Snotfish kernel: ESR value after enabling vector: 00000000
Jul 20 22:25:37 Snotfish kernel: Booting processor 1/1 eip 3000
Jul 20 22:25:37 Snotfish kernel: Initializing CPU#1
Jul 20 22:25:37 Snotfish kernel: masked ExtINT on CPU#1
Jul 20 22:25:37 Snotfish kernel: ESR value before enabling vector: 00000000
Jul 20 22:25:37 Snotfish kernel: ESR value after enabling vector: 00000000
Jul 20 22:25:37 Snotfish kernel: Calibrating delay loop... 2798.38 BogoMIPS
Jul 20 22:25:37 Snotfish kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Jul 20 22:25:37 Snotfish kernel: CPU: L2 Cache: 64K (64 bytes/line)
Jul 20 22:25:37 Snotfish kernel: Intel machine check reporting enabled on CPU#1.
Jul 20 22:25:37 Snotfish kernel: CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
Jul 20 22:25:37 Snotfish kernel: CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
Jul 20 22:25:37 Snotfish kernel: CPU1: AMD Unknown CPU Type stepping 00
Jul 20 22:25:37 Snotfish kernel: Total of 2 processors activated (7058.22 BogoMIPS).
Jul 20 22:25:37 Snotfish kernel: ENABLING IO-APIC IRQs
Jul 20 22:25:37 Snotfish kernel: init IO_APIC IRQs
Jul 20 22:25:37 Snotfish kernel:  IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
Jul 20 22:25:37 Snotfish kernel: ..TIMER: vector=0x31 pin1=2 pin2=-1
Jul 20 22:25:37 Snotfish kernel: Using local APIC timer interrupts.
Jul 20 22:25:37 Snotfish kernel: calibrating APIC timer ...
Jul 20 22:25:37 Snotfish kernel: ..... CPU clock speed is 2133.4421 MHz.
Jul 20 22:25:37 Snotfish kernel: ..... host bus clock speed is 266.6800 MHz.
Jul 20 22:25:37 Snotfish kernel: cpu: 0, clocks: 2666800, slice: 888933
Jul 20 22:25:37 Snotfish kernel: CPU0<T0:2666800,T1:1777856,D:11,S:888933,C:2666800>
Jul 20 22:25:37 Snotfish kernel: cpu: 1, clocks: 2666800, slice: 888933
Jul 20 22:25:37 Snotfish kernel: CPU1<T0:2666800,T1:888928,D:6,S:888933,C:2666800>
Jul 20 22:25:37 Snotfish kernel: checking TSC synchronization across CPUs: 
Jul 20 22:25:37 Snotfish kernel: BIOS BUG: CPU#0 improperly initialized, has 5961591 usecs TSC skew! FIXED.
Jul 20 22:25:37 Snotfish kernel: BIOS BUG: CPU#1 improperly initialized, has -5961591 usecs TSC skew! FIXED.
Jul 20 22:25:37 Snotfish kernel: Waiting on wait_init_idle (map = 0x2)
Jul 20 22:25:37 Snotfish kernel: All processors have done init_idle
Jul 20 22:25:37 Snotfish kernel: mtrr: your CPUs had inconsistent fixed MTRR settings
Jul 20 22:25:37 Snotfish kernel: mtrr: probably your BIOS does not setup all CPUs
Jul 20 22:25:37 Snotfish kernel: ACPI: Subsystem revision 20040326
Jul 20 22:25:37 Snotfish kernel: PCI: PCI BIOS revision 2.10 entry at 0xfa320, last bus=2
Jul 20 22:25:37 Snotfish kernel: PCI: Using configuration type 1
Jul 20 22:25:37 Snotfish kernel: ACPI: Interpreter enabled
Jul 20 22:25:37 Snotfish kernel: ACPI: Using IOAPIC for interrupt routing
Jul 20 22:25:37 Snotfish kernel: ACPI: System [ACPI] (supports S0 S1 S4 S5)
Jul 20 22:25:37 Snotfish kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Jul 20 22:25:37 Snotfish kernel: PCI: Probing PCI hardware (bus 00)
Jul 20 22:25:37 Snotfish kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Jul 20 22:25:37 Snotfish kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.OP2P._PRT]
Jul 20 22:25:37 Snotfish kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPP._PRT]
Jul 20 22:25:37 Snotfish kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 10 11 12 14 15)
Jul 20 22:25:37 Snotfish kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
Jul 20 22:25:37 Snotfish kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Jul 20 22:25:37 Snotfish kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Jul 20 22:25:37 Snotfish kernel: PCI: Probing PCI hardware
Jul 20 22:25:37 Snotfish kernel: 00:00:08[A] -> 2-16 -> IRQ 16 level low
Jul 20 22:25:37 Snotfish kernel: 00:00:08[B] -> 2-17 -> IRQ 17 level low
Jul 20 22:25:37 Snotfish kernel: 00:00:08[C] -> 2-18 -> IRQ 18 level low
Jul 20 22:25:37 Snotfish kernel: 00:00:08[D] -> 2-19 -> IRQ 19 level low
Jul 20 22:25:37 Snotfish kernel: number of MP IRQ sources: 15.
Jul 20 22:25:37 Snotfish kernel: number of IO-APIC #2 registers: 24.
Jul 20 22:25:37 Snotfish kernel: testing the IO APIC.......................
Jul 20 22:25:37 Snotfish kernel: 
Jul 20 22:25:37 Snotfish kernel: IO APIC #2......
Jul 20 22:25:37 Snotfish kernel: .... register #00: 02000000
Jul 20 22:25:37 Snotfish kernel: .......    : physical APIC id: 02
Jul 20 22:25:37 Snotfish kernel: .......    : Delivery Type: 0
Jul 20 22:25:37 Snotfish kernel: .......    : LTS          : 0
Jul 20 22:25:37 Snotfish kernel: .... register #01: 00170011
Jul 20 22:25:37 Snotfish kernel: .......     : max redirection entries: 0017
Jul 20 22:25:37 Snotfish kernel: .......     : PRQ implemented: 0
Jul 20 22:25:37 Snotfish kernel: .......     : IO APIC version: 0011
Jul 20 22:25:37 Snotfish kernel: .... register #02: 00000000
Jul 20 22:25:37 Snotfish kernel: .......     : arbitration: 00
Jul 20 22:25:37 Snotfish kernel: .... IRQ redirection table:
Jul 20 22:25:37 Snotfish kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
Jul 20 22:25:37 Snotfish kernel:  00 000 00  1    0    0   0   0    0    0    00
Jul 20 22:25:37 Snotfish kernel:  01 003 03  0    0    0   0   0    1    1    39
Jul 20 22:25:37 Snotfish kernel:  02 003 03  0    0    0   0   0    1    1    31
Jul 20 22:25:37 Snotfish kernel:  03 003 03  0    0    0   0   0    1    1    41
Jul 20 22:25:37 Snotfish kernel:  04 003 03  0    0    0   0   0    1    1    49
Jul 20 22:25:37 Snotfish kernel:  05 003 03  0    0    0   0   0    1    1    51
Jul 20 22:25:37 Snotfish kernel:  06 003 03  0    0    0   0   0    1    1    59
Jul 20 22:25:37 Snotfish kernel:  07 003 03  0    0    0   0   0    1    1    61
Jul 20 22:25:37 Snotfish kernel:  08 003 03  0    0    0   0   0    1    1    69
Jul 20 22:25:37 Snotfish kernel:  09 003 03  0    1    0   1   0    1    1    71
Jul 20 22:25:37 Snotfish kernel:  0a 003 03  0    0    0   0   0    1    1    79
Jul 20 22:25:37 Snotfish kernel:  0b 003 03  0    0    0   0   0    1    1    81
Jul 20 22:25:37 Snotfish kernel:  0c 003 03  0    0    0   0   0    1    1    89
Jul 20 22:25:37 Snotfish kernel:  0d 003 03  0    0    0   0   0    1    1    91
Jul 20 22:25:37 Snotfish kernel:  0e 003 03  0    0    0   0   0    1    1    99
Jul 20 22:25:37 Snotfish kernel:  0f 003 03  0    0    0   0   0    1    1    A1
Jul 20 22:25:37 Snotfish kernel:  10 003 03  1    1    0   1   0    1    1    A9
Jul 20 22:25:37 Snotfish kernel:  11 003 03  1    1    0   1   0    1    1    B1
Jul 20 22:25:37 Snotfish kernel:  12 003 03  1    1    0   1   0    1    1    B9
Jul 20 22:25:37 Snotfish kernel:  13 003 03  1    1    0   1   0    1    1    C1
Jul 20 22:25:37 Snotfish kernel:  14 000 00  1    0    0   0   0    0    0    00
Jul 20 22:25:37 Snotfish kernel:  15 000 00  1    0    0   0   0    0    0    00
Jul 20 22:25:37 Snotfish kernel:  16 000 00  1    0    0   0   0    0    0    00
Jul 20 22:25:37 Snotfish kernel:  17 000 00  1    0    0   0   0    0    0    00
Jul 20 22:25:37 Snotfish kernel: IRQ to pin mappings:
Jul 20 22:25:37 Snotfish kernel: IRQ0 -> 0:2
Jul 20 22:25:37 Snotfish kernel: IRQ1 -> 0:1
Jul 20 22:25:37 Snotfish kernel: IRQ3 -> 0:3
Jul 20 22:25:37 Snotfish kernel: IRQ4 -> 0:4
Jul 20 22:25:37 Snotfish kernel: IRQ5 -> 0:5
Jul 20 22:25:37 Snotfish kernel: IRQ6 -> 0:6
Jul 20 22:25:37 Snotfish kernel: IRQ7 -> 0:7
Jul 20 22:25:37 Snotfish kernel: IRQ8 -> 0:8
Jul 20 22:25:37 Snotfish kernel: IRQ9 -> 0:9
Jul 20 22:25:37 Snotfish kernel: IRQ10 -> 0:10
Jul 20 22:25:37 Snotfish kernel: IRQ11 -> 0:11
Jul 20 22:25:37 Snotfish kernel: IRQ12 -> 0:12
Jul 20 22:25:37 Snotfish kernel: IRQ13 -> 0:13
Jul 20 22:25:37 Snotfish kernel: IRQ14 -> 0:14
Jul 20 22:25:37 Snotfish kernel: IRQ15 -> 0:15
Jul 20 22:25:37 Snotfish kernel: IRQ16 -> 0:16
Jul 20 22:25:37 Snotfish kernel: IRQ17 -> 0:17
Jul 20 22:25:37 Snotfish kernel: IRQ18 -> 0:18
Jul 20 22:25:37 Snotfish kernel: IRQ19 -> 0:19
Jul 20 22:25:37 Snotfish kernel: .................................... done.
Jul 20 22:25:37 Snotfish kernel: PCI: Using ACPI for IRQ routing
Jul 20 22:25:37 Snotfish kernel: BIOS failed to enable PCI standards compliance, fixing this error.
Jul 20 22:25:37 Snotfish kernel: isapnp: Scanning for PnP cards...
Jul 20 22:25:37 Snotfish kernel: isapnp: No Plug & Play device found
Jul 20 22:25:37 Snotfish kernel: Linux NET4.0 for Linux 2.4
Jul 20 22:25:37 Snotfish kernel: Based upon Swansea University Computer Society NET3.039
Jul 20 22:25:37 Snotfish kernel: Initializing RT netlink socket
Jul 20 22:25:37 Snotfish kernel: Starting kswapd
Jul 20 22:25:37 Snotfish kernel: allocated 32 pages and 32 bhs reserved for the highmem bounces
Jul 20 22:25:37 Snotfish kernel: VFS: Disk quotas vdquot_6.5.1
Jul 20 22:25:37 Snotfish kernel: Journalled Block Device driver loaded
Jul 20 22:25:37 Snotfish kernel: devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
Jul 20 22:25:37 Snotfish kernel: devfs: devfs_debug: 0x0
Jul 20 22:25:37 Snotfish kernel: devfs: boot_options: 0x0
Jul 20 22:25:37 Snotfish kernel: Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Jul 20 22:25:37 Snotfish kernel: SGI XFS with no debug enabled
Jul 20 22:25:37 Snotfish kernel: pty: 256 Unix98 ptys configured
Jul 20 22:25:37 Snotfish kernel: Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
Jul 20 22:25:37 Snotfish kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Jul 20 22:25:37 Snotfish kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
Jul 20 22:25:37 Snotfish kernel: Real Time Clock Driver v1.10f
Jul 20 22:25:37 Snotfish kernel: amd768_rng: AMD768 system management I/O registers at 0x5000.
Jul 20 22:25:37 Snotfish kernel: amd768_rng hardware driver 0.1.0 loaded
Jul 20 22:25:37 Snotfish kernel: hw_random: AMD768 system management I/O registers at 0x5000.
Jul 20 22:25:37 Snotfish kernel: hw_random: misc device register failed
Jul 20 22:25:37 Snotfish kernel: amd76x_pm: Version 20020730
Jul 20 22:25:37 Snotfish kernel: amd76x_pm: Initializing northbridge Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller
Jul 20 22:25:37 Snotfish kernel: amd76x_pm: Initializing southbridge Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI
Jul 20 22:25:37 Snotfish kernel: Floppy drive(s): fd0 is 1.44M
Jul 20 22:25:37 Snotfish kernel: FDC 0 is a post-1991 82077
Jul 20 22:25:37 Snotfish kernel: eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
Jul 20 22:25:37 Snotfish kernel: eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
Jul 20 22:25:37 Snotfish kernel: eth0: OEM i82557/i82558 10/100 Ethernet, 00:0D:61:6B:46:2B, IRQ 16.
Jul 20 22:25:37 Snotfish kernel:   Board assembly a30469-002, Physical connectors present: RJ45
Jul 20 22:25:37 Snotfish kernel:   Primary interface chip i82555 PHY #1.
Jul 20 22:25:37 Snotfish kernel:   General self-test: passed.
Jul 20 22:25:37 Snotfish kernel:   Serial sub-system self-test: passed.
Jul 20 22:25:37 Snotfish kernel:   Internal registers self-test: passed.
Jul 20 22:25:37 Snotfish kernel:   ROM checksum self-test: passed (0xb874c1d3).
Jul 20 22:25:37 Snotfish kernel: Linux agpgart interface v0.99 (c) Jeff Hartmann
Jul 20 22:25:37 Snotfish kernel: agpgart: Maximum main memory to use for agp memory: 941M
Jul 20 22:25:37 Snotfish kernel: agpgart: Detected AMD 760MP chipset
Jul 20 22:25:37 Snotfish kernel: agpgart: AGP aperture is 128M @ 0xe8000000

[etc]

--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="good.txt"

Jul 22 23:13:49 Snotfish syslogd 1.4.1#11: restart.
Jul 22 23:13:49 Snotfish kernel: klogd 1.4.1#11, log source = /proc/kmsg started.
Jul 22 23:13:49 Snotfish kernel: Inspecting /boot/System.map-2.4.27-rc3
Jul 22 23:13:49 Snotfish named[455]: starting (/etc/bind/named.conf).  named 8.3.3-REL-NOESW Tue Jul  2 12:00:28 CEST 2002 ^Iwakkerma@satie:/home/wakkerma/NMU/bind-8.3.3/src/bin/named
Jul 22 23:13:49 Snotfish kernel: Loaded 23663 symbols from /boot/System.map-2.4.27-rc3.
Jul 22 23:13:49 Snotfish kernel: Symbols match kernel version 2.4.27.
Jul 22 23:13:49 Snotfish kernel: Loaded 99 symbols from 9 modules.
Jul 22 23:13:49 Snotfish kernel: Linux version 2.4.27-rc3 (root@Snotfish) (gcc version 3.3.3 (Debian 20040320)) #8 SMP Wed Jul 21 22:13:54 EDT 2004
Jul 22 23:13:49 Snotfish kernel: BIOS-provided physical RAM map:
Jul 22 23:13:49 Snotfish kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Jul 22 23:13:49 Snotfish kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Jul 22 23:13:49 Snotfish kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Jul 22 23:13:49 Snotfish kernel:  BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
Jul 22 23:13:49 Snotfish kernel:  BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
Jul 22 23:13:49 Snotfish kernel:  BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
Jul 22 23:13:49 Snotfish kernel:  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
Jul 22 23:13:49 Snotfish kernel: 127MB HIGHMEM available.
Jul 22 23:13:49 Snotfish kernel: 896MB LOWMEM available.
Jul 22 23:13:49 Snotfish kernel: found SMP MP-table at 000f4df0
Jul 22 23:13:49 Snotfish kernel: hm, page 000f4000 reserved twice.
Jul 22 23:13:49 Snotfish kernel: hm, page 000f5000 reserved twice.
Jul 22 23:13:49 Snotfish kernel: hm, page 000f0000 reserved twice.
Jul 22 23:13:49 Snotfish kernel: hm, page 000f1000 reserved twice.
Jul 22 23:13:49 Snotfish kernel: On node 0 totalpages: 262128
Jul 22 23:13:49 Snotfish kernel: zone(0): 4096 pages.
Jul 22 23:13:49 Snotfish kernel: zone(1): 225280 pages.
Jul 22 23:13:49 Snotfish kernel: zone(2): 32752 pages.
Jul 22 23:13:49 Snotfish kernel: ACPI: RSDP (v000 AMD2P                                     ) @ 0x000f6830
Jul 22 23:13:49 Snotfish kernel: ACPI: RSDT (v001 AMD2P  AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x3fff3000
Jul 22 23:13:49 Snotfish kernel: ACPI: FADT (v001 AMD2P  AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x3fff3040
Jul 22 23:13:49 Snotfish kernel: ACPI: MADT (v001 AMD2P  AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x3fff6300
Jul 22 23:13:49 Snotfish kernel: ACPI: DSDT (v001 AMD2P  AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
Jul 22 23:13:49 Snotfish kernel: ACPI: Local APIC address 0xfee00000
Jul 22 23:13:49 Snotfish kernel: ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Jul 22 23:13:49 Snotfish kernel: Processor #0 Pentium(tm) Pro APIC version 16
Jul 22 23:13:49 Snotfish kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Jul 22 23:13:49 Snotfish kernel: Processor #1 Pentium(tm) Pro APIC version 16
Jul 22 23:13:49 Snotfish kernel: ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
Jul 22 23:13:49 Snotfish kernel: ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
Jul 22 23:13:49 Snotfish kernel: ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
Jul 22 23:13:49 Snotfish kernel: IOAPIC[0]: Assigned apic_id 2
Jul 22 23:13:49 Snotfish kernel: IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, IRQ 0-23
Jul 22 23:13:49 Snotfish kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Jul 22 23:13:49 Snotfish kernel: ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
Jul 22 23:13:49 Snotfish kernel: Using ACPI (MADT) for SMP configuration information
Jul 22 23:13:49 Snotfish kernel: Kernel command line: BOOT_IMAGE=Linux ro root=801 hda=ide-scsi hdb=ide-scsi hdc=ide-scsi hdd=ide-scsi
Jul 22 23:13:49 Snotfish kernel: ide_setup: hda=ide-scsi
Jul 22 23:13:49 Snotfish kernel: ide_setup: hdb=ide-scsi
Jul 22 23:13:49 Snotfish kernel: ide_setup: hdc=ide-scsi
Jul 22 23:13:49 Snotfish kernel: ide_setup: hdd=ide-scsi
Jul 22 23:13:49 Snotfish kernel: Initializing CPU#0
Jul 22 23:13:49 Snotfish kernel: Detected 2159.681 MHz processor.
Jul 22 23:13:49 Snotfish kernel: Console: colour VGA+ 80x25
Jul 22 23:13:49 Snotfish kernel: Calibrating delay loop... 4312.26 BogoMIPS
Jul 22 23:13:49 Snotfish kernel: Memory: 1032004k/1048512k available (2501k kernel code, 16120k reserved, 728k data, 164k init, 131008k highmem)
Jul 22 23:13:49 Snotfish kernel: Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Jul 22 23:13:49 Snotfish kernel: Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Jul 22 23:13:49 Snotfish kernel: Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Jul 22 23:13:49 Snotfish kernel: Buffer cache hash table entries: 65536 (order: 6, 262144 bytes)
Jul 22 23:13:49 Snotfish kernel: Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
Jul 22 23:13:49 Snotfish kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Jul 22 23:13:49 Snotfish kernel: CPU: L2 Cache: 512K (64 bytes/line)
Jul 22 23:13:49 Snotfish kernel: Intel machine check architecture supported.
Jul 22 23:13:49 Snotfish kernel: Intel machine check reporting enabled on CPU#0.
Jul 22 23:13:49 Snotfish kernel: CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
Jul 22 23:13:49 Snotfish kernel: CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
Jul 22 23:13:49 Snotfish kernel: Enabling fast FPU save and restore... done.
Jul 22 23:13:49 Snotfish kernel: Enabling unmasked SIMD FPU exception support... done.
Jul 22 23:13:49 Snotfish kernel: Checking 'hlt' instruction... OK.
Jul 22 23:13:49 Snotfish kernel: POSIX conformance testing by UNIFIX
Jul 22 23:13:49 Snotfish kernel: mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
Jul 22 23:13:49 Snotfish kernel: mtrr: detected mtrr type: Intel
Jul 22 23:13:49 Snotfish kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Jul 22 23:13:49 Snotfish kernel: CPU: L2 Cache: 512K (64 bytes/line)
Jul 22 23:13:49 Snotfish kernel: Intel machine check reporting enabled on CPU#0.
Jul 22 23:13:49 Snotfish kernel: CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
Jul 22 23:13:49 Snotfish kernel: CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
Jul 22 23:13:49 Snotfish kernel: CPU0: AMD Athlon(tm) MP 2800+ stepping 00
Jul 22 23:13:49 Snotfish kernel: per-CPU timeslice cutoff: 1463.27 usecs.
Jul 22 23:13:49 Snotfish kernel: enabled ExtINT on CPU#0
Jul 22 23:13:49 Snotfish kernel: ESR value before enabling vector: 00000000
Jul 22 23:13:49 Snotfish kernel: ESR value after enabling vector: 00000000
Jul 22 23:13:49 Snotfish kernel: Booting processor 1/1 eip 3000
Jul 22 23:13:49 Snotfish kernel: Initializing CPU#1
Jul 22 23:13:49 Snotfish kernel: masked ExtINT on CPU#1
Jul 22 23:13:49 Snotfish kernel: ESR value before enabling vector: 00000000
Jul 22 23:13:49 Snotfish kernel: ESR value after enabling vector: 00000000
Jul 22 23:13:49 Snotfish kernel: Calibrating delay loop... 4312.26 BogoMIPS
Jul 22 23:13:49 Snotfish kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Jul 22 23:13:49 Snotfish kernel: CPU: L2 Cache: 512K (64 bytes/line)
Jul 22 23:13:49 Snotfish kernel: Intel machine check reporting enabled on CPU#1.
Jul 22 23:13:49 Snotfish kernel: CPU:     After generic, caps: 0383fbff c1cbfbff 00000000 00000000
Jul 22 23:13:49 Snotfish kernel: CPU:             Common caps: 0383fbff c1cbfbff 00000000 00000000
Jul 22 23:13:49 Snotfish kernel: CPU1: AMD Athlon(tm) MP stepping 00
Jul 22 23:13:49 Snotfish kernel: Total of 2 processors activated (8624.53 BogoMIPS).
Jul 22 23:13:49 Snotfish kernel: ENABLING IO-APIC IRQs
Jul 22 23:13:49 Snotfish kernel: init IO_APIC IRQs
Jul 22 23:13:49 Snotfish kernel:  IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
Jul 22 23:13:49 Snotfish kernel: ..TIMER: vector=0x31 pin1=2 pin2=-1
Jul 22 23:13:49 Snotfish kernel: Using local APIC timer interrupts.
Jul 22 23:13:49 Snotfish kernel: calibrating APIC timer ...
Jul 22 23:13:49 Snotfish kernel: ..... CPU clock speed is 2159.6971 MHz.
Jul 22 23:13:49 Snotfish kernel: ..... host bus clock speed is 287.9593 MHz.
Jul 22 23:13:49 Snotfish kernel: cpu: 0, clocks: 2879593, slice: 959864
Jul 22 23:13:49 Snotfish kernel: CPU0<T0:2879584,T1:1919712,D:8,S:959864,C:2879593>
Jul 22 23:13:49 Snotfish kernel: cpu: 1, clocks: 2879593, slice: 959864
Jul 22 23:13:49 Snotfish kernel: CPU1<T0:2879584,T1:959856,D:0,S:959864,C:2879593>
Jul 22 23:13:49 Snotfish kernel: checking TSC synchronization across CPUs: passed.
Jul 22 23:13:49 Snotfish kernel: Waiting on wait_init_idle (map = 0x2)
Jul 22 23:13:49 Snotfish kernel: All processors have done init_idle
Jul 22 23:13:49 Snotfish kernel: mtrr: your CPUs had inconsistent fixed MTRR settings
Jul 22 23:13:49 Snotfish kernel: mtrr: probably your BIOS does not setup all CPUs
Jul 22 23:13:49 Snotfish kernel: ACPI: Subsystem revision 20040326
Jul 22 23:13:49 Snotfish kernel: PCI: PCI BIOS revision 2.10 entry at 0xfa320, last bus=2
Jul 22 23:13:49 Snotfish kernel: PCI: Using configuration type 1
Jul 22 23:13:49 Snotfish kernel: ACPI: Interpreter enabled
Jul 22 23:13:49 Snotfish kernel: ACPI: Using IOAPIC for interrupt routing
Jul 22 23:13:49 Snotfish kernel: ACPI: System [ACPI] (supports S0 S1 S4 S5)
Jul 22 23:13:49 Snotfish kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Jul 22 23:13:49 Snotfish kernel: PCI: Probing PCI hardware (bus 00)
Jul 22 23:13:49 Snotfish kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Jul 22 23:13:49 Snotfish kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.OP2P._PRT]
Jul 22 23:13:49 Snotfish kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPP._PRT]
Jul 22 23:13:49 Snotfish kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 10 11 12 14 15)
Jul 22 23:13:49 Snotfish kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
Jul 22 23:13:49 Snotfish kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Jul 22 23:13:49 Snotfish kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11 12 14 15)
Jul 22 23:13:49 Snotfish kernel: PCI: Probing PCI hardware
Jul 22 23:13:49 Snotfish kernel: 00:00:08[A] -> 2-16 -> IRQ 16 level low
Jul 22 23:13:49 Snotfish kernel: 00:00:08[B] -> 2-17 -> IRQ 17 level low
Jul 22 23:13:49 Snotfish kernel: 00:00:08[C] -> 2-18 -> IRQ 18 level low
Jul 22 23:13:49 Snotfish kernel: 00:00:08[D] -> 2-19 -> IRQ 19 level low
Jul 22 23:13:49 Snotfish kernel: number of MP IRQ sources: 15.
Jul 22 23:13:49 Snotfish kernel: number of IO-APIC #2 registers: 24.
Jul 22 23:13:49 Snotfish kernel: testing the IO APIC.......................
Jul 22 23:13:49 Snotfish kernel: 
Jul 22 23:13:49 Snotfish kernel: IO APIC #2......
Jul 22 23:13:49 Snotfish kernel: .... register #00: 02000000
Jul 22 23:13:49 Snotfish kernel: .......    : physical APIC id: 02
Jul 22 23:13:49 Snotfish kernel: .......    : Delivery Type: 0
Jul 22 23:13:49 Snotfish kernel: .......    : LTS          : 0
Jul 22 23:13:49 Snotfish kernel: .... register #01: 00170011
Jul 22 23:13:49 Snotfish kernel: .......     : max redirection entries: 0017
Jul 22 23:13:49 Snotfish kernel: .......     : PRQ implemented: 0
Jul 22 23:13:49 Snotfish kernel: .......     : IO APIC version: 0011
Jul 22 23:13:49 Snotfish kernel: .... register #02: 00000000
Jul 22 23:13:49 Snotfish kernel: .......     : arbitration: 00
Jul 22 23:13:49 Snotfish kernel: .... IRQ redirection table:
Jul 22 23:13:49 Snotfish kernel:  NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
Jul 22 23:13:49 Snotfish kernel:  00 000 00  1    0    0   0   0    0    0    00
Jul 22 23:13:49 Snotfish kernel:  01 003 03  0    0    0   0   0    1    1    39
Jul 22 23:13:49 Snotfish kernel:  02 003 03  0    0    0   0   0    1    1    31
Jul 22 23:13:49 Snotfish kernel:  03 003 03  0    0    0   0   0    1    1    41
Jul 22 23:13:49 Snotfish kernel:  04 003 03  0    0    0   0   0    1    1    49
Jul 22 23:13:49 Snotfish kernel:  05 003 03  0    0    0   0   0    1    1    51
Jul 22 23:13:49 Snotfish kernel:  06 003 03  0    0    0   0   0    1    1    59
Jul 22 23:13:49 Snotfish kernel:  07 003 03  0    0    0   0   0    1    1    61
Jul 22 23:13:49 Snotfish kernel:  08 003 03  0    0    0   0   0    1    1    69
Jul 22 23:13:49 Snotfish kernel:  09 003 03  0    1    0   1   0    1    1    71
Jul 22 23:13:49 Snotfish kernel:  0a 003 03  0    0    0   0   0    1    1    79
Jul 22 23:13:49 Snotfish kernel:  0b 003 03  0    0    0   0   0    1    1    81
Jul 22 23:13:49 Snotfish kernel:  0c 003 03  0    0    0   0   0    1    1    89
Jul 22 23:13:49 Snotfish kernel:  0d 003 03  0    0    0   0   0    1    1    91
Jul 22 23:13:49 Snotfish kernel:  0e 003 03  0    0    0   0   0    1    1    99
Jul 22 23:13:49 Snotfish kernel:  0f 003 03  0    0    0   0   0    1    1    A1
Jul 22 23:13:49 Snotfish kernel:  10 003 03  1    1    0   1   0    1    1    A9
Jul 22 23:13:49 Snotfish kernel:  11 003 03  1    1    0   1   0    1    1    B1
Jul 22 23:13:49 Snotfish kernel:  12 003 03  1    1    0   1   0    1    1    B9
Jul 22 23:13:49 Snotfish kernel:  13 003 03  1    1    0   1   0    1    1    C1
Jul 22 23:13:49 Snotfish kernel:  14 000 00  1    0    0   0   0    0    0    00
Jul 22 23:13:49 Snotfish kernel:  15 000 00  1    0    0   0   0    0    0    00
Jul 22 23:13:50 Snotfish kernel:  16 000 00  1    0    0   0   0    0    0    00
Jul 22 23:13:50 Snotfish kernel:  17 000 00  1    0    0   0   0    0    0    00
Jul 22 23:13:50 Snotfish kernel: IRQ to pin mappings:
Jul 22 23:13:50 Snotfish kernel: IRQ0 -> 0:2
Jul 22 23:13:50 Snotfish kernel: IRQ1 -> 0:1
Jul 22 23:13:50 Snotfish kernel: IRQ3 -> 0:3
Jul 22 23:13:50 Snotfish kernel: IRQ4 -> 0:4
Jul 22 23:13:50 Snotfish kernel: IRQ5 -> 0:5
Jul 22 23:13:50 Snotfish kernel: IRQ6 -> 0:6
Jul 22 23:13:50 Snotfish kernel: IRQ7 -> 0:7
Jul 22 23:13:50 Snotfish kernel: IRQ8 -> 0:8
Jul 22 23:13:50 Snotfish kernel: IRQ9 -> 0:9
Jul 22 23:13:50 Snotfish kernel: IRQ10 -> 0:10
Jul 22 23:13:50 Snotfish kernel: IRQ11 -> 0:11
Jul 22 23:13:50 Snotfish kernel: IRQ12 -> 0:12
Jul 22 23:13:50 Snotfish kernel: IRQ13 -> 0:13
Jul 22 23:13:50 Snotfish kernel: IRQ14 -> 0:14
Jul 22 23:13:50 Snotfish kernel: IRQ15 -> 0:15
Jul 22 23:13:50 Snotfish kernel: IRQ16 -> 0:16
Jul 22 23:13:50 Snotfish kernel: IRQ17 -> 0:17
Jul 22 23:13:50 Snotfish kernel: IRQ18 -> 0:18
Jul 22 23:13:50 Snotfish kernel: IRQ19 -> 0:19
Jul 22 23:13:50 Snotfish kernel: .................................... done.
Jul 22 23:13:50 Snotfish kernel: PCI: Using ACPI for IRQ routing
Jul 22 23:13:50 Snotfish kernel: BIOS failed to enable PCI standards compliance, fixing this error.
Jul 22 23:13:50 Snotfish kernel: isapnp: Scanning for PnP cards...
Jul 22 23:13:50 Snotfish kernel: isapnp: No Plug & Play device found
Jul 22 23:13:50 Snotfish kernel: Linux NET4.0 for Linux 2.4
Jul 22 23:13:50 Snotfish kernel: Based upon Swansea University Computer Society NET3.039
Jul 22 23:13:50 Snotfish kernel: Initializing RT netlink socket
Jul 22 23:13:50 Snotfish kernel: Starting kswapd
Jul 22 23:13:50 Snotfish kernel: allocated 32 pages and 32 bhs reserved for the highmem bounces
Jul 22 23:13:50 Snotfish kernel: VFS: Disk quotas vdquot_6.5.1
Jul 22 23:13:50 Snotfish kernel: Journalled Block Device driver loaded
Jul 22 23:13:50 Snotfish kernel: devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
Jul 22 23:13:50 Snotfish kernel: devfs: devfs_debug: 0x0
Jul 22 23:13:50 Snotfish kernel: devfs: boot_options: 0x0
Jul 22 23:13:50 Snotfish kernel: Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Jul 22 23:13:50 Snotfish kernel: SGI XFS with no debug enabled
Jul 22 23:13:50 Snotfish kernel: pty: 256 Unix98 ptys configured
Jul 22 23:13:50 Snotfish kernel: Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
Jul 22 23:13:50 Snotfish kernel: ttyS00 at 0x03f8 (irq = 4) is a 16550A
Jul 22 23:13:50 Snotfish kernel: ttyS01 at 0x02f8 (irq = 3) is a 16550A
Jul 22 23:13:50 Snotfish kernel: Real Time Clock Driver v1.10f
Jul 22 23:13:50 Snotfish kernel: amd768_rng: AMD768 system management I/O registers at 0x5000.
Jul 22 23:13:50 Snotfish kernel: amd768_rng hardware driver 0.1.0 loaded
Jul 22 23:13:50 Snotfish kernel: hw_random: AMD768 system management I/O registers at 0x5000.
Jul 22 23:13:50 Snotfish kernel: hw_random: misc device register failed
Jul 22 23:13:50 Snotfish kernel: amd76x_pm: Version 20020730
Jul 22 23:13:50 Snotfish kernel: amd76x_pm: Initializing northbridge Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller
Jul 22 23:13:50 Snotfish kernel: amd76x_pm: Initializing southbridge Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI
Jul 22 23:13:50 Snotfish kernel: Floppy drive(s): fd0 is 1.44M
Jul 22 23:13:50 Snotfish kernel: FDC 0 is a post-1991 82077
Jul 22 23:13:50 Snotfish kernel: eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
Jul 22 23:13:50 Snotfish kernel: eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
Jul 22 23:13:50 Snotfish kernel: eth0: OEM i82557/i82558 10/100 Ethernet, 00:0D:61:6B:46:2B, IRQ 16.
Jul 22 23:13:50 Snotfish kernel:   Board assembly a30469-002, Physical connectors present: RJ45
Jul 22 23:13:50 Snotfish kernel:   Primary interface chip i82555 PHY #1.
Jul 22 23:13:50 Snotfish kernel:   General self-test: passed.
Jul 22 23:13:50 Snotfish kernel:   Serial sub-system self-test: passed.
Jul 22 23:13:50 Snotfish kernel:   Internal registers self-test: passed.
Jul 22 23:13:50 Snotfish kernel:   ROM checksum self-test: passed (0xb874c1d3).
Jul 22 23:13:50 Snotfish kernel: Linux agpgart interface v0.99 (c) Jeff Hartmann
Jul 22 23:13:50 Snotfish kernel: agpgart: Maximum main memory to use for agp memory: 941M
Jul 22 23:13:50 Snotfish kernel: agpgart: Detected AMD 760MP chipset
Jul 22 23:13:50 Snotfish kernel: agpgart: AGP aperture is 128M @ 0xe8000000

[etc]
--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cpuinfo.txt"

Snotfish:/home/xiphmont# cat /proc/cpuinfo 
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Athlon(tm) MP 2800+
stepping        : 0
cpu MHz         : 2159.681
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 4312.26

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Athlon(tm) MP
stepping        : 0
cpu MHz         : 2159.681
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 4312.26


--3MwIy2ne0vdjdPXF--
