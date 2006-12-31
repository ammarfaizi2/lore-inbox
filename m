Return-Path: <linux-kernel-owner+w=401wt.eu-S933094AbWLaION@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933094AbWLaION (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 03:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933095AbWLaION
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 03:14:13 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:16206 "EHLO
	pd5mo1so.prod.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933094AbWLaIOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 03:14:11 -0500
Date: Sun, 31 Dec 2006 02:15:30 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Suspend problems on 2.6.20-rc2-git1
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <459771A2.6060301@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Having some suspend problems on 2.6.20-rc2-git1 with Fedora Core 6. 
First of all the normal user interface for hibernate isn't working 
properly while it did in 2.6.19. When you select "Hibernate" it seems to 
stop X and go into console mode but somehow doesn't seem to actually 
start the process of suspending. I'm not sure at what point it is failing.

Secondly, if you try and suspend manually it claims there is no swap 
device available when there clearly is:

[root@localhost rob]# cat /proc/swaps
Filename                                Type            Size    Used 
Priority
/dev/mapper/VolGroup00-LogVol01         partition       1048568 0       -1
[root@localhost rob]# echo disk > /sys/power/state
bash: echo: write error: No such device or address

Full dmesg from bootup and attempted suspend:

Linux version 2.6.20-rc2-git1 (rob@localhost.localdomain) (gcc version 
4.1.1 20061011 (Red Hat 4.1.1-30)) #1 SMP Sun Dec 31 01:33:54 CST 2006
BIOS-provided physical RAM map:
sanitize start
sanitize end
copy_e820_map() start: 0000000000000000 size: 000000000009fc00 end: 
000000000009fc00 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000000009fc00 size: 0000000000000400 end: 
00000000000a0000 type: 2
copy_e820_map() start: 00000000000e0000 size: 0000000000020000 end: 
0000000000100000 type: 2
copy_e820_map() start: 0000000000100000 size: 000000001fed0000 end: 
000000001ffd0000 type: 1
copy_e820_map() type is E820_RAM
copy_e820_map() start: 000000001ffd0000 size: 0000000000020c00 end: 
000000001fff0c00 type: 2
copy_e820_map() start: 000000001fff0c00 size: 000000000000b400 end: 
000000001fffc000 type: 4
copy_e820_map() start: 000000001fffc000 size: 0000000000004000 end: 
0000000020000000 type: 2
  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000001ffd0000 (usable)
  BIOS-e820: 000000001ffd0000 - 000000001fff0c00 (reserved)
  BIOS-e820: 000000001fff0c00 - 000000001fffc000 (ACPI NVS)
  BIOS-e820: 000000001fffc000 - 0000000020000000 (reserved)
0MB HIGHMEM available.
511MB LOWMEM available.
Entering add_active_range(0, 0, 131024) 0 entries of 256 used
Zone PFN ranges:
   DMA             0 ->     4096
   Normal       4096 ->   131024
   HighMem    131024 ->   131024
early_node_map[1] active PFN ranges
     0:        0 ->   131024
On node 0 totalpages: 131024
   DMA zone: 40 pages used for memmap
   DMA zone: 0 pages reserved
   DMA zone: 4056 pages, LIFO batch:0
   Normal zone: 1239 pages used for memmap
   Normal zone: 125689 pages, LIFO batch:31
   HighMem zone: 0 pages used for memmap
DMI 2.3 present.
Using APIC driver default
ACPI: RSDP (v000 COMPAQ                                ) @ 0x000f6560
ACPI: RSDT (v001 HP     CPQ0860  0x14070520 CPQ  0x00000001) @ 0x1fff0c84
ACPI: FADT (v002 HP     CPQ0860  0x00000002 CPQ  0x00000001) @ 0x1fff0c00
ACPI: SSDT (v001 COMPAQ  CPQGysr 0x00001001 MSFT 0x0100000e) @ 0x1fff5c3c
ACPI: DSDT (v001 HP       nx7000 0x00010000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
Allocating PCI resources starting at 30000000 (gap: 20000000:e0000000)
Detected 1694.562 MHz processor.
Built 1 zonelists.  Total pages: 129745
Kernel command line: ro root=/dev/VolGroup00/LogVol00
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (0150c000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c046c000 soft=c044c000
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 511704k/524096k available (2154k kernel code, 11760k reserved, 
935k data, 244k init, 0k highmem)
virtual kernel memory layout:
     fixmap  : 0xffc56000 - 0xfffff000   (3748 kB)
     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
     vmalloc : 0xe0800000 - 0xff7fe000   ( 495 MB)
     lowmem  : 0xc0000000 - 0xdffd0000   ( 511 MB)
       .init : 0xc040a000 - 0xc0447000   ( 244 kB)
       .data : 0xc031a915 - 0xc0404674   ( 935 kB)
       .text : 0xc0100000 - 0xc031a915   (2154 kB)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 3390.78 BogoMIPS 
(lpj=16953925)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: afe9f9bf 00000000 00000000 00000000 
00000180 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 2048K
CPU: After all inits, caps: afe9f9bf 00000000 00000000 00002040 00000180 
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 12k freed
ACPI: Core revision 20060707
ACPI: setting ELCR to 0200 (from 0c20)
CPU0: Intel(R) Pentium(R) M processor 1.70GHz stepping 06
SMP motherboard not detected.
Local APIC not detected. Using dummy APIC emulation.
Brought up 1 CPUs
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf031f, last bus=3
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [C046] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.C046] bus is 0
PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 1100-113f claimed by ICH4 GPIO
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
PCI: Bus #03 (-#06) is hidden behind transparent bridge #02 (-#03) (try 
'pci=assign-busses')
Please report the result to linux-kernel to fix this permanently
ACPI: PCI Interrupt Routing Table [\_SB_.C046._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C046.C047._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C046.C058._PRT]
ACPI: Power Resource [C18D] (on)
ACPI: Power Resource [C195] (on)
ACPI: Power Resource [C19C] (on)
ACPI: Power Resource [C1A6] (on)
ACPI: PCI Interrupt Link [C0C2] (IRQs 5 *10)
ACPI: PCI Interrupt Link [C0C3] (IRQs 5 *10)
ACPI: PCI Interrupt Link [C0C4] (IRQs *5 10)
ACPI: PCI Interrupt Link [C0C5] (IRQs *5 10)
ACPI: PCI Interrupt Link [C0C6] (IRQs 5 10) *0, disabled.
ACPI: PCI Interrupt Link [C0C7] (IRQs 5 10) *11
ACPI: PCI Interrupt Link [C0C8] (IRQs 5 10) *0, disabled.
ACPI: PCI Interrupt Link [C0C9] (IRQs *5 10)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 15 devices
SCSI subsystem initialized
libata version 2.00 loaded.
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a 
report
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4
NetLabel:  unlabeled traffic allowed by default
pnp: 00:0d: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:0d: ioport range 0x1000-0x107f could not be reserved
pnp: 00:0d: ioport range 0x1100-0x113f has been reserved
pnp: 00:0d: ioport range 0x1200-0x121f has been reserved
PCI: Bridge: 0000:00:01.0
   IO window: 3000-3fff
   MEM window: 90400000-904fffff
   PREFETCH window: 98000000-9fffffff
PCI: Bus 3, cardbus bridge: 0000:02:04.0
   IO window: 00002800-000028ff
   IO window: 00002c00-00002cff
   PREFETCH window: 30000000-33ffffff
   MEM window: 38000000-3bffffff
PCI: Bridge: 0000:00:1e.0
   IO window: 2000-2fff
   MEM window: 90000000-903fffff
   PREFETCH window: 30000000-33ffffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt Link [C0C4] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:02:04.0[A] -> Link [C0C4] -> GSI 5 (level, low) 
-> IRQ 5
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 6, 327680 bytes)
TCP bind hash table entries: 8192 (order: 5, 163840 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
checking if image is initramfs... it is
Freeing initrd memory: 2113k freed
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1167530352.610:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU0] (supports 8 throttling states)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
Non-volatile memory driver v1.2
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 855PM Chipset.
agpgart: AGP aperture is 256M @ 0xb0000000
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS2 at I/O 0x3e8 (irq = 3) is a 16550A
00:03: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ACPI: PCI Interrupt Link [C0C3] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [C0C3] -> GSI 10 (level, 
low) -> IRQ 10
ACPI: PCI interrupt for device 0000:00:1f.6 disabled
RAMDISK driver initialized: 16 RAM disks of 16384K size 4096 blocksize
ata_piix 0000:00:1f.1: version 2.00ac7
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [C0C4] -> GSI 5 (level, low) 
-> IRQ 5
PCI: Setting latency timer of device 0000:00:1f.1 to 64
ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0x4C40 irq 14
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x4C48 irq 15
scsi0 : ata_piix
ata1.00: ATA-7, max UDMA/100, 156368016 sectors: LBA48
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/100
scsi1 : ata_piix
ata2.00: ATAPI, max UDMA/33
ata2.00: configured for UDMA/33
scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG MP0804H  UE20 PQ: 0 ANSI: 5
SCSI device sda: 156368016 512-byte hdwr sectors (80060 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
SCSI device sda: 156368016 512-byte hdwr sectors (80060 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: write cache: enabled, read cache: enabled, doesn't 
support DPO or FUA
  sda: sda1 sda2 sda3
sd 0:0:0:0: Attached scsi disk sda
scsi 1:0:0:0: CD-ROM            QSI      CDRW/DVD SBW-241 VH04 PQ: 0 ANSI: 5
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0
Yenta: CardBus bridge found at 0000:02:04.0 [0e11:0860]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:04.0, mfunc 0x001c1112, devctl 0x44
Yenta: ISA IRQ mask 0x08d8, PCI irq 5
Socket status: 30000006
Yenta: Raising subordinate bus# of parent bus (#02) from #03 to #06
pcmcia: parent PCI bridge I/O window: 0x2000 - 0x2fff
cs: IO port probe 0x2000-0x2fff: clean.
pcmcia: parent PCI bridge Memory window: 0x90000000 - 0x903fffff
pcmcia: parent PCI bridge Memory window: 0x30000000 - 0x33ffffff
usbcore: registered new interface driver libusual
usbcore: registered new interface driver hiddev
usbcore: registered new interface driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:C1A3,PNP0f13:C1A4] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
mice: PS/2 mouse device common for all mice
nf_conntrack version 0.5.0 (4094 buckets, 32752 max)
TCP bic registered
Initializing XFRM netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI No-Shortcut mode
ACPI: (supports S0 S3 S4 S5)
Freeing unused kernel memory: 244k freed
Write protecting the kernel read-only data: 633k
Time: tsc clocksource has been installed.
Time: acpi_pm clocksource has been installed.
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt Link [C0C2] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [C0C2] -> GSI 10 (level, 
low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 10, io base 0x000048c0
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [C0C5] enabled at IRQ 5
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [C0C5] -> GSI 5 (level, low) 
-> IRQ 5
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 5, io base 0x000048e0
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [C0C4] -> GSI 5 (level, low) 
-> IRQ 5
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 5, io base 0x00004c00
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
Synaptics Touchpad, model: 1, fw: 5.9, id: 0x236eb3, caps: 0x904713/0x10008
input: SynPS/2 Synaptics TouchPad as /class/input/input0
input: AT Translated Set 2 keyboard as /class/input/input1
ohci_hcd: 2006 August 04 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [C0C9] enabled at IRQ 5
ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [C0C9] -> GSI 5 (level, low) 
-> IRQ 5
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 4
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: irq 5, io mem 0xa0000000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: 
dm-devel@redhat.com
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
audit(1167530360.470:2): enforcing=1 old_enforcing=0 auid=4294967295
security:  3 users, 6 roles, 1583 types, 172 bools, 1 sens, 1024 cats
security:  59 classes, 49428 rules
security:  class dccp_socket not defined in policy
security:  permission dccp_recv in class node not defined in policy
security:  permission dccp_send in class node not defined in policy
security:  permission dccp_recv in class netif not defined in policy
security:  permission dccp_send in class netif not defined in policy
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev dm-0, type ext3), uses xattr
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
SELinux: initialized (dev debugfs, type debugfs), uses genfs_contexts
SELinux: initialized (dev selinuxfs, type selinuxfs), uses genfs_contexts
SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
SELinux: initialized (dev hugetlbfs, type hugetlbfs), uses genfs_contexts
SELinux: initialized (dev devpts, type devpts), uses transition SIDs
SELinux: initialized (dev eventpollfs, type eventpollfs), uses task SIDs
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
audit(1167530360.820:3): policy loaded auid=4294967295
input: PC Speaker as /class/input/input2
ACPI: PCI Interrupt 0000:00:1f.3[B] -> Link [C0C3] -> GSI 10 (level, 
low) -> IRQ 10
ieee80211_crypt: registered algorithm 'NULL'
ieee80211: 802.11 data/management/control stack, git-1.1.13
ieee80211: Copyright (C) 2004-2005 Intel Corporation 
<jketreno@linux.intel.com>
iTCO_vendor_support: vendor-support=0
iTCO_wdt: Intel TCO WatchDog Timer Driver v1.01 (11-Nov-2006)
iTCO_wdt: Found a ICH4-M TCO device (Version=1, TCOBASE=0x1060)
iTCO_wdt: initialized. heartbeat=30 sec (nowayout=0)
intel_rng: FWH not detected
ieee1394: Initialized config rom entry `ip1394'
cs: IO port probe 0x100-0x3af: excluding 0x140-0x14f 0x200-0x20f 0x378-0x37f
cs: IO port probe 0x3e0-0x4ff: clean.
cs: IO port probe 0x820-0x8ff: clean.
cs: IO port probe 0xc00-0xcf7: clean.
cs: IO port probe 0xa00-0xaff: clean.
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [C0C2] -> GSI 10 (level, 
low) -> IRQ 10
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[10] 
MMIO=[90200000-902007ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.2.0kmprq
ipw2200: Copyright(c) 2003-2006 Intel Corporation
ACPI: PCI Interrupt 0000:02:02.0[A] -> Link [C0C5] -> GSI 5 (level, low) 
-> IRQ 5
ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
Floppy drive(s): fd0 is 1.44M
8139cp: 10/100 PCI Ethernet driver v1.3 (Mar 22, 2004)
ipw2200: Detected geography ZZM (11 802.11bg channels, 0 802.11a channels)
ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [C0C3] -> GSI 10 (level, 
low) -> IRQ 10
eth1: RTL-8139C+ at 0xe09a4000, 00:02:3f:65:4d:74, IRQ 10
sd 0:0:0:0: Attached scsi generic sg0 type 0
sr 1:0:0:0: Attached scsi generic sg1 type 5
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00023f383800c298]
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [C0C3] -> GSI 10 (level, 
low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.6 to 64
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [C0C3] -> GSI 10 (level, 
low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 59425 usecs
intel8x0: clocking to 48000
floppy0: no floppy controllers found
Floppy drive(s): fd0 is 1.44M
floppy0: no floppy controllers found
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
lp0: using parport0 (interrupt-driven).
lp0: console ready
ACPI: AC Adapter [C134] (on-line)
ACPI: Battery Slot [C11F] (battery present)
input: Power Button (FF) as /class/input/input3
ACPI: Power Button (FF) [PWRF]
input: Power Button (CM) as /class/input/input4
ACPI: Power Button (CM) [C1BE]
input: Lid Switch as /class/input/input5
ACPI: Lid Switch [C136]
No dock devices found.
ibm_acpi: ec object not found
ACPI: Video Device [C0D0] (multi-head: yes  rom: no  post: no)
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
EXT3 FS on dm-0, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev sda2, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
NTFS driver 2.1.27 [Flags: R/W MODULE].
NTFS volume version 3.1.
NTFS-fs warning (device sda1): load_system_files(): Unsupported volume 
flags 0x4000 encountered.
NTFS-fs error (device sda1): load_system_files(): Volume has unsupported 
flags set.  Mounting read-only.  Run chkdsk and mount in Windows.
SELinux: initialized (dev sda1, type ntfs), uses genfs_contexts
Adding 1048568k swap on /dev/VolGroup00/LogVol01.  Priority:-1 extents:1 
across:1048568k
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses 
genfs_contexts
ip_tables: (C) 2000-2006 Netfilter Core Team
eth0: link down
ACPI: EC: evaluating _Q09
Bluetooth: Core ver 2.11
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
Bluetooth: HIDP (Human Interface Emulation) ver 1.1
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
Mobile IPv6
eth0: link down
ADDRCONF(NETDEV_UP): eth0: link is not ready
ADDRCONF(NETDEV_UP): __tmp32284835: link is not ready
wbsd: Winbond W83L51xD SD/MMC card interface driver, 1.6
wbsd: Copyright(c) Pierre Ossman
pnp: Device 00:02 activated.
mmc0: W83L51xD id 7112 at 0x248 irq 6 dma 0 PnP
[drm] Initialized drm 1.1.0 20060810
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [C0C2] -> GSI 10 (level, 
low) -> IRQ 10
[drm] Initialized radeon 1.25.0 20060524 on minor 0
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
[drm] Setting GART location based on new memory map
[drm] Loading R200 Microcode
[drm] writeback test succeeded in 2 usecs
ADDRCONF(NETDEV_CHANGE): __tmp32284835: link becomes ready
ieee80211_crypt: registered algorithm 'CCMP'
__tmp32284835: no IPv6 routers present
ADDRCONF(NETDEV_UP): __tmp32284835: link is not ready
ACPI: PCI interrupt for device 0000:02:02.0 disabled
ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.2.0kmprq
ipw2200: Copyright(c) 2003-2006 Intel Corporation
ACPI: PCI Interrupt 0000:02:02.0[A] -> Link [C0C5] -> GSI 5 (level, low) 
-> IRQ 5
ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
ipw2200: Detected geography ZZM (11 802.11bg channels, 0 802.11a channels)
eth1: no IPv6 routers present
Disabling non-boot CPUs ...
Stopping tasks ... done.
Shrinking memory...  -\|/-done (67667 pages freed)
Freed 270668 kbytes in 0.55 seconds (492.12 MB/s)
Suspending console(s)
pnp: Device 00:05 disabled.
pnp: Device 00:03 disabled.
pnp: Device 00:02 disabled.
eth1: Going into suspend...
ACPI: PCI interrupt for device 0000:02:02.0 disabled
ohci1394 does not fully support suspend and resume yet
ACPI: PCI interrupt for device 0000:00:1f.6 disabled
codec_write 0: semaphore is not ready for register 0x26
ACPI: PCI interrupt for device 0000:00:1f.5 disabled
ACPI: PCI interrupt for device 0000:00:1d.7 disabled
ACPI: PCI interrupt for device 0000:00:1d.2 disabled
ACPI: PCI interrupt for device 0000:00:1d.1 disabled
ACPI: PCI interrupt for device 0000:00:1d.0 disabled
swsusp: critical section:
swsusp: Need to copy 56787 pages
swsusp: critical section/: done (56787 pages copied)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [C0C2] -> GSI 10 (level, 
low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1d.0 to 64
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [C0C5] -> GSI 5 (level, low) 
-> IRQ 5
PCI: Setting latency timer of device 0000:00:1d.1 to 64
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [C0C4] -> GSI 5 (level, low) 
-> IRQ 5
PCI: Setting latency timer of device 0000:00:1d.2 to 64
PCI: Enabling device 0000:00:1d.7 (0000 -> 0002)
ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [C0C9] -> GSI 5 (level, low) 
-> IRQ 5
PCI: Setting latency timer of device 0000:00:1d.7 to 64
PM: Writing back config space on device 0000:00:1d.7 at offset f (was 
400, writing 405)
PM: Writing back config space on device 0000:00:1d.7 at offset 4 (was 0, 
writing a0000000)
PCI: Setting latency timer of device 0000:00:1e.0 to 64
PCI: Setting latency timer of device 0000:00:1f.1 to 64
ACPI: PCI Interrupt 0000:00:1f.3[B] -> Link [C0C3] -> GSI 10 (level, 
low) -> IRQ 10
PM: Writing back config space on device 0000:00:1f.5 at offset f (was 
200, writing 20a)
PM: Writing back config space on device 0000:00:1f.5 at offset 7 (was 0, 
writing a0300000)
PM: Writing back config space on device 0000:00:1f.5 at offset 6 (was 0, 
writing a0200000)
PM: Writing back config space on device 0000:00:1f.5 at offset 5 (was 1, 
writing 4881)
PM: Writing back config space on device 0000:00:1f.5 at offset 4 (was 1, 
writing 4001)
PM: Writing back config space on device 0000:00:1f.5 at offset 1 (was 
2900000, writing 2900003)
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [C0C3] -> GSI 10 (level, 
low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.5 to 64
PM: Writing back config space on device 0000:00:1f.6 at offset f (was 
200, writing 20a)
PM: Writing back config space on device 0000:00:1f.6 at offset 5 (was 1, 
writing 4801)
PM: Writing back config space on device 0000:00:1f.6 at offset 4 (was 1, 
writing 4401)
PM: Writing back config space on device 0000:00:1f.6 at offset 1 (was 
2900000, writing 2900001)
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [C0C3] -> GSI 10 (level, 
low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.6 to 64
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [C0C2] -> GSI 10 (level, 
low) -> IRQ 10
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[10] 
MMIO=[90200000-902007ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
eth1: Coming out of suspend...
PCI: Enabling device 0000:02:02.0 (0000 -> 0002)
ACPI: PCI Interrupt 0000:02:02.0[A] -> Link [C0C5] -> GSI 5 (level, low) 
-> IRQ 5
PM: Writing back config space on device 0000:02:02.0 at offset f (was 
18030100, writing 1803010b)
PM: Writing back config space on device 0000:02:02.0 at offset 4 (was 0, 
writing 90000000)
PM: Writing back config space on device 0000:02:02.0 at offset 3 (was 0, 
writing 8008)
PM: Writing back config space on device 0000:02:02.0 at offset 1 (was 
2900002, writing 2900006)
pnp: Device 00:02 activated.
pnp: Device 00:03 activated.
pnp: Device 00:05 activated.
pnp: Device 00:0a does not support activation.
pnp: Device 00:0b does not support activation.
ata1: EH complete
ata2: EH complete
swsusp: Cannot find swap device, try swapon -a.
Restarting tasks ... done.
Enabling non-boot CPUs ...
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
[drm] Loading R200 Microcode


-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/
