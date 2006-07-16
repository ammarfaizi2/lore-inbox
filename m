Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946009AbWGPNNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946009AbWGPNNO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 09:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946067AbWGPNNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 09:13:14 -0400
Received: from in.cluded.net ([195.159.98.120]:12448 "EHLO in.cluded.net")
	by vger.kernel.org with ESMTP id S1946009AbWGPNNN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 09:13:13 -0400
Message-ID: <44BA3A7F.4050803@cluded.net>
Date: Sun, 16 Jul 2006 13:09:19 +0000
From: "Daniel K." <daniel@cluded.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9a1) Gecko/20060307 SeaMonkey/1.5a
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Using irqpoll option triggers the NMI Watchdog
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel advised me to boot using the irqpoll option.
(Possibly broken SATA subsystem or equipment, a separate story)

I did, but after a while, ranging from 15 minutes to several hours,
the NMI Watchdog will detect a lockup, and panic ensues.

I first noticed this on the FC5 shipped 2.6.17-1.2145_FC5 kernel,
which ran for several weeks prior to adding the irqpoll option.

Checking the just released 2.6.18-rc2 kernel, the irqpoll option
seems to cause the same problem.

dnetc is the distributed.net client.


Daniel K.

Console output:

Bootdata ok (command line is ro root=/dev/md2 rhgb console=ttyS0,9600 console=tty0 netconsole=@10.0.0.2/,@10.0.0.100/ irqpoll)
Linux version 2.6.18-rc2 (root@o4) (gcc version 4.1.1 20060525 (Red Hat 4.1.1-1)) #1 SMP Sun Jul 16 01:53:39 CEST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000fbff0000 (usable)
 BIOS-e820: 00000000fbff0000 - 00000000fbffe000 (ACPI data)
 BIOS-e820: 00000000fbffe000 - 00000000fc000000 (ACPI NVS)
 BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
DMI 2.3 present.
SRAT: PXM 0 -> APIC 0 -> Node 0
SRAT: PXM 0 -> APIC 1 -> Node 0
SRAT: PXM 1 -> APIC 2 -> Node 1
SRAT: PXM 1 -> APIC 3 -> Node 1
SRAT: Node 0 PXM 0 100000-80000000
SRAT: Node 1 PXM 1 80000000-fc000000
SRAT: Node 1 PXM 1 80000000-100000000
SRAT: Node 0 PXM 0 0-80000000
Bootmem setup node 0 0000000000000000-0000000080000000
Bootmem setup node 1 0000000080000000-00000000fbff0000
ACPI: PM-Timer IO Port: 0x5008
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x02] enabled)
Processor #2 15:1 APIC version 16
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x03] enabled)
Processor #3 15:1 APIC version 16
ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 4, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x05] address[0xfcffe000] gsi_base[24])
IOAPIC[1]: apic_id 5, version 17, address 0xfcffe000, GSI 24-27
ACPI: IOAPIC (id[0x06] address[0xfcfff000] gsi_base[28])
IOAPIC[2]: apic_id 6, version 17, address 0xfcfff000, GSI 28-31
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Setting APIC routing to physical flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at fc400000 (gap: fc000000:3780000)
SMP: Allowing 4 CPUs, 0 hotplug CPUs
Built 2 zonelists.  Total pages: 1014670
Kernel command line: ro root=/dev/md2 rhgb console=ttyS0,9600 console=tty0 netconsole=@10.0.0.2/,@10.0.0.100/ irqpoll
netconsole: local port 6665
netconsole: local IP 10.0.0.2
netconsole: interface eth0
netconsole: remote port 6666
netconsole: remote IP 10.0.0.100
netconsole: remote ethernet address ff:ff:ff:ff:ff:ff
Misrouted IRQ fixup and polling support enabled
This may significantly impact system performance
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Disabling vsyscall due to use of PM timer
time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
time.c: Detected 2004.610 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Checking aperture...
CPU 0: aperture @ 3850000000 size 32 MB
Aperture too small (32 MB)
No AGP bridge found
Memory: 4049980k/4128704k available (2047k kernel code, 78336k reserved, 1276k data, 180k init)
Calibrating delay using timer specific routine.. 4020.74 BogoMIPS (lpj=8041499)
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0/0 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
SMP alternatives: switching to UP code
ACPI: Core revision 20060707
Using local APIC timer interrupts.
result 12528830
Detected 12.528 MHz APIC timer.
SMP alternatives: switching to SMP code
Booting processor 1/4 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4009.39 BogoMIPS (lpj=8018780)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1/1 -> Node 0
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
Dual Core AMD Opteron(tm) Processor 270 stepping 02
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff 1 cycles, maxerr 583 cycles)
SMP alternatives: switching to SMP code
Booting processor 2/4 APIC 0x2
Initializing CPU#2
Calibrating delay using timer specific routine.. 4009.40 BogoMIPS (lpj=8018819)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 2/2 -> Node 1
CPU: Physical Processor ID: 1
CPU: Processor Core ID: 0
Dual Core AMD Opteron(tm) Processor 270 stepping 02
CPU 2: Syncing TSC to CPU 0.
CPU 2: synchronized TSC with CPU 0 (last diff -118 cycles, maxerr 1063 cycles)
SMP alternatives: switching to SMP code
Booting processor 3/4 APIC 0x3
Initializing CPU#3
Calibrating delay using timer specific routine.. 4009.42 BogoMIPS (lpj=8018852)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 3/3 -> Node 1
CPU: Physical Processor ID: 1
CPU: Processor Core ID: 1
Dual Core AMD Opteron(tm) Processor 270 stepping 02
CPU 3: Syncing TSC to CPU 0.
CPU 3: synchronized TSC with CPU 0 (last diff -118 cycles, maxerr 1063 cycles)
Brought up 4 CPUs
testing NMI watchdog ... OK.
migration_cost=443,498
Unpacking initramfs... done
Freeing initrd memory: 1089k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI-DMA: Disabling IOMMU.
pnp: 00:08: ioport range 0xa00-0xa0f has been reserved
pnp: 00:0a: ioport range 0xca2-0xca3 has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: e000-efff
  MEM window: fea00000-febfffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:02.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:06.0
  IO window: d000-dfff
  MEM window: fd000000-fe9fffff
  PREFETCH window: disabled.
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 131072 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
Total HugeTLB memory allocated, 0
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: MSI quirk detected. PCI_BUS_FLAGS_NO_MSI set for subordinate bus.
PCI: MSI quirk detected. PCI_BUS_FLAGS_NO_MSI set for subordinate bus.
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:07: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Intel(R) PRO/1000 Network Driver - version 7.1.9-k2-NAPI
Copyright (c) 1999-2006 Intel Corporation.
GSI 16 sharing vector 0xA9 and IRQ 16
ACPI: PCI Interrupt 0000:03:03.0[A] -> GSI 27 (level, low) -> IRQ 169
e1000: 0000:03:03.0: e1000_probe: (PCI:66MHz:32-bit) 00:d0:68:0c:c3:45
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
GSI 17 sharing vector 0xB1 and IRQ 17
ACPI: PCI Interrupt 0000:03:04.0[A] -> GSI 24 (level, low) -> IRQ 177
e1000: 0000:03:04.0: e1000_probe: (PCI:66MHz:32-bit) 00:d0:68:0c:c3:46
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
netconsole: device eth0 not up yet, forcing it
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
e1000: eth0: e1000_clean_tx_irq: Detected Tx Unit Hang
  Tx Queue             <0>
  TDH                  <b7>
  TDT                  <b7>
  next_to_use          <b7>
  next_to_clean        <41>
buffer_info[next_to_clean]
  time_stamp           <fffee70a>
  next_to_watch        <41>
  jiffies              <fffeeaff>
  next_to_watch.status <1>
netconsole: network logging started
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD8111: IDE controller at PCI slot 0000:00:07.1
AMD8111: chipset revision 3
AMD8111: not 100% native mode: will probe irqs later
AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
usbcore: registered new driver libusual
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S1 S4 S5<6>input: AT Translated Set 2 keyboard as /class/input/input0
)
Freeing unused kernel memory: 180k freed
Write protecting the kernel read-only data: 395k
SCSI subsystem initialized
GSI 18 sharing vector 0xB9 and IRQ 18
ACPI: PCI Interrupt 0000:03:05.0[A] -> GSI 25 (level, low) -> IRQ 185
sata_sil 0000:03:05.0: Applying R_ERR on DMA activate FIS errata fix
ata1: SATA max UDMA/100 cmd 0xFFFFC20000010C80 ctl 0xFFFFC20000010C8A bmdma 0xFFFFC20000010C00 irq 185
ata2: SATA max UDMA/100 cmd 0xFFFFC20000010CC0 ctl 0xFFFFC20000010CCA bmdma 0xFFFFC20000010C08 irq 185
ata3: SATA max UDMA/100 cmd 0xFFFFC20000010E80 ctl 0xFFFFC20000010E8A bmdma 0xFFFFC20000010E00 irq 185
ata4: SATA max UDMA/100 cmd 0xFFFFC20000010EC0 ctl 0xFFFFC20000010ECA bmdma 0xFFFFC20000010E08 irq 185
scsi0 : sata_sil
input: ImPS/2 Generic Wheel Mouse as /class/input/input1
ata1: SATA link down (SStatus 0 SControl 310)
scsi1 : sata_sil
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata2.00: ATA-6, max UDMA/133, 145226112 sectors: LBA48
ata2.00: ata2: dev 0 multi count 16
ata2.00: configured for UDMA/100
scsi2 : sata_sil
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata3.00: ATA-6, max UDMA/133, 145226112 sectors: LBA48
ata3.00: ata3: dev 0 multi count 16
ata3.00: configured for UDMA/100
scsi3 : sata_sil
ata4: SATA link down (SStatus 0 SControl 310)
  Vendor: ATA       Model: WDC WD740GD-00FL  Rev: 33.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 145226112 512-byte hdwr sectors (74356 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
SCSI device sda: 145226112 512-byte hdwr sectors (74356 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 > sda4
sd 1:0:0:0: Attached scsi disk sda
  Vendor: ATA       Model: WDC WD740GD-00FL  Rev: 33.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 145226112 512-byte hdwr sectors (74356 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write back
SCSI device sdb: 145226112 512-byte hdwr sectors (74356 MB)
sdb: Write Protect is off
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 sdb3 < sdb5 sdb6 sdb7 > sdb4
sd 2:0:0:0: Attached scsi disk sdb
md: raid1 personality registered for level 1
md: Autodetecting RAID arrays.
md: autorun ...

[*MD stuff snipped*]

md: ... autorun DONE.
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
NMI Watchdog detected LOCKUP on CPU 0
CPU 0
Modules linked in: ipv6 video button ac sg ohci_hcd i2c_amd756 pcspkr i2c_core raid1 ext3 jbd sata_sil libata sd_mod scsi_mod
Pid: 1830, comm: dnetc Not tainted 2.6.18-rc2 #1
RIP: 0010:[<ffffffff8020cb23>]  [<ffffffff8020cb23>] __delay+0x2/0x10
RSP: 0000:ffffffff80544df8  EFLAGS: 00000002
RAX: 000000009f91ef88 RBX: ffffffff805b4138 RCX: 000000009f91ef6b
RDX: 0000000000000186 RSI: 0000000000000082 RDI: 0000000000000001
RBP: 0000000017ff0ac7 R08: 000000000000000c R09: ffff81000301d2c0
R10: ffff81007f49a880 R11: ffff810037ec0900 R12: 0000000000000001
R13: 00000000000000b1 R14: 0000000000000000 R15: 00000000000000a9
FS:  00000000005f5860(0063) GS:ffffffff805ae000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002b0223143000 CR3: 00000000822f4000 CR4: 00000000000006e0
Process dnetc (pid: 1830, threadinfo ffff8100faaa8000, task ffff8100fbdf5790)
Stack:  ffffffff8020776b 0000000000000000 ffffffff805b4138 ffffffff805b3d00
 ffffffff802a3b94 ffffffff80544ed4 ffffffff80544ea8 0000000000000000
 ffffffff805b3d00 0000000000000000 00000000000000a9 ffffffff805b3d38
Call Trace:
 [<ffffffff8020776b>] _raw_spin_lock+0x82/0xf6
 [<ffffffff802a3b94>] note_interrupt+0x94/0x220
 [<ffffffff802a3281>] __do_IRQ+0xc8/0x107
 [<ffffffff80268dcb>] do_IRQ+0x65/0x73
 [<ffffffff8025d588>] ret_from_intr+0x0/0xa

Code: 89 c1 f3 90 0f 31 29 c8 48 39 f8 72 f5 c3 41 54 83 3d ae af
console shuts up ...
 <0>Kernel panic - not syncing: Aiee, killing interrupt handler!
 NMI Watchdog detected LOCKUP on CPU 2
CPU 2
Modules linked in: ipv6 video button ac sg ohci_hcd i2c_amd756 pcspkr i2c_core raid1 ext3 jbd sata_sil libata sd_mod scsi_mod
Pid: 1831, comm: dnetc Not tainted 2.6.18-rc2 #1
RIP: 0010:[<ffffffff80207766>]  [<ffffffff80207766>] _raw_spin_lock+0x7d/0xf6
RSP: 0000:ffff8100fbf5fef0  EFLAGS: 00000002
RAX: 0000000000000000 RBX: ffffffff805b3d38 RCX: 00000000e9b6ba36
RDX: 0000000000000189 RSI: 0000000000000082 RDI: 0000000000000001
RBP: 0000000035090acd R08: 000000000000003f R09: 00002b8f48dcd1e8
R10: 00000000000000b1 R11: ffff810037ec0900 R12: 0000000000000001
R13: 00000000000000a9 R14: 0000000000000000 R15: 00000000000000b1
FS:  00000000005f5860(0063) GS:ffff8100fbf3a140(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002ad014ead000 CR3: 00000000fb737000 CR4: 00000000000006e0
Process dnetc (pid: 1831, threadinfo ffff8100faaaa000, task ffff81008233a040)
Stack:  0000000000000000 ffffffff805b3d38 ffffffff805b4100 ffffffff802a3b94
 00000000000000f8 ffff8100faaabf58 0000000100000000 ffffffff805b4100
 0000000000000000 00000000000000b1 ffffffff805b4138 ffff81007ef07480
Call Trace:
 [<ffffffff802a3b94>] note_interrupt+0x94/0x220
 [<ffffffff802a3281>] __do_IRQ+0xc8/0x107
 [<ffffffff80268dcb>] do_IRQ+0x65/0x73
 [<ffffffff8025d588>] ret_from_intr+0x0/0xa

Code: e8 b6 53 00 00 48 69 05 fa 92 2c 00 fa 00 00 00 48 39 c5 72
console shuts up ...
