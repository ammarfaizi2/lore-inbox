Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbUBQMv7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 07:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264507AbUBQMv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 07:51:59 -0500
Received: from ns.suse.de ([195.135.220.2]:39311 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261881AbUBQMvP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 07:51:15 -0500
Date: Tue, 17 Feb 2004 13:51:10 +0100
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@lists.linuxppc.org
Cc: linux-kernel@vger.kernel.org
Subject: unkillable processes stuck in recheck()
Message-ID: <20040217125110.GA27420@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I see (seldom) processes stuck in recheck() on ppc32. This happend also
during the 2.6.0-test* time frame. Current kernel is plain 2.6.3-rc3 on
a 450Mhz G4.

Any idea how can this happen? I dont have a testcase to reproduce.

The first time (some months ago) was on a PReP system with a minimal
config, no preempt kernel.

...
conftest      R 1000077C     0 26105  26104                     (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c0008318>] recheck+0x0/0x20
....


Total memory = 1792MB; using 4096kB for hash table (at c0800000)
Linux version 2.6.3-rc3-olh (olaf@nectarine) (gcc version 3.2.3 (SuSE Linux)) #2 Sun Feb 15 19:03:34 CET 2004
Found UniNorth memory controller & host bridge, revision: 3
Mapped at 0xfdfc0000
Found a Keylargo mac-io controller, rev: 2, mapped at 0xfdf40000
PowerMac motherboard: PowerMac G4 AGP Graphics
Found UniNorth PCI host bridge at 0xf0000000. Firmware bus number: 0->0
Found UniNorth PCI host bridge at 0xf2000000. Firmware bus number: 0->1
Found UniNorth PCI host bridge at 0xf4000000. Firmware bus number: 0->0
via-pmu: Server Mode is disabled
PMU driver 2 initialized for Core99, firmware: 0c
nvram: Checking bank 0...
nvram: gen0=46, gen1=47
nvram: Active bank is: 1
nvram: OF partition at 0x210
nvram: XP partition at 0x1220
nvram: NR partition at 0x1320
On node 0 totalpages: 458752
  DMA zone: 196608 pages, LIFO batch:16
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 262144 pages, LIFO batch:16
Built 1 zonelists
Kernel command line: root=/dev/hda11 video=aty128fb:vmode:17 
PowerMac using OpenPIC irq controller at 0x80040000
OpenPIC Version 1.2 (4 CPUs and 64 IRQ sources) at fc6f1000
OpenPIC timer frequency is 2147.483648 MHz
PID hash table entries: 4096 (order 12: 32768 bytes)
GMT Delta read from XPRAM: 120 minutes, DST: on
via_calibrate_decr: ticks per jiffy = 24907 (1494453 ticks)
Console: colour dummy device 80x25
Memory: 1808000k available (1604k kernel code, 1328k data, 124k init, 1048576k highmem)
AGP special page: 0xeffff000
Calibrating delay loop... 894.97 BogoMIPS
Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes)
Inode-cache hash table entries: 131072 (order: 7, 524288 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs... it is
Freeing initrd memory: 656k freed
POSIX conformance testing by UNIFIX
do_initcalls
init_elf_binfmt
NET: Registered protocol family 16
PCI: Probing PCI hardware
 ... the first call_usermodehelper: pci_bus
Fixing up IO bus PCI Bus #02
PCI: Enabling device 0001:02:03.0 (0014 -> 0017)
Registering openpic with sysfs...
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Enabling device 0000:00:10.0 (0086 -> 0087)
aty128fb: Rage128 Pro PF (AGP) [chip rev 0x1] 16M 128-bit SDR SGRAM (1:1)
fb0: ATY Rage128 frame buffer device on Rage128 Pro PF (AGP)
ikconfig 0.7 with /proc/config*
highmem bounce pool size: 64 pages
Initializing Cryptographic API
Console: switching to colour frame buffer device 128x48
pty: 256 Unix98 ptys configured
Generic RTC Driver v1.07
Macintosh non-volatile memory driver v1.1
RAMDISK driver initialized: 16 RAM disks of 123456K size 1024 blocksize
sungem.c:v0.98 8/24/03 David S. Miller (davem@redhat.com)
eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:0a:27:e2:f3:3e 
PHY ID: 406212, addr: 0
eth0: Found BCM5201 PHY
MacIO PCI driver attached to Keylargo chipset
preparing mdev @effa5000, ofdev @effa5008, dev @effa5018, kobj @effa503c
preparing mdev @c2ab8c00, ofdev @c2ab8c08, dev @c2ab8c18, kobj @c2ab8c3c
preparing mdev @c2ab8800, ofdev @c2ab8808, dev @c2ab8818, kobj @c2ab883c
preparing mdev @c2ab8400, ofdev @c2ab8408, dev @c2ab8418, kobj @c2ab843c
preparing mdev @c2ab8000, ofdev @c2ab8008, dev @c2ab8018, kobj @c2ab803c
preparing mdev @c2ab2c00, ofdev @c2ab2c08, dev @c2ab2c18, kobj @c2ab2c3c
preparing mdev @c2ab2800, ofdev @c2ab2808, dev @c2ab2818, kobj @c2ab283c
preparing mdev @c2ab2400, ofdev @c2ab2408, dev @c2ab2418, kobj @c2ab243c
preparing mdev @c2ab2000, ofdev @c2ab2008, dev @c2ab2018, kobj @c2ab203c
preparing mdev @c2aadc00, ofdev @c2aadc08, dev @c2aadc18, kobj @c2aadc3c
preparing mdev @c2aad800, ofdev @c2aad808, dev @c2aad818, kobj @c2aad83c
preparing mdev @c2aad400, ofdev @c2aad408, dev @c2aad418, kobj @c2aad43c
preparing mdev @c2aad000, ofdev @c2aad008, dev @c2aad018, kobj @c2aad03c
input: Macintosh mouse button emulation
apm_emu: APM Emulation 0.5 initialized.
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
adb: starting probe task...
adb: finished probe task...
ide0: Found Apple KeyLargo ATA-4 controller, bus ID 2, irq 19
Probing IDE interface ide0...
hda: WDC WD273BA, ATA DISK drive
hdb: WDC WD273BA, ATA DISK drive
ide_pmac: Set UDMA timing for mode 4, reg: 0x0c50038c
hda: Enabling Ultra DMA 4
ide_pmac: Set UDMA timing for mode 4, reg: 0x0c50038c
hdb: Enabling Ultra DMA 4
Using anticipatory io scheduler
ide0 at 0xf2207000-0xf2207007,0xf2207160 on irq 19
ide1: Found Apple KeyLargo ATA-3 controller, bus ID 0, irq 20
Probing IDE interface ide1...
hdc: MATSHITAPD-2 LF-D110, ATAPI CD/DVD-ROM drive
hdd: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
hdc: MDMA, cycleTime: 120, accessTime: 90, recTime: 30
hdc: Set MDMA timing for mode 2, reg: 0x00011d26
hdc: Enabling MultiWord DMA 2
ide1 at 0xf220c000-0xf220c007,0xf220c160 on irq 20
ide2: Found Apple KeyLargo ATA-3 controller, bus ID 1, irq 21
Probing IDE interface ide2...
ide2: Bus empty, interface released.
hda: max request size: 128KiB
hda: 53464320 sectors (27373 MB) w/1961KiB Cache, CHS=53040/16/63, UDMA(66)
 hda: [mac] hda1 hda2 hda3 hda4 hda5 hda6 hda7 hda8 hda9 hda10 hda11 hda12
hdb: max request size: 128KiB
hdb: 53464320 sectors (27373 MB) w/1961KiB Cache, CHS=53040/16/63, UDMA(66)
 hdb: [mac] hdb1 hdb2 hdb3 hdb4 hdb5 hdb6 hdb7 hdb8 hdb9 hdb10 hdb11
Console: switching to colour frame buffer device 128x48
ohci_hcd: 2004 Feb 02 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
PCI: Enabling device 0001:02:08.0 (0000 -> 0002)
ohci_hcd 0001:02:08.0: OHCI Host Controller
ohci_hcd 0001:02:08.0: irq 27, pci mem f2211000
ohci_hcd 0001:02:08.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PCI: Enabling device 0001:02:09.0 (0000 -> 0002)
ohci_hcd 0001:02:09.0: OHCI Host Controller
ohci_hcd 0001:02:09.0: irq 28, pci mem f2213000
ohci_hcd 0001:02:09.0: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
NET: Registered protocol family 2
IP: routing cache hash table of 16384 buckets, 128Kbytes
TCP: Hash tables configured (established 524288 bind 65536)
NET: Registered protocol family 1
NET: Registered protocol family 17
NET: Registered protocol family 15
Freeing unused kernel memory: 124k init 4k chrp 8k prep
SCSI subsystem initialized
st: Version 20040122, fixed bufsize 32768, s/g segs 256
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
        <Adaptec 2902/04/10/15/20C/30C SCSI adapter>
        aic7850: Ultra Single Channel A, SCSI Id=7, 3/253 SCBs

usb 1-1: new full speed USB device using address 2
usb 2-1: new full speed USB device using address 2
hub 2-1:1.0: USB hub found
hub 2-1:1.0: 3 ports detected
usb 2-1.1: new low speed USB device using address 3
input: USB HID v1.00 Keyboard [Alps Electric Apple USB Keyboard] on usb-0001:02:09.0-1.1
usb 2-1.2: new low speed USB device using address 4
input: USB HID v1.00 Mouse [Mitsumi Apple USB Mouse] on usb-0001:02:09.0-1.2
(scsi0:A:0): 20.000MB/s transfers (20.000MHz, offset 15)
  Vendor: IBM       Model: DNES-309170       Rev: SA30
  Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 32
SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
SCSI device sda: drive cache: write back
 sda: [mac] sda1 sda2 sda3 sda4 sda5 sda6 sda7 sda8
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
ide-scsi is deprecated for cd burning! Use ide-cd and give dev=/dev/hdX as device
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: MATSHITA  Model: PD-2 LF-D110      Rev: A105
  Type:   CD-ROM                             ANSI SCSI revision: 02
sr0: scsi3-mmc drive: 0x/0x dvd-ram cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
Attached scsi CD-ROM sr0 at scsi1, channel 0, id 0, lun 0
Attached scsi generic sg1 at scsi1, channel 0, id 0, lun 0,  type 5
scsi2 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: IOMEGA    Model: ZIP 100           Rev: 14.A
  Type:   Direct-Access                      ANSI SCSI revision: 00
Attached scsi removable disk sdb at scsi2, channel 0, id 0, lun 0
Attached scsi generic sg2 at scsi2, channel 0, id 0, lun 0,  type 0
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected Apple UniNorth chipset
agpgart: Maximum main memory to use for agp memory: 1675M
agpgart: configuring for size idx: 4
agpgart: AGP aperture is 16M @ 0x0
ohci1394: $Rev: 1097 $ Ben Collins <bcollins@debian.org>
PCI: Enabling device 0001:02:0a.0 (0010 -> 0012)
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[63]  MMIO=[80080000-800807ff]  Max Packet=[2048]
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000a27fffee2f33e]
drivers/usb/net/pegasus.c: v0.5.12 (2003/06/06):Pegasus/Pegasus II USB Ethernet driver
eth1: D-Link DSB-650TX
drivers/usb/core/usb.c: registered new driver pegasus
PHY ID: 406212, addr: 0
process `syslogd' is using obsolete setsockopt SO_BSDCOMPAT
eth0: Link is up at 100 Mbps, full-duplex.
eth0: Pause is disabled
process `named' is using obsolete setsockopt SO_BSDCOMPAT
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
nfs warning: mount version older than kernel
process `host' is using obsolete setsockopt SO_BSDCOMPAT
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
nfs: server Hilbert3 not responding, still trying
nfs: server Hilbert3 OK
nfs: server Hilbert3 not responding, still trying
nfs: server Hilbert3 OK
nfs: server Hilbert3 not responding, still trying
nfs: server Hilbert3 OK
nfs: server Hilbert3 not responding, still trying
nfs: server Hilbert3 OK
nfs: server Hilbert3 not responding, still trying
nfs: server Hilbert3 OK
nfs warning: mount version older than kernel
nfs: server Hilbert3 not responding, still trying
nfs: server Hilbert3 OK
nfs: server Hilbert3 not responding, still trying
nfs: server Hilbert3 OK
iocb has no cancel operation
iocb has no cancel operation
iocb has no cancel operation
iocb has no cancel operation
iocb has no cancel operation
iocb has no cancel operation
iocb has no cancel operation
iocb has no cancel operation
iocb has no cancel operation
iocb has no cancel operation
iocb has no cancel operation
iocb has no cancel operation
iocb has no cancel operation
iocb has no cancel operation
iocb has no cancel operation
iocb has no cancel operation
iocb has no cancel operation
iocb has no cancel operation
iocb has no cancel operation
iocb has no cancel operation
iocb has no cancel operation
iocb has no cancel operation
nfs: server Hilbert2 not responding, still trying
nfs: server Hilbert2 OK
nfs: server Hilbert2 not responding, still trying
nfs: server Hilbert2 OK
nfs: server Hilbert2 not responding, still trying
nfs: server Hilbert2 OK
nfs: server Hilbert3 not responding, still trying
nfs: server Hilbert3 OK
nfs: server Hilbert3 not responding, still trying
nfs: server Hilbert3 OK
nfs: server Hilbert3 not responding, still trying
nfs: server Hilbert3 OK
nfs: server Hilbert2 not responding, still trying
nfs: server Hilbert2 not responding, still trying
nfs: server Hilbert2 OK
nfs: server Hilbert2 OK
nfs: server Hilbert2 not responding, still trying
nfs: server Hilbert2 OK
nfs: server Hilbert2 not responding, still trying
nfs: server Hilbert2 OK
nfs: server Hilbert2 not responding, still trying
nfs: server Hilbert2 OK
nfs warning: mount version older than kernel
nfs: server Hilbert3 not responding, still trying
nfs: server Hilbert3 OK
nfs: server Hilbert2 not responding, still trying
nfs: server Hilbert2 OK
nfs: server Hilbert3 not responding, still trying
nfs: server Hilbert3 OK
nfs: server Hilbert2 not responding, still trying
nfs: server Hilbert2 not responding, still trying
nfs: server Hilbert2 OK
nfs: server Hilbert2 OK
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
usb 2-1.3: new full speed USB device using address 5
drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
drivers/usb/core/usb.c: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
drivers/usb/serial/usb-serial.c: USB Serial support registered for Handspring Visor / Palm OS
drivers/usb/serial/usb-serial.c: USB Serial support registered for Sony Clie 3.5
usb 2-1.3: palm_os_4_probe - error -32 getting connection info
visor 2-1.3:1.0: Handspring Visor / Palm OS converter detected
usb 2-1.3: Handspring Visor / Palm OS converter now attached to ttyUSB0 (or usb/tts/0 for devfs)
usb 2-1.3: Handspring Visor / Palm OS converter now attached to ttyUSB1 (or usb/tts/1 for devfs)
drivers/usb/core/usb.c: registered new driver visor
drivers/usb/serial/visor.c: USB HandSpring Visor / Palm OS driver v2.1
drivers/usb/net/pegasus.c: intr status -84
usb 2-1.3: USB disconnect, address 5
visor ttyUSB0: Handspring Visor / Palm OS converter now disconnected from ttyUSB0
visor ttyUSB1: Handspring Visor / Palm OS converter now disconnected from ttyUSB1
visor 2-1.3:1.0: device disconnected
usb 2-1.3: new full speed USB device using address 6
usb 2-1.3: palm_os_4_probe - error -32 getting connection info
usbserial 2-1.3:1.0: Handspring Visor / Palm OS converter detected
usb 2-1.3: Handspring Visor / Palm OS converter now attached to ttyUSB0 (or usb/tts/0 for devfs)
usb 2-1.3: Handspring Visor / Palm OS converter now attached to ttyUSB1 (or usb/tts/1 for devfs)
usb 2-1.3: USB disconnect, address 6
visor ttyUSB0: Handspring Visor / Palm OS converter now disconnected from ttyUSB0
visor ttyUSB1: Handspring Visor / Palm OS converter now disconnected from ttyUSB1
usbserial 2-1.3:1.0: device disconnected
usb 2-1.3: new full speed USB device using address 7
usb 2-1.3: palm_os_4_probe - error -32 getting connection info
usbserial 2-1.3:1.0: Handspring Visor / Palm OS converter detected
usb 2-1.3: Handspring Visor / Palm OS converter now attached to ttyUSB0 (or usb/tts/0 for devfs)
usb 2-1.3: Handspring Visor / Palm OS converter now attached to ttyUSB1 (or usb/tts/1 for devfs)
usb 2-1.3: USB disconnect, address 7
visor ttyUSB0: Handspring Visor / Palm OS converter now disconnected from ttyUSB0
visor ttyUSB1: Handspring Visor / Palm OS converter now disconnected from ttyUSB1
usbserial 2-1.3:1.0: device disconnected
nfs: server Hilbert2 not responding, still trying
nfs: server Hilbert2 OK
nfs: server Hilbert2 not responding, still trying
nfs: server Hilbert2 OK
nfs warning: mount version older than kernel
nfs: server Hilbert2 not responding, still trying
nfs: server Hilbert2 OK
nfs: server Hilbert2 not responding, still trying
nfs: server Hilbert2 OK
nfs: server Hilbert not responding, still trying
nfs: server Hilbert OK
nfs: server Hilbert3 not responding, still trying
nfs: server Hilbert3 OK
nfs: server Hilbert2 not responding, still trying
nfs: server Hilbert2 OK
nfs: server Hilbert2 not responding, still trying
nfs: server Hilbert2 OK
nfs: server Hilbert2 not responding, still trying
nfs: server Hilbert2 OK
nfs: server Hilbert3 not responding, still trying
nfs: server Hilbert3 OK
nfs: server Hilbert3 not responding, still trying
nfs: server Hilbert3 OK
nfs: server Hilbert2 not responding, still trying
nfs: server Hilbert2 not responding, still trying
nfs: server Hilbert2 OK
nfs: server Hilbert2 OK
nfs warning: mount version older than kernel
nfs: server Hilbert3 not responding, still trying
nfs: server Hilbert3 OK
nfs: server Hilbert3 not responding, still trying
nfs: server Hilbert3 OK
nfs: server Hilbert2 not responding, still trying
nfs: server Hilbert2 OK
nfs: server Hilbert3 not responding, still trying
nfs: server Hilbert3 OK
nfs: server Hilbert3 not responding, still trying
nfs: server Hilbert3 OK
nfs: server Hilbert3 not responding, still trying
nfs: server Hilbert3 OK
nfs: server Hilbert3 not responding, still trying
nfs: server Hilbert3 OK
nfs: server Hilbert3 not responding, still trying
nfs: server Hilbert3 OK
nfs: server Hilbert2 not responding, still trying
nfs: server Hilbert2 not responding, still trying
nfs: server Hilbert2 not responding, still trying
nfs: server Hilbert2 OK
nfs: server Hilbert2 OK
nfs: server Hilbert2 OK
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
nfs: server Hilbert2 not responding, still trying
nfs: server Hilbert2 OK
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
nfs: server Hilbert3 not responding, still trying
nfs: server Hilbert3 OK
nfs: server Hilbert3 not responding, still trying
nfs: server Hilbert3 OK
nfs: server Hilbert not responding, still trying
nfs: server Hilbert OK
nfs: server Hilbert3 not responding, still trying
nfs: server Hilbert3 OK
nfs: server Hilbert2 not responding, still trying
nfs: server Hilbert2 OK
nfs: server Hilbert2 not responding, still trying
nfs: server Hilbert2 not responding, still trying
nfs: server Hilbert2 not responding, still trying
nfs: server Hilbert2 OK
nfs: server Hilbert2 OK
nfs: server Hilbert2 OK
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
nfs warning: mount version older than kernel
nfs: server Hilbert2 not responding, still trying
nfs: server Hilbert2 OK
nfs: server Hilbert2 not responding, still trying
nfs: server Hilbert2 OK
nfs: server Hilbert2 not responding, still trying
nfs: server Hilbert2 OK
nfs warning: mount version older than kernel
nfs: server Hilbert3 not responding, still trying
nfs: server Hilbert3 OK
nfs: server Hilbert3 not responding, still trying
nfs: server Hilbert3 OK
nfs: server Hilbert3 not responding, still trying
nfs: server Hilbert3 OK
nfs: server Hilbert3 not responding, still trying
nfs: server Hilbert3 OK
nfs: server Hilbert3 not responding, still trying
nfs: server Hilbert3 OK
nfs: server Hilbert3 not responding, still trying
nfs: server Hilbert3 OK
nfs: server Hilbert3 not responding, still trying
nfs: server Hilbert3 OK
nfs warning: mount version older than kernel
nfs: server Hilbert2 not responding, still trying
nfs: server Hilbert2 OK
nfs: server Hilbert3 not responding, still trying
nfs: server Hilbert3 OK
SysRq : Show State

                         free                        sibling
  task             PC    stack   pid father child younger older
init          S 10018B6C     0     1      0     2               (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255a0>] schedule_timeout+0x7c/0xcc
 [<c006d618>] do_select+0x128/0x280
 [<c006da50>] sys_select+0x298/0x430
 [<c000dc2c>] ppc_select+0xa8/0xac
 [<c0007c7c>] ret_from_syscall+0x0/0x44
ksoftirqd/0   S 00000000     0     2      1             3       (L-TLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c0020d0c>] ksoftirqd+0x78/0xbc
 [<c000ae50>] kernel_thread+0x44/0x60
events/0      S 00000000     0     3      1            20     2 (L-TLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c002cf38>] worker_thread+0x1cc/0x1fc
 [<c000ae50>] kernel_thread+0x44/0x60
kblockd/0     S 00000000     0    20      1            21     3 (L-TLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c002cf38>] worker_thread+0x1cc/0x1fc
 [<c000ae50>] kernel_thread+0x44/0x60
khubd         S 00000000     0    21      1            34    20 (L-TLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c010de74>] hub_thread+0xc8/0xf8
 [<c000ae50>] kernel_thread+0x44/0x60
kswapd0       S 00000000     0    34      1            35    21 (L-TLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00429bc>] kswapd+0xa8/0xd0
 [<c000ae50>] kernel_thread+0x44/0x60
aio/0         S 00000000    16    35      1           177    34 (L-TLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c002cf38>] worker_thread+0x1cc/0x1fc
 [<c000ae50>] kernel_thread+0x44/0x60
kseriod       S 00000000     0   177      1           206    35 (L-TLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c0124bb0>] serio_thread+0xc8/0x104
 [<c000ae50>] kernel_thread+0x44/0x60
scsi_eh_0     S 00000000     0   206      1           207   177 (L-TLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c000d594>] __down_interruptible+0xd8/0x120
 [<f226035c>] scsi_error_handler+0x190/0x194 [scsi_mod]
 [<c000ae50>] kernel_thread+0x44/0x60
ahc_dv_0      S 00000000    24   207      1           233   206 (L-TLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c000d594>] __down_interruptible+0xd8/0x120
 [<f22f5c78>] ahc_linux_dv_thread+0x218/0x22c [aic7xxx]
 [<c000ae50>] kernel_thread+0x44/0x60
scsi_eh_1     S 00000000  6280   233      1           239   207 (L-TLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c000d594>] __down_interruptible+0xd8/0x120
 [<f226035c>] scsi_error_handler+0x190/0x194 [scsi_mod]
 [<c000ae50>] kernel_thread+0x44/0x60
scsi_eh_2     S 00000000     0   239      1          3012   233 (L-TLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c000d594>] __down_interruptible+0xd8/0x120
 [<f226035c>] scsi_error_handler+0x190/0x194 [scsi_mod]
 [<c000ae50>] kernel_thread+0x44/0x60
knodemgrd_0   S 00000000  4056  3012      1          3530   239 (L-TLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c000d594>] __down_interruptible+0xd8/0x120
 [<f23d9b68>] nodemgr_host_thread+0x1c0/0x1c4 [ieee1394]
 [<c000ae50>] kernel_thread+0x44/0x60
syslogd       S 0FF7E8D0     0  3527      1          3547  3530 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c006d618>] do_select+0x128/0x280
 [<c006da50>] sys_select+0x298/0x430
 [<c000dc2c>] ppc_select+0xa8/0xac
 [<c0007c7c>] ret_from_syscall+0x0/0x44
klogd         R 0FF77404     0  3530      1          3527  3012 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c001c5b0>] do_syslog+0x22c/0x49c
 [<c008ab44>] kmsg_read+0x14/0x24
 [<c0058454>] vfs_read+0xdc/0x128
 [<c00586c0>] sys_read+0x40/0x74
 [<c0007c7c>] ret_from_syscall+0x0/0x44
resmgrd       S 0FF58868    56  3547      1          3561  3527 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c006dd84>] do_poll+0xbc/0xf0
 [<c006df30>] sys_poll+0x178/0x288
 [<c0007c7c>] ret_from_syscall+0x0/0x44
portmap       S 0FF5A868     0  3561      1          3624  3547 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c006dd84>] do_poll+0xbc/0xf0
 [<c006df30>] sys_poll+0x178/0x288
 [<c0007c7c>] ret_from_syscall+0x0/0x44
named         S 0FB233A4  5640  3624      1  3625    3632  3561 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c000bb30>] sys_rt_sigsuspend+0xe4/0x134
 [<c0007c7c>] ret_from_syscall+0x0/0x44
named         S 0FBC98CC     0  3625   3624  3627               (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255a0>] schedule_timeout+0x7c/0xcc
 [<c006dd84>] do_poll+0xbc/0xf0
 [<c006df30>] sys_poll+0x178/0x288
 [<c0007c7c>] ret_from_syscall+0x0/0x44
named         S 0FB233A4    88  3627   3625          3628       (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c000bb30>] sys_rt_sigsuspend+0xe4/0x134
 [<c0007c7c>] ret_from_syscall+0x0/0x44
named         S 0FC59610     0  3628   3625          3629  3627 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255a0>] schedule_timeout+0x7c/0xcc
 [<c0025858>] sys_nanosleep+0x118/0x27c
 [<c0007c7c>] ret_from_syscall+0x0/0x44
named         S 0FBCB91C     0  3629   3625                3628 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c006d618>] do_select+0x128/0x280
 [<c006da50>] sys_select+0x298/0x430
 [<c000dc2c>] ppc_select+0xa8/0xac
 [<c0007c7c>] ret_from_syscall+0x0/0x44
rpc.rstatd    S 0FF7C868     0  3632      1          3656  3624 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c006dd84>] do_poll+0xbc/0xf0
 [<c006df30>] sys_poll+0x178/0x288
 [<c0007c7c>] ret_from_syscall+0x0/0x44
sshd          S 0FC448D0  4060  3656      1  5787    3671  3632 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c006d618>] do_select+0x128/0x280
 [<c006da50>] sys_select+0x298/0x430
 [<c000dc2c>] ppc_select+0xa8/0xac
 [<c0007c7c>] ret_from_syscall+0x0/0x44
ypbind        S 0FED58CC    88  3671      1  3672    3789  3656 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c006dd84>] do_poll+0xbc/0xf0
 [<c006df30>] sys_poll+0x178/0x288
 [<c0007c7c>] ret_from_syscall+0x0/0x44
ypbind        S 0FED58CC     0  3672   3671  3673               (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255a0>] schedule_timeout+0x7c/0xcc
 [<c006dd84>] do_poll+0xbc/0xf0
 [<c006df30>] sys_poll+0x178/0x288
 [<c0007c7c>] ret_from_syscall+0x0/0x44
ypbind        S 0FE2F3A4     0  3673   3672          3674       (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c000bb30>] sys_rt_sigsuspend+0xe4/0x134
 [<c0007c7c>] ret_from_syscall+0x0/0x44
ypbind        S 0FEAD048     0  3674   3672                3673 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255a0>] schedule_timeout+0x7c/0xcc
 [<c0025858>] sys_nanosleep+0x118/0x27c
 [<c0007c7c>] ret_from_syscall+0x0/0x44
automount     S 0FF54404     0  3789      1          3791  3671 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00661f8>] pipe_wait+0x78/0xc4
 [<c0066450>] pipe_readv+0x20c/0x340
 [<c00665ac>] pipe_read+0x28/0x38
 [<c0058454>] vfs_read+0xdc/0x128
 [<c00586c0>] sys_read+0x40/0x74
 [<c0007c7c>] ret_from_syscall+0x0/0x44
automount     S 0FF54404     0  3791      1          3793  3789 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00661f8>] pipe_wait+0x78/0xc4
 [<c0066450>] pipe_readv+0x20c/0x340
 [<c00665ac>] pipe_read+0x28/0x38
 [<c0058454>] vfs_read+0xdc/0x128
 [<c00586c0>] sys_read+0x40/0x74
 [<c0007c7c>] ret_from_syscall+0x0/0x44
automount     S 0FF54404  4120  3793      1          3848  3791 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00661f8>] pipe_wait+0x78/0xc4
 [<c0066450>] pipe_readv+0x20c/0x340
 [<c00665ac>] pipe_read+0x28/0x38
 [<c0058454>] vfs_read+0xdc/0x128
 [<c00586c0>] sys_read+0x40/0x74
 [<c0007c7c>] ret_from_syscall+0x0/0x44
cupsd         S 0FCE48D0  4056  3819      1          3943  3895 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255a0>] schedule_timeout+0x7c/0xcc
 [<c006d618>] do_select+0x128/0x280
 [<c006da50>] sys_select+0x298/0x430
 [<c000dc2c>] ppc_select+0xa8/0xac
 [<c0007c7c>] ret_from_syscall+0x0/0x44
papd          S 0FCD08D0     0  3848      1          3857  3793 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c006d618>] do_select+0x128/0x280
 [<c006da50>] sys_select+0x298/0x430
 [<c000dc2c>] ppc_select+0xa8/0xac
 [<c0007c7c>] ret_from_syscall+0x0/0x44
afpd          S 0FCD08D0   120  3857      1          3864  3848 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c006d618>] do_select+0x128/0x280
 [<c006da50>] sys_select+0x298/0x430
 [<c000dc2c>] ppc_select+0xa8/0xac
 [<c0007c7c>] ret_from_syscall+0x0/0x44
nfsd          S 00000000     0  3864      1          3865  3857 (L-TLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255a0>] schedule_timeout+0x7c/0xcc
 [<f23a86f0>] svc_recv+0x41c/0x52c [sunrpc]
 [<f246a35c>] nfsd+0xe8/0x364 [nfsd]
 [<c000ae50>] kernel_thread+0x44/0x60
nfsd          S 00000000     0  3865      1          3866  3864 (L-TLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255a0>] schedule_timeout+0x7c/0xcc
 [<f23a86f0>] svc_recv+0x41c/0x52c [sunrpc]
 [<f246a35c>] nfsd+0xe8/0x364 [nfsd]
 [<c000ae50>] kernel_thread+0x44/0x60
nfsd          S 00000000     0  3866      1          3868  3865 (L-TLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255a0>] schedule_timeout+0x7c/0xcc
 [<f23a86f0>] svc_recv+0x41c/0x52c [sunrpc]
 [<f246a35c>] nfsd+0xe8/0x364 [nfsd]
 [<c000ae50>] kernel_thread+0x44/0x60
lockd         S 00000000     0  3868      1          3867  3866 (L-TLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<f23a86f0>] svc_recv+0x41c/0x52c [sunrpc]
 [<f2372264>] lockd+0x154/0x284 [lockd]
 [<c000ae50>] kernel_thread+0x44/0x60
nfsd          S 00000000     0  3867      1          3869  3868 (L-TLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255a0>] schedule_timeout+0x7c/0xcc
 [<f23a86f0>] svc_recv+0x41c/0x52c [sunrpc]
 [<f246a35c>] nfsd+0xe8/0x364 [nfsd]
 [<c000ae50>] kernel_thread+0x44/0x60
rpciod        S 00000000     0  3869      1          3872  3867 (L-TLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<f23a3d38>] rpciod+0x210/0x248 [sunrpc]
 [<c000ae50>] kernel_thread+0x44/0x60
rpc.mountd    S 0FF46868     0  3872      1          3895  3869 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c006dd84>] do_poll+0xbc/0xf0
 [<c006df30>] sys_poll+0x178/0x288
 [<c0007c7c>] ret_from_syscall+0x0/0x44
ntpd          S 0FEC48D0     0  3895      1          3819  3872 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c006d618>] do_select+0x128/0x280
 [<c006da50>] sys_select+0x298/0x430
 [<c000dc2c>] ppc_select+0xa8/0xac
 [<c0007c7c>] ret_from_syscall+0x0/0x44
autobuild     S 0FE45AD0     0  3923      1 31787    3963  3943 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c001f4b0>] sys_wait4+0x19c/0x218
 [<c0007c7c>] ret_from_syscall+0x0/0x44
abuild-bs     S 0FDF4014  4120  3943      1          3923  3819 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255a0>] schedule_timeout+0x7c/0xcc
 [<c0025858>] sys_nanosleep+0x118/0x27c
 [<c0007c7c>] ret_from_syscall+0x0/0x44
kdm           S 0FDE18D0     0  3963      1  3980    4002  3923 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c006d618>] do_select+0x128/0x280
 [<c006da50>] sys_select+0x298/0x430
 [<c000dc2c>] ppc_select+0xa8/0xac
 [<c0007c7c>] ret_from_syscall+0x0/0x44
X             R 0FE958D0     0  3980   3963          3985       (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255a0>] schedule_timeout+0x7c/0xcc
 [<c006d618>] do_select+0x128/0x280
 [<c006da50>] sys_select+0x298/0x430
 [<c000dc2c>] ppc_select+0xa8/0xac
 [<c0007c7c>] ret_from_syscall+0x0/0x44
kdm           S 0FDB6AD0     0  3985   3963  4127          3980 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c001f4b0>] sys_wait4+0x19c/0x218
 [<c0007c7c>] ret_from_syscall+0x0/0x44
httpd2-prefor S 0FBE68D0     0  4002      1  4003    4042  3963 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255a0>] schedule_timeout+0x7c/0xcc
 [<c006d618>] do_select+0x128/0x280
 [<c006da50>] sys_select+0x298/0x430
 [<c000dc2c>] ppc_select+0xa8/0xac
 [<c0007c7c>] ret_from_syscall+0x0/0x44
httpd2-prefor S 0FC73ECC     0  4003   4002          4004       (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c0154324>] wait_for_connect+0x100/0x108
 [<c01543b4>] tcp_accept+0x88/0x108
 [<c017468c>] inet_accept+0x38/0xd4
 [<c012d524>] sys_accept+0xb4/0x15c
 [<c012e060>] sys_socketcall+0xe4/0x1d4
 [<c0007c7c>] ret_from_syscall+0x0/0x44
httpd2-prefor S 0FC73ECC     0  4004   4002          4005  4003 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c0154324>] wait_for_connect+0x100/0x108
 [<c01543b4>] tcp_accept+0x88/0x108
 [<c017468c>] inet_accept+0x38/0xd4
 [<c012d524>] sys_accept+0xb4/0x15c
 [<c012e060>] sys_socketcall+0xe4/0x1d4
 [<c0007c7c>] ret_from_syscall+0x0/0x44
httpd2-prefor S 0FC73ECC     0  4005   4002          4006  4004 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c0154324>] wait_for_connect+0x100/0x108
 [<c01543b4>] tcp_accept+0x88/0x108
 [<c017468c>] inet_accept+0x38/0xd4
 [<c012d524>] sys_accept+0xb4/0x15c
 [<c012e060>] sys_socketcall+0xe4/0x1d4
 [<c0007c7c>] ret_from_syscall+0x0/0x44
httpd2-prefor S 0FC73ECC     0  4006   4002          4007  4005 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c0154324>] wait_for_connect+0x100/0x108
 [<c01543b4>] tcp_accept+0x88/0x108
 [<c017468c>] inet_accept+0x38/0xd4
 [<c012d524>] sys_accept+0xb4/0x15c
 [<c012e060>] sys_socketcall+0xe4/0x1d4
 [<c0007c7c>] ret_from_syscall+0x0/0x44
httpd2-prefor S 0FC73ECC     0  4007   4002                4006 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c0154324>] wait_for_connect+0x100/0x108
 [<c01543b4>] tcp_accept+0x88/0x108
 [<c017468c>] inet_accept+0x38/0xd4
 [<c012d524>] sys_accept+0xb4/0x15c
 [<c012e060>] sys_socketcall+0xe4/0x1d4
 [<c0007c7c>] ret_from_syscall+0x0/0x44
cron          S 0FF54014   376  4042      1          4055  4002 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255a0>] schedule_timeout+0x7c/0xcc
 [<c0025858>] sys_nanosleep+0x118/0x27c
 [<c0007c7c>] ret_from_syscall+0x0/0x44
exim          S 0FDD08D0     0  4055      1          4080  4042 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c006d618>] do_select+0x128/0x280
 [<c006da50>] sys_select+0x298/0x430
 [<c000dc2c>] ppc_select+0xa8/0xac
 [<c0007c7c>] ret_from_syscall+0x0/0x44
nscd          S 0FF9AEF8    56  4080      1  4082    4104  4055 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c01324a4>] wait_for_packet+0x11c/0x15c
 [<c01325b0>] skb_recv_datagram+0xcc/0x158
 [<c01847d4>] unix_accept+0x6c/0xe4
 [<c012d524>] sys_accept+0xb4/0x15c
 [<c012e060>] sys_socketcall+0xe4/0x1d4
 [<c0007c7c>] ret_from_syscall+0x0/0x44
nscd          S 0FED58CC     0  4082   4080  4083               (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255a0>] schedule_timeout+0x7c/0xcc
 [<c006dd84>] do_poll+0xbc/0xf0
 [<c006df30>] sys_poll+0x178/0x288
 [<c0007c7c>] ret_from_syscall+0x0/0x44
nscd          S 0FED58CC     0  4083   4082          4084       (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255a0>] schedule_timeout+0x7c/0xcc
 [<c006dd84>] do_poll+0xbc/0xf0
 [<c006df30>] sys_poll+0x178/0x288
 [<c0007c7c>] ret_from_syscall+0x0/0x44
nscd          S 0FF9AEF8     4  4084   4082          4085  4083 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c01324a4>] wait_for_packet+0x11c/0x15c
 [<c01325b0>] skb_recv_datagram+0xcc/0x158
 [<c01847d4>] unix_accept+0x6c/0xe4
 [<c012d524>] sys_accept+0xb4/0x15c
 [<c012e060>] sys_socketcall+0xe4/0x1d4
 [<c0007c7c>] ret_from_syscall+0x0/0x44
nscd          S 0FF9AEF8  4056  4085   4082          4086  4084 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c01324a4>] wait_for_packet+0x11c/0x15c
 [<c01325b0>] skb_recv_datagram+0xcc/0x158
 [<c01847d4>] unix_accept+0x6c/0xe4
 [<c012d524>] sys_accept+0xb4/0x15c
 [<c012e060>] sys_socketcall+0xe4/0x1d4
 [<c0007c7c>] ret_from_syscall+0x0/0x44
nscd          S 0FF9AEF8     0  4086   4082          4087  4085 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c01324a4>] wait_for_packet+0x11c/0x15c
 [<c01325b0>] skb_recv_datagram+0xcc/0x158
 [<c01847d4>] unix_accept+0x6c/0xe4
 [<c012d524>] sys_accept+0xb4/0x15c
 [<c012e060>] sys_socketcall+0xe4/0x1d4
 [<c0007c7c>] ret_from_syscall+0x0/0x44
nscd          S 0FF9AEF8     0  4087   4082                4086 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c01324a4>] wait_for_packet+0x11c/0x15c
 [<c01325b0>] skb_recv_datagram+0xcc/0x158
 [<c01847d4>] unix_accept+0x6c/0xe4
 [<c012d524>] sys_accept+0xb4/0x15c
 [<c012e060>] sys_socketcall+0xe4/0x1d4
 [<c0007c7c>] ret_from_syscall+0x0/0x44
inetd         S 0FF7E8D0   120  4104      1  9426    4112  4080 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c006d618>] do_select+0x128/0x280
 [<c006da50>] sys_select+0x298/0x430
 [<c000dc2c>] ppc_select+0xa8/0xac
 [<c0007c7c>] ret_from_syscall+0x0/0x44
mingetty      S 0FF77404     0  4112      1          4113  4104 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c00bb430>] read_chan+0x208/0x87c
 [<c00b673c>] tty_read+0x108/0x128
 [<c0058454>] vfs_read+0xdc/0x128
 [<c00586c0>] sys_read+0x40/0x74
 [<c0007c7c>] ret_from_syscall+0x0/0x44
mingetty      S 0FF77404     0  4113      1          4114  4112 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c00bb430>] read_chan+0x208/0x87c
 [<c00b673c>] tty_read+0x108/0x128
 [<c0058454>] vfs_read+0xdc/0x128
 [<c00586c0>] sys_read+0x40/0x74
 [<c0007c7c>] ret_from_syscall+0x0/0x44
mingetty      S 0FF77404  4088  4114      1          4115  4113 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c00bb430>] read_chan+0x208/0x87c
 [<c00b673c>] tty_read+0x108/0x128
 [<c0058454>] vfs_read+0xdc/0x128
 [<c00586c0>] sys_read+0x40/0x74
 [<c0007c7c>] ret_from_syscall+0x0/0x44
mingetty      S 0FF77404     0  4115      1          4116  4114 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c00bb430>] read_chan+0x208/0x87c
 [<c00b673c>] tty_read+0x108/0x128
 [<c0058454>] vfs_read+0xdc/0x128
 [<c00586c0>] sys_read+0x40/0x74
 [<c0007c7c>] ret_from_syscall+0x0/0x44
mingetty      S 0FF77404     0  4116      1          4117  4115 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c00bb430>] read_chan+0x208/0x87c
 [<c00b673c>] tty_read+0x108/0x128
 [<c0058454>] vfs_read+0xdc/0x128
 [<c00586c0>] sys_read+0x40/0x74
 [<c0007c7c>] ret_from_syscall+0x0/0x44
mingetty      S 0FF77404     0  4117      1          4140  4116 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c00bb430>] read_chan+0x208/0x87c
 [<c00b673c>] tty_read+0x108/0x128
 [<c0058454>] vfs_read+0xdc/0x128
 [<c00586c0>] sys_read+0x40/0x74
 [<c0007c7c>] ret_from_syscall+0x0/0x44
wmaker        R 0FB968D0     0  4127   3985  4174               (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255a0>] schedule_timeout+0x7c/0xcc
 [<c006d618>] do_select+0x128/0x280
 [<c006da50>] sys_select+0x298/0x430
 [<c000dc2c>] ppc_select+0xa8/0xac
 [<c0007c7c>] ret_from_syscall+0x0/0x44
uxmon         S 0FDF4014     0  4140      1          5744  4117 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255a0>] schedule_timeout+0x7c/0xcc
 [<c0025858>] sys_nanosleep+0x118/0x27c
 [<c0007c7c>] ret_from_syscall+0x0/0x44
xchat         R 0F7CB868     0  4174   4127          4175       (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255a0>] schedule_timeout+0x7c/0xcc
 [<c006dd84>] do_poll+0xbc/0xf0
 [<c006df30>] sys_poll+0x178/0x288
 [<c0007c7c>] ret_from_syscall+0x0/0x44
wmtime        R 0FD60014     0  4175   4127         21223  4174 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255a0>] schedule_timeout+0x7c/0xcc
 [<c0025858>] sys_nanosleep+0x118/0x27c
 [<c0007c7c>] ret_from_syscall+0x0/0x44
ssh-agent     S 0FC908D0    88  5744      1          5749  4140 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c006d618>] do_select+0x128/0x280
 [<c006da50>] sys_select+0x298/0x430
 [<c000dc2c>] ppc_select+0xa8/0xac
 [<c0007c7c>] ret_from_syscall+0x0/0x44
screen        S 0FE798D0     0  5749      1  5765   28861  5744 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c006d618>] do_select+0x128/0x280
 [<c006da50>] sys_select+0x298/0x430
 [<c000dc2c>] ppc_select+0xa8/0xac
 [<c0007c7c>] ret_from_syscall+0x0/0x44
bash          S 0FE45AD0     0  5765   5749  6883    5770       (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c001f4b0>] sys_wait4+0x19c/0x218
 [<c0007c7c>] ret_from_syscall+0x0/0x44
bash          S 0FE45AD0     0  5770   5749 26846    5773  5765 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c001f4b0>] sys_wait4+0x19c/0x218
 [<c0007c7c>] ret_from_syscall+0x0/0x44
ssh           S 0FC908D0     0  5773   5749          5776  5770 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c006d618>] do_select+0x128/0x280
 [<c006da50>] sys_select+0x298/0x430
 [<c000dc2c>] ppc_select+0xa8/0xac
 [<c0007c7c>] ret_from_syscall+0x0/0x44
bash          S 0FE45AD0     0  5776   5749  8489    5779  5773 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c001f4b0>] sys_wait4+0x19c/0x218
 [<c0007c7c>] ret_from_syscall+0x0/0x44
bash          S 0FE45AD0     0  5779   5749  1487    5783  5776 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c001f4b0>] sys_wait4+0x19c/0x218
 [<c0007c7c>] ret_from_syscall+0x0/0x44
bash          S 0FE45AD0     0  5783   5749 11619    5793  5779 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c001f4b0>] sys_wait4+0x19c/0x218
 [<c0007c7c>] ret_from_syscall+0x0/0x44
sshd          S 0FC3D404     4  5787   3656  6013   11614       (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c01856d4>] unix_stream_data_wait+0xb8/0xfc
 [<c0185ba8>] unix_stream_recvmsg+0x490/0x524
 [<c012c5c0>] sock_aio_read+0xe4/0xe8
 [<c0058334>] do_sync_read+0x74/0xb8
 [<c0058488>] vfs_read+0x110/0x128
 [<c00586c0>] sys_read+0x40/0x74
 [<c0007c7c>] ret_from_syscall+0x0/0x44
bash          S 0FE45AD0     4  5793   5749  8136    5826  5783 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c001f4b0>] sys_wait4+0x19c/0x218
 [<c0007c7c>] ret_from_syscall+0x0/0x44
bash          S 0FE69404     0  5826   5749          5833  5793 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c00bb430>] read_chan+0x208/0x87c
 [<c00b673c>] tty_read+0x108/0x128
 [<c0058454>] vfs_read+0xdc/0x128
 [<c00586c0>] sys_read+0x40/0x74
 [<c0007c7c>] ret_from_syscall+0x0/0x44
bash          S 0FE45AD0     0  5833   5749 28943    5836  5826 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c001f4b0>] sys_wait4+0x19c/0x218
 [<c0007c7c>] ret_from_syscall+0x0/0x44
bash          S 0FE45AD0     0  5836   5749 17835   30500  5833 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c001f4b0>] sys_wait4+0x19c/0x218
 [<c0007c7c>] ret_from_syscall+0x0/0x44
sshd          S 0FC448D0     0  6013   5787  6014               (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c006d618>] do_select+0x128/0x280
 [<c006da50>] sys_select+0x298/0x430
 [<c000dc2c>] ppc_select+0xa8/0xac
 [<c0007c7c>] ret_from_syscall+0x0/0x44
bash          S 0FE69404     0  6014   6013                     (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c00bb430>] read_chan+0x208/0x87c
 [<c00b673c>] tty_read+0x108/0x128
 [<c0058454>] vfs_read+0xdc/0x128
 [<c00586c0>] sys_read+0x40/0x74
 [<c0007c7c>] ret_from_syscall+0x0/0x44
ssh           S 0FC908D0     0  6883   5765                     (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c006d618>] do_select+0x128/0x280
 [<c006da50>] sys_select+0x298/0x430
 [<c000dc2c>] ppc_select+0xa8/0xac
 [<c0007c7c>] ret_from_syscall+0x0/0x44
ssh           S 0FC908D0     0  8489   5776                     (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c006d618>] do_select+0x128/0x280
 [<c006da50>] sys_select+0x298/0x430
 [<c000dc2c>] ppc_select+0xa8/0xac
 [<c0007c7c>] ret_from_syscall+0x0/0x44
ssh           S 0FC908D0     0 11619   5783                     (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c006d618>] do_select+0x128/0x280
 [<c006da50>] sys_select+0x298/0x430
 [<c000dc2c>] ppc_select+0xa8/0xac
 [<c0007c7c>] ret_from_syscall+0x0/0x44
ssh           S 0FC908D0     0  8136   5793                     (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c006d618>] do_select+0x128/0x280
 [<c006da50>] sys_select+0x298/0x430
 [<c000dc2c>] ppc_select+0xa8/0xac
 [<c0007c7c>] ret_from_syscall+0x0/0x44
ssh           S 0FC908D0     0 17835   5836                     (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c006d618>] do_select+0x128/0x280
 [<c006da50>] sys_select+0x298/0x430
 [<c000dc2c>] ppc_select+0xa8/0xac
 [<c0007c7c>] ret_from_syscall+0x0/0x44
ssh           S 0FC908D0     0 28943   5833                     (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c006d618>] do_select+0x128/0x280
 [<c006da50>] sys_select+0x298/0x430
 [<c000dc2c>] ppc_select+0xa8/0xac
 [<c0007c7c>] ret_from_syscall+0x0/0x44
bash          S 0FE69404     0 30500   5749                5836 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c00bb430>] read_chan+0x208/0x87c
 [<c00b673c>] tty_read+0x108/0x128
 [<c0058454>] vfs_read+0xdc/0x128
 [<c00586c0>] sys_read+0x40/0x74
 [<c0007c7c>] ret_from_syscall+0x0/0x44
ssh           S 0FC908D0     0  1487   5779                     (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c006d618>] do_select+0x128/0x280
 [<c006da50>] sys_select+0x298/0x430
 [<c000dc2c>] ppc_select+0xa8/0xac
 [<c0007c7c>] ret_from_syscall+0x0/0x44
screen        S 0FE798D0     0 28861      1 28862    6737  5749 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c006d618>] do_select+0x128/0x280
 [<c006da50>] sys_select+0x298/0x430
 [<c000dc2c>] ppc_select+0xa8/0xac
 [<c0007c7c>] ret_from_syscall+0x0/0x44
ssh           S 0FC908D0     0 28862  28861                     (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c006d618>] do_select+0x128/0x280
 [<c006da50>] sys_select+0x298/0x430
 [<c000dc2c>] ppc_select+0xa8/0xac
 [<c0007c7c>] ret_from_syscall+0x0/0x44
sshd          S 0FC3D404     0 11614   3656 11616          5787 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c01856d4>] unix_stream_data_wait+0xb8/0xfc
 [<c0185ba8>] unix_stream_recvmsg+0x490/0x524
 [<c012c5c0>] sock_aio_read+0xe4/0xe8
 [<c0058334>] do_sync_read+0x74/0xb8
 [<c0058488>] vfs_read+0x110/0x128
 [<c00586c0>] sys_read+0x40/0x74
 [<c0007c7c>] ret_from_syscall+0x0/0x44
sshd          S 0FC448D0     0 11616  11614 11617               (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c006d618>] do_select+0x128/0x280
 [<c006da50>] sys_select+0x298/0x430
 [<c000dc2c>] ppc_select+0xa8/0xac
 [<c0007c7c>] ret_from_syscall+0x0/0x44
bash          S 0FE45AD0     0 11617  11616 11635               (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c001f4b0>] sys_wait4+0x19c/0x218
 [<c0007c7c>] ret_from_syscall+0x0/0x44
ssh           S 0FC908D0     0 11635  11617                     (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c006d618>] do_select+0x128/0x280
 [<c006da50>] sys_select+0x298/0x430
 [<c000dc2c>] ppc_select+0xa8/0xac
 [<c0007c7c>] ret_from_syscall+0x0/0x44
bootpd        S 0FF7E8D0     0  9426   4104                     (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255a0>] schedule_timeout+0x7c/0xcc
 [<c006d618>] do_select+0x128/0x280
 [<c006da50>] sys_select+0x298/0x430
 [<c000dc2c>] ppc_select+0xa8/0xac
 [<c0007c7c>] ret_from_syscall+0x0/0x44
xterm         S 0FA868D0     0 21223   4127 21225   23800  4175 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c006d618>] do_select+0x128/0x280
 [<c006da50>] sys_select+0x298/0x430
 [<c000dc2c>] ppc_select+0xa8/0xac
 [<c0007c7c>] ret_from_syscall+0x0/0x44
bash          S 0FE45AD0     0 21225  21223 21240               (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c001f4b0>] sys_wait4+0x19c/0x218
 [<c0007c7c>] ret_from_syscall+0x0/0x44
screen        S 0FE4EFA8     0 21240  21225                     (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c002a0dc>] sys_pause+0x18/0x2c
 [<c0007c7c>] ret_from_syscall+0x0/0x44
xterm         S 0FA868D0     0 23800   4127 23802         21223 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c006d618>] do_select+0x128/0x280
 [<c006da50>] sys_select+0x298/0x430
 [<c000dc2c>] ppc_select+0xa8/0xac
 [<c0007c7c>] ret_from_syscall+0x0/0x44
bash          S 0FE45AD0     0 23802  23800  6337               (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c001f4b0>] sys_wait4+0x19c/0x218
 [<c0007c7c>] ret_from_syscall+0x0/0x44
pdflush       S 00000000     0  6737      1          3103 28861 (L-TLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c003ca48>] __pdflush+0xb4/0x21c
 [<c003cbc4>] pdflush+0x14/0x24
 [<c000ae50>] kernel_thread+0x44/0x60
autobuild     S 0FE45AD0    56 31787   3923 31789               (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c001f4b0>] sys_wait4+0x19c/0x218
 [<c0007c7c>] ret_from_syscall+0x0/0x44
tee           S 0FF77404     0 31789  31787         32217       (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00661f8>] pipe_wait+0x78/0xc4
 [<c0066450>] pipe_readv+0x20c/0x340
 [<c00665ac>] pipe_read+0x28/0x38
 [<c0058454>] vfs_read+0xdc/0x128
 [<c00586c0>] sys_read+0x40/0x74
 [<c0007c7c>] ret_from_syscall+0x0/0x44
autobuild_wat S 0FDF4014     0 32217  31787         32218 31789 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255a0>] schedule_timeout+0x7c/0xcc
 [<c0025858>] sys_nanosleep+0x118/0x27c
 [<c0007c7c>] ret_from_syscall+0x0/0x44
.build_script S 0FE45AD0     0 32218  31787  4108         32217 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c001f4b0>] sys_wait4+0x19c/0x218
 [<c0007c7c>] ret_from_syscall+0x0/0x44
pdflush       S 00000000     0  3103      1                6737 (L-TLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c003ca48>] __pdflush+0xb4/0x21c
 [<c003cbc4>] pdflush+0x14/0x24
 [<c000ae50>] kernel_thread+0x44/0x60
su            S 0FE8BBB0     0  4108  32218  4109               (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c001f4b0>] sys_wait4+0x19c/0x218
 [<c0007c7c>] ret_from_syscall+0x0/0x44
rpmb          S 0FD31D78     0  4109   4108  4168               (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c001f4b0>] sys_wait4+0x19c/0x218
 [<c0007c7c>] ret_from_syscall+0x0/0x44
sh            S 0FE3EBB0     0  4168   4109  6439               (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c001f4b0>] sys_wait4+0x19c/0x218
 [<c0007c7c>] ret_from_syscall+0x0/0x44
mozilla-bin   S 0F6768CC     0  6337  23802  6396               (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255ec>] schedule_timeout+0xc8/0xcc
 [<c006dd84>] do_poll+0xbc/0xf0
 [<c006df30>] sys_poll+0x178/0x288
 [<c0007c7c>] ret_from_syscall+0x0/0x44
mozilla-bin   S 0F6768CC     0  6396   6337  6397               (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255a0>] schedule_timeout+0x7c/0xcc
 [<c006dd84>] do_poll+0xbc/0xf0
 [<c006df30>] sys_poll+0x178/0x288
 [<c0007c7c>] ret_from_syscall+0x0/0x44
mozilla-bin   S 0F6768CC     0  6397   6396          6398       (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255a0>] schedule_timeout+0x7c/0xcc
 [<c006dd84>] do_poll+0xbc/0xf0
 [<c006df30>] sys_poll+0x178/0x288
 [<c0007c7c>] ret_from_syscall+0x0/0x44
mozilla-bin   S 0F5D03A4     0  6398   6396          6409  6397 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c000bb30>] sys_rt_sigsuspend+0xe4/0x134
 [<c0007c7c>] ret_from_syscall+0x0/0x44
mozilla-bin   S 0FC81610     0  6409   6396          7854  6398 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c00255a0>] schedule_timeout+0x7c/0xcc
 [<c0025858>] sys_nanosleep+0x118/0x27c
 [<c0007c7c>] ret_from_syscall+0x0/0x44
configure     S 0FE3EBB0    56  6439   4168 22479               (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c001f4b0>] sys_wait4+0x19c/0x218
 [<c0007c7c>] ret_from_syscall+0x0/0x44
mozilla-bin   S 0F5D03A4     0  7854   6396                6409 (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c000bb30>] sys_rt_sigsuspend+0xe4/0x134
 [<c0007c7c>] ret_from_syscall+0x0/0x44
sh            S 0FE3EBB0     0 22479   6439 26104               (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c001f4b0>] sys_wait4+0x19c/0x218
 [<c0007c7c>] ret_from_syscall+0x0/0x44
sh            S 0FE3EBB0     0 26104  22479 26105               (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c001f4b0>] sys_wait4+0x19c/0x218
 [<c0007c7c>] ret_from_syscall+0x0/0x44
conftest      R 1000077C     0 26105  26104                     (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c0008318>] recheck+0x0/0x20
su            S 0FEB6AD0     0 26846   5770 26847               (NOTLB)
Call trace:
 [<c000b0c0>] __switch_to+0x48/0x70
 [<c001869c>] schedule+0x3b8/0x774
 [<c001f4b0>] sys_wait4+0x19c/0x218
 [<c0007c7c>] ret_from_syscall+0x0/0x44
bash          R current      0 26847  26846                     (NOTLB)
Call trace:
 [<c001a0f4>] show_task+0x190/0x1fc
 [<c001a1b8>] show_state+0x58/0x9c
 [<c00cadf0>] sysrq_handle_showstate+0x10/0x20
 [<c00cb0b8>] __handle_sysrq_nolock+0x9c/0x140
 [<c00cb008>] handle_sysrq+0x54/0x68
 [<c008bf64>] write_sysrq_trigger+0x6c/0x74
 [<c0058634>] vfs_write+0xdc/0x128
 [<c0058734>] sys_write+0x40/0x74
 [<c0007c7c>] ret_from_syscall+0x0/0x44
nfs: server Hilbert2 not responding, still trying
nfs: server Hilbert2 OK

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
