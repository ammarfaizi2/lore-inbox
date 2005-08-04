Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261767AbVHDDkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbVHDDkO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 23:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbVHDDiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 23:38:16 -0400
Received: from smtp2.brturbo.com.br ([200.199.201.158]:53665 "EHLO
	smtp2.brturbo.com.br") by vger.kernel.org with ESMTP
	id S261788AbVHDDh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 23:37:58 -0400
Subject: [Fwd: Re: BTTV - experimental no_overlay patch]
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: gregkh@suse.de
Cc: LKML <linux-kernel@vger.kernel.org>, Bodo Eggbert <7eggert@gmx.de>
Content-Type: text/plain
Date: Thu, 04 Aug 2005 00:37:53 -0300
Message-Id: <1123126673.8274.56.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3-5mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

	It seems that some newer VIA chipsets have some troubles with PCI2PCI
data transfers. These problems had occurred on the past (while Gerd
Knorr were the V4L maintainer) and affected Overlay support for bttv
cards, mostly on via chipsets. 
	Bodo (and others) had reported some OOPS occurring when activating
Overlay support (that makes data transfers from PCI bttv cards to AGI
video card).
	We've made some tests deactivating overlay support and they reported no
OOPS.
	I'm submiting a patch for V4L bttv to allow disabling pci2pci transfers
based on quirks.c information and also an optional workaround parameter
to force the board to don't allow (no_overlay insmod parameter).
	I think you may also check if it is a hardware problem with these via
chips or something that can be fixed by software (increasing some
delays, for example?).

Mauro.
Current V4L Maintainer.

-------- Mensagem encaminhada --------
De: Bodo Eggert <7eggert@gmx.de>
Para: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Assunto: Re: BTTV - experimental no_overlay patch
Data: Thu, 4 Aug 2005 02:28:21 +0200 (CEST)

On Wed, 3 Aug 2005, Mauro Carvalho Chehab wrote:

> Bodo,
> 
> 	Please, send me bttv init logs. I need to know if PCI quirks has
> detected your PCI chipset as a problematic one.

It seems it hasn't. Full dmesg and lspci:


Detected 901.761 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 514344k/524224k available (3082k kernel code, 9324k reserved, 961k data, 148k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1806.64 BogoMIPS (lpj=3613286)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0183f9ff c1c7f9ff 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0183f9ff c1c7f9ff 00000000 00000000 00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps: 0183f9ff c1c7f9ff 00000000 00000020 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
NET: Registered protocol family 16
PCI: Using configuration type 1
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
PCI: Using IRQ router VIA [1106/0686] at 0000:00:07.0
PCI: Bridge: 0000:00:01.0
  IO window: c000-cfff
  MEM window: e8000000-e9ffffff
  PREFETCH window: d0000000-dfffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
NTFS driver 2.1.23 [Flags: R/O].
Initializing Cryptographic API
Applying VIA southbridge workaround.
radeonfb_pci_register BEGIN
radeonfb (0000:01:00.0): Found 131072k of DDR 128 bits wide videoram
radeonfb (0000:01:00.0): mapped 16384k videoram
radeonfb: Found Intel x86 BIOS ROM Image
radeonfb: Retreived PLL infos from BIOS
radeonfb: Reference=27.00 MHz (RefDiv=12) Memory=250.00 Mhz, System=200.00 MHz
radeonfb: PLL min 20000 max 40000
1 chips in connector info
 - chip 1 has 2 connectors
  * connector 0 of type 2 (CRT) : 2300
  * connector 1 of type 3 (DVI-I) : 3201
Starting monitor auto detection...
radeonfb: I2C (port 1) ... not found
radeonfb: I2C (port 2) ... not found
radeonfb: I2C (port 3) ... found CRT display
radeonfb: I2C (port 4) ... not found
radeonfb: I2C (port 2) ... not found
radeonfb: I2C (port 4) ... not found
radeonfb: I2C (port 3) ... found CRT display
radeonfb: Monitor 1 type CRT found
radeonfb: EDID probed
radeonfb: Monitor 2 type no found
hStart = 694, hEnd = 757, hTotal = 795
vStart = 402, vEnd = 408, vTotal = 418
h_total_disp = 0x590062	   hsync_strt_wid = 0x8702c0
v_total_disp = 0x18f01a1	   vsync_strt_wid = 0x860191
pixclock = 85925
freq = 1163
freq = 1666, PLL min = 20000, PLL max = 40000
ref_div = 12, ref_clk = 2700, output_freq = 26656
ref_div = 12, ref_clk = 2700, output_freq = 26656
post div = 0x5
fb_div = 0x76
ppll_div_3 = 0x50076
Console: switching to colour frame buffer device 90x25
radeonfb (0000:01:00.0): ATI Radeon AS 
radeonfb_pci_register END
PCI: Enabling device 0000:00:09.0 (0000 -> 0003)
PCI: Found IRQ 5 for device 0000:00:09.0
PCI: Sharing IRQ 5 with 0000:00:0d.0
fb: 3Dfx Banshee memory = 16384K
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected VIA Twister-K/KT133x/KM133 chipset
agpgart: AGP aperture is 64M @ 0xe0000000
[drm] Initialized drm 1.0.0 20040925
PCI: Found IRQ 5 for device 0000:00:09.0
PCI: Sharing IRQ 5 with 0000:00:0d.0
[drm] Initialized tdfx 1.0.0 20010216 on minor 0: 
[drm] Initialized radeon 1.16.0 20050311 on minor 1: 
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin is 60 seconds).
Hangcheck: Using monotonic_clock().
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport_pc: VIA 686A/8231 detected
parport_pc: probing current configuration
parport_pc: Current parallel port base: 0x378
parport0: PC-style at 0x378 (0x778), irq 7 [PCSPP,TRISTATE]
parport_pc: VIA parallel port: io=0x378, irq=7
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
loop: loaded (max 8 devices)
sis900.c: v1.08.08 Jan. 22 2005
PCI: Found IRQ 10 for device 0000:00:0b.0
0000:00:0b.0: SiS 900 Internal MII PHY transceiver found at address 1.
0000:00:0b.0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0xe400, IRQ 10, 00:40:33:e2:57:c8.
netconsole: device eth0 not up yet, forcing it
netconsole: carrier detect appears untrustworthy, waiting 4 seconds
eth0: Media Link On 100mbps full-duplex 
netconsole: network logging started
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
PCI: Via IRQ fixup for 0000:00:07.1, from 255 to 0
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: Maxtor 2F040L0, ATA DISK drive
hdb: Maxtor 6Y080L0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: ST36451A, ATA DISK drive
hdd: LITE-ON LTR-48246K, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 80293248 sectors (41110 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes supported
 hda: hda1 hda2
hdb: max request size: 128KiB
hdb: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hdb: cache flushes supported
 hdb: hdb1 hdb2 hdb3 < hdb5 hdb6 hdb7 hdb8 > hdb4
hdc: max request size: 128KiB
hdc: 12594960 sectors (6448 MB) w/448KiB Cache, CHS=13328/15/63, UDMA(33)
hdc: cache flushes not supported
 hdc: hdc1 hdc2
hdd: ATAPI 48X CD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
PCI: Found IRQ 11 for device 0000:00:0c.0
PCI: Sharing IRQ 11 with 0000:00:07.2
PCI: Sharing IRQ 11 with 0000:00:07.3
DC390_init: No EEPROM found! Trying default settings ...
DC390: Used defaults: AdaptID=7, SpeedIdx=0 (10.0 MHz), DevMode=0x1f, AdaptMode=0x2f, TaggedCmnds=3 (16), DelayReset=1s
scsi0 : Tekram DC390/AM53C974 V2.1d 2004-05-27
  Vendor: IBM       Model: DCAS-34330        Rev: S65A
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: IBM       Model: DCAS-34330        Rev: S65A
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: TOSHIBA   Model: CD-ROM XM-6201TA  Rev: 1030
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: MATSHITA  Model: CD-ROM CR-8004    Rev: 1.1f
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: IBM       Model: DORS-32160        Rev: S82C
  Type:   Direct-Access                      ANSI SCSI revision: 02
st: Version 20050501, fixed bufsize 32768, s/g segs 256
DC390: Target 0: Sync transfer 10.0 MHz, Offset 15
SCSI device sda: 8467200 512-byte hdwr sectors (4335 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 8467200 512-byte hdwr sectors (4335 MB)
SCSI device sda: drive cache: write back
 sda: sda1
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
DC390: Target 1: Sync transfer 10.0 MHz, Offset 15
SCSI device sdb: 8467200 512-byte hdwr sectors (4335 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 8467200 512-byte hdwr sectors (4335 MB)
SCSI device sdb: drive cache: write back
 sdb: sdb1
Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
DC390: Target 5: Sync transfer 10.0 MHz, Offset 15
SCSI device sdc: 4226725 512-byte hdwr sectors (2164 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 4226725 512-byte hdwr sectors (2164 MB)
SCSI device sdc: drive cache: write back
 sdc: sdc1
Attached scsi disk sdc at scsi0, channel 0, id 5, lun 0
DC390: Target 3: Sync transfer 10.0 MHz, Offset 15
sr0: scsi3-mmc drive: 0x/0x caddy
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 3, lun 0
DC390: Target 4: Sync transfer 2.1 MHz, Offset 8
sr1: scsi3-mmc drive: 0x/0x caddy
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 4, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
Attached scsi generic sg1 at scsi0, channel 0, id 1, lun 0,  type 0
Attached scsi generic sg2 at scsi0, channel 0, id 3, lun 0,  type 5
Attached scsi generic sg3 at scsi0, channel 0, id 4, lun 0,  type 5
Attached scsi generic sg4 at scsi0, channel 0, id 5, lun 0,  type 0
USB Universal Host Controller Interface driver v2.3
PCI: Found IRQ 11 for device 0000:00:07.2
PCI: Sharing IRQ 11 with 0000:00:07.3
PCI: Sharing IRQ 11 with 0000:00:0c.0
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:07.2: irq 11, io base 0x0000d400
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
PCI: Found IRQ 11 for device 0000:00:07.3
PCI: Sharing IRQ 11 with 0000:00:07.2
PCI: Sharing IRQ 11 with 0000:00:0c.0
uhci_hcd 0000:00:07.3: UHCI Host Controller
uhci_hcd 0000:00:07.3: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:07.3: irq 11, io base 0x0000d800
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
Initializing USB Mass Storage driver...
usb 1-2: new full speed USB device using uhci_hcd and address 2
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.01:USB HID core driver
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
drivers/usb/serial/usb-serial.c: USB Serial support registered for PL-2303
pl2303 1-2:1.0: PL-2303 converter detected
usb 1-2: PL-2303 converter now attached to ttyUSB0
usbcore: registered new driver pl2303
drivers/usb/serial/pl2303.c: Prolific PL2303 USB to serial adaptor driver v0.12
mice: PS/2 mouse device common for all mice
input: PC Speaker
i2c /dev entries driver
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Logitech Wheel Mouse on isa0060/serio1
device-mapper: 4.4.0-ioctl (2005-01-12) initialised: dm-devel@redhat.com
wbsd: Winbond W83L51xD SD/MMC card interface driver, 1.2
wbsd: Copyright(c) Pierre Ossman
NET: Registered protocol family 2
IP route cache hash table entries: 8192 (order: 3, 32768 bytes)
TCP established hash table entries: 32768 (order: 6, 262144 bytes)
TCP bind hash table entries: 32768 (order: 5, 131072 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
SCTP: Hash tables configured (established 16384 bind 32768)
Using IPI Shortcut mode
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 148k freed
Adding 120476k swap on /dev/hdb4.  Priority:2 extents:1
ReiserFS: hdb6: found reiserfs format "3.6" with standard journal
ReiserFS: hdb6: using ordered data mode
ReiserFS: hdb6: journal params: device hdb6, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hdb6: checking transaction log (hdb6)
ReiserFS: hdb6: Using r5 hash to sort names
ReiserFS: hdb7: found reiserfs format "3.6" with standard journal
ReiserFS: hdb7: using ordered data mode
ReiserFS: hdb7: journal params: device hdb7, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hdb7: checking transaction log (hdb7)
ReiserFS: hdb7: Using r5 hash to sort names
ReiserFS: hdb8: found reiserfs format "3.6" with standard journal
ReiserFS: hdb8: using ordered data mode
ReiserFS: hdb8: journal params: device hdb8, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hdb8: checking transaction log (hdb8)
ReiserFS: hdb8: Using r5 hash to sort names
es1371: version v0.32 time 22:48:36 Aug  3 2005
PCI: Found IRQ 5 for device 0000:00:0d.0
PCI: Sharing IRQ 5 with 0000:00:09.0
es1371: found chip, vendor id 0x1274 device id 0x5880 revision 0x02
es1371: found es1371 rev 2 at io 0xec00 irq 5
ac97_codec: AC97  codec, id: TRA35 (TriTech TR A5)
gameport: ESS1371 Gameport is isa0218/gameport0, io 0x218, speed 2209kHz
bttv: driver version 0.9.16 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
PCI: Found IRQ 9 for device 0000:00:0a.0
bttv0: Bt848 (rev 18) at 0000:00:0a.0, irq: 9, latency: 32, mmio: 0xeb000000
bttv0: using: Terratec TerraTV+ Version 1.1 (bt878) [card=28,insmod option]
bttv0: gpio: en=00000000, out=00000000 in=00ffffff [init]
 : chip found @ 0xc0 (bt848 #0 [sw])
 : All bytes are equal. It is not a TEA5767
bttv0: tea5757: read timeout
bttv0: using tuner=5
tuner 6-0060: type set to 5 (Philips PAL_BG (FI1216 and compatibles))
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
bttv0: i2c: checking for TDA9887 @ 0x86... not found
bttv0: registered device video0
bttv0: registered device vbi0
input: Multisystem joystick (2 fire) on parport0
input: Analog 2-axis 4-button joystick at isa0218/gameport0 [TSC timer, 897 MHz clock, 481 ns res]
process `syslogd' is using obsolete setsockopt SO_BSDCOMPAT
hdd: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdd: drive_cmd: error=0x04 { AbortedCommand }
ide: failed opcode was: 0xec
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO
program smartd is using a deprecated SCSI ioctl, please convert it to SG_IO


00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
	Subsystem: Elitegroup Computer Systems: Unknown device 0987
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: e8000000-e9ffffff
	Prefetchable memory behind bridge: d0000000-dfffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. VT82C586/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at d000 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at d400 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 16) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at d800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Subsystem: Elitegroup Computer Systems: Unknown device 0987
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 11
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo Banshee (rev 03) (prog-if 00 [VGA])
	Subsystem: Creative Labs: Unknown device 1017
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at e4000000 (32-bit, non-prefetchable) [size=32M]
	Region 1: Memory at e6000000 (32-bit, prefetchable) [size=32M]
	Region 2: I/O ports at e000 [size=256]
	Expansion ROM at 20020000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Multimedia video controller: Brooktree Corporation Bt848 Video Capture (rev 12)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at eb000000 (32-bit, prefetchable) [size=4K]

00:0b.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet (rev 02)
	Subsystem: Silicon Integrated Systems [SiS] SiS900 10/100 Ethernet Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (13000ns min, 2750ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at e400 [size=256]
	Region 1: Memory at eb001000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at 20000000 [disabled] [size=128K]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 SCSI storage controller: Advanced Micro Devices [AMD] 53c974 [PCscsi] (rev 10)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at e800 [size=128]

00:0d.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
	Subsystem: Ensoniq Creative Sound Blaster AudioPCI128
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
	Latency: 32 (3000ns min, 32000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at ec00 [size=64]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: ATI Technologies Inc: Unknown device 4153 (prog-if 00 [VGA])
	Subsystem: Unknown device 1536:0200
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 08
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at c000 [size=256]
	Region 2: Memory at e9000000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at e8000000 [disabled] [size=128K]
	Capabilities: [58] AGP version 2.0
		Status: RQ=80 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.1 Display controller: ATI Technologies Inc: Unknown device 4173
	Subsystem: Unknown device 1536:0201
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2000ns min), cache line size 08
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Region 1: Memory at e9010000 (32-bit, non-prefetchable) [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


