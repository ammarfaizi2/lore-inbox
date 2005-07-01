Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263361AbVGAPRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263361AbVGAPRx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 11:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263367AbVGAPRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 11:17:53 -0400
Received: from mx02.qsc.de ([213.148.130.14]:33700 "EHLO mx02.qsc.de")
	by vger.kernel.org with ESMTP id S263361AbVGAPRM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 11:17:12 -0400
Message-ID: <42C55E66.2010400@exactcode.de>
Date: Fri, 01 Jul 2005 17:16:54 +0200
From: Rene Rebe <rene@exactcode.de>
Organization: ExactCode
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-users@lists.sourceforge.net
Subject: irq XX: nobody cared! and uhci_hcd
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have a tiny Sumicom box with Intel (ICH5/ICH5R) w/ Celeron CPU in 
front of me, that expose quite some bugs in recent Linux kernels. I 
tested with 2.6.8 (Debian) 2.6.11 and 2.6.12. .12 output attached below.

First if of all I have to use acpi=noirq or pci=noacpi to get the e100 
interrupt routed at all. Otherwise no network packet will go on the wire 
or is received.

But even with this workaround USB 1.x devices are not functional due to 
the IRQ for those devices is disabled because nobody cared:

uhci_hcd 0000:00:1d.0: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB 
UHCI Controller #1
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
irq 10: nobody cared!
  [<c012f64d>] __report_bad_irq+0x31/0x77
  [<c012f6f7>] note_interrupt+0x4c/0x71
  [<c012f200>] __do_IRQ+0xc5/0x10d
  [<c0104c3f>] do_IRQ+0x1b/0x28
  [<c01036f2>] common_interrupt+0x1a/0x20
  [<c011a544>] __do_softirq+0x28/0x74
  [<c011a5b2>] do_softirq+0x22/0x26
  [<c011a651>] irq_exit+0x28/0x32
  [<c0104c44>] do_IRQ+0x20/0x28
  [<c01036f2>] common_interrupt+0x1a/0x20
  [<c012f478>] setup_irq+0xc5/0x104
  [<d0226992>] usb_hcd_irq+0x0/0x4e [usbcore]
  [<c012f605>] request_irq+0x75/0x8c
  [<d0226bdd>] usb_add_hcd+0xe6/0x215 [usbcore]
  [<d0226992>] usb_hcd_irq+0x0/0x4e [usbcore]
  [<d022a35a>] usb_hcd_pci_probe+0x206/0x293 [usbcore]
  [<c01b3630>] pci_device_probe_static+0x2e/0x41
  [<c01b3662>] __pci_device_probe+0x1f/0x32
  [<c01b3691>] pci_device_probe+0x1c/0x31
  [<c01fafba>] driver_probe_device+0x36/0x54
  [<c01fb093>] driver_attach+0x39/0x6e
  [<c01fb464>] bus_add_driver+0x69/0x95
  [<c01fb8e9>] driver_register+0x23/0x25
  [<c01b3850>] pci_register_driver+0x5f/0x72
  [<d000207b>] uhci_hcd_init+0x7b/0xb7 [uhci_hcd]
  [<c012ceaa>] sys_init_module+0xbc/0x1d0
  [<c0102cbd>] syscall_call+0x7/0xb
handlers:
[<d0226992>] (usb_hcd_irq+0x0/0x4e [usbcore])
Disabling IRQ #10
uhci_hcd 0000:00:1d.0: irq 10, io base 0x0000e000

Of course USB 1.x transfers stall due to no IRQ gets received anymore.

Full logs:

version:

Linux version 2.6.12 (root@archivista) (gcc-Version 3.3.5 (Debian 
1:3.3.5-13)) #2 Fri Jul 1 19:58:08 CEST 2005

lspci:

0000:00:00.0 Host bridge: Intel Corp. 82865G/PE/P DRAM 
Controller/Host-Hub Interface (rev 02)
0000:00:02.0 VGA compatible controller: Intel Corp. 82865G Integrated 
Graphics Device (rev 02)
0000:00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB 
UHCI #1 (rev 02)
0000:00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB 
UHCI #2 (rev 02)
0000:00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB 
UHCI #3 (rev 02)
0000:00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB 
UHCI #4 (rev 02)
0000:00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 
EHCI Controller (rev 02)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2)
0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge 
(rev 02)
0000:00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra 
ATA 100 Storage Controller (rev 02)
0000:00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller 
(rev 02)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER 
(ICH5/ICH5R) AC'97 Audio Controller (rev 02)
0000:01:03.0 FireWire (IEEE 1394): Lucent Microelectronics FW323 (rev 61)
0000:01:08.0 Ethernet controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) 
integrated LAN Controller (rev 02)

interrupts:
            CPU0
   0:     161507          XT-PIC  timer
   1:        354          XT-PIC  i8042
   2:          0          XT-PIC  cascade
   5:          0          XT-PIC  Intel ICH5
   7:          0          XT-PIC  parport0
   9:          0          XT-PIC  acpi, ohci1394, uhci_hcd:usb2
  10:     100000          XT-PIC  uhci_hcd:usb1, uhci_hcd:usb3, 
uhci_hcd:usb4
  11:        273          XT-PIC  ehci_hcd:usb5, eth0
  12:         97          XT-PIC  i8042
  14:       5695          XT-PIC  ide0
  15:         24          XT-PIC  ide1
NMI:          0
LOC:     161465
ERR:          0
MIS:          0

dmesg:

Linux version 2.6.12 (root@archivista) (gcc-Version 3.3.5 (Debian 
1:3.3.5-13)) #2 Fri Jul 1 19:58:08 CEST 2005
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000000f7f0000 (usable)
  BIOS-e820: 000000000f7f0000 - 000000000f7f3000 (ACPI NVS)
  BIOS-e820: 000000000f7f3000 - 000000000f800000 (ACPI data)
  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
247MB LOWMEM available.
On node 0 totalpages: 63472
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 59376 pages, LIFO batch:31
   HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI: RSDP (v000 IntelR                                ) @ 0x000f8790
ACPI: RSDT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0f7f3040
ACPI: FADT (v001 IntelR AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0f7f30c0
ACPI: DSDT (v001 INTELR AWRDACPI 0x00001000 MSFT 0x0100000e) @ 0x00000000
ACPI: PM-Timer IO Port: 0x408
Allocating PCI resources starting at 0f800000 (gap: 0f800000:ef400000)
Built 1 zonelists
Kernel command line: root=/dev/hda1 pci=noacpi ro
Found and enabled local APIC!
mapped APIC to ffffd000 (fee00000)
Initializing CPU#0
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 1495.732 MHz processor.
Using pmtmr for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 248264k/253888k available (1569k kernel code, 5048k reserved, 
823k data, 228k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 2957.31 BogoMIPS (lpj=1478656)
Security Framework v1.0.0 initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: bfebfbff 00000000 00000000 00000000 
00004400 00000000 00000000
CPU: After vendor identify, caps: bfebfbff 00000000 00000000 00000000 
00004400 00000000 00000000
CPU: Trace cache: 12K uops, L1 D cache: 8K
CPU: L2 cache: 128K
CPU: After all inits, caps: bfebfbff 00000000 00000000 00000080 00004400 
00000000 00000000
CPU: Intel(R) Celeron(R) CPU 2.00GHz stepping 09
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
EISA bus registered
PCI: PCI BIOS revision 2.10 entry at 0xfa140, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050309
     ACPI-0352: *** Error: Looking up [\_SB_.PCI0.LNK9] in namespace, 
AE_NOT_FOUND
search_node c123ae00 start_node c123ae00 return_node 00000000
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
PnPBIOS: Disabled by ACPI PNP
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:00:02.0
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
PCI: Transparent bridge - 0000:00:1e.0
PCI: Using IRQ router PIIX/ICH [8086/24d0] at 0000:00:1f.0
PCI: IRQ 0 for device 0000:00:1f.1 doesn't match PIRQ mask - try 
pci=usepirqmask
PCI: Found IRQ 10 for device 0000:00:1f.1
PCI: Sharing IRQ 10 with 0000:00:1d.2
pnp: 00:0a: ioport range 0x400-0x4bf could not be reserved
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PNP: PS/2 Controller [PNP0303:PS2K,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 54 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ICH5: IDE controller at PCI slot 0000:00:1f.1
PCI: Found IRQ 10 for device 0000:00:1f.1
PCI: Sharing IRQ 10 with 0000:00:1d.2
ICH5: chipset revision 2
ICH5: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: HTS548060M9AT00, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: QSI CD-ROM SCR-242, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 117210240 sectors (60011 MB) w/7877KiB Cache, CHS=16383/255/63, 
UDMA(33)
hda: cache flushes supported
  hda: hda1 hda2 hda3 hda4
EISA: Probing bus 0 at eisa.0
EISA: Detected 0 cards.
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
NET: Registered protocol family 8
NET: Registered protocol family 20
ACPI wakeup devices:
PCI0 HUB0 UAR1 UAR2 USB0 USB1 USB2 USB3 USBE MODM
ACPI: (supports S0 S1 S4 S5)
input: AT Translated Set 2 keyboard on isa0060/serio0
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 228k freed
kjournald starting.  Commit interval 5 seconds
input: ImExPS/2 Generic Explorer Mouse on isa0060/serio1
NET: Registered protocol family 1
mice: PS/2 mouse device common for all mice
ts: Compaq touchscreen protocol output
Adding 996020k swap on /dev/hda3.  Priority:-1 extents:1
EXT3 FS on hda1, internal journal
Generic RTC Driver v1.07
hdc: ATAPI 24X CD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
Probing IDE interface ide2...
Probing IDE interface ide3...
Probing IDE interface ide4...
Probing IDE interface ide5...
ieee1394: Initialized config rom entry `ip1394'
SCSI subsystem initialized
sbp2: $Rev: 1219 $ Ben Collins <bcollins@debian.org>
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda4, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ohci1394: $Rev: 1250 $ Ben Collins <bcollins@debian.org>
ohci1394: fw-host0: Unexpected PCI resource length of 1000!
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[9] 
MMIO=[f8400000-f84007ff]  Max Packet=[2048]
e100: Intel(R) PRO/100 Network Driver, 3.4.8-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
PCI: Found IRQ 11 for device 0000:01:08.0
e100: eth0: e100_probe: addr 0xf8401000, irq 11, MAC addr 00:0A:9D:08:08:24
Intel 810 + AC97 Audio, version 1.01, 18:57:51 Jul  1 2005
PCI: Found IRQ 5 for device 0000:00:1f.5
PCI: Sharing IRQ 5 with 0000:00:1f.3
PCI: Setting latency timer of device 0000:00:1f.5 to 64
i810: Intel ICH5 found at IO 0xe700 and 0xe600, MEM 0xf8581000 and 
0xf8582000, IRQ 5
i810: Intel ICH5 mmio at 0xd011e000 and 0xd0120000
i810_audio: Primary codec has ID 0
i810_audio: Audio Controller supports 6 channels.
i810_audio: Defaulting to base 2 channel mode.
i810_audio: Resetting connection 0
i810_audio: Connection 0 with codec id 0
ac97_codec: AC97 Audio codec, id: ALG32 (ALC650)
i810_audio: AC'97 codec 0, new EID value = 0x05c7
i810_audio: AC'97 codec 0, DAC map configured, total channels = 6
i810_audio: setting clocking to 48525
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 865 Chipset.
agpgart: Detected 8060K stolen memory.
agpgart: AGP aperture is 128M @ 0xf0000000
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.2
PCI: Found IRQ 10 for device 0000:00:1d.0
PCI: Sharing IRQ 10 with 0000:00:02.0
PCI: Sharing IRQ 10 with 0000:00:1d.3
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB 
UHCI Controller #1
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
irq 10: nobody cared!
  [<c012f64d>] __report_bad_irq+0x31/0x77
  [<c012f6f7>] note_interrupt+0x4c/0x71
  [<c012f200>] __do_IRQ+0xc5/0x10d
  [<c0104c3f>] do_IRQ+0x1b/0x28
  [<c01036f2>] common_interrupt+0x1a/0x20
  [<c011a544>] __do_softirq+0x28/0x74
  [<c011a5b2>] do_softirq+0x22/0x26
  [<c011a651>] irq_exit+0x28/0x32
  [<c0104c44>] do_IRQ+0x20/0x28
  [<c01036f2>] common_interrupt+0x1a/0x20
  [<c012f478>] setup_irq+0xc5/0x104
  [<d0226992>] usb_hcd_irq+0x0/0x4e [usbcore]
  [<c012f605>] request_irq+0x75/0x8c
  [<d0226bdd>] usb_add_hcd+0xe6/0x215 [usbcore]
  [<d0226992>] usb_hcd_irq+0x0/0x4e [usbcore]
  [<d022a35a>] usb_hcd_pci_probe+0x206/0x293 [usbcore]
  [<c01b3630>] pci_device_probe_static+0x2e/0x41
  [<c01b3662>] __pci_device_probe+0x1f/0x32
  [<c01b3691>] pci_device_probe+0x1c/0x31
  [<c01fafba>] driver_probe_device+0x36/0x54
  [<c01fb093>] driver_attach+0x39/0x6e
  [<c01fb464>] bus_add_driver+0x69/0x95
  [<c01fb8e9>] driver_register+0x23/0x25
  [<c01b3850>] pci_register_driver+0x5f/0x72
  [<d000207b>] uhci_hcd_init+0x7b/0xb7 [uhci_hcd]
  [<c012ceaa>] sys_init_module+0xbc/0x1d0
  [<c0102cbd>] syscall_call+0x7/0xb
handlers:
[<d0226992>] (usb_hcd_irq+0x0/0x4e [usbcore])
Disabling IRQ #10
uhci_hcd 0000:00:1d.0: irq 10, io base 0x0000e000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PCI: Found IRQ 9 for device 0000:00:1d.1
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB 
UHCI Controller #2
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:1d.1: irq 9, io base 0x0000e100
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
PCI: Found IRQ 10 for device 0000:00:1d.2
PCI: Sharing IRQ 10 with 0000:00:1f.1
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB UHCI #3
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.2: irq 10, io base 0x0000e200
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
PCI: Found IRQ 10 for device 0000:00:1d.3
PCI: Sharing IRQ 10 with 0000:00:02.0
PCI: Sharing IRQ 10 with 0000:00:1d.0
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB 
UHCI Controller #4
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.3: irq 10, io base 0x0000e300
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
PCI: Found IRQ 11 for device 0000:00:1d.7
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB2 
EHCI Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 5
ehci_hcd 0000:00:1d.7: irq 11, io mem 0xf8580000
PCI: cache line size of 128 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 8 ports detected
hw_random: RNG not detected
pci_hotplug: PCI Hot Plug PCI Core version: 0.5
shpchp: shpc_init : shpc_cap_offset == 0
shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
input: PC Speaker
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
lp0: using parport0 (interrupt-driven).
NET: Registered protocol family 10
Disabled Privacy Extensions on device c03204e0(lo)
IPv6 over IPv4 tunneling driver
eth0: no IPv6 routers present

Any idea appreciated - yours,

-- 
René Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
             http://www.exactcode.de/ | http://www.t2-project.org/
             +49 (0)30  255 897 45

