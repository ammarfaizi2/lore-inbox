Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751639AbWBMF1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751639AbWBMF1l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 00:27:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbWBMF1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 00:27:40 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:62753 "EHLO
	pd3mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751639AbWBMF1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 00:27:39 -0500
Date: Sun, 12 Feb 2006 23:26:39 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Compaq X1050 multiple suspend problems (ACPI, PS2)
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43F0188F.2050007@shaw.ca>
MIME-version: 1.0
Content-type: multipart/mixed; boundary=------------020709070202050206080601
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020709070202050206080601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

The following is with a Compaq Presario X1050, Fedora Core 4 and Fedora 
kernel version 2.6.15-1.1831_FC4.

I'm trying to get suspend working on this laptop. It kind of works with 
a script which does

echo -n mem > /sys/power/state

to do the suspend, with calls in the suspend/restore to use vbetool to 
save/restore the video state and re-POST the video after resume. 
However, the keyboard was behaving wonky after resume (losing 
characters) and ACPI seems unhappy.

The full kernel output from boot, suspend and resume is attached. Note 
the "sleeping function called from invalid context" warning out of the 
ACPI code, the method execution failures in ACPI and synchronization 
errors from the psmouse and keyboard drivers.

I can provide some further info or debugging tests if desired.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/


--------------020709070202050206080601
Content-Type: text/plain;
 name="messages.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="messages.txt"

Feb 12 23:08:12 localhost kernel: klogd 1.4.1, log source = /proc/kmsg started.
Feb 12 23:08:12 localhost kernel: Linux version 2.6.15-1.1831_FC4custom (rob@Banias) (gcc version 4.0.2 20051125 (Red Hat 4.0.2-8)) #1 Thu Feb 9 20:54:19 CST 2006
Feb 12 23:08:12 localhost kernel: BIOS-provided physical RAM map:
Feb 12 23:08:12 localhost kernel:  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
Feb 12 23:08:12 localhost kernel:  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
Feb 12 23:08:12 localhost kernel:  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
Feb 12 23:08:12 localhost kernel:  BIOS-e820: 0000000000100000 - 000000001ffd0000 (usable)
Feb 12 23:08:12 localhost kernel:  BIOS-e820: 000000001ffd0000 - 000000001fff0c00 (reserved)
Feb 12 23:08:12 localhost kernel:  BIOS-e820: 000000001fff0c00 - 000000001fffc000 (ACPI NVS)
Feb 12 23:08:12 localhost kernel:  BIOS-e820: 000000001fffc000 - 0000000020000000 (reserved)
Feb 12 23:08:12 localhost kernel: 511MB LOWMEM available.
Feb 12 23:08:12 localhost kernel: Using x86 segment limits to approximate NX protection
Feb 12 23:08:13 localhost kernel: DMI 2.3 present.
Feb 12 23:08:13 localhost kernel: ACPI: PM-Timer IO Port: 0x1008
Feb 12 23:08:13 localhost kernel: ACPI: Local APIC disabled (-2); pass 'lapic' to re-enable.
Feb 12 23:08:13 localhost kernel: Allocating PCI resources starting at 30000000 (gap: 20000000:e0000000)
Feb 12 23:08:13 localhost kernel: Built 1 zonelists
Feb 12 23:08:13 localhost kernel: Kernel command line: ro root=LABEL=/
Feb 12 23:08:13 localhost kernel: Initializing CPU#0
Feb 12 23:08:13 localhost kernel: CPU 0 irqstacks, hard=c0452000 soft=c0451000
Feb 12 23:08:13 localhost kernel: PID hash table entries: 2048 (order: 11, 32768 bytes)
Feb 12 23:08:13 localhost kernel: Detected 1395.686 MHz processor.
Feb 12 23:08:13 localhost kernel: Using pmtmr for high-res timesource
Feb 12 23:08:13 localhost kernel: Console: colour VGA+ 80x25
Feb 12 23:08:13 localhost kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Feb 12 23:08:13 localhost kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Feb 12 23:08:13 localhost kernel: Memory: 513748k/524096k available (2386k kernel code, 9752k reserved, 776k data, 208k init, 0k highmem)
Feb 12 23:08:13 localhost kernel: Checking if this processor honours the WP bit even in supervisor mode... Ok.
Feb 12 23:08:13 localhost kernel: Calibrating delay using timer specific routine.. 2793.59 BogoMIPS (lpj=5587186)
Feb 12 23:08:13 localhost kernel: Security Framework v1.0.0 initialized
Feb 12 23:08:13 localhost kernel: SELinux:  Initializing.
Feb 12 23:08:13 localhost kernel: SELinux:  Starting in permissive mode
Feb 12 23:08:13 localhost kernel: selinux_register_security:  Registering secondary module capability
Feb 12 23:08:14 localhost kernel: Capability LSM initialized as secondary
Feb 12 23:08:14 localhost kernel: Mount-cache hash table entries: 512
Feb 12 23:08:14 localhost kernel: CPU: L1 I cache: 32K, L1 D cache: 32K
Feb 12 23:08:14 localhost kernel: CPU: L2 cache: 1024K
Feb 12 23:08:14 localhost kernel: Intel machine check architecture supported.
Feb 12 23:08:14 localhost kernel: Intel machine check reporting enabled on CPU#0.
Feb 12 23:08:14 localhost kernel: mtrr: v2.0 (20020519)
Feb 12 23:08:14 localhost kernel: CPU: Intel(R) Pentium(R) M processor 1400MHz stepping 05
Feb 12 23:08:14 localhost kernel: Enabling fast FPU save and restore... done.
Feb 12 23:08:14 localhost kernel: Enabling unmasked SIMD FPU exception support... done.
Feb 12 23:08:14 localhost kernel: Checking 'hlt' instruction... OK.
Feb 12 23:08:14 localhost kernel: ACPI: setting ELCR to 0200 (from 0c20)
Feb 12 23:08:14 localhost kernel: checking if image is initramfs... it is
Feb 12 23:08:14 localhost kernel: Freeing initrd memory: 1072k freed
Feb 12 23:08:14 localhost kernel: NET: Registered protocol family 16
Feb 12 23:08:14 localhost kernel: ACPI: bus type pci registered
Feb 12 23:08:14 localhost kernel: PCI: PCI BIOS revision 2.10 entry at 0xf031f, last bus=3
Feb 12 23:08:14 localhost kernel: PCI: Using configuration type 1
Feb 12 23:08:14 localhost kernel: ACPI: Subsystem revision 20050902
Feb 12 23:08:14 localhost kernel: ACPI: Interpreter enabled
Feb 12 23:08:14 localhost kernel: ACPI: Using PIC for interrupt routing
Feb 12 23:08:14 localhost kernel: ACPI: PCI Root Bridge [C046] (0000:00)
Feb 12 23:08:14 localhost kernel: ACPI: Assume root bridge [\_SB_.C046] bus is 0
Feb 12 23:08:15 localhost kernel: PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
Feb 12 23:08:15 localhost kernel: PCI quirk: region 1100-113f claimed by ICH4 GPIO
Feb 12 23:08:15 localhost kernel: PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Feb 12 23:08:15 localhost kernel: PCI: Transparent bridge - 0000:00:1e.0
Feb 12 23:08:15 localhost kernel: ACPI: Embedded Controller [C0EA] (gpe 28)
Feb 12 23:08:15 localhost kernel: ACPI: Power Resource [C18D] (on)
Feb 12 23:08:15 localhost kernel: ACPI: Power Resource [C195] (on)
Feb 12 23:08:15 localhost kernel: ACPI: Power Resource [C19C] (on)
Feb 12 23:08:15 localhost kernel: ACPI: Power Resource [C1A6] (on)
Feb 12 23:08:15 localhost kernel: ACPI: PCI Interrupt Link [C0C2] (IRQs 5 *10)
Feb 12 23:08:15 localhost kernel: ACPI: PCI Interrupt Link [C0C3] (IRQs 5 *10)
Feb 12 23:08:15 localhost kernel: ACPI: PCI Interrupt Link [C0C4] (IRQs *5 10)
Feb 12 23:08:15 localhost kernel: ACPI: PCI Interrupt Link [C0C5] (IRQs *5 10)
Feb 12 23:08:15 localhost kernel: ACPI: PCI Interrupt Link [C0C6] (IRQs 5 10) *0, disabled.
Feb 12 23:08:15 localhost kernel: ACPI: PCI Interrupt Link [C0C7] (IRQs 5 10) *11
Feb 12 23:08:15 localhost kernel: ACPI: PCI Interrupt Link [C0C8] (IRQs 5 10) *0, disabled.
Feb 12 23:08:16 localhost kernel: ACPI: PCI Interrupt Link [C0C9] (IRQs *5 10)
Feb 12 23:08:16 localhost kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Feb 12 23:08:16 localhost kernel: pnp: PnP ACPI init
Feb 12 23:08:16 localhost kernel: pnp: PnP ACPI: found 15 devices
Feb 12 23:08:16 localhost kernel: usbcore: registered new driver usbfs
Feb 12 23:08:16 localhost kernel: usbcore: registered new driver hub
Feb 12 23:08:16 localhost kernel: PCI: Using ACPI for IRQ routing
Feb 12 23:08:16 localhost kernel: PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
Feb 12 23:08:16 localhost kernel: pnp: 00:0d: ioport range 0x4d0-0x4d1 has been reserved
Feb 12 23:08:17 localhost kernel: pnp: 00:0d: ioport range 0x1000-0x107f could not be reserved
Feb 12 23:08:17 localhost kernel: pnp: 00:0d: ioport range 0x1100-0x113f has been reserved
Feb 12 23:08:17 localhost kernel: pnp: 00:0d: ioport range 0x1200-0x121f has been reserved
Feb 12 23:08:17 localhost kernel: PCI: Bridge: 0000:00:01.0
Feb 12 23:08:17 localhost kernel:   IO window: 3000-3fff
Feb 12 23:08:17 localhost kernel:   MEM window: 90400000-904fffff
Feb 12 23:08:17 localhost kernel:   PREFETCH window: 98000000-9fffffff
Feb 12 23:08:17 localhost kernel: PCI: Bus 3, cardbus bridge: 0000:02:04.0
Feb 12 23:08:17 localhost kernel:   IO window: 00002800-000028ff
Feb 12 23:08:17 localhost kernel:   IO window: 00002c00-00002cff
Feb 12 23:08:17 localhost kernel:   PREFETCH window: 30000000-31ffffff
Feb 12 23:08:17 localhost kernel:   MEM window: 34000000-35ffffff
Feb 12 23:08:17 localhost kernel: PCI: Bridge: 0000:00:1e.0
Feb 12 23:08:17 localhost kernel:   IO window: 2000-2fff
Feb 12 23:08:17 localhost kernel:   MEM window: 90000000-903fffff
Feb 12 23:08:17 localhost kernel:   PREFETCH window: 30000000-31ffffff
Feb 12 23:08:17 localhost kernel: ACPI: PCI Interrupt Link [C0C4] enabled at IRQ 5
Feb 12 23:08:18 localhost kernel: PCI: setting IRQ 5 as level-triggered
Feb 12 23:08:18 localhost kernel: ACPI: PCI Interrupt 0000:02:04.0[A] -> Link [C0C4] -> GSI 5 (level, low) -> IRQ 5
Feb 12 23:08:18 localhost kernel: apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
Feb 12 23:08:18 localhost kernel: apm: overridden by ACPI.
Feb 12 23:08:18 localhost kernel: audit: initializing netlink socket (disabled)
Feb 12 23:08:18 localhost kernel: audit(1139785660.024:1): initialized
Feb 12 23:08:18 localhost kernel: Total HugeTLB memory allocated, 0
Feb 12 23:08:18 localhost kernel: VFS: Disk quotas dquot_6.5.1
Feb 12 23:08:18 localhost kernel: Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Feb 12 23:08:18 localhost kernel: SELinux:  Registering netfilter hooks
Feb 12 23:08:18 localhost kernel: Initializing Cryptographic API
Feb 12 23:08:18 localhost kernel: ksign: Installing public key data
Feb 12 23:08:18 localhost kernel: Loading keyring
Feb 12 23:08:18 localhost kernel: io scheduler noop registered
Feb 12 23:08:18 localhost kernel: io scheduler anticipatory registered
Feb 12 23:08:18 localhost kernel: io scheduler deadline registered
Feb 12 23:08:18 localhost kernel: io scheduler cfq registered
Feb 12 23:08:19 localhost kernel: pci_hotplug: PCI Hot Plug PCI Core version: 0.5
Feb 12 23:08:19 localhost kernel: ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
Feb 12 23:08:19 localhost kernel: ACPI: Processor [CPU0] (supports 8 throttling states)
Feb 12 23:08:19 localhost kernel: isapnp: Scanning for PnP cards...
Feb 12 23:08:19 localhost kernel: isapnp: No Plug & Play device found
Feb 12 23:08:19 localhost kernel: Real Time Clock Driver v1.12
Feb 12 23:08:19 localhost kernel: Linux agpgart interface v0.101 (c) Dave Jones
Feb 12 23:08:19 localhost kernel: agpgart: Detected an Intel 855PM Chipset.
Feb 12 23:08:19 localhost kernel: agpgart: AGP aperture is 256M @ 0xb0000000
Feb 12 23:08:19 localhost kernel: PNP: PS/2 Controller [PNP0303:C1A3,PNP0f13:C1A4] at 0x60,0x64 irq 1,12
Feb 12 23:08:19 localhost kernel: i8042.c: Detected active multiplexing controller, rev 1.1.
Feb 12 23:08:19 localhost kernel: serio: i8042 AUX0 port at 0x60,0x64 irq 12
Feb 12 23:08:19 localhost kernel: serio: i8042 AUX1 port at 0x60,0x64 irq 12
Feb 12 23:08:19 localhost kernel: serio: i8042 AUX2 port at 0x60,0x64 irq 12
Feb 12 23:08:19 localhost kernel: serio: i8042 AUX3 port at 0x60,0x64 irq 12
Feb 12 23:08:19 localhost kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Feb 12 23:08:19 localhost kernel: Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
Feb 12 23:08:20 localhost kernel: serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Feb 12 23:08:20 localhost kernel: serial8250: ttyS2 at I/O 0x3e8 (irq = 3) is a 16550A
Feb 12 23:08:20 localhost kernel: 00:03: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Feb 12 23:08:20 localhost kernel: ACPI: PCI Interrupt Link [C0C3] enabled at IRQ 10
Feb 12 23:08:20 localhost kernel: PCI: setting IRQ 10 as level-triggered
Feb 12 23:08:20 localhost kernel: ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [C0C3] -> GSI 10 (level, low) -> IRQ 10
Feb 12 23:08:20 localhost kernel: ACPI: PCI interrupt for device 0000:00:1f.6 disabled
Feb 12 23:08:20 localhost kernel: RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Feb 12 23:08:20 localhost kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Feb 12 23:08:20 localhost kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Feb 12 23:08:20 localhost kernel: ICH4: IDE controller at PCI slot 0000:00:1f.1
Feb 12 23:08:20 localhost kernel: PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
Feb 12 23:08:20 localhost kernel: ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [C0C4] -> GSI 5 (level, low) -> IRQ 5
Feb 12 23:08:21 localhost kernel: ICH4: chipset revision 1
Feb 12 23:08:21 localhost kernel: ICH4: not 100% native mode: will probe irqs later
Feb 12 23:08:21 localhost kernel:     ide0: BM-DMA at 0x4c40-0x4c47, BIOS settings: hda:DMA, hdb:pio
Feb 12 23:08:21 localhost kernel:     ide1: BM-DMA at 0x4c48-0x4c4f, BIOS settings: hdc:DMA, hdd:pio
Feb 12 23:08:21 localhost kernel: hda: SAMSUNG MP0804H, ATA DISK drive
Feb 12 23:08:21 localhost kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Feb 12 23:08:21 localhost kernel: hdc: QSI CD-RW/DVD-ROM SBW-241, ATAPI CD/DVD-ROM drive
Feb 12 23:08:21 localhost kernel: ide1 at 0x170-0x177,0x376 on irq 15
Feb 12 23:08:21 localhost kernel: hda: max request size: 1024KiB
Feb 12 23:08:21 localhost kernel: hda: 156368016 sectors (80060 MB) w/8192KiB Cache, CHS=16383/255/63, UDMA(100)
Feb 12 23:08:21 localhost kernel: hda: cache flushes supported
Feb 12 23:08:21 localhost kernel:  hda: hda1 hda2 hda3 hda4 < hda5 >
Feb 12 23:08:21 localhost kernel: hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Feb 12 23:08:21 localhost kernel: Uniform CD-ROM driver Revision: 3.20
Feb 12 23:08:21 localhost kernel: ide-floppy driver 0.99.newide
Feb 12 23:08:21 localhost kernel: usbcore: registered new driver libusual
Feb 12 23:08:21 localhost kernel: usbcore: registered new driver hiddev
Feb 12 23:08:21 localhost kernel: usbcore: registered new driver usbhid
Feb 12 23:08:21 localhost kernel: drivers/usb/input/hid-core.c: v2.6:USB HID core driver
Feb 12 23:08:21 localhost kernel: mice: PS/2 mouse device common for all mice
Feb 12 23:08:22 localhost kernel: md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
Feb 12 23:08:22 localhost kernel: md: bitmap version 4.39
Feb 12 23:08:22 localhost kernel: NET: Registered protocol family 2
Feb 12 23:08:22 localhost kernel: input: AT Translated Set 2 keyboard as /class/input/input0
Feb 12 23:08:22 localhost kernel: IP route cache hash table entries: 8192 (order: 3, 32768 bytes)
Feb 12 23:08:22 localhost kernel: TCP established hash table entries: 32768 (order: 7, 524288 bytes)
Feb 12 23:08:22 localhost kernel: TCP bind hash table entries: 32768 (order: 7, 655360 bytes)
Feb 12 23:08:22 localhost kernel: TCP: Hash tables configured (established 32768 bind 32768)
Feb 12 23:08:22 localhost kernel: TCP reno registered
Feb 12 23:08:22 localhost kernel: TCP bic registered
Feb 12 23:08:22 localhost kernel: Initializing IPsec netlink socket
Feb 12 23:08:22 localhost kernel: NET: Registered protocol family 1
Feb 12 23:08:22 localhost kernel: NET: Registered protocol family 17
Feb 12 23:08:22 localhost kernel: Using IPI Shortcut mode
Feb 12 23:08:22 localhost kernel: ACPI wakeup devices: 
Feb 12 23:08:22 localhost kernel: C058 C1AD C1A3 C1A4 C0AC C0B3 C0B4 C0B5 C0E7 C136 
Feb 12 23:08:22 localhost kernel: ACPI: (supports S0 S3 S4 S5)
Feb 12 23:08:22 localhost kernel: Freeing unused kernel memory: 208k freed
Feb 12 23:08:22 localhost kernel: Write protecting the kernel read-only data: 336k
Feb 12 23:08:22 localhost kernel: EXT3-fs: INFO: recovery required on readonly filesystem.
Feb 12 23:08:22 localhost kernel: EXT3-fs: write access will be enabled during recovery.
Feb 12 23:08:22 localhost kernel: kjournald starting.  Commit interval 5 seconds
Feb 12 23:08:22 localhost kernel: EXT3-fs: hda5: orphan cleanup on readonly fs
Feb 12 23:08:22 localhost kernel: EXT3-fs: hda5: 1 orphan inode deleted
Feb 12 23:08:22 localhost kernel: EXT3-fs: recovery complete.
Feb 12 23:08:22 localhost kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb 12 23:08:22 localhost kernel: Synaptics Touchpad, model: 1, fw: 5.9, id: 0x236eb3, caps: 0x904713/0x10008
Feb 12 23:08:22 localhost kernel: input: SynPS/2 Synaptics TouchPad as /class/input/input1
Feb 12 23:08:22 localhost kernel: security:  3 users, 6 roles, 878 types, 101 bools
Feb 12 23:08:22 localhost kernel: security:  55 classes, 239681 rules
Feb 12 23:08:22 localhost kernel: SELinux:  Completing initialization.
Feb 12 23:08:22 localhost kernel: SELinux:  Setting up existing superblocks.
Feb 12 23:08:22 localhost kernel: SELinux: initialized (dev hda5, type ext3), uses xattr
Feb 12 23:08:22 localhost kernel: SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
Feb 12 23:08:22 localhost kernel: SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
Feb 12 23:08:22 localhost kernel: SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
Feb 12 23:08:22 localhost kernel: SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
Feb 12 23:08:22 localhost kernel: SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses genfs_contexts
Feb 12 23:08:22 localhost kernel: SELinux: initialized (dev devpts, type devpts), uses transition SIDs
Feb 12 23:08:22 localhost kernel: SELinux: initialized (dev eventpollfs, type eventpollfs), uses genfs_contexts
Feb 12 23:08:22 localhost kernel: SELinux: initialized (dev inotifyfs, type inotifyfs), uses genfs_contexts
Feb 12 23:08:22 localhost kernel: SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
Feb 12 23:08:22 localhost kernel: SELinux: initialized (dev futexfs, type futexfs), uses genfs_contexts
Feb 12 23:08:22 localhost kernel: SELinux: initialized (dev pipefs, type pipefs), uses task SIDs
Feb 12 23:08:22 localhost kernel: SELinux: initialized (dev sockfs, type sockfs), uses task SIDs
Feb 12 23:08:22 localhost kernel: SELinux: initialized (dev proc, type proc), uses genfs_contexts
Feb 12 23:08:22 localhost kernel: SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
Feb 12 23:08:22 localhost kernel: SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
Feb 12 23:08:22 localhost kernel: SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
Feb 12 23:08:22 localhost kernel: SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
Feb 12 23:08:22 localhost kernel: Floppy drive(s): fd0 is 1.44M
Feb 12 23:08:22 localhost kernel: floppy0: no floppy controllers found
Feb 12 23:08:22 localhost kernel: 8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
Feb 12 23:08:22 localhost kernel: ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [C0C3] -> GSI 10 (level, low) -> IRQ 10
Feb 12 23:08:22 localhost kernel: eth0: RTL-8139C+ at 0xe0830000, 00:02:3f:65:4d:74, IRQ 10
Feb 12 23:08:22 localhost kernel: 8139too Fast Ethernet driver 0.9.27
Feb 12 23:08:22 localhost kernel: ieee80211: 802.11 data/management/control stack, git-1.1.7
Feb 12 23:08:22 localhost kernel: ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
Feb 12 23:08:22 localhost kernel: ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, git-1.0.8
Feb 12 23:08:22 localhost kernel: ipw2200: Copyright(c) 2003-2005 Intel Corporation
Feb 12 23:08:22 localhost kernel: ACPI: PCI Interrupt Link [C0C5] enabled at IRQ 5
Feb 12 23:08:22 localhost kernel: ACPI: PCI Interrupt 0000:02:02.0[A] -> Link [C0C5] -> GSI 5 (level, low) -> IRQ 5
Feb 12 23:08:22 localhost kernel: ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
Feb 12 23:08:22 localhost kernel: eth0: link down
Feb 12 23:08:22 localhost kernel: ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [C0C3] -> GSI 10 (level, low) -> IRQ 10
Feb 12 23:08:22 localhost kernel: intel8x0_measure_ac97_clock: measured 55416 usecs
Feb 12 23:08:22 localhost kernel: intel8x0: clocking to 48000
Feb 12 23:08:22 localhost kernel: ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [C0C3] -> GSI 10 (level, low) -> IRQ 10
Feb 12 23:08:22 localhost kernel: hw_random: cannot enable RNG, aborting
Feb 12 23:08:22 localhost kernel: ACPI: PCI Interrupt Link [C0C9] enabled at IRQ 5
Feb 12 23:08:22 localhost kernel: ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [C0C9] -> GSI 5 (level, low) -> IRQ 5
Feb 12 23:08:22 localhost kernel: ehci_hcd 0000:00:1d.7: EHCI Host Controller
Feb 12 23:08:23 localhost kernel: ehci_hcd 0000:00:1d.7: debug port 1
Feb 12 23:08:23 localhost kernel: ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
Feb 12 23:08:23 localhost kernel: ehci_hcd 0000:00:1d.7: irq 5, io mem 0xa0000000
Feb 12 23:08:23 localhost kernel: ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
Feb 12 23:08:23 localhost kernel: hub 1-0:1.0: USB hub found
Feb 12 23:08:23 localhost kernel: hub 1-0:1.0: 6 ports detected
Feb 12 23:08:23 localhost kernel: USB Universal Host Controller Interface driver v2.3
Feb 12 23:08:23 localhost kernel: ACPI: PCI Interrupt Link [C0C2] enabled at IRQ 10
Feb 12 23:08:23 localhost kernel: ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [C0C2] -> GSI 10 (level, low) -> IRQ 10
Feb 12 23:08:23 localhost kernel: uhci_hcd 0000:00:1d.0: UHCI Host Controller
Feb 12 23:08:23 localhost kernel: uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
Feb 12 23:08:23 localhost kernel: uhci_hcd 0000:00:1d.0: irq 10, io base 0x000048c0
Feb 12 23:08:23 localhost kernel: hub 2-0:1.0: USB hub found
Feb 12 23:08:23 localhost kernel: hub 2-0:1.0: 2 ports detected
Feb 12 23:08:23 localhost kernel: ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [C0C5] -> GSI 5 (level, low) -> IRQ 5
Feb 12 23:08:23 localhost kernel: uhci_hcd 0000:00:1d.1: UHCI Host Controller
Feb 12 23:08:23 localhost kernel: uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
Feb 12 23:08:23 localhost kernel: uhci_hcd 0000:00:1d.1: irq 5, io base 0x000048e0
Feb 12 23:08:23 localhost kernel: hub 3-0:1.0: USB hub found
Feb 12 23:08:23 localhost kernel: hub 3-0:1.0: 2 ports detected
Feb 12 23:08:23 localhost kernel: ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [C0C4] -> GSI 5 (level, low) -> IRQ 5
Feb 12 23:08:23 localhost kernel: uhci_hcd 0000:00:1d.2: UHCI Host Controller
Feb 12 23:08:23 localhost kernel: uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
Feb 12 23:08:23 localhost kernel: uhci_hcd 0000:00:1d.2: irq 5, io base 0x00004c00
Feb 12 23:08:23 localhost kernel: hub 4-0:1.0: USB hub found
Feb 12 23:08:23 localhost kernel: hub 4-0:1.0: 2 ports detected
Feb 12 23:08:23 localhost kernel: ACPI: PCI Interrupt 0000:02:04.0[A] -> Link [C0C4] -> GSI 5 (level, low) -> IRQ 5
Feb 12 23:08:23 localhost kernel: Yenta: CardBus bridge found at 0000:02:04.0 [0e11:0860]
Feb 12 23:08:23 localhost kernel: Yenta: Using CSCINT to route CSC interrupts to PCI
Feb 12 23:08:23 localhost kernel: Yenta: Routing CardBus interrupts to PCI
Feb 12 23:08:23 localhost kernel: Yenta TI: socket 0000:02:04.0, mfunc 0x001c1112, devctl 0x44
Feb 12 23:08:23 localhost kernel: Yenta: ISA IRQ mask 0x08d8, PCI irq 5
Feb 12 23:08:23 localhost kernel: Socket status: 30000006
Feb 12 23:08:23 localhost kernel: pcmcia: parent PCI bridge I/O window: 0x2000 - 0x2fff
Feb 12 23:08:23 localhost kernel: cs: IO port probe 0x2000-0x2fff: clean.
Feb 12 23:08:23 localhost kernel: pcmcia: parent PCI bridge Memory window: 0x90000000 - 0x903fffff
Feb 12 23:08:24 localhost kernel: pcmcia: parent PCI bridge Memory window: 0x30000000 - 0x31ffffff
Feb 12 23:08:24 localhost kernel: ohci1394: $Rev: 1313 $ Ben Collins <bcollins@debian.org>
Feb 12 23:08:24 localhost kernel: ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [C0C2] -> GSI 10 (level, low) -> IRQ 10
Feb 12 23:08:24 localhost kernel: ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[10]  MMIO=[90200000-902007ff]  Max Packet=[2048]
Feb 12 23:08:24 localhost kernel: ACPI: AC Adapter [C134] (on-line)
Feb 12 23:08:24 localhost kernel: ACPI: Battery Slot [C11F] (battery present)
Feb 12 23:08:24 localhost kernel: ACPI: Power Button (FF) [PWRF]
Feb 12 23:08:24 localhost kernel: ACPI: Power Button (CM) [C1BE]
Feb 12 23:08:24 localhost kernel: ACPI: Lid Switch [C136]
Feb 12 23:08:24 localhost kernel: ibm_acpi: ec object not found
Feb 12 23:08:24 localhost kernel: ACPI: Video Device [C0D0] (multi-head: yes  rom: no  post: no)
Feb 12 23:08:24 localhost kernel: md: Autodetecting RAID arrays.
Feb 12 23:08:24 localhost kernel: md: autorun ...
Feb 12 23:08:24 localhost kernel: md: ... autorun DONE.
Feb 12 23:08:24 localhost kernel: device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
Feb 12 23:08:24 localhost kernel: cdrom: open failed.
Feb 12 23:08:24 localhost kernel: cdrom: open failed.
Feb 12 23:08:25 localhost kernel: EXT3 FS on hda5, internal journal
Feb 12 23:08:25 localhost kernel: kjournald starting.  Commit interval 5 seconds
Feb 12 23:08:25 localhost kernel: EXT3 FS on hda2, internal journal
Feb 12 23:08:25 localhost kernel: EXT3-fs: mounted filesystem with ordered data mode.
Feb 12 23:08:25 localhost kernel: SELinux: initialized (dev hda2, type ext3), uses xattr
Feb 12 23:08:25 localhost kernel: SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
Feb 12 23:08:25 localhost kernel: NTFS driver 2.1.25 [Flags: R/O MODULE].
Feb 12 23:08:25 localhost kernel: NTFS volume version 3.1.
Feb 12 23:08:25 localhost kernel: SELinux: initialized (dev hda1, type ntfs), uses genfs_contexts
Feb 12 23:08:25 localhost kernel: Adding 1232272k swap on /dev/hda3.  Priority:-1 extents:1 across:1232272k
Feb 12 23:08:25 localhost kernel: SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses genfs_contexts
Feb 12 23:08:25 localhost kernel: ip_tables: (C) 2000-2002 Netfilter core team
Feb 12 23:08:25 localhost kernel: Netfilter messages via NETLINK v0.30.
Feb 12 23:08:25 localhost kernel: ip_conntrack version 2.4 (4094 buckets, 32752 max) - 232 bytes per conntrack
Feb 12 23:08:25 localhost kernel: cs: IO port probe 0xc00-0xcff: clean.
Feb 12 23:08:25 localhost kernel: cs: IO port probe 0x800-0x8ff: clean.
Feb 12 23:08:25 localhost kernel: cs: IO port probe 0x100-0x4ff: excluding 0x140-0x14f 0x200-0x20f 0x378-0x37f
Feb 12 23:08:25 localhost kernel: cs: IO port probe 0xa00-0xaff: clean.
Feb 12 23:08:25 localhost kernel: eth0: link down
Feb 12 23:08:25 localhost kernel: audit(1139807293.911:2): avc:  denied  { read } for  pid=2777 comm="auditd" name="[6193]" dev=pipefs ino=6193 scontext=system_u:system_r:auditd_t tcontext=system_u:system_r:auditd_t tclass=fifo_file
Feb 12 23:08:25 localhost kernel: SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
Feb 12 23:08:25 localhost kernel: parport: PnPBIOS parport detected.
Feb 12 23:08:25 localhost kernel: parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
Feb 12 23:08:25 localhost kernel: lp0: using parport0 (interrupt-driven).
Feb 12 23:08:25 localhost kernel: lp0: console ready
Feb 12 23:08:25 localhost kernel: NET: Registered protocol family 10
Feb 12 23:08:25 localhost kernel: lo: Disabled Privacy Extensions
Feb 12 23:08:25 localhost kernel: IPv6 over IPv4 tunneling driver
Feb 12 23:08:34 localhost kernel: [drm] Initialized drm 1.0.0 20040925
Feb 12 23:08:34 localhost kernel: ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [C0C2] -> GSI 10 (level, low) -> IRQ 10
Feb 12 23:08:34 localhost kernel: [drm] Initialized radeon 1.19.0 20050911 on minor 0: 
Feb 12 23:08:34 localhost kernel: mtrr: 0x98000000,0x8000000 overlaps existing 0x98000000,0x2000000
Feb 12 23:08:34 localhost kernel: agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
Feb 12 23:08:34 localhost kernel: agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
Feb 12 23:08:34 localhost kernel: agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
Feb 12 23:08:34 localhost kernel: [drm] Loading R200 Microcode
Feb 12 23:09:12 localhost kernel: eth0: link down
Feb 12 23:09:12 localhost kernel: ADDRCONF(NETDEV_UP): eth0: link is not ready
Feb 12 23:09:24 localhost kernel: audit(:0): major=252 name_count=0: freeing multiple contexts (1)
Feb 12 23:09:24 localhost kernel: audit(:0): major=113 name_count=0: freeing multiple contexts (2)
Feb 12 23:09:47 localhost kernel: Stopping tasks: =================================================================================================|
Feb 12 23:09:47 localhost kernel: ACPI: PCI interrupt for device 0000:02:04.0 disabled
Feb 12 23:09:47 localhost kernel: eth1: Going into suspend...
Feb 12 23:09:47 localhost kernel: ACPI: PCI interrupt for device 0000:02:02.0 disabled
Feb 12 23:09:47 localhost kernel: ACPI: PCI interrupt for device 0000:00:1f.6 disabled
Feb 12 23:09:47 localhost kernel: ACPI: PCI interrupt for device 0000:00:1f.5 disabled
Feb 12 23:09:47 localhost kernel: ACPI: PCI interrupt for device 0000:00:1d.7 disabled
Feb 12 23:09:47 localhost kernel: ACPI: PCI interrupt for device 0000:00:1d.2 disabled
Feb 12 23:09:47 localhost kernel: ACPI: PCI interrupt for device 0000:00:1d.1 disabled
Feb 12 23:09:47 localhost kernel: ACPI: PCI interrupt for device 0000:00:1d.0 disabled
Feb 12 23:09:47 localhost kernel: Intel machine check architecture supported.
Feb 12 23:09:47 localhost kernel: Intel machine check reporting enabled on CPU#0.
Feb 12 23:09:47 localhost kernel: Debug: sleeping function called from invalid context at mm/slab.c:2499
Feb 12 23:09:47 localhost kernel: in_atomic():0, irqs_disabled():1
Feb 12 23:09:47 localhost kernel:  [<c014e974>] kmem_cache_alloc+0x54/0x70     [<c0221708>] acpi_os_acquire_object+0xb/0x3c
Feb 12 23:09:47 localhost kernel:  [<c0235cad>] acpi_ut_allocate_object_desc_dbg+0x13/0x49     [<c0235b47>] acpi_ut_create_internal_object_dbg+0xf/0x5e
Feb 12 23:09:47 localhost kernel:  [<c02321b0>] acpi_rs_set_srs_method_data+0x3d/0xb9     [<c02d79ca>] cpufreq_cpu_put+0xa/0x30
Feb 12 23:09:47 localhost kernel:  [<c02d8ee5>] cpufreq_resume+0xc5/0x230     [<c0239562>] acpi_pci_link_set+0x107/0x17b
Feb 12 23:09:47 localhost kernel:  [<c02399eb>] irqrouter_resume+0x1e/0x3c     [<c0271d51>] __sysdev_resume+0x11/0x80
Feb 12 23:09:47 localhost kernel:  [<c0272057>] sysdev_resume+0x47/0x65     [<c0276d75>] device_power_up+0x5/0xa
Feb 12 23:09:47 localhost kernel:  [<c013f2d6>] suspend_enter+0x56/0x60     [<c013f206>] suspend_prepare+0x76/0xf0
Feb 12 23:09:47 localhost kernel:  [<c013f37f>] enter_state+0x6f/0x90     [<c013f4f5>] state_store+0x95/0xaf
Feb 12 23:09:47 localhost kernel:  [<c013f460>] state_store+0x0/0xaf     [<c01a7779>] subsys_attr_store+0x29/0x40
Feb 12 23:09:47 localhost kernel:  [<c01a7a48>] flush_write_buffer+0x28/0x40     [<c01a7ab8>] sysfs_write_file+0x58/0x90
Feb 12 23:09:47 localhost kernel:  [<c01a7a60>] sysfs_write_file+0x0/0x90     [<c01654eb>] vfs_write+0xbb/0x180
Feb 12 23:09:47 localhost kernel:  [<c0165661>] sys_write+0x41/0x70     [<c0103259>] syscall_call+0x7/0xb
Feb 12 23:09:47 localhost kernel: PCI: Enabling device 0000:00:1d.0 (0000 -> 0001)
Feb 12 23:09:47 localhost kernel: ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [C0C2] -> GSI 10 (level, low) -> IRQ 10
Feb 12 23:09:47 localhost kernel: PCI: Enabling device 0000:00:1d.1 (0000 -> 0001)
Feb 12 23:09:47 localhost kernel: ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [C0C5] -> GSI 5 (level, low) -> IRQ 5
Feb 12 23:09:47 localhost kernel: PCI: Enabling device 0000:00:1d.2 (0000 -> 0001)
Feb 12 23:09:47 localhost kernel: ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [C0C4] -> GSI 5 (level, low) -> IRQ 5
Feb 12 23:09:47 localhost kernel: PCI: Enabling device 0000:00:1d.7 (0000 -> 0002)
Feb 12 23:09:47 localhost kernel: ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [C0C9] -> GSI 5 (level, low) -> IRQ 5
Feb 12 23:09:47 localhost kernel: ehci_hcd 0000:00:1d.7: debug port 1
Feb 12 23:09:47 localhost kernel: ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
Feb 12 23:09:48 localhost kernel: ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [C0C4] -> GSI 5 (level, low) -> IRQ 5
Feb 12 23:09:48 localhost kernel: ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [C0C3] -> GSI 10 (level, low) -> IRQ 10
Feb 12 23:09:48 localhost kernel: ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [C0C3] -> GSI 10 (level, low) -> IRQ 10
Feb 12 23:09:48 localhost kernel: ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [C0C2] -> GSI 10 (level, low) -> IRQ 10
Feb 12 23:09:48 localhost kernel: PCI: Enabling device 0000:02:00.0 (0080 -> 0083)
Feb 12 23:09:48 localhost kernel: ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [C0C2] -> GSI 10 (level, low) -> IRQ 10
Feb 12 23:09:48 localhost kernel: PCI: Via IRQ fixup for 0000:02:00.0, from 0 to 10
Feb 12 23:09:48 localhost kernel: eth1: Coming out of suspend...
Feb 12 23:09:48 localhost kernel: PCI: Enabling device 0000:02:02.0 (0000 -> 0002)
Feb 12 23:09:48 localhost kernel: ACPI: PCI Interrupt 0000:02:02.0[A] -> Link [C0C5] -> GSI 5 (level, low) -> IRQ 5
Feb 12 23:09:48 localhost kernel: ACPI: PCI Interrupt 0000:02:04.0[A] -> Link [C0C4] -> GSI 5 (level, low) -> IRQ 5
Feb 12 23:09:48 localhost kernel:     ACPI-0412: *** Error: Handler for [EmbeddedControl] returned AE_TIME
Feb 12 23:09:48 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C046.C059.C0EA.C11D] (Node dfea1280), AE_TIME
Feb 12 23:09:48 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_WAK] (Node c14dd500), AE_TIME
Feb 12 23:09:48 localhost kernel:     ACPI-0550: *** Error: Method _WAK failed, AE_TIME
Feb 12 23:09:48 localhost kernel: Restarting tasks...<4>psmouse.c: Failed to reset mouse on isa0060/serio1
Feb 12 23:09:48 localhost kernel:  done
Feb 12 23:09:48 localhost kernel: input: PS/2 Generic Mouse as /class/input/input2
Feb 12 23:09:48 localhost kernel: psmouse.c: Failed to enable mouse on isa0060/serio1
Feb 12 23:09:52 localhost kernel: audit(:0): major=252 name_count=0: freeing multiple contexts (1)
Feb 12 23:09:52 localhost kernel: audit(:0): major=113 name_count=0: freeing multiple contexts (2)
Feb 12 23:09:52 localhost kernel: audit(:0): major=252 name_count=0: freeing multiple contexts (1)
Feb 12 23:09:52 localhost kernel: audit(:0): major=113 name_count=0: freeing multiple contexts (2)
Feb 12 23:09:52 localhost kernel: agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
Feb 12 23:09:52 localhost kernel: agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
Feb 12 23:09:52 localhost kernel: agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
Feb 12 23:09:52 localhost kernel: [drm] Loading R200 Microcode
Feb 12 23:09:53 localhost kernel:     ACPI-0412: *** Error: Handler for [EmbeddedControl] returned AE_TIME
Feb 12 23:09:53 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C046.C059.C0EA.C132] (Node dfea11e0), AE_TIME
Feb 12 23:09:53 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C132] (Node c14dee20), AE_TIME
Feb 12 23:09:53 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C11F._BST] (Node c14ded60), AE_TIME
Feb 12 23:09:54 localhost kernel:     ACPI-0412: *** Error: Handler for [EmbeddedControl] returned AE_TIME
Feb 12 23:09:54 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C046.C059.C0EA.C132] (Node dfea11e0), AE_TIME
Feb 12 23:09:54 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C132] (Node c14dee20), AE_TIME
Feb 12 23:09:54 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C11F._BST] (Node c14ded60), AE_TIME
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 - driver resynched.
Feb 12 23:10:22 localhost kernel:     ACPI-0412: *** Error: Handler for [EmbeddedControl] returned AE_TIME
Feb 12 23:10:22 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C046.C059.C0EA.C132] (Node dfea11e0), AE_TIME
Feb 12 23:10:22 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C132] (Node c14dee20), AE_TIME
Feb 12 23:10:22 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C11F._BST] (Node c14ded60), AE_TIME
Feb 12 23:10:24 localhost kernel:     ACPI-0412: *** Error: Handler for [EmbeddedControl] returned AE_TIME
Feb 12 23:10:24 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C046.C059.C0EA.C132] (Node dfea11e0), AE_TIME
Feb 12 23:10:24 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C132] (Node c14dee20), AE_TIME
Feb 12 23:10:24 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C11F._BST] (Node c14ded60), AE_TIME
Feb 12 23:10:28 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
Feb 12 23:10:28 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:28 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 - driver resynched.
Feb 12 23:10:28 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
Feb 12 23:10:28 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:28 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 - driver resynched.
Feb 12 23:10:28 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:10:28 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 - driver resynched.
Feb 12 23:10:52 localhost kernel:     ACPI-0412: *** Error: Handler for [EmbeddedControl] returned AE_TIME
Feb 12 23:10:52 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C046.C059.C0EA.C132] (Node dfea11e0), AE_TIME
Feb 12 23:10:52 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C132] (Node c14dee20), AE_TIME
Feb 12 23:10:52 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C11F._BST] (Node c14ded60), AE_TIME
Feb 12 23:10:54 localhost kernel:     ACPI-0412: *** Error: Handler for [EmbeddedControl] returned AE_TIME
Feb 12 23:10:54 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C046.C059.C0EA.C132] (Node dfea11e0), AE_TIME
Feb 12 23:10:54 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C132] (Node c14dee20), AE_TIME
Feb 12 23:10:54 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C11F._BST] (Node c14ded60), AE_TIME
Feb 12 23:11:23 localhost kernel:     ACPI-0412: *** Error: Handler for [EmbeddedControl] returned AE_TIME
Feb 12 23:11:23 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C046.C059.C0EA.C132] (Node dfea11e0), AE_TIME
Feb 12 23:11:23 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C132] (Node c14dee20), AE_TIME
Feb 12 23:11:23 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C11F._BST] (Node c14ded60), AE_TIME
Feb 12 23:11:24 localhost kernel:     ACPI-0412: *** Error: Handler for [EmbeddedControl] returned AE_TIME
Feb 12 23:11:24 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C046.C059.C0EA.C132] (Node dfea11e0), AE_TIME
Feb 12 23:11:24 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C132] (Node c14dee20), AE_TIME
Feb 12 23:11:24 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C11F._BST] (Node c14ded60), AE_TIME
Feb 12 23:11:53 localhost kernel:     ACPI-0412: *** Error: Handler for [EmbeddedControl] returned AE_TIME
Feb 12 23:11:53 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C046.C059.C0EA.C132] (Node dfea11e0), AE_TIME
Feb 12 23:11:53 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C132] (Node c14dee20), AE_TIME
Feb 12 23:11:53 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C11F._BST] (Node c14ded60), AE_TIME
Feb 12 23:11:54 localhost kernel:     ACPI-0412: *** Error: Handler for [EmbeddedControl] returned AE_TIME
Feb 12 23:11:54 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C046.C059.C0EA.C132] (Node dfea11e0), AE_TIME
Feb 12 23:11:54 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C132] (Node c14dee20), AE_TIME
Feb 12 23:11:54 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C11F._BST] (Node c14ded60), AE_TIME
Feb 12 23:11:58 localhost kernel: atkbd.c: Unknown key released (translated set 2, code 0xe0 on isa0060/serio0).
Feb 12 23:11:58 localhost kernel: atkbd.c: Use 'setkeycodes e060 <keycode>' to make it known.
Feb 12 23:11:58 localhost kernel: atkbd.c: Unknown key released (translated set 2, code 0xe0 on isa0060/serio0).
Feb 12 23:11:58 localhost kernel: atkbd.c: Use 'setkeycodes e060 <keycode>' to make it known.
Feb 12 23:12:05 localhost kernel: input: AT Translated Set 2 keyboard as /class/input/input3
Feb 12 23:12:10 localhost kernel: ipw2200: Unknown notification: subtype=40,flags=0xa0,size=40
Feb 12 23:12:23 localhost kernel:     ACPI-0412: *** Error: Handler for [EmbeddedControl] returned AE_TIME
Feb 12 23:12:23 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C046.C059.C0EA.C132] (Node dfea11e0), AE_TIME
Feb 12 23:12:23 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C132] (Node c14dee20), AE_TIME
Feb 12 23:12:23 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C11F._BST] (Node c14ded60), AE_TIME
Feb 12 23:12:24 localhost kernel:     ACPI-0412: *** Error: Handler for [EmbeddedControl] returned AE_TIME
Feb 12 23:12:24 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C046.C059.C0EA.C132] (Node dfea11e0), AE_TIME
Feb 12 23:12:24 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C132] (Node c14dee20), AE_TIME
Feb 12 23:12:24 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C11F._BST] (Node c14ded60), AE_TIME
Feb 12 23:12:31 localhost kernel: atkbd.c: Unknown key released (translated set 2, code 0xe0 on isa0060/serio0).
Feb 12 23:12:31 localhost kernel: atkbd.c: Use 'setkeycodes e060 <keycode>' to make it known.
Feb 12 23:12:34 localhost kernel: atkbd.c: Unknown key released (translated set 2, code 0xe0 on isa0060/serio0).
Feb 12 23:12:34 localhost kernel: atkbd.c: Use 'setkeycodes e060 <keycode>' to make it known.
Feb 12 23:12:36 localhost kernel: atkbd.c: Unknown key released (translated set 2, code 0xe0 on isa0060/serio0).
Feb 12 23:12:36 localhost kernel: atkbd.c: Use 'setkeycodes e060 <keycode>' to make it known.
Feb 12 23:12:53 localhost kernel:     ACPI-0412: *** Error: Handler for [EmbeddedControl] returned AE_TIME
Feb 12 23:12:53 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C046.C059.C0EA.C132] (Node dfea11e0), AE_TIME
Feb 12 23:12:53 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C132] (Node c14dee20), AE_TIME
Feb 12 23:12:53 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C11F._BST] (Node c14ded60), AE_TIME
Feb 12 23:12:54 localhost kernel:     ACPI-0412: *** Error: Handler for [EmbeddedControl] returned AE_TIME
Feb 12 23:12:54 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C046.C059.C0EA.C132] (Node dfea11e0), AE_TIME
Feb 12 23:12:54 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C132] (Node c14dee20), AE_TIME
Feb 12 23:12:54 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C11F._BST] (Node c14ded60), AE_TIME
Feb 12 23:13:00 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:13:00 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 - driver resynched.
Feb 12 23:13:23 localhost kernel:     ACPI-0412: *** Error: Handler for [EmbeddedControl] returned AE_TIME
Feb 12 23:13:23 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C046.C059.C0EA.C132] (Node dfea11e0), AE_TIME
Feb 12 23:13:23 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C132] (Node c14dee20), AE_TIME
Feb 12 23:13:23 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C11F._BST] (Node c14ded60), AE_TIME
Feb 12 23:13:24 localhost kernel:     ACPI-0412: *** Error: Handler for [EmbeddedControl] returned AE_TIME
Feb 12 23:13:24 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C046.C059.C0EA.C132] (Node dfea11e0), AE_TIME
Feb 12 23:13:24 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C132] (Node c14dee20), AE_TIME
Feb 12 23:13:24 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C11F._BST] (Node c14ded60), AE_TIME
Feb 12 23:13:31 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
Feb 12 23:13:31 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:13:35 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 - driver resynched.
Feb 12 23:13:36 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
Feb 12 23:13:36 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:13:36 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 - driver resynched.
Feb 12 23:13:38 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
Feb 12 23:13:38 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:13:38 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:13:38 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 - driver resynched.
Feb 12 23:13:41 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
Feb 12 23:13:41 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:13:41 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 - driver resynched.
Feb 12 23:13:53 localhost kernel:     ACPI-0412: *** Error: Handler for [EmbeddedControl] returned AE_TIME
Feb 12 23:13:53 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C046.C059.C0EA.C132] (Node dfea11e0), AE_TIME
Feb 12 23:13:53 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C132] (Node c14dee20), AE_TIME
Feb 12 23:13:53 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C11F._BST] (Node c14ded60), AE_TIME
Feb 12 23:13:54 localhost kernel:     ACPI-0412: *** Error: Handler for [EmbeddedControl] returned AE_TIME
Feb 12 23:13:54 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C046.C059.C0EA.C132] (Node dfea11e0), AE_TIME
Feb 12 23:13:54 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C132] (Node c14dee20), AE_TIME
Feb 12 23:13:54 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C11F._BST] (Node c14ded60), AE_TIME
Feb 12 23:14:18 localhost kernel: atkbd.c: Unknown key released (translated set 2, code 0xe0 on isa0060/serio0).
Feb 12 23:14:18 localhost kernel: atkbd.c: Use 'setkeycodes e060 <keycode>' to make it known.
Feb 12 23:14:23 localhost kernel:     ACPI-0412: *** Error: Handler for [EmbeddedControl] returned AE_TIME
Feb 12 23:14:23 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C046.C059.C0EA.C132] (Node dfea11e0), AE_TIME
Feb 12 23:14:23 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C132] (Node c14dee20), AE_TIME
Feb 12 23:14:23 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C11F._BST] (Node c14ded60), AE_TIME
Feb 12 23:14:24 localhost kernel:     ACPI-0412: *** Error: Handler for [EmbeddedControl] returned AE_TIME
Feb 12 23:14:24 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C046.C059.C0EA.C132] (Node dfea11e0), AE_TIME
Feb 12 23:14:24 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C132] (Node c14dee20), AE_TIME
Feb 12 23:14:24 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C11F._BST] (Node c14ded60), AE_TIME
Feb 12 23:14:33 localhost kernel: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
Feb 12 23:14:53 localhost kernel:     ACPI-0412: *** Error: Handler for [EmbeddedControl] returned AE_TIME
Feb 12 23:14:53 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C046.C059.C0EA.C132] (Node dfea11e0), AE_TIME
Feb 12 23:14:53 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C132] (Node c14dee20), AE_TIME
Feb 12 23:14:53 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C11F._BST] (Node c14ded60), AE_TIME
Feb 12 23:14:54 localhost kernel:     ACPI-0412: *** Error: Handler for [EmbeddedControl] returned AE_TIME
Feb 12 23:14:54 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C046.C059.C0EA.C132] (Node dfea11e0), AE_TIME
Feb 12 23:14:54 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C132] (Node c14dee20), AE_TIME
Feb 12 23:14:54 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C11F._BST] (Node c14ded60), AE_TIME
Feb 12 23:15:14 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:15:14 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 - driver resynched.
Feb 12 23:15:18 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
Feb 12 23:15:18 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:15:18 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:15:18 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
Feb 12 23:15:18 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:15:18 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
Feb 12 23:15:18 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:15:18 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:15:18 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
Feb 12 23:15:18 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:15:18 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
Feb 12 23:15:18 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:15:18 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 - driver resynched.
Feb 12 23:15:18 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
Feb 12 23:15:18 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:15:18 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 - driver resynched.
Feb 12 23:15:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
Feb 12 23:15:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:15:19 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 - driver resynched.
Feb 12 23:15:24 localhost kernel:     ACPI-0412: *** Error: Handler for [EmbeddedControl] returned AE_TIME
Feb 12 23:15:24 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C046.C059.C0EA.C132] (Node dfea11e0), AE_TIME
Feb 12 23:15:24 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C132] (Node c14dee20), AE_TIME
Feb 12 23:15:24 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C11F._BST] (Node c14ded60), AE_TIME
Feb 12 23:15:24 localhost kernel:     ACPI-0412: *** Error: Handler for [EmbeddedControl] returned AE_TIME
Feb 12 23:15:24 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C046.C059.C0EA.C132] (Node dfea11e0), AE_TIME
Feb 12 23:15:24 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C132] (Node c14dee20), AE_TIME
Feb 12 23:15:24 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C11F._BST] (Node c14ded60), AE_TIME
Feb 12 23:15:54 localhost kernel:     ACPI-0412: *** Error: Handler for [EmbeddedControl] returned AE_TIME
Feb 12 23:15:54 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C046.C059.C0EA.C132] (Node dfea11e0), AE_TIME
Feb 12 23:15:54 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C132] (Node c14dee20), AE_TIME
Feb 12 23:15:54 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C11F._BST] (Node c14ded60), AE_TIME
Feb 12 23:15:54 localhost kernel:     ACPI-0412: *** Error: Handler for [EmbeddedControl] returned AE_TIME
Feb 12 23:15:54 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C046.C059.C0EA.C132] (Node dfea11e0), AE_TIME
Feb 12 23:15:54 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C132] (Node c14dee20), AE_TIME
Feb 12 23:15:54 localhost kernel:     ACPI-0508: *** Error: Method execution failed [\_SB_.C11F._BST] (Node c14ded60), AE_TIME
Feb 12 23:15:55 localhost kernel: atkbd.c: Unknown key released (translated set 2, code 0xe0 on isa0060/serio0).
Feb 12 23:15:55 localhost kernel: atkbd.c: Use 'setkeycodes e060 <keycode>' to make it known.
Feb 12 23:15:56 localhost kernel: atkbd.c: Unknown key released (translated set 2, code 0xe0 on isa0060/serio0).
Feb 12 23:15:56 localhost kernel: atkbd.c: Use 'setkeycodes e060 <keycode>' to make it known.
Feb 12 23:16:02 localhost kernel: atkbd.c: Unknown key released (translated set 2, code 0xe0 on isa0060/serio0).
Feb 12 23:16:02 localhost kernel: atkbd.c: Use 'setkeycodes e060 <keycode>' to make it known.
Feb 12 23:16:08 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:16:08 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 - driver resynched.
Feb 12 23:16:09 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:16:09 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 - driver resynched.
Feb 12 23:16:10 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 4
Feb 12 23:16:10 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1
Feb 12 23:16:10 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 - driver resynched.
Feb 12 23:16:10 localhost kernel: psmouse.c: TouchPad at isa0060/serio4/input0 lost sync at byte 1

--------------020709070202050206080601--
