Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261919AbUJZFiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbUJZFiK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 01:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbUJZFe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 01:34:56 -0400
Received: from gyre.foreca.com ([193.94.59.26]:29907 "EHLO gyre.weather.fi")
	by vger.kernel.org with ESMTP id S261919AbUJZFcA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 01:32:00 -0400
Date: Tue, 26 Oct 2004 08:31:55 +0300 (EEST)
From: =?ISO-8859-1?Q?Jaakko_Hyv=E4tti?= <jaakko@hyvatti.iki.fi>
X-X-Sender: jaakko@gyre.weather.fi
To: linux-kernel@vger.kernel.org
Subject: x86_64, LOCKUP on CPU0, kjournald
Message-ID: <Pine.LNX.4.58.0410260818560.3400@gyre.weather.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Last night we got this trace, saved by serial console.

The machine is dual AMD Opteron 240 (1.4GHz), MSI K8D motherboard, 3G
mem, disks in raid configuration with 3ware SATA adapter, so they show
up as scsi devices.  Kernel is updated Fedora Core 2 2.6.8-1.521smp,
but the same probably happened with 2.6.6 at least, cannot tell as I
did not have serial console back then.  Disks are shared over nfs to
a few very very busy clients, some running Linux, some running IRIX.


NMI Watchdog detected LOCKUP on CPU0, registers:
CPU 0
Modules linked in: loop w83627hf i2c_sensor i2c_isa i2c_core nfsd exportfs lockd sunrpc md5 ipv6 parport_pc lp parport tg3 ipt_REJECT ipt_state ip_conntrack iptable_filter ip_tables dm_mod ohci_hcd button battery asus_acpi ac ext3 jbd 3w_xxxx sd_mod scsi_mod
Pid: 210, comm: kjournald Not tainted 2.6.8-1.521smp
RIP: 0010:[<ffffffff80161b7b>] <ffffffff80161b7b>{cache_alloc_refill+397}
RSP: 0018:00000100bf4efa58  EFLAGS: 00000013
RAX: 00000100bff39000 RBX: 0000000000000031 RCX: 00000100400116d8
RDX: 00000100400116c8 RSI: 0000000000000850 RDI: 0000010040011680
RBP: 000001003ffbf000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000010095e05e00 R12: 00000100400116c8
R13: 0000010040011680 R14: 0000000000000850 R15: 0000010031cdb9d0
FS:  0000002a958624c0(0000) GS:ffffffff804e2d80(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000a02b5c CR3: 0000000000101000 CR4: 00000000000006e0
Process kjournald (pid: 210, threadinfo 00000100bf4ee000, task 0000010037d201f0)
Stack: 000001007e657558 000001007e657558 00000100bdc356e0 000001007e657558
       000001003ffb5e00 000001003c2ed180 000001007e657558 ffffffff80161eae
       0000000000000202 ffffffff80180d98
Call Trace:<ffffffff80161eae>{kmem_cache_alloc+52} <ffffffff80180d98>{alloc_buffer_head+17}
       <ffffffffa003b620>{:jbd:journal_write_metadata_buffer+130}
       <ffffffffa0038064>{:jbd:journal_commit_transaction+2847}
       <ffffffff801367e2>{autoremove_wake_function+0} <ffffffff801367e2>{autoremove_wake_function+0}
       <ffffffffa003b0e3>{:jbd:kjournald+333} <ffffffff801367e2>{autoremove_wake_function+0}
       <ffffffff801367e2>{autoremove_wake_function+0} <ffffffffa003af90>{:jbd:commit_timeout+0}
       <ffffffff801121e3>{child_rip+8} <ffffffffa003af96>{:jbd:kjournald+0}
       <ffffffff801121db>{child_rip+0}

Code: 4c 89 61 08 49 89 0c 24 85 db 0f 8f 2c ff ff ff 8b 45 00 49
console shuts up ...


And here the next boot so you see what is there in the machine:

Bootdata ok (command line is ro root=LABEL=/ console=ttyS0,19200 console=tty0)
Linux version 2.6.8-1.521smp (bhcompile@thor.perf.redhat.com) (gcc version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #1 SMP Mon Aug 16 09:32:47 EDT 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000bfff0000 (usable)
 BIOS-e820: 00000000bfff0000 - 00000000bffff000 (ACPI data)
 BIOS-e820: 00000000bffff000 - 00000000c0000000 (ACPI NVS)
 BIOS-e820: 00000000ff7c0000 - 0000000100000000 (reserved)
Scanning NUMA topology in Northbridge 24
Number of nodes 2 (10010)
Node 0 MemBase 0000000000000000 Limit 000000003fffffff
Node 1 MemBase 0000000040000000 Limit 00000000bfff0000
Using node hash shift of 24
Bootmem setup node 0 0000000000000000-000000003fffffff
Bootmem setup node 1 0000000040000000-00000000bfff0000
No mptable found.
ACPI: RSDP (v000 ACPIAM                                    ) @ 0x00000000000f4530
ACPI: RSDT (v001 A M I  OEMRSDT  0x07000304 MSFT 0x00000097) @ 0x00000000bfff0000
ACPI: FADT (v001 A M I  OEMFACP  0x07000304 MSFT 0x00000097) @ 0x00000000bfff0200
ACPI: MADT (v001 A M I  OEMAPIC  0x07000304 MSFT 0x00000097) @ 0x00000000bfff0380
ACPI: SPCR (v001 A M I  OEMSPCR  0x07000304 MSFT 0x00000097) @ 0x00000000bfff0400
ACPI: OEMB (v001 A M I  OEMBIOS  0x07000304 MSFT 0x00000097) @ 0x00000000bffff040
ACPI: ASF! (v001 AMIASF AMDSTRET 0x00000001 INTL 0x02002026) @ 0x00000000bfff2d90
ACPI: DSDT (v001  0ABCF 0ABCF008 0x00000008 INTL 0x02002026) @ 0x0000000000000000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xfebfe000] gsi_base[24])
IOAPIC[1]: Assigned apic_id 3
IOAPIC[1]: apic_id 3, version 17, address 0xfebfe000, GSI 24-27
ACPI: IOAPIC (id[0x04] address[0xfebff000] gsi_base[28])
IOAPIC[2]: Assigned apic_id 4
IOAPIC[2]: apic_id 4, version 17, address 0xfebff000, GSI 28-31
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Using ACPI (MADT) for SMP configuration information
Checking aperture...
CPU 0: aperture @ ffd4000000 size 32 MB
Aperture from northbridge cpu 0 too small (32 MB)
No AGP bridge found
Built 2 zonelists
Kernel command line: ro root=LABEL=/ console=ttyS0,19200 console=tty0
Initializing CPU#0
PID hash table entries: 1024 (order 10: 16384 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 1395.673 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Memory: 3095016k/3145664k available (2161k kernel code, 0k reserved, 1409k data, 176k init)
Calibrating delay loop... 2744.32 BogoMIPS
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
There is already a security framework initialized, register_security failed.
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
Using local APIC NMI watchdog using perfctr0
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU0: AMD Opteron(tm) Processor 240 stepping 01
per-CPU timeslice cutoff: 1023.77 usecs.
task migration cache decay timeout: 2 msecs.
Booting processor 1/1 rip 6000 rsp 10041d67f58
Initializing CPU#1
Calibrating delay loop... 2785.28 BogoMIPS
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
AMD Opteron(tm) Processor 240 stepping 01
Total of 2 processors activated (5529.60 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
Using local APIC timer interrupts.
Detected 12.461 MHz APIC timer.
checking TSC synchronization across 2 CPUs: passed.
time.c: Using PIT/TSC based timekeeping.
Brought up 2 CPUs
checking if image is initramfs...it isn't (no cpio magic); looks like an initrd
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: Power Resource [GFAN] (on)
ACPI: Power Resource [LFAN] (on)
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
ACPI: PCI interrupt 0000:00:07.2[D] -> GSI 19 (level, low) -> IRQ 169
ACPI: PCI interrupt 0000:03:00.0[D] -> GSI 19 (level, low) -> IRQ 169
ACPI: PCI interrupt 0000:03:00.1[D] -> GSI 19 (level, low) -> IRQ 169
ACPI: PCI interrupt 0000:03:06.0[A] -> GSI 18 (level, low) -> IRQ 177
ACPI: PCI interrupt 0000:01:01.0[A] -> GSI 28 (level, low) -> IRQ 185
ACPI: PCI interrupt 0000:01:02.0[A] -> GSI 29 (level, low) -> IRQ 193
ACPI: PCI interrupt 0000:01:02.1[B] -> GSI 30 (level, low) -> IRQ 201
testing the IO APIC.......................



Using vector-based indexing
.................................... done.
PCI-DMA: Disabling IOMMU.
vesafb: probe of vesafb0 failed with error -6
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1098720917.956:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key 9BD64214C19BFDB0
- User ID: Red Hat, Inc. (Kernel Module GPG key)
ksign: invalid packet (ctb=00)
Unable to load default keyring: error=74
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: Fan [FN00] (on)
ACPI: Fan [FN01] (on)
ACPI: Processor [CPU1] (supports C1, 8 throttling states)
ACPI: Processor [CPU2] (supports C1)
ACPI: Thermal Zone [THRM] (45 C)
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ÿttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD8111: IDE controller at PCI slot 0000:00:07.1
AMD8111: chipset revision 3
AMD8111: not 100% native mode: will probe irqs later
AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
ide-floppy driver 0.99.newide
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 16384 buckets, 256Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow-k8: Power state transitions not supported
powernow-k8: Power state transitions not supported
ACPI: (supports S0 S1 S4 S5)
BIOS EDD facility v0.16 2004-Jun-25, 3 devices found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
SCSI subsystem initialized
3ware Storage Controller device driver for Linux v1.26.00.039.
ACPI: PCI interrupt 0000:01:01.0[A] -> GSI 28 (level, low) -> IRQ 185
scsi0 : Found a 3ware Storage Controller at 0x8c00, IRQ: 185, P-chip: 1.3
scsi0 : 3ware Storage Controller
3w-xxxx: scsi0: AEN: WARNING: Unclean shutdown detected: Unit #0.
3w-xxxx: scsi0: AEN: WARNING: Unclean shutdown detected: Unit #2.
3w-xxxx: scsi0: AEN: WARNING: Unclean shutdown detected: Unit #4.
Using cfq io scheduler
  Vendor: 3ware     Model: Logical Disk 0    Rev: 1.2
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sda: 145224064 512-byte hdwr sectors (74355 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
  Vendor: 3ware     Model: Logical Disk 2    Rev: 1.2
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdb: 145224064 512-byte hdwr sectors (74355 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1
Attached scsi disk sdb at scsi0, channel 0, id 2, lun 0
  Vendor: 3ware     Model: Logical Disk 4    Rev: 1.2
  Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sdc: 145224064 512-byte hdwr sectors (74355 MB)
SCSI device sdc: drive cache: write back
 sdc: sdc1
Attached scsi disk sdc at scsi0, channel 0, id 4, lun 0
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: sda3: orphan cleanup on readonly fs
EXT3-fs: sda3: 8 orphan inodes deleted
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 176k freed
SELinux:  Disabled at runtime.
SELinux:  Unregistering netfilter hooks
3w-xxxx: scsi0: AEN: INFO: Initialization started: Unit #0.
3w-xxxx: scsi0: AEN: INFO: Initialization complete: Unit #0.
3w-xxxx: scsi0: AEN: INFO: Initialization started: Unit #2.
3w-xxxx: scsi0: AEN: INFO: Initialization complete: Unit #2.
3w-xxxx: scsi0: AEN: INFO: Initialization started: Unit #4.
3w-xxxx: scsi0: AEN: INFO: Initialization complete: Unit #4.



-- 
Jaakko.Hyvatti@iki.fi         http://www.iki.fi/hyvatti/        +358 40 5011222
echo 'movl $36,%eax;int $128;movl $0,%ebx;movl $1,%eax;int $128'|as -o/bin/sync
