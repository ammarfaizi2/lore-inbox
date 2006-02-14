Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030331AbWBNECE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030331AbWBNECE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 23:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030342AbWBNECD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 23:02:03 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:6860 "EHLO
	pd5mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1030335AbWBNEB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 23:01:58 -0500
Date: Mon, 13 Feb 2006 22:01:51 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Compaq X1050 multiple suspend problems (ACPI, PS2)
In-reply-to: <3ACA40606221794F80A5670F0AF15F840AEE1EB2@pdsmsx403>
To: "Yu, Luming" <luming.yu@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43F1562F.8060807@shaw.ca>
MIME-version: 1.0
Content-type: multipart/mixed; boundary=------------030208030508050902080109
References: <3ACA40606221794F80A5670F0AF15F840AEE1EB2@pdsmsx403>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030208030508050902080109
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I have not seen any ACPI errors other than during suspend/resume.

Tried ec_intr=0 option on the command line, same problem.

ACPI_EC_DELAY=100 patch did not help either, same or at least similar 
problem. Output attached.

Yu, Luming wrote:
>> No luck with 2.6.16-rc3. Slightly different messages, but still ACPI 
>> complaints about EC, battery status polling fails and the 
>> keyboard loses 
>> characters after resume. Full dmesg attached.
>>
> Do you have such issues before resume?
> What about ec_intr=0?
> 
> I found "ACPI: read EC, IB not empty" in the dmesg.
> Could you try this against 2.6.16-rc3
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index 79b09d7..c4c9ded 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -51,7 +51,7 @@ ACPI_MODULE_NAME("acpi_ec")
>  #define ACPI_EC_FLAG_SCI       0x20    /* EC-SCI occurred */
>  #define ACPI_EC_EVENT_OBF      0x01    /* Output buffer full */
>  #define ACPI_EC_EVENT_IBE      0x02    /* Input buffer empty */
> -#define ACPI_EC_DELAY          50      /* Wait 50ms max. during EC ops
> */
> +#define ACPI_EC_DELAY          100     /* Wait 50ms max. during EC ops
> */
>  #define ACPI_EC_UDELAY_GLK     1000    /* Wait 1ms max. to get global
> lock */
>  #define ACPI_EC_UDELAY         100     /* Poll @ 100us increments */
>  #define ACPI_EC_UDELAY_COUNT   1000    /* Wait 10ms max. during EC ops
> */
> 

--------------030208030508050902080109
Content-Type: text/plain;
 name="dmesg2.6.16-rc3delay100.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg2.6.16-rc3delay100.txt"

Linux version 2.6.16-rc3 (rob@Banias) (gcc version 4.0.2 20051125 (Red Hat 4.0.2-8)) #2 Mon Feb 13 21:45:29 CST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ffd0000 (usable)
 BIOS-e820: 000000001ffd0000 - 000000001fff0c00 (reserved)
 BIOS-e820: 000000001fff0c00 - 000000001fffc000 (ACPI NVS)
 BIOS-e820: 000000001fffc000 - 0000000020000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131024
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 126928 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:0
DMI 2.3 present.
ACPI: RSDP (v000 COMPAQ                                ) @ 0x000f6560
ACPI: RSDT (v001 HP     CPQ0860  0x14070520 CPQ  0x00000001) @ 0x1fff0c84
ACPI: FADT (v002 HP     CPQ0860  0x00000002 CPQ  0x00000001) @ 0x1fff0c00
ACPI: SSDT (v001 COMPAQ  CPQGysr 0x00001001 MSFT 0x0100000e) @ 0x1fff5c3c
ACPI: DSDT (v001 HP       nx7000 0x00010000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
Allocating PCI resources starting at 30000000 (gap: 20000000:e0000000)
Built 1 zonelists
Kernel command line: ro root=LABEL=/
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01404000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c0438000 soft=c0439000
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 598.137 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 513860k/524096k available (2302k kernel code, 9636k reserved, 760k data, 208k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1198.30 BogoMIPS (lpj=2396610)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 512
CPU: After generic identify, caps: a7e9f9bf 00000000 00000000 00000000 00000180 00000000 00000000
CPU: After vendor identify, caps: a7e9f9bf 00000000 00000000 00000000 00000180 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU: After all inits, caps: a7e9f9bf 00000000 00000000 00000040 00000180 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel(R) Pentium(R) M processor 1400MHz stepping 05
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0c20)
checking if image is initramfs... it is
Freeing initrd memory: 1070k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf031f, last bus=3
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [C046] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.C046] bus is 0
PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 1100-113f claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
PCI: Transparent bridge - 0000:00:1e.0
PCI: Bus #03 (-#06) may be hidden behind transparent bridge #02 (-#03) (try 'pci=assign-busses')
ACPI: PCI Interrupt Routing Table [\_SB_.C046._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C046.C047._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C046.C058._PRT]
ACPI: Embedded Controller [C0EA] (gpe 28) interrupt mode.
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
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
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
  PREFETCH window: 30000000-31ffffff
  MEM window: 34000000-35ffffff
PCI: Bridge: 0000:00:1e.0
  IO window: 2000-2fff
  MEM window: 90000000-903fffff
  PREFETCH window: 30000000-31ffffff
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt Link [C0C4] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:02:04.0[A] -> Link [C0C4] -> GSI 5 (level, low) -> IRQ 5
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
apm: overridden by ACPI.
audit: initializing netlink socket (disabled)
audit(1139867464.128:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
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
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 855PM Chipset.
agpgart: AGP aperture is 256M @ 0xb0000000
PNP: PS/2 Controller [PNP0303:C1A3,PNP0f13:C1A4] at 0x60,0x64 irq 1,12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS2 at I/O 0x3e8 (irq = 3) is a 16550A
00:03: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ACPI: PCI Interrupt Link [C0C3] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [C0C3] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI interrupt for device 0000:00:1f.6 disabled
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [C0C4] -> GSI 5 (level, low) -> IRQ 5
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x4c40-0x4c47, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x4c48-0x4c4f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: SAMSUNG MP0804H, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: QSI CD-RW/DVD-ROM SBW-241, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 512KiB
hda: 156368016 sectors (80060 MB) w/8192KiB Cache, CHS=16383/255/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3 hda4 < hda5 >
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
usbcore: registered new driver libusual
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
MC: drivers/edac/edac_mc.c version edac_mc  Ver: 2.0.0 Feb 13 2006
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard as /class/input/input0
IP route cache hash table entries: 8192 (order: 3, 32768 bytes)
TCP established hash table entries: 32768 (order: 7, 524288 bytes)
TCP bind hash table entries: 32768 (order: 7, 655360 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP reno registered
TCP bic registered
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI wakeup devices: 
C058 C1AD C1A3 C1A4 C0AC C0B3 C0B4 C0B5 C0E7 C136 
ACPI: (supports S0 S3 S4 S5)
Freeing unused kernel memory: 208k freed
Write protecting the kernel read-only data: 345k
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Synaptics Touchpad, model: 1, fw: 5.9, id: 0x236eb3, caps: 0x904713/0x10008
input: SynPS/2 Synaptics TouchPad as /class/input/input1
security:  3 users, 6 roles, 878 types, 101 bools
security:  55 classes, 239681 rules
SELinux:  Completing initialization.
SELinux:  Setting up existing superblocks.
SELinux: initialized (dev hda5, type ext3), uses xattr
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
SELinux: initialized (dev proc, type proc), uses genfs_contexts
SELinux: initialized (dev bdev, type bdev), uses genfs_contexts
SELinux: initialized (dev rootfs, type rootfs), uses genfs_contexts
SELinux: initialized (dev sysfs, type sysfs), uses genfs_contexts
SELinux: initialized (dev usbfs, type usbfs), uses genfs_contexts
Floppy drive(s): fd0 is 1.44M
floppy0: no floppy controllers found
8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [C0C3] -> GSI 10 (level, low) -> IRQ 10
eth0: RTL-8139C+ at 0xe0830000, 00:02:3f:65:4d:74, IRQ 10
8139too Fast Ethernet driver 0.9.27
ieee80211_crypt: registered algorithm 'NULL'
ieee80211: 802.11 data/management/control stack, git-1.1.7
ieee80211: Copyright (C) 2004-2005 Intel Corporation <jketreno@linux.intel.com>
ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, git-1.0.8
ipw2200: Copyright(c) 2003-2005 Intel Corporation
ACPI: PCI Interrupt Link [C0C5] enabled at IRQ 5
ACPI: PCI Interrupt 0000:02:02.0[A] -> Link [C0C5] -> GSI 5 (level, low) -> IRQ 5
ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [C0C3] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.5 to 64
intel8x0_measure_ac97_clock: measured 55308 usecs
intel8x0: clocking to 48000
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [C0C3] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.6 to 64
hw_random: cannot enable RNG, aborting
ACPI: PCI Interrupt Link [C0C9] enabled at IRQ 5
ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [C0C9] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 5, io mem 0xa0000000
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt Link [C0C2] enabled at IRQ 10
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [C0C2] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 10, io base 0x000048c0
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [C0C5] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 5, io base 0x000048e0
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [C0C4] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 5, io base 0x00004c00
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:02:04.0[A] -> Link [C0C4] -> GSI 5 (level, low) -> IRQ 5
Yenta: CardBus bridge found at 0000:02:04.0 [0e11:0860]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:04.0, mfunc 0x001c1112, devctl 0x44
Yenta: ISA IRQ mask 0x08d8, PCI irq 5
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x2000 - 0x2fff
cs: IO port probe 0x2000-0x2fff: clean.
pcmcia: parent PCI bridge Memory window: 0x90000000 - 0x903fffff
pcmcia: parent PCI bridge Memory window: 0x30000000 - 0x31ffffff
ieee1394: Initialized config rom entry `ip1394'
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [C0C2] -> GSI 10 (level, low) -> IRQ 10
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[10]  MMIO=[90200000-902007ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00023f383800c298]
ACPI: AC Adapter [C134] (off-line)
ACPI: Battery Slot [C11F] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [C1BE]
ACPI: Lid Switch [C136]
ibm_acpi: ec object not found
ACPI: Video Device [C0D0] (multi-head: yes  rom: no  post: no)
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
EXT3 FS on hda5, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
SELinux: initialized (dev hda2, type ext3), uses xattr
SELinux: initialized (dev tmpfs, type tmpfs), uses transition SIDs
NTFS driver 2.1.25 [Flags: R/O MODULE].
NTFS volume version 3.1.
SELinux: initialized (dev hda1, type ntfs), uses genfs_contexts
Adding 1232272k swap on /dev/hda3.  Priority:-1 extents:1 across:1232272k
SELinux: initialized (dev binfmt_misc, type binfmt_misc), uses genfs_contexts
ip_tables: (C) 2000-2006 Netfilter Core Team
Netfilter messages via NETLINK v0.30.
ip_conntrack version 2.4 (4094 buckets, 32752 max) - 232 bytes per conntrack
pcmcia: Detected deprecated PCMCIA ioctl usage.
pcmcia: This interface will soon be removed from the kernel; please expect breakage unless you upgrade to new tools.
pcmcia: see http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for details.
cs: IO port probe 0xc00-0xcff: clean.
cs: IO port probe 0x800-0x8ff: clean.
cs: IO port probe 0x100-0x4ff: excluding 0x140-0x14f 0x200-0x20f 0x378-0x37f
cs: IO port probe 0xa00-0xaff: clean.
eth0: link down
audit(1139889111.387:2): avc:  denied  { read } for  pid=2261 comm="auditd" name="[5581]" dev=pipefs ino=5581 scontext=system_u:system_r:auditd_t tcontext=system_u:system_r:auditd_t tclass=fifo_file
SELinux: initialized (dev autofs, type autofs), uses genfs_contexts
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
lp0: using parport0 (interrupt-driven).
lp0: console ready
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
eth1: no IPv6 routers present
[drm] Initialized drm 1.0.1 20051102
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [C0C2] -> GSI 10 (level, low) -> IRQ 10
[drm] Initialized radeon 1.21.0 20051229 on minor 0
mtrr: 0x98000000,0x8000000 overlaps existing 0x98000000,0x2000000
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
[drm] Loading R200 Microcode
audit(:0): major=252 name_count=0: freeing multiple contexts (1)
audit(:0): major=113 name_count=0: freeing multiple contexts (2)
Stopping tasks: ===============================================================================================|
pnp: Device 00:05 disabled.
pnp: Device 00:03 disabled.
ACPI: PCI interrupt for device 0000:02:04.0 disabled
eth1: Going into suspend...
ACPI: PCI interrupt for device 0000:02:02.0 disabled
ACPI: PCI interrupt for device 0000:00:1f.6 disabled
ACPI: PCI interrupt for device 0000:00:1f.5 disabled
ACPI: PCI interrupt for device 0000:00:1d.7 disabled
ACPI: PCI interrupt for device 0000:00:1d.2 disabled
ACPI: PCI interrupt for device 0000:00:1d.1 disabled
ACPI: PCI interrupt for device 0000:00:1d.0 disabled
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
Back to C!
Debug: sleeping function called from invalid context at mm/slab.c:2666
in_atomic():0, irqs_disabled():1
 [<c015e094>] kmem_cache_alloc+0x54/0x70
 [<c021039e>] acpi_os_acquire_object+0xb/0x36
 [<c0224f5b>] acpi_ut_allocate_object_desc_dbg+0x10/0x3e
 [<c0224fce>] acpi_ut_create_internal_object_dbg+0xf/0x5e
 [<c022161f>] acpi_rs_set_srs_method_data+0x3d/0xba
 [<c010664c>] get_cmos_time+0x15c/0x170
 [<c0228888>] acpi_pci_link_set+0xf4/0x168
 [<c0228930>] irqrouter_resume+0x34/0x52
 [<c025f781>] __sysdev_resume+0x11/0x80
 [<c025f837>] sysdev_resume+0x47/0x70
 [<c0264895>] device_power_up+0x5/0x10
 [<c013cb55>] enter_state+0x175/0x1d0
 [<c013cc45>] state_store+0x95/0xb0
 [<c013cbb0>] state_store+0x0/0xb0
 [<c01a18c9>] subsys_attr_store+0x29/0x40
 [<c01a1e90>] sysfs_write_file+0xa0/0xf0
 [<c01a1df0>] sysfs_write_file+0x0/0xf0
 [<c01619ef>] vfs_write+0xbf/0x180
 [<c01623f1>] sys_write+0x41/0x70
 [<c0102e3d>] syscall_call+0x7/0xb
PCI: Enabling device 0000:00:1d.0 (0000 -> 0001)
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [C0C2] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1d.0 to 64
usb usb2: root hub lost power or was reset
PCI: Enabling device 0000:00:1d.1 (0000 -> 0001)
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [C0C5] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1d.1 to 64
usb usb3: root hub lost power or was reset
PCI: Enabling device 0000:00:1d.2 (0000 -> 0001)
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [C0C4] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1d.2 to 64
usb usb4: root hub lost power or was reset
PCI: Enabling device 0000:00:1d.7 (0000 -> 0002)
ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [C0C9] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:1d.7 to 64
usb usb1: root hub lost power or was reset
ehci_hcd 0000:00:1d.7: debug port 1
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
PCI: Setting latency timer of device 0000:00:1e.0 to 64
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [C0C4] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [C0C3] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.5 to 64
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [C0C3] -> GSI 10 (level, low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.6 to 64
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [C0C2] -> GSI 10 (level, low) -> IRQ 10
PCI: Enabling device 0000:02:00.0 (0080 -> 0083)
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [C0C2] -> GSI 10 (level, low) -> IRQ 10
PCI: Via IRQ fixup for 0000:02:00.0, from 0 to 10
eth1: Coming out of suspend...
PCI: Enabling device 0000:02:02.0 (0000 -> 0002)
ACPI: PCI Interrupt 0000:02:02.0[A] -> Link [C0C5] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt 0000:02:04.0[A] -> Link [C0C4] -> GSI 5 (level, low) -> IRQ 5
pnp: Device 00:03 activated.
pnp: Device 00:05 activated.
pnp: Device 00:0a does not supported activation.
pnp: Device 00:0b does not supported activation.
Restarting tasks... done
ACPI: read EC, IB not empty
ACPI Exception (evregion-0409): AE_TIME, Returned by Handler for [EmbeddedControl] [20060127]
ACPI Exception (dswexec-0458): AE_TIME, While resolving operands for [AE_NOT_CONFIGURED] [20060127]
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C046.C059.C0EA.C11D] (Node dfea0280), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\_WAK] (Node c14dc500), AE_TIME
ACPI Exception (hwsleep-0546): AE_TIME, During Method _WAK [20060127]
Synaptics Touchpad, model: 1, fw: 5.9, id: 0x236eb3, caps: 0x904713/0x10008
input: SynPS/2 Synaptics TouchPad as /class/input/input2
audit(:0): major=252 name_count=0: freeing multiple contexts (1)
audit(:0): major=113 name_count=0: freeing multiple contexts (2)
audit(:0): major=252 name_count=0: freeing multiple contexts (1)
audit(:0): major=113 name_count=0: freeing multiple contexts (2)
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 1x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 1x mode
[drm] Loading R200 Microcode
ACPI: read EC, IB not empty
ACPI Exception (evregion-0409): AE_TIME, Returned by Handler for [EmbeddedControl] [20060127]
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C046.C059.C0EA.C132] (Node dfea01e0), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C132] (Node c14dde20), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C11F._BST] (Node c14ddd60), AE_TIME
ACPI: read EC, IB not empty
ACPI Exception (evregion-0409): AE_TIME, Returned by Handler for [EmbeddedControl] [20060127]
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C046.C059.C0EA.C132] (Node dfea01e0), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C132] (Node c14dde20), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C11F._BST] (Node c14ddd60), AE_TIME
ACPI: read EC, IB not empty
ACPI Exception (evregion-0409): AE_TIME, Returned by Handler for [EmbeddedControl] [20060127]
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C046.C059.C0EA.C132] (Node dfea01e0), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C132] (Node c14dde20), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C11F._BST] (Node c14ddd60), AE_TIME
ACPI: read EC, IB not empty
ACPI Exception (evregion-0409): AE_TIME, Returned by Handler for [EmbeddedControl] [20060127]
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C046.C059.C0EA.C132] (Node dfea01e0), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C132] (Node c14dde20), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C11F._BST] (Node c14ddd60), AE_TIME
ACPI: read EC, IB not empty
ACPI Exception (evregion-0409): AE_TIME, Returned by Handler for [EmbeddedControl] [20060127]
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C046.C059.C0EA.C132] (Node dfea01e0), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C132] (Node c14dde20), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C11F._BST] (Node c14ddd60), AE_TIME
ACPI: read EC, IB not empty
ACPI Exception (evregion-0409): AE_TIME, Returned by Handler for [EmbeddedControl] [20060127]
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C046.C059.C0EA.C132] (Node dfea01e0), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C132] (Node c14dde20), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C11F._BST] (Node c14ddd60), AE_TIME
eth0: link down
ADDRCONF(NETDEV_UP): eth0: link is not ready
ipw2200: Unknown notification: subtype=40,flags=0xa0,size=40
ACPI: read EC, IB not empty
ACPI Exception (evregion-0409): AE_TIME, Returned by Handler for [EmbeddedControl] [20060127]
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C046.C059.C0EA.C132] (Node dfea01e0), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C132] (Node c14dde20), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C11F._BST] (Node c14ddd60), AE_TIME
ACPI: read EC, IB not empty
ACPI Exception (evregion-0409): AE_TIME, Returned by Handler for [EmbeddedControl] [20060127]
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C046.C059.C0EA.C132] (Node dfea01e0), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C132] (Node c14dde20), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C11F._BST] (Node c14ddd60), AE_TIME
ACPI: read EC, IB not empty
ACPI Exception (evregion-0409): AE_TIME, Returned by Handler for [EmbeddedControl] [20060127]
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C046.C059.C0EA.C132] (Node dfea01e0), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C132] (Node c14dde20), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C11F._BST] (Node c14ddd60), AE_TIME
ipw2200: Unknown notification: subtype=40,flags=0xa0,size=40
ACPI: read EC, IB not empty
ACPI Exception (evregion-0409): AE_TIME, Returned by Handler for [EmbeddedControl] [20060127]
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C046.C059.C0EA.C132] (Node dfea01e0), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C132] (Node c14dde20), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C11F._BST] (Node c14ddd60), AE_TIME
ACPI: read EC, IB not empty
ACPI Exception (evregion-0409): AE_TIME, Returned by Handler for [EmbeddedControl] [20060127]
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C046.C059.C0EA.C132] (Node dfea01e0), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C132] (Node c14dde20), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C11F._BST] (Node c14ddd60), AE_TIME
ACPI: read EC, IB not empty
ACPI Exception (evregion-0409): AE_TIME, Returned by Handler for [EmbeddedControl] [20060127]
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C046.C059.C0EA.C132] (Node dfea01e0), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C132] (Node c14dde20), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C11F._BST] (Node c14ddd60), AE_TIME
ACPI: read EC, IB not empty
ACPI Exception (evregion-0409): AE_TIME, Returned by Handler for [EmbeddedControl] [20060127]
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C046.C059.C0EA.C132] (Node dfea01e0), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C132] (Node c14dde20), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C11F._BST] (Node c14ddd60), AE_TIME
ipw2200: Unknown notification: subtype=40,flags=0xa0,size=40
ACPI: read EC, IB not empty
ACPI Exception (evregion-0409): AE_TIME, Returned by Handler for [EmbeddedControl] [20060127]
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C046.C059.C0EA.C132] (Node dfea01e0), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C132] (Node c14dde20), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C11F._BST] (Node c14ddd60), AE_TIME
ACPI: read EC, IB not empty
ACPI Exception (evregion-0409): AE_TIME, Returned by Handler for [EmbeddedControl] [20060127]
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C046.C059.C0EA.C132] (Node dfea01e0), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C132] (Node c14dde20), AE_TIME
ACPI Error (psparse-0517): Method parse/execution failed [\_SB_.C11F._BST] (Node c14ddd60), AE_TIME

--------------030208030508050902080109--
