Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbTKYOAg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 09:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbTKYOAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 09:00:36 -0500
Received: from pop.gmx.de ([213.165.64.20]:26800 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262683AbTKYN7z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 08:59:55 -0500
X-Authenticated: #4512188
Message-ID: <3FC36057.40108@gmx.de>
Date: Tue, 25 Nov 2003 14:59:51 +0100
From: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031116
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Silicon Image 3112A SATA trouble
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think it it high time to get the SIIMAGE.C 1.06 bugfree. It seems to 
have some problems with my HD+SATA converter mainly performance wise. I 
htink it is due to this error coming constanlty in dmesg unless I 
comment it out in the sources:

hde: sata_error = 0x00000000, watchdog = 0, siimage_mmio_ide_dma_test_irq

What is the problem? I think it may be due to the fact that I have an 
SiI3112A controller onboard and the driver detects it without the A 
revision (just as SiI3112). And/or it is due to the fact that I 
connected a PATA drive with a SATA converter to the controller.

Now with 2.6-test10 the performance got a bit better in comparison to 
test9 and prior 2.6 kernels. Before it was max 22MB/sec and now it is 
25mb/sec. But it is still far away from 2.4.22-ac4 kernel which managed 
37mb/s, which is still bad in comparison to windows which reaches 50mb/s.

It is NOT a problem of read-ahead. I tried various hdparm parameters and 
it didn't improve the situation. What makes the situation even worse:

When I try hdparm -d1 /dev/hde (though hdparm sates dma is already on) 
the drive stops working and I get some lines of erorrs like drive-seek 
error and some irq related stuff. So I have to push the button.

Someone else using a native SATA Maxtor on Sil3112 (dunno whether A or 
not) has no problems, hdparm -d works as well and he gets 40mb/sec with 
test10.

So what may be the problem, and how to get rid of it? (1. error message, 
2. bad performance, 3. hdparm -d1 malfunctioning). 1 & 3 were also with 
2.4.22-ac4 and 2 wasn't that bad, as stated above, so except 2 there is 
no regression, but also no fix yet. Changing max_kb_per_request didn't 
help either.

If you need more infos, just ask me.


Here the relevant part of dmesg:

SiI3112 Serial ATA: IDE controller at PCI slot 0000:01:0b.0
SiI3112 Serial ATA: chipset revision 2
SiI3112 Serial ATA: 100% native mode on irq 11
     ide2: MMIO-DMA at 0xf9844000-0xf9844007, BIOS settings: hde:pio, 
hdf:pio
     ide3: MMIO-DMA at 0xf9844008-0xf984400f, BIOS settings: hdg:pio, 
hdh:pio
hde: SAMSUNG SP1614N, ATA DISK drive
ide2 at 0xf9844080-0xf9844087,0xf984408a on irq 11
hde: max request size: 7KiB
hde: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=19457/255/63, 
UDMA(100)
  /dev/ide/host2/bus0/target0/lun0:<4>hde: sata_error = 0x00000000, 
watchdog = 0, siimage_mmio_ide_dma_test_irq
  p1 p2 p3 <<4>hde: sata_error = 0x00000000, watchdog = 0, 
siimage_mmio_ide_dma_test_irq
  p5<4>hde: sata_error = 0x00000000, watchdog = 0, 
siimage_mmio_ide_dma_test_irq
  p6<4>hde: sata_error = 0x00000000, watchdog = 0, 
siimage_mmio_ide_dma_test_irq
  p7<4>hde: sata_error = 0x00000000, watchdog = 0, 
siimage_mmio_ide_dma_test_irq
  p8<4>hde: sata_error = 0x00000000, watchdog = 0, 
siimage_mmio_ide_dma_test_irq
  p9 >



Here is hdparm -iI /dev/hde:



/dev/hde:

  Model=SAMSUNG SP1614N, FwRev=TM100-24, SerialNo=0735J1FW702444
  Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
  RawCHS=16383/16/63, TrkSize=34902, SectSize=554, ECCbytes=4
  BuffType=DualPortCache, BuffSize=8192kB, MaxMultSect=16, MultSect=16
  CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=268435455
  IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
  PIO modes:  pio0 pio1 pio2 pio3 pio4
  DMA modes:  mdma0 mdma1 mdma2
  UDMA modes: udma0 udma1 udma2
  AdvancedPM=no WriteCache=enabled
  Drive conforms to: (null):

  * signifies the current active mode


ATA device, with non-removable media
         Model Number:       SAMSUNG SP1614N
         Serial Number:      0735J1FW702444
         Firmware Revision:  TM100-24
Standards:
         Supported: 7 6 5 4
         Likely used: 7
Configuration:
         Logical         max     current
         cylinders       16383   65535
         heads           16      1
         sectors/track   63      63
         --
         CHS current addressable sectors:    4128705
         LBA    user addressable sectors:  268435455
         LBA48  user addressable sectors:  312581808
         device size with M = 1024*1024:      152627 MBytes
         device size with M = 1000*1000:      160041 MBytes (160 GB)
Capabilities:
         LBA, IORDY(can be disabled)
         Queue depth: 1
         Standby timer values: spec'd by Standard, no device specific 
minimum
         R/W multiple sector transfer: Max = 16  Current = 16
         Recommended acoustic management value: 254, current value: 0
         DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5
              Cycle time: min=120ns recommended=120ns
         PIO: pio0 pio1 pio2 pio3 pio4
              Cycle time: no flow control=240ns  IORDY flow control=120ns
Commands/features:
         Enabled Supported:
            *    READ BUFFER cmd
            *    WRITE BUFFER cmd
            *    Host Protected Area feature set
            *    Look-ahead
            *    Write cache
            *    Power Management feature set
                 Security Mode feature set
            *    SMART feature set
            *    FLUSH CACHE EXT command
            *    Mandatory FLUSH CACHE command
            *    Device Configuration Overlay feature set
            *    48-bit Address feature set
                 Automatic Acoustic Management feature set
                 SET MAX security extension
            *    DOWNLOAD MICROCODE cmd
            *    SMART self-test
            *    SMART error logging
Security:
         Master password revision code = 65534
                 supported
         not     enabled
         not     locked
         not     frozen
         not     expired: security count
                 supported: enhanced erase
         96min for SECURITY ERASE UNIT. 96min for ENHANCED SECURITY 
ERASE UNIT.
HW reset results:
         CBLID- below Vih
         Device num = 0 determined by the jumper
Checksum: correct



And here the complete dmesg:

Linux version 2.6.0-gentoo (root@tachyon) (gcc-Version 3.3.2 20031022 
(Gentoo Linux 3.3.2-r2, propolice)) #6 Tue Nov 25 14:40:13 CET 2003
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000003fff0000 (usable)
  BIOS-e820: 000000003fff0000 - 000000003fff3000 (ACPI NVS)
  BIOS-e820: 000000003fff3000 - 0000000040000000 (ACPI data)
  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
127MB HIGHMEM available.
896MB LOWMEM available.
On node 0 totalpages: 262128
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 225280 pages, LIFO batch:16
   HighMem zone: 32752 pages, LIFO batch:7
DMI 2.2 present.
ACPI: RSDP (v000 Nvidia                                    ) @ 0x000f6b60
ACPI: RSDT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3000
ACPI: FADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff3040
ACPI: MADT (v001 Nvidia AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x3fff79c0
ACPI: DSDT (v001 NVIDIA AWRDACPI 0x00001000 MSFT 0x0100000d) @ 0x00000000
Building zonelist for node : 0
Kernel command line: root=/dev/hde6 hdg=none vga=0x51A video=vesa:mtrr,ywrap
ide_setup: hdg=none
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 1904.513 MHz processor.
Console: colour dummy device 80x25
Memory: 1032280k/1048512k available (3128k kernel code, 15280k reserved, 
1007k data, 160k init, 131008k highmem)
Calibrating delay loop... 3768.32 BogoMIPS
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (ungzip failed); looks like an 
initrd
Freeing initrd memory: 304k freed
CPU:     After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1c3fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm)  stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb420, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
ACPI: IRQ 9 was Edge Triggered, setting to Level Triggerd
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.HUB0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNK1] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK2] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNK3] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK4] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNK5] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LUBA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LUBB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMAC] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LAPU] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LACI] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LMCI] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LSMB] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LUB2] (IRQs 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LFIR] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [L3CM] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LIDE] (IRQs 3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [APC1] (IRQs *16)
ACPI: PCI Interrupt Link [APC2] (IRQs 17)
ACPI: PCI Interrupt Link [APC3] (IRQs *18)
ACPI: PCI Interrupt Link [APC4] (IRQs *19)
ACPI: PCI Interrupt Link [APCE] (IRQs 16)
ACPI: PCI Interrupt Link [APCF] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCG] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCH] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCI] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCJ] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCK] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCS] (IRQs *23)
ACPI: PCI Interrupt Link [APCL] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCM] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [AP3C] (IRQs 20 21 22)
ACPI: PCI Interrupt Link [APCZ] (IRQs 20 21 22)
Linux Plug and Play Support v0.97 (c) Adam Belay
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LSMB] enabled at IRQ 10
ACPI: PCI Interrupt Link [LUBA] enabled at IRQ 11
ACPI: PCI Interrupt Link [LUBB] enabled at IRQ 5
ACPI: PCI Interrupt Link [LUB2] enabled at IRQ 10
ACPI: PCI Interrupt Link [LMAC] enabled at IRQ 10
ACPI: PCI Interrupt Link [LAPU] enabled at IRQ 10
ACPI: PCI Interrupt Link [LACI] enabled at IRQ 5
ACPI: PCI Interrupt Link [LFIR] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNK4] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNK1] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNK3] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 
'acpi=off'
vesafb: framebuffer at 0xc0000000, mapped to 0xf8808000, size 16384k
vesafb: mode is 1280x1024x16, linelength=2560, pages=1
vesafb: protected mode interface info at c000:ea60
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
Machine check exception polling timer started.
IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
apm: overridden by ACPI.
highmem bounce pool size: 64 pages
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.5 [Flags: R/W].
udf: registering filesystem
SGI XFS for Linux with large block numbers, no debug enabled
ACPI: Power Button (FF) [PWRF]
ACPI: Fan [FAN] (on)
ACPI: Processor [CPU0] (supports C1)
ACPI: Thermal Zone [THRM] (43 C)
bootsplash 3.1.3-2003/11/14: looking for picture.... silentjpeg size 
155838 bytes, found (1280x1024, 155850 bytes, v3).
Console: switching to colour frame buffer device 153x58
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Using anticipatory io scheduler
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.18.
PCI: Setting latency timer of device 0000:00:04.0 to 64
eth0: forcedeth.c: subsystem: 0147b:1c00
Linux video capture interface: v1.00
DriverInitialize MAC address = ff:ff:ff:ff:ff:ff:00:00
DriverInitialize key =
  ff ff ff ff
  ff ff ff ff
  ff ff ff ff
  ff ff ff ff
DVB: registering new adapter (Technisat SkyStar2 driver).
DVB: registering frontend 0:0 (Zarlink MT312)...
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
NFORCE2: IDE controller at PCI slot 0000:00:09.0
NFORCE2: chipset revision 162
NFORCE2: not 100% native mode: will probe irqs later
NFORCE2: 0000:00:09.0 (rev a2) UDMA133 controller
     ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
     ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: _NEC DV-5800A, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: LITE-ON LTR-16102B, ATAPI CD/DVD-ROM drive
hdd: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
ide1 at 0x170-0x177,0x376 on irq 15
SiI3112 Serial ATA: IDE controller at PCI slot 0000:01:0b.0
SiI3112 Serial ATA: chipset revision 2
SiI3112 Serial ATA: 100% native mode on irq 11
     ide2: MMIO-DMA at 0xf9844000-0xf9844007, BIOS settings: hde:pio, 
hdf:pio
     ide3: MMIO-DMA at 0xf9844008-0xf984400f, BIOS settings: hdg:pio, 
hdh:pio
hde: SAMSUNG SP1614N, ATA DISK drive
ide2 at 0xf9844080-0xf9844087,0xf984408a on irq 11
hde: max request size: 7KiB
hde: 312581808 sectors (160041 MB) w/8192KiB Cache, CHS=19457/255/63, 
UDMA(100)
  /dev/ide/host2/bus0/target0/lun0:<4>hde: sata_error = 0x00000000, 
watchdog = 0, siimage_mmio_ide_dma_test_irq
  p1 p2 p3 <<4>hde: sata_error = 0x00000000, watchdog = 0, 
siimage_mmio_ide_dma_test_irq
  p5<4>hde: sata_error = 0x00000000, watchdog = 0, 
siimage_mmio_ide_dma_test_irq
  p6<4>hde: sata_error = 0x00000000, watchdog = 0, 
siimage_mmio_ide_dma_test_irq
  p7<4>hde: sata_error = 0x00000000, watchdog = 0, 
siimage_mmio_ide_dma_test_irq
  p8<4>hde: sata_error = 0x00000000, watchdog = 0, 
siimage_mmio_ide_dma_test_irq
  p9 >
hda: ATAPI 48X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
hdc: ATAPI 40X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
ide-floppy driver 0.99.newide
hdd: No disk in drive
hdd: 98304kB, 32/64/96 CHS, 4096 kBps, 512 sector size, 2941 rpm
ohci1394: $Rev: 1045 $ Ben Collins <bcollins@debian.org>
PCI: Setting latency timer of device 0000:00:0d.0 to 64
ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[11]  MMIO=[cc084000-cc0847ff]  Max 
Packet=[2048]
ohci1394_0: SelfID received outside of bus reset sequence
video1394: Installed video1394 module
raw1394: /dev/raw1394 device initialized
Console: switching to colour frame buffer device 153x58
ehci_hcd 0000:00:02.2: EHCI Host Controller
PCI: Setting latency timer of device 0000:00:02.2 to 64
ehci_hcd 0000:00:02.2: irq 10, pci mem f984c000
ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
PCI: cache line size of 64 is not supported by device 0000:00:02.2
ehci_hcd 0000:00:02.2: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:00:02.0: OHCI Host Controller
PCI: Setting latency timer of device 0000:00:02.0 to 64
ohci_hcd 0000:00:02.0: irq 11, pci mem f984e000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ohci_hcd 0000:00:02.1: OHCI Host Controller
PCI: Setting latency timer of device 0000:00:02.1 to 64
ohci_hcd 0000:00:02.1: irq 5, pci mem f9850000
ohci_hcd 0000:00:02.1: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 3 ports detected
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface 
driver v2.1
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/core/usb.c: registered new driver usbscanner
drivers/usb/image/scanner.c: 0.4.15:USB Scanner Driver
mice: PS/2 mouse device common for all mice
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
I2O Core - (C) Copyright 1999 Red Hat Software
I2O: Event thread created as pid 15
i2o: Checking for PCI I2O controllers...
I2O configuration manager v 0.04.
   (C) Copyright 1999 Red Hat Software
i2c /dev entries driver
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x5000
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x5100
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000000508df0fbe3]
hub 2-0:1.0: new USB device on port 1, assigned address 2
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 
19:16:36 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
PCI: Setting latency timer of device 0000:00:06.0 to 64
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if 0 
alt 1 proto 2 vid 0x03F0 pid 0x1004
intel8x0: clocking to 47482
ALSA device list:
   #0: NVidia nForce2 at 0xcc081000, irq 5
NET: Registered protocol family 2
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
ACPI: (supports S0 S3 S4 S5)
hde: sata_error = 0x00000000, watchdog = 0, siimage_mmio_ide_dma_test_irq
hde: sata_error = 0x00000000, watchdog = 0, siimage_mmio_ide_dma_test_irq
hde: sata_error = 0x00000000, watchdog = 0, siimage_mmio_ide_dma_test_irq
hde: sata_error = 0x00000000, watchdog = 0, siimage_mmio_ide_dma_test_irq
UDF-fs DEBUG fs/udf/lowlevel.c:65:udf_get_last_session: 
CDROMMULTISESSION not supported: rc=-22
UDF-fs DEBUG fs/udf/super.c:1550:udf_fill_super: Multi-session=0
UDF-fs DEBUG fs/udf/super.c:538:udf_vrs: Starting at sector 16 (2048 
byte sectors)
UDF-fs: No VRS found
XFS mounting filesystem hde6
Ending clean XFS mount for filesystem: hde6
VFS: Mounted root (xfs filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 160k freed
NTFS volume version 3.1.
NTFS volume version 3.1.

Prakash

