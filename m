Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbUAFQr1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 11:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbUAFQr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 11:47:27 -0500
Received: from cimice4.lam.cz ([212.71.168.94]:7298 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S261881AbUAFQrQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 11:47:16 -0500
Date: Tue, 6 Jan 2004 17:47:14 +0100
From: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
To: Hugo Mills <hugo-lkml@carfax.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: won't work: 2.6.0 && SiI 3112 SATA
Message-ID: <20040106174714.B6567@beton.cybernet.src>
References: <20040106135634.A5825@beton.cybernet.src> <20040106132533.GD17606@carfax.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040106132533.GD17606@carfax.org.uk>; from hugo-lkml@carfax.org.uk on Tue, Jan 06, 2004 at 01:25:33PM +0000
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 06, 2004 at 01:25:33PM +0000, Hugo Mills wrote:
> On Tue, Jan 06, 2004 at 01:56:34PM +0100, Karel Kulhavý wrote:
> > I try to make Adaptec SATA RAID AAR-1210SA (in fact, SiI 3112 ACT 144 chip)
> > work under 2.6.0
> > 
> > When booting, get "hde: lost interrupt" and DMA errors. Tried to switch
> > on/off local and I/O APIC (singleproc board) and the errors stay the same.
> > 
> > Are these errors experienced on all SiI3112 boards? Are they experienced
> > also in 2.4 kernel? Shall I try some "newer" kernel than 2.6.0?
> 
>    The AAR-1210SA has a BIOS which turns off interrupts unexpectedly.
> Jeff Garzik released a patch[1] earlier today that addresses this
> problem in the libata driver.
> 
>    Hugo.
> 
> [1] http://marc.theaimsgroup.com/?l=linux-kernel&m=107338181210727&w=2

Tried that patch however no remedy. Interesting is maybe the information the
controller reports on hde. The patch includes something with interrupts
of IDE0 and IDE1.

Tried to "extrapolate" the stuff in sata_sil.c logically (sorry for not knowing
what's going on here) with bitmasks 1<<25, 1<<26 and adding them to the few
lines that reenable the interrupts, but this also didn't work.

In fact, it doesn't even get into the workaround code at the moment the system
freezes temporarily.

I managed (after long wait) to get the system boot up and captured the
dmesg:

Linux version 2.6.0 (root@oberon) (gcc version 3.3.2 20031022 (Gentoo Linux 3.3.2-r3, propolice)) #10 Tue Jan 6 15:48:43 MET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e6000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ff30000 (usable)
 BIOS-e820: 000000003ff30000 - 000000003ff40000 (ACPI data)
 BIOS-e820: 000000003ff40000 - 000000003fff0000 (ACPI NVS)
 BIOS-e820: 000000003fff0000 - 0000000040000000 (reserved)
 BIOS-e820: 00000000fecf0000 - 00000000fecf1000 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000feda0000 (reserved)
Warning only 896MB will be used.
Use a HIGHMEM enabled kernel.
896MB LOWMEM available.
On node 0 totalpages: 229376
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
Building zonelist for node : 0
Kernel command line: root=/dev/sda3
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 2793.189 MHz processor.
Console: colour VGA+ 80x25
Memory: 902880k/917504k available (3140k kernel code, 13840k reserved, 1116k data, 144k init, 0k highmem)
Calibrating delay loop... 5521.40 BogoMIPS
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU:     After all inits, caps: bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xf0031, last bus=3
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Transparent bridge - 0000:00:1e.0
PCI: Using IRQ router PIIX/ICH [8086/24d0] at 0000:00:1f.0
PCI: IRQ 0 for device 0000:00:1f.1 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 10 for device 0000:00:1f.1
PCI: Sharing IRQ 10 with 0000:00:1d.2
PCI: Sharing IRQ 10 with 0000:00:1f.2
PCI: Sharing IRQ 10 with 0000:02:01.0
Machine check exception polling timer started.
Total HugeTLB memory allocated, 0
ikconfig 0.7 with /proc/config*
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.5 [Flags: R/O].
udf: registering filesystem
SGI XFS for Linux with ACLs, large block numbers, no debug enabled
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
pty: 2048 Unix98 ptys configured
Generic RTC Driver v1.07
hw_random hardware driver 1.0.0 loaded
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel i875 Chipset.
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: AGP aperture is 64M @ 0xf8000000
[drm] Initialized r128 2.5.0 20030725 on minor 0
[drm] Initialized radeon 1.9.0 20020828 on minor 1
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Intel(R) PRO/100 Network Driver - version 2.3.30-k1
Copyright (c) 2003 Intel Corporation

PCI: Found IRQ 11 for device 0000:03:08.0
PCI: Sharing IRQ 11 with 0000:03:06.0
e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection
  Hardware receive checksums enabled

Intel(R) PRO/1000 Network Driver - version 5.2.20-k1
Copyright (c) 1999-2003 Intel Corporation.
PCI: Found IRQ 10 for device 0000:02:01.0
PCI: Sharing IRQ 10 with 0000:00:1d.2
PCI: Sharing IRQ 10 with 0000:00:1f.1
PCI: Sharing IRQ 10 with 0000:00:1f.2
PCI: Setting latency timer of device 0000:02:01.0 to 64
eth1: Intel(R) PRO/1000 Network Connection
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
PCI: Found IRQ 10 for device 0000:00:1f.1
PCI: Sharing IRQ 10 with 0000:00:1d.2
PCI: Sharing IRQ 10 with 0000:00:1f.2
PCI: Sharing IRQ 10 with 0000:02:01.0
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hdc: _NEC CD-ROM CD-3002A, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
### THIS IS MY COMMENT Entering __devinit siimage_init_one
Adaptec AAR-1210SA: IDE controller at PCI slot 0000:03:02.0
PCI: Found IRQ 7 for device 0000:03:02.0
PCI: Sharing IRQ 7 with 0000:00:1f.3
Adaptec AAR-1210SA: chipset revision 2
Adaptec AAR-1210SA: 100% native mode on irq 7
    ide2: MMIO-DMA at 0xf8848c00-0xf8848c07, BIOS settings: hde:pio, hdf:pio
    ide3: MMIO-DMA at 0xf8848c08-0xf8848c0f, BIOS settings: hdg:pio, hdh:pio
hde: Maxtor 7Y250M0, ATA DISK drive
ide2 at 0xf8848c80-0xf8848c87,0xf8848c8a on irq 7
hdg: Maxtor 7Y250M0, ATA DISK drive
ide3 at 0xf8848cc0-0xf8848cc7,0xf8848cca on irq 7
hde: max request size: 7KiB
### Here the first freeze occurs
hde: lost interrupt
### Another freeze
hde: lost interrupt
### Another freeze... etc.
hde: lost interrupt
hde: 490234752 sectors (251000 MB) w/7936KiB Cache, CHS=30515/255/63
hde: lost interrupt
hde: lost interrupt
 /dev/ide/host2/bus0/target0/lun0:<4>hde: dma_timer_expiry: dma status == 0x24
hde: DMA interrupt recovery
hde: lost interrupt
 unknown partition table
hdg: max request size: 7KiB
hdg: lost interrupt
hdg: lost interrupt
hdg: lost interrupt
hdg: 490234752 sectors (251000 MB) w/7936KiB Cache, CHS=30515/255/63
hdg: lost interrupt
hdg: lost interrupt
 /dev/ide/host2/bus1/target0/lun0:<4>hdg: dma_timer_expiry: dma status == 0x24
hdg: DMA interrupt recovery
hdg: lost interrupt
 unknown partition table
hdc: ATAPI 52X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
Red Hat/Adaptec aacraid driver (1.1.2 Jan  6 2004)
libata version 0.81 loaded.
ata_piix version 0.95
PCI: Found IRQ 10 for device 0000:00:1f.2
PCI: Sharing IRQ 10 with 0000:00:1d.2
PCI: Sharing IRQ 10 with 0000:00:1f.1
PCI: Sharing IRQ 10 with 0000:02:01.0
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xEC00 ctl 0xE802 bmdma 0xDC00 irq 10
ata2: SATA max UDMA/133 cmd 0xE400 ctl 0xE002 bmdma 0xDC08 irq 10
ata1: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01 87:4003 88:207f
ata1: dev 0 ATA, max UDMA/133, 240121728 sectors
ata1: dev 0 configured for UDMA/133
scsi0 : ata_piix
ata2: dev 0 cfg 49:2f00 82:7c6b 83:7b09 84:4003 85:7c69 86:3a01 87:4003 88:207f
ata2: dev 0 ATA, max UDMA/133, 240121728 sectors
ata2: dev 0 configured for UDMA/133
scsi1 : ata_piix
  Vendor: ATA       Model: Maxtor 6Y120M0    Rev: 0.81
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: Maxtor 6Y120M0    Rev: 0.81
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
SCSI device sda: drive cache: write through
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
SCSI device sdb: 240121728 512-byte hdwr sectors (122942 MB)
SCSI device sdb: drive cache: write through
 /dev/scsi/host1/bus0/target0/lun0: p1 p2 p3
Attached scsi disk sdb at scsi1, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
PCI: Found IRQ 9 for device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 9, pci mem f8854c00
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
PCI: Found IRQ 5 for device 0000:00:1d.0
PCI: Sharing IRQ 5 with 0000:00:1d.3
uhci_hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 5, io base 0000cc00
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
PCI: Found IRQ 3 for device 0000:00:1d.1
uhci_hcd 0000:00:1d.1: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 3, io base 0000d000
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
PCI: Found IRQ 10 for device 0000:00:1d.2
PCI: Sharing IRQ 10 with 0000:00:1f.1
PCI: Sharing IRQ 10 with 0000:00:1f.2
PCI: Sharing IRQ 10 with 0000:02:01.0
uhci_hcd 0000:00:1d.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 10, io base 0000d400
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
PCI: Found IRQ 5 for device 0000:00:1d.3
PCI: Sharing IRQ 5 with 0000:00:1d.0
uhci_hcd 0000:00:1d.3: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: irq 5, io base 0000d800
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
mice: PS/2 mouse device common for all mice
input: PC Speaker
input: GenPS/2 Genius Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
md: raid0 personality registered as nr 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  3248.000 MB/sec
   8regs_prefetch:  2824.000 MB/sec
   32regs    :  2068.000 MB/sec
   32regs_prefetch:  1884.000 MB/sec
   pIII_sse  :  3644.000 MB/sec
   pII_mmx   :  4556.000 MB/sec
   p5_mmx    :  4504.000 MB/sec
raid5: using function: pIII_sse (3644.000 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:36 2003 UTC).
ALSA device list:
  No soundcards found.
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
request_module: failed /sbin/modprobe -- nls_iso8859-1. error = -16
Unable to load NLS charset iso8859-1
sh-2021: reiserfs_fill_super: can not find reiserfs on sda3
UDF-fs DEBUG fs/udf/lowlevel.c:65:udf_get_last_session: CDROMMULTISESSION not supported: rc=-22
UDF-fs DEBUG fs/udf/super.c:1544:udf_fill_super: Multi-session=0
UDF-fs DEBUG fs/udf/super.c:532:udf_vrs: Starting at sector 16 (2048 byte sectors)
UDF-fs: No VRS found
XFS mounting filesystem sda3
Ending clean XFS mount for filesystem: sda3
VFS: Mounted root (xfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 144k freed
Adding 2008116k swap on /dev/sda2.  Priority:-1 extents:1
e1000: eth1 NIC Link is Up 1000 Mbps Full Duplex
hde: dma_timer_expiry: dma status == 0x24
hde: DMA interrupt recovery
hde: lost interrupt
hde: dma_timer_expiry: dma status == 0x24
hdg: dma_timer_expiry: dma status == 0x24
hde: DMA interrupt recovery
hde: lost interrupt
hdg: DMA interrupt recovery
hdg: lost interrupt
hde: dma_timer_expiry: dma status == 0x24
hdg: dma_timer_expiry: dma status == 0x24
hde: DMA interrupt recovery
hde: lost interrupt
hdg: DMA interrupt recovery
hdg: lost interrupt
hde: dma_timer_expiry: dma status == 0x24
hdg: dma_timer_expiry: dma status == 0x24
hde: DMA interrupt recovery
hde: lost interrupt
hdg: DMA interrupt recovery
hdg: lost interrupt
hde: dma_timer_expiry: dma status == 0x24
hdg: dma_timer_expiry: dma status == 0x24
hde: DMA interrupt recovery
hde: lost interrupt
hdg: DMA interrupt recovery
hdg: lost interrupt
hde: dma_timer_expiry: dma status == 0x24
hdg: dma_timer_expiry: dma status == 0x24
hde: DMA interrupt recovery
hde: lost interrupt
hdg: DMA interrupt recovery
hdg: lost interrupt
hde: dma_timer_expiry: dma status == 0x24
hdg: dma_timer_expiry: dma status == 0x24
hde: DMA interrupt recovery
hde: lost interrupt
hdg: DMA interrupt recovery
hdg: lost interrupt
hde: dma_timer_expiry: dma status == 0x24
hdg: dma_timer_expiry: dma status == 0x24
hde: DMA interrupt recovery
hde: lost interrupt
hdg: DMA interrupt recovery
hdg: lost interrupt

Also tried to cat /dev/hde and /dev/hdg. First the processes were dead frozen
but after some minutes the /dev/hdg one sputtered out a chunk of random data.
The /dev/hde one didn't puke out anything no matter that it was started
earlier. I even managed to break them by CTRL-C (after several minutes) ;-)

Any clue what can be wrong here?

Cl<
