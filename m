Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262898AbTJUEXL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 00:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262910AbTJUEXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 00:23:11 -0400
Received: from eleanor.physics.ucsb.edu ([128.111.8.116]:17849 "EHLO
	eleanor.physics.ucsb.edu") by vger.kernel.org with ESMTP
	id S262898AbTJUEWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 00:22:18 -0400
Date: Mon, 20 Oct 2003 21:24:11 -0700 (PDT)
From: David Whysong <dwhysong@physics.ucsb.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Serious problem with Promise controller cards, 2.6.0-test[78]
Message-ID: <Pine.LNX.4.33.0310202055250.6554-100000@eleanor.physics.ucsb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Last Friday I had a system crash, and I traced the problem to a Promise
PDC20269 ATA133 card. I replaced it with a spare PDC20268 ATA100 card,
recompiled linux-2.6.0-test8 with CONFIG_BLK_DEV_PDC202XX_OLD=y and later
suffered the same failure again.

This is on a Tyan S2885 K8W motherboard, x86_64 (Opteron) SMP system with
only a single CPU installed. The Promise cards were in a PCI-X slot that
is supposed to be backwards compatible with PCI (I had to set some jumpers
for that). They did work for a while. The problem is that when the
interface is stressed, it simply stops working and does not recover. For
now I'm restoring from backups and running all my IDE disks through the
motherboard controller.

The syslog data, complete kernel config, and lspci -vv output are
attached. I'd be happy to send any other information upon request. The
"secondary channel reset" messages often continue, and that interface
never recovers. The primary channel (which is the motherboard) seems to be
fine.

--
David Whysong                                       dwhysong@physics.ucsb.edu
Astrophysics graduate student         University of California, Santa Barbara
My public PGP keys are on my web page - http://www.physics.ucsb.edu/~dwhysong
DSS PGP Key 0x903F5BD6  :  FE78 91FE 4508 106F 7C88  1706 B792 6995 903F 5BD6
D-H PGP key 0x5DAB0F91  :  BC33 0F36 FCCD E72C 441F  663A 72ED 7FB7 5DAB 0F91

Oct 18 18:27:27 sleepy syslogd 1.4.1: restart.
Oct 18 18:27:27 sleepy syslog: syslogd startup succeeded
Oct 18 18:27:27 sleepy kernel: klogd 1.4.1, log source = /proc/kmsg started.
Oct 18 18:27:27 sleepy kernel: Bootdata ok (command line is ro root=/dev/hda1)
Oct 18 18:27:27 sleepy kernel: Linux version 2.6.0-test8 (root@sleepy.sb.sd.cox.net) (gcc version 3.2) #17 SMP Sat Oct 18 13:56:36 PDT 2003
Oct 18 18:27:27 sleepy kernel: BIOS-provided physical RAM map:
Oct 18 18:27:27 sleepy kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Oct 18 18:27:27 sleepy kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Oct 18 18:27:27 sleepy kernel:  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
Oct 18 18:27:27 sleepy kernel:  BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
Oct 18 18:27:27 sleepy kernel:  BIOS-e820: 000000007fff0000 - 000000007ffff000 (ACPI data)
Oct 18 18:27:27 sleepy kernel:  BIOS-e820: 000000007ffff000 - 0000000080000000 (ACPI NVS)
Oct 18 18:27:27 sleepy kernel:  BIOS-e820: 00000000ff7c0000 - 0000000100000000 (reserved)
Oct 18 18:27:27 sleepy kernel: Scanning NUMA topology in Northbridge 24
Oct 18 18:27:27 sleepy syslog: klogd startup succeeded
Oct 18 18:27:27 sleepy kernel: Node 0 MemBase 0000000000000000 Limit 000000007fff0000
Oct 18 18:27:27 sleepy irqbalance: irqbalance startup succeeded
Oct 18 18:27:27 sleepy kernel: Using node hash shift of 24
Oct 18 18:27:28 sleepy portmap: portmap startup succeeded
Oct 18 18:27:28 sleepy kernel: Bootmem setup node 0 0000000000000000-000000007fff0000
Oct 18 18:27:28 sleepy kernel: found SMP MP-table at 000ff780
Oct 18 18:27:28 sleepy keytable: Loading keymap:
Oct 18 18:27:23 sleepy kudzu:  succeeded
Oct 18 18:27:28 sleepy kernel: hm, page 000ff000 reserved twice.
Oct 18 18:27:28 sleepy keytable:
Oct 18 18:27:23 sleepy kudzu: Updating /etc/fstab succeeded
Oct 18 18:27:28 sleepy kernel: hm, page 00100000 reserved twice.
Oct 18 18:27:28 sleepy keytable:
Oct 18 18:27:23 sleepy iptables:  failed
Oct 18 18:27:28 sleepy kernel: hm, page 000f9000 reserved twice.
Oct 18 18:27:28 sleepy rc: Starting keytable:  succeeded
Oct 18 18:27:23 sleepy iptables:  failed
Oct 18 18:27:28 sleepy kernel: hm, page 000fa000 reserved twice.
Oct 18 18:27:28 sleepy random: Initializing random number generator:  succeeded
Oct 18 18:27:23 sleepy iptables:  failed
Oct 18 18:27:28 sleepy kernel: setting up node 0 0-7fff0
Oct 18 18:27:28 sleepy autofs: automount startup succeeded
Oct 18 18:27:23 sleepy sysctl: net.ipv4.ip_forward = 0
Oct 18 18:27:28 sleepy kernel: On node 0 totalpages: 524272
Oct 18 18:27:23 sleepy sysctl: net.ipv4.conf.default.rp_filter = 1
Oct 18 18:27:29 sleepy kernel:   DMA zone: 4096 pages, LIFO batch:1
Oct 18 18:27:29 sleepy sshd:  succeeded
Oct 18 18:27:23 sleepy sysctl: kernel.sysrq = 0
Oct 18 18:27:29 sleepy kernel:   Normal zone: 520176 pages, LIFO batch:16
Oct 18 18:27:23 sleepy sysctl: kernel.core_uses_pid = 1
Oct 18 18:27:29 sleepy kernel:   HighMem zone: 0 pages, LIFO batch:1
Oct 18 18:27:23 sleepy network: Setting network parameters:  succeeded
Oct 18 18:27:30 sleepy kernel: ACPI: RSDP (v002 ACPIAM                                    ) @ 0x00000000000f4710
Oct 18 18:27:23 sleepy network: Bringing up loopback interface:  succeeded
Oct 18 18:27:30 sleepy kernel: ACPI: XSDT (v001 A M I  OEMXSDT  0x08000327 MSFT 0x00000097) @ 0x000000007fff0100
Oct 18 18:27:23 sleepy ifup:
Oct 18 18:27:30 sleepy kernel: ACPI: FADT (v001 A M I  OEMFACP  0x08000327 MSFT 0x00000097) @ 0x000000007fff0281
Oct 18 18:27:30 sleepy kernel: ACPI: MADT (v001 A M I  OEMAPIC  0x08000327 MSFT 0x00000097) @ 0x000000007fff0380
Oct 18 18:27:23 sleepy ifup: Determining IP information for eth0...
Oct 18 18:27:30 sleepy kernel: ACPI: OEMB (v001 A M I  OEMBIOS  0x08000327 MSFT 0x00000097) @ 0x000000007ffff040
Oct 18 18:27:30 sleepy kernel: ACPI: ASF! (v001 AMIASF AMDSTRET 0x00000001 INTL 0x02002026) @ 0x000000007fff3a00
Oct 18 18:27:26 sleepy dhclient: sit0: unknown hardware address type 776 <27>Oct 18 18:27:26 dhclient: gre0: unknown hardware address type 778
Oct 18 18:27:30 sleepy kernel: ACPI: DSDT (v001  0ABCF 0ABCF007 0x00000007 INTL 0x02002026) @ 0x0000000000000000
Oct 18 18:27:30 sleepy kernel: ACPI: Local APIC address 0x00000000fee00000
Oct 18 18:27:30 sleepy kernel: ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Oct 18 18:27:30 sleepy kernel: Processor #0 15:5 APIC version 16
Oct 18 18:27:30 sleepy kernel: ACPI: LAPIC (acpi_id[0x02] lapic_id[0x81] disabled)
Oct 18 18:27:30 sleepy kernel: Processor #129 invalid (max 16)
Oct 18 18:27:30 sleepy kernel: ACPI: IOAPIC (id[0x01] address[0xfec00000] global_irq_base[0x0])
Oct 18 18:27:31 sleepy kernel: IOAPIC[0]: Assigned apic_id 1
Oct 18 18:27:31 sleepy kernel: IOAPIC[0]: apic_id 1, version 17, address 0xfec00000, IRQ 0-23
Oct 18 18:27:31 sleepy kernel: ACPI: IOAPIC (id[0x02] address[0xfd9fe000] global_irq_base[0x18])
Oct 18 18:27:31 sleepy kernel: IOAPIC[1]: Assigned apic_id 2
Oct 18 18:27:31 sleepy kernel: IOAPIC[1]: apic_id 2, version 17, address 0xfd9fe000, IRQ 24-27
Oct 18 18:27:31 sleepy kernel: ACPI: IOAPIC (id[0x03] address[0xfd9ff000] global_irq_base[0x1c])
Oct 18 18:27:31 sleepy kernel: IOAPIC[2]: Assigned apic_id 3
Oct 18 18:27:31 sleepy kernel: IOAPIC[2]: apic_id 3, version 17, address 0xfd9ff000, IRQ 28-31
Oct 18 18:27:31 sleepy kernel: ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x0])
Oct 18 18:27:31 sleepy kernel: ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x0])
Oct 18 18:27:31 sleepy kernel: Using ACPI (MADT) for SMP configuration information
Oct 18 18:27:31 sleepy kernel: Checking aperture...
Oct 18 18:27:31 sleepy kernel: CPU 0: aperture @ fffe000000 size 32 MB
Oct 18 18:27:31 sleepy kernel: Aperture from northbridge cpu 0 too small (32 MB)
Oct 18 18:27:31 sleepy kernel: AGP bridge at 04:00:00
Oct 18 18:27:31 sleepy kernel: Aperture from AGP @ e0000000 size 4096 MB (APSIZE 0)
Oct 18 18:27:31 sleepy kernel: Aperture from AGP bridge too small (0 MB)
Oct 18 18:27:31 sleepy kernel: Your BIOS doesn't leave a aperture memory hole
Oct 18 18:27:31 sleepy kernel: Please enable the IOMMU option in the BIOS setup
Oct 18 18:27:31 sleepy kernel: This costs you 64 MB of RAM
Oct 18 18:27:31 sleepy kernel: Mapping aperture over 65536 KB of RAM @ 4000000
Oct 18 18:27:31 sleepy kernel: Building zonelist for node : 0
Oct 18 18:27:31 sleepy kernel: Kernel command line: ro root=/dev/hda1 console=tty0
Oct 18 18:27:31 sleepy kernel: Initializing CPU#0
Oct 18 18:27:31 sleepy kernel: PID hash table entries: 16 (order 4: 256 bytes)
Oct 18 18:27:31 sleepy kernel: time.c: Using 1.193182 MHz PIT timer.
Oct 18 18:27:31 sleepy kernel: time.c: Detected 1593.764 MHz processor.
Oct 18 18:27:31 sleepy kernel: Console: colour VGA+ 80x25
Oct 18 18:27:31 sleepy kernel: Memory: 1984584k/2097088k available (3043k kernel code, 0k reserved, 1297k data, 192k init)
Oct 18 18:27:31 sleepy kernel: Calibrating delay loop... 3129.34 BogoMIPS
Oct 18 18:27:31 sleepy kernel: Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Oct 18 18:27:31 sleepy kernel: Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Oct 18 18:27:31 sleepy kernel: Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
Oct 18 18:27:31 sleepy kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Oct 18 18:27:31 sleepy kernel: CPU: L2 Cache: 1024K (64 bytes/line)
Oct 18 18:27:31 sleepy kernel: POSIX conformance testing by UNIFIX
Oct 18 18:27:31 sleepy kernel: CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
Oct 18 18:27:31 sleepy kernel: CPU: L2 Cache: 1024K (64 bytes/line)
Oct 18 18:27:31 sleepy kernel: CPU0: AMD Opteron(tm) Processor 242 stepping 01
Oct 18 18:27:31 sleepy kernel: per-CPU timeslice cutoff: 1024.22 usecs.
Oct 18 18:27:31 sleepy kernel: task migration cache decay timeout: 2 msecs.
Oct 18 18:27:31 sleepy kernel: watchdog: setting K7_PERFCTR0 to ffe7b158
Oct 18 18:27:31 sleepy kernel: Only one processor found.
Oct 18 18:27:31 sleepy kernel: ENABLING IO-APIC IRQs
Oct 18 18:27:31 sleepy kernel: ..TIMER: vector=0x31 pin1=2 pin2=0
Oct 18 18:27:32 sleepy kernel: testing the IO APIC.......................
Oct 18 18:27:32 sleepy kernel:
Oct 18 18:27:32 sleepy last message repeated 2 times
Oct 18 18:27:32 sleepy kernel: .................................... done.
Oct 18 18:27:32 sleepy kernel: Using local APIC timer interrupts.
Oct 18 18:27:32 sleepy kernel: Detected 12.451 MHz APIC timer.
Oct 18 18:27:32 sleepy kernel: time.c: Using PIT/TSC based timekeeping.
Oct 18 18:27:32 sleepy kernel: Starting migration thread for cpu 0
Oct 18 18:27:32 sleepy kernel: CPUS done 2
Oct 18 18:27:32 sleepy kernel: NET: Registered protocol family 16
Oct 18 18:27:32 sleepy kernel: PCI: Using configuration type 1
Oct 18 18:27:32 sleepy kernel: mtrr: v2.0 (20020519)
Oct 18 18:27:32 sleepy kernel: ACPI: Subsystem revision 20031002
Oct 18 18:27:32 sleepy kernel: ACPI: Interpreter enabled
Oct 18 18:27:32 sleepy kernel: ACPI: Using IOAPIC for interrupt routing
Oct 18 18:27:32 sleepy kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Oct 18 18:27:32 sleepy kernel: PCI: Probing PCI hardware (bus 00)
Oct 18 18:27:32 sleepy kernel: ACPI: PCI Root Bridge [PCIB] (00:04)
Oct 18 18:27:32 sleepy kernel: PCI: Probing PCI hardware (bus 04)
Oct 18 18:27:32 sleepy kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
Oct 18 18:27:32 sleepy kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
Oct 18 18:27:32 sleepy kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
Oct 18 18:27:32 sleepy kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
Oct 18 18:27:32 sleepy kernel: SCSI subsystem initialized
Oct 18 18:27:32 sleepy kernel: drivers/usb/core/usb.c: registered new driver usbfs
Oct 18 18:27:32 sleepy kernel: drivers/usb/core/usb.c: registered new driver hub
Oct 18 18:27:32 sleepy kernel: PCI: Using ACPI for IRQ routing
Oct 18 18:27:32 sleepy kernel: PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Oct 18 18:27:32 sleepy kernel: PCI-DMA: Disabling IOMMU.
Oct 18 18:27:32 sleepy kernel: IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
Oct 18 18:27:32 sleepy kernel: ikconfig 0.7 with /proc/config*
Oct 18 18:27:32 sleepy kernel: udf: registering filesystem
Oct 18 18:27:32 sleepy kernel: Initializing Cryptographic API
Oct 18 18:27:32 sleepy kernel: ACPI: Processor [CPU1] (supports C1, 8 throttling states)
Oct 18 18:27:32 sleepy kernel: pty: 2048 Unix98 ptys configured
Oct 18 18:27:32 sleepy kernel: lp: driver loaded but no devices found
Oct 18 18:27:32 sleepy kernel: Real Time Clock Driver v1.12
Oct 18 18:27:32 sleepy kernel: Non-volatile memory driver v1.2
Oct 18 18:27:32 sleepy kernel: hw_random: AMD768 system management I/O registers at 0x5000.
Oct 18 18:27:32 sleepy kernel: hw_random hardware driver 1.0.0 loaded
Oct 18 18:27:32 sleepy kernel: ppdev: user-space parallel port driver
Oct 18 18:27:32 sleepy kernel: Linux agpgart interface v0.100 (c) Dave Jones
Oct 18 18:27:32 sleepy kernel: [drm:drm_init] *ERROR* Cannot initialize the agpgart module.
Oct 18 18:27:32 sleepy kernel: ipmi: message handler initialized
Oct 18 18:27:32 sleepy kernel: ipmi: device interface at char major 254
Oct 18 18:27:32 sleepy kernel: ipmi_kcs: No KCS @ port 0x0ca2
Oct 18 18:27:32 sleepy kernel: ipmi_kcs: Unable to find any KCS interfaces
Oct 18 18:27:32 sleepy kernel: IPMI watchdog by Corey Minyard (minyard@mvista.com)
Oct 18 18:27:32 sleepy kernel: Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin is 60 seconds).
Oct 18 18:27:32 sleepy kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
Oct 18 18:27:32 sleepy kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Oct 18 18:27:32 sleepy kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Oct 18 18:27:32 sleepy kernel: parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
Oct 18 18:27:32 sleepy kernel: parport0: irq 7 detected
Oct 18 18:27:32 sleepy kernel: lp0: using parport0 (polling).
Oct 18 18:27:32 sleepy kernel: lp0: console ready
Oct 18 18:27:32 sleepy kernel: RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Oct 18 18:27:32 sleepy xinetd: xinetd startup succeeded
Oct 18 18:27:32 sleepy kernel: loop: loaded (max 8 devices)
Oct 18 18:27:33 sleepy kernel: tg3.c:v2.2 (August 24, 2003)
Oct 18 18:27:33 sleepy kernel: eth0: Tigon3 [partno(BCM95703A30) rev 1002 PHY(5703)] (PCI:33MHz:64-bit) 10/100/1000BaseT Ethernet 00:e0:81:27:60:41
Oct 18 18:27:33 sleepy kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Oct 18 18:27:33 sleepy kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Oct 18 18:27:33 sleepy kernel: AMD8111: IDE controller at PCI slot 0000:00:07.1
Oct 18 18:27:33 sleepy kernel: AMD8111: chipset revision 3
Oct 18 18:27:33 sleepy kernel: AMD8111: not 100%% native mode: will probe irqs later
Oct 18 18:27:33 sleepy kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Oct 18 18:27:33 sleepy kernel: AMD_IDE: 0000:00:07.1 (rev 03) UDMA100 controller on pci0000:00:07.1
Oct 18 18:27:33 sleepy kernel:     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
Oct 18 18:27:33 sleepy kernel:     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
Oct 18 18:27:33 sleepy kernel: hda: IBM-DTTA-371440, ATA DISK drive
Oct 18 18:27:33 sleepy kernel: Using anticipatory io scheduler
Oct 18 18:27:33 sleepy kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Oct 18 18:27:33 sleepy kernel: hdc: WDC WD800BB-00CCB0, ATA DISK drive
Oct 18 18:27:33 sleepy kernel: ide1 at 0x170-0x177,0x376 on irq 15
Oct 18 18:27:33 sleepy kernel: PDC20268: IDE controller at PCI slot 0000:02:07.0
Oct 18 18:27:33 sleepy kernel: PDC20268: chipset revision 1
Oct 18 18:27:33 sleepy kernel: PDC20268: ROM enabled at 0xfd6d0000
Oct 18 18:27:33 sleepy kernel: PDC20268: 100%% native mode on irq 26
Oct 18 18:27:33 sleepy kernel:     ide2: BM-DMA at 0x7880-0x7887, BIOS settings: hde:pio, hdf:pio
Oct 18 18:27:33 sleepy kernel:     ide3: BM-DMA at 0x7888-0x788f, BIOS settings: hdg:pio, hdh:pio
Oct 18 18:27:33 sleepy kernel: hde: Maxtor 54098U8, ATA DISK drive
Oct 18 18:27:33 sleepy kernel: ide2 at 0x8c00-0x8c07,0x8082 on irq 26
Oct 18 18:27:33 sleepy kernel: hdg: Maxtor 6Y200P0, ATA DISK drive
Oct 18 18:27:33 sleepy kernel: ide3 at 0x8000-0x8007,0x7c02 on irq 26
Oct 18 18:27:33 sleepy kernel: hda: max request size: 128KiB
Oct 18 18:27:33 sleepy kernel: hda: 28229040 sectors (14453 MB) w/462KiB Cache, CHS=28005/16/63, UDMA(33)
Oct 18 18:27:33 sleepy kernel:  hda: hda1 hda2 hda3
Oct 18 18:27:33 sleepy kernel: hdc: max request size: 128KiB
Oct 18 18:27:33 sleepy kernel: hdc: 156301488 sectors (80026 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
Oct 18 18:27:33 sleepy kernel:  hdc: hdc1 hdc2
Oct 18 18:27:33 sleepy kernel: hde: max request size: 128KiB
Oct 18 18:27:33 sleepy kernel: hde: 80041248 sectors (40981 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(66)
Oct 18 18:27:33 sleepy kernel:  hde: hde1 hde2
Oct 18 18:27:33 sleepy kernel: hdg: max request size: 1024KiB
Oct 18 18:27:33 sleepy kernel: hdg: 398297088 sectors (203928 MB) w/7936KiB Cache, CHS=24792/255/63, UDMA(100)
Oct 18 18:27:33 sleepy kernel:  hdg: hdg1 hdg2
Oct 18 18:27:33 sleepy kernel: sym0: <810a> rev 0x12 at pci 0000:03:0a.0 irq 16
Oct 18 18:27:33 sleepy kernel: sym0: No NVRAM, ID 7, Fast-10, SE, parity checking
Oct 18 18:27:33 sleepy kernel: sym0: SCSI BUS has been reset.
Oct 18 18:27:33 sleepy kernel: scsi0 : sym-2.1.18b
Oct 18 18:27:33 sleepy kernel:   Vendor: PIONEER   Model: DVD-ROM DVD-303   Rev: 1.09
Oct 18 18:27:33 sleepy kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Oct 18 18:27:33 sleepy kernel:   Vendor: PLEXTOR   Model: CD-R   PX-W1210S  Rev: 1.03
Oct 18 18:27:33 sleepy kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Oct 18 18:27:33 sleepy kernel:   Vendor: TOSHIBA   Model: CD-ROM XM-6201TA  Rev: 1037
Oct 18 18:27:33 sleepy kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Oct 18 18:27:33 sleepy kernel: sym1: <1010-33> rev 0x1 at pci 0000:02:08.0 irq 27
Oct 18 18:27:33 sleepy kernel: sym1: using 64 bit DMA addressing
Oct 18 18:27:33 sleepy kernel: sym1: Symbios NVRAM, ID 7, Fast-80, SE, parity checking
Oct 18 18:27:33 sleepy kernel: sym1: open drain IRQ line driver, using on-chip SRAM
Oct 18 18:27:33 sleepy kernel: sym1: using LOAD/STORE-based firmware.
Oct 18 18:27:33 sleepy kernel: sym1: handling phase mismatch from SCRIPTS.
Oct 18 18:27:33 sleepy kernel: sym1: SCSI BUS has been reset.
Oct 18 18:27:33 sleepy kernel: scsi1 : sym-2.1.18b
Oct 18 18:27:33 sleepy kernel:   Vendor: SEAGATE   Model: DAT    06240-XXX  Rev: 8240
Oct 18 18:27:33 sleepy kernel:   Type:   Sequential-Access                  ANSI SCSI revision: 03
Oct 18 18:27:33 sleepy kernel: sym2: <1010-33> rev 0x1 at pci 0000:02:08.1 irq 24
Oct 18 18:27:33 sleepy kernel: sym2: using 64 bit DMA addressing
Oct 18 18:27:33 sleepy kernel: sym2: Symbios NVRAM, ID 7, Fast-80, SE, parity checking
Oct 18 18:27:33 sleepy kernel: sym2: open drain IRQ line driver, using on-chip SRAM
Oct 18 18:27:33 sleepy kernel: sym2: using LOAD/STORE-based firmware.
Oct 18 18:27:33 sleepy kernel: sym2: handling phase mismatch from SCRIPTS.
Oct 18 18:27:33 sleepy kernel: sym2: SCSI BUS has been reset.
Oct 18 18:27:33 sleepy kernel: scsi2 : sym-2.1.18b
Oct 18 18:27:33 sleepy kernel: st: Version 20030811, fixed bufsize 32768, s/g segs 256
Oct 18 18:27:33 sleepy kernel: Attached scsi tape st0 at scsi1, channel 0, id 6, lun 0
Oct 18 18:27:33 sleepy kernel: st0: try direct i/o: yes, max page reachable by HBA 268435455
Oct 18 18:27:33 sleepy kernel: sym0:1: FAST-10 SCSI 10.0 MB/s ST (100.0 ns, offset 8)
Oct 18 18:27:33 sleepy kernel: sr0: scsi3-mmc drive: 0x/0x cd/rw xa/form2 cdda tray
Oct 18 18:27:33 sleepy kernel: Uniform CD-ROM driver Revision: 3.12
Oct 18 18:27:33 sleepy kernel: sym0:2: FAST-10 SCSI 10.0 MB/s ST (100.0 ns, offset 8)
Oct 18 18:27:33 sleepy kernel: sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
Oct 18 18:27:33 sleepy kernel: sym0:3: FAST-10 SCSI 10.0 MB/s ST (100.0 ns, offset 8)
Oct 18 18:27:33 sleepy kernel: sr2: scsi-1 drive
Oct 18 18:27:34 sleepy kernel: Attached scsi generic sg0 at scsi0, channel 0, id 1, lun 0,  type 5
Oct 18 18:27:34 sleepy kernel: Attached scsi generic sg1 at scsi0, channel 0, id 2, lun 0,  type 5
Oct 18 18:27:34 sleepy kernel: Attached scsi generic sg2 at scsi0, channel 0, id 3, lun 0,  type 5
Oct 18 18:27:34 sleepy kernel: Attached scsi generic sg3 at scsi1, channel 0, id 6, lun 0,  type 1
Oct 18 18:27:34 sleepy kernel: ohci1394: $Rev: 1045 $ Ben Collins <bcollins@debian.org>
Oct 18 18:27:34 sleepy kernel: ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[19]  MMIO=[fd8ff000-fd8ff7ff]  Max Packet=[2048]
Oct 18 18:27:34 sleepy kernel: video1394: Installed video1394 module
Oct 18 18:27:34 sleepy kernel: raw1394: /dev/raw1394 device initialized
Oct 18 18:27:34 sleepy kernel: sbp2: $Rev: 1034 $ Ben Collins <bcollins@debian.org>
Oct 18 18:27:34 sleepy kernel: ieee1394: Loaded AMDTP driver
Oct 18 18:27:34 sleepy kernel: ieee1394: Loaded CMP driver
Oct 18 18:27:34 sleepy kernel: ohci_hcd 0000:03:00.0: OHCI Host Controller
Oct 18 18:27:33 sleepy ntpdate[707]: step time server 66.187.233.4 offset -0.466176 sec
Oct 18 18:27:33 sleepy kernel: ohci_hcd 0000:03:00.0: irq 19, pci mem ffffff000003f000
Oct 18 18:27:33 sleepy ntpd:  succeeded
Oct 18 18:27:33 sleepy kernel: ohci_hcd 0000:03:00.0: new USB bus registered, assigned bus number 1
Oct 18 18:27:34 sleepy ntpd[711]: ntpd 4.1.1c-rc1@1.836 Thu Feb 13 12:17:19 EST 2003 (1)
Oct 18 18:27:34 sleepy ntpd: ntpd startup succeeded
Oct 18 18:27:34 sleepy kernel: hub 1-0:1.0: USB hub found
Oct 18 18:27:34 sleepy vsftpd: true startup succeeded
Oct 18 18:27:34 sleepy xinetd[696]: xinetd Version 2.3.11 started with libwrap loadavg options compiled in.
Oct 18 18:27:34 sleepy xinetd[696]: Started working: 1 available service
Oct 18 18:27:34 sleepy ntpd[711]: precision = 10 usec
Oct 18 18:27:34 sleepy kernel: hub 1-0:1.0: 3 ports detected
Oct 18 18:27:34 sleepy gpm: gpm startup succeeded
Oct 18 18:27:34 sleepy ntpd[711]: kernel time discipline status 0040
Oct 18 18:27:34 sleepy kernel: ohci_hcd 0000:03:00.1: OHCI Host Controller
Oct 18 18:27:34 sleepy ntpd[711]: frequency initialized 13.565 from /etc/ntp/drift
Oct 18 18:27:34 sleepy kernel: ohci_hcd 0000:03:00.1: irq 19, pci mem ffffff0000041000
Oct 18 18:27:34 sleepy kernel: ohci_hcd 0000:03:00.1: new USB bus registered, assigned bus number 2
Oct 18 18:27:34 sleepy kernel: hub 2-0:1.0: USB hub found
Oct 18 18:27:34 sleepy kernel: hub 2-0:1.0: 3 ports detected
Oct 18 18:27:34 sleepy kernel: drivers/usb/core/usb.c: registered new driver acm
Oct 18 18:27:34 sleepy kernel: drivers/usb/class/cdc-acm.c: v0.21:USB Abstract Control Model driver for USB modems and ISDN adapters
Oct 18 18:27:34 sleepy kernel: drivers/usb/core/usb.c: registered new driver audio
Oct 18 18:27:34 sleepy kernel: drivers/usb/class/audio.c: v1.0.0:USB Audio Class driver
Oct 18 18:27:34 sleepy kernel: drivers/usb/core/usb.c: registered new driver midi
Oct 18 18:27:34 sleepy kernel: drivers/usb/core/usb.c: registered new driver usblp
Oct 18 18:27:34 sleepy crond: crond startup succeeded
Oct 18 18:27:35 sleepy kernel: drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Oct 18 18:27:35 sleepy kernel: Initializing USB Mass Storage driver...
Oct 18 18:27:35 sleepy kernel: drivers/usb/core/usb.c: registered new driver usb-storage
Oct 18 18:27:36 sleepy kernel: USB Mass Storage support registered.
Oct 18 18:27:36 sleepy kernel: drivers/usb/core/usb.c: registered new driver hid
Oct 18 18:27:36 sleepy kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Oct 18 18:27:36 sleepy kernel: drivers/usb/core/usb.c: registered new driver wacom
Oct 18 18:27:37 sleepy kernel: drivers/usb/input/wacom.c: v1.30:USB Wacom Graphire and Wacom Intuos tablet driver
Oct 18 18:27:37 sleepy kernel: drivers/usb/core/usb.c: registered new driver usbscanner
Oct 18 18:27:37 sleepy kernel: drivers/usb/image/scanner.c: 0.4.15:USB Scanner Driver
Oct 18 18:27:38 sleepy kernel: mice: PS/2 mouse device common for all mice
Oct 18 18:27:38 sleepy kernel: input: PC Speaker
Oct 18 18:27:40 sleepy kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Oct 18 18:27:40 sleepy cups: cupsd startup succeeded
Oct 18 18:27:40 sleepy kernel: input: AT Translated Set 2 keyboard on isa0060/serio0
Oct 18 18:27:40 sleepy kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Oct 18 18:27:41 sleepy kernel: i2c /dev entries driver
Oct 18 18:27:41 sleepy kernel: md: linear personality registered as nr 1
Oct 18 18:27:42 sleepy xfs: xfs startup succeeded
Oct 18 18:27:42 sleepy kernel: md: raid0 personality registered as nr 2
Oct 18 18:27:42 sleepy anacron: anacron startup succeeded
Oct 18 18:27:42 sleepy kernel: md: raid1 personality registered as nr 3
Oct 18 18:27:42 sleepy atd: atd startup succeeded
Oct 18 18:27:42 sleepy kernel: md: raid5 personality registered as nr 4
Oct 18 18:27:43 sleepy rhnsd[872]: Red Hat Network Services Daemon starting up.
Oct 18 18:27:43 sleepy rhnsd: rhnsd startup succeeded
Oct 18 18:27:43 sleepy kernel: raid5: measuring checksumming speed
Oct 18 18:27:43 sleepy kernel:    generic_sse:  4804.000 MB/sec
Oct 18 18:27:43 sleepy kernel: raid5: using function: generic_sse (4804.000 MB/sec)
Oct 18 18:27:44 sleepy kernel: md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Oct 18 18:27:44 sleepy kernel: Intel 810 + AC97 Audio, version 0.24, 13:53:59 Oct 18 2003
Oct 18 18:27:45 sleepy kernel: i810: AMD-8111 IOHub found at IO 0xbc00 and 0xb800, MEM 0x0000 and 0x0000, IRQ 17
Oct 18 18:27:46 sleepy kernel: hub 2-0:1.0: new USB device on port 2, assigned address 2
Oct 18 18:27:46 sleepy kernel: midi: probe of 2-2:1.0 failed with error -5
Oct 18 18:27:47 sleepy kernel: i810_audio: Audio Controller supports 6 channels.
Oct 18 18:27:47 sleepy kernel: i810_audio: Defaulting to base 2 channel mode.
Oct 18 18:27:48 sleepy kernel: i810_audio: Resetting connection 0
Oct 18 18:27:48 sleepy kernel: ac97_codec: AC97 Audio codec, id: ADS116 (Unknown)
Oct 18 18:27:48 sleepy kernel: i810_audio: AC'97 codec 0 supports AMAP, total channels = 2
Oct 18 18:27:49 sleepy kernel: i810_audio: setting clocking to 48979
Oct 18 18:27:49 sleepy kernel: NET: Registered protocol family 2
Oct 18 18:27:49 sleepy kernel: drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if 0 alt 0 proto 2 vid 0x04F9 pid 0x000D
Oct 18 18:27:49 sleepy kernel: IP: routing cache hash table of 8192 buckets, 128Kbytes
Oct 18 18:27:49 sleepy kernel: TCP: Hash tables configured (established 262144 bind 65536)
Oct 18 18:27:50 sleepy kernel: IPv4 over IPv4 tunneling driver
Oct 18 18:27:50 sleepy kernel: GRE over IPv4 tunneling driver
Oct 18 18:27:50 sleepy kernel: ip_conntrack version 2.1 (8192 buckets, 65536 max) - 448 bytes per conntrack
Oct 18 18:27:50 sleepy kernel: ip_tables: (C) 2000-2002 Netfilter core team
Oct 18 18:27:50 sleepy kernel: arp_tables: (C) 2002 David S. Miller
Oct 18 18:27:50 sleepy kernel: NET: Registered protocol family 1
Oct 18 18:27:50 sleepy kernel: NET: Registered protocol family 10
Oct 18 18:27:50 sleepy kernel: IPv6 over IPv4 tunneling driver
Oct 18 18:27:50 sleepy kernel: ip6_tables: (C) 2000-2002 Netfilter core team
Oct 18 18:27:50 sleepy kernel: NET: Registered protocol family 17
Oct 18 18:27:50 sleepy kernel: md: Autodetecting RAID arrays.
Oct 18 18:27:50 sleepy kernel: md: autorun ...
Oct 18 18:27:50 sleepy kernel: md: ... autorun DONE.
Oct 18 18:27:50 sleepy kernel: kjournald starting.  Commit interval 5 seconds
Oct 18 18:27:50 sleepy kernel: EXT3-fs: mounted filesystem with ordered data mode.
Oct 18 18:27:50 sleepy kernel: VFS: Mounted root (ext3 filesystem) readonly.
Oct 18 18:27:50 sleepy kernel: Freeing unused kernel memory: 192k freed
Oct 18 18:27:50 sleepy kernel: hub 2-0:1.0: new USB device on port 3, assigned address 3
Oct 18 18:27:50 sleepy kernel: midi: probe of 2-3:1.0 failed with error -5
Oct 18 18:27:50 sleepy kernel: input: USB HID v1.10 Mouse [Logitech USB Mouse] on usb-0000:03:00.1-3
Oct 18 18:27:50 sleepy kernel: modprobe: 32bit 2.4.x modutils not supported on 64bit kernel
Oct 18 18:27:50 sleepy last message repeated 2 times
Oct 18 18:27:50 sleepy kernel: EXT3 FS on hda1, internal journal
Oct 18 18:27:50 sleepy kernel: Adding 995988k swap on /dev/hdg1.  Priority:1 extents:1
Oct 18 18:27:50 sleepy kernel: Adding 1048784k swap on /dev/hdc1.  Priority:1 extents:1
Oct 18 18:27:50 sleepy kernel: Adding 1052216k swap on /dev/hde1.  Priority:1 extents:1
Oct 18 18:27:50 sleepy kernel: lsmod: 32bit 2.4.x modutils not supported on 64bit kernel
Oct 18 18:27:50 sleepy kernel: modprobe: 32bit 2.4.x modutils not supported on 64bit kernel
Oct 18 18:27:50 sleepy kernel: lsmod: 32bit 2.4.x modutils not supported on 64bit kernel
Oct 18 18:27:50 sleepy kernel: modprobe: 32bit 2.4.x modutils not supported on 64bit kernel
Oct 18 18:27:50 sleepy kernel: kjournald starting.  Commit interval 5 seconds
Oct 18 18:27:50 sleepy kernel: EXT3 FS on hdg2, internal journal
Oct 18 18:27:50 sleepy kernel: EXT3-fs: mounted filesystem with ordered data mode.
Oct 18 18:27:50 sleepy kernel: kjournald starting.  Commit interval 5 seconds
Oct 18 18:27:50 sleepy kernel: EXT3 FS on hdc2, internal journal
Oct 18 18:27:50 sleepy kernel: EXT3-fs: mounted filesystem with ordered data mode.
Oct 18 18:27:50 sleepy kernel: kjournald starting.  Commit interval 5 seconds
Oct 18 18:27:50 sleepy kernel: EXT3 FS on hda2, internal journal
Oct 18 18:27:50 sleepy kernel: EXT3-fs: mounted filesystem with ordered data mode.
Oct 18 18:27:50 sleepy kernel: kjournald starting.  Commit interval 5 seconds
Oct 18 18:27:50 sleepy kernel: EXT3 FS on hda3, internal journal
Oct 18 18:27:50 sleepy kernel: EXT3-fs: mounted filesystem with ordered data mode.
Oct 18 18:27:50 sleepy kernel: IA32 syscall 131 from quotaon not implemented
Oct 18 18:27:50 sleepy kernel: modprobe: 32bit 2.4.x modutils not supported on 64bit kernel
Oct 18 18:27:50 sleepy last message repeated 6 times
Oct 18 18:27:50 sleepy kernel: lsmod: 32bit 2.4.x modutils not supported on 64bit kernel
Oct 18 18:27:50 sleepy kernel: lsmod: 32bit 2.4.x modutils not supported on 64bit kernel
Oct 18 18:27:50 sleepy kernel: ioctl32(iwconfig:383): Unknown cmd fd(3) cmd(00008b01){00} arg(ffffda70) on socket:[2222]
Oct 18 18:27:50 sleepy kernel: modprobe: 32bit 2.4.x modutils not supported on 64bit kernel
Oct 18 18:27:50 sleepy kernel: ioctl32(iwconfig:452): Unknown cmd fd(3) cmd(00008b01){00} arg(ffffda70) on socket:[2305]
Oct 18 18:27:50 sleepy kernel: modprobe: 32bit 2.4.x modutils not supported on 64bit kernel
Oct 18 18:27:50 sleepy kernel: tg3: eth0: Link is up at 100 Mbps, full duplex.
Oct 18 18:27:50 sleepy kernel: tg3: eth0: Flow control is on for TX and on for RX.
Oct 18 18:27:50 sleepy kernel: ioctl32(usb:764): Unknown cmd fd(0) cmd(84005001){04} arg(ffffb680) on /dev/usb/lp0
Oct 18 18:27:50 sleepy kernel: modprobe: 32bit 2.4.x modutils not supported on 64bit kernel
Oct 18 18:27:50 sleepy last message repeated 4 times
Oct 18 18:27:50 sleepy kernel: X: vm86 mode not supported on 64 bit kernel
Oct 18 18:27:50 sleepy kernel: modprobe: 32bit 2.4.x modutils not supported on 64bit kernel
Oct 18 18:27:50 sleepy kernel: modprobe: 32bit 2.4.x modutils not supported on 64bit kernel
Oct 18 18:27:58 sleepy gdm(pam_unix)[922]: session opened for user dwhysong by (uid=0)
Oct 18 15:28:02 sleepy gconfd (dwhysong-1060): starting (version 2.2.0), pid 1060 user 'dwhysong'
Oct 18 15:28:02 sleepy gconfd (dwhysong-1060): Resolved address "xml:readonly:/etc/gconf/gconf.xml.mandatory" to a read-only config source at position 0
Oct 18 15:28:02 sleepy gconfd (dwhysong-1060): Resolved address "xml:readwrite:/home/dwhysong/.gconf" to a writable config source at position 1
Oct 18 15:28:02 sleepy gconfd (dwhysong-1060): Resolved address "xml:readonly:/etc/gconf/gconf.xml.defaults" to a read-only config source at position 2
Oct 18 15:28:08 sleepy su(pam_unix)[1134]: session opened for user root by dwhysong(uid=500)
Oct 18 15:29:41 sleepy su(pam_unix)[1466]: session opened for user root by dwhysong(uid=500)
Oct 18 18:30:08 sleepy kernel: hde: dma_timer_expiry: dma status == 0x24
Oct 18 18:30:08 sleepy kernel: hdg: dma_timer_expiry: dma status == 0x24
Oct 18 18:30:18 sleepy kernel: PDC202XX: Primary channel reset.
Oct 18 18:30:18 sleepy kernel: hde: DMA interrupt recovery
Oct 18 18:30:18 sleepy kernel: hde: lost interrupt
Oct 18 18:30:18 sleepy kernel: PDC202XX: Secondary channel reset.
Oct 18 18:30:18 sleepy kernel: hdg: DMA interrupt recovery
Oct 18 18:30:18 sleepy kernel: hdg: lost interrupt
Oct 18 18:30:38 sleepy kernel: hdg: dma_timer_expiry: dma status == 0x24
Oct 18 18:30:48 sleepy kernel: hde: dma_timer_expiry: dma status == 0x24
Oct 18 18:30:48 sleepy kernel: PDC202XX: Secondary channel reset.
Oct 18 18:30:48 sleepy kernel: hdg: DMA interrupt recovery
Oct 18 18:30:48 sleepy kernel: hdg: lost interrupt
Oct 18 18:30:58 sleepy kernel: PDC202XX: Primary channel reset.
Oct 18 18:30:58 sleepy kernel: hde: DMA interrupt recovery
Oct 18 18:30:58 sleepy kernel: hde: lost interrupt
Oct 18 18:31:08 sleepy kernel: hdg: dma_timer_expiry: dma status == 0x24
Oct 18 15:31:10 sleepy su(pam_unix)[1466]: session closed for user root
Oct 18 18:31:18 sleepy kernel: hde: dma_timer_expiry: dma status == 0x24
Oct 18 18:31:18 sleepy kernel: PDC202XX: Secondary channel reset.
Oct 18 18:31:18 sleepy kernel: hdg: DMA interrupt recovery
Oct 18 18:31:18 sleepy kernel: hdg: lost interrupt
Oct 18 18:31:25 sleepy login(pam_unix)[883]: session opened for user root by LOGIN(uid=0)
Oct 18 18:31:25 sleepy  -- root[883]: ROOT LOGIN ON tty1
Oct 18 18:31:28 sleepy kernel: PDC202XX: Primary channel reset.
Oct 18 18:31:28 sleepy kernel: hde: DMA interrupt recovery
Oct 18 18:31:28 sleepy kernel: hde: lost interrupt
Oct 18 15:31:28 sleepy su(pam_unix)[1134]: session closed for user root
Oct 18 18:31:38 sleepy kernel: hdg: dma_timer_expiry: dma status == 0x24
Oct 18 18:31:48 sleepy kernel: PDC202XX: Secondary channel reset.
Oct 18 18:31:48 sleepy kernel: hdg: DMA interrupt recovery
Oct 18 18:31:48 sleepy kernel: hdg: lost interrupt
Oct 18 18:31:56 sleepy kernel: SysRq : Emergency Sync
Oct 18 18:31:58 sleepy kernel: SysRq : Emergency Remount R/O
Oct 18 18:31:58 sleepy kernel: SysRq : Emergency Sync
Oct 18 18:31:59 sleepy kernel: SysRq : Emergency Remount R/O
Oct 18 18:32:00 sleepy ntpd[711]: kernel time discipline status change 41
Oct 18 18:32:05 sleepy kernel: SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem powerOff showPc unRaw Sync showTasks Unmount
Oct 18 18:32:08 sleepy kernel: hdg: dma_timer_expiry: dma status == 0x24
Oct 18 18:32:17 sleepy kernel: SysRq : HELP : loglevel0-8 reBoot tErm kIll saK showMem powerOff showPc unRaw Sync showTasks Unmount
Oct 18 18:32:18 sleepy kernel: PDC202XX: Secondary channel reset.
Oct 18 18:32:18 sleepy kernel: hdg: DMA interrupt recovery
Oct 18 18:32:18 sleepy kernel: hdg: lost interrupt



I get the same failures with this controller:

Oct 17 17:51:20 sleepy kernel: PDC20269: IDE controller at PCI slot
0000:02:07.0Oct 17 17:51:20 sleepy kernel: PDC20269: chipset revision 2
Oct 17 17:51:20 sleepy kernel: PDC20269: ROM enabled at 0xfd6d0000
Oct 17 17:51:20 sleepy kernel: PDC20269: 100%% native mode on irq 26
Oct 17 17:51:20 sleepy kernel:     ide2: BM-DMA at 0x7880-0x7887, BIOS
settings: hde:pio, hdf:pio
Oct 17 17:51:20 sleepy kernel:     ide3: BM-DMA at 0x7888-0x788f, BIOS
settings: hdg:pio, hdh:pio
Oct 17 17:51:20 sleepy kernel: hde: Maxtor 54098U8, ATA DISK drive
Oct 17 17:51:20 sleepy kernel: ide2 at 0x8c00-0x8c07,0x8082 on irq 26
Oct 17 17:51:20 sleepy kernel: hdg: Maxtor 6Y200P0, ATA DISK drive
Oct 17 17:51:20 sleepy kernel: ide3 at 0x8000-0x8007,0x7c02 on irq 26



Here is the lspci -vv output:

00:06.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI (rev 07) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=64
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: fd700000-fd8fffff
	Prefetchable memory behind bridge: d9100000-d91fffff
	BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [c0] #08 [0086]
	Capabilities: [f0] #08 [8000]

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC (rev 05)
	Subsystem: Advanced Micro Devices [AMD] AMD-8111 LPC
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE (rev 03) (prog-if 8a [Master SecP PriP])
	Subsystem: Advanced Micro Devices [AMD] AMD-8111 IDE
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at ffa0 [size=16]

00:07.2 SMBus: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0 (rev 02)
	Subsystem: Advanced Micro Devices [AMD] AMD-8111 SMBus 2.0
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin D routed to IRQ 19
	Region 0: I/O ports at b480 [size=32]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 05)
	Subsystem: Advanced Micro Devices [AMD] AMD-8111 ACPI
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:07.5 Multimedia audio controller: Advanced Micro Devices [AMD] AMD-8111 AC97 Audio (rev 03)
	Subsystem: Tyan Computer: Unknown device 2885
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin B routed to IRQ 17
	Region 0: I/O ports at b800 [size=256]
	Region 1: I/O ports at bc00 [size=64]

00:0a.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
	I/O behind bridge: 00007000-00008fff
	Memory behind bridge: fd600000-fd6fffff
	Prefetchable memory behind bridge: 00000000d9000000-00000000d9000000
	BridgeCtl: Parity+ SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [a0] PCI-X non-bridge device.
		Command: DPERE+ ERO+ RBC=0 OST=0
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-	Capabilities: [b8] #08 [8000]
	Capabilities: [c0] #08 [004a]

00:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01) (prog-if 10 [IO-APIC])
	Subsystem: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at fd9fe000 (64-bit, non-prefetchable) [size=4K]

00:0b.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12) (prog-if 00 [Normal decode])
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	Memory behind bridge: fd500000-fd5fffff
	Prefetchable memory behind bridge: 00000000d8f00000-00000000d8f00000
	BridgeCtl: Parity+ SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [a0] PCI-X non-bridge device.
		Command: DPERE+ ERO+ RBC=0 OST=4
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-	Capabilities: [b8] #08 [8000]

00:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01) (prog-if 10 [IO-APIC])
	Subsystem: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at fd9ff000 (64-bit, non-prefetchable) [size=4K]

00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [80] #08 [2101]
	Capabilities: [a0] #08 [2101]
	Capabilities: [c0] #08 [2101]

00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

02:07.0 Unknown mass storage controller: Promise Technology, Inc. 20269 (rev 02) (prog-if 85)
	Subsystem: Promise Technology, Inc.: Unknown device 4d68
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (1000ns min, 4500ns max), cache line size 10
	Interrupt: pin A routed to IRQ 26
	Region 0: I/O ports at 8c00 [size=8]
	Region 1: I/O ports at 8080 [size=4]
	Region 2: I/O ports at 8000 [size=8]
	Region 3: I/O ports at 7c00 [size=4]
	Region 4: I/O ports at 7880 [size=16]
	Region 5: Memory at fd6d4000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at fd6d0000 [disabled] [size=16K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:08.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 Ultra3 SCSI Adapter (rev 01)
	Subsystem: LSI Logic / Symbios Logic: Unknown device 1030
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 72 (4250ns min, 4500ns max), cache line size 10
	Interrupt: pin A routed to IRQ 27
	Region 0: I/O ports at 8400 [size=256]
	Region 1: Memory at fd6df800 (64-bit, non-prefetchable) [size=1K]
	Region 3: Memory at fd6da000 (64-bit, non-prefetchable) [size=8K]
	Expansion ROM at fd680000 [disabled] [size=128K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:08.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1010 Ultra3 SCSI Adapter (rev 01)
	Subsystem: LSI Logic / Symbios Logic: Unknown device 1030
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 72 (4250ns min, 4500ns max), cache line size 10
	Interrupt: pin B routed to IRQ 24
	Region 0: I/O ports at 8800 [size=256]
	Region 1: Memory at fd6dfc00 (64-bit, non-prefetchable) [size=1K]
	Region 3: Memory at fd6dc000 (64-bit, non-prefetchable) [size=8K]
	Expansion ROM at fd6a0000 [disabled] [size=128K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:09.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5703 Gigabit Ethernet (rev 02)
	Subsystem: Tyan Computer: Unknown device 2885
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (16000ns min), cache line size 10
	Interrupt: pin A routed to IRQ 24
	Region 0: Memory at fd6f0000 (64-bit, non-prefetchable) [size=64K]
	Expansion ROM at fd6e0000 [disabled] [size=64K]
	Capabilities: [40] PCI-X non-bridge device.
		Command: DPERE- ERO- RBC=0 OST=0
		Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-	Capabilities: [48] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=1 PME-
	Capabilities: [50] Vital Product Data
	Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-
		Address: 002206000e082210  Data: 0458

03:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b) (prog-if 10 [OHCI])
	Subsystem: Advanced Micro Devices [AMD] AMD-8111 USB
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max)
	Interrupt: pin D routed to IRQ 19
	Region 0: Memory at fd8fd000 (32-bit, non-prefetchable) [size=4K]

03:00.1 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b) (prog-if 10 [OHCI])
	Subsystem: Advanced Micro Devices [AMD] AMD-8111 USB
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (20000ns max)
	Interrupt: pin D routed to IRQ 19
	Region 0: Memory at fd8fe000 (32-bit, non-prefetchable) [size=4K]

03:0a.0 SCSI storage controller: LSI Logic / Symbios Logic 53c810 (rev 12)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 16000ns max), cache line size 10
	Interrupt: pin A routed to IRQ 16
	Region 0: I/O ports at 9000 [size=256]
	Region 1: Memory at fd8ff800 (32-bit, non-prefetchable) [size=256]

03:0b.0 RAID bus controller: CMD Technology Inc: Unknown device 3114 (rev 02)
	Subsystem: Tyan Computer: Unknown device 2885
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64, cache line size 10
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at 9c00 [size=8]
	Region 1: I/O ports at 9880 [size=4]
	Region 2: I/O ports at 9800 [size=8]
	Region 3: I/O ports at 9480 [size=4]
	Region 4: I/O ports at 9400 [size=16]
	Region 5: Memory at fd8ffc00 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at fd800000 [disabled] [size=512K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

03:0c.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A IEEE-1394a-2000 Controller (PHY/Link) (prog-if 10 [OHCI])
	Subsystem: Tyan Computer: Unknown device 2885
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max), cache line size 10
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at fd8ff000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at fd8f8000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+

04:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-8151 System Controller (rev 13)
	Subsystem: Advanced Micro Devices [AMD] AMD-8151 System Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=256M]
	Capabilities: [a0] AGP version 3.0
		Status: RQ=31 SBA+ 64bit+ FW+ Rate=x1,x2,x4
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [c0] #08 [0060]

04:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8151 AGP Bridge (rev 13) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=04, secondary=05, subordinate=05, sec-latency=64
	Memory behind bridge: fda00000-feafffff
	Prefetchable memory behind bridge: d9300000-dd3fffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

05:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 03) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc. Millennium G400 32Mb SGRAM
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 8000ns max), cache line size 10
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at da000000 (32-bit, prefetchable) [size=32M]
	Region 1: Memory at feafc000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at fe000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at feae0000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x1


Kernel 2.6.0-test8 .config:

#
# Automatically generated make config: don't edit
#
CONFIG_X86_64=y
CONFIG_64BIT=y
CONFIG_X86=y
CONFIG_MMU=y
CONFIG_RWSEM_GENERIC_SPINLOCK=y
CONFIG_X86_CMPXCHG=y
CONFIG_EARLY_PRINTK=y
CONFIG_HPET_TIMER=y
CONFIG_GENERIC_ISA_DMA=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
# CONFIG_STANDALONE is not set

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=15
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y

#
# Loadable module support
#
# CONFIG_MODULES is not set

#
# Processor type and features
#
CONFIG_MK8=y
# CONFIG_GENERIC_CPU is not set
CONFIG_X86_L1_CACHE_BYTES=64
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_PREEMPT=y
CONFIG_K8_NUMA=y
CONFIG_DISCONTIGMEM=y
CONFIG_NUMA=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_NR_CPUS=2
CONFIG_GART_IOMMU=y
CONFIG_X86_MCE=y

#
# Power management options
#
CONFIG_PM=y
# CONFIG_SOFTWARE_SUSPEND is not set

#
# ACPI (Advanced Configuration and Power Interface) Support
#
CONFIG_ACPI=y
CONFIG_ACPI_BOOT=y
CONFIG_ACPI_INTERPRETER=y
# CONFIG_ACPI_SLEEP is not set
# CONFIG_ACPI_AC is not set
# CONFIG_ACPI_BATTERY is not set
# CONFIG_ACPI_BUTTON is not set
CONFIG_ACPI_FAN=y
CONFIG_ACPI_PROCESSOR=y
CONFIG_ACPI_THERMAL=y
# CONFIG_ACPI_ASUS is not set
# CONFIG_ACPI_TOSHIBA is not set
# CONFIG_ACPI_DEBUG is not set
CONFIG_ACPI_BUS=y
CONFIG_ACPI_EC=y
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PCI=y
CONFIG_ACPI_SYSTEM=y
# CONFIG_ACPI_RELAXED_AML is not set

#
# CPU Frequency scaling
#
# CONFIG_CPU_FREQ is not set

#
# Bus options (PCI etc.)
#
CONFIG_PCI=y
CONFIG_PCI_DIRECT=y
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set

#
# Executable file formats / Emulations
#
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
CONFIG_IA32_EMULATION=y
CONFIG_COMPAT=y
CONFIG_UID16=y

#
# Generic Driver Options
#
# CONFIG_FW_LOADER is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_CRYPTOLOOP=y
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_LBD is not set

#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_IDEDISK_STROKE is not set
# CONFIG_BLK_DEV_IDECD is not set
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
# CONFIG_IDE_TASK_IOCTL is not set
# CONFIG_IDE_TASKFILE_IO is not set

#
# IDE chipset support/bugfixes
#
# CONFIG_BLK_DEV_CMD640 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_BLK_DEV_GENERIC=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEDMA_PCI=y
# CONFIG_BLK_DEV_IDE_TCQ is not set
# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
CONFIG_IDEDMA_PCI_AUTO=y
# CONFIG_IDEDMA_ONLYDISK is not set
# CONFIG_IDEDMA_PCI_WIP is not set
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
CONFIG_BLK_DEV_AMD74XX=y
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_TRIFLEX is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5520 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_BLK_DEV_HPT366 is not set
# CONFIG_BLK_DEV_SC1200 is not set
# CONFIG_BLK_DEV_PIIX is not set
# CONFIG_BLK_DEV_NS87415 is not set
CONFIG_BLK_DEV_PDC202XX_OLD=y
CONFIG_PDC202XX_BURST=y
CONFIG_BLK_DEV_PDC202XX_NEW=y
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_SVWKS is not set
CONFIG_BLK_DEV_SIIMAGE=y
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_VIA82CXXX is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_IVB is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_DMA_NONPCI is not set
# CONFIG_BLK_DEV_HD is not set

#
# SCSI device support
#
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
CONFIG_CHR_DEV_ST=y
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=y
# CONFIG_BLK_DEV_SR_VENDOR is not set
CONFIG_CHR_DEV_SG=y

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_REPORT_LUNS is not set
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
# CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
CONFIG_BLK_DEV_MD=y
CONFIG_MD_LINEAR=y
CONFIG_MD_RAID0=y
CONFIG_MD_RAID1=y
CONFIG_MD_RAID5=y
# CONFIG_MD_MULTIPATH is not set
# CONFIG_BLK_DEV_DM is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
CONFIG_IEEE1394=y

#
# Subsystem Options
#
# CONFIG_IEEE1394_VERBOSEDEBUG is not set
# CONFIG_IEEE1394_OUI_DB is not set

#
# Device Drivers
#

#
# Texas Instruments PCILynx requires I2C bit-banging
#
CONFIG_IEEE1394_OHCI1394=y

#
# Protocol Drivers
#
CONFIG_IEEE1394_VIDEO1394=y
CONFIG_IEEE1394_SBP2=y
# CONFIG_IEEE1394_SBP2_PHYS_DMA is not set
# CONFIG_IEEE1394_ETH1394 is not set
CONFIG_IEEE1394_DV1394=y
CONFIG_IEEE1394_RAWIO=y
CONFIG_IEEE1394_CMP=y
CONFIG_IEEE1394_AMDTP=y

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_NAT=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_TOS=y
CONFIG_IP_ROUTE_VERBOSE=y
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=y
CONFIG_NET_IPGRE=y
CONFIG_NET_IPGRE_BROADCAST=y
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
CONFIG_IPV6=y
# CONFIG_IPV6_PRIVACY is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=y
CONFIG_IP_NF_FTP=y
CONFIG_IP_NF_IRC=y
# CONFIG_IP_NF_TFTP is not set
# CONFIG_IP_NF_AMANDA is not set
CONFIG_IP_NF_QUEUE=y
CONFIG_IP_NF_IPTABLES=y
CONFIG_IP_NF_MATCH_LIMIT=y
CONFIG_IP_NF_MATCH_IPRANGE=y
CONFIG_IP_NF_MATCH_MAC=y
CONFIG_IP_NF_MATCH_PKTTYPE=y
CONFIG_IP_NF_MATCH_MARK=y
CONFIG_IP_NF_MATCH_MULTIPORT=y
CONFIG_IP_NF_MATCH_TOS=y
# CONFIG_IP_NF_MATCH_RECENT is not set
CONFIG_IP_NF_MATCH_ECN=y
CONFIG_IP_NF_MATCH_DSCP=y
CONFIG_IP_NF_MATCH_AH_ESP=y
CONFIG_IP_NF_MATCH_LENGTH=y
CONFIG_IP_NF_MATCH_TTL=y
CONFIG_IP_NF_MATCH_TCPMSS=y
CONFIG_IP_NF_MATCH_HELPER=y
CONFIG_IP_NF_MATCH_STATE=y
CONFIG_IP_NF_MATCH_CONNTRACK=y
CONFIG_IP_NF_MATCH_OWNER=y
CONFIG_IP_NF_FILTER=y
CONFIG_IP_NF_TARGET_REJECT=y
CONFIG_IP_NF_NAT=y
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=y
CONFIG_IP_NF_TARGET_REDIRECT=y
CONFIG_IP_NF_TARGET_NETMAP=y
CONFIG_IP_NF_TARGET_SAME=y
# CONFIG_IP_NF_NAT_LOCAL is not set
CONFIG_IP_NF_NAT_SNMP_BASIC=y
CONFIG_IP_NF_NAT_IRC=y
CONFIG_IP_NF_NAT_FTP=y
CONFIG_IP_NF_MANGLE=y
CONFIG_IP_NF_TARGET_TOS=y
CONFIG_IP_NF_TARGET_ECN=y
CONFIG_IP_NF_TARGET_DSCP=y
CONFIG_IP_NF_TARGET_MARK=y
CONFIG_IP_NF_TARGET_CLASSIFY=y
CONFIG_IP_NF_TARGET_LOG=y
CONFIG_IP_NF_TARGET_ULOG=y
CONFIG_IP_NF_TARGET_TCPMSS=y
CONFIG_IP_NF_ARPTABLES=y
CONFIG_IP_NF_ARPFILTER=y
# CONFIG_IP_NF_ARP_MANGLE is not set

#
# IPv6: Netfilter Configuration
#
# CONFIG_IP6_NF_QUEUE is not set
CONFIG_IP6_NF_IPTABLES=y
CONFIG_IP6_NF_MATCH_LIMIT=y
CONFIG_IP6_NF_MATCH_MAC=y
# CONFIG_IP6_NF_MATCH_RT is not set
# CONFIG_IP6_NF_MATCH_OPTS is not set
# CONFIG_IP6_NF_MATCH_FRAG is not set
# CONFIG_IP6_NF_MATCH_HL is not set
CONFIG_IP6_NF_MATCH_MULTIPORT=y
CONFIG_IP6_NF_MATCH_OWNER=y
CONFIG_IP6_NF_MATCH_MARK=y
# CONFIG_IP6_NF_MATCH_IPV6HEADER is not set
# CONFIG_IP6_NF_MATCH_AHESP is not set
CONFIG_IP6_NF_MATCH_LENGTH=y
CONFIG_IP6_NF_MATCH_EUI64=y
CONFIG_IP6_NF_FILTER=y
CONFIG_IP6_NF_TARGET_LOG=y
CONFIG_IP6_NF_MANGLE=y
CONFIG_IP6_NF_TARGET_MARK=y
CONFIG_XFRM=y
# CONFIG_XFRM_USER is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set

#
# Ethernet (10 or 100Mbit)
#
# CONFIG_NET_ETHERNET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SK98LIN is not set
CONFIG_TIGON3=y

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# Bluetooth support
#
# CONFIG_BT is not set

#
# ISDN subsystem
#
# CONFIG_ISDN_BOOL is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1600
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1200
CONFIG_INPUT_JOYDEV=y
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input I/O drivers
#
CONFIG_GAMEPORT=y
CONFIG_SOUND_GAMEPORT=y
# CONFIG_GAMEPORT_NS558 is not set
# CONFIG_GAMEPORT_L4 is not set
CONFIG_GAMEPORT_EMU10K1=y
# CONFIG_GAMEPORT_VORTEX is not set
# CONFIG_GAMEPORT_FM801 is not set
# CONFIG_GAMEPORT_CS461x is not set
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_PCSPKR=y
# CONFIG_INPUT_UINPUT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
# CONFIG_SERIAL_8250_CONSOLE is not set
# CONFIG_SERIAL_8250_ACPI is not set
CONFIG_SERIAL_8250_NR_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=2048
CONFIG_PRINTER=y
CONFIG_LP_CONSOLE=y
CONFIG_PPDEV=y
# CONFIG_TIPAR is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_CHARDEV=y

#
# I2C Algorithms
#
# CONFIG_I2C_ALGOBIT is not set
# CONFIG_I2C_ALGOPCF is not set

#
# I2C Hardware Bus support
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
CONFIG_I2C_AMD8111=y
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIAPRO is not set

#
# I2C Hardware Sensors Chip support
#
CONFIG_I2C_SENSOR=y
CONFIG_SENSORS_ADM1021=y
# CONFIG_SENSORS_EEPROM is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_VIA686A is not set
# CONFIG_SENSORS_W83781D is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
CONFIG_IPMI_HANDLER=y
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=y
CONFIG_IPMI_KCS=y
CONFIG_IPMI_WATCHDOG=y

#
# Watchdog Cards
#
CONFIG_WATCHDOG=y
# CONFIG_WATCHDOG_NOWAYOUT is not set
# CONFIG_SOFT_WATCHDOG is not set
# CONFIG_WDT is not set
# CONFIG_WDTPCI is not set
# CONFIG_PCWATCHDOG is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_EUROTECH_WDT is not set
# CONFIG_IB700_WDT is not set
# CONFIG_I810_TCO is not set
# CONFIG_MIXCOMWD is not set
# CONFIG_SCx200_WDT is not set
# CONFIG_60XX_WDT is not set
# CONFIG_W83877F_WDT is not set
# CONFIG_MACHZ_WDT is not set
# CONFIG_SC520_WDT is not set
CONFIG_AMD7XX_TCO=y
# CONFIG_ALIM7101_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_SC1200_WDT is not set
# CONFIG_WAFER_WDT is not set
# CONFIG_CPU5_WDT is not set
CONFIG_HW_RANDOM=y
CONFIG_NVRAM=y
CONFIG_RTC=y
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
CONFIG_AGP=y
CONFIG_AGP_AMD64=y
CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
CONFIG_DRM_MGA=y
# CONFIG_DRM_SIS is not set
# CONFIG_MWAVE is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_HANGCHECK_TIMER=y

#
# Misc devices
#

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# File systems
#
# CONFIG_EXT2_FS is not set
CONFIG_EXT3_FS=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_EXT3_FS_POSIX_ACL=y
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_JBD=y
# CONFIG_JBD_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_UDF_FS=y

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
# CONFIG_HUGETLBFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_NFS_FS is not set
# CONFIG_NFSD is not set
# CONFIG_EXPORTFS is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
CONFIG_NLS_UTF8=y

#
# Graphics support
#
# CONFIG_FB is not set
CONFIG_VIDEO_SELECT=y

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
CONFIG_SOUND=y

#
# Advanced Linux Sound Architecture
#
# CONFIG_SND is not set

#
# Open Sound System
#
CONFIG_SOUND_PRIME=y
# CONFIG_SOUND_BT878 is not set
# CONFIG_SOUND_CMPCI is not set
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_SOUND_FUSION is not set
# CONFIG_SOUND_CS4281 is not set
# CONFIG_SOUND_ES1370 is not set
# CONFIG_SOUND_ES1371 is not set
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
CONFIG_SOUND_ICH=y
# CONFIG_SOUND_SONICVIBES is not set
# CONFIG_SOUND_TRIDENT is not set
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
# CONFIG_SOUND_OSS is not set
# CONFIG_SOUND_TVMIXER is not set
# CONFIG_SOUND_ALI5455 is not set
# CONFIG_SOUND_FORTE is not set
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_AD1980 is not set

#
# USB support
#
CONFIG_USB=y
# CONFIG_USB_DEBUG is not set

#
# Miscellaneous USB options
#
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_DYNAMIC_MINORS is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
CONFIG_USB_OHCI_HCD=y
# CONFIG_USB_UHCI_HCD is not set

#
# USB Device Class drivers
#
CONFIG_USB_AUDIO=y
# CONFIG_USB_BLUETOOTH_TTY is not set
CONFIG_USB_MIDI=y
CONFIG_USB_ACM=y
CONFIG_USB_PRINTER=y
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_DPCM is not set
# CONFIG_USB_STORAGE_HP8200e is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set

#
# USB Human Interface Devices (HID)
#
CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y
# CONFIG_HID_FF is not set
# CONFIG_USB_HIDDEV is not set
# CONFIG_USB_AIPTEK is not set
CONFIG_USB_WACOM=y
# CONFIG_USB_KBTAB is not set
# CONFIG_USB_POWERMATE is not set
# CONFIG_USB_XPAD is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
CONFIG_USB_SCANNER=y
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set

#
# USB Multimedia devices
#
# CONFIG_USB_DABUSB is not set

#
# Video4Linux support is needed for USB Multimedia device support
#

#
# USB Network adaptors
#
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_USBNET is not set

#
# USB port drivers
#
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_TIGL is not set
# CONFIG_USB_AUERSWALD is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_BRLVGER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_GADGET is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_SLAB is not set
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_INIT_DEBUG is not set
# CONFIG_DEBUG_INFO is not set
# CONFIG_FRAME_POINTER is not set
# CONFIG_IOMMU_DEBUG is not set
# CONFIG_MCE_DEBUG is not set

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
CONFIG_CRYPTO=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_NULL=y
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_BLOWFISH=y
CONFIG_CRYPTO_TWOFISH=y
CONFIG_CRYPTO_SERPENT=y
CONFIG_CRYPTO_AES=y
CONFIG_CRYPTO_CAST5=y
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_DEFLATE=y
# CONFIG_CRYPTO_TEST is not set

#
# Library routines
#
CONFIG_CRC32=y
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y



