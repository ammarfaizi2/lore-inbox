Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbWAQA3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbWAQA3o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 19:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbWAQA3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 19:29:44 -0500
Received: from mail.gmx.de ([213.165.64.21]:57014 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751313AbWAQA3n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 19:29:43 -0500
X-Authenticated: #428038
Date: Tue, 17 Jan 2006 00:51:03 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.15.1 Oops: rmmod ide-scsi
Message-ID: <20060116235103.GA9664@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings,

playing with 2.6.15.1 a bit, I found that unloading ide-scsi causes two
reproducible Oopsen here, and then the system locks up a short while
later (with SysRq still functional so I can SysRq+B, but this corrupted
an innocent .pyo file unrelated and even unaccessed during this time...)

Procedure to reproduce:

boot with init=/bin/bash added

rmmod ide-cd      # SUSE loads this module from initrd
modprobe ide-scsi
rmmod ide-scsi    # <- oopses right after that with Oops #1
                  #    and a few seconds later with Oops #2

Enclosed: (1) the full dmesg and (2) .config (I fed the latter through
egrep to ditch the comments and blank lines and sorted it for easy "is
option XYZ set" retrieval).

I don't think ide-cd is the culprit here, I can unload and reload it
several times in a row without Oops.

There be more dragons inside that module,
but that's a different tale
not to be told today.

Regards,

-- 
Matthias Andree

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg

Linux version 2.6.15.1-default (emma@merlin) (gcc-Version 4.0.2 20050901 (prerelease) (SUSE Linux)) #2 Sun Jan 15 12:53:45 CET 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009d800 (usable)
 BIOS-e820: 000000000009d800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fffb000 (usable)
 BIOS-e820: 000000003fffb000 - 000000003ffff000 (ACPI data)
 BIOS-e820: 000000003ffff000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 262139
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 32763 pages, LIFO batch:7
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                  ) @ 0x000f5e30
ACPI: RSDT (v001 ASUS   A7V600-X 0x42302e31 MSFT 0x31313031) @ 0x3fffb000
ACPI: FADT (v001 ASUS   A7V600-X 0x42302e31 MSFT 0x31313031) @ 0x3fffb0b2
ACPI: BOOT (v001 ASUS   A7V600-X 0x42302e31 MSFT 0x31313031) @ 0x3fffb030
ACPI: MADT (v001 ASUS   A7V600-X 0x42302e31 MSFT 0x31313031) @ 0x3fffb058
ACPI: DSDT (v001   ASUS A7V600-X 0x00001000 MSFT 0x0100000b) @ 0x00000000
ACPI: PM-Timer IO Port: 0xe408
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:10 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 50000000 (gap: 40000000:bec00000)
Built 1 zonelists
Kernel command line: root=/dev/sda2 vga=791 init=/bin/bash
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
CPU 0 irqstacks, hard=c0365000 soft=c0364000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 1838.499 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1034320k/1048556k available (1624k kernel code, 13468k reserved, 642k data, 156k init, 131052k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3677.39 BogoMIPS (lpj=1838695)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000 00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: After all inits, caps: 0383fbff c1c3fbff 00000000 00000020 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
CPU: AMD Athlon(TM) XP 2500+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=2 apic2=-1 pin2=-1
checking if image is initramfs... it is
Freeing initrd memory: 1612k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf1970, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 10 11 12) *0, disabled.
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 *9 10 11 12)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 9 *10 11 12)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 9 10 11 12) *15, disabled.
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 14 devices
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
pnp: 00:01: ioport range 0xe400-0xe47f could not be reserved
pnp: 00:01: ioport range 0xe800-0xe81f has been reserved
pnp: 00:0d: ioport range 0x290-0x297 has been reserved
pnp: 00:0d: ioport range 0x370-0x375 has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: e5000000-e66fffff
  PREFETCH window: e7f00000-efffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
Simple Boot Flag at 0x3a set to 0x1
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1137454042.888:1): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
PCI: Bypassing VIA 8237 APIC De-Assert Message
vesafb: framebuffer at 0xe8000000, mapped to 0xf8880000, using 3072k, total 131072k
vesafb: mode is 1024x768x16, linelength=2048, pages=1
vesafb: protected mode interface info at c000:dfe0
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
vesafb: Mode is VGA compatible
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f03:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 64000K size 1024 blocksize
loop: loaded (max 8 devices)
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input0
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 262144 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
NET: Registered protocol family 1
Using IPI Shortcut mode
ACPI wakeup devices: 
PCI0 PCI1 USB0 USB1 USB2 USB3 SU20 MC97 SLAN 
ACPI: (supports S0 S1 S3 S4 S5)
Freeing unused kernel memory: 156k freed
input: AT Translated Set 2 keyboard as /class/input/input1
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SCSI subsystem initialized
libata version 1.20 loaded.
sata_via 0000:00:0f.0: version 1.1
ACPI: PCI Interrupt 0000:00:0f.0[B] -> GSI 20 (level, low) -> IRQ 169
PCI: Via IRQ fixup for 0000:00:0f.0, from 0 to 9
sata_via 0000:00:0f.0: routed to hard irq line 9
ata1: SATA max UDMA/133 cmd 0xB800 ctl 0xB402 bmdma 0xA400 irq 169
ata2: SATA max UDMA/133 cmd 0xB000 ctl 0xA802 bmdma 0xA408 irq 169
logips2pp: Detected unknown logitech mouse model 85
input: ImPS/2 Logitech Wheel Mouse as /class/input/input2
ata1: dev 0 cfg 49:2f00 82:746b 83:7f01 84:4023 85:7469 86:3e01 87:4023 88:80ff
ata1: dev 0 ATA-7, max UDMA7, 390721968 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : sata_via
ata2: no device found (phy stat 00000000)
scsi1 : sata_via
  Vendor: ATA       Model: SAMSUNG SP2004C   Rev: VM10
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
sd 0:0:0:0: Attached scsi disk sda
ACPI: PCI Interrupt 0000:00:0d.0[A] -> GSI 16 (level, low) -> IRQ 177
sym0: <895> rev 0x1 at pci 0000:00:0d.0 irq 177
sd 0:0:0:0: Attached scsi generic sg0 type 0
sym0: Tekram NVRAM, ID 7, Fast-40, LVD, parity checking
sym0: SCSI BUS has been reset.
scsi2 : sym-2.2.1
  Vendor: PLEXTOR   Model: CD-ROM PX-32TS    Rev: 1.02
  Type:   CD-ROM                             ANSI SCSI revision: 02
 target2:0:2: Beginning Domain Validation
 target2:0:2: asynchronous.
 target2:0:2: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 15)
 target2:0:2: Domain Validation skipping write tests
 target2:0:2: Ending Domain Validation
 2:0:2:0: Attached scsi generic sg1 type 5
sr0: scsi-1 drive
Uniform CD-ROM driver Revision: 3.20
sr 2:0:2:0: Attached scsi CD-ROM sr0
  Vendor: TANDBERG  Model:  TDC 4222         Rev: =07:
  Type:   Sequential-Access                  ANSI SCSI revision: 02
 target2:0:6: Beginning Domain Validation
 target2:0:6: asynchronous.
 target2:0:6: FAST-5 SCSI 4.8 MB/s ST (208 ns, offset 8)
 target2:0:6: Domain Validation skipping write tests
 target2:0:6: Ending Domain Validation
 2:0:6:0: Attached scsi generic sg2 type 1
st: Version 20050830, fixed bufsize 32768, s/g segs 256
st 2:0:6:0: Attached scsi tape st0<4>st0: try direct i/o: yes (alignment 512 B), max page reachable by HBA 1048575
  Vendor: TANDBERG  Model: SLR6              Rev: 0404
  Type:   Sequential-Access                  ANSI SCSI revision: 02
 target2:0:8: Beginning Domain Validation
 target2:0:8: asynchronous.
 target2:0:8: wide asynchronous.
 target2:0:8: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 15)
 target2:0:8: Domain Validation skipping write tests
 target2:0:8: Ending Domain Validation
st 2:0:8:0: Attached scsi tape st1<4>st1: try direct i/o: yes (alignment 512 B), max page reachable by HBA 1048575
st 2:0:8:0: Attached scsi generic sg3 type 1
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
ACPI: PCI Interrupt 0000:00:0f.1[A] -> GSI 20 (level, low) -> IRQ 169
PCI: Via IRQ fixup for 0000:00:0f.1, from 14 to 9
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
    ide0: BM-DMA at 0x9800-0x9807, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x9808-0x980f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: MAXTOR 4K060H3, ATA DISK drive
hdb: WDC AC420400D, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: max request size: 128KiB
hda: 117266688 sectors (60040 MB) w/2000KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 < hda5 hda6 hda7 >
hdb: max request size: 128KiB
hdb: 39876480 sectors (20416 MB) w/1966KiB Cache, CHS=39560/16/63
hdb: cache flushes not supported
 hdb: hdb1 hdb2 < hdb5 hdb6 hdb7 > hdb3 hdb4
 hdb3: <bsd: hdb8 hdb9 hdb10 hdb11 >
Probing IDE interface ide1...
hdc: _NEC DVD_RW ND-4550A, ATAPI CD/DVD-ROM drive
hdd: PLEXTOR CD-R PX-W4824A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: ATAPI 48X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
hdd: ATAPI 40X CD-ROM CD-R/RW drive, 4096kB Cache, UDMA(33)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as device
scsi3 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: _NEC      Model: DVD_RW ND-4550A   Rev: 1.07
  Type:   CD-ROM                             ANSI SCSI revision: 00
sr1: scsi-1 drive
sr 3:0:0:0: Attached scsi CD-ROM sr1
sr 3:0:0:0: Attached scsi generic sg4 type 5
scsi4 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: PLEXTOR   Model: CD-R   PX-W4824A  Rev: 1.06
  Type:   CD-ROM                             ANSI SCSI revision: 00
sr2: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
sr 4:0:0:0: Attached scsi CD-ROM sr2
sr 4:0:0:0: Attached scsi generic sg5 type 5
Unable to handle kernel NULL pointer dereference at virtual address 0000029c
 printing eip:
f8bd7081
*pde = 00000000
Oops: 0000 [#1]
Modules linked in: ide_scsi ext3 jbd fan thermal processor via82cxxx st sr_mod cdrom sg sym53c8xx scsi_transport_spi sata_via libata sd_mod scsi_mod ide_disk ide_core
CPU:    0
EIP:    0060:[<f8bd7081>]    Not tainted VLI
EFLAGS: 00010016   (2.6.15.1-default) 
EIP is at idescsi_queue+0x151/0x393 [ide_scsi]
eax: 00000000   ebx: f8b817b8   ecx: 00000000   edx: f884c858
esi: c1b814ce   edi: c1b7ba6a   ebp: c1b7ba60   esp: c7188cf8
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 2496, threadinfo=c7188000 task=c1bdc0b0)
Stack: c1b81480 f884c858 c1bd2760 00000000 00000284 00000293 c1b81480 edafbc00 
       f7ce41dc f8b81625 edafb000 edafbc00 c1bf621c f8b863ae c1b81480 c1bf621c 
       c1bf621c f7ce4256 c7188dbc c01b76dd f7ce41dc c01b76e5 c01b8094 00000001 
Call Trace:
 [<f8b81625>] scsi_dispatch_cmd+0x1ab/0x21b [scsi_mod]
 [<f8b863ae>] scsi_request_fn+0x232/0x291 [scsi_mod]
 [<c01b76dd>] __generic_unplug_device+0x1d/0x1f
 [<c01b76e5>] generic_unplug_device+0x6/0x8
 [<c01b8094>] blk_execute_rq+0x65/0x88
 [<c01b81e4>] blk_end_sync_rq+0x0/0x1d
 [<c01b8edd>] blk_rq_bio_prep+0x61/0x7c
 [<f8b85449>] scsi_execute+0xba/0xcc [scsi_mod]
 [<f8866ffc>] sr_do_ioctl+0x7f/0x1c7 [sr_mod]
 [<c01217a3>] call_usermodehelper_keys+0x9e/0xab
 [<f8866dab>] sr_packet+0x1a/0x1f [sr_mod]
 [<f88787b8>] cdrom_get_disc_info+0x3e/0x7d [cdrom]
 [<f887552c>] cdrom_mrw_exit+0xd/0x54 [cdrom]
 [<f887526e>] unregister_cdrom+0x5a/0x7f [cdrom]
 [<f8866dca>] sr_kref_release+0x1a/0x31 [sr_mod]
 [<f8866db0>] sr_kref_release+0x0/0x31 [sr_mod]
 [<c01c1981>] kref_put+0x43/0x4e
 [<f8866e0a>] sr_remove+0x29/0x35 [sr_mod]
 [<c0214ab3>] __device_release_driver+0x43/0x5b
 [<c0214ae6>] device_release_driver+0x1b/0x29
 [<c021455c>] bus_remove_device+0x4b/0x59
 [<c0213a8b>] device_del+0x35/0x62
 [<f8b88aad>] __scsi_remove_device+0x31/0x60 [scsi_mod]
 [<f8b88044>] scsi_forget_host+0x20/0x38 [scsi_mod]
 [<f8b81f7f>] scsi_remove_host+0x59/0xbe [scsi_mod]
 [<f8bd6e60>] ide_scsi_remove+0x43/0x51 [ide_scsi]
 [<c0214ab3>] __device_release_driver+0x43/0x5b
 [<c0214b2e>] driver_detach+0x3a/0x4f
 [<c02146bd>] bus_remove_driver+0x38/0x52
 [<c0214d3d>] driver_unregister+0xb/0x13
 [<c012803e>] sys_delete_module+0x127/0x15c
 [<c0147b5c>] do_sys_open+0x94/0x9c
 [<c01029eb>] sysenter_past_esp+0x54/0x75
Code: c7 45 28 00 00 00 00 8b 14 24 8b 42 54 89 55 2c 89 5d 30 89 45 14 89 45 0c a1 38 56 2e c0 03 42 34 89 45 38 8b 54 24 04 8b 42 1c <8b> 80 9c 02 00 00 a8 01 74 05 0f ba 6d 34 02 8b 45 1c 89 44 24 
 <1>Unable to handle kernel NULL pointer dereference at virtual address 0000029c
 printing eip:
f8bd7081
*pde = 00000000
Oops: 0000 [#2]
Modules linked in: ide_scsi ext3 jbd fan thermal processor via82cxxx st sr_mod cdrom sg sym53c8xx scsi_transport_spi sata_via libata sd_mod scsi_mod ide_disk ide_core
CPU:    0
EIP:    0060:[<f8bd7081>]    Not tainted VLI
EFLAGS: 00010016   (2.6.15.1-default) 
EIP is at idescsi_queue+0x151/0x393 [ide_scsi]
eax: 00000000   ebx: f8b83d36   ecx: 00000000   edx: f884c858
esi: c1b814ca   edi: c1bb0426   ebp: c1bb0420   esp: edafaf28
ds: 007b   es: 007b   ss: 0068
Process scsi_eh_4 (pid: 2490, threadinfo=edafa000 task=dff59030)
Stack: c1b81480 f884c858 c1bd2860 0000007b 00000284 00000246 c1b81480 edafbc00 
       00002710 f8b83dda 00000000 edafaf54 edafaf54 00000000 c1b81480 c1b81588 
       00000001 f8b84176 c1b81480 edafaf98 edafafac edafafa4 f8b8423c edafafa4 
Call Trace:
 [<f8b83dda>] scsi_send_eh_cmnd+0x67/0x10c [scsi_mod]
 [<f8b84176>] scsi_eh_tur+0x78/0xd0 [scsi_mod]
 [<f8b8423c>] scsi_eh_abort_cmds+0x6e/0xc7 [scsi_mod]
 [<f8b84dca>] scsi_error_handler+0x0/0xff [scsi_mod]
 [<f8b84da9>] scsi_unjam_host+0x156/0x177 [scsi_mod]
 [<f8b84dca>] scsi_error_handler+0x0/0xff [scsi_mod]
 [<f8b84e6e>] scsi_error_handler+0xa4/0xff [scsi_mod]
 [<c0124613>] kthread+0x63/0x8f
 [<c01245b0>] kthread+0x0/0x8f
 [<c010129d>] kernel_thread_helper+0x5/0xb
Code: c7 45 28 00 00 00 00 8b 14 24 8b 42 54 89 55 2c 89 5d 30 89 45 14 89 45 0c a1 38 56 2e c0 03 42 34 89 45 38 8b 54 24 04 8b 42 1c <8b> 80 9c 02 00 00 a8 01 74 05 0f ba 6d 34 02 8b 45 1c 89 44 24 

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config-stripped

CONFIG_4KSTACKS=y
CONFIG_ACPI=y
CONFIG_ACPI_AC=m
CONFIG_ACPI_ASUS=m
CONFIG_ACPI_BATTERY=m
CONFIG_ACPI_BLACKLIST_YEAR=2001
CONFIG_ACPI_BUTTON=m
CONFIG_ACPI_CONTAINER=m
CONFIG_ACPI_EC=y
CONFIG_ACPI_FAN=m
CONFIG_ACPI_IBM=m
CONFIG_ACPI_POWER=y
CONFIG_ACPI_PROCESSOR=m
CONFIG_ACPI_SLEEP=y
CONFIG_ACPI_SLEEP_PROC_FS=y
CONFIG_ACPI_SLEEP_PROC_SLEEP=y
CONFIG_ACPI_SYSTEM=y
CONFIG_ACPI_THERMAL=m
CONFIG_ACPI_TOSHIBA=m
CONFIG_ACPI_VIDEO=m
CONFIG_AGP=m
CONFIG_AGP_INTEL=m
CONFIG_AGP_VIA=m
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_ASK_IP_FIB_HASH=y
CONFIG_AUDIT=y
CONFIG_AUDITSYSCALL=y
CONFIG_AUTOFS4_FS=m
CONFIG_BASE_FULL=y
CONFIG_BASE_SMALL=0
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_BLK_DEV_CRYPTOLOOP=m
CONFIG_BLK_DEV_DM=m
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_IDE=m
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDEDISK=m
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_BLK_DEV_INITRD=y
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_MD=y
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=64000
CONFIG_BLK_DEV_SD=m
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_VIA82CXXX=m
CONFIG_BONDING=m
CONFIG_BRIDGE=m
CONFIG_BRIDGE_EBT_802_3=m
CONFIG_BRIDGE_EBT_AMONG=m
CONFIG_BRIDGE_EBT_ARP=m
CONFIG_BRIDGE_EBT_ARPREPLY=m
CONFIG_BRIDGE_EBT_BROUTE=m
CONFIG_BRIDGE_EBT_DNAT=m
CONFIG_BRIDGE_EBT_IP=m
CONFIG_BRIDGE_EBT_LIMIT=m
CONFIG_BRIDGE_EBT_LOG=m
CONFIG_BRIDGE_EBT_MARK=m
CONFIG_BRIDGE_EBT_MARK_T=m
CONFIG_BRIDGE_EBT_PKTTYPE=m
CONFIG_BRIDGE_EBT_REDIRECT=m
CONFIG_BRIDGE_EBT_SNAT=m
CONFIG_BRIDGE_EBT_STP=m
CONFIG_BRIDGE_EBT_T_FILTER=m
CONFIG_BRIDGE_EBT_T_NAT=m
CONFIG_BRIDGE_EBT_ULOG=m
CONFIG_BRIDGE_EBT_VLAN=m
CONFIG_BRIDGE_NETFILTER=y
CONFIG_BRIDGE_NF_EBTABLES=m
CONFIG_BROKEN_ON_SMP=y
CONFIG_BSD_DISKLABEL=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_BSD_PROCESS_ACCT_V3=y
CONFIG_BT=m
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIUART=m
CONFIG_BT_HCIUART_BCSP=y
CONFIG_BT_HCIUART_H4=y
CONFIG_BT_HCIUSB=m
CONFIG_BT_HCIUSB_SCO=y
CONFIG_BT_HCIVHCI=m
CONFIG_BT_HIDP=m
CONFIG_BT_L2CAP=m
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_SCO=m
CONFIG_BUG=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_JUMPS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
CONFIG_CDROM_PKTCDVD_WCACHE=y
CONFIG_CHR_DEV_SG=m
CONFIG_CHR_DEV_ST=m
CONFIG_CIFS=m
CONFIG_CIFS_POSIX=y
CONFIG_CIFS_STATS=y
CONFIG_CIFS_XATTR=y
CONFIG_CLEAN_COMPILE=y
CONFIG_CLS_U32_MARK=y
CONFIG_CLS_U32_PERF=y
CONFIG_CODA_FS=m
CONFIG_CRC32=y
CONFIG_CRC_CCITT=m
CONFIG_CRYPTO=y
CONFIG_CRYPTO_AES_586=m
CONFIG_CRYPTO_ARC4=m
CONFIG_CRYPTO_BLOWFISH=m
CONFIG_CRYPTO_CRC32C=m
CONFIG_CRYPTO_DEFLATE=m
CONFIG_CRYPTO_DES=y
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_MD4=m
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_SHA1=m
CONFIG_CRYPTO_SHA256=m
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEFAULT_DEADLINE=y
CONFIG_DEFAULT_IOSCHED="deadline"
CONFIG_DETECT_SOFTLOCKUP=y
CONFIG_DM_CRYPT=m
CONFIG_DM_MIRROR=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_ZERO=m
CONFIG_DNOTIFY=y
CONFIG_DUMMY=m
CONFIG_DUMMY_CONSOLE=y
CONFIG_E100=m
CONFIG_EARLY_PRINTK=y
CONFIG_EDD=m
CONFIG_EPOLL=y
CONFIG_EXPERIMENTAL=y
CONFIG_EXPORTFS=m
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_XIP=y
CONFIG_EXT3_FS=m
CONFIG_EXT3_FS_POSIX_ACL=y
CONFIG_EXT3_FS_SECURITY=y
CONFIG_EXT3_FS_XATTR=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="utf-8"
CONFIG_FAT_FS=m
CONFIG_FB=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_NVIDIA=m
CONFIG_FB_NVIDIA_I2C=y
CONFIG_FB_VESA=y
CONFIG_FB_VGA16=m
CONFIG_FLATMEM=y
CONFIG_FLATMEM_MANUAL=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_FONT_8x16=y
CONFIG_FONT_8x8=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FS_MBCACHE=y
CONFIG_FS_POSIX_ACL=y
CONFIG_FS_XIP=y
CONFIG_FUSE_FS=m
CONFIG_FUTEX=y
CONFIG_FW_LOADER=m
CONFIG_GACT_PROB=y
CONFIG_GAMEPORT=m
CONFIG_GAMEPORT_EMU10K1=m
CONFIG_GAMEPORT_FM801=m
CONFIG_GAMEPORT_L4=m
CONFIG_GAMEPORT_NS558=m
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_GENERIC_IOMAP=y
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_ISA_DMA=y
CONFIG_HANGCHECK_TIMER=m
CONFIG_HID_FF=y
CONFIG_HID_PID=y
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_HOTPLUG=y
CONFIG_HPET=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_HPET_MMAP=y
CONFIG_HPET_TIMER=y
CONFIG_HUGETLBFS=y
CONFIG_HUGETLB_PAGE=y
CONFIG_HWMON=m
CONFIG_HWMON_VID=m
CONFIG_HW_CONSOLE=y
CONFIG_HZ=1000
CONFIG_HZ_1000=y
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCA=m
CONFIG_I2C_ALGOPCF=m
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_ISA=m
CONFIG_I2C_VIAPRO=m
CONFIG_IDE=m
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_IDEDMA_AUTO=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_INET6_AH=m
CONFIG_INET6_ESP=m
CONFIG_INET6_IPCOMP=m
CONFIG_INET6_TUNNEL=m
CONFIG_INET=y
CONFIG_INET_AH=m
CONFIG_INET_DIAG=y
CONFIG_INET_ESP=m
CONFIG_INET_IPCOMP=m
CONFIG_INET_TCP_DIAG=y
CONFIG_INET_TUNNEL=m
CONFIG_INITRAMFS_SOURCE=""
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_INOTIFY=y
CONFIG_INPUT=y
CONFIG_INPUT_EVDEV=y
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_JOYSTICK=y
CONFIG_INPUT_KEYBOARD=y
CONFIG_INPUT_MISC=y
CONFIG_INPUT_MOUSE=y
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_PCSPKR=y
CONFIG_INPUT_TSDEV=m
CONFIG_INPUT_TSDEV_SCREEN_X=240
CONFIG_INPUT_TSDEV_SCREEN_Y=320
CONFIG_INPUT_UINPUT=m
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_CFQ=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IP6_NF_FILTER=m
CONFIG_IP6_NF_IPTABLES=m
CONFIG_IP6_NF_MANGLE=m
CONFIG_IP6_NF_MATCH_AHESP=m
CONFIG_IP6_NF_MATCH_EUI64=m
CONFIG_IP6_NF_MATCH_FRAG=m
CONFIG_IP6_NF_MATCH_HL=m
CONFIG_IP6_NF_MATCH_IPV6HEADER=m
CONFIG_IP6_NF_MATCH_LENGTH=m
CONFIG_IP6_NF_MATCH_LIMIT=m
CONFIG_IP6_NF_MATCH_MAC=m
CONFIG_IP6_NF_MATCH_MARK=m
CONFIG_IP6_NF_MATCH_MULTIPORT=m
CONFIG_IP6_NF_MATCH_OPTS=m
CONFIG_IP6_NF_MATCH_OWNER=m
CONFIG_IP6_NF_MATCH_PHYSDEV=m
CONFIG_IP6_NF_MATCH_RT=m
CONFIG_IP6_NF_QUEUE=m
CONFIG_IP6_NF_RAW=m
CONFIG_IP6_NF_TARGET_LOG=m
CONFIG_IP6_NF_TARGET_MARK=m
CONFIG_IP6_NF_TARGET_REJECT=m
CONFIG_IPV6=m
CONFIG_IPV6_PRIVACY=y
CONFIG_IPV6_TUNNEL=m
CONFIG_IP_ADVANCED_ROUTER=y
CONFIG_IP_FIB_HASH=y
CONFIG_IP_MROUTE=y
CONFIG_IP_MULTICAST=y
CONFIG_IP_MULTIPLE_TABLES=y
CONFIG_IP_NF_AMANDA=m
CONFIG_IP_NF_ARPFILTER=m
CONFIG_IP_NF_ARPTABLES=m
CONFIG_IP_NF_ARP_MANGLE=m
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_CONNTRACK_MARK=y
CONFIG_IP_NF_CT_ACCT=y
CONFIG_IP_NF_CT_PROTO_SCTP=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_MATCH_ADDRTYPE=m
CONFIG_IP_NF_MATCH_AH_ESP=m
CONFIG_IP_NF_MATCH_COMMENT=m
CONFIG_IP_NF_MATCH_CONNMARK=m
CONFIG_IP_NF_MATCH_CONNTRACK=m
CONFIG_IP_NF_MATCH_DSCP=m
CONFIG_IP_NF_MATCH_ECN=m
CONFIG_IP_NF_MATCH_HASHLIMIT=m
CONFIG_IP_NF_MATCH_HELPER=m
CONFIG_IP_NF_MATCH_IPRANGE=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_MATCH_PHYSDEV=m
CONFIG_IP_NF_MATCH_PKTTYPE=m
CONFIG_IP_NF_MATCH_REALM=m
CONFIG_IP_NF_MATCH_RECENT=m
CONFIG_IP_NF_MATCH_SCTP=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_AMANDA=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_TFTP=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_RAW=m
CONFIG_IP_NF_TARGET_CLASSIFY=m
CONFIG_IP_NF_TARGET_CLUSTERIP=m
CONFIG_IP_NF_TARGET_CONNMARK=m
CONFIG_IP_NF_TARGET_DSCP=m
CONFIG_IP_NF_TARGET_ECN=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_NETMAP=m
CONFIG_IP_NF_TARGET_NOTRACK=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_SAME=m
CONFIG_IP_NF_TARGET_TCPMSS=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_TTL=m
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TFTP=m
CONFIG_IP_PIMSM_V1=y
CONFIG_IP_PIMSM_V2=y
CONFIG_IP_ROUTE_FWMARK=y
CONFIG_IP_ROUTE_MULTIPATH=y
CONFIG_IP_ROUTE_MULTIPATH_CACHED=y
CONFIG_IP_ROUTE_MULTIPATH_DRR=m
CONFIG_IP_ROUTE_MULTIPATH_RANDOM=m
CONFIG_IP_ROUTE_MULTIPATH_RR=m
CONFIG_IP_ROUTE_MULTIPATH_WRANDOM=m
CONFIG_IP_ROUTE_VERBOSE=y
CONFIG_IP_SCTP=m
CONFIG_IP_VS=m
CONFIG_IP_VS_DH=m
CONFIG_IP_VS_FTP=m
CONFIG_IP_VS_LBLC=m
CONFIG_IP_VS_LBLCR=m
CONFIG_IP_VS_LC=m
CONFIG_IP_VS_NQ=m
CONFIG_IP_VS_PROTO_AH=y
CONFIG_IP_VS_PROTO_ESP=y
CONFIG_IP_VS_PROTO_TCP=y
CONFIG_IP_VS_PROTO_UDP=y
CONFIG_IP_VS_RR=m
CONFIG_IP_VS_SED=m
CONFIG_IP_VS_SH=m
CONFIG_IP_VS_TAB_BITS=12
CONFIG_IP_VS_WLC=m
CONFIG_IP_VS_WRR=m
CONFIG_ISA=y
CONFIG_ISAPNP=y
CONFIG_ISA_DMA_API=y
CONFIG_ISCSI_TCP=m
CONFIG_ISO9660_FS=y
CONFIG_JBD=m
CONFIG_JBD_DEBUG=y
CONFIG_JOLIET=y
CONFIG_JOYSTICK_ANALOG=m
CONFIG_KALLSYMS=y
CONFIG_KEYBOARD_ATKBD=y
CONFIG_KMOD=y
CONFIG_KOBJECT_UEVENT=y
CONFIG_LBD=y
CONFIG_LDM_PARTITION=y
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
CONFIG_LIBCRC32C=m
CONFIG_LOCALVERSION="-default"
CONFIG_LOCALVERSION_AUTO=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_LOGITECH_FF=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_MAGIC_SYSRQ=y
CONFIG_MD=y
CONFIG_MDA_CONSOLE=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID5=m
CONFIG_MII=m
CONFIG_MINIX_FS=y
CONFIG_MK7=y
CONFIG_MMU=y
CONFIG_MODULES=y
CONFIG_MODULE_FORCE_UNLOAD=y
CONFIG_MODULE_SRCVERSION_ALL=y
CONFIG_MODULE_UNLOAD=y
CONFIG_MODVERSIONS=y
CONFIG_MOUSE_PS2=y
CONFIG_MOUSE_SERIAL=m
CONFIG_MSDOS_FS=m
CONFIG_MSDOS_PARTITION=y
CONFIG_MTRR=y
CONFIG_NET=y
CONFIG_NETCONSOLE=m
CONFIG_NETDEVICES=y
CONFIG_NETFILTER=y
CONFIG_NETPOLL=y
CONFIG_NETPOLL_RX=y
CONFIG_NETPOLL_TRAP=y
CONFIG_NET_ACT_GACT=m
CONFIG_NET_ACT_IPT=m
CONFIG_NET_ACT_MIRRED=m
CONFIG_NET_ACT_PEDIT=m
CONFIG_NET_ACT_POLICE=m
CONFIG_NET_ACT_SIMP=m
CONFIG_NET_CLS=y
CONFIG_NET_CLS_ACT=y
CONFIG_NET_CLS_BASIC=m
CONFIG_NET_CLS_FW=m
CONFIG_NET_CLS_ROUTE4=m
CONFIG_NET_CLS_ROUTE=y
CONFIG_NET_CLS_RSVP6=m
CONFIG_NET_CLS_RSVP=m
CONFIG_NET_CLS_TCINDEX=m
CONFIG_NET_CLS_U32=m
CONFIG_NET_ESTIMATOR=y
CONFIG_NET_ETHERNET=y
CONFIG_NET_FC=y
CONFIG_NET_IPGRE=m
CONFIG_NET_IPGRE_BROADCAST=y
CONFIG_NET_IPIP=m
CONFIG_NET_KEY=m
CONFIG_NET_PCI=y
CONFIG_NET_POLL_CONTROLLER=y
CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_CLK_GETTIMEOFDAY=y
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_HFSC=m
CONFIG_NET_SCH_HTB=m
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_SCH_NETEM=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_TEQL=m
CONFIG_NET_VENDOR_3COM=y
CONFIG_NFSD=m
CONFIG_NFSD_TCP=y
CONFIG_NFSD_V2_ACL=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V3_ACL=y
CONFIG_NFSD_V4=y
CONFIG_NFS_ACL_SUPPORT=y
CONFIG_NFS_COMMON=y
CONFIG_NFS_DIRECTIO=y
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFS_V3_ACL=y
CONFIG_NFS_V4=y
CONFIG_NLS=y
CONFIG_NLS_ASCII=m
CONFIG_NLS_CODEPAGE_1250=m
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_CODEPAGE_852=m
CONFIG_NLS_CODEPAGE_855=m
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=m
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=m
CONFIG_NLS_CODEPAGE_863=m
CONFIG_NLS_CODEPAGE_864=m
CONFIG_NLS_CODEPAGE_865=m
CONFIG_NLS_CODEPAGE_866=m
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_874=m
CONFIG_NLS_CODEPAGE_932=m
CONFIG_NLS_CODEPAGE_936=m
CONFIG_NLS_CODEPAGE_949=m
CONFIG_NLS_CODEPAGE_950=m
CONFIG_NLS_DEFAULT="utf8"
CONFIG_NLS_ISO8859_13=m
CONFIG_NLS_ISO8859_14=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_6=m
CONFIG_NLS_ISO8859_7=m
CONFIG_NLS_ISO8859_8=m
CONFIG_NLS_ISO8859_9=m
CONFIG_NLS_KOI8_R=m
CONFIG_NLS_KOI8_U=m
CONFIG_NLS_UTF8=m
CONFIG_NTFS_FS=m
CONFIG_NTFS_RW=y
CONFIG_NVRAM=m
CONFIG_OBSOLETE_MODPARM=y
CONFIG_OPROFILE=m
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_PARPORT=m
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
CONFIG_PARPORT_SERIAL=m
CONFIG_PARTITION_ADVANCED=y
CONFIG_PCI=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_MMCONFIG=y
CONFIG_PCI_MSI=y
CONFIG_PHYSICAL_START=0x100000
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_LEGACY=y
CONFIG_PM_STD_PARTITION=""
CONFIG_PNP=y
CONFIG_PNPACPI=y
CONFIG_POSIX_MQUEUE=y
CONFIG_PPDEV=m
CONFIG_PPP=m
CONFIG_PPPOE=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_FILTER=y
CONFIG_PPP_MPPE=m
CONFIG_PPP_MULTILINK=y
CONFIG_PPP_SYNC_TTY=m
CONFIG_PREEMPT_VOLUNTARY=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_PRINTER=m
CONFIG_PRINTK=y
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
CONFIG_PROFILING=y
CONFIG_QFMT_V1=m
CONFIG_QFMT_V2=m
CONFIG_QUOTA=y
CONFIG_QUOTACTL=y
CONFIG_RAMFS=y
CONFIG_REGPARM=y
CONFIG_RELAYFS_FS=m
CONFIG_ROMFS_FS=m
CONFIG_RPCSEC_GSS_KRB5=y
CONFIG_RPCSEC_GSS_SPKM3=m
CONFIG_RTC=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_SCSI=m
CONFIG_SCSI_CONSTANTS=y
CONFIG_SCSI_FC_ATTRS=m
CONFIG_SCSI_ISCSI_ATTRS=m
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_PROC_FS=y
CONFIG_SCSI_QLA2XXX=m
CONFIG_SCSI_SATA=m
CONFIG_SCSI_SATA_AHCI=m
CONFIG_SCSI_SATA_VIA=m
CONFIG_SCSI_SPI_ATTRS=m
CONFIG_SCSI_SYM53C8XX_2=m
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=0
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
CONFIG_SCTP_HMAC_MD5=y
CONFIG_SCx200=m
CONFIG_SECCOMP=y
CONFIG_SECURITY=y
CONFIG_SECURITY_CAPABILITIES=m
CONFIG_SECURITY_NETWORK=y
CONFIG_SECURITY_ROOTPLUG=m
CONFIG_SECURITY_SECLVL=m
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_SEMAPHORE_SLEEPERS=y
CONFIG_SENSORS_EEPROM=m
CONFIG_SENSORS_IT87=m
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_EXTENDED=y
CONFIG_SERIAL_8250_MANY_PORTS=y
CONFIG_SERIAL_8250_NR_UARTS=8
CONFIG_SERIAL_8250_RSA=y
CONFIG_SERIAL_8250_SHARE_IRQ=y
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIO=y
CONFIG_SERIO_CT82C710=m
CONFIG_SERIO_I8042=y
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_PARKBD=m
CONFIG_SERIO_PCIPS2=m
CONFIG_SERIO_RAW=m
CONFIG_SERIO_SERPORT=m
CONFIG_SHAPER=m
CONFIG_SHMEM=y
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_MODE_SLIP6=y
CONFIG_SLIP_SMART=y
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp850"
CONFIG_SND=m
CONFIG_SND_AC97_BUS=m
CONFIG_SND_AC97_CODEC=m
CONFIG_SND_BT87X=m
CONFIG_SND_DEBUG=y
CONFIG_SND_DUMMY=m
CONFIG_SND_GENERIC_DRIVER=y
CONFIG_SND_HWDEP=m
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_MPU401=m
CONFIG_SND_MPU401_UART=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_PCM=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_RAWMIDI=m
CONFIG_SND_RTCTIMER=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_SEQ_RTCTIMER_DEFAULT=y
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_TIMER=m
CONFIG_SND_USB_AUDIO=m
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_VIA82XX=m
CONFIG_SND_VIA82XX_MODEM=m
CONFIG_SND_VIRMIDI=m
CONFIG_SOFTWARE_SUSPEND=y
CONFIG_SOFT_WATCHDOG=m
CONFIG_SOLARIS_X86_PARTITION=y
CONFIG_SOUND=m
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
CONFIG_SWAP=y
CONFIG_SYN_COOKIES=y
CONFIG_SYSCTL=y
CONFIG_SYSFS=y
CONFIG_SYSVIPC=y
CONFIG_TCP_CONG_ADVANCED=y
CONFIG_TCP_CONG_BIC=m
CONFIG_TCP_CONG_HSTCP=m
CONFIG_TCP_CONG_HTCP=m
CONFIG_TCP_CONG_HYBLA=m
CONFIG_TCP_CONG_SCALABLE=m
CONFIG_TCP_CONG_VEGAS=m
CONFIG_TCP_CONG_WESTWOOD=m
CONFIG_THRUSTMASTER_FF=y
CONFIG_TMPFS=y
CONFIG_TUN=m
CONFIG_UDF_FS=m
CONFIG_UDF_NLS=y
CONFIG_UFS_FS=m
CONFIG_UFS_FS_WRITE=y
CONFIG_UID16=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX=y
CONFIG_UNIXWARE_DISKLABEL=y
CONFIG_USB=m
CONFIG_USB_ACM=m
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_USB_DEVICEFS=y
CONFIG_USB_EHCI_HCD=m
CONFIG_USB_EHCI_ROOT_HUB_TT=y
CONFIG_USB_EHCI_SPLIT_ISO=y
CONFIG_USB_HID=m
CONFIG_USB_HIDDEV=y
CONFIG_USB_HIDINPUT=y
CONFIG_USB_MON=y
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_PRINTER=m
CONFIG_USB_STORAGE=m
CONFIG_USB_UHCI_HCD=m
CONFIG_VFAT_FS=m
CONFIG_VGA_CONSOLE=y
CONFIG_VIA_RHINE=m
CONFIG_VIA_RHINE_MMIO=y
CONFIG_VIDEO_BT848=m
CONFIG_VIDEO_BTCX=m
CONFIG_VIDEO_BUF=m
CONFIG_VIDEO_DEV=m
CONFIG_VIDEO_IR=m
CONFIG_VIDEO_SELECT=y
CONFIG_VIDEO_TUNER=m
CONFIG_VIDEO_TVEEPROM=m
CONFIG_VLAN_8021Q=m
CONFIG_VORTEX=m
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_WATCHDOG=y
CONFIG_X86=y
CONFIG_X86_32=y
CONFIG_X86_BIOS_REBOOT=y
CONFIG_X86_BSWAP=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_CPUID=m
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_GENERIC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_INVLPG=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_L1_CACHE_SHIFT=7
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_MCE=y
CONFIG_X86_MCE_NONFATAL=y
CONFIG_X86_MCE_P4THERMAL=y
CONFIG_X86_MPPARSE=y
CONFIG_X86_MSR=m
CONFIG_X86_PC=y
CONFIG_X86_PM_TIMER=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_REBOOTFIXUPS=y
CONFIG_X86_TSC=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_XADD=y
CONFIG_XFRM=y
CONFIG_XFRM_USER=m
CONFIG_XFS_EXPORT=y
CONFIG_XFS_FS=m
CONFIG_XFS_POSIX_ACL=y
CONFIG_XFS_QUOTA=y
CONFIG_XFS_RT=y
CONFIG_XFS_SECURITY=y
CONFIG_ZISOFS=y
CONFIG_ZISOFS_FS=y
CONFIG_ZLIB_DEFLATE=m
CONFIG_ZLIB_INFLATE=y

--CE+1k2dSO48ffgeK--
