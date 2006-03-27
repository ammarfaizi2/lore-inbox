Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWC0AdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWC0AdY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 19:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWC0AdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 19:33:24 -0500
Received: from smtp1.Stanford.EDU ([171.67.16.123]:52427 "EHLO
	smtp1.Stanford.EDU") by vger.kernel.org with ESMTP id S932270AbWC0AdX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 19:33:23 -0500
Subject: Re: 2.6.15-rt21, BUG at net/ipv4/netfilter/ip_conntrack_core.c:124
From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
To: Ingo Molnar <mingo@elte.hu>
Cc: nando@ccrma.Stanford.EDU, linux-kernel@vger.kernel.org
In-Reply-To: <20060326231913.GA18750@elte.hu>
References: <1143339628.5527.3.camel@cmn2.stanford.edu>
	 <20060326163056.GC15667@elte.hu> <20060326163450.GA22411@elte.hu>
	 <1143404146.7768.18.camel@cmn3.stanford.edu>
	 <20060326231913.GA18750@elte.hu>
Content-Type: multipart/mixed; boundary="=-XPiqtSGJLhncObNTba8R"
Date: Sun, 26 Mar 2006 16:33:15 -0800
Message-Id: <1143419595.5404.5.camel@cmn2.stanford.edu>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-XPiqtSGJLhncObNTba8R
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2006-03-27 at 01:19 +0200, Ingo Molnar wrote:
> * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> 
> > On Sun, 2006-03-26 at 18:34 +0200, Ingo Molnar wrote:
> > > * Ingo Molnar <mingo@elte.hu> wrote:
> > > 
> > > > > Mar 23 15:22:48 host kernel: BUG at
> > > > > net/ipv4/netfilter/ip_conntrack_core.c:124!
> > > > 
> > > > does the patch below help?
> > > 
> > > updated patch below.
> > 
> > Thanks! I'll test later today. It may take a while to be reasonably 
> > sure whether it makes a difference. The hangs have not been frequent.
> > 
> > If I try a 2.6.16 based kernel, should I also use this patch?
> 
> not needed - it's included in -rt10. (-rt9 had it too but was buggy)

Oh well, I just experienced another complete hang, no traces left
behind, reset button was the only option :-( So most probably this
problem is unrelated to your fix. I'm including a dmesg of the
successful reboot just in case there is something there of use (I only
had to apply one chunk of your fix to arp_tables.c, the other raw_* was
already there, maybe included in 2.6.15.6?). 

Maybe I'll have to try 2.6.16...
-- Fernando


--=-XPiqtSGJLhncObNTba8R
Content-Disposition: attachment; filename=dmesg
Content-Type: text/plain; name=dmesg; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Linux version 2.6.15-1.1833.5.rrt.rhfc4.ccrmasmp (machbuild@planetforge.stanford.edu) (gcc version 4.0.2 20051125 (Red Hat 4.0.2-8)) #1 SMP PREEMPT Sun Mar 26 16:10:21 EST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007fff0000 (usable)
 BIOS-e820: 000000007fff0000 - 000000007fff3000 (ACPI NVS)
 BIOS-e820: 000000007fff3000 - 0000000080000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
1151MB HIGHMEM available.
896MB LOWMEM available.
found SMP MP-table at 000f4ee0
NX (Execute Disable) protection: active
On node 0 totalpages: 524272
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 294896 pages, LIFO batch:31
DMI 2.3 present.
Using APIC driver default
ACPI: RSDP (v000 Nvidia                                ) @ 0x000f6a20
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x7fff3000
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x7fff3040
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x01010101) @ 0x7fff78c0
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
ACPI: Local APIC enabled (0).
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 15:3 APIC version 16
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x01] enabled)
Processor #1 15:3 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] dfl dfl lint[0x1])
ACPI: LAPIC_NMI (acpi_id[0x01] dfl dfl lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: BIOS IRQ0 pin2 override ignored.
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: INT_SRC_OVR (bus 0 bus_irq 14 global_irq 14 high edge)
ACPI: INT_SRC_OVR (bus 0 bus_irq 15 global_irq 15 high edge)
ACPI: IRQ9 used by override.
ACPI: IRQ14 used by override.
ACPI: IRQ15 used by override.
Enabling APIC mode:  Flat.  Using 1 I/O APICs
LAPIC enabled (0), calling get_smp_config
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at 88000000 (gap: 80000000:7ec00000)
Detected 2210.745 MHz processor.
Real-Time Preemption Support (C) 2004-2005 Ingo Molnar
Built 1 zonelists
Kernel command line: ro root=LABEL=/1 rhgb quiet
mapped APIC to ffffd000 (fee00000)
mapped IOAPIC to ffffc000 (fec00000)
Initializing CPU#0
WARNING: experimental RCU implementation.
CPU 0 irqstacks, hard=c0475000 soft=c0455000
PID hash table entries: 4096 (order: 12, 65536 bytes)
Event source pit installed with caps set: 01
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 2057696k/2097088k available (2271k kernel code, 39004k reserved, 875k data, 232k init, 1179584k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 4422.77 BogoMIPS (lpj=2211387)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 178bfbff e3d3fbff 00000000 00000000 00000001 00000000 00000003
CPU: After vendor identify, caps: 178bfbff e3d3fbff 00000000 00000000 00000001 00000000 00000003
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(2) -> Core 0
CPU: After all inits, caps: 178bfbff e3d3fbff 00000000 00000010 00000001 00000000 00000003
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
CPU0: AMD Athlon(tm) 64 X2 Dual Core Processor 4400+ stepping 02
Booting processor 1/1 eip 3000
CPU 1 irqstacks, hard=c0476000 soft=c0456000
Initializing CPU#1
Calibrating delay using timer specific routine.. 4420.89 BogoMIPS (lpj=2210446)
CPU: After generic identify, caps: 178bfbff e3d3fbff 00000000 00000000 00000001 00000000 00000003
CPU: After vendor identify, caps: 178bfbff e3d3fbff 00000000 00000000 00000001 00000000 00000003
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(2) -> Core 1
CPU: After all inits, caps: 178bfbff e3d3fbff 00000000 00000010 00000001 00000000 00000003
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
CPU1: AMD Athlon(tm) 64 X2 Dual Core Processor 4400+ stepping 02
Total of 2 processors activated (8843.66 BogoMIPS).
ENABLING IO-APIC IRQs
..TIMER: vector=0x31 apic1=0 pin1=0 apic2=-1 pin2=-1
Event source lapic installed with caps set: 06
checking TSC synchronization across 2 CPUs: failed.
starting TSC synchronization
TSC synchronization complete max_delta=0 cycles
TSC sync round-trip time 0.225 microseconds
Event source lapic installed with caps set: 06
Brought up 2 CPUs
checking if image is initramfs... it is
Freeing initrd memory: 1175k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfb110, last bus=2
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: Power Resource [ISAV] (on)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LSID] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LFID] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [APC1] (IRQs 16) *0, disabled.
ACPI: PCI Interrupt Link [APC2] (IRQs 17) *0, disabled.
ACPI: PCI Interrupt Link [APC3] (IRQs 18) *0, disabled.
ACPI: PCI Interrupt Link [APC4] (IRQs 19) *0, disabled.
ACPI: PCI Interrupt Link [APC5] (IRQs *16), disabled.
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCS] (IRQs *23), disabled.
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APSI] (IRQs 20 21 22) *0, disabled.
ACPI: PCI Interrupt Link [APSJ] (IRQs 20 21 22) *0, disabled.
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
pnp: 00:00: ioport range 0x1000-0x107f could not be reserved
pnp: 00:00: ioport range 0x1080-0x10ff has been reserved
pnp: 00:00: ioport range 0x1400-0x147f has been reserved
pnp: 00:00: ioport range 0x1480-0x14ff could not be reserved
pnp: 00:00: ioport range 0x1800-0x187f has been reserved
pnp: 00:00: ioport range 0x1880-0x18ff has been reserved
PCI: Bridge: 0000:00:0b.0
  IO window: 8000-8fff
  MEM window: f2000000-f3ffffff
  PREFETCH window: e0000000-efffffff
PCI: Bridge: 0000:00:0e.0
  IO window: 9000-afff
  MEM window: f4000000-f5ffffff
  PREFETCH window: 88000000-880fffff
PCI: Setting latency timer of device 0000:00:0e.0 to 64
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
apm: disabled - APM is not SMP safe.
audit: initializing netlink socket (disabled)
audit(1143390143.028:1): initialized
highmem bounce pool size: 64 pages
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key 3FD05D7BD6CB3BE4
  - key was been created 15969 seconds in future
- User ID: Red Hat, Inc. (Kernel Module GPG key)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected AGP bridge 0
agpgart: Setting up Nforce3 AGP.
agpgart: AGP aperture is 32M @ 0xf0000000
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:09: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE3-250: IDE controller at PCI slot 0000:00:08.0
NFORCE3-250: chipset revision 162
NFORCE3-250: not 100% native mode: will probe irqs later
NFORCE3-250: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE3-250: 0000:00:08.0 (rev a2) UDMA133 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: SONY DVD RW DW-Q28A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
hda: ATAPI 48X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver libusual
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
NET: Registered protocol family 2
IP route cache hash table entries: 131072 (order: 7, 524288 bytes)
TCP established hash table entries: 65536 (order: 9, 2621440 bytes)
TCP bind hash table entries: 65536 (order: 9, 2359296 bytes)
TCP: Hash tables configured (established 65536 bind 65536)
TCP reno registered
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI No-Shortcut mode
ACPI wakeup devices: 
HUB0 HUB1 USB0 USB1 USB2 F139 MMAC MMCI UAR1 
ACPI: (supports S0 S1 S4 S5)
Freeing unused kernel memory: 232k freed
Write protecting the kernel read-only data: 354k
Time: tsc clocksource has been installed.
hrtimers: Switched to high resolution mode CPU 1
hrtimers: Switched to high resolution mode CPU 0
SCSI subsystem initialized
libata version 1.20 loaded.
sata_sil 0000:02:0d.0: version 0.9
ACPI: PCI Interrupt Link [APC2] enabled at IRQ 17
ACPI: PCI Interrupt 0000:02:0d.0[A] -> Link [APC2] -> GSI 17 (level, low) -> IRQ 177
ata1: SATA max UDMA/100 cmd 0xF881C080 ctl 0xF881C08A bmdma 0xF881C000 irq 177
ata2: SATA max UDMA/100 cmd 0xF881C0C0 ctl 0xF881C0CA bmdma 0xF881C008 irq 177
Time: acpi_pm clocksource has been installed.
hrtimers: Switched to high resolution mode CPU 1
hrtimers: Switched to high resolution mode CPU 0
ata1: SATA link down (SStatus 0)
scsi0 : sata_sil
ata2: SATA link down (SStatus 0)
scsi1 : sata_sil
sata_nv 0000:00:0a.0: version 0.8
ACPI: PCI Interrupt Link [APSJ] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [APSJ] -> GSI 22 (level, high) -> IRQ 185
PCI: Setting latency timer of device 0000:00:0a.0 to 64
ata3: SATA max UDMA/133 cmd 0x9F0 ctl 0xBF2 bmdma 0xD800 irq 185
ata4: SATA max UDMA/133 cmd 0x970 ctl 0xB72 bmdma 0xD808 irq 185
ata3: SATA link up 1.5 Gbps (SStatus 113)
ata3: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3468 86:3c01 87:4003 88:407f
ata3: dev 0 ATA-6, max UDMA/133, 156301488 sectors: LBA48
nv_sata: Primary device added
ata3: dev 0 configured for UDMA/133
scsi2 : sata_nv
nv_sata: Primary device removed
nv_sata: Secondary device removed
ata4: SATA link down (SStatus 0)
scsi3 : sata_nv
  Vendor: ATA       Model: ST380817AS        Rev: 3.42
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 >
sd 2:0:0:0: Attached scsi disk sda
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
EXT3-fs: recovery complete.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
security:  3 users, 6 roles, 889 types, 109 bools
security:  55 classes, 244452 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev sda1, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses genfs_contexts
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev eventpollfs, type eventpollfs), uses genfs_contexts
SELinux: initialized (dev inotifyfs, type inotifyfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
SELinux: initialized (dev cpuset, type cpuset), not configured for labeling
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
ACPI: PCI Interrupt Link [APC4] enabled at IRQ 19
ACPI: PCI Interrupt 0000:02:0b.0[A] -> Link [APC4] -> GSI 19 (level, low) -> IRQ 193
ACPI: PCI Interrupt 0000:02:0b.0[A] -> Link [APC4] -> GSI 19 (level, low) -> IRQ 193
eth0: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
      PrefPort:A  RlmtMode:Check Link State
ACPI: PCI Interrupt Link [APC3] enabled at IRQ 18
ACPI: PCI Interrupt 0000:02:0a.0[A] -> Link [APC3] -> GSI 18 (level, low) -> IRQ 201
ALSA /usr/src/rpm/BUILD/alsa-driver-1.0.10/pci/rme9652/../../alsa-kernel/pci/rme9652/hdsp.c:4952: Hammerfall-DSP: Firmware already present, initializing card.
ALSA /usr/src/rpm/BUILD/alsa-driver-1.0.10/acore/init.c:106: cannot find the slot for index 0 (range 0-0)
Intel ICH: probe of 0000:00:06.0 failed with error -12
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x1c00
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x2000
ACPI: PCI Interrupt Link [APCL] enabled at IRQ 21
ACPI: PCI Interrupt 0000:00:02.2[C] -> Link [APCL] -> GSI 21 (level, high) -> IRQ 209
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: EHCI Host Controller
ehci_hcd 0000:00:02.2: debug port 1
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:02.2: irq 209, io mem 0xf6005000
ehci_hcd 0000:00:02.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 8 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [APCF] enabled at IRQ 20
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [APCF] -> GSI 20 (level, high) -> IRQ 217
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.0: irq 217, io mem 0xf6003000
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 4 ports detected
ACPI: PCI Interrupt Link [APCG] enabled at IRQ 22
ACPI: PCI Interrupt 0000:00:02.1[B] -> Link [APCG] -> GSI 22 (level, high) -> IRQ 185
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: OHCI Host Controller
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:02.1: irq 185, io mem 0xf6004000
usb 2-3: new low speed USB device using ohci_hcd and address 2
input: Logitech USB-PS/2 Optical Mouse as /class/input/input0
input: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:02.0-3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 4 ports detected
ieee1394: Initialized config rom entry `ip1394'
ohci1394: $Rev: 1313 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt 0000:02:0e.0[A] -> Link [APC3] -> GSI 18 (level, low) -> IRQ 201
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[201]  MMIO=[f5018000-f50187ff]  Max Packet=[4096]
usb 3-3: new low speed USB device using ohci_hcd and address 2
input: Logitech Logitech USB Keyboard as /class/input/input1
input: USB HID v1.10 Keyboard [Logitech Logitech USB Keyboard] on usb-0000:00:02.1-3
input: Logitech Logitech USB Keyboard as /class/input/input2
input: USB HID v1.10 Device [Logitech Logitech USB Keyboard] on usb-0000:00:02.1-3
SELinux: initialized (dev ramfs, type ramfs), uses genfs_contexts
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000fea560057330b]
eth0: network connection up using port A
    speed:           1000
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    role:            slave
    irq moderation:  disabled
    scatter-gather:  enabled
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ibm_acpi: ec object not found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
cdrom: open failed.
cdrom: open failed.
EXT3 FS on sda1, internal journal
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev sda5, type ext3), uses xattr
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev sda2, type ext3), uses xattr
Adding 2048276k swap on /dev/sda3.  Priority:-1 extents:1 across:2048276k
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses genfs_contexts
SELinux: initialized (dev rpc_pipefs, type rpc_pipefs), uses genfs_contexts
Bluetooth: Core ver 2.8
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.6
SELinux: initialized (dev 0:16, type nfs), uses genfs_contexts
eth0: no IPv6 routers present
ip_tables: (C) 2000-2002 Netfilter core team
Netfilter messages via NETLINK v0.30.
ip_conntrack version 2.4 (8192 buckets, 65536 max) - 232 bytes per conntrack
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
ipt_owner: pid, sid and command matching not supported anymore
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
lp0: using parport0 (interrupt-driven).
lp0: console ready
SELinux: initialized (dev 0:18, type nfs), uses genfs_contexts
SELinux: initialized (dev 0:19, type nfs), uses genfs_contexts
[drm] Initialized drm 1.0.0 20040925
ACPI: PCI Interrupt Link [APC5] enabled at IRQ 16
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [APC5] -> GSI 16 (level, low) -> IRQ 225
[drm] Initialized radeon 1.19.0 20050911 on minor 0: 
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 4x mode
[drm] Loading R200 Microcode
SELinux: initialized (dev 0:1a, type nfs), uses genfs_contexts
SELinux: initialized (dev 0:12, type nfs), uses genfs_contexts
SELinux: initialized (dev 0:1b, type nfs), uses genfs_contexts
WARNING: sbcl/5362 changed soft IRQ-flags.
 [<c01411c2>] local_irq_enable+0x16/0x29 (8)
 [<c0335a99>] do_int3+0x7f/0x81 (8)
 [<c03356a2>] int3+0x1e/0x24 (48)

--=-XPiqtSGJLhncObNTba8R--

