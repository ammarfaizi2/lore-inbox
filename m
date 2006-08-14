Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751823AbWHNHq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbWHNHq5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 03:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751765AbWHNHq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 03:46:57 -0400
Received: from outgoing3.smtp.agnat.pl ([193.239.44.85]:5306 "EHLO
	outgoing3.smtp.agnat.pl") by vger.kernel.org with ESMTP
	id S1751621AbWHNHq4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 03:46:56 -0400
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: linux-scsi@vger.kernel.org
Subject: qlogic 2312 + xfs problems on 2.6.16.22
Date: Mon, 14 Aug 2006 09:46:50 +0200
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200608140946.50411.arekm@pld-linux.org>
X-Authenticated-Id: arekm
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was using QLA2312 FC card on 32-bit machine with 6GB ram
without problems. Recently I've switched to opteron dual core machine
also with 6GB ram and I'm having serious problem with access to FC array.

When I switch back to 32-bit machine the problem disappears. Some qla2312
problems with 64bit machines?

SGI XFS with ACLs, security attributes, large block/inode numbers, no debug enabled
XFS mounting filesystem sda1
Ending clean XFS mount for filesystem: sda1
sh[2988]: segfault at 00000000f80011c8 rip 00000000f7eebb68 rsp 00000000ffffc638 error 6
XFS internal error XFS_WANT_CORRUPTED_GOTO at line 4467 of file fs/xfs/xfs_bmap.c.  Caller 0xffffffff881cbe7f

Call Trace: <ffffffff881adcf3>{:xfs:xfs_bmap_read_extents+833}
       <ffffffff881cbe7f>{:xfs:xfs_iread_extents+182} <ffffffff881ad90a>{:xfs:xfs_bmap_last_offset+133}
       <ffffffff881b9e26>{:xfs:xfs_dir2_put_dirent64_direct+0}
       <ffffffff881b9dbb>{:xfs:xfs_dir2_isblock+20} <ffffffff881b989e>{:xfs:xfs_dir2_getdents+155}
       <ffffffff881e37e0>{:xfs:xfs_readdir+73} <ffffffff881e9728>{:xfs:linvfs_readdir+228}
       <ffffffff8017ab77>{filldir64+0} <ffffffff8017ab77>{filldir64+0}
       <ffffffff8017a8e7>{vfs_readdir+115} <ffffffff8017aca6>{sys_getdents64+116}
       <ffffffff8010a586>{system_call+126}

$ xfs_info /dest
meta-data=/dev/sda1              isize=256    agcount=16, agsize=152617 blks
         =                       sectsz=512   attr=0
data     =                       bsize=4096   blocks=2441872, imaxpct=25
         =                       sunit=0      swidth=0 blks, unwritten=1
naming   =version 2              bsize=4096
log      =internal               bsize=4096   blocks=2560, version=1
         =                       sectsz=512   sunit=0 blks
realtime =none                   extsz=65536  blocks=0, rtextents=0


kernel is UP 2.6.16.22.

Notice weird errors like: Buffer I/O error on device sdb2, logical block 576416. sdb is also on FC.

While trying to mount sdb1 I get:
Starting XFS recovery on filesystem: sdb1 (logdev: internal)
general protection fault: 0000 [1]
CPU 0
Modules linked in: xfs exportfs ipv6 tg3 ohci_hcd ehci_hcd usbcore parport_pc parport ide_cd cdrom ide_disk amd74xx ide_core sd_mod sata_nv libata aic79xx scsi_transport_spi qla2300 qla2xxx scsi_transport_fc scsi_mod
Pid: 3062[#0], comm: mount Not tainted 2.6.16.22-1 #1
RIP: 0010:[<ffffffff881d62db>] <ffffffff881d62db>{:xfs:xlog_recover_do_inode_trans+298}
RSP: 0000:ffff8101bebdd8e8  EFLAGS: 00010206
RAX: 6db65ced212e8fff RBX: ffff8101bf372200 RCX: 0000000000000000
RDX: ffff810000000000 RSI: 0000000000000fff RDI: ffff8101be916aa0
RBP: ffff8101be916aa0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 6db65ced212e8fff
R13: ffff8101bf0e5800 R14: ffff8101bee85300 R15: ffff8101bee85c80
FS:  00002b94a1084320(0000) GS:ffffffff803c5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00002aba7ecd0cd5 CR3: 00000001be46c000 CR4: 00000000000006e0
Process mount (pid: 3062[#0], threadinfo ffff8101bebdc000, task ffff8101bfeec740)
Stack: 0000000000000000 0000000000000000 0000001000000000 0000000000000000
       00000000ffff02d0 0000000000000246 00000000000002d0 0000000000000000
       ffff8101bee85c80 ffff8101bf372200
Call Trace: <ffffffff881d6b99>{:xfs:xlog_recover_do_trans+118}
       <ffffffff881d6cd3>{:xfs:xlog_recover_commit_trans+40}
       <ffffffff881d6e23>{:xfs:xlog_recover_process_data+293}
       <ffffffff881d78f5>{:xfs:xlog_do_recovery_pass+604} <ffffffff801dc63c>{vsnprintf+746}
       <ffffffff881d7d66>{:xfs:xlog_do_log_recovery+83} <ffffffff881d7d9a>{:xfs:xlog_do_recover+12}
       <ffffffff881d7f06>{:xfs:xlog_recover+124} <ffffffff881d1a8c>{:xfs:xfs_log_mount+129}
       <ffffffff881d9101>{:xfs:xfs_mountfs+1709} <ffffffff881e81bd>{:xfs:xfs_buf_iostart+128}
       <ffffffff881e8962>{:xfs:xfs_setsize_buftarg_flags+48}
       <ffffffff881de4d9>{:xfs:xfs_mount+781} <ffffffff881ee023>{:xfs:linvfs_fill_super+0}
       <ffffffff881ee21a>{:xfs:vfs_mount+34} <ffffffff881ee0b4>{:xfs:linvfs_fill_super+145}
       <ffffffff8017041a>{set_bdev_super+0} <ffffffff8016f9cb>{alloc_super+223}
       <ffffffff80181b06>{get_filesystem+18} <ffffffff8016fddc>{sget+318}
       <ffffffff80170554>{get_sb_bdev+248} <ffffffff801707ea>{do_kern_mount+256}
       <ffffffff80183632>{do_new_mount+160} <ffffffff80183c79>{do_mount+489}
       <ffffffff801518c1>{__alloc_pages+91} <ffffffff80151b48>{__get_free_pages+48}
       <ffffffff80183fa1>{sys_mount+134} <ffffffff8010a586>{system_call+126}

Code: 0f b7 00 89 c2 c1 e8 08 c1 e2 08 09 c2 66 81 fa 4e 49 74 5e
RIP <ffffffff881d62db>{:xfs:xlog_recover_do_inode_trans+298} RSP <ffff8101bebdd8e8>


dmesg:

ACPI: LAPIC (acpi_id[0x02] lapic_id[0x02] enabled)
Processor #2 15:1 APIC version 16
WARNING: NR_CPUS limit of 1 reached. Processor ignored.
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x03] enabled)
Processor #3 15:1 APIC version 16
WARNING: NR_CPUS limit of 1 reached. Processor ignored.
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
ACPI: IOAPIC (id[0x04] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 4, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x05] address[0xdf200000] gsi_base[24])
IOAPIC[1]: apic_id 5, version 17, address 0xdf200000, GSI 24-27
ACPI: IOAPIC (id[0x06] address[0xdf201000] gsi_base[28])
IOAPIC[2]: apic_id 6, version 17, address 0xdf201000, GSI 28-31
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ9 used by override.
Setting APIC routing to flat
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at c2000000 (gap: c0000000:20000000)
Checking aperture...
CPU 0: aperture @ d8000000 size 64 MB
CPU 1: aperture @ d8000000 size 64 MB
Built 1 zonelists
Kernel command line: initrd=/rescue.cpi,/custom/custom.cpi root=/dev/ram0 console=tty1 console=ttyS1,9600n81 BOOT_IMAGE=vmlinuz console=ttyS1,115200,n81
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 3.579545 MHz WALL PM GTOD PIT/TSC timer.
time.c: Detected 2009.288 MHz processor.
Console: colour VGA+ 80x25
Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes)
Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes)
Memory: 6128728k/7340032k available (1728k kernel code, 160912k reserved, 847k data, 164k init)
Calibrating delay using timer specific routine.. 4024.54 BogoMIPS (lpj=8049094)
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU: Dual Core AMD Opteron(tm) Processor 270 stepping 02
Using local APIC timer interrupts.
result 12558065
Detected 12.558 MHz APIC timer.
testing NMI watchdog ... OK.
checking if image is initramfs... it is
Overmounted tmpfs
Freeing initrd memory: 44897k freed
DMI present.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
PCI: Using MMCONFIG at e0000000
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Boot video device is 0000:01:07.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P2P0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.XVR0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 16 17 18 19) *0
ACPI: PCI Interrupt Link [LNK2] (IRQs 16 17 18 19) *0
ACPI: PCI Interrupt Link [LNK3] (IRQs 16 17 18 19) *0
ACPI: PCI Interrupt Link [LNK4] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LNK5] (IRQs 16 17 18 19) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [LUS0] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [LUS2] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [LMAC] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [LACI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [LMCI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [LPID] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [LTID] (IRQs 20 21 22 23) *0
ACPI: PCI Interrupt Link [LSI1] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCP] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Root Bridge [PCI2] (0000:08)
PCI: Probing PCI hardware (bus 08)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI2.G0PA._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI2.G0PB._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 15 devices
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
PCI-DMA: Disabling AGP.
PCI-DMA: aperture base @ d8000000 size 65536 KB
PCI-DMA: using GART IOMMU.
PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
pnp: 00:08: ioport range 0x8000-0x807f could not be reserved
pnp: 00:08: ioport range 0x8080-0x80ff has been reserved
pnp: 00:08: ioport range 0x8400-0x847f has been reserved
pnp: 00:08: ioport range 0x8480-0x84ff has been reserved
pnp: 00:08: ioport range 0x8800-0x887f has been reserved
pnp: 00:08: ioport range 0x8880-0x88ff has been reserved
pnp: 00:08: ioport range 0x5000-0x503f has been reserved
pnp: 00:08: ioport range 0x5040-0x507f has been reserved
PCI: Bridge: 0000:00:09.0
  IO window: 2000-2fff
  MEM window: dd100000-deffffff
  PREFETCH window: c2000000-c20fffff
PCI: Bridge: 0000:00:0e.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Setting latency timer of device 0000:00:09.0 to 64
PCI: Setting latency timer of device 0000:00:0e.0 to 64
PCI: Bridge: 0000:08:0a.0
  IO window: 3000-3fff
  MEM window: df300000-df3fffff
  PREFETCH window: c2100000-c21fffff
PCI: Bridge: 0000:08:0b.0
  IO window: disabled.
  MEM window: df400000-df4fffff
  PREFETCH window: disabled.
Simple Boot Flag at 0x36 set to 0x1
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1155547909.097:1): initialized
Total HugeTLB memory allocated, 0
Squashfs 2.2 LZMA (released 2005/07/03) (C) 2002-2005 Phillip Lougher
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: MSI quirk detected. pci_msi_quirk set.
PCI: MSI quirk detected. pci_msi_quirk set.
PCI: Setting latency timer of device 0000:00:0e.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
PCI: MSI quirk detected. MSI disabled.
Allocate Port Service[0000:00:0e.0:pcie00]
Allocate Port Service[0000:00:0e.0:pcie03]
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:02: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:03: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
IP route cache hash table entries: 262144 (order: 9, 2097152 bytes)
TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 7, 524288 bytes)
TCP: Hash tables configured (established 524288 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI wakeup devices: 
PCI0 PS2M PS2K USB0 USB2 MAC0 P2P0 G0PA G0PB 
ACPI: (supports S0 S1 S4 S5)
Freeing unused kernel memory: 164k freed
SCSI subsystem initialized
QLogic Fibre Channel HBA Driver
GSI 16 sharing vector 0xB1 and IRQ 16
ACPI: PCI Interrupt 0000:09:08.0[A] -> GSI 24 (level, low) -> IRQ 177
qla2300 0000:09:08.0: Found an ISP2312, irq 177, iobase 0xffffc2000001e000
qla2300 0000:09:08.0: Configuring PCI space...
qla2300 0000:09:08.0: Configure NVRAM parameters...
qla2300 0000:09:08.0: Verifying loaded RISC code...
qla2300 0000:09:08.0: LIP reset occured (f7f7).
qla2300 0000:09:08.0: Waiting for LIP to complete...
qla2300 0000:09:08.0: LOOP UP detected (2 Gbps).
qla2300 0000:09:08.0: Topology - (F_Port), Host Loop address 0xffff
scsi0 : qla2xxx
qla2300 0000:09:08.0: 
 QLogic Fibre Channel HBA Driver: 8.01.04-k-fw
  QLogic QLA2340 - 
  ISP2312: PCI-X (133 MHz) @ 0000:09:08.0 hdma+, host#=0, fw=3.03.18 IPX
scsi: unknown device type 12
  Vendor: COMPAQ    Model: MSA1000           Rev: 4.96
  Type:   RAID                               ANSI SCSI revision: 04
  Vendor: COMPAQ    Model: MSA1000 VOLUME    Rev: 4.96
  Type:   Direct-Access                      ANSI SCSI revision: 04
  Vendor: COMPAQ    Model: MSA1000 VOLUME    Rev: 4.96
  Type:   Direct-Access                      ANSI SCSI revision: 04
GSI 17 sharing vector 0xB9 and IRQ 17
ACPI: PCI Interrupt 0000:09:0a.0[A] -> GSI 26 (level, low) -> IRQ 185
scsi1 : Adaptec AIC79XX PCI-X SCSI HBA DRIVER, Rev 3.0
        <Adaptec AIC7901 Ultra320 SCSI adapter>
        aic7901: Ultra320 Wide Channel A, SCSI Id=7, PCI-X 101-133Mhz, 512 SCBs

libata version 1.20 loaded.
sata_nv 0000:00:07.0: version 0.8
ACPI: PCI Interrupt Link [LTID] enabled at IRQ 23
GSI 18 sharing vector 0xC1 and IRQ 18
ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [LTID] -> GSI 23 (level, high) -> IRQ 193
PCI: Setting latency timer of device 0000:00:07.0 to 64
ata1: SATA max UDMA/133 cmd 0x1440 ctl 0x1436 bmdma 0x1410 irq 193
ata2: SATA max UDMA/133 cmd 0x1438 ctl 0x1432 bmdma 0x1418 irq 193
ata1: SATA link down (SStatus 0)
scsi2 : sata_nv
ata2: SATA link down (SStatus 0)
scsi3 : sata_nv
ACPI: PCI Interrupt Link [LSI1] enabled at IRQ 22
GSI 19 sharing vector 0xC9 and IRQ 19
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [LSI1] -> GSI 22 (level, high) -> IRQ 201
PCI: Setting latency timer of device 0000:00:08.0 to 64
ata3: SATA max UDMA/133 cmd 0x1458 ctl 0x144E bmdma 0x1420 irq 201
ata4: SATA max UDMA/133 cmd 0x1450 ctl 0x144A bmdma 0x1428 irq 201
ata3: SATA link down (SStatus 0)
scsi4 : sata_nv
ata4: SATA link down (SStatus 0)
scsi5 : sata_nv
SCSI device sda: 513790830 512-byte hdwr sectors (263061 MB)
sda: Write Protect is off
sda: Mode Sense: 83 00 00 08
SCSI device sda: drive cache: write back
SCSI device sda: 513790830 512-byte hdwr sectors (263061 MB)
sda: Write Protect is off
sda: Mode Sense: 83 00 00 08
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
sd 0:0:0:2: Attached scsi disk sda
SCSI device sdb: 1381590 512-byte hdwr sectors (707 MB)
sdb: Write Protect is off
sdb: Mode Sense: 83 00 00 08
SCSI device sdb: drive cache: write back
SCSI device sdb: 1381590 512-byte hdwr sectors (707 MB)
sdb: Write Protect is off
sdb: Mode Sense: 83 00 00 08
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2
sd 0:0:0:4: Attached scsi disk sdb
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE-CK804: IDE controller at PCI slot 0000:00:06.0
NFORCE-CK804: chipset revision 242
NFORCE-CK804: not 100% native mode: will probe irqs later
NFORCE-CK804: 0000:00:06.0 (rev f2) UDMA133 controller
    ide0: BM-DMA at 0x1400-0x1407, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x1408-0x140f, BIOS settings: hdc:pio, hdd:DMA
Probing IDE interface ide0...
Probing IDE interface ide1...
hdd: CD-224E-N, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hdd: ATAPI 24X CD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
parport: PnPBIOS parport detected.
parport0: PC-style at 0x278 (0x678), irq 5, dma 3 [PCSPP,TRISTATE,COMPAT,EPP,ECP,DMA]
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ACPI: PCI Interrupt Link [LUS2] enabled at IRQ 21
GSI 20 sharing vector 0xD1 and IRQ 20
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [LUS2] -> GSI 21 (level, high) -> IRQ 209
PCI: Setting latency timer of device 0000:00:02.1 to 64
ehci_hcd 0000:00:02.1: EHCI Host Controller
ehci_hcd 0000:00:02.1: debug port 1
PCI: cache line size of 64 is not supported by device 0000:00:02.1
ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:02.1: irq 209, io mem 0xdd001000
ehci_hcd 0000:00:02.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 10 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [LUS0] enabled at IRQ 20
GSI 21 sharing vector 0xD9 and IRQ 21
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LUS0] -> GSI 20 (level, high) -> IRQ 217
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.0: irq 217, io mem 0xdd000000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 10 ports detected
Buffer I/O error on device sdb2, logical block 576416
Buffer I/O error on device sdb2, logical block 576417
Buffer I/O error on device sdb2, logical block 576416
Buffer I/O error on device sdb2, logical block 576417
Buffer I/O error on device sdb2, logical block 576460
Buffer I/O error on device sdb2, logical block 576460
Buffer I/O error on device sdb2, logical block 576460
Buffer I/O error on device sdb2, logical block 576460
Buffer I/O error on device sdb2, logical block 576460
Buffer I/O error on device sdb2, logical block 576460
tg3.c:v3.49 (Feb 2, 2006)
GSI 22 sharing vector 0xE1 and IRQ 22
ACPI: PCI Interrupt 0000:0a:09.0[A] -> GSI 28 (level, low) -> IRQ 225
eth0: Tigon3 [partno(BCM95704) rev 2003 PHY(5704)] (PCIX:133MHz:64-bit) 10/100/1000BaseT Ethernet 00:e0:81:33:5e:ae
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[1] Split[0] WireSpeed[1] TSOcap[0] 
eth0: dma_rwctrl[769f4000] dma_mask[64-bit]
GSI 23 sharing vector 0xE9 and IRQ 23
ACPI: PCI Interrupt 0000:0a:09.1[B] -> GSI 29 (level, low) -> IRQ 233
eth1: Tigon3 [partno(BCM95704) rev 2003 PHY(5704)] (PCIX:133MHz:64-bit) 10/100/1000BaseT Ethernet 00:e0:81:33:5e:af
eth1: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
eth1: dma_rwctrl[769f4000] dma_mask[64-bit]
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is off for TX and off for RX.
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
ADDRCONF(NETDEV_UP): eth1: link is not ready
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present
SGI XFS with ACLs, security attributes, large block/inode numbers, no debug enabled
XFS mounting filesystem sda1
Ending clean XFS mount for filesystem: sda1
sh[2988]: segfault at 00000000f80011c8 rip 00000000f7eebb68 rsp 00000000ffffc638 error 6
XFS internal error XFS_WANT_CORRUPTED_GOTO at line 4467 of file fs/xfs/xfs_bmap.c.  Caller 0xffffffff881cbe7f

Call Trace: <ffffffff881adcf3>{:xfs:xfs_bmap_read_extents+833}
       <ffffffff881cbe7f>{:xfs:xfs_iread_extents+182} <ffffffff881ad90a>{:xfs:xfs_bmap_last_offset+133}
       <ffffffff881b9e26>{:xfs:xfs_dir2_put_dirent64_direct+0}
       <ffffffff881b9dbb>{:xfs:xfs_dir2_isblock+20} <ffffffff881b989e>{:xfs:xfs_dir2_getdents+155}
       <ffffffff881e37e0>{:xfs:xfs_readdir+73} <ffffffff881e9728>{:xfs:linvfs_readdir+228}
       <ffffffff8017ab77>{filldir64+0} <ffffffff8017ab77>{filldir64+0}
       <ffffffff8017a8e7>{vfs_readdir+115} <ffffffff8017aca6>{sys_getdents64+116}
       <ffffffff8010a586>{system_call+126}


-- 
Arkadiusz Mi¶kiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
