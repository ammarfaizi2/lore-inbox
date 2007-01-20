Return-Path: <linux-kernel-owner+w=401wt.eu-S1750726AbXATWdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbXATWdG (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 17:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbXATWdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 17:33:06 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:34803 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbXATWdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 17:33:04 -0500
From: Chr <chunkeey@web.de>
To: Robert Hancock <hancockr@shaw.ca>
Subject: Re: SATA exceptions with 2.6.20-rc5
Date: Sat, 20 Jan 2007 23:32:58 +0100
User-Agent: KMail/1.9.5
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Jeff Garzik <jeff@garzik.org>,
       =?utf-8?q?Bj=C3=B6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       linux-kernel@vger.kernel.org, htejun@gmail.com, jens.axboe@oracle.com,
       lwalton@real.com, chunkeey@web.de
References: <fa.hif5u4ZXua+b0mVNaWEcItWv9i0@ifi.uio.no> <200701191505.33480.s0348365@sms.ed.ac.uk> <45B18160.9020602@shaw.ca>
In-Reply-To: <45B18160.9020602@shaw.ca>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_aipsFDy4YjPjhY5"
Message-Id: <200701202332.58719.chunkeey@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_aipsFDy4YjPjhY5
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday, 20. January 2007 20:59, you wrote:
> Ian Kumlien wrote:
> > Hi,
> >
> > I went from 2.6.19+sata_nv-adma-ncq-v7.patch, with no problems and adama
> > enabled, to 2.6.20-rc5, which gave me problems almost instantly.
> >
> > I just thought that it might be interesting to know that it DID work
> > nicely.
> >
> > CC since i'm not on the ml
>
> (I'm ccing more of the people who reported this)
>
> Well that's interesting.. The only significant change that went into
> 2.6.20-rc5 in that driver that wasn't in that version you mentioned was
> this one:
>
> http://www2.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=com
>mit;h=2dec7555e6bf2772749113ea0ad454fcdb8cf861
>
> Could you (or anyone else) test what happens if you take the 2.6.20-rc5
> version of sata_nv.c and try it on 2.6.19? That would tell us whether
> it's this change or whether it's something else (i.e. in libata core).

Ok, did that! (got a fresh 2.6.19 tar ball, and used 2.6.20-rc5' sata_nv.c
with the oneliner in libata_sff.c)

And surprise.................... after one hour uptime, there is not even one 
sata exceptions in dmesg! (I'll report back tomorrow...)

>
> Assuming that still doesn't work, can you then try removing these lines
> from nv_host_intr in 2.6.20-rc5 sata_nv.c and see what that does?
>
> 	/* bail out if not our interrupt */
> 	if (!(irq_stat & NV_INT_DEV))
> 		return 0;
>
> as that's the difference I'm most suspicious of causing the problem.



--Boundary-00=_aipsFDy4YjPjhY5
Content-Type: text/plain;
  charset="iso-8859-15";
  name="kern.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="kern.log"

Linux version 2.6.19test (root@debian64) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #2 SMP PREEMPT Sat Jan 20 22:19:20 CET 2007
Command line: root=/dev/md1 ro
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
 BIOS-e820: 000000007fff0000 - 000000007fff3000 (ACPI NVS)
 BIOS-e820: 000000007fff3000 - 0000000080000000 (ACPI data)
 BIOS-e820: 00000000e0000000 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
Entering add_active_range(0, 0, 159) 0 entries of 256 used
Entering add_active_range(0, 256, 524272) 1 entries of 256 used
end_pfn_map = 1048576
DMI 2.3 present.
ACPI: RSDP (v000 Nvidia                                ) @ 0x00000000000f7d30
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000007fff3040
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000007fff30c0
ACPI: SSDT (v001 PTLTD  POWERNOW 0x00000001  LTP 0x00000001) @ 0x000000007fff9900
ACPI: SRAT (v001 AMD    HAMMER   0x00000001 AMD  0x00000001) @ 0x000000007fff9b40
ACPI: MCFG (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000007fff9c40
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x000000007fff9840
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x0000000000000000
Entering add_active_range(0, 0, 159) 0 entries of 256 used
Entering add_active_range(0, 256, 524272) 1 entries of 256 used
Zone PFN ranges:
  DMA             0 ->     4096
  DMA32        4096 ->  1048576
  Normal    1048576 ->  1048576
early_node_map[2] active PFN ranges
    0:        0 ->      159
    0:      256 ->   524272
On node 0 totalpages: 524175
  DMA zone: 56 pages used for memmap
  DMA zone: 10 pages reserved
  DMA zone: 3933 pages, LIFO batch:0
  DMA32 zone: 7111 pages used for memmap
  DMA32 zone: 513065 pages, LIFO batch:31
  Normal zone: 0 pages used for memmap
Nvidia board detected. Ignoring ACPI timer override.
If you got timer trouble try acpi_use_timer_override
ACPI: PM-Timer IO Port: 0x4008
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 (Bootup-CPU)
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1
ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
ACPI: IRQ9 used by override.
ACPI: IRQ14 used by override.
ACPI: IRQ15 used by override.
Setting APIC routing to physical flat
Using ACPI (MADT) for SMP configuration information
Nosave address range: 000000000009f000 - 00000000000a0000
Nosave address range: 00000000000a0000 - 00000000000f0000
Nosave address range: 00000000000f0000 - 0000000000100000
Allocating PCI resources starting at 88000000 (gap: 80000000:60000000)
SMP: Allowing 2 CPUs, 0 hotplug CPUs
PERCPU: Allocating 32320 bytes of per cpu data
Built 1 zonelists.  Total pages: 516998
Kernel command line: root=/dev/md1 ro
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 32768 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 262144 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 131072 (order: 8, 1048576 bytes)
Checking aperture...
CPU 0: aperture @ 1844000000 size 32 MB
Aperture too small (32 MB)
No AGP bridge found
Memory: 2059352k/2097088k available (3025k kernel code, 37076k reserved, 1382k data, 208k init)
Calibrating delay using timer specific routine.. 4425.39 BogoMIPS (lpj=8850788)
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 0
SMP alternatives: switching to UP code
ACPI: Core revision 20060707
Using local APIC timer interrupts.
result 12564452
Detected 12.564 MHz APIC timer.
SMP alternatives: switching to SMP code
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 4422.96 BogoMIPS (lpj=8845921)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU: Physical Processor ID: 0
CPU: Processor Core ID: 1
AMD Athlon(tm) 64 X2 Dual Core Processor 4200+ stepping 01
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff -1 cycles, maxerr 547 cycles)
Brought up 2 CPUs
testing NMI watchdog ... OK.
Disabling vsyscall due to use of PM timer
time.c: Using 3.579545 MHz WALL PM GTOD PM timer.
time.c: Detected 2211.339 MHz processor.
migration_cost=226
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using MMCONFIG at e0000000
PCI: No mmconfig possible on device 00:18
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:09.0
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs *3 4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 7 9 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 *4 5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 *7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LPCA] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22 23) *0, disabled.
ACPI: PCI Interrupt Link [APCP] (IRQs 20 21 22 23) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
SCSI subsystem initialized
libata version 2.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI-DMA: Disabling IOMMU.
pnp: 00:01: ioport range 0x4000-0x407f could not be reserved
pnp: 00:01: ioport range 0x4080-0x40ff has been reserved
pnp: 00:01: ioport range 0x4400-0x447f has been reserved
pnp: 00:01: ioport range 0x4480-0x44ff could not be reserved
pnp: 00:01: ioport range 0x4800-0x487f has been reserved
pnp: 00:01: ioport range 0x4880-0x48ff has been reserved
PCI: Bridge: 0000:00:09.0
  IO window: a000-afff
  MEM window: d0000000-d1ffffff
  PREFETCH window: 88000000-880fffff
PCI: Bridge: 0000:00:0b.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0c.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0d.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0e.0
  IO window: disabled.
  MEM window: c8000000-cfffffff
  PREFETCH window: c0000000-c7ffffff
PCI: Setting latency timer of device 0000:00:09.0 to 64
PCI: Setting latency timer of device 0000:00:0b.0 to 64
PCI: Setting latency timer of device 0000:00:0c.0 to 64
PCI: Setting latency timer of device 0000:00:0d.0 to 64
PCI: Setting latency timer of device 0000:00:0e.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 7, 524288 bytes)
TCP established hash table entries: 262144 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
audit: initializing netlink socket (disabled)
audit(1169328271.472:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
JFS: nTxBlock = 8192, nTxLock = 65536
SGI XFS with large block/inode numbers, no debug enabled
SGI XFS Quota Management subsystem
io scheduler noop registered
io scheduler cfq registered (default)
PCI: Linking AER extended capability on 0000:00:0b.0
PCI: Found HT MSI mapping on 0000:00:0b.0 with capability disabled
PCI: Found HT MSI mapping on 0000:00:00.0 with capability enabled
PCI: Linking AER extended capability on 0000:00:0c.0
PCI: Found HT MSI mapping on 0000:00:0c.0 with capability disabled
PCI: Found HT MSI mapping on 0000:00:00.0 with capability enabled
PCI: Linking AER extended capability on 0000:00:0d.0
PCI: Found HT MSI mapping on 0000:00:0d.0 with capability disabled
PCI: Found HT MSI mapping on 0000:00:00.0 with capability enabled
PCI: Linking AER extended capability on 0000:00:0e.0
PCI: Found HT MSI mapping on 0000:00:0e.0 with capability disabled
PCI: Found HT MSI mapping on 0000:00:00.0 with capability enabled
PCI: Setting latency timer of device 0000:00:0b.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0b.0:pcie00]
Allocate Port Service[0000:00:0b.0:pcie03]
PCI: Setting latency timer of device 0000:00:0c.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0c.0:pcie00]
Allocate Port Service[0000:00:0c.0:pcie03]
PCI: Setting latency timer of device 0000:00:0d.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0d.0:pcie00]
Allocate Port Service[0000:00:0d.0:pcie03]
PCI: Setting latency timer of device 0000:00:0e.0 to 64
pcie_portdrv_probe->Dev[005d:10de] has invalid IRQ. Check vendor BIOS
assign_interrupt_mode Found MSI capability
Allocate Port Service[0000:00:0e.0:pcie00]
Allocate Port Service[0000:00:0e.0:pcie03]
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing disabled
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 4 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
sata_nv 0000:00:07.0: version 3.2
ACPI: PCI Interrupt Link [APSI] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:07.0[A] -> Link [APSI] -> GSI 23 (level, low) -> IRQ 23
sata_nv 0000:00:07.0: Using ADMA mode
PCI: Setting latency timer of device 0000:00:07.0 to 64
ata1: SATA max UDMA/133 cmd 0xFFFFC20000028480 ctl 0xFFFFC200000284A0 bmdma 0xD800 irq 23
ata2: SATA max UDMA/133 cmd 0xFFFFC20000028580 ctl 0xFFFFC200000285A0 bmdma 0xD808 irq 23
scsi0 : sata_nv
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATAPI, max UDMA/33
ata1.00: configured for UDMA/33
scsi1 : sata_nv
ata2: SATA link down (SStatus 0 SControl 300)
scsi 0:0:0:0: CD-ROM            TSSTcorp CD/DVDW SH-S183L SB00 PQ: 0 ANSI: 5
ata1: bounce limit 0xFFFFFFFF, segment boundary 0xFFFF, hw segs 127
sr0: scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 0:0:0:0: Attached scsi CD-ROM sr0
sr 0:0:0:0: Attached scsi generic sg0 type 5
ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:08.0[A] -> Link [APSJ] -> GSI 22 (level, low) -> IRQ 22
sata_nv 0000:00:08.0: Using ADMA mode
PCI: Setting latency timer of device 0000:00:08.0 to 64
ata3: SATA max UDMA/133 cmd 0xFFFFC2000002A480 ctl 0xFFFFC2000002A4A0 bmdma 0xC400 irq 22
ata4: SATA max UDMA/133 cmd 0xFFFFC2000002A580 ctl 0xFFFFC2000002A5A0 bmdma 0xC408 irq 22
scsi2 : sata_nv
ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata3.00: ATA-7, max UDMA/133, 488395055 sectors: LBA48 
ata3.00: ata3: dev 0 multi count 1
ata3.00: configured for UDMA/133
scsi3 : sata_nv
ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata4.00: ATA-7, max UDMA/133, 490234752 sectors: LBA48 NCQ (depth 1)
ata4.00: ata4: dev 0 multi count 1
ata4.00: configured for UDMA/133
scsi 2:0:0:0: Direct-Access     ATA      WDC WD2500KS-00M 02.0 PQ: 0 ANSI: 5
ata3: bounce limit 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw segs 61
SCSI device sda: 488395055 512-byte hdwr sectors (250058 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 488395055 512-byte hdwr sectors (250058 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 sda8 sda9 sda10 sda11 sda12 >
sd 2:0:0:0: Attached scsi disk sda
sd 2:0:0:0: Attached scsi generic sg1 type 0
scsi 3:0:0:0: Direct-Access     ATA      WDC WD2500YD-01N 10.0 PQ: 0 ANSI: 5
ata4: bounce limit 0xFFFFFFFFFFFFFFFF, segment boundary 0xFFFFFFFF, hw segs 61
SCSI device sdb: 490234752 512-byte hdwr sectors (251000 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 490234752 512-byte hdwr sectors (251000 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 sdb3 < sdb5 sdb6 sdb7 sdb8 sdb9 sdb10 sdb11 sdb12 >
sd 3:0:0:0: Attached scsi disk sdb
sd 3:0:0:0: Attached scsi generic sg2 type 0
pata_amd 0000:00:06.0: version 0.2.4
PCI: Setting latency timer of device 0000:00:06.0 to 64
ata5: PATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0xF000 irq 14
ata6: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xF008 irq 15
scsi4 : pata_amd
ata5.00: ATA-6, max UDMA/100, 156299375 sectors: LBA48 
ata5.00: ata5: dev 0 multi count 1
ata5.00: configured for UDMA/100
scsi5 : pata_amd
ata6.00: ATAPI, max UDMA/33
ata6.00: configured for UDMA/33
scsi 4:0:0:0: Direct-Access     ATA      WDC WD800JB-00ET 77.0 PQ: 0 ANSI: 5
SCSI device sdc: 156299375 512-byte hdwr sectors (80025 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
SCSI device sdc: 156299375 512-byte hdwr sectors (80025 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
 sdc: sdc1 sdc2
sd 4:0:0:0: Attached scsi disk sdc
sd 4:0:0:0: Attached scsi generic sg3 type 0
scsi 5:0:0:0: CD-ROM            PIONEER  DVD-ROM DVD-105  1.33 PQ: 0 ANSI: 5
sr1: scsi3-mmc drive: 16x/40x cd/rw xa/form2 cdda tray
sr 5:0:0:0: Attached scsi CD-ROM sr1
sr 5:0:0:0: Attached scsi generic sg4 type 5
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
input: PC Speaker as /class/input/input0
input: AT Translated Set 2 keyboard as /class/input/input1
md: linear personality registered for level -1
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
md: raid10 personality registered for level 10
device-mapper: ioctl: 4.10.0-ioctl (2006-09-14) initialised: dm-devel@redhat.com
device-mapper: multipath: version 1.0.5 loaded
device-mapper: multipath round-robin: version 1.0.0 loaded
EDAC MC: Ver: 2.0.1 Jan 20 2007
TCP cubic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
ieee80211: 802.11 data/management/control stack, git-1.1.13
ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
ieee80211_crypt: registered algorithm 'NULL'
ieee80211_crypt: registered algorithm 'WEP'
ACPI: (supports S0 S1 S3 S4 S5)
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
md: Autodetecting RAID arrays.
md: autorun ...
[..]
raid1: raid set md0 active with 2 out of 2 mirrors
md: ... autorun DONE.
ReiserFS: md1: found reiserfs format "3.6" with standard journal
ReiserFS: md1: using ordered data mode
ReiserFS: md1: journal params: device md1, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: md1: checking transaction log (md1)
ReiserFS: md1: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 208k freed
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCL] -> GSI 21 (level, low) -> IRQ 21
PCI: Setting latency timer of device 0000:00:02.1 to 64
ehci_hcd 0000:00:02.1: EHCI Host Controller
ehci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:02.1: debug port 1
PCI: cache line size of 64 is not supported by device 0000:00:02.1
ehci_hcd 0000:00:02.1: irq 21, io mem 0xfeb00000
ehci_hcd 0000:00:02.1: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 10 ports detected
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 20 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.0: irq 20, io mem 0xd2003000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 10 ports detected
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.57.
ACPI: PCI Interrupt Link [APCH] enabled at IRQ 23
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APCH] -> GSI 23 (level, low) -> IRQ 23
PCI: Setting latency timer of device 0000:00:0a.0 to 64
forcedeth: using HIGHDMA
usb 2-4: new low speed USB device using ohci_hcd and address 2
usb 2-4: configuration #1 chosen from 1 choice
eth0: forcedeth.c: subsystem: 01043:8141 bound to 0000:00:0a.0
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x4c00
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x4c40
ieee1394: Initialized config rom entry `ip1394'
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
ACPI: PCI Interrupt 0000:05:0c.0[A] -> Link [APC2] -> GSI 17 (level, low) -> IRQ 17
skge 1.9 addr 0xd1004000 irq 17 chip Yukon-Lite rev 9
skge eth1: addr 00:15:f2:50:d7:70
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
ACPI: PCI Interrupt 0000:05:07.2[B] -> Link [APC3] -> GSI 18 (level, low) -> IRQ 18
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[18]  MMIO=[d100f000-d100f7ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
ACPI: PCI Interrupt Link [APC1] enabled at IRQ 16
ACPI: PCI Interrupt 0000:05:0b.0[A] -> Link [APC1] -> GSI 16 (level, low) -> IRQ 16
usbcore: registered new interface driver hiddev
input: Logitech USB-PS/2 Optical Mouse as /class/input/input2
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:02.0-4
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
ohci1394: fw-host1: OHCI-1394 1.1 (PCI): IRQ=[16]  MMIO=[d100e000-d100e7ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
ACPI: PCI Interrupt 0000:05:07.0[A] -> Link [APC2] -> GSI 17 (level, low) -> IRQ 17
Installing spdif_bug patch: Audigy 2 ZS [SB0350]
gameport: EMU10K1 is pci0000:05:07.1/gameport0, io 0xa400, speed 1205kHz
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00023c015112bb16]
eth1394: eth2: IEEE-1394 IPv4 over 1394 Ethernet (fw-host0)
eth1394: eth3: IEEE-1394 IPv4 over 1394 Ethernet (fw-host1)
ieee1394: Host added: ID:BUS[1-00:1023]  GUID[0011d800007ab4d6]
ieee1394: sbp2: Driver forced to serialize I/O (serialize_io=1)
ieee1394: sbp2: Try serialize_io=0 for better performance
it87: Found IT8712F chip at 0x290, revision 7
it87: in3 is VCC (+5V)
it87: in7 is VCCH (+5V Stand-By)
powernow-k8: Found 2 AMD Athlon(tm) 64 X2 Dual Core Processor 4200+ processors (version 2.00.00)
powernow-k8:    0 : fid 0xe (2200 MHz), vid 0x8
powernow-k8:    1 : fid 0xc (2000 MHz), vid 0xa
powernow-k8:    2 : fid 0xa (1800 MHz), vid 0xc
powernow-k8:    3 : fid 0x2 (1000 MHz), vid 0x12
usbcore: registered new interface driver usbmouse
drivers/usb/input/usbmouse.c: v1.6:USB HID Boot Protocol mouse driver
Initializing USB Mass Storage driver...
usbcore: registered new interface driver usb-storage
USB Mass Storage support registered.
sr1: CDROM not ready.  Make sure there is a disc in the drive.
[..]
Adding 1951888k swap on /dev/mapper/cswap1.  Priority:-1 extents:1 across:1951888k
Adding 1951888k swap on /dev/mapper/cswap2.  Priority:-2 extents:1 across:1951888k
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
eth0: no IPv6 routers present
lp: driver loaded but no devices found
ppdev: user-space parallel port driver
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: starting 90-second grace period
Bluetooth: Core ver 2.11
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.8
cdrom: sr0: mrw address space DMA selected
cdrom: sr0: mrw address space DMA selected
ISO 9660 Extensions: Microsoft Joliet Level 1
ISOFS: changing to secondary root
cdrom: sr0: mrw address space DMA selected
cdrom: sr0: mrw address space DMA selected
ISO 9660 Extensions: Microsoft Joliet Level 1
ISOFS: changing to secondary root


--Boundary-00=_aipsFDy4YjPjhY5--
