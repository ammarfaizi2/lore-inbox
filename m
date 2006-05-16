Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbWEPWhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWEPWhL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 18:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbWEPWhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 18:37:10 -0400
Received: from ns2.ngi.it ([88.149.128.3]:51657 "EHLO maya.ngi.it")
	by vger.kernel.org with ESMTP id S932232AbWEPWhH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 18:37:07 -0400
From: Biker <biker@villagepeople.it>
Organization: Village People Inc.
To: linux-kernel@vger.kernel.org
Subject: Re: USB 2.0 ehci failure with large amount of RAM (4GB) on x86_64
Date: Wed, 17 May 2006 00:37:03 +0200
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200605170037.03610.biker@villagepeople.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I've been hitting this bug (or a similar one) for the last few months; it also 
happens on 32 bits with 1 GB of RAM. My system is a somewhat old Athlon, 
coupled with a VIA chipset and an ALI USB 2.0 PCI card.
Whenever I plug in my creative muvo tx 1GB I get the following messages:

May 17 00:05:15 hiddenplace hub 4-0:1.0: state 7 ports 6 chg 0000 evt 0008
May 17 00:05:15 hiddenplace ehci_hcd 0000:00:0a.3: GetStatus port 3 status 
001803 POWER sig=j CSC CONNECT
May 17 00:05:15 hiddenplace hub 4-0:1.0: port 3, status 0501, change 0001, 480 
Mb/s
May 17 00:05:15 hiddenplace hub 4-0:1.0: debounce: port 3: total 100ms stable 
100ms status 0x501
May 17 00:05:15 hiddenplace ehci_hcd 0000:00:0a.3: port 3 high speed
May 17 00:05:15 hiddenplace ehci_hcd 0000:00:0a.3: GetStatus port 3 status 
001005 POWER sig=se0 PE CONNECT
May 17 00:05:15 hiddenplace usb 4-3: new high speed USB device using ehci_hcd 
and address 7
May 17 00:05:15 hiddenplace ehci_hcd 0000:00:0a.3: devpath 3 ep0out 3strikes
May 17 00:05:15 hiddenplace ehci_hcd 0000:00:0a.3: devpath 3 ep0out 3strikes
May 17 00:05:16 hiddenplace usb 4-3: device not accepting address 7, error -71
May 17 00:05:16 hiddenplace ehci_hcd 0000:00:0a.3: port 3 high speed
May 17 00:05:16 hiddenplace ehci_hcd 0000:00:0a.3: GetStatus port 3 status 
001005 POWER sig=se0 PE CONNECT
May 17 00:05:16 hiddenplace usb 4-3: new high speed USB device using ehci_hcd 
and address 8
May 17 00:05:16 hiddenplace ehci_hcd 0000:00:0a.3: devpath 3 ep0out 3strikes
May 17 00:05:16 hiddenplace ehci_hcd 0000:00:0a.3: devpath 3 ep0out 3strikes
May 17 00:05:16 hiddenplace usb 4-3: device not accepting address 8, error -71
[output omitted]

If I rmmod ehci_hcd then ohci_hcd kicks in and it works, albeit at 12 MB/s.
I'm using the nvidia proprietary module and ndiswrapper, but removing them and 
rebooting to an untainted kernel does not change anything.

Thanks in advance for your help, please CC: me as I'm not subscribed.

Best regards, Silla

# uname -a
Linux hiddenplace 2.6.16-gentoo-r7 #1 PREEMPT Wed May 10 21:14:35 CEST 2006 
i686 AMD Athlon(tm) XP 1600+ GNU/Linux

# lspci
00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP]
00:08.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 06)
00:08.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 
06)
00:0a.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
00:0a.1 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
00:0a.2 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
00:0a.3 USB Controller: ALi Corporation USB 2.0 Controller (rev 01)
00:0b.0 Network controller: Broadcom Corporation BCM4306 802.11b/g Wireless 
LAN Controller (rev 03)
00:0d.0 Ethernet controller: 3Com Corporation 3c905 100BaseTX [Boomerang]
00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
00:11.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 1b)
00:11.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 
Controller (rev 1b)
01:00.0 VGA compatible controller: nVidia Corporation NV11DDR [GeForce2 MX 100 
DDR/200 DDR] (rev b2)

# cat /proc/interrupts
           CPU0
  0:     276293          XT-PIC  timer
  2:          0          XT-PIC  cascade
  7:         34          XT-PIC  ehci_hcd:usb4
  9:          0          XT-PIC  acpi
 10:      58405          XT-PIC  ohci_hcd:usb1, uhci_hcd:usb5, uhci_hcd:usb6
 11:          0          XT-PIC  EMU10K1, ohci_hcd:usb2, ohci_hcd:usb3
 14:       3333          XT-PIC  ide0
 15:       4382          XT-PIC  ide1
NMI:          0
ERR:          0

# cat /var/log/dmesg
Linux version 2.6.16-gentoo-r7 (root@hiddenplace) (gcc version 3.4.5 (Gentoo 
3.4.5-r1, ssp-3.4.5-1.0, pie-8.7.9)) #1 PREEMPT Wed May 10 21:14:35 CEST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
 BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
 BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 262128
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 225280 pages, LIFO batch:31
  HighMem zone: 32752 pages, LIFO batch:7
DMI 2.2 present.
ACPI: RSDP (v000 VIA694                                ) @ 0x000f7290
ACPI: RSDT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3000
ACPI: FADT (v001 VIA694 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3040
ACPI: DSDT (v001 VIA694 AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: PM-Timer IO Port: 0x4008
Allocating PCI resources starting at 50000000 (gap: 40000000:bfff0000)
Built 1 zonelists
Kernel command line: root=/dev/hda3
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 4096 (order: 12, 65536 bytes)
Detected 1403.365 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1036144k/1048512k available (1859k kernel code, 11776k reserved, 553k 
data, 128k init, 131008k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 2809.46 BogoMIPS 
(lpj=1404733)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0383f9ff c1c3f9ff 00000000 00000000 
00000000 00000000 00000000
CPU: After vendor identify, caps: 0383f9ff c1c3f9ff 00000000 00000000 00000000 
00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps: 0383f9ff c1c3f9ff 00000000 00000420 00000000 
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 1600+ stepping 02
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0e80)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfb480, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 11 devices
SCSI subsystem initialized
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: ec000000-edffffff
  PREFETCH window: e0000000-e7ffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
Machine check exception polling timer started.
audit: initializing netlink socket (disabled)
audit(1147817373.641:1): initialized
highmem bounce pool size: 64 pages
SGI XFS with no debug enabled
Initializing Cryptographic API
io scheduler noop registered
io scheduler cfq registered (default)
 0000:00:11.2: uhci_check_and_reset_hc: legsup = 0x003a
 0000:00:11.2: Performing full reset
 0000:00:11.3: uhci_check_and_reset_hc: legsup = 0x0010
 0000:00:11.3: Performing full reset
vesafb: NVidia Corporation, NV11 Board, Chip Rev B2 (OEM: NVidia)
vesafb: VBE version: 3.0
vesafb: VBIOS/hardware supports DDC2 transfers
vesafb: monitor limits: vf = 200 Hz, hf = 107 kHz, clk = 230 MHz
vesafb: scrolling: redraw
Console: switching to colour frame buffer device 128x48
vesafb: framebuffer at 0xe0000000, mapped to 0xf8880000, using 7500k, total 
32768k
fb0: VESA VGA frame buffer device
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PNP: No PS/2 controller found. Probing ports directly.
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:11.1[A] -> Link [LNKA] -> GSI 11 (level, low) -> 
IRQ 11
PCI: Via IRQ fixup for 0000:00:11.1, from 255 to 11
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8233 (rev 00) IDE UDMA100 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xdc00-0xdc07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xdc08-0xdc0f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: MAXTOR 6L040J2, ATA DISK drive
hdb: Maxtor 6L300R0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: MATSHITADVD-ROM SR-8587, ATAPI CD/DVD-ROM drive
hdd: HL-DT-ST DVDRAM GSA-4163B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 78177792 sectors (40027 MB) w/1818KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2 hda3
hdb: max request size: 512KiB
hdb: 586114704 sectors (300090 MB) w/16384KiB Cache, CHS=36483/255/63, 
UDMA(100)
hdb: cache flushes supported
 hdb: hdb1
NET: Registered protocol family 2
IP route cache hash table entries: 65536 (order: 6, 262144 bytes)
TCP established hash table entries: 262144 (order: 8, 1048576 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 262144 bind 65536)
TCP reno registered
TCP bic registered
Using IPI Shortcut mode
XFS mounting filesystem hda3
Ending clean XFS mount for filesystem: hda3
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 128k freed
NET: Registered protocol family 1
Adding 506036k swap on /dev/hda2.  Priority:-1 extents:1 across:506036k
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
hdc: ATAPI 48X DVD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 40X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache, UDMA(33)
NET: Registered protocol family 17
XFS mounting filesystem hdb1
Ending clean XFS mount for filesystem: hdb1
usbcore: registered new driver usbfs
usbcore: registered new driver hub
TCP westwood registered





