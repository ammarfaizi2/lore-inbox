Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030580AbWAGVGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030580AbWAGVGb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 16:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030578AbWAGVGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 16:06:30 -0500
Received: from smtp.knology.net ([24.214.63.101]:41654 "HELO smtp.knology.net")
	by vger.kernel.org with SMTP id S1030580AbWAGVG2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 16:06:28 -0500
Subject: Adaptec 1420SA issues with MSI
From: Dave Dillow <dave@thedillows.org>
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 07 Jan 2006 16:06:24 -0500
Message-Id: <1136667984.2799.0.camel@obelisk.thedillows.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Doh! Forgot to cc LKML since it may be more of an MSI issue. ]

I'm having some issues with sata_mv and my 1420SA card on an ASUS
CUV4X-D motherboard (2x PIII 1GHz, Via VT82C693A/694x Apollo PRO133x).

If I build 2.6.15 with CONFIG_MSI=y, I get mv_eng_timeout() calls in the
log, and cannot talk to the disks. No interrupts are reported for libata
in /proc/interrupts. I've also tried pci=routeirq on the command line,
to no avail.

If I build with CONFIG_MSI=n, then all seems to be well.

I'd like to help find a fix, since Fedora uses CONFIG_MSI=y on their
kernels, and I eventually want to return this box to a non-custom
kernel. To that end, here's lspci and dmesg output. If you need any more
info, or have something for me to try, then please let me know.

Thanks!

lspci -vvv on CONFIG_MSI=y, pci=routeirq:
00:0a.0 RAID bus controller: Adaptec Serial ATA II RAID 1420SA (rev 01)
        Subsystem: Adaptec Serial ATA II RAID 1420SA
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, Cache Line Size 08
        Interrupt: pin A routed to IRQ 209
        Region 0: Memory at ed000000 (64-bit, non-prefetchable) [size=1M]
        Region 2: I/O ports at a000 [size=256]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable+
                Address: 00000000fee03000  Data: 40d1


lspci info:
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev c4)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x AGP]
00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
00:04.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:04.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 16)
00:04.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 16)
00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
00:09.0 Mass storage controller: Promise Technology, Inc. 20269 (rev 02)
00:0a.0 RAID bus controller: Adaptec Serial ATA II RAID 1420SA (rev 01)
00:0b.0 Ethernet controller: Intel Corporation 82541GI/PI Gigabit Ethernet Controller
00:0d.0 Ethernet controller: 3Com Corporation 3CR990SVR97 [Typhoon Server 168-bit] (rev 02)
01:00.0 VGA compatible controller: nVidia Corporation NV15 [GeForce2 GTS/Pro] (rev a3)


dmesg for CONFIG_MSI=y, pci=routeirq:
Linux version 2.6.15msi (il1@shed.thedillows.org) (gcc version 4.0.2 20051125 (Red Hat 4.0.2-8)) #3 SMP Fri Jan 6 22:20:01 EST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009a400 (usable)
 BIOS-e820: 000000000009a400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fffc000 (usable)
 BIOS-e820: 000000001fffc000 - 000000001ffff000 (ACPI data)
 BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
found SMP MP-table at 000f54d0
On node 0 totalpages: 131068
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 126972 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:0
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                  ) @ 0x000f6870
ACPI: RSDT (v001 ASUS   CUV4X-D  0x30303031 MSFT 0x31313031) @ 0x1fffc000
ACPI: FADT (v001 ASUS   CUV4X-D  0x30303031 MSFT 0x31313031) @ 0x1fffc100
ACPI: BOOT (v001 ASUS   CUV4X-D  0x30303031 MSFT 0x31313031) @ 0x1fffc040
ACPI: MADT (v001 ASUS   CUV4X-D  0x30303031 MSFT 0x31313031) @ 0x1fffc080
ACPI: DSDT (v001   ASUS CUV4X-D  0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: PM-Timer IO Port: 0xe408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x03] enabled)
Processor #3 6:8 APIC version 17
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 6:8 APIC version 17
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 30000000 (gap: 20000000:dec00000)
Built 1 zonelists
Kernel command line: ro root=/dev/VolGroup00/LogVol00 pci=routeirq
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
CPU 0 irqstacks, hard=c039e000 soft=c039c000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1004.624 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 514100k/524272k available (1868k kernel code, 9660k reserved, 569k data, 208k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 2011.30 BogoMIPS (lpj=4022616)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel Pentium III (Coppermine) stepping 0a
Booting processor 1/0 eip 2000
CPU 1 irqstacks, hard=c039f000 soft=c039d000
Initializing CPU#1
Calibrating delay using timer specific routine.. 2009.20 BogoMIPS (lpj=4018400)
CPU: After generic identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After all inits, caps: 0383fbff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel Pentium III (Coppermine) stepping 0a
Total of 2 processors activated (4020.50 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
checking if image is initramfs... it is
Freeing initrd memory: 1678k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf0d20, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI quirk: region e800-e80f claimed by vt82c686 SMB
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
PCI: Using ACPI for IRQ routing
PCI: Routing PCI interrupts for all devices because "pci=routeirq" specified
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:04.2[D] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt 0000:00:04.3[D] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 19 (level, low) -> IRQ 169
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 18 (level, low) -> IRQ 177
ACPI: PCI Interrupt 0000:00:0b.0[A] -> GSI 17 (level, low) -> IRQ 185
ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 19 (level, low) -> IRQ 169
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 193
pnp: 00:02: ioport range 0xe400-0xe47f could not be reserved
pnp: 00:02: ioport range 0xe800-0xe80f has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: ee000000-efcfffff
  PREFETCH window: eff00000-fbffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
Simple Boot Flag at 0x3a set to 0x1
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
PCI: Enabling Via external APIC routing
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 32 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:04.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:04.1
    ide0: BM-DMA at 0xd800-0xd807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xd808-0xd80f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: Maxtor 4D040H2, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: IOMEGA ZIP 250 ATAPI, ATAPI FLOPPY drive
hdc: set_drive_speed_status: status=0x51 { DriveReady SeekComplete Error }
hdc: set_drive_speed_status: error=0x04 { AbortedCommand }
ide1 at 0x170-0x177,0x376 on irq 15
PDC20269: IDE controller at PCI slot 0000:00:09.0
ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 19 (level, low) -> IRQ 169
PDC20269: chipset revision 2
PDC20269: ROM enabled at 0x30020000
PDC20269: 100% native mode on irq 169
    ide2: BM-DMA at 0xa400-0xa407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xa408-0xa40f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
hde: Maxtor 6Y120L0, ATA DISK drive
ide2 at 0xb800-0xb807,0xb402 on irq 169
Probing IDE interface ide3...
hdg: ST380013A, ATA DISK drive
ide3 at 0xb000-0xb007,0xa802 on irq 169
hda: max request size: 128KiB
hda: 80043264 sectors (40982 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes not supported
 hda: hda1 hda2
hde: max request size: 128KiB
hde: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(133)
hde: cache flushes supported
 hde: hde1 hde2
hdg: max request size: 1024KiB
hdg: 156301488 sectors (80026 MB) w/8192KiB Cache, CHS=16383/255/63, UDMA(100)
hdg: cache flushes supported
 hdg: hdg1 hdg2 hdg3
ide-floppy driver 0.99.newide
hdc: No disk in drive
hdc: 244736kB, 239/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
NET: Registered protocol family 2
IP route cache hash table entries: 8192 (order: 3, 32768 bytes)
TCP established hash table entries: 32768 (order: 7, 655360 bytes)
TCP bind hash table entries: 32768 (order: 7, 655360 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP reno registered
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Starting balanced_irq
Using IPI Shortcut mode
Freeing unused kernel memory: 208k freed
input: AT Translated Set 2 keyboard as /class/input/input0
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
md: raid1 personality registered as nr 3
md: Autodetecting RAID arrays.
md: autorun ...
md: considering hdg1 ...
md:  adding hdg1 ...
md: created md0
md: bind<hdg1>
md: running: <hdg1>
raid1: raid set md0 active with 1 out of 2 mirrors
md: ... autorun DONE.
hdc: No disk in drive
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Intel(R) PRO/1000 Network Driver - version 6.1.16-k2-NAPI
Copyright (c) 1999-2005 Intel Corporation.
ACPI: PCI Interrupt 0000:00:0b.0[A] -> GSI 17 (level, low) -> IRQ 185
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
typhoon.c: version 1.5.7 (05/01/07)
ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 19 (level, low) -> IRQ 169
ACPI: PCI interrupt for device 0000:00:0d.0 disabled
eth1: 3Com Typhoon (3CR990SVR97) at MMIO 0xeb000000, 00:01:03:ce:7d:09
eth1: Typhoon 1.0 Sleep Image built 07/07/2000
SCSI subsystem initialized
libata version 1.20 loaded.
sata_mv 0000:00:0a.0: version 0.5
ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 18 (level, low) -> IRQ 177
sata_mv 0000:00:0a.0: Applying B2 workarounds to unknown rev
sata_mv 0000:00:0a.0: 32 slots 4 ports unknown mode IRQ via MSI
ata1: SATA max UDMA/133 cmd 0x0 ctl 0xE0A22120 bmdma 0x0 irq 177
ata2: SATA max UDMA/133 cmd 0x0 ctl 0xE0A24120 bmdma 0x0 irq 177
ata3: SATA max UDMA/133 cmd 0x0 ctl 0xE0A26120 bmdma 0x0 irq 177
ata4: SATA max UDMA/133 cmd 0x0 ctl 0xE0A28120 bmdma 0x0 irq 177
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4673 85:7c69 86:3e21 87:4663 88:007f
ata1: dev 0 ATA-7, max UDMA/133, 398297088 sectors: LBA48
ata1: slow completion (cmd ef)
ata1: dev 0 configured for UDMA/133
scsi0 : sata_mv
ata2: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4673 85:7c69 86:3e21 87:4663 88:007f
ata2: dev 0 ATA-7, max UDMA/133, 398297088 sectors: LBA48
ata2: slow completion (cmd ef)
ata2: dev 0 configured for UDMA/133
scsi1 : sata_mv
ata3: no device found (phy stat 00000000)
scsi2 : sata_mv
ata4: no device found (phy stat 00000000)
scsi3 : sata_mv
  Vendor: ATA       Model: Maxtor 6L200S0    Rev: BACE
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 6L200S0    Rev: BACE
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sda: drive cache: write back
 sda:<6>ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
ata1: Entering mv_eng_timeout
mmio_base e0a00000 ap dfe55314 qc dfe557e8 scsi_cmnd df80ee40 &cmnd df80ee84
ata1: status=0x50 { DriveReady SeekComplete }
ata1: error=0x01 { AddrMarkNotFound }
sda: Current: sense key=0x0
    ASC=0x0 ASCQ=0x0
 unknown partition table
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 398297088 512-byte hdwr sectors (203928 MB)
SCSI device sdb: drive cache: write back
 sdb:<3>ata1: Entering mv_eng_timeout
mmio_base e0a00000 ap dfe55314 qc dfe557e8 scsi_cmnd de4391c0 &cmnd de439204
ata2: Entering mv_eng_timeout
mmio_base e0a00000 ap df12a314 qc df12a7e8 scsi_cmnd de439060 &cmnd de4390a4
ata1: status=0x50 { DriveReady SeekComplete }
ata1: error=0x01 { AddrMarkNotFound }
sda: Current: sense key=0x0
    ASC=0x0 ASCQ=0x0
ata2: status=0x50 { DriveReady SeekComplete }
ata2: error=0x01 { AddrMarkNotFound }
sdb: Current: sense key=0x0
    ASC=0x0 ASCQ=0x0
 unknown partition table
sd 1:0:0:0: Attached scsi disk sdb
ata1: Entering mv_eng_timeout
mmio_base e0a00000 ap dfe55314 qc dfe557e8 scsi_cmnd de4391c0 &cmnd de439204
ata1: status=0x50 { DriveReady SeekComplete }
ata1: error=0x01 { AddrMarkNotFound }
sda: Current: sense key=0x0
    ASC=0x0 ASCQ=0x0
ata1: Entering mv_eng_timeout
mmio_base e0a00000 ap dfe55314 qc dfe557e8 scsi_cmnd de4391c0 &cmnd de439204
ata1: status=0x50 { DriveReady SeekComplete }
ata1: error=0x01 { AddrMarkNotFound }
sda: Current: sense key=0x0
    ASC=0x0 ASCQ=0x0
hdc: No disk in drive
EXT3 FS on dm-0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on md0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hde2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdg3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 1048568k swap on /dev/VolGroup00/LogVol01.  Priority:-1 extents:1 across:1048568k
e1000: eth0: e1000_watchdog_task: NIC Link is Up 1000 Mbps Full Duplex
hdc: No disk in drive
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: starting 90-second grace period




diff -u dmesg.msi-pci-routeirq dmesg.nomsi (trimmed to remove some noise
	bogomips, memory usage, etc. Full dmesg is available):
--- dmesg.msi-pciirq    2006-01-06 23:24:40.000000000 -0500
+++ dmesg.nomsi 2006-01-06 23:13:18.000000000 -0500
@@ -1,1 +1,1 @@
-Linux version 2.6.15msi (il1@shed.thedillows.org) (gcc version 4.0.2 20051125 (Red Hat 4.0.2-8)) #3 SMP Fri Jan 6 22:20:01 EST 2006
+Linux version 2.6.15 (il1@shed.thedillows.org) (gcc version 4.0.2 20051125 (Red Hat 4.0.2-8)) #2 SMP Fri Jan 6 21:39:07 EST 2006
@@ -43,6 +43,6 @@
-Kernel command line: ro root=/dev/VolGroup00/LogVol00 pci=routeirq
+Kernel command line: ro root=/dev/VolGroup00/LogVol00 rhgb quiet
 mapped APIC to ffffd000 (fee00000)
 mapped IOAPIC to ffffc000 (fec00000)
 Initializing CPU#0
-CPU 0 irqstacks, hard=c039e000 soft=c039c000
+CPU 0 irqstacks, hard=c039c000 soft=c039a000
 PID hash table entries: 2048 (order: 11, 32768 bytes)
@@ -108,15 +108,7 @@
 pnp: PnP ACPI init
 pnp: PnP ACPI: found 12 devices
 PCI: Using ACPI for IRQ routing
-PCI: Routing PCI interrupts for all devices because "pci=routeirq" specified
-ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
-ACPI: PCI Interrupt 0000:00:04.2[D] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
-ACPI: PCI Interrupt 0000:00:04.3[D] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
-ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 19 (level, low) -> IRQ 169
-ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 18 (level, low) -> IRQ 177
-ACPI: PCI Interrupt 0000:00:0b.0[A] -> GSI 17 (level, low) -> IRQ 185
-ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 19 (level, low) -> IRQ 169
-ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 193
+PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
 pnp: 00:02: ioport range 0xe400-0xe47f could not be reserved
 pnp: 00:02: ioport range 0xe800-0xe80f has been reserved
 PCI: Bridge: 0000:00:01.0
@@ -163,18 +155,18 @@
 hdc: set_drive_speed_status: error=0x04 { AbortedCommand }
 ide1 at 0x170-0x177,0x376 on irq 15
 PDC20269: IDE controller at PCI slot 0000:00:09.0
-ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 19 (level, low) -> IRQ 169
+ACPI: PCI Interrupt 0000:00:09.0[A] -> GSI 19 (level, low) -> IRQ 16
 PDC20269: chipset revision 2
 PDC20269: ROM enabled at 0x30020000
-PDC20269: 100% native mode on irq 169
+PDC20269: 100% native mode on irq 16
     ide2: BM-DMA at 0xa400-0xa407, BIOS settings: hde:pio, hdf:pio
     ide3: BM-DMA at 0xa408-0xa40f, BIOS settings: hdg:pio, hdh:pio
 Probing IDE interface ide2...
 hde: Maxtor 6Y120L0, ATA DISK drive
-ide2 at 0xb800-0xb807,0xb402 on irq 169
+ide2 at 0xb800-0xb807,0xb402 on irq 16
 Probing IDE interface ide3...
 hdg: ST380013A, ATA DISK drive
-ide3 at 0xb000-0xb007,0xa802 on irq 169
+ide3 at 0xb000-0xb007,0xa802 on irq 16
 hda: max request size: 128KiB
 hda: 80043264 sectors (40982 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
 hda: cache flushes not supported
@@ -225,31 +217,29 @@
 FDC 0 is a post-1991 82077
 Intel(R) PRO/1000 Network Driver - version 6.1.16-k2-NAPI
 Copyright (c) 1999-2005 Intel Corporation.
-ACPI: PCI Interrupt 0000:00:0b.0[A] -> GSI 17 (level, low) -> IRQ 185
+ACPI: PCI Interrupt 0000:00:0b.0[A] -> GSI 17 (level, low) -> IRQ 17
 e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
 typhoon.c: version 1.5.7 (05/01/07)
-ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 19 (level, low) -> IRQ 169
+ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 19 (level, low) -> IRQ 16
 ACPI: PCI interrupt for device 0000:00:0d.0 disabled
 eth1: 3Com Typhoon (3CR990SVR97) at MMIO 0xeb000000, 00:01:03:ce:7d:09
 eth1: Typhoon 1.0 Sleep Image built 07/07/2000
 SCSI subsystem initialized
 libata version 1.20 loaded.
 sata_mv 0000:00:0a.0: version 0.5
-ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 18 (level, low) -> IRQ 177
+ACPI: PCI Interrupt 0000:00:0a.0[A] -> GSI 18 (level, low) -> IRQ 18
 sata_mv 0000:00:0a.0: Applying B2 workarounds to unknown rev
-sata_mv 0000:00:0a.0: 32 slots 4 ports unknown mode IRQ via MSI
-ata1: SATA max UDMA/133 cmd 0x0 ctl 0xE0A22120 bmdma 0x0 irq 177
-ata2: SATA max UDMA/133 cmd 0x0 ctl 0xE0A24120 bmdma 0x0 irq 177
-ata3: SATA max UDMA/133 cmd 0x0 ctl 0xE0A26120 bmdma 0x0 irq 177
-ata4: SATA max UDMA/133 cmd 0x0 ctl 0xE0A28120 bmdma 0x0 irq 177
+sata_mv 0000:00:0a.0: 32 slots 4 ports unknown mode IRQ via INTx
+ata1: SATA max UDMA/133 cmd 0x0 ctl 0xE0A22120 bmdma 0x0 irq 18
+ata2: SATA max UDMA/133 cmd 0x0 ctl 0xE0A24120 bmdma 0x0 irq 18
+ata3: SATA max UDMA/133 cmd 0x0 ctl 0xE0A26120 bmdma 0x0 irq 18
+ata4: SATA max UDMA/133 cmd 0x0 ctl 0xE0A28120 bmdma 0x0 irq 18
 ata1: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4673 85:7c69 86:3e21 87:4663 88:007f
 ata1: dev 0 ATA-7, max UDMA/133, 398297088 sectors: LBA48
-ata1: slow completion (cmd ef)
 ata1: dev 0 configured for UDMA/133
 scsi0 : sata_mv
 ata2: dev 0 cfg 49:2f00 82:7c6b 83:7f09 84:4673 85:7c69 86:3e21 87:4663 88:007f
 ata2: dev 0 ATA-7, max UDMA/133, 398297088 sectors: LBA48
-ata2: slow completion (cmd ef)
 ata2: dev 0 configured for UDMA/133
 scsi1 : sata_mv
 ata3: no device found (phy stat 00000000)
@@ -264,49 +254,19 @@
 SCSI device sda: drive cache: write back
 SCSI device sda: 398297088 512-byte hdwr sectors (203928 MB)
 SCSI device sda: drive cache: write back
- sda:<6>ACPI: Power Button (FF) [PWRF]
-ACPI: Power Button (CM) [PWRB]
-md: Autodetecting RAID arrays.
-md: autorun ...
-md: ... autorun DONE.
-ata1: Entering mv_eng_timeout
-mmio_base e0a00000 ap dfe55314 qc dfe557e8 scsi_cmnd df80ee40 &cmnd df80ee84
-ata1: status=0x50 { DriveReady SeekComplete }
-ata1: error=0x01 { AddrMarkNotFound }
-sda: Current: sense key=0x0
-    ASC=0x0 ASCQ=0x0
- unknown partition table
+ sda: unknown partition table
 sd 0:0:0:0: Attached scsi disk sda
 SCSI device sdb: 398297088 512-byte hdwr sectors (203928 MB)
 SCSI device sdb: drive cache: write back
 SCSI device sdb: 398297088 512-byte hdwr sectors (203928 MB)
 SCSI device sdb: drive cache: write back
- sdb:<3>ata1: Entering mv_eng_timeout
-mmio_base e0a00000 ap dfe55314 qc dfe557e8 scsi_cmnd de4391c0 &cmnd de439204
-ata2: Entering mv_eng_timeout
-mmio_base e0a00000 ap df12a314 qc df12a7e8 scsi_cmnd de439060 &cmnd de4390a4
-ata1: status=0x50 { DriveReady SeekComplete }
-ata1: error=0x01 { AddrMarkNotFound }
-sda: Current: sense key=0x0
-    ASC=0x0 ASCQ=0x0
-ata2: status=0x50 { DriveReady SeekComplete }
-ata2: error=0x01 { AddrMarkNotFound }
-sdb: Current: sense key=0x0
-    ASC=0x0 ASCQ=0x0
- unknown partition table
+ sdb: unknown partition table
 sd 1:0:0:0: Attached scsi disk sdb
-ata1: Entering mv_eng_timeout
-mmio_base e0a00000 ap dfe55314 qc dfe557e8 scsi_cmnd de4391c0 &cmnd de439204
-ata1: status=0x50 { DriveReady SeekComplete }
-ata1: error=0x01 { AddrMarkNotFound }
-sda: Current: sense key=0x0
-    ASC=0x0 ASCQ=0x0
-ata1: Entering mv_eng_timeout
-mmio_base e0a00000 ap dfe55314 qc dfe557e8 scsi_cmnd de4391c0 &cmnd de439204
-ata1: status=0x50 { DriveReady SeekComplete }
-ata1: error=0x01 { AddrMarkNotFound }
-sda: Current: sense key=0x0
-    ASC=0x0 ASCQ=0x0
+ACPI: Power Button (FF) [PWRF]
+ACPI: Power Button (CM) [PWRB]
+md: Autodetecting RAID arrays.
+md: autorun ...
+md: ... autorun DONE.
 hdc: No disk in drive
 EXT3 FS on dm-0, internal journal
 kjournald starting.  Commit interval 5 seconds

