Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbUJWRy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbUJWRy5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 13:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbUJWRy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 13:54:57 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:39906 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261259AbUJWRxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 13:53:48 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.9-mm1: NForce3 problem (update)
Date: Sat, 23 Oct 2004 19:55:22 +0200
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>, Zwane Mwaikambo <zwane@linuxpower.ca>
References: <200410222354.44563.rjw@sisk.pl> <20041022162656.2f9ca653.akpm@osdl.org> <200410231909.09931.rjw@sisk.pl>
In-Reply-To: <200410231909.09931.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_KspeB03/CPA2Bpt"
Message-Id: <200410231955.22819.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_KspeB03/CPA2Bpt
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 23 of October 2004 19:09, Rafael J. Wysocki wrote:
> On Saturday 23 of October 2004 01:26, you wrote:
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > >
> > > Hi,
> > > 
> > > I have a problem with 2.6.9-mm1 on an AMD64 NForce3-based box.  Namely, 
> after 
> > > some time in X, USB suddenly stops working and sound goes off 
> simultaneously 
> > > (it's quite annoying, as I use a USB mouse ;-)).  It is 100% 
reproducible 
> and 
> > > it may be related to the sharing of IRQ 5:
> > > 
> > > rafael@albercik:~> cat /proc/interrupts
> > >            CPU0
> > >   0:    3499292          XT-PIC  timer
> > >   1:       7135          XT-PIC  i8042
> > >   2:          0          XT-PIC  cascade
> > >   5:       6945          XT-PIC  NVidia nForce3, ohci_hcd
> > >   8:          0          XT-PIC  rtc
> > >   9:       1416          XT-PIC  acpi, yenta
> > >  10:          2          XT-PIC  ehci_hcd
> > >  11:      37266          XT-PIC  SysKonnect SK-98xx, yenta, ohci1394, 
> ohci_hcd
> > >  12:      13781          XT-PIC  i8042
> > >  14:         16          XT-PIC  ide0
> > >  15:      23601          XT-PIC  ide1
> > > NMI:          0
> > > LOC:    3498657
> > > ERR:          1
> > > MIS:          0
[-- snip --]

It happened again, on 2.6.9-mm1, and this time the network adapter stopped 
working along with the USB (like on 2.6.10-rc1).  I unloaded the ohci-hcd, 
ehci-hcd and sk98lin modules and loaded them again, and this apparently _did_ 
help.

I'm attaching the "fresh" output of dmesg (the "IRQ INTR_SF lossage" message 
from ohci_hcd looks suspiciously to me).

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--Boundary-00=_KspeB03/CPA2Bpt
Content-Type: text/x-log;
  charset="iso-8859-2";
  name="2.6.9-mm1-dmesg-2.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="2.6.9-mm1-dmesg-2.log"

Bootdata ok (command line is root=/dev/hdc6 vga=792 resume=/dev/hdc3 pci=routeirq nmi_watchdog=0 console=ttyS0,57600 console=tty0 debug)
Linux version 2.6.9-mm1 (rafael@albercik) (gcc version 3.3.3 (SuSE Linux)) #3 Sat Oct 23 18:40:43 CEST 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ff40000 (usable)
 BIOS-e820: 000000001ff40000 - 000000001ff50000 (ACPI data)
 BIOS-e820: 000000001ff50000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
No mptable found.
On node 0 totalpages: 130880
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126784 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
Nvidia board detected. Ignoring ACPI timer override.
ACPI: RSDP (v000 ACPIAM                                ) @ 0x00000000000f76e0
ACPI: RSDT (v001 A M I  OEMRSDT  0x04000413 MSFT 0x00000097) @ 0x000000001ff40000
ACPI: FADT (v001 A M I  OEMFACP  0x04000413 MSFT 0x00000097) @ 0x000000001ff40200
ACPI: OEMB (v001 A M I  OEMBIOS  0x04000413 MSFT 0x00000097) @ 0x000000001ff50040
  >>> ERROR: Invalid checksum
ACPI: DSDT (v001  L5DK8 L5DK8013 0x00000013 INTL 0x02002026) @ 0x0000000000000000
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: ASUSTeK  <6>Product ID: L5D          <6>APIC at: 0xFEE00000
Processor #0 15:4 APIC version 16
I/O APIC #1 Version 17 at 0xFEC00000.
Setting APIC routing to flat
Processors: 1
Checking aperture...
CPU 0: aperture @ e8000000 size 128 MB
Built 1 zonelists
Initializing CPU#0
Kernel command line: root=/dev/hdc6 vga=792 resume=/dev/hdc3 pci=routeirq nmi_watchdog=0 console=ttyS0,57600 console=tty0 debug
PID hash table entries: 2048 (order: 11, 65536 bytes)
time.c: Using 1.193182 MHz PIT timer.
time.c: Detected 1795.385 MHz processor.
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
Memory: 509428k/523520k available (2784k kernel code, 13528k reserved, 1150k data, 160k init)
Calibrating delay loop... 3555.32 BogoMIPS (lpj=1777664)
Security Framework v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
selinux_register_security:  Registering secondary module capability
Capability LSM initialized as secondary
Mount-cache hash table entries: 256 (order: 0, 4096 bytes)
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 1024K (64 bytes/line)
CPU: AMD Athlon(tm) 64 Processor 3000+ stepping 0a
ACPI: IRQ9 SCI: Edge set to Level Trigger.
Using IO-APIC 1
..MP-BIOS bug: 8254 timer not connected to IO-APIC
works.
Using local APIC timer interrupts.
Detected 12.467 MHz APIC timer.
NET: Registered protocol family 16
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040816
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Embedded Controller [EC0] (gpe 37)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P1._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P2._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUS0] (IRQs 3 4 5 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUS1] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUS2] (IRQs 3 4 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LKLN] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.<7>Losing some ticks... checking if CPU frequency changed.

ACPI: PCI Interrupt Link [LAUI] (IRQs 3 4 *5 7 9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LKMO] (IRQs 3 4 5 7 9 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LKSM] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LTID] (IRQs 3 4 5 7 9 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LATA] (IRQs 3 4 6 7 10 11 12 *14 15)
ACPI: Power Resource [GFAN] (off)
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
** Routing PCI interrupts for all devices because "pci=routeirq"
** was specified.  If this was required to make a driver work,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
ACPI: PCI Interrupt Link [LKSM] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI interrupt 0000:00:01.1[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LUS0] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LUS1] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt Link [LUS2] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LAUI] enabled at IRQ 5
ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI Interrupt Link [LKMO] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:06.1[B] -> GSI 10 (level, low) -> IRQ 10
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
PCI: setting IRQ 9 as level-triggered
ACPI: PCI interrupt 0000:02:01.0[A] -> GSI 9 (level, low) -> IRQ 9
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI interrupt 0000:02:01.1[B] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:02:01.2[C] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
ACPI: PCI interrupt 0000:02:01.3[D] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI interrupt 0000:02:01.4[D] -> GSI 5 (level, low) -> IRQ 5
ACPI: PCI interrupt 0000:02:02.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
ACPI: PCI interrupt 0000:01:00.0[A] -> GSI 11 (level, low) -> IRQ 11
agpgart: Detected AGP bridge 0
agpgart: Setting up Nforce3 AGP.
agpgart: Maximum main memory to use for agp memory: 439M
agpgart: AGP aperture is 128M @ 0xe8000000
PCI-DMA: Disabling IOMMU.
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
audit: initializing netlink socket (disabled)
warning: many lost ticks.
Your time source seems to be instable or some driver is hogging interupts
rip release_console_sem+0x27d/0x380
audit(1098552091.815:0): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
SELinux:  Registering netfilter hooks
Initializing Cryptographic API
vesafb: framebuffer at 0xd0000000, mapped to 0xffffff0000100000, using 6144k, total 65536k
vesafb: mode is 1024x768x32, linelength=4096, pages=1
vesafb: scrolling: redraw
vesafb: Truecolor: size=8:8:8:8, shift=24:16:8:0
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
Real Time Clock Driver v1.12
Linux agpgart interface v0.100 (c) Dave Jones
ACPI: PS/2 Keyboard Controller [PS2K] at I/O 0x60, 0x64, irq 1
ACPI: PS/2 Mouse Controller [PS2M] at irq 12
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ACPI: PCI interrupt 0000:00:06.1[B] -> GSI 10 (level, low) -> IRQ 10
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 128000K size 1024 blocksize
loop: loaded (max 8 devices)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE3-150: IDE controller at PCI slot 0000:00:08.0
NFORCE3-150: chipset revision 165
NFORCE3-150: not 100% native mode: will probe irqs later
NFORCE3-150: BIOS didn't set cable bits correctly. Enabling workaround.
NFORCE3-150: 0000:00:08.0 (rev a5) UDMA133 controller
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:DMA
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hdb: TOSHIBA DVD-ROM SD-R2512, ATAPI CD/DVD-ROM drive
elevator: using anticipatory as default io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: IC25N060ATMR04-0, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
Probing IDE interface ide2...
ide2: Wait for ready failed before probe !
Probing IDE interface ide3...
ide3: Wait for ready failed before probe !
Probing IDE interface ide4...
ide4: Wait for ready failed before probe !
Probing IDE interface ide5...
ide5: Wait for ready failed before probe !
hdc: max request size: 1024KiB
hdc: 117210240 sectors (60011 MB) w/7884KiB Cache, CHS=16383/255/63, UDMA(100)
hdc: cache flushes supported
 hdc: hdc1 hdc2 hdc3 hdc4 < hdc5 hdc6 hdc7 hdc8 hdc9 hdc10 >
hdb: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
Synaptics Touchpad, model: 1
 Firmware: 5.9
 180 degree mounted touchpad
 Sensor: 18
 new absolute packet format
 Touchpad has extended capability bits
 -> four buttons
 -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
NET: Registered protocol family 2
IP: routing cache hash table of 512 buckets, 28Kbytes
TCP: Hash tables configured (established 32768 bind 4681)
NET: Registered protocol family 1
PM: Reading pmdisk image.
swsusp: Resume From Partition: /dev/hdc3
<3>swsusp: Invalid partition type.
pmdisk: Error -22 resuming
PM: Resume from disk failed.
ACPI: (supports S0 S1 S3 S4 S5)
ACPI wakeup devices: 
 MDM P0P1 LAN0 LAN1 USB0 USB1 USB2 SLPB 
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 160k freed
Adding 1534196k swap on /dev/hdc3.  Priority:42 extents:1
EXT3 FS on hdc6, internal journal
device-mapper: 4.1.0-ioctl (2003-12-10) initialised: dm@uk.sistina.com
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdc5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdc7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdc8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ReiserFS: hdc9: found reiserfs format "3.6" with standard journal
ReiserFS: hdc9: using ordered data mode
ReiserFS: hdc9: journal params: device hdc9, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hdc9: checking transaction log (hdc9)
ReiserFS: hdc9: Using r5 hash to sort names
ReiserFS: hdc10: found reiserfs format "3.6" with standard journal
ReiserFS: hdc10: using ordered data mode
ReiserFS: hdc10: journal params: device hdc10, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hdc10: checking transaction log (hdc10)
ReiserFS: hdc10: Using r5 hash to sort names
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 (level, low) -> IRQ 11
eth0: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
      PrefPort:A  RlmtMode:Check Link State
ehci_hcd: block sizes: qh 160 qtd 96 itd 192 sitd 96
ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 10 (level, low) -> IRQ 10
ehci_hcd 0000:00:02.2: nVidia Corporation nForce3 USB 2.0
ehci_hcd 0000:00:02.2: reset hcs_params 0x102486 dbg=1 cc=2 pcc=4 !ppc ports=6
ehci_hcd 0000:00:02.2: reset portroute 0 0 1 1 1 0 
ehci_hcd 0000:00:02.2: reset hcc_params a086 caching frame 256/512/1024 park
ehci_hcd 0000:00:02.2: capability 1010001 at a0
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 80 td 96
NET: Registered protocol family 17
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    scatter-gather:  enabled
ieee1394: Initialized config rom entry `ip1394'
snd_intel8x0: Unknown parameter `joystick'
ACPI: AC Adapter [AC0] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ACPI: Fan [FN00] (off)
ACPI: Processor [CPU1] (supports C1)
ACPI: Thermal Zone [THRM] (55 C)
ehci_hcd 0000:00:02.2: BIOS handoff failed (160, 1010001)
ehci_hcd 0000:00:02.2: continuing after BIOS bug...
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: irq 10, pci mem 0xfebfdc00
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:02.2: reset command 080b1a park=3 ithresh=8 Periodic period=256 Reset HALT
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: init command 010b09 park=3 ithresh=1 period=256 RUN
ehci_hcd 0000:00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
ehci_hcd 0000:00:02.2: supports USB remote wakeup
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: default language 0x0409
usb usb1: Product: nVidia Corporation nForce3 USB 2.0
usb usb1: Manufacturer: Linux 2.6.9-mm1 ehci_hcd
usb usb1: SerialNumber: 0000:00:02.2
usb usb1: hotplug
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: ganged power switching
hub 1-0:1.0: individual port over-current protection
hub 1-0:1.0: Single TT
hub 1-0:1.0: TT requires at most 8 FS bit times
hub 1-0:1.0: power on to power good time: 20ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: enabling power on all ports
ehci_hcd 0000:00:02.2: GetStatus port 2 status 001403 POWER sig=k  CSC CONNECT
hub 1-0:1.0: port 2, status 0501, change 0001, 480 Mb/s
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 11 (level, low) -> IRQ 11
ohci_hcd 0000:00:02.0: nVidia Corporation nForce3 USB 1.1
ohci_hcd 0000:00:02.0: USB HC TakeOver from BIOS/SMM
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: irq 11, pci mem 0xfebfb000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.0: resetting from state 'reset', control = 0x600
hub 1-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x501
ehci_hcd 0000:00:02.2: port 2 low speed --> companion
ohci_hcd 0000:00:02.0: OHCI controller state
ohci_hcd 0000:00:02.0: OHCI 1.0, with legacy support registers
ohci_hcd 0000:00:02.0: control 0x683 RWE RWC HCFS=operational CBSR=3
ohci_hcd 0000:00:02.0: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:02.0: intrstatus 0x00000044 RHSC SF
ohci_hcd 0000:00:02.0: intrenable 0x8000000a MIE RD WDH
ohci_hcd 0000:00:02.0: hcca frame #0003
ohci_hcd 0000:00:02.0: roothub.a 01001203 POTPGT=1 NOCP NPS NDP=3
ohci_hcd 0000:00:02.0: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:02.0: roothub.status 00008000 DRWE
ohci_hcd 0000:00:02.0: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:02.0: roothub.portstatus [1] 0x00010301 CSC LSDA PPS CCS
ohci_hcd 0000:00:02.0: roothub.portstatus [2] 0x00000100 PPS
ohci_hcd 0000:00:02.0: supports USB remote wakeup
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: default language 0x0409
usb usb2: Product: nVidia Corporation nForce3 USB 1.1
usb usb2: Manufacturer: Linux 2.6.9-mm1 ohci_hcd
usb usb2: SerialNumber: 0000:00:02.0
usb usb2: hotplug
ehci_hcd 0000:00:02.2: GetStatus port 2 status 003402 POWER OWNER sig=k  CSC
usb usb2: adding 2-0:1.0 (config #1, interface 0)
usb 2-0:1.0: hotplug
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: no power switching (usb 1.0)
hub 2-0:1.0: no over-current protection
hub 2-0:1.0: power on to power good time: 2ms
hub 2-0:1.0: local power source is good
ohci_hcd 0000:00:02.0: created debug files
ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 5 (level, low) -> IRQ 5
ohci_hcd 0000:00:02.1: nVidia Corporation nForce3 USB 1.1 (#2)
ohci_hcd 0000:00:02.1: USB HC TakeOver from BIOS/SMM
ohci_hcd 0000:00:02.0: GetStatus roothub.portstatus [1] = 0x00010301 CSC LSDA PPS CCS
hub 2-0:1.0: port 2, status 0301, change 0001, 1.5 Mb/s
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: irq 5, pci mem 0xfebfc000
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:02.1: resetting from state 'reset', control = 0x600
powernow-k8: Found 1 AMD Athlon 64 / Opteron processors (version 1.00.09e)
powernow-k8:    0 : fid 0xa (1800 MHz), vid 0x2 (1500 mV)
powernow-k8:    1 : fid 0x8 (1600 MHz), vid 0x6 (1400 mV)
powernow-k8:    2 : fid 0x0 (800 MHz), vid 0x12 (1100 mV)
ohci_hcd 0000:00:02.1: OHCI controller state
ohci_hcd 0000:00:02.1: OHCI 1.0, with legacy support registers
ohci_hcd 0000:00:02.1: control 0x683 RWE RWC HCFS=operational CBSR=3
ohci_hcd 0000:00:02.1: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:02.1: intrstatus 0x00000004 SF
ohci_hcd 0000:00:02.1: intrenable 0x8000000a MIE RD WDH
ohci_hcd 0000:00:02.1: hcca frame #0003
ohci_hcd 0000:00:02.1: roothub.a 01001203 POTPGT=1 NOCP NPS NDP=3
ohci_hcd 0000:00:02.1: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:02.1: roothub.status 00008000 DRWE
ohci_hcd 0000:00:02.1: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:02.1: roothub.portstatus [1] 0x00000100 PPS
ohci_hcd 0000:00:02.1: roothub.portstatus [2] 0x00000100 PPS
ohci_hcd 0000:00:02.1: supports USB remote wakeup
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: default language 0x0409
usb usb3: Product: nVidia Corporation nForce3 USB 1.1 (#2)
usb usb3: Manufacturer: Linux 2.6.9-mm1 ohci_hcd
usb usb3: SerialNumber: 0000:00:02.1
usb usb3: hotplug
hub 2-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x301
usb usb3: adding 3-0:1.0 (config #1, interface 0)
usb 3-0:1.0: hotplug
hub 3-0:1.0: usb_probe_interface
hub 3-0:1.0: usb_probe_interface - got id
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
hub 3-0:1.0: standalone hub
hub 3-0:1.0: no power switching (usb 1.0)
hub 3-0:1.0: no over-current protection
hub 3-0:1.0: power on to power good time: 2ms
hub 3-0:1.0: local power source is good
powernow-k8: cpu_init done, current fid 0xa, vid 0x2
ohci_hcd 0000:00:02.1: created debug files
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ACPI: PCI interrupt 0000:02:01.2[C] -> GSI 11 (level, low) -> IRQ 11
ohci_hcd 0000:00:02.0: GetStatus roothub.portstatus [1] = 0x00100303 PRSC LSDA PPS PES CCS
usb 2-2: new low speed USB device using address 2
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[11]  MMIO=[feafd000-feafd7ff]  Max Packet=[2048]
ACPI: PCI interrupt 0000:00:06.0[A] -> GSI 5 (level, low) -> IRQ 5
PCI: Setting latency timer of device 0000:00:06.0 to 64
usb 2-2: skipped 1 descriptor after interface
usb 2-2: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 2-2: default language 0x0409
usb 2-2: Product: Optical USB Mouse
ohci_hcd 0000:00:02.1: suspend root hub
usb 2-2: Manufacturer: Logitech
usb 2-2: hotplug
usb 2-2: adding 2-2:1.0 (config #1, interface 0)
usb 2-2:1.0: hotplug
intel8x0_measure_ac97_clock: measured 49633 usecs
intel8x0: clocking to 47489
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00e018000319b175]
usbcore: registered new driver hiddev
usbhid 2-2:1.0: usb_probe_interface
usbhid 2-2:1.0: usb_probe_interface - got id
input: USB HID v1.10 Mouse [Logitech Optical USB Mouse] on usb-0000:00:02.0-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
SCSI subsystem initialized
st: Version 20040403, fixed bufsize 32768, s/g segs 256
NET: Registered protocol family 10
Disabled Privacy Extensions on device ffffffff8049c9e0(lo)
IPv6 over IPv4 tunneling driver
Disabled Privacy Extensions on device 0000010013fa6440(sit0)
parport0: PC-style at 0x378 [PCSPP,TRISTATE]
lp0: using parport0 (polling).
drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
usbcore: registered new driver usbserial_generic
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
eth0: no IPv6 routers present
ohci_hcd 0000:00:02.0: remove, state 1
ohci_hcd 0000:00:02.0: roothub graceful disconnect
usb usb2: USB disconnect, address 1
usb 2-2: USB disconnect, address 2
usb 2-2: usb_disable_device nuking all URBs
ohci_hcd 0000:00:02.0: shutdown urb 000001001a2c3320 pipe 40408280 ep1in-intr
ohci_hcd 0000:00:02.0: IRQ INTR_SF lossage
usb 2-2: unregistering interface 2-2:1.0
usb 2-2:1.0: hotplug
usb 2-2: unregistering device
usb 2-2: hotplug
usb usb2: usb_disable_device nuking all URBs
ohci_hcd 0000:00:02.0: shutdown urb 000001001a85c3b8 pipe 40408180 ep1in-intr
usb usb2: unregistering interface 2-0:1.0
usb 2-0:1.0: hotplug
usb usb2: unregistering device
usb usb2: hotplug
ohci_hcd 0000:00:02.0: stop operational controller (state 0x85)
ohci_hcd 0000:00:02.0: OHCI controller state
ohci_hcd 0000:00:02.0: OHCI 1.0, with legacy support registers
ohci_hcd 0000:00:02.0: control 0x683 RWE RWC HCFS=operational CBSR=3
ohci_hcd 0000:00:02.0: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:02.0: intrstatus 0x00000026 FNO SF WDH
ohci_hcd 0000:00:02.0: intrenable 0x8000000e MIE RD SF WDH
ohci_hcd 0000:00:02.0: ed_controlhead 1cd6d000
ohci_hcd 0000:00:02.0: hcca frame #efb0
ohci_hcd 0000:00:02.0: roothub.a 01001203 POTPGT=1 NOCP NPS NDP=3
ohci_hcd 0000:00:02.0: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:02.0: roothub.status 00008000 DRWE
ohci_hcd 0000:00:02.0: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:02.0: roothub.portstatus [1] 0x00000303 LSDA PPS PES CCS
ohci_hcd 0000:00:02.0: roothub.portstatus [2] 0x00000100 PPS
ohci_hcd 0000:00:02.0: USB bus 2 deregistered
ohci_hcd 0000:00:02.1: remove, state 1
ohci_hcd 0000:00:02.1: roothub graceful disconnect
usb usb3: USB disconnect, address 1
usb usb3: usb_disable_device nuking all URBs
ohci_hcd 0000:00:02.1: shutdown urb 000001001a119d00 pipe 40408180 ep1in-intr
usb usb3: unregistering interface 3-0:1.0
usb 3-0:1.0: hotplug
usb usb3: unregistering device
usb usb3: hotplug
ohci_hcd 0000:00:02.1: stop suspend controller (state 0x85)
ohci_hcd 0000:00:02.1: OHCI controller state
ohci_hcd 0000:00:02.1: OHCI 1.0, with legacy support registers
ohci_hcd 0000:00:02.1: control 0x6c3 RWE RWC HCFS=suspend CBSR=3
ohci_hcd 0000:00:02.1: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:02.1: intrstatus 0x00000000
ohci_hcd 0000:00:02.1: intrenable 0x8000000a MIE RD WDH
ohci_hcd 0000:00:02.1: hcca frame #0179
ohci_hcd 0000:00:02.1: roothub.a 01001203 POTPGT=1 NOCP NPS NDP=3
ohci_hcd 0000:00:02.1: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:02.1: roothub.status 00008000 DRWE
ohci_hcd 0000:00:02.1: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:02.1: roothub.portstatus [1] 0x00000100 PPS
ohci_hcd 0000:00:02.1: roothub.portstatus [2] 0x00000100 PPS
ohci_hcd 0000:00:02.1: USB bus 3 deregistered
ehci_hcd 0000:00:02.2: remove, state 1
ehci_hcd 0000:00:02.2: roothub graceful disconnect
usb usb1: USB disconnect, address 1
usb usb1: usb_disable_device nuking all URBs
ehci_hcd 0000:00:02.2: shutdown urb 000001001a2d2758 pipe 40408180 ep1in-intr
usb usb1: unregistering interface 1-0:1.0
usb 1-0:1.0: hotplug
usb usb1: unregistering device
usb usb1: hotplug
ehci_hcd 0000:00:02.2: stop
ehci_hcd 0000:00:02.2: reset command 010b0b park=3 ithresh=1 period=256 Reset RUN
ehci_hcd 0000:00:02.2: irq normal 0 err 0 reclaim 0 (lost 0)
ehci_hcd 0000:00:02.2: complete 0 unlink 0
ehci_hcd 0000:00:02.2: ehci_stop completed status 1000 Halt
ehci_hcd 0000:00:02.2: USB bus 1 deregistered
eth0: network connection down
skge 0000:02:00.0: Device was removed without properly calling pci_disable_device(). This may need fixing.
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 (level, low) -> IRQ 11
ACPI: PCI interrupt 0000:02:00.0[A] -> GSI 11 (level, low) -> IRQ 11
eth0: Yukon Gigabit Ethernet 10/100/1000Base-T Adapter
      PrefPort:A  RlmtMode:Check Link State
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    scatter-gather:  enabled
eth0: network connection down
eth0: network connection up using port A
    speed:           100
    autonegotiation: yes
    duplex mode:     full
    flowctrl:        symmetric
    irq moderation:  disabled
    scatter-gather:  enabled
eth0: no IPv6 routers present
ehci_hcd: block sizes: qh 160 qtd 96 itd 192 sitd 96
ACPI: PCI interrupt 0000:00:02.2[C] -> GSI 10 (level, low) -> IRQ 10
ehci_hcd 0000:00:02.2: nVidia Corporation nForce3 USB 2.0
ehci_hcd 0000:00:02.2: reset hcs_params 0x102486 dbg=1 cc=2 pcc=4 !ppc ports=6
ehci_hcd 0000:00:02.2: reset portroute 0 0 1 1 1 0 
ehci_hcd 0000:00:02.2: reset hcc_params a086 caching frame 256/512/1024 park
ehci_hcd 0000:00:02.2: capability 1000001 at a0
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: irq 10, pci mem 0xfebfdc00
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:02.2: reset command 080b02 park=3 ithresh=8 period=1024 Reset HALT
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: init command 010b09 park=3 ithresh=1 period=256 RUN
ehci_hcd 0000:00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
ehci_hcd 0000:00:02.2: supports USB remote wakeup
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: default language 0x0409
usb usb1: Product: nVidia Corporation nForce3 USB 2.0
usb usb1: Manufacturer: Linux 2.6.9-mm1 ehci_hcd
usb usb1: SerialNumber: 0000:00:02.2
usb usb1: hotplug
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: ganged power switching
hub 1-0:1.0: individual port over-current protection
hub 1-0:1.0: Single TT
hub 1-0:1.0: TT requires at most 8 FS bit times
hub 1-0:1.0: power on to power good time: 20ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: enabling power on all ports
ehci_hcd 0000:00:02.2: GetStatus port 2 status 001403 POWER sig=k  CSC CONNECT
hub 1-0:1.0: port 2, status 0501, change 0001, 480 Mb/s
hub 1-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x501
ehci_hcd 0000:00:02.2: port 2 low speed --> companion
ehci_hcd 0000:00:02.2: GetStatus port 2 status 003002 POWER OWNER sig=se0  CSC
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 80 td 96
ACPI: PCI interrupt 0000:00:02.0[A] -> GSI 11 (level, low) -> IRQ 11
ohci_hcd 0000:00:02.0: nVidia Corporation nForce3 USB 1.1
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: irq 11, pci mem 0xfebfb000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.0: resetting from state 'reset', control = 0x600
ohci_hcd 0000:00:02.0: OHCI controller state
ohci_hcd 0000:00:02.0: OHCI 1.0, with legacy support registers
ohci_hcd 0000:00:02.0: control 0x683 RWE RWC HCFS=operational CBSR=3
ohci_hcd 0000:00:02.0: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:02.0: intrstatus 0x00000044 RHSC SF
ohci_hcd 0000:00:02.0: intrenable 0x8000000a MIE RD WDH
ohci_hcd 0000:00:02.0: hcca frame #0003
ohci_hcd 0000:00:02.0: roothub.a 01001203 POTPGT=1 NOCP NPS NDP=3
ohci_hcd 0000:00:02.0: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:02.0: roothub.status 00008000 DRWE
ohci_hcd 0000:00:02.0: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:02.0: roothub.portstatus [1] 0x00010301 CSC LSDA PPS CCS
ohci_hcd 0000:00:02.0: roothub.portstatus [2] 0x00000100 PPS
ohci_hcd 0000:00:02.0: supports USB remote wakeup
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: default language 0x0409
usb usb2: Product: nVidia Corporation nForce3 USB 1.1
usb usb2: Manufacturer: Linux 2.6.9-mm1 ohci_hcd
usb usb2: SerialNumber: 0000:00:02.0
usb usb2: hotplug
usb usb2: adding 2-0:1.0 (config #1, interface 0)
usb 2-0:1.0: hotplug
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: no power switching (usb 1.0)
hub 2-0:1.0: no over-current protection
hub 2-0:1.0: power on to power good time: 2ms
hub 2-0:1.0: local power source is good
ohci_hcd 0000:00:02.0: created debug files
ACPI: PCI interrupt 0000:00:02.1[B] -> GSI 5 (level, low) -> IRQ 5
ohci_hcd 0000:00:02.1: nVidia Corporation nForce3 USB 1.1 (#2)
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: irq 5, pci mem 0xfebfc000
ohci_hcd 0000:00:02.0: GetStatus roothub.portstatus [1] = 0x00010301 CSC LSDA PPS CCS
hub 2-0:1.0: port 2, status 0301, change 0001, 1.5 Mb/s
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:02.1: resetting from state 'reset', control = 0x600
ohci_hcd 0000:00:02.1: OHCI controller state
ohci_hcd 0000:00:02.1: OHCI 1.0, with legacy support registers
ohci_hcd 0000:00:02.1: control 0x683 RWE RWC HCFS=operational CBSR=3
ohci_hcd 0000:00:02.1: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:02.1: intrstatus 0x00000004 SF
ohci_hcd 0000:00:02.1: intrenable 0x8000000a MIE RD WDH
ohci_hcd 0000:00:02.1: hcca frame #0003
ohci_hcd 0000:00:02.1: roothub.a 01001203 POTPGT=1 NOCP NPS NDP=3
ohci_hcd 0000:00:02.1: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:02.1: roothub.status 00008000 DRWE
ohci_hcd 0000:00:02.1: roothub.portstatus [0] 0x00000100 PPS
ohci_hcd 0000:00:02.1: roothub.portstatus [1] 0x00000100 PPS
ohci_hcd 0000:00:02.1: roothub.portstatus [2] 0x00000100 PPS
ohci_hcd 0000:00:02.1: supports USB remote wakeup
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: default language 0x0409
usb usb3: Product: nVidia Corporation nForce3 USB 1.1 (#2)
usb usb3: Manufacturer: Linux 2.6.9-mm1 ohci_hcd
usb usb3: SerialNumber: 0000:00:02.1
usb usb3: hotplug
usb usb3: adding 3-0:1.0 (config #1, interface 0)
usb 3-0:1.0: hotplug
hub 2-0:1.0: debounce: port 2: total 100ms stable 100ms status 0x301
hub 3-0:1.0: usb_probe_interface
hub 3-0:1.0: usb_probe_interface - got id
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
hub 3-0:1.0: standalone hub
hub 3-0:1.0: no power switching (usb 1.0)
hub 3-0:1.0: no over-current protection
hub 3-0:1.0: power on to power good time: 2ms
hub 3-0:1.0: local power source is good
ohci_hcd 0000:00:02.1: created debug files
ohci_hcd 0000:00:02.0: GetStatus roothub.portstatus [1] = 0x00100303 PRSC LSDA PPS PES CCS
usb 2-2: new low speed USB device using address 2
usb 2-2: skipped 1 descriptor after interface
usb 2-2: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 2-2: default language 0x0409
usb 2-2: Product: Optical USB Mouse
usb 2-2: Manufacturer: Logitech
usb 2-2: hotplug
usb 2-2: adding 2-2:1.0 (config #1, interface 0)
usb 2-2:1.0: hotplug
usbhid 2-2:1.0: usb_probe_interface
usbhid 2-2:1.0: usb_probe_interface - got id
ohci_hcd 0000:00:02.1: suspend root hub
input: USB HID v1.10 Mouse [Logitech Optical USB Mouse] on usb-0000:00:02.0-2

--Boundary-00=_KspeB03/CPA2Bpt--
