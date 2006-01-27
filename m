Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbWA0PVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbWA0PVE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 10:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWA0PVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 10:21:03 -0500
Received: from relay03.pair.com ([209.68.5.17]:6670 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S1751326AbWA0PVA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 10:21:00 -0500
X-pair-Authenticated: 67.163.102.102
From: Chase Venters <chase.venters@clientec.com>
Organization: Clientec, Inc.
To: Jens Axboe <axboe@suse.de>
Subject: Re: More information on scsi_cmd_cache leak... (bisect)
Date: Fri, 27 Jan 2006 09:20:32 -0600
User-Agent: KMail/1.9
Cc: Neil Brown <neilb@suse.de>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org, akpm@osdl.org, a.titov@host.bg,
       askernel2615@dsgml.com, jamie@audible.transient.net
References: <200601270410.06762.chase.venters@clientec.com> <20060127112352.GF4311@suse.de> <20060127112837.GG4311@suse.de>
In-Reply-To: <20060127112837.GG4311@suse.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_spj2D8ciPWSC2Xk"
Message-Id: <200601270920.54713.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_spj2D8ciPWSC2Xk
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 27 January 2006 05:28, Jens Axboe wrote:
> Sorry, that was for the ->issue_flush() that md also does but did before
> the barrier addition as well. Most of the barrier handling is done in
> the block layer, but it could show leaks in SCSI of course. FWIW, I
> tested barriers with and without md on SCSI here a few days ago and
> didn't see any leaks at all.
>
> Chase, can you post full dmesg again? I don't have it, thanks.

Attached.

Thanks,
Chase

--Boundary-00=_spj2D8ciPWSC2Xk
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dmesg"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dmesg"

Linux version 2.6.15-ck1 (root@turbotaz) (gcc version 3.3.6 (Gentoo 3.3.6, =
ssp-3.3.6-1.0, pie-8.7.8)) #1 SMP PREEMPT Tue Jan 10 12:42:28 CST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ffb0000 (usable)
 BIOS-e820: 000000003ffb0000 - 000000003ffbe000 (ACPI data)
 BIOS-e820: 000000003ffbe000 - 000000003fff0000 (ACPI NVS)
 BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000ffb80000 - 0000000100000000 (reserved)
1023MB LOWMEM available.
found SMP MP-table at 000ff780
On node 0 totalpages: 262064
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 257968 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:0
DMI 2.3 present.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: INTEL    Product ID: DELUXE       APIC at: 0xFEE00000
Processor #0 15:4 APIC version 20
I/O APIC #2 Version 32 at 0xFEC00000.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Processors: 1
Allocating PCI resources starting at 50000000 (gap: 40000000:bfb80000)
Built 1 zonelists
Kernel command line: root=3D/dev/md1 noapic acpi=3Doff console=3DttyS0,3840=
0n8 console=3Dtty0
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
CPU 0 irqstacks, hard=3Db0791000 soft=3Db078f000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 3212.691 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)
Memory: 1030612k/1048256k available (4837k kernel code, 17088k reserved, 15=
97k data, 256k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 6429.42 BogoMIPS (lpj=3D32=
14711)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 0000=
441d 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 00004=
41d 00000000 00000000
monitor/mwait feature present.
using mwait in idle threads.
CPU: Trace cache: 12K uops, L1 D cache: 16K
CPU: L2 cache: 1024K
CPU: Physical Processor ID: 0
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 0000441d 00=
000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
mtrr: v2.0 (20020519)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: Intel(R) Pentium(R) 4 CPU 3.20GHz stepping 01
Total of 1 processors activated (6429.42 BogoMIPS).
Brought up 1 CPUs
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=3D4
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI: disabled
Generic PHY: Registered new driver
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:04:00.0
PCI: Transparent bridge - 0000:00:1e.0
PCI: Discovered primary peer bus ff [IRQ]
PCI: Using IRQ router PIIX/ICH [8086/2640] at 0000:00:1f.0
PCI: IRQ 0 for device 0000:00:01.0 doesn't match PIRQ mask - try pci=3Dusep=
irqmask
PCI: Found IRQ 10 for device 0000:00:01.0
PCI: Sharing IRQ 10 with 0000:00:1b.0
PCI: Sharing IRQ 10 with 0000:00:1c.0
PCI: Sharing IRQ 10 with 0000:00:1d.3
PCI: Sharing IRQ 10 with 0000:04:00.0
PCI: IRQ 0 for device 0000:00:1c.1 doesn't match PIRQ mask - try pci=3Dusep=
irqmask
PCI: Found IRQ 5 for device 0000:00:1c.1
PCI: Sharing IRQ 5 with 0000:02:00.0
PCI: Sharing IRQ 5 with 0000:01:09.0
PCI: IRQ 0 for device 0000:00:1f.1 doesn't match PIRQ mask - try pci=3Dusep=
irqmask
PCI: Found IRQ 5 for device 0000:00:1f.1
PCI: Sharing IRQ 5 with 0000:00:1d.2
PCI: Sharing IRQ 5 with 0000:01:09.2
PCI: IRQ 0 for device 0000:00:1f.3 doesn't match PIRQ mask - try pci=3Dusep=
irqmask
PCI: Found IRQ 3 for device 0000:00:1f.3
PCI: Sharing IRQ 3 with 0000:00:1d.1
PCI: Sharing IRQ 3 with 0000:00:1f.2
PCI: Bridge: 0000:00:01.0
  IO window: e000-efff
  MEM window: cdf00000-cfffffff
  PREFETCH window: d0000000-dfffffff
PCI: Bridge: 0000:00:1c.0
  IO window: d000-dfff
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1c.1
  IO window: c000-cfff
  MEM window: cde00000-cdefffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:1e.0
  IO window: a000-bfff
  MEM window: cdd00000-cddfffff
  PREFETCH window: 50000000-500fffff
PCI: Found IRQ 10 for device 0000:00:01.0
PCI: Sharing IRQ 10 with 0000:00:1b.0
PCI: Sharing IRQ 10 with 0000:00:1c.0
PCI: Sharing IRQ 10 with 0000:00:1d.3
PCI: Sharing IRQ 10 with 0000:04:00.0
PCI: Setting latency timer of device 0000:00:01.0 to 64
PCI: Found IRQ 10 for device 0000:00:1c.0
PCI: Sharing IRQ 10 with 0000:00:01.0
PCI: Sharing IRQ 10 with 0000:00:1b.0
PCI: Sharing IRQ 10 with 0000:00:1d.3
PCI: Sharing IRQ 10 with 0000:04:00.0
PCI: Setting latency timer of device 0000:00:1c.0 to 64
PCI: Found IRQ 5 for device 0000:00:1c.1
PCI: Sharing IRQ 5 with 0000:02:00.0
PCI: Sharing IRQ 5 with 0000:01:09.0
PCI: Setting latency timer of device 0000:00:1c.1 to 64
PCI: Setting latency timer of device 0000:00:1e.0 to 64
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.14 <tigran@veritas.com>
audit: initializing netlink socket (disabled)
audit(1138354673.738:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
fuse init (API version 7.3)
JFS: nTxBlock =3D 8052, nTxLock =3D 64423
SGI XFS with ACLs, security attributes, large block numbers, no debug enabl=
ed
SGI XFS Quota Management subsystem
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
 0000:00:1d.0: uhci_check_and_reset_hc: legsup =3D 0x0f30
 0000:00:1d.0: Performing full reset
 0000:00:1d.1: uhci_check_and_reset_hc: legsup =3D 0x0030
 0000:00:1d.1: Performing full reset
 0000:00:1d.2: uhci_check_and_reset_hc: legsup =3D 0x0030
 0000:00:1d.2: Performing full reset
 0000:00:1d.3: uhci_check_and_reset_hc: legsup =3D 0x0030
 0000:00:1d.3: Performing full reset
0000:00:1d.7 EHCI: early BIOS handoff failed (BIOS bug ?)
PCI: Found IRQ 10 for device 0000:00:01.0
PCI: Sharing IRQ 10 with 0000:00:1b.0
PCI: Sharing IRQ 10 with 0000:00:1c.0
PCI: Sharing IRQ 10 with 0000:00:1d.3
PCI: Sharing IRQ 10 with 0000:04:00.0
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
PCI: Found IRQ 10 for device 0000:00:1c.0
PCI: Sharing IRQ 10 with 0000:00:1b.0
PCI: Sharing IRQ 10 with 0000:00:1d.3
PCI: Sharing IRQ 10 with 0000:04:00.0
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie02]
PCI: Found IRQ 5 for device 0000:00:1c.1
PCI: Sharing IRQ 5 with 0000:02:00.0
PCI: Sharing IRQ 5 with 0000:01:09.0
PCI: Setting latency timer of device 0000:00:1c.1 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie02]
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
hw_random: RNG not detected
[drm] Initialized drm 1.0.0 20040925
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
=46loppy drive(s): fd0 is 1.44M
=46DC 0 is a post-1991 82077
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
Marvell 88E1101: Registered new driver
Davicom DM9161E: Registered new driver
Davicom DM9131: Registered new driver
Cicada Cis8204: Registered new driver
LXT970: Registered new driver
LXT971: Registered new driver
QS6612: Registered new driver
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
ICH6: IDE controller at PCI slot 0000:00:1f.1
PCI: Found IRQ 5 for device 0000:00:1f.1
PCI: Sharing IRQ 5 with 0000:00:1d.2
PCI: Sharing IRQ 5 with 0000:01:09.2
ICH6: chipset revision 3
ICH6: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: PLEXTOR DVDR PX-716A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
IT8212: IDE controller at PCI slot 0000:01:04.0
PCI: Found IRQ 11 for device 0000:01:04.0
PCI: Sharing IRQ 11 with 0000:00:1d.0
PCI: Sharing IRQ 11 with 0000:00:1d.7
IT8212: chipset revision 19
it821x: controller in pass through mode.
IT8212: 100% native mode on irq 11
    ide2: BM-DMA at 0xa880-0xa887, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xa888-0xa88f, BIOS settings: hdg:pio, hdh:pio
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide1...
Probing IDE interface ide2...
Probing IDE interface ide3...
hda: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 8192kB Cache, UDMA(66)
Uniform CD-ROM driver Revision: 3.20
PCI: Found IRQ 11 for device 0000:01:0a.0
PCI: Sharing IRQ 11 with 0000:01:03.0
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
        <Adaptec 2902/04/10/15/20C/30C SCSI adapter>
        aic7850: Ultra Single Channel A, SCSI Id=3D7, 3/253 SCBs

  Vendor: PLEXTOR   Model: CD-R   PX-W124TS  Rev: 1.07
  Type:   CD-ROM                             ANSI SCSI revision: 02
 target0:0:4: Beginning Domain Validation
 target0:0:4: FAST-20 SCSI 20.0 MB/s ST (50 ns, offset 8)
 target0:0:4: Domain Validation skipping write tests
 target0:0:4: Ending Domain Validation
libata version 1.20 loaded.
ata_piix 0000:00:1f.2: version 1.05
PCI: Found IRQ 3 for device 0000:00:1f.2
PCI: Sharing IRQ 3 with 0000:00:1d.1
PCI: Sharing IRQ 3 with 0000:00:1f.3
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x9C00 ctl 0x9882 bmdma 0x9400 irq 3
ata2: SATA max UDMA/133 cmd 0x9800 ctl 0x9482 bmdma 0x9408 irq 3
ata1: dev 0 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3469 86:3e01 87:4003 88:=
203f
ata1: dev 0 ATA-6, max UDMA/100, 625142448 sectors: LBA48
ata1: dev 1 cfg 49:2f00 82:306b 83:7e01 84:4003 85:3069 86:3c01 87:4003 88:=
203f
ata1: dev 1 ATA-6, max UDMA/100, 625142448 sectors: LBA48
ata1: dev 0 configured for UDMA/100
ata1: dev 1 configured for UDMA/100
scsi1 : ata_piix
ata2: dev 0 cfg 49:2f00 82:306b 83:7e01 84:4003 85:3069 86:3c01 87:4003 88:=
203f
ata2: dev 0 ATA-6, max UDMA/100, 625142448 sectors: LBA48
ata2: dev 1 cfg 49:2f00 82:346b 83:7f01 84:4003 85:3469 86:3c01 87:4003 88:=
203f
ata2: dev 1 ATA-6, max UDMA/100, 625142448 sectors: LBA48
ata2: dev 0 configured for UDMA/100
ata2: dev 1 configured for UDMA/100
scsi2 : ata_piix
  Vendor: ATA       Model: WDC WD3200JD-98K  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: WDC WD3200JD-60K  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: WDC WD3200JD-60K  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: WDC WD3200JD-00K  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3
sd 1:0:0:0: Attached scsi disk sda
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 sdb3
sd 1:0:1:0: Attached scsi disk sdb
SCSI device sdc: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sdc: drive cache: write back
 sdc: sdc1 sdc2 sdc3
sd 2:0:0:0: Attached scsi disk sdc
SCSI device sdd: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sdd: drive cache: write back
SCSI device sdd: 625142448 512-byte hdwr sectors (320073 MB)
SCSI device sdd: drive cache: write back
 sdd: sdd1 sdd2 sdd3
sd 2:0:1:0: Attached scsi disk sdd
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
sr 0:0:4:0: Attached scsi CD-ROM sr0
sr 0:0:4:0: Attached scsi generic sg0 type 5
sd 1:0:0:0: Attached scsi generic sg1 type 0
sd 1:0:1:0: Attached scsi generic sg2 type 0
sd 2:0:0:0: Attached scsi generic sg3 type 0
sd 2:0:1:0: Attached scsi generic sg4 type 0
ehci_hcd: block sizes: qh 128 qtd 96 itd 192 sitd 96
PCI: Found IRQ 11 for device 0000:00:1d.7
PCI: Sharing IRQ 11 with 0000:00:1d.0
PCI: Sharing IRQ 11 with 0000:01:04.0
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: reset hcs_params 0x104208 dbg=3D1 cc=3D4 pcc=3D2 ord=
ered !ppc ports=3D8
ehci_hcd 0000:00:1d.7: reset hcc_params 6871 thresh 7 uframes 1024 64 bit a=
ddr
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: capability 1000001 at 68
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
drivers/usb/core/inode.c: creating file 'devices'
drivers/usb/core/inode.c: creating file '001'
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 11, io mem 0xcdcff800
ehci_hcd 0000:00:1d.7: reset command 080012 (park)=3D0 ithresh=3D8 Periodic=
 period=3D1024 Reset HALT
ehci_hcd 0000:00:1d.7: init command 010001 (park)=3D0 ithresh=3D1 period=3D=
1024 RUN
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: default language 0x0409
usb usb1: new device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb1: Product: EHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.15-ck1 ehci_hcd
usb usb1: SerialNumber: 0000:00:1d.7
usb usb1: hotplug
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: no power switching (usb 1.0)
hub 1-0:1.0: individual port over-current protection
hub 1-0:1.0: Single TT
hub 1-0:1.0: TT requires at most 8 FS bit times (666 ns)
hub 1-0:1.0: power on to power good time: 20ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: state 5 ports 8 chg 0000 evt 0000
drivers/usb/core/inode.c: creating file '001'
ehci_hcd 0000:00:1d.7: GetStatus port 2 status 001803 POWER sig=3Dj CSC CON=
NECT
hub 1-0:1.0: port 2, status 0501, change 0001, 480 Mb/s
USB Universal Host Controller Interface driver v2.3
PCI: Found IRQ 11 for device 0000:00:1d.0
PCI: Sharing IRQ 11 with 0000:00:1d.7
PCI: Sharing IRQ 11 with 0000:01:04.0
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: detected 2 ports
uhci_hcd 0000:00:1d.0: uhci_check_and_reset_hc: cmd =3D 0x0000
uhci_hcd 0000:00:1d.0: Performing full reset
drivers/usb/core/inode.c: creating file '002'
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 11, io base 0x00008880
usb usb2: default language 0x0409
usb usb2: new device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb2: Product: UHCI Host Controller
hub 1-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x501
usb usb2: Manufacturer: Linux 2.6.15-ck1 uhci_hcd
usb usb2: SerialNumber: 0000:00:1d.0
usb usb2: hotplug
usb usb2: adding 2-0:1.0 (config #1, interface 0)
usb 2-0:1.0: hotplug
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: no power switching (usb 1.0)
hub 2-0:1.0: individual port over-current protection
hub 2-0:1.0: power on to power good time: 2ms
hub 2-0:1.0: local power source is good
ehci_hcd 0000:00:1d.7: port 2 high speed
ehci_hcd 0000:00:1d.7: GetStatus port 2 status 001005 POWER sig=3Dse0 PE CO=
NNECT
usb 1-2: new high speed USB device using ehci_hcd and address 2
drivers/usb/core/inode.c: creating file '001'
PCI: Found IRQ 3 for device 0000:00:1d.1
PCI: Sharing IRQ 3 with 0000:00:1f.2
PCI: Sharing IRQ 3 with 0000:00:1f.3
ehci_hcd 0000:00:1d.7: port 2 high speed
ehci_hcd 0000:00:1d.7: GetStatus port 2 status 001005 POWER sig=3Dse0 PE CO=
NNECT
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: detected 2 ports
uhci_hcd 0000:00:1d.1: uhci_check_and_reset_hc: cmd =3D 0x0000
uhci_hcd 0000:00:1d.1: Performing full reset
drivers/usb/core/inode.c: creating file '003'
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 3, io base 0x00008c00
usb usb3: default language 0x0409
usb usb3: new device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb3: Product: UHCI Host Controller
usb usb3: Manufacturer: Linux 2.6.15-ck1 uhci_hcd
usb usb3: SerialNumber: 0000:00:1d.1
usb usb3: hotplug
usb usb3: adding 3-0:1.0 (config #1, interface 0)
usb 3-0:1.0: hotplug
hub 3-0:1.0: usb_probe_interface
hub 3-0:1.0: usb_probe_interface - got id
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
hub 3-0:1.0: standalone hub
hub 3-0:1.0: no power switching (usb 1.0)
hub 3-0:1.0: individual port over-current protection
hub 3-0:1.0: power on to power good time: 2ms
hub 3-0:1.0: local power source is good
usb 1-2: default language 0x0409
usb 1-2: new device strings: Mfr=3D0, Product=3D1, SerialNumber=3D0
usb 1-2: Product: USB2.0 Hub
usb 1-2: hotplug
usb 1-2: adding 1-2:1.0 (config #1, interface 0)
usb 1-2:1.0: hotplug
hub 1-2:1.0: usb_probe_interface
hub 1-2:1.0: usb_probe_interface - got id
hub 1-2:1.0: USB hub found
hub 1-2:1.0: 4 ports detected
hub 1-2:1.0: standalone hub
hub 1-2:1.0: individual port power switching
hub 1-2:1.0: individual port over-current protection
hub 1-2:1.0: Single TT
hub 1-2:1.0: TT requires at most 32 FS bit times (2664 ns)
hub 1-2:1.0: Port indicators are supported
hub 1-2:1.0: power on to power good time: 100ms
hub 1-2:1.0: local power source is good
hub 1-2:1.0: enabling power on all ports
drivers/usb/core/inode.c: creating file '001'
PCI: Found IRQ 5 for device 0000:00:1d.2
PCI: Sharing IRQ 5 with 0000:00:1f.1
PCI: Sharing IRQ 5 with 0000:01:09.2
usb 1-2: link qh256-0001/efad4100 start 255 [1/0 us]
drivers/usb/core/inode.c: creating file '002'
ehci_hcd 0000:00:1d.7: GetStatus port 5 status 001403 POWER sig=3Dk CSC CON=
NECT
hub 1-0:1.0: port 5, status 0501, change 0001, 480 Mb/s
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: detected 2 ports
uhci_hcd 0000:00:1d.2: uhci_check_and_reset_hc: cmd =3D 0x0000
uhci_hcd 0000:00:1d.2: Performing full reset
drivers/usb/core/inode.c: creating file '004'
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 5, io base 0x00009000
usb usb4: default language 0x0409
usb usb4: new device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb4: Product: UHCI Host Controller
usb usb4: Manufacturer: Linux 2.6.15-ck1 uhci_hcd
usb usb4: SerialNumber: 0000:00:1d.2
usb usb4: hotplug
usb usb4: adding 4-0:1.0 (config #1, interface 0)
usb 4-0:1.0: hotplug
hub 4-0:1.0: usb_probe_interface
hub 4-0:1.0: usb_probe_interface - got id
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
hub 4-0:1.0: standalone hub
hub 4-0:1.0: no power switching (usb 1.0)
hub 4-0:1.0: individual port over-current protection
hub 4-0:1.0: power on to power good time: 2ms
hub 4-0:1.0: local power source is good
hub 1-0:1.0: debounce: port 5: total 100ms stable 100ms status 0x501
ehci_hcd 0000:00:1d.7: port 5 low speed --> companion
ehci_hcd 0000:00:1d.7: GetStatus port 5 status 003002 POWER OWNER sig=3Dse0=
 CSC
hub 1-0:1.0: state 5 ports 8 chg 0000 evt 0000
hub 2-0:1.0: state 5 ports 2 chg 0000 evt 0004
uhci_hcd 0000:00:1d.0: port 2 portsc 0082,00
hub 2-0:1.0: port 2, status 0100, change 0001, 12 Mb/s
drivers/usb/core/inode.c: creating file '001'
PCI: Found IRQ 10 for device 0000:00:1d.3
PCI: Sharing IRQ 10 with 0000:00:1b.0
PCI: Sharing IRQ 10 with 0000:04:00.0
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: detected 2 ports
uhci_hcd 0000:00:1d.3: uhci_check_and_reset_hc: cmd =3D 0x0000
uhci_hcd 0000:00:1d.3: Performing full reset
drivers/usb/core/inode.c: creating file '005'
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
hub 2-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x100
hub 3-0:1.0: state 5 ports 2 chg 0000 evt 0000
hub 1-2:1.0: state 5 ports 4 chg 0000 evt 0018
uhci_hcd 0000:00:1d.3: irq 10, io base 0x00009080
usb usb5: default language 0x0409
usb usb5: new device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
usb usb5: Product: UHCI Host Controller
usb usb5: Manufacturer: Linux 2.6.15-ck1 uhci_hcd
usb usb5: SerialNumber: 0000:00:1d.3
usb usb5: hotplug
usb usb5: adding 5-0:1.0 (config #1, interface 0)
usb 5-0:1.0: hotplug
hub 5-0:1.0: usb_probe_interface
hub 5-0:1.0: usb_probe_interface - got id
hub 5-0:1.0: USB hub found
hub 1-2:1.0: port 3, status 0301, change 0001, 1.5 Mb/s
hub 5-0:1.0: 2 ports detected
hub 5-0:1.0: standalone hub
hub 5-0:1.0: no power switching (usb 1.0)
hub 5-0:1.0: individual port over-current protection
hub 5-0:1.0: power on to power good time: 2ms
hub 5-0:1.0: local power source is good
drivers/usb/core/inode.c: creating file '001'
hub 1-2:1.0: debounce: port 3: total 100ms stable 100ms status 0x301
hub 1-2:1.0: port 3 not reset yet, waiting 10ms
usb 1-2.3: new low speed USB device using ehci_hcd and address 4
hub 1-2:1.0: port 3 not reset yet, waiting 10ms
usb 1-2.3: skipped 1 descriptor after interface
usb 1-2.3: default language 0x0409
usb 1-2.3: new device strings: Mfr=3D4, Product=3D26, SerialNumber=3D0
usb 1-2.3: Product: Keytronic USB Keyboard
usb 1-2.3: Manufacturer: Key Tronic
usb 1-2.3: hotplug
usb 1-2.3: adding 1-2.3:1.0 (config #1, interface 0)
usb 1-2.3:1.0: hotplug
usb 1-2.3: wrong descriptor type 00 for string 20 ("ic?Keytronic USB Keyboa=
rd?1234???????????????????????=A9")
drivers/usb/core/inode.c: creating file '004'
hub 1-2:1.0: port 4, status 0301, change 0001, 1.5 Mb/s
hub 1-2:1.0: debounce: port 4: total 100ms stable 100ms status 0x301
hub 1-2:1.0: port 4 not reset yet, waiting 10ms
usb 1-2.4: new low speed USB device using ehci_hcd and address 5
hub 1-2:1.0: port 4 not reset yet, waiting 10ms
usb 1-2.4: skipped 1 descriptor after interface
usb 1-2.4: default language 0x0409
usb 1-2.4: new device strings: Mfr=3D0, Product=3D1, SerialNumber=3D0
usb 1-2.4: Product: USB Mouse
usb 1-2.4: hotplug
usb 1-2.4: adding 1-2.4:1.0 (config #1, interface 0)
usb 1-2.4:1.0: hotplug
drivers/usb/core/inode.c: creating file '005'
hub 4-0:1.0: state 5 ports 2 chg 0000 evt 0002
uhci_hcd 0000:00:1d.2: port 1 portsc 01a3,00
uhci_hcd 0000:00:1d.1: suspend_rh (auto-stop)
hub 4-0:1.0: port 1, status 0301, change 0001, 1.5 Mb/s
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
hub 4-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x301
usb 4-1: new low speed USB device using uhci_hcd and address 2
uhci_hcd 0000:00:1d.0: suspend_rh (auto-stop)
usb 4-1: skipped 1 descriptor after interface
usb 4-1: default language 0x0409
uhci_hcd 0000:00:1d.3: suspend_rh (auto-stop)
usb 4-1: new device strings: Mfr=3D3, Product=3D1, SerialNumber=3D2
usb 4-1: Product: Back-UPS RS 1000 FW:7.g8 .D USB FW:g8=20
usb 4-1: Manufacturer: American Power Conversion
usb 4-1: SerialNumber: QB0507149462 =20
usb 4-1: hotplug
usb 4-1: adding 4-1:1.0 (config #1, interface 0)
usb 4-1:1.0: hotplug
drivers/usb/core/inode.c: creating file '002'
hub 1-2:1.0: state 5 ports 4 chg 0000 evt 0010
usbcore: registered new driver usb-storage
hub 5-0:1.0: state 5 ports 2 chg 0000 evt 0000
USB Mass Storage support registered.
usbcore: registered new driver ati_remote
drivers/usb/input/ati_remote.c: Registered USB driver ATI/X10 RF USB Remote=
 Control v. 2.2.1
usbcore: registered new driver hiddev
usbhid 1-2.3:1.0: usb_probe_interface
usbhid 1-2.3:1.0: usb_probe_interface - got id
input: Key Tronic Keytronic USB Keyboard as /class/input/input0
usb 1-2.3: link qh8-0601/efad4280 start 7 [1/2 us]
input: USB HID v1.10 Keyboard [Key Tronic Keytronic USB Keyboard] on usb-00=
00:00:1d.7-2.3
usbhid 1-2.4:1.0: usb_probe_interface
usbhid 1-2.4:1.0: usb_probe_interface - got id
input: USB Mouse as /class/input/input1
input: USB HID v1.00 Mouse [USB Mouse] on usb-0000:00:1d.7-2.4
usbhid 4-1:1.0: usb_probe_interface
usbhid 4-1:1.0: usb_probe_interface - got id
drivers/usb/core/file.c: looking for a minor, starting at 0
hiddev0: USB HID v1.10 Device [American Power Conversion Back-UPS RS 1000 F=
W:7.g8 .D USB FW:g8 ] on usb-0000:00:1d.2-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial support registered for generic
usbcore: registered new driver usbserial_generic
drivers/usb/serial/usb-serial.c: USB Serial Driver core
gameport: EMU10K1 is pci0000:01:09.1/gameport0, io 0xbc00, speed 932kHz
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input2
I2O subsystem v1.288
i2o: max drivers =3D 8
I2O Configuration OSM v1.248
I2O Bus Adapter OSM v$Rev$
I2O Block Device OSM v1.287
I2O SCSI Peripheral OSM v1.282
I2O ProcFS OSM v1.145
i2c /dev entries driver
md: linear personality registered as nr 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid10 personality registered as nr 9
md: raid5 personality registered as nr 4
raid5: automatically using best checksumming function: pIII_sse
   pIII_sse  :  4744.000 MB/sec
raid5: using function: pIII_sse (4744.000 MB/sec)
raid6: int32x1    925 MB/s
raid6: int32x2    996 MB/s
raid6: int32x4    726 MB/s
raid6: int32x8    609 MB/s
raid6: mmxx1     1957 MB/s
raid6: mmxx2     2269 MB/s
raid6: sse1x1    1164 MB/s
raid6: sse1x2    1246 MB/s
raid6: sse2x1    2226 MB/s
raid6: sse2x2    2402 MB/s
raid6: using algorithm sse2x2 (2402 MB/s)
md: raid6 personality registered as nr 8
md: multipath personality registered as nr 7
md: md driver 0.90.3 MAX_MD_DEVS=3D256, MD_SB_DISKS=3D27
md: bitmap version 4.39
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
device-mapper: dm-multipath version 1.0.4 loaded
device-mapper: dm-round-robin version 1.0.0 loaded
device-mapper: dm-emc version 0.0.3 loaded
wbsd: Winbond W83L51xD SD/MMC card interface driver, 1.5
wbsd: Copyright(c) Pierre Ossman
padlock: VIA PadLock not detected.
oprofile: using NMI interrupt.
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 262144 (order: 9, 3145728 bytes)
TCP bind hash table entries: 65536 (order: 7, 786432 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
IPv4 over IPv4 tunneling driver
GRE over IPv4 tunneling driver
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
Bridge firewalling registered
802.1Q VLAN Support v1.8 Ben Greear <greearb@candelatech.com>
All bugs added by David S. Miller <davem@redhat.com>
CCID: Registered CCID 3 (ccid3)
Using IPI Shortcut mode
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdd3 ...
md:  adding sdd3 ...
md: sdd1 has different UUID to sdd3
md:  adding sdc3 ...
md: sdc1 has different UUID to sdd3
md:  adding sdb3 ...
md: sdb1 has different UUID to sdd3
md:  adding sda3 ...
md: sda1 has different UUID to sdd3
md: created md1
md: bind<sda3>
md: bind<sdb3>
md: bind<sdc3>
md: bind<sdd3>
md: running: <sdd3><sdc3><sdb3><sda3>
md: md1: raid array is not clean -- starting background reconstruction
raid10: raid set md1 active with 4 out of 4 devices
md: syncing RAID array md1
md: minimum _guaranteed_ reconstruction speed: 1000 KB/sec/disc.
md: using maximum available idle IO bandwidth (but not more than 200000 KB/=
sec) for reconstruction.
md: using 128k window, over a total of 622920192 blocks.
md: considering sdd1 ...
md:  adding sdd1 ...
md:  adding sdc1 ...
md:  adding sdb1 ...
md:  adding sda1 ...
md: created md0
md: bind<sda1>
md: bind<sdb1>
md: bind<sdc1>
md: bind<sdd1>
md: running: <sdd1><sdc1><sdb1><sda1>
raid1: raid set md0 active with 4 out of 4 mirrors
md: ... autorun DONE.
ReiserFS: md1: found reiserfs format "3.6" with standard journal
ReiserFS: md1: using ordered data mode
ReiserFS: md1: journal params: device md1, size 8192, journal first block 1=
8, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: md1: checking transaction log (md1)
ReiserFS: md1: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
=46reeing unused kernel memory: 256k freed
Adding 1004052k swap on /dev/sda2.  Priority:-1 extents:1 across:1004052k
Adding 1004052k swap on /dev/sdb2.  Priority:-2 extents:1 across:1004052k
PCI: Found IRQ 5 for device 0000:02:00.0
PCI: Sharing IRQ 5 with 0000:01:09.0
sk98lin: Network Device Driver v8.23.1.3
(C)Copyright 1999-2005 Marvell(R).
PCI: Found IRQ 5 for device 0000:02:00.0
PCI: Sharing IRQ 5 with 0000:01:09.0
PCI: Setting latency timer of device 0000:02:00.0 to 64
eth0: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
      PrefPort:A  RlmtMode:Check Link State
PCI: Found IRQ 10 for device 0000:00:1b.0
PCI: Sharing IRQ 10 with 0000:00:1d.3
PCI: Sharing IRQ 10 with 0000:04:00.0
PCI: Setting latency timer of device 0000:00:1b.0 to 64
nvidia: no version for "struct_module" found: kernel tainted.
nvidia: module license 'NVIDIA' taints kernel.
PCI: Found IRQ 10 for device 0000:04:00.0
PCI: Sharing IRQ 10 with 0000:00:1b.0
PCI: Sharing IRQ 10 with 0000:00:1d.3
PCI: Setting latency timer of device 0000:04:00.0 to 64
NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-7676  Fri Jul 29 1=
2:58:54 PDT 2005
ADDRCONF(NETDEV_UP): eth0: link is not ready
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        none
    irq moderation:  disabled
    tcp offload:     enabled
    scatter-gather:  enabled
    tx-checksum:     enabled
    rx-checksum:     enabled
    rx-polling:      enabled
ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
cdrom: open failed.
eth0: no IPv6 routers present
usb 1-2.4: link qh8-3008/efad4300 start 7 [1/2 us]
usb 1-2.4: unlink qh8-3008/efad4300 start 7 [1/2 us]
ehci_hcd 0000:00:1d.7: reused qh efad4300 schedule
usb 1-2.4: link qh8-3008/efad4300 start 7 [1/2 us]
md: md1: sync done.
RAID10 conf printout:
 --- wd:4 rd:4
 disk 0, wo:0, o:1, dev:sdc3
 disk 1, wo:0, o:1, dev:sdd3
 disk 2, wo:0, o:1, dev:sdb3
 disk 3, wo:0, o:1, dev:sda3
spurious 8259A interrupt: IRQ7.

--Boundary-00=_spj2D8ciPWSC2Xk--
