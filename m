Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbVACSfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbVACSfL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 13:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbVACSeV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 13:34:21 -0500
Received: from pop.gmx.net ([213.165.64.20]:58821 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261763AbVACS3v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 13:29:51 -0500
X-Authenticated: #438326
From: Michael Geithe <warpy@gmx.de>
To: Len Brown <len.brown@intel.com>
Subject: Re: __iounmap: bad address c00f0000 (Re: 2.6.10-bk5)
Date: Mon, 3 Jan 2005 19:29:49 +0100
User-Agent: KMail/1.7.2
References: <200501030114.55399.warpy@gmx.de> <1104773076.18173.64.camel@d845pe> <1104774583.18174.68.camel@d845pe>
In-Reply-To: <1104774583.18174.68.camel@d845pe>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_e8Y2Bo3ycC+Ofnp"
Message-Id: <200501031929.50080.warpy@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_e8Y2Bo3ycC+Ofnp
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 03 January 2005 18:49, you wrote:
> Suggested-by: Al Viro
> Signed-off-by: Len Brown <len.brown@intel.com>
>
>
> ===== arch/i386/kernel/dmi_scan.c 1.74 vs edited =====
> --- 1.74/arch/i386/kernel/dmi_scan.c 2004-12-28 14:07:48 -05:00
> +++ edited/arch/i386/kernel/dmi_scan.c 2005-01-03 12:46:33 -05:00
> @@ -126,12 +126,12 @@
>     dmi_printk((KERN_INFO "DMI table at 0x%08X.\n",
>      base));
>     if(dmi_table(base,len, num, decode)==0) {
> -    iounmap(p);
> +    /* too early to call iounmap(p); */
>      return 0;
>     }
>    }
>   }
> - iounmap(p);
> + /* too early to call iounmap(p); */
>   return -1;
>  }

Hi,
with this patch now looks good.

Linux version 2.6.10-bk6 (root@h2so4.warpy.net) (gcc-Version 3.3.4 20040623 
(Gentoo Linux 3.3.4-r1, ssp-3.3.2-2, pie-8.7.6)) #1 SMP Mon Jan 3 19:11:36 
CET 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d4000 - 00000000000de014 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff8000 (ACPI data)
 BIOS-e820: 000000003fff8000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000fc0f0
On node 0 totalpages: 262128
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32752 pages, LIFO batch:7
DMI 2.3 present.
ACPI: RSDP (v000 AMI                                   ) @ 0x000fa380
ACPI: RSDT (v001 AMIINT INTEL875 0x00000010 MSFT 0x00000097) @ 0x3fff0000
ACPI: FADT (v001 AMIINT INTEL875 0x00000011 MSFT 0x00000097) @ 0x3fff0030
ACPI: MADT (v001 AMIINT INTEL875 0x00000009 MSFT 0x00000097) @ 0x3fff00c0
ACPI: DSDT (v001  INTEL     I875 0x00001000 MSFT 0x0100000d) @ 0x00000000

Thanks

-- Michael Geithe








--Boundary-00=_e8Y2Bo3ycC+Ofnp
Content-Type: text/plain;
  charset="iso-8859-15";
  name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="dmesg"

Linux version 2.6.10-bk6 (root@h2so4.warpy.net) (gcc-Version 3.3.4 20040623 (Gentoo Linux 3.3.4-r1, ssp-3.3.2-2, pie-8.7.6)) #1 SMP Mon Jan 3 19:11:36 CET 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d4000 - 00000000000de014 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff8000 (ACPI data)
 BIOS-e820: 000000003fff8000 - 0000000040000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000fff00000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000fc0f0
On node 0 totalpages: 262128
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225280 pages, LIFO batch:16
  HighMem zone: 32752 pages, LIFO batch:7
DMI 2.3 present.
ACPI: RSDP (v000 AMI                                   ) @ 0x000fa380
ACPI: RSDT (v001 AMIINT INTEL875 0x00000010 MSFT 0x00000097) @ 0x3fff0000
ACPI: FADT (v001 AMIINT INTEL875 0x00000011 MSFT 0x00000097) @ 0x3fff0030
ACPI: MADT (v001 AMIINT INTEL875 0x00000009 MSFT 0x00000097) @ 0x3fff00c0
ACPI: DSDT (v001  INTEL     I875 0x00001000 MSFT 0x0100000d) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:2 APIC version 20
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:2 APIC version 20
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Built 1 zonelists
Kernel command line: root=/dev/md0 acpi_os_name=Linux video=vesafb:ypan,vram:16vga=0x317
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
CPU 0 irqstacks, hard=c03dc000 soft=c03da000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 2800.850 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1035560k/1048512k available (2039k kernel code, 12308k reserved, 646k data, 208k init, 131008k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 5537.79 BogoMIPS (lpj=2768896)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU0: Intel P4/Xeon Extended MCE MSRs (12) available
CPU0: Thermal monitoring enabled
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: Overriding _OS definition to 'Linux'
CPU0: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
per-CPU timeslice cutoff: 1463.19 usecs.
task migration cache decay timeout: 2 msecs.
Booting processor 1/1 eip 2000
CPU 1 irqstacks, hard=c03dd000 soft=c03db000
Initializing CPU#1
Calibrating delay loop... 5586.94 BogoMIPS (lpj=2793472)
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000
CPU: After vendor identify, caps:  bfebfbff 00000000 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 512K
CPU: Physical Processor ID: 0
CPU: After all inits, caps:        bfebfbff 00000000 00000000 00000080
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: Intel P4/Xeon Extended MCE MSRs (12) available
CPU1: Thermal monitoring enabled
CPU1: Intel(R) Pentium(R) 4 CPU 2.80GHz stepping 09
Total of 2 processors activated (11124.73 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 pin1=2 pin2=-1
checking TSC synchronization across 2 CPUs: passed.
Brought up 2 CPUs
CPU0:
 domain 0: span 3
  groups: 1 2
  domain 1: span 3
   groups: 3
CPU1:
 domain 0: span 3
  groups: 2 1
  domain 1: span 3
   groups: 3
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdb81, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20041210
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.ICHB._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 6 7 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
Machine check exception polling timer started.
highmem bounce pool size: 64 pages
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
vesafb: framebuffer at 0xe8000000, mapped to 0xf8880000, using 3072k, total 65536k
vesafb: mode is 1024x768x16, linelength=2048, pages=1
vesafb: protected mode interface info at c000:e9d0
vesafb: pmi: set display start = c00cea15, set palette = c00cea9a
vesafb: pmi: ports = b4c3 b503 ba03 c003 c103 c403 c503 c603 c703 c803 c903 cc03 ce03 cf03 d003 d103 d203 d303 d403 d503 da03 ff03
vesafb: scrolling: ypan using protected mode interface, yres_virtual=1536
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
ACPI: Processor [CPU1] (supports 8 throttling states)
ACPI: Processor [CPU2] (supports 8 throttling states)
Real Time Clock Driver v1.12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
io scheduler noop registered
io scheduler anticipatory registered
elevator: using anticipatory as default io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
e100: Intel(R) PRO/100 Network Driver, 3.2.3-k2-NAPI
e100: Copyright(c) 1999-2004 Intel Corporation
ACPI: PCI interrupt 0000:02:08.0[A] -> GSI 20 (level, low) -> IRQ 20
e100: eth0: e100_probe: addr 0xfeafe000, irq 20, MAC addr 00:0C:76:27:61:10
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xfc00-0xfc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xfc08-0xfc0f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: WDC WD600AB-00CDB0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: ST340015A, ATA DISK drive
hdd: LITEON DVD-ROM LTD163D, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes not supported
 hda: hda1
hdc: max request size: 128KiB
hdc: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hdc: cache flushes supported
 hdc: hdc1 hdc2 hdc3
hdd: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ACPI: PCI interrupt 0000:02:03.0[A] -> GSI 19 (level, low) -> IRQ 19
scsi0 : AdvanSys SCSI 3.3K: PCI Ultra: IO 0xB400-0xB40F, IRQ 0x13
  Vendor: YAMAHA    Model: CDR400t           Rev: 1.0q
  Type:   CD-ROM                             ANSI SCSI revision: 02
libata version 1.10 loaded.
ata_piix version 1.03
ACPI: PCI interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xEC00 ctl 0xE802 bmdma 0xDC00 irq 18
ata2: SATA max UDMA/133 cmd 0xE400 ctl 0xE002 bmdma 0xDC08 irq 18
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:207f
ata1: dev 0 ATA, max UDMA/133, 234441648 sectors: lba48
ata1: dev 0 configured for UDMA/133
scsi1 : ata_piix
ata2: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:207f
ata2: dev 0 ATA, max UDMA/133, 234441648 sectors: lba48
ata2: dev 0 configured for UDMA/133
scsi2 : ata_piix
  Vendor: ATA       Model: ST3120026AS       Rev: 3.05
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3120026AS       Rev: 3.05
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 234441648 512-byte hdwr sectors (120034 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2
Attached scsi disk sda at scsi1, channel 0, id 0, lun 0
SCSI device sdb: 234441648 512-byte hdwr sectors (120034 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 234441648 512-byte hdwr sectors (120034 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2
Attached scsi disk sdb at scsi2, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 6x/6x writer xa/form2 cdda tray
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 3, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 3, lun 0,  type 5
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg2 at scsi2, channel 0, id 0, lun 0,  type 0
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
md: linear personality registered as nr 1
md: raid1 personality registered as nr 3
md: multipath personality registered as nr 7
md: md driver 0.90.1 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
Starting balanced_irq
md: Autodetecting RAID arrays.
md: autorun ...
md: considering sdb2 ...
md:  adding sdb2 ...
md: sdb1 has different UUID to sdb2
md:  adding sda2 ...
md: sda1 has different UUID to sdb2
md: created md1
md: bind<sda2>
md: bind<sdb2>
md: running: <sdb2><sda2>
raid1: raid set md1 active with 2 out of 2 mirrors
md: considering sdb1 ...
md:  adding sdb1 ...
md:  adding sda1 ...
md: created md0
md: bind<sda1>
md: bind<sdb1>
md: running: <sdb1><sda1>
raid1: raid set md0 active with 2 out of 2 mirrors
md: ... autorun DONE.
ReiserFS: md0: found reiserfs format "3.6" with standard journal
ReiserFS: md0: using ordered data mode
ReiserFS: md0: journal params: device md0, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: md0: checking transaction log (md0)
ReiserFS: md0: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 208k freed
Adding 977248k swap on /dev/hdc2.  Priority:-1 extents:1
ReiserFS: md0: Removing [3426991 3426992 0x0 SD]..done
ReiserFS: md0: There were 1 uncompleted unlinks/truncates. Completed
ReiserFS: md1: found reiserfs format "3.6" with standard journal
ReiserFS: md1: using ordered data mode
ReiserFS: md1: journal params: device md1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: md1: checking transaction log (md1)
ReiserFS: md1: Using r5 hash to sort names
ReiserFS: hdc3: found reiserfs format "3.6" with standard journal
ReiserFS: hdc3: using ordered data mode
ReiserFS: hdc3: journal params: device hdc3, size 8192, journal first block 18,max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hdc3: checking transaction log (hdc3)
ReiserFS: hdc3: Using r5 hash to sort names
usbcore: registered new driver usbfs
usbcore: registered new driver hub
hdd: CHECK for good STATUS
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 17 (level, low) -> IRQ 17
USB Universal Host Controller Interface driver v2.2
ACPI: PCI interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.0: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: irq 16, io base 0xcc00
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
uhci_hcd 0000:00:1d.1: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: irq 19, io base 0xd000
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
uhci_hcd 0000:00:1d.2: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: irq 18, io base 0xd400
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
usb 1-1: new low speed USB device using uhci_hcd and address 2
ACPI: PCI interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 16
uhci_hcd 0000:00:1d.3: UHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: irq 16, io base 0xd800
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 1-2: new low speed USB device using uhci_hcd and address 3
ACPI: PCI interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
ehci_hcd 0000:00:1d.7: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: irq 23, pci mem 0xfebff800
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 26 Oct 2004
usbcore: registered new driver hiddev
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
usbhid: probe of 1-1:1.0 failed with error -5
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
usb 1-1: USB disconnect, address 2
nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-6629  Wed Nov  3 13:12:51 PST 2004
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ACPI: PCI interrupt 0000:02:01.2[B] -> GSI 18 (level, low) -> IRQ 18
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[18]  MMIO=[feaff000-feaff7ff]  Max Packet=[2048]
usb 5-3: new high speed USB device using ehci_hcd and address 4
Initializing USB Mass Storage driver...
usb 5-4: new high speed USB device using ehci_hcd and address 5
usb 5-5: new high speed USB device using ehci_hcd and address 6
scsi3 : SCSI emulation for USB Mass Storage devices
scsi4 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 5
usb-storage: waiting for device to settle before scanning
usb-storage: device found at 4
usb-storage: waiting for device to settle before scanning
scsi5 : SCSI emulation for USB Mass Storage devices
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usb-storage: device found at 6
usb-storage: waiting for device to settle before scanning
usb 1-1: new low speed USB device using uhci_hcd and address 4
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00023c0151028a1f]
input: USB HID v1.11 Mouse [Logitech USB Receiver] on usb-0000:00:1d.0-1
usb 1-2: new low speed USB device using uhci_hcd and address 5
input: USB HID v1.11 Keyboard [046a:0023] on usb-0000:00:1d.0-2
input: USB HID v1.11 Device [046a:0023] on usb-0000:00:1d.0-2
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
  Vendor: Lion      Model: BlueMedia         Rev: 4.70
  Type:   Direct-Access                      ANSI SCSI revision: 00
  Vendor: LITE-ON   Model: DVDRW LDW-851S    Rev: GS0K
  Type:   CD-ROM                             ANSI SCSI revision: 00
  Vendor: ExcelSto  Model: r Technology J88  Rev:  0 0
  Type:   Direct-Access                      ANSI SCSI revision: 00
sr1: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
Attached scsi CD-ROM sr1 at scsi3, channel 0, id 0, lun 0
Attached scsi generic sg3 at scsi3, channel 0, id 0, lun 0,  type 5
usb-storage: device scan complete
SCSI device sdc: 499200 512-byte hdwr sectors (256 MB)
sdc: Write Protect is off
sdc: Mode Sense: 45 00 00 08
sdc: assuming drive cache: write through
SCSI device sdc: 499200 512-byte hdwr sectors (256 MB)
sdc: Write Protect is off
sdc: Mode Sense: 45 00 00 08
sdc: assuming drive cache: write through
 sdc:
Attached scsi removable disk sdc at scsi4, channel 0, id 0, lun 0
SCSI device sdd: 160836480 512-byte hdwr sectors (82348 MB)
sdd: assuming drive cache: write through
Attached scsi generic sg4 at scsi4, channel 0, id 0, lun 0,  type 0
usb-storage: device scan complete
SCSI device sdd: 160836480 512-byte hdwr sectors (82348 MB)
sdd: assuming drive cache: write through
 sdd: sdd1
Attached scsi disk sdd at scsi5, channel 0, id 0, lun 0
Attached scsi generic sg5 at scsi5, channel 0, id 0, lun 0,  type 0
usb-storage: device scan complete
drivers/usb/input/hid-input.c: event field not found 

--Boundary-00=_e8Y2Bo3ycC+Ofnp--
