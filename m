Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbVJOW2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbVJOW2L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 18:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbVJOW2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 18:28:11 -0400
Received: from eastrmmtao05.cox.net ([68.230.240.34]:64985 "EHLO
	eastrmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751247AbVJOW2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 18:28:10 -0400
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7C12733D-6AEC-4798-914D-B3FF5FCC6720@mac.com>
Cc: Frank Tiernan <frankt@promise.com>, Andre Hedrick <andre@linux-ide.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: [BUG] PDC20268 crashing during DMA setup on stock Debian 2.6.12-1-powerpc
Date: Sat, 15 Oct 2005 18:29:36 -0400
To: LKML Kernel <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm trying to upgrade the kernel in a Samba fileserver from a custom- 
compiled 2.6.8.1 to a stock Debian 2.8.12-1-powerpc and running into  
an issue with my Sonnet Tempo ATA/100 [The card is a rebranded  
FirmTek UltraTek/100 which is _actually_ a Promise PDC20268 with Mac- 
bootable firmware ROM].  I'm getting the following BUG() output  
[NOTE: This was hand-copied from the screen after panic, so there may  
be typos despite me being careful to avoid them]:

PDC20268: IDE controller at PCI slot 0001:11:02.0
PDC20268: chipset revision 2
PDC20268: ROM enabled at 0x80090000
PDC20268: 100% native mode on irq 52
ide2: PDC20268 Bus-Master DMA disabled (BIOS)
     ide3: BM-DMA at 0x1408-0x140f, BIOS settings: hdg:pio, hdh:pio
kernel BUG in ide_setup_dma at drivers/ide/ide-dma.c:956!
Oops: Exception in kernel mode, sig: 5 [#1]
NIP: C01ADE44 LR: C01ADE38 SP: C0EA1D60 REGS: c0ea1cb0 TRAP: 0700     
Not tainted
MSR: 00029032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c1e91770[219] 'modprobe' THREAD: c0ea0000
Last syscall: 128
GPR00: 00000000 C0EA1D60 C1E91770 00000001 000019CC FFFFFFFF 00000001  
00000000
GPR08: 00000007 C02F0000 00000000 C0340000 44048488 1001E280 00000000  
00000000
GPR16: C0EA1D9A C0379948 C0377638 00000034 C0EA1E38 00000002 C0377638  
C1DF4838
GPR24: F1041001 00000001 C0280000 C0281E3C 00000008 C03780B4 C0312000  
C0377C10
NIP [c01ade44] ide_setup_dma+0x284/0x5f0
LR [c01ade38] ide_setup_dma+0x278/0x5f0
Call trace:
[c01ac6e0] ide_pci_setup_ports+0x6d0/0x700
[c01ac908] do_ide_setup_pci_device+0x1f8/0x490
[c01acca0] ide_setup_pci_device+0x20/0xa0
[f103eec0] init_setup_pdcnew+0x10/0x20 [pdc202xx_new]
[f103f070] pdc202new_init_one+0x40/0x50 [pdc202xx_new]
[c00eee0c] pci_device_probe+0x9c/0x1a0
[c017f8a4] driver_probe_device+0x54/00xc0
[c017f9a4] driver_attach+0x94/0xd0
[c017fa78] bus_add_driver+0x98/0x1c0
[c0180000] driver_register+0x30/0x40
[c00ee964] pci_register_driver+0x74/0xc0
[c01abd54] ide_pci_register_driver+0x64/0x80
[f103f098] pdc202new_ide_init+0x18/0x30 [pdc202xx_new]
[c003d4a4] sys_init_module+0x174/0x330
[c0004810] ret_from_syscall+0x0/0x4c


This comes while the Debian initrd is modprobing various drivers.   
The working log from my older 2.6.8.1 kernel is appended.  Thanks for  
any advice you can give!  This system is somewhat difficult to test  
new kernels on as it is in production and a 5 hour drive away, but  
I'll try to do what I can.

Cheers,
Kyle Moffett


Oct 15 15:41:22 penelope kernel: Total memory = 832MB; using 2048kB  
for hash table (at c0600000)
Oct 15 15:41:22 penelope kernel: Linux version 2.6.8.1-penelope  
(root@penelope) (gcc version 3.3.4 (Debian 1:3.3.4-6sarge1)) #1 Sun  
Aug 22 22:14:54 EDT 2004
Oct 15 15:41:22 penelope kernel: Found UniNorth memory controller &  
host bridge, revision: 7
Oct 15 15:41:22 penelope kernel: Mapped at 0xfdf00000
Oct 15 15:41:22 penelope kernel: Found a Keylargo mac-io controller,  
rev: 2, mapped at 0xfde80000
Oct 15 15:41:22 penelope kernel: Processor NAP mode on idle enabled.
Oct 15 15:41:22 penelope kernel: PowerMac motherboard: PowerMac G4  
AGP Graphics
Oct 15 15:41:22 penelope kernel: Found UniNorth PCI host bridge at  
0xf0000000. Firmware bus number: 0->0
Oct 15 15:41:22 penelope kernel: Found UniNorth PCI host bridge at  
0xf2000000. Firmware bus number: 0->1
Oct 15 15:41:22 penelope kernel: Found UniNorth PCI host bridge at  
0xf4000000. Firmware bus number: 0->0
Oct 15 15:41:22 penelope kernel: via-pmu: Server Mode is disabled
Oct 15 15:41:22 penelope kernel: PMU driver 2 initialized for Core99,  
firmware: 0c
Oct 15 15:41:22 penelope kernel: nvram: Checking bank 0...
Oct 15 15:41:22 penelope kernel: nvram: gen0=364, gen1=365
Oct 15 15:41:22 penelope kernel: nvram: Active bank is: 1
Oct 15 15:41:22 penelope kernel: nvram: OF partition at 0x210
Oct 15 15:41:22 penelope kernel: nvram: XP partition at 0x1220
Oct 15 15:41:22 penelope kernel: nvram: NR partition at 0x1320
Oct 15 15:41:22 penelope kernel: On node 0 totalpages: 212992
Oct 15 15:41:22 penelope kernel:   DMA zone: 196608 pages, LIFO batch:16
Oct 15 15:41:22 penelope kernel:   Normal zone: 0 pages, LIFO batch:1
Oct 15 15:41:22 penelope kernel:   HighMem zone: 16384 pages, LIFO  
batch:4
Oct 15 15:41:22 penelope kernel: Built 1 zonelists
Oct 15 15:41:22 penelope kernel: Kernel command line: root=/dev/ 
mapper/raid-root ro  ramdisk_size=16384 video=aty128fb:1024x768-32@75
Oct 15 15:41:22 penelope kernel: PowerMac using OpenPIC irq  
controller at 0x80040000
Oct 15 15:41:22 penelope kernel: OpenPIC Version 1.2 (4 CPUs and 64  
IRQ sources) at fc62f000
Oct 15 15:41:22 penelope kernel: OpenPIC timer frequency is 4.166666 MHz
Oct 15 15:41:22 penelope kernel: PID hash table entries: 4096 (order  
12: 32768 bytes)
Oct 15 15:41:22 penelope kernel: GMT Delta read from XPRAM: 0  
minutes, DST: off
Oct 15 15:41:22 penelope kernel: time_init: decrementer frequency =  
24.907667 MHz
Oct 15 15:41:22 penelope kernel: Console: colour dummy device 80x25
Oct 15 15:41:22 penelope kernel: Dentry cache hash table entries:  
131072 (order: 7, 524288 bytes)
Oct 15 15:41:22 penelope kernel: Inode-cache hash table entries:  
65536 (order: 6, 262144 bytes)
Oct 15 15:41:22 penelope kernel: Memory: 832928k available (3460k  
kernel code, 2148k data, 188k init, 65536k highmem)
Oct 15 15:41:22 penelope kernel: AGP special page: 0xeffff000
Oct 15 15:41:22 penelope kernel: Calibrating delay loop... 794.62  
BogoMIPS
Oct 15 15:41:22 penelope kernel: Security Scaffold v1.0.0 initialized
Oct 15 15:41:22 penelope kernel: Capability LSM initialized
Oct 15 15:41:22 penelope kernel: Mount-cache hash table entries: 512  
(order: 0, 4096 bytes)
Oct 15 15:41:22 penelope kernel: checking if image is initramfs...it  
isn't (ungzip failed); looks like an initrd
Oct 15 15:41:22 penelope kernel: Freeing initrd memory: 2824k freed
Oct 15 15:41:22 penelope kernel: NET: Registered protocol family 16
Oct 15 15:41:22 penelope kernel: PCI: Probing PCI hardware
Oct 15 15:41:22 penelope kernel: PCI: Enabling device 0001:02:02.0  
(0006 -> 0007)
Oct 15 15:41:22 penelope kernel: Registering openpic with sysfs...
Oct 15 15:41:22 penelope kernel: SCSI subsystem initialized
Oct 15 15:41:22 penelope kernel: usbcore: registered new driver usbfs
Oct 15 15:41:22 penelope kernel: usbcore: registered new driver hub
Oct 15 15:41:22 penelope kernel: TC classifier action (bugs to  
netdev@oss.sgi.com cc hadi@cyberus.ca)
Oct 15 15:41:22 penelope kernel: PCI: Enabling device 0000:00:10.0  
(0086 -> 0087)
Oct 15 15:41:22 penelope kernel: aty128fb: Invalid ROM signature 1111  
should be 0xaa55
Oct 15 15:41:22 penelope kernel: aty128fb: BIOS not located, guessing  
timings.
Oct 15 15:41:22 penelope kernel: aty128fb: Rage128 PF PRO AGP [chip  
rev 0x1] 16M 128-bit SDR SGRAM (1:1)
Oct 15 15:41:22 penelope kernel: fb0: ATY Rage128 frame buffer device  
on Rage128 PF PRO AGP
Oct 15 15:41:22 penelope kernel: Thermal assist unit using timers,  
shrink_timer: 2000 jiffies
Oct 15 15:41:22 penelope kernel: audit: initializing netlink socket  
(disabled)
Oct 15 15:41:22 penelope kernel: audit(1129405236.223:0): initialized
Oct 15 15:41:22 penelope kernel: highmem bounce pool size: 64 pages
Oct 15 15:41:22 penelope kernel: VFS: Disk quotas dquot_6.5.1
Oct 15 15:41:22 penelope kernel: Dquot-cache hash table entries: 1024  
(order 0, 4096 bytes)
Oct 15 15:41:22 penelope kernel: udf: registering filesystem
Oct 15 15:41:22 penelope kernel: Initializing Cryptographic API
Oct 15 15:41:22 penelope kernel: Console: switching to colour frame  
buffer device 128x48
Oct 15 15:41:22 penelope kernel: Macintosh non-volatile memory driver  
v1.1
Oct 15 15:41:22 penelope kernel: Linux agpgart interface v0.100 (c)  
Dave Jones
Oct 15 15:41:22 penelope kernel: agpgart: Detected Apple UniNorth  
chipset
Oct 15 15:41:22 penelope kernel: agpgart: Maximum main memory to use  
for agp memory: 753M
Oct 15 15:41:22 penelope kernel: agpgart: configuring for size idx: 4
Oct 15 15:41:22 penelope kernel: agpgart: AGP aperture is 16M @ 0x0
Oct 15 15:41:22 penelope kernel: [drm] Initialized r128 2.5.0  
20030725 on minor 0: ATI Technologies Inc Rage 128 PF/PRO AGP 4x TMDS
Oct 15 15:41:22 penelope kernel: pmac_zilog: 0.6 (Benjamin  
Herrenschmidt <benh@kernel.crashing.org>)
Oct 15 15:41:22 penelope kernel: ttyS0 at MMIO 0x80013020 (irq = 22)  
is a Z85c30 ESCC - Serial port
Oct 15 15:41:22 penelope kernel: ttyS1 at MMIO 0x80013000 (irq = 50)  
is a Z85c30 ESCC - Serial port
Oct 15 15:41:22 penelope kernel: RAMDISK driver initialized: 16 RAM  
disks of 16384K size 1024 blocksize
Oct 15 15:41:22 penelope kernel: loop: loaded (max 8 devices)
Oct 15 15:41:22 penelope kernel: sungem.c:v0.98 8/24/03 David S.  
Miller (davem@redhat.com)
Oct 15 15:41:22 penelope kernel: eth0: Sun GEM (PCI) 10/100/1000BaseT  
Ethernet 00:30:65:96:77:a4
Oct 15 15:41:22 penelope kernel: PHY ID: 406212, addr: 0
Oct 15 15:41:22 penelope kernel: eth0: Found BCM5201 PHY
Oct 15 15:41:22 penelope kernel: r8169 Gigabit Ethernet driver 1.2  
loaded
Oct 15 15:41:22 penelope kernel: PCI: Enabling device 0001:02:03.0  
(0014 -> 0017)
Oct 15 15:41:22 penelope kernel: eth1: Identified chip type is  
'RTL8169s/8110s'.
Oct 15 15:41:22 penelope kernel: eth1: RTL8169 at 0xf2527000,  
00:08:54:d1:af:f9, IRQ 53
Oct 15 15:41:22 penelope kernel: eth1: Auto-negotiation Enabled.
Oct 15 15:41:22 penelope kernel: eth1: 1000Mbps Full-duplex operation.
Oct 15 15:41:23 penelope kernel: netconsole: not configured, aborting
Oct 15 15:41:23 penelope kernel: MacIO PCI driver attached to  
Keylargo chipset
Oct 15 15:41:23 penelope kernel: Can't request resource 0 for MacIO  
device 0.80000000:mac-io
Oct 15 15:41:23 penelope kernel: Uniform Multi-Platform E-IDE driver  
Revision: 7.00alpha2
Oct 15 15:41:23 penelope kernel: ide: Assuming 33MHz system bus speed  
for PIO modes; override with idebus=xx
Oct 15 15:41:23 penelope kernel: PDC20268: IDE controller at PCI slot  
0001:02:02.0
Oct 15 15:41:23 penelope kernel: PDC20268: chipset revision 2
Oct 15 15:41:23 penelope kernel: PDC20268: ROM enabled at 0x80090000
Oct 15 15:41:23 penelope kernel: PDC20268: 100%% native mode on irq 52
Oct 15 15:41:23 penelope kernel:     ide2: BM-DMA at 0x1400-0x1407,  
BIOS settings: hde:pio, hdf:pio
Oct 15 15:41:23 penelope kernel:     ide3: BM-DMA at 0x1408-0x140f,  
BIOS settings: hdg:pio, hdh:pio
Oct 15 15:41:23 penelope kernel: Probing IDE interface ide2...
Oct 15 15:41:23 penelope kernel: hde: Maxtor 6Y080P0, ATA DISK drive
Oct 15 15:41:23 penelope kernel: Using anticipatory io scheduler
Oct 15 15:41:23 penelope kernel: ide2 at 0x1440-0x1447,0x1432 on irq 52
Oct 15 15:41:23 penelope kernel: Probing IDE interface ide3...
Oct 15 15:41:23 penelope kernel: hdg: SAMSUNG SP0822N, ATA DISK drive
Oct 15 15:41:23 penelope kernel: ide3 at 0x1420-0x1427,0x1412 on irq 52
Oct 15 15:41:23 penelope kernel: ide0: Found Apple KeyLargo ATA-4  
controller, bus ID 2, irq 19
Oct 15 15:41:23 penelope kernel: Probing IDE interface ide0...
Oct 15 15:41:23 penelope kernel: hda: ST380011A, ATA DISK drive
Oct 15 15:41:23 penelope kernel: ide_pmac: Set UDMA timing for mode  
4, reg: 0x0c50038c
Oct 15 15:41:23 penelope kernel: hda: Enabling Ultra DMA 4
Oct 15 15:41:23 penelope kernel: ide0 at  
0xf2529000-0xf2529007,0xf2529160 on irq 19
Oct 15 15:41:23 penelope kernel: ide1: Found Apple KeyLargo ATA-3  
controller, bus ID 0, irq 20
Oct 15 15:41:23 penelope kernel: Probing IDE interface ide1...
Oct 15 15:41:23 penelope kernel: hdc: CD-ROM Drive/F5A, ATAPI CD/DVD- 
ROM drive
Oct 15 15:41:23 penelope kernel: hdc: Disabling (U)DMA for CD-ROM  
Drive/F5A (blacklisted)
Oct 15 15:41:23 penelope kernel: ide1 at  
0xf252e000-0xf252e007,0xf252e160 on irq 20
Oct 15 15:41:23 penelope kernel: ide4: Found Apple KeyLargo ATA-3  
controller, bus ID 1, irq 21
Oct 15 15:41:23 penelope kernel: Probing IDE interface ide4...
Oct 15 15:41:23 penelope kernel: ide4: Bus empty, interface released.
Oct 15 15:41:23 penelope kernel: hde: max request size: 128KiB
Oct 15 15:41:23 penelope kernel: hde: 160086528 sectors (81964 MB) w/ 
7936KiB Cache, CHS=65535/16/63, UDMA(100)
Oct 15 15:41:23 penelope kernel:  hde:hde: dma_intr: status=0x51  
{ DriveReady SeekComplete Error }
Oct 15 15:41:23 penelope kernel: hde: dma_intr: error=0x84  
{ DriveStatusError BadCRC }
Oct 15 15:41:23 penelope kernel: hde: dma_intr: status=0x51  
{ DriveReady SeekComplete Error }
Oct 15 15:41:23 penelope kernel: hde: dma_intr: error=0x84  
{ DriveStatusError BadCRC }
Oct 15 15:41:23 penelope kernel: hde: dma_intr: status=0x51  
{ DriveReady SeekComplete Error }
Oct 15 15:41:23 penelope kernel: hde: dma_intr: error=0x84  
{ DriveStatusError BadCRC }
Oct 15 15:41:23 penelope kernel: hde: dma_intr: status=0x51  
{ DriveReady SeekComplete Error }
Oct 15 15:41:23 penelope kernel: hde: dma_intr: error=0x84  
{ DriveStatusError BadCRC }
Oct 15 15:41:23 penelope kernel: PDC202XX: Primary channel reset.
Oct 15 15:41:23 penelope kernel: ide2: reset: success
Oct 15 15:41:23 penelope kernel:  [mac] hde1 hde2 hde3 hde4 hde5
Oct 15 15:41:23 penelope kernel: hdg: max request size: 1024KiB
Oct 15 15:41:23 penelope kernel: hdg: 156368016 sectors (80060 MB) w/ 
2048KiB Cache, CHS=16383/255/63, UDMA(100)
Oct 15 15:41:23 penelope kernel:  hdg:hdg: dma_intr: status=0x51  
{ DriveReady SeekComplete Error }
Oct 15 15:41:23 penelope kernel: hdg: dma_intr: error=0x84  
{ DriveStatusError BadCRC }
Oct 15 15:41:23 penelope kernel: hdg: dma_intr: status=0x51  
{ DriveReady SeekComplete Error }
Oct 15 15:41:23 penelope kernel: hdg: dma_intr: error=0x84  
{ DriveStatusError BadCRC }
Oct 15 15:41:23 penelope kernel: hdg: dma_intr: status=0x51  
{ DriveReady SeekComplete Error }
Oct 15 15:41:23 penelope kernel: hdg: dma_intr: error=0x84  
{ DriveStatusError BadCRC }
Oct 15 15:41:23 penelope kernel: hdg: dma_intr: status=0x51  
{ DriveReady SeekComplete Error }
Oct 15 15:41:23 penelope kernel: hdg: dma_intr: error=0x84  
{ DriveStatusError BadCRC }
Oct 15 15:41:23 penelope kernel: PDC202XX: Secondary channel reset.
Oct 15 15:41:23 penelope kernel: ide3: reset: success
Oct 15 15:41:23 penelope kernel:  unknown partition table
Oct 15 15:41:23 penelope kernel: hda: max request size: 1024KiB
Oct 15 15:41:23 penelope kernel: hda: 156301488 sectors (80026 MB) w/ 
2048KiB Cache, CHS=16383/255/63, UDMA(66)
Oct 15 15:41:23 penelope kernel:  hda: [mac] hda1 hda2 hda3 hda4 hda5
Oct 15 15:41:23 penelope kernel: hdc: ATAPI 48X CD-ROM drive, 128kB  
Cache
Oct 15 15:41:23 penelope kernel: Uniform CD-ROM driver Revision: 3.20
Oct 15 15:41:23 penelope kernel: ieee1394: Initialized config rom  
entry `ip1394'
Oct 15 15:41:23 penelope kernel: ohci_hcd: 2004 Feb 02 USB 1.1 'Open'  
Host Controller (OHCI) Driver (PCI)
Oct 15 15:41:23 penelope kernel: ohci_hcd: block sizes: ed 64 td 64
Oct 15 15:41:23 penelope kernel: PCI: Enabling device 0001:02:08.0  
(0000 -> 0002)
Oct 15 15:41:23 penelope kernel: ohci_hcd 0001:02:08.0: Apple  
Computer Inc. KeyLargo USB
Oct 15 15:41:23 penelope kernel: ohci_hcd 0001:02:08.0: irq 27, pci  
mem f2547000
Oct 15 15:41:23 penelope kernel: ohci_hcd 0001:02:08.0: new USB bus  
registered, assigned bus number 1
Oct 15 15:41:23 penelope kernel: hub 1-0:1.0: USB hub found
Oct 15 15:41:23 penelope kernel: hub 1-0:1.0: 2 ports detected
Oct 15 15:41:23 penelope kernel: PCI: Enabling device 0001:02:09.0  
(0000 -> 0002)
Oct 15 15:41:23 penelope kernel: ohci_hcd 0001:02:09.0: Apple  
Computer Inc. KeyLargo USB (#2)
Oct 15 15:41:23 penelope kernel: ohci_hcd 0001:02:09.0: irq 28, pci  
mem f2549000
Oct 15 15:41:23 penelope kernel: ohci_hcd 0001:02:09.0: new USB bus  
registered, assigned bus number 2
Oct 15 15:41:23 penelope kernel: hub 2-0:1.0: USB hub found
Oct 15 15:41:23 penelope kernel: hub 2-0:1.0: 2 ports detected
Oct 15 15:41:23 penelope kernel: Initializing USB Mass Storage driver...
Oct 15 15:41:23 penelope kernel: usbcore: registered new driver usb- 
storage
Oct 15 15:41:23 penelope kernel: USB Mass Storage support registered.
Oct 15 15:41:23 penelope kernel: usbcore: registered new driver hiddev
Oct 15 15:41:23 penelope kernel: usbcore: registered new driver usbhid
Oct 15 15:41:23 penelope kernel: drivers/usb/input/hid-core.c:  
v2.0:USB HID core driver
Oct 15 15:41:23 penelope kernel: drivers/usb/serial/usb-serial.c: USB  
Serial support registered for Generic
Oct 15 15:41:23 penelope kernel: usbcore: registered new driver  
usbserial_generic
Oct 15 15:41:23 penelope kernel: usbcore: registered new driver  
usbserial
Oct 15 15:41:23 penelope kernel: drivers/usb/serial/usb-serial.c: USB  
Serial Driver core v2.0
Oct 15 15:41:23 penelope kernel: drivers/usb/serial/usb-serial.c: USB  
Serial support registered for Keyspan - (without firmware)
Oct 15 15:41:23 penelope kernel: drivers/usb/serial/usb-serial.c: USB  
Serial support registered for Keyspan 1 port adapter
Oct 15 15:41:23 penelope kernel: drivers/usb/serial/usb-serial.c: USB  
Serial support registered for Keyspan 2 port adapter
Oct 15 15:41:23 penelope kernel: drivers/usb/serial/usb-serial.c: USB  
Serial support registered for Keyspan 4 port adapter
Oct 15 15:41:23 penelope kernel: usbcore: registered new driver keyspan
Oct 15 15:41:23 penelope kernel: drivers/usb/serial/keyspan.c:  
v1.1.4:Keyspan USB to Serial Converter Driver
Oct 15 15:41:23 penelope kernel: mice: PS/2 mouse device common for  
all mice
Oct 15 15:41:23 penelope kernel: i2c /dev entries driver
Oct 15 15:41:23 penelope kernel: Found KeyWest i2c on "uni-n", 2  
channels, stepping: 4 bits
Oct 15 15:41:23 penelope kernel: Found KeyWest i2c on "mac-io", 1  
channel, stepping: 4 bits
Oct 15 15:41:23 penelope kernel: md: linear personality registered as  
nr 1
Oct 15 15:41:23 penelope kernel: md: raid0 personality registered as  
nr 2
Oct 15 15:41:23 penelope kernel: md: raid1 personality registered as  
nr 3
Oct 15 15:41:23 penelope kernel: md: raid5 personality registered as  
nr 4
Oct 15 15:41:23 penelope kernel: raid5: measuring checksumming speed
Oct 15 15:41:23 penelope kernel:    8regs     :   488.000 MB/sec
Oct 15 15:41:23 penelope kernel:    8regs_prefetch:   436.000 MB/sec
Oct 15 15:41:23 penelope kernel:    32regs    :   484.000 MB/sec
Oct 15 15:41:23 penelope kernel:    32regs_prefetch:   432.000 MB/sec
Oct 15 15:41:23 penelope kernel: raid5: using function: 8regs  
(488.000 MB/sec)
Oct 15 15:41:23 penelope kernel: raid6: int32x1     85 MB/s
Oct 15 15:41:23 penelope kernel: raid6: int32x2    117 MB/s
Oct 15 15:41:23 penelope kernel: raid6: int32x4    152 MB/s
Oct 15 15:41:23 penelope kernel: raid6: int32x8    128 MB/s
Oct 15 15:41:23 penelope kernel: raid6: using algorithm int32x4 (152  
MB/s)
Oct 15 15:41:23 penelope kernel: md: raid6 personality registered as  
nr 8
Oct 15 15:41:23 penelope kernel: md: multipath personality registered  
as nr 7
Oct 15 15:41:23 penelope kernel: md: md driver 0.90.0  
MAX_MD_DEVS=256, MD_SB_DISKS=27
Oct 15 15:41:23 penelope kernel: device-mapper: 4.1.0-ioctl  
(2003-12-10) initialised: dm@uk.sistina.com
Oct 15 15:41:23 penelope kernel: u32 classifier
Oct 15 15:41:23 penelope kernel:     Perfomance counters on
Oct 15 15:41:23 penelope kernel:     input device check on
Oct 15 15:41:23 penelope kernel:     Actions configured
Oct 15 15:41:23 penelope kernel: NET: Registered protocol family 2
Oct 15 15:41:23 penelope kernel: IP: routing cache hash table of 8192  
buckets, 64Kbytes
Oct 15 15:41:23 penelope kernel: TCP: Hash tables configured  
(established 262144 bind 65536)
Oct 15 15:41:23 penelope kernel: ip_conntrack version 2.1 (6656  
buckets, 53248 max) - 296 bytes per conntrack
Oct 15 15:41:23 penelope kernel: ip_tables: (C) 2000-2002 Netfilter  
core team
Oct 15 15:41:23 penelope kernel: usb 2-1: new full speed USB device  
using address 2
Oct 15 15:41:23 penelope kernel: hub 2-1:1.0: USB hub found
Oct 15 15:41:23 penelope kernel: hub 2-1:1.0: 3 ports detected
Oct 15 15:41:23 penelope kernel: ipt_recent v0.3.1: Stephen Frost  
<sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
Oct 15 15:41:23 penelope kernel: arp_tables: (C) 2002 David S. Miller
Oct 15 15:41:23 penelope kernel: Initializing IPsec netlink socket
Oct 15 15:41:23 penelope kernel: NET: Registered protocol family 1
Oct 15 15:41:23 penelope kernel: NET: Registered protocol family 10
Oct 15 15:41:23 penelope kernel: IPv6 over IPv4 tunneling driver
Oct 15 15:41:23 penelope kernel: ip6_tables: (C) 2000-2002 Netfilter  
core team
Oct 15 15:41:23 penelope kernel: registering ipv6 mark target
Oct 15 15:41:23 penelope kernel: NET: Registered protocol family 17
Oct 15 15:41:23 penelope kernel: NET: Registered protocol family 15
Oct 15 15:41:23 penelope kernel: md: Autodetecting RAID arrays.
Oct 15 15:41:23 penelope kernel: md: autorun ...
Oct 15 15:41:23 penelope kernel: md: ... autorun DONE.
Oct 15 15:41:23 penelope kernel: RAMDISK: cramfs filesystem found at  
block 0
Oct 15 15:41:23 penelope kernel: RAMDISK: Loading 2824 blocks [1  
disk] into ram disk... |^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H 
\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H- 
^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/ 
^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H| 
^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H 
\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H- 
^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/ 
^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H| 
^Hdone.
Oct 15 15:41:23 penelope kernel: usb 2-1.1: new full speed USB device  
using address 3
Oct 15 15:41:23 penelope kernel: VFS: Mounted root (cramfs  
filesystem) readonly.
Oct 15 15:41:23 penelope kernel: input: USB HID v1.10 Keyboard  
[Mitsumi Electric Apple Extended USB Keyboard] on usb-0001:02:09.0-1.1
Oct 15 15:41:23 penelope kernel: input: USB HID v1.10 Device [Mitsumi  
Electric Apple Extended USB Keyboard] on usb-0001:02:09.0-1.1
Oct 15 15:41:23 penelope kernel: Freeing unused kernel memory: 188k  
init 4k chrp 8k prep
Oct 15 15:41:23 penelope kernel: md: md0 stopped.
Oct 15 15:41:23 penelope kernel: md: bind<hda3>
Oct 15 15:41:23 penelope kernel: md: bind<hde3>
Oct 15 15:41:23 penelope kernel: raid1: raid set md0 active with 2  
out of 3 mirrors
Oct 15 15:41:23 penelope kernel: md: md1 stopped.
Oct 15 15:41:23 penelope kernel: md: bind<hda4>
Oct 15 15:41:23 penelope kernel: md: bind<hde4>
Oct 15 15:41:23 penelope kernel: raid5: device hde4 operational as  
raid disk 0
Oct 15 15:41:23 penelope kernel: raid5: device hda4 operational as  
raid disk 1
Oct 15 15:41:23 penelope kernel: raid5: allocated 3168kB for md1
Oct 15 15:41:23 penelope kernel: raid5: raid level 5 set md1 active  
with 2 out of 3 devices, algorithm 2
Oct 15 15:41:23 penelope kernel: RAID5 conf printout:
Oct 15 15:41:23 penelope kernel:  --- rd:3 wd:2 fd:1
Oct 15 15:41:23 penelope kernel:  disk 0, o:1, dev:hde4
Oct 15 15:41:23 penelope kernel:  disk 1, o:1, dev:hda4
Oct 15 15:41:23 penelope kernel: md: md2 stopped.
Oct 15 15:41:23 penelope kernel: md: bind<hda5>
Oct 15 15:41:23 penelope kernel: md: bind<hde5>
Oct 15 15:41:23 penelope kernel: raid5: device hde5 operational as  
raid disk 0
Oct 15 15:41:23 penelope kernel: raid5: device hda5 operational as  
raid disk 1
Oct 15 15:41:23 penelope kernel: raid5: allocated 3168kB for md2
Oct 15 15:41:23 penelope kernel: raid5: raid level 5 set md2 active  
with 2 out of 3 devices, algorithm 2
Oct 15 15:41:23 penelope kernel: RAID5 conf printout:
Oct 15 15:41:23 penelope kernel:  --- rd:3 wd:2 fd:1
Oct 15 15:41:23 penelope kernel:  disk 0, o:1, dev:hde5
Oct 15 15:41:23 penelope kernel:  disk 1, o:1, dev:hda5
Oct 15 15:41:23 penelope kernel: cdrom: open failed.
Oct 15 15:41:23 penelope kernel: hde: dma_intr: status=0x51  
{ DriveReady SeekComplete Error }
Oct 15 15:41:23 penelope kernel: hde: dma_intr: error=0x84  
{ DriveStatusError BadCRC }
Oct 15 15:41:23 penelope kernel: hde: dma_intr: status=0x51  
{ DriveReady SeekComplete Error }
Oct 15 15:41:23 penelope kernel: hde: dma_intr: error=0x84  
{ DriveStatusError BadCRC }
Oct 15 15:41:23 penelope kernel: hde: dma_intr: status=0x51  
{ DriveReady SeekComplete Error }
Oct 15 15:41:23 penelope kernel: hde: dma_intr: error=0x84  
{ DriveStatusError BadCRC }
Oct 15 15:41:23 penelope kernel: hde: dma_intr: status=0x51  
{ DriveReady SeekComplete Error }
Oct 15 15:41:23 penelope kernel: hde: dma_intr: error=0x84  
{ DriveStatusError BadCRC }
Oct 15 15:41:23 penelope kernel: PDC202XX: Primary channel reset.
Oct 15 15:41:23 penelope kernel: ide2: reset: success
Oct 15 15:41:23 penelope kernel: kjournald starting.  Commit interval  
5 seconds
Oct 15 15:41:23 penelope kernel: EXT3-fs warning: maximal mount count  
reached, running e2fsck is recommended
Oct 15 15:41:23 penelope kernel: EXT3 FS on dm-0, internal journal
Oct 15 15:41:23 penelope kernel: EXT3-fs: mounted filesystem with  
ordered data mode.
Oct 15 15:41:23 penelope kernel: Adding 1048440k swap on /dev/md1.   
Priority:-1 extents:1
Oct 15 15:41:23 penelope kernel: cdrom: open failed.
Oct 15 15:41:23 penelope kernel: kjournald starting.  Commit interval  
5 seconds
Oct 15 15:41:23 penelope kernel: EXT3 FS on md0, internal journal
Oct 15 15:41:23 penelope kernel: EXT3-fs: mounted filesystem with  
ordered data mode.
Oct 15 15:41:23 penelope kernel: kjournald starting.  Commit interval  
5 seconds
Oct 15 15:41:23 penelope kernel: EXT3 FS on dm-3, internal journal
Oct 15 15:41:23 penelope kernel: EXT3-fs: mounted filesystem with  
ordered data mode.
Oct 15 15:41:23 penelope kernel: kjournald starting.  Commit interval  
5 seconds
Oct 15 15:41:23 penelope kernel: EXT3 FS on dm-2, internal journal
Oct 15 15:41:23 penelope kernel: EXT3-fs: mounted filesystem with  
ordered data mode.
Oct 15 15:41:23 penelope kernel: kjournald starting.  Commit interval  
5 seconds
Oct 15 15:41:23 penelope kernel: EXT3 FS on dm-1, internal journal
Oct 15 15:41:23 penelope kernel: EXT3-fs: mounted filesystem with  
ordered data mode.
Oct 15 15:41:23 penelope kernel: kjournald starting.  Commit interval  
5 seconds
Oct 15 15:41:23 penelope kernel: EXT3 FS on dm-4, internal journal
Oct 15 15:41:23 penelope kernel: EXT3-fs: mounted filesystem with  
ordered data mode.
Oct 15 15:41:23 penelope kernel: ohci1394: $Rev: 1223 $ Ben Collins  
<bcollins@debian.org>
Oct 15 15:41:23 penelope kernel: PCI: Enabling device 0001:02:0a.0  
(0010 -> 0012)
Oct 15 15:41:23 penelope kernel: ohci1394: fw-host0: OHCI-1394 1.0  
(PCI): IRQ=[63]  MMIO=[80081000-800817ff]  Max Packet=[2048]
Oct 15 15:41:23 penelope kernel: ip1394: $Rev: 1224 $ Ben Collins  
<bcollins@debian.org>
Oct 15 15:41:23 penelope kernel: ip1394: eth2: IEEE-1394 IPv4 over  
1394 Ethernet (fw-host0)
Oct 15 15:41:23 penelope kernel: ieee1394: Host added: ID:BUS 
[0-00:1023]  GUID[003065fffe9677a4]
Oct 15 15:41:23 penelope kernel: Disabled Privacy Extensions on  
device c048799c(lo)
Oct 15 15:41:23 penelope kernel: Disabled Privacy Extensions on  
device ef4bcc00(tun_624)
Oct 15 15:41:32 penelope kernel: Installing knfsd (copyright (C) 1996  
okir@monad.swb.de).
Oct 15 16:00:03 penelope kernel: PHY ID: 406212, addr: 0
Oct 15 16:00:05 penelope kernel: eth_pub: Link is up at 100 Mbps,  
full-duplex.
Oct 15 16:00:05 penelope kernel: eth_pub: Pause is disabled

