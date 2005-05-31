Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261945AbVEaQur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261945AbVEaQur (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 12:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbVEaQsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 12:48:41 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:3272 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S261981AbVEaQpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 12:45:41 -0400
Message-ID: <429C94A2.102@snacksy.com>
Date: Tue, 31 May 2005 18:45:22 +0200
From: jan malstrom <xanon@snacksy.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, jgarzik@pobox.com, akpm@osdl.org
Subject: [2.6-rcX-mmX] File descriptor (?) problem under high io to ide disk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

when reading many fragmented files the system slows down to a crawl,
often stalling for a second or two. with preemption enabled it gets 
better but still occurs.

the real problem is that under such pressure i get errors from alsa
applications stating that the file descriptor is in a bad state.
azureus (a bittorrent app) gives me following error: "Likely network
disconnect/reconnect: Repairing 1 selector, xx keys"

their description of the problem is :
"That message is shown when network socket selector spin is detected,
and it's pretty hard to trip it off without there actually being a
problem; i.e. false positives are extremely rare. Without getting into
specifics, a socket selector is a high-speed way of knowing when a
socket is ready to be written to / read from ( ala poll() ). In this
case, to warrant a popup alert, a select op would have to return,
prematurely, without having selected any channels for readiness 10,000
times in a row. If this happens consistently, something is most
definitely wrong."

when i used xfs a while ago i had severe corruptions with files
intermixed with content from other files
reiserfs and reiser4 seem to be not having these problems as i havent
had any corruption at all with them

the problem is not related to java as it also happens to alsa and xfs

i already tried the standard ide drivers and leaving the intel/ich4
stuff out but that didnt help.
preemption on or off doesnt matter.
pio mode, dma and.or unmasked interrupt on the drives didnt matter.

another interesting thing is that my usb disk works like a charm and
soent trigger that problem while a simple cat /dev/hda > /dev/null is
enough to get errors from azureus or mplayer when pausing a sound file.

i want able to test if the problem only occurs when reading from the disk.
when i wrote a big file it didnt show these symptoms but maybe the
file want big enough (just 700mb).

Debug memory allocations,  Spinlock debugging nor 
Sleep-inside-spinlock checking showed anything.

i really dont know whats happing or how to describe it more clearly.
any help in debugging would be appreciated.


thanks
jan


Linux version 2.6.12-rc4-mm1 (root@hades) (gcc version 3.3.6 (Debian 
1:3.3.6-5)) #55 Tue May 31 18:12:20 CEST 2005
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
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 126928 pages, LIFO batch:31
   HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 COMPAQ                                ) @ 0x000f6560
ACPI: RSDT (v001 HP     CPQ0860  0x20040520 CPQ  0x00000001) @ 0x1fff0c84
ACPI: FADT (v002 HP     CPQ0860  0x00000002 CPQ  0x00000001) @ 0x1fff0c00
ACPI: SSDT (v001 COMPAQ  CPQGysr 0x00001001 MSFT 0x0100000e) @ 0x1fff5c3c
ACPI: DSDT (v001 HP       nx7000 0x00010000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x1008
Allocating PCI resources starting at 20000000 (gap: 20000000:e0000000)
Built 1 zonelists
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (01405000)
Initializing CPU#0
Kernel command line: BOOT_IMAGE=Linux ro root=301 1
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 1395.697 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 511576k/524096k available (4992k kernel code, 11980k reserved, 
1435k data, 200k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor 
mode... Ok.
Calibrating delay using timer specific routine.. 2792.49 BogoMIPS 
(lpj=1396247)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: a7e9f9bf 00000000 00000000 00000000 
0000018000000000 00000000
CPU: After vendor identify, caps: a7e9f9bf 00000000 00000000 00000000 
00000180 00000000 00000000
CPU: L1 I cache: 32K, L1 D cache: 32K
CPU: L2 cache: 1024K
CPU: After all inits, caps: a7e9f9bf 00000000 00000000 00000040 
00000180 00000000 00000000
CPU: Intel(R) Pentium(R) M processor 1400MHz stepping 05
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0c20)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xf031f, last bus=3
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050408
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [C046] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.C046] segment is 0
ACPI: Assume root bridge [\_SB_.C046] bus is 0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.C046._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C046.C047._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.C046.C058._PRT]
ACPI: Embedded Controller [C0EA] (gpe 28)
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
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post 
a report
inotify device minor=63
NTFS driver 2.1.23-WIP [Flags: R/W].
SGI XFS with no debug enabled
Initializing Cryptographic API
ACPI: AC Adapter [C134] (on-line)
ACPI: Battery Slot [C11F] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [C1BE]
ACPI: Lid Switch [C136]
ACPI: Video Device [C0D0] (multi-head: yes  rom: no  post: no)
Disabling BM access before entering C3
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU0] (supports 8 throttling states)
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 855PM Chipset.
agpgart: AGP aperture is 256M @ 0xb0000000
[drm] Initialized drm 1.0.0 20040925
cn_fork is registered
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
serio: i8042 AUX3 port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
ACPI: PCI Interrupt Link [C0C3] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:1f.6[B] -> Link [C0C3] -> GSI 10 (level, 
low) -> IRQ 10
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
lp0: using parport0 (polling).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
loop: loaded (max 8 devices)
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
NET: Registered protocol family 24
8139cp: 10/100 PCI Ethernet driver v1.2 (Mar 22, 2004)
ACPI: PCI Interrupt 0000:02:01.0[A] -> Link [C0C3] -> GSI 10 (level, 
low) -> IRQ 10
eth0: RTL-8139C+ at 0xe0806000, 00:02:3f:65:86:5c, IRQ 10
hostap_crypt: registered algorithm 'NULL'
hostap_crypt: registered algorithm 'WEP'
hostap_crypt: registered algorithm 'TKIP'
hostap_crypt: registered algorithm 'CCMP'
hostap_cs: CVS (Jouni Malinen <jkmaline@cc.hut.fi>)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
ICH4: IDE controller at PCI slot 0000:00:1f.1
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt Link [C0C4] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [C0C4] -> GSI 5 (level, 
low) -> IRQ5
ICH4: chipset revision 1
ICH4: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0x4c40-0x4c47, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0x4c48-0x4c4f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: TOSHIBA MK4021GAS, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: SD-R2312, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB), CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
  hda: hda1 hda2
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt Link [C0C2] enabled at IRQ 10
ACPI: PCI Interrupt 0000:02:00.0[A] -> Link [C0C2] -> GSI 10 (level, 
low) -> IRQ 10
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[10] 
MMIO=[90200000-902007ff]  Max Packet=[2048]
ACPI: PCI Interrupt 0000:02:04.0[A] -> Link [C0C4] -> GSI 5 (level, 
low) -> IRQ5
Yenta: CardBus bridge found at 0000:02:04.0 [0e11:0860]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:02:04.0, mfunc 0x001c1112, devctl 0x44
Yenta: ISA IRQ mask 0x0000, PCI irq 5
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x2000 - 0x2fff
cs: IO port probe 0x2000-0x2fff: clean.
pcmcia: parent PCI bridge Memory window: 0x90000000 - 0x903fffff
ACPI: PCI Interrupt Link [C0C9] enabled at IRQ 5
ACPI: PCI Interrupt 0000:00:1d.7[D] -> Link [C0C9] -> GSI 5 (level, 
low) -> IRQ5
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: Intel Corporation 82801DB/DBM (ICH4/ICH4-M) 
USB2 EHCI Controller
ehci_hcd 0000:00:1d.7: debug port 1
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:1d.7: irq 5, io mem 0xa0000000
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:1d.0[A] -> Link [C0C2] -> GSI 10 (level, 
low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: Intel Corporation 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.0: irq 10, io base 0x000048c0
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [C0C5] enabled at IRQ 5
ACPI: PCI Interrupt 0000:00:1d.1[B] -> Link [C0C5] -> GSI 5 (level, 
low) -> IRQ5
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: Intel Corporation 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 5, io base 0x000048e0
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> Link [C0C4] -> GSI 5 (level, 
low) -> IRQ5
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: Intel Corporation 82801DB/DBL/DBM 
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 5, io base 0x00004c00
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 1-5: new high speed USB device using ehci_hcd and address 3
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usb 2-1: new low speed USB device using uhci_hcd and address 2
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[00023f39380016aa]
scsi0 : SCSI emulation for USB Mass Storage devices
usb-storage: device found at 3
usb-storage: waiting for device to settle before scanning
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
input: USB HID v1.10 Mouse [Logitech USB Mouse] on usb-0000:00:1d.0-1
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
mice: PS/2 mouse device common for all mice
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
wbsd: Winbond W83L51xD SD/MMC card interface driver, 1.1
wbsd: Copyright(c) Pierre Ossman
mmc0: W83L51xD id 7112 at 0x248 irq 6 dma 2
perfctr: driver 2.7.15, cpu type Intel P6 at 1395697 kHz
Advanced Linux Sound Architecture Driver Version 1.0.9rc3  (Thu Mar 24 
10:33:392005 UTC).
ACPI: PCI Interrupt 0000:00:1f.5[B] -> Link [C0C3] -> GSI 10 (level, 
low) -> IRQ 10
PCI: Setting latency timer of device 0000:00:1f.5 to 64
input: AT Translated Set 2 keyboard on isa0060/serio0
Synaptics Touchpad, model: 1
  Firmware: 5.9
  Sensor: 35
  new absolute packet format
  Touchpad has extended capability bits
  -> multifinger detection
  -> palm detection
input: SynPS/2 Synaptics TouchPad on isa0060/serio4
intel8x0_measure_ac97_clock: measured 49209 usecs
intel8x0: clocking to 48000
ALSA device list:
   #0: Intel 82801DB-ICH4 with AD1981B at 0xa0200000, irq 10
NET: Registered protocol family 2
IP: routing cache hash table of 1024 buckets, 32Kbytes
TCP established hash table entries: 32768 (order: 6, 262144 bytes)
TCP bind hash table entries: 32768 (order: 7, 917504 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
ip_conntrack version 2.1 (4094 buckets, 32752 max) - 208 bytes per 
conntrack
ip_tables: (C) 2000-2002 Netfilter core team
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
ieee80211_crypt: registered algorithm 'NULL'
ieee80211_crypt: registered algorithm 'WEP'
ieee80211_crypt: registered algorithm 'CCMP'
ieee80211_crypt: registered algorithm 'TKIP'
ACPI wakeup devices:
C058 C1AD C1A3 C1A4 C0AC C0B3 C0B4 C0B5 C0E7 C136
ACPI: (supports S0 S3 S4 S4bios S5)
ReiserFS: hda1: found reiserfs format "3.6" with standard journal
ReiserFS: hda1: using ordered data mode
ReiserFS: hda1: journal params: device hda1, size 8192, journal first 
block 18,max trans len 1024, max batch 900, max commit age 30, max 
trans age 30
ReiserFS: hda1: checking transaction log (hda1)
ReiserFS: hda1: Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 200k freed
   Vendor: HDS72252  Model: 5VLAT80           Rev: V36O
   Type:   Direct-Access                      ANSI SCSI revision: 00
SCSI device sda: 488397167 512-byte hdwr sectors (250059 MB)
sda: assuming drive cache: write through
SCSI device sda: 488397167 512-byte hdwr sectors (250059 MB)
sda: assuming drive cache: write through
  sda: sda1 sda2 sda3 sda4
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
usb-storage: device scan complete
ub: sizeof ub_scsi_cmd 68 ub_dev 2456 ub_lun 140
usbcore: registered new driver ub
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1


