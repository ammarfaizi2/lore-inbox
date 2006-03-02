Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWCBBUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWCBBUL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 20:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWCBBUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 20:20:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:20418 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750799AbWCBBUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 20:20:07 -0500
Date: Wed, 1 Mar 2006 20:19:59 -0500
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       Ashok Raj <ashok.raj@intel.com>
Subject: Re: 2.6.16rc5 'found' an extra CPU.
Message-ID: <20060302011959.GC19755@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Ashok Raj <ashok.raj@intel.com>
References: <20060301224647.GD1440@redhat.com> <20060301230317.GF1440@redhat.com> <200603020155.46534.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603020155.46534.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 01:55:46AM +0100, Andi Kleen wrote:
 > On Thursday 02 March 2006 00:03, Dave Jones wrote:
 > > On Wed, Mar 01, 2006 at 05:46:47PM -0500, Dave Jones wrote:
 > >  > This amused me.
 > >  >
 > >  > (17:43:34:davej@nemesis:~)$ ll /proc/acpi/processor/
 > >  > total 0
 > >  > dr-xr-xr-x 2 root root 0 Mar  1 17:43 CPU1/
 > >  > dr-xr-xr-x 2 root root 0 Mar  1 17:43 CPU2/
 > >  > dr-xr-xr-x 2 root root 0 Mar  1 17:43 CPU3/
 > >  > (17:43:36:davej@nemesis:~)$
 > >
 > > Digging further. I notice more oddities (or maybe I've just
 > > misunderstood this -- corrections welcomed)
 > 
 > Probably related to Ashok's ACPI CPU hotplug patches.

Could be..

SMP: Allowing 4 CPUs, 2 hotplug CPUs

I thought we chopped out the heuristic to do NRCPUS/2 as hotplug?
(*checks*... yes, we did).
This machine isn't hotplug cpu capable (its an early tyan 2885)
so I'd be surprised if the bios is advertising that ability.

It looks like 'num_processors' is incorrect somehow.

 > What's the full bootup log?

below.
		Dave

Bootdata ok (command line is ro root=/dev/hda2 vga=791 profile=1)
Linux version 2.6.15-1.1990_FC5 (bhcompile@hs20-bc1-3.build.redhat.com) (gcc version 4.1.0 20060219 (Red Hat 4.1.0-0.29)) #1 SMP Mon Feb 27 02:51:40 EST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000e8ff0000 (usable)
 BIOS-e820: 00000000e8ff0000 - 00000000e8fff000 (ACPI data)
 BIOS-e820: 00000000e8fff000 - 00000000e9000000 (ACPI NVS)
 BIOS-e820: 00000000ff780000 - 0000000100000000 (reserved)
SRAT: PXM 0 -> APIC 0 -> Node 0
SRAT: PXM 1 -> APIC 1 -> Node 1
SRAT: Node 0 PXM 0 100000-80000000
SRAT: Node 1 PXM 1 80000000-e9000000
SRAT: Node 1 PXM 1 80000000-100000000
SRAT: Node 0 PXM 0 0-80000000
Bootmem setup node 0 0000000000000000-0000000080000000
Bootmem setup node 1 0000000080000000-00000000e8ff0000
ACPI: PM-Timer IO Port: 0x5008
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
Processor #0 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
Processor #1 15:5 APIC version 16
ACPI: LAPIC (acpi_id[0x03] lapic_id[0x82] disabled)
ACPI: LAPIC (acpi_id[0x04] lapic_id[0x83] disabled)
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
IOAPIC[0]: apic_id 2, version 17, address 0xfec00000, GSI 0-23
ACPI: IOAPIC (id[0x03] address[0xfd9ff000] gsi_base[24])
IOAPIC[1]: apic_id 3, version 17, address 0xfd9ff000, GSI 24-27
ACPI: IOAPIC (id[0x04] address[0xfd9fe000] gsi_base[28])
IOAPIC[2]: apic_id 4, version 17, address 0xfd9fe000, GSI 28-31
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
Setting APIC routing to physical flat
ACPI: HPET id: 0x102282a0 base: 0xfec01000
Using ACPI (MADT) for SMP configuration information
Allocating PCI resources starting at ea000000 (gap: e9000000:16780000)
Checking aperture...
CPU 0: aperture @ f0000000 size 128 MB
CPU 1: aperture @ f0000000 size 128 MB
SMP: Allowing 4 CPUs, 2 hotplug CPUs
Built 2 zonelists
Kernel command line: ro root=/dev/hda2 vga=791 profile=1
kernel profiling enabled (shift: 1)
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 131072 bytes)
time.c: Using 14.318180 MHz WALL HPET GTOD HPET timer.
time.c: Detected 1789.412 MHz processor.
Console: colour dummy device 80x25
Dentry cache hash table entries: 524288 (order: 10, 4194304 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Memory: 3740452k/3817408k available (2320k kernel code, 76568k reserved, 1212k data, 196k init)
Calibrating delay using timer specific routine.. 3585.35 BogoMIPS (lpj=7170702)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 0(1) -> Node 0 -> Core 0
Using local APIC timer interrupts.
result 12426477
Detected 12.426 MHz APIC timer.
Booting processor 1/2 APIC 0x1
Initializing CPU#1
Calibrating delay using timer specific routine.. 3578.59 BogoMIPS (lpj=7157190)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU 1(1) -> Node 1 -> Core 0
AMD Opteron(tm) Processor 244 stepping 08
CPU 1: Syncing TSC to CPU 0.
CPU 1: synchronized TSC with CPU 0 (last diff -8 cycles, maxerr 1033 cycles)
Brought up 2 CPUs
testing NMI watchdog ... OK.
migration_cost=467
checking if image is initramfs... it is
Freeing initrd memory: 1046k freed
DMI 2.3 present.
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
ACPI: PCI Root Bridge [PCIB] (0000:04)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 15 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
hpet0: at MMIO 0xfec01000 (virtual 0xffffffffff5fe000), IRQs 2, 8, 0
hpet0: 3 32-bit timers, 14318180 Hz
agpgart: Detected AMD 8151 AGP Bridge rev B2
agpgart: AGP aperture is 128M @ 0xf0000000
PCI-DMA: Disabling IOMMU.
pnp: 00:09: ioport range 0x680-0x6ff has been reserved
pnp: 00:09: ioport range 0x295-0x296 has been reserved
PCI: Bridge: 0000:00:06.0
  IO window: a000-bfff
  MEM window: fd700000-fd7fffff
  PREFETCH window: disabled.
PCI: Bridge: 0000:00:0a.0
  IO window: disabled.
  MEM window: fd800000-fd8fffff
  PREFETCH window: e9400000-e94fffff
PCI: Bridge: 0000:00:0b.0
  IO window: disabled.
  MEM window: disabled.
  PREFETCH window: disabled.
PCI: Bridge: 0000:04:01.0
  IO window: disabled.
  MEM window: fda00000-feafffff
  PREFETCH window: e9600000-ed5fffff
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
audit(1141045958.664:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
ksign: Installing public key data
Loading keyring
- Added public key 9A50E414E2E99FF
- User ID: Red Hat, Inc. (Kernel Module GPG key)
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
PCI: MSI quirk detected. pci_msi_quirk set.
PCI: MSI quirk detected. pci_msi_quirk set.
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
vesafb: framebuffer at 0xea000000, mapped to 0xffffc20000100000, using 3072k, total 32768k
vesafb: mode is 1024x768x16, linelength=2048, pages=9
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
ACPI: Processor [CPU1] (supports 8 throttling states)
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:06: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:07: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD8111: IDE controller at PCI slot 0000:00:07.1
AMD8111: chipset revision 3
AMD8111: not 100% native mode: will probe irqs later
AMD8111: 0000:00:07.1 (rev 03) UDMA133 controller
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
hda: ST340014A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: HL-DT-STDVD-ROM GDR8162B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
HPT370: IDE controller at PCI slot 0000:01:0a.0
GSI 16 sharing vector 0xA9 and IRQ 16
ACPI: PCI Interrupt 0000:01:0a.0[A] -> GSI 16 (level, low) -> IRQ 16
HPT370: chipset revision 3
HPT370: 100% native mode on irq 16
    ide2: BM-DMA at 0xa800-0xa807, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xa808-0xa80f, BIOS settings: hdg:pio, hdh:pio
hde: IC35L080AVVA07-0, ATA DISK drive
ide2 at 0xbc00-0xbc07,0xb802 on irq 16
hdg: IC35L080AVVA07-0, ATA DISK drive
ide3 at 0xb400-0xb407,0xb002 on irq 16
hda: max request size: 512KiB
hda: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3
hde: max request size: 128KiB
hde: 160836480 sectors (82348 MB) w/1863KiB Cache, CHS=65535/16/63, UDMA(100)
hde: cache flushes supported
 hde: hde1 hde2
hdg: max request size: 128KiB
hdg: 160836480 sectors (82348 MB) w/1863KiB Cache, CHS=65535/16/63, UDMA(100)
hdg: cache flushes supported
 hdg: hdg1 hdg2
hdc: ATAPI 48X DVD-ROM drive, 256kB Cache, UDMA(33)
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
IP route cache hash table entries: 131072 (order: 8, 1048576 bytes)
TCP established hash table entries: 131072 (order: 10, 4194304 bytes)
TCP bind hash table entries: 65536 (order: 9, 2097152 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
powernow-k8: Power state transitions not supported
powernow-k8: Power state transitions not supported
input: AT Translated Set 2 keyboard as /class/input/input0
ACPI wakeup devices: 
PCI1 USB0 USB1 PS2K UAR1 UAR2 GOLA GLAN GOLB SMBC AC97 MODM PWRB 
ACPI: (supports S0 S1 S4 S5)
Freeing unused kernel memory: 196k freed
Write protecting the kernel read-only data: 435k
SCSI subsystem initialized
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
security:  3 users, 6 roles, 1135 types, 133 bools, 1 sens, 256 cats
security:  55 classes, 37676 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev hda2, type ext3), uses xattr
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
ACPI: PCI Interrupt 0000:05:00.0[A] -> GSI 16 (level, low) -> IRQ 16
matroxfb: Matrox G550 detected
matroxfb: probe of 0000:05:00.0 failed with error -1
tg3.c:v3.49 (Feb 2, 2006)
GSI 17 sharing vector 0xB1 and IRQ 17
ACPI: PCI Interrupt 0000:02:09.0[A] -> GSI 24 (level, low) -> IRQ 17
eth0: Tigon3 [partno(BCM95703A30) rev 1002 PHY(5703)] (PCI:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:e0:81:29:93:fe
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
eth0: dma_rwctrl[763f0000]
GSI 18 sharing vector 0xB9 and IRQ 18
ACPI: PCI Interrupt 0000:01:00.0[D] -> GSI 19 (level, low) -> IRQ 18
ohci_hcd 0000:01:00.0: OHCI Host Controller
ohci_hcd 0000:01:00.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:01:00.0: irq 18, io mem 0xfd7de000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ACPI: PCI Interrupt 0000:01:00.1[D] -> GSI 19 (level, low) -> IRQ 18
ohci_hcd 0000:01:00.1: OHCI Host Controller
ohci_hcd 0000:01:00.1: new USB bus registered, assigned bus number 2
ohci_hcd 0000:01:00.1: irq 18, io mem 0xfd7df000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
GSI 19 sharing vector 0xC1 and IRQ 19
ACPI: PCI Interrupt 0000:02:07.0[A] -> GSI 26 (level, low) -> IRQ 19
ohci_hcd 0000:02:07.0: OHCI Host Controller
ohci_hcd 0000:02:07.0: new USB bus registered, assigned bus number 3
ohci_hcd 0000:02:07.0: irq 19, io mem 0xfd8fd000
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
usb 2-2: new low speed USB device using ohci_hcd and address 2
usb 2-2: configuration #1 chosen from 1 choice
input: Microsoft Microsoft 3-Button Mouse with IntelliEye(TM) as /class/input/input1
input: USB HID v1.10 Mouse [Microsoft Microsoft 3-Button Mouse with IntelliEye(TM)] on usb-0000:01:00.1-2
GSI 20 sharing vector 0xC9 and IRQ 20
ACPI: PCI Interrupt 0000:02:07.1[B] -> GSI 27 (level, low) -> IRQ 20
ohci_hcd 0000:02:07.1: OHCI Host Controller
ohci_hcd 0000:02:07.1: new USB bus registered, assigned bus number 4
ohci_hcd 0000:02:07.1: irq 20, io mem 0xfd8fe000
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:02:07.2[C] -> GSI 24 (level, low) -> IRQ 17
ehci_hcd 0000:02:07.2: EHCI Host Controller
ehci_hcd 0000:02:07.2: new USB bus registered, assigned bus number 5
ehci_hcd 0000:02:07.2: irq 17, io mem 0xfd8ffc00
ehci_hcd 0000:02:07.2: USB 2.0 started, EHCI 0.95, driver 10 Dec 2004
usb usb5: configuration #1 chosen from 1 choice
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 5 ports detected
GSI 21 sharing vector 0xD1 and IRQ 21
ACPI: PCI Interrupt 0000:00:07.5[B] -> GSI 17 (level, low) -> IRQ 21
intel8x0_measure_ac97_clock: measured 58085 usecs
intel8x0: clocking to 48000
hw_random: AMD768 system management I/O registers at 0x5000.
hw_random hardware driver 1.0.0 loaded
Non-volatile memory driver v1.2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
lp: driver loaded but no devices found
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
ibm_acpi: ec object not found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
md: md0 stopped.
md: bind<hdg2>
md: bind<hde2>
md: raid0 personality registered for level 0
md0: setting max_sectors to 128, segment boundary to 32767
raid0: looking at hde2
raid0:   comparing hde2(79440896) with hde2(79440896)
raid0:   END
raid0:   ==> UNIQUE
raid0: 1 zones
raid0: looking at hdg2
raid0:   comparing hdg2(79440896) with hde2(79440896)
raid0:   EQUAL
raid0: FINAL 1 zones
raid0: done.
raid0 : md_size is 158881792 blocks.
raid0 : conf->hash_spacing is 158881792 blocks.
raid0 : nb_zone is 1.
raid0 : Allocating 8 bytes for hash.
device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
EXT3 FS on hda2, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev hda1, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on md0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev md0, type ext3), uses xattr
audit(1141063982.492:2): avc:  denied  { write } for  pid=1421 comm="swapon" name="blkid.tab" dev=hda2 ino=3555770 scontext=system_u:system_r:fsadm_t:s0 tcontext=user_u:object_r:etc_t:s0 tclass=file
Adding 2040244k swap on /dev/hda3.  Priority:-1 extents:1 across:2040244k
audit(1141063982.508:3): avc:  denied  { write } for  pid=1421 comm="swapon" name="blkid.tab" dev=hda2 ino=3555770 scontext=system_u:system_r:fsadm_t:s0 tcontext=user_u:object_r:etc_t:s0 tclass=file
Adding 977216k swap on /dev/hde1.  Priority:-2 extents:1 across:977216k
audit(1141063982.528:4): avc:  denied  { write } for  pid=1421 comm="swapon" name="blkid.tab" dev=hda2 ino=3555770 scontext=system_u:system_r:fsadm_t:s0 tcontext=user_u:object_r:etc_t:s0 tclass=file
Adding 977216k swap on /dev/hdg1.  Priority:-3 extents:1 across:977216k
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses genfs_contexts
tg3: eth0: Link is up at 100 Mbps, full duplex.
tg3: eth0: Flow control is on for TX and on for RX.
SELinux: initialized (dev rpc_pipefs, type rpc_pipefs), uses genfs_contexts
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
SELinux: initialized (dev nfsd, type nfsd), uses genfs_contexts
NFSD: Using /var/lib/nfs/v4recovery as the NFSv4 state recovery directory
NFSD: unable to find recovery directory /var/lib/nfs/v4recovery
NFSD: starting 90-second grace period

