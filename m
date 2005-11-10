Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbVKJVrw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbVKJVrw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 16:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbVKJVrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 16:47:52 -0500
Received: from pilet.ens-lyon.fr ([140.77.167.16]:6287 "EHLO pilet.ens-lyon.fr")
	by vger.kernel.org with ESMTP id S932171AbVKJVru (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 16:47:50 -0500
Message-ID: <4373C042.3060901@ens-lyon.org>
Date: Thu, 10 Nov 2005 16:48:50 -0500
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: axboe@suse.de
Cc: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Linux 2.6.14: Badness in as-iosched
References: <Pine.LNX.4.64.0510271717190.4664@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510271717190.4664@g5.osdl.org>
Content-Type: multipart/mixed;
 boundary="------------000801000907080505020402"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000801000907080505020402
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Jens,

I just hit a badness (actually, tons of badness like this) in as-iosched
while ripping
an audio CD with ripperX (with cdparanoia as a backend).
I was using 2.6.14 on an IBM Thinkpad R52. The kernel has been compiled with
gcc-4.0.2-2 (Debian testing).

The first badness in dmesg is:

cdrom: dropping to single frame dma
arq->state: 4
Badness in as_insert_request at drivers/block/as-iosched.c:1519
 [<c0237410>] as_insert_request+0x70/0x1d0
 [<c022dc25>] __elv_add_request+0xa5/0xe0
 [<c022dc8b>] elv_add_request+0x2b/0x40
 [<c0230fe6>] blk_execute_rq_nowait+0x46/0x60
 [<c023107a>] blk_execute_rq+0x7a/0xe0
 [<c0231310>] blk_end_sync_rq+0x0/0x30
 [<c0160b77>] bio_phys_segments+0x27/0x30
 [<c0232610>] blk_rq_bio_prep+0x40/0xb0
 [<c0230dc7>] blk_rq_map_user+0xb7/0xf0
 [<c026bc32>] cdrom_read_cdda_bpc+0x182/0x210
 [<c026bd1b>] cdrom_read_cdda+0x5b/0xc0
 [<c026d4b6>] mmc_ioctl+0x846/0xb20
 [<c0107bce>] timer_interrupt+0x3e/0x60
 [<c013affd>] handle_IRQ_event+0x3d/0x70
 [<c02352af>] scsi_cmd_ioctl+0xbf/0x510
 [<c01202f2>] __do_softirq+0x42/0xa0
 [<c0140f90>] buffered_rmqueue+0xc0/0x1c0
 [<c013f544>] generic_file_aio_write+0x84/0x110
 [<c026be66>] cdrom_ioctl+0xe6/0xe40
 [<c0146bdd>] lru_cache_add_active+0x2d/0x40
 [<c014c7b5>] do_anonymous_page+0x135/0x150
 [<c0252b75>] idecd_ioctl+0x85/0xa0
 [<c0233670>] blkdev_ioctl+0x140/0x1c0
 [<c016457b>] block_ioctl+0x2b/0x30
 [<c016e6a2>] do_ioctl+0x32/0x90
 [<c016e860>] vfs_ioctl+0x60/0x1f0
 [<c016ea35>] sys_ioctl+0x45/0x70
 [<c0103105>] syscall_call+0x7/0xb

It found similar reports in the archives
(http://lkml.org/lkml/2005/10/31/238
or http://lkml.org/lkml/2005/9/14/201) without any interesting conclusion.

_after_ reboot, hdparm looks like this:
/dev/hdc:
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  0 (off)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 readahead    = 256 (on)
 HDIO_GETGEO failed: Invalid argument

dmesg (without the badness flooding), lspci and .config are attached.

Regards,
Brice Goglin


--------------000801000907080505020402
Content-Type: application/x-gzip;
 name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="config.gz"

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
--------------000801000907080505020402
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dmesg"

[A] -> GSI 16 (level, low) -> IRQ 169
Simple Boot Flag at 0x35 set to 0x1
Initializing Cryptographic API
ACPI: PCI Interrupt 0000:00:01.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:01.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie03]
ACPI: PCI Interrupt 0000:00:1c.0[A] -> GSI 20 (level, low) -> IRQ 177
PCI: Setting latency timer of device 0000:00:1c.0 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie02]
Allocate Port Service[pcie03]
ACPI: PCI Interrupt 0000:00:1c.2[C] -> GSI 22 (level, low) -> IRQ 185
PCI: Setting latency timer of device 0000:00:1c.2 to 64
assign_interrupt_mode Found MSI capability
Allocate Port Service[pcie00]
Allocate Port Service[pcie02]
Allocate Port Service[pcie03]
ibm_acpi: IBM ThinkPad ACPI Extras v0.12a
ibm_acpi: http://ibm-acpi.sf.net/
ibm_acpi: dock device not present
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A
ACPI: PCI Interrupt 0000:00:1e.3[B] -> GSI 23 (level, low) -> IRQ 225
ACPI: PCI interrupt for device 0000:00:1e.3 disabled
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ide0: I/O resource 0x1F0-0x1F7 not free.
ide0: ports already in use, skipping probe
Probing IDE interface ide1...
hdc: MATSHITADVD-RAM UJ-822S, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW drive, 2048kB Cache
Uniform CD-ROM driver Revision: 3.20
libata version 1.12 loaded.
ata_piix version 1.04
ata: 0x170 IDE port busy
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0x1F0 ctl 0x3F6 bmdma 0x18C0 irq 14
ata1: dev 0 cfg 49:0f00 82:746b 83:5be8 84:4003 85:f469 86:1848 87:4003 88:203f
ata1: dev 0 ATA, max UDMA/100, 156301488 sectors:
ata1(0): applying bridge limits
ata1: dev 0 configured for UDMA/100
scsi0 : ata_piix
  Vendor: ATA       Model: IC25N080ATMR04-0  Rev: MO4O
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 < sda5 sda6 sda7 > sda4
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard on isa0060/serio0
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 4, 65536 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
TCP bic registered
Using IPI Shortcut mode
ACPI wakeup devices: 
 LID SLPB UART EXP0 EXP1 EXP2 EXP3 PCI1 USB0 USB1 USB3 USB7 AC9M 
ACPI: (supports S0 S3 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 188k freed
Synaptics Touchpad, model: 1, fw: 5.9, id: 0x2c6ab1, caps: 0x884793/0x0
serio: Synaptics pass-through port at isa0060/serio1/input0
input: SynPS/2 Synaptics TouchPad on isa0060/serio1
NET: Registered protocol family 1
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 915GM Chipset.
agpgart: AGP aperture is 256M @ 0x0
tg3.c:v3.42 (Oct 3, 2005)
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:02:00.0 to 64
eth0: Tigon3 [partno(BCM95751M) rev 4101 PHY(5750)] (PCI Express) 10/100/1000BaseT Ethernet 00:0a:e4:c1:49:c4
eth0: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1] TSOcap[1] 
eth0: dma_rwctrl[76180000]
hw_random: RNG not detected
IBM TrackPoint firmware: 0x0e, buttons: 3/3
input: TPPS/2 IBM TrackPoint on synaptics-pt/serio0
usbcore: registered new driver usbfs
usbcore: registered new driver hub
USB Universal Host Controller Interface driver v2.3
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 169
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.0: UHCI Host Controller
uhci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:1d.0: irq 169, io base 0x00001800
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 19 (level, low) -> IRQ 233
PCI: Setting latency timer of device 0000:00:1d.7 to 64
ehci_hcd 0000:00:1d.7: EHCI Host Controller
ehci_hcd 0000:00:1d.7: debug port 1
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 17 (level, low) -> IRQ 50
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.1: UHCI Host Controller
ehci_hcd 0000:00:1d.7: new USB bus registered, assigned bus number 2
ehci_hcd 0000:00:1d.7: irq 233, io mem 0xa8000000
PCI: cache line size of 32 is not supported by device 0000:00:1d.7
ehci_hcd 0000:00:1d.7: USB 2.0 initialized, EHCI 1.00, driver 10 Dec 2004
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 8 ports detected
snd_pcm: Unknown symbol snd_timer_notify
snd_pcm: Unknown symbol snd_timer_interrupt
snd_pcm: Unknown symbol snd_timer_new
uhci_hcd 0000:00:1d.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:1d.1: irq 50, io base 0x00001820
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 58
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.2: UHCI Host Controller
uhci_hcd 0000:00:1d.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:1d.2: irq 58, io base 0x00001840
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1d.3[D] -> GSI 19 (level, low) -> IRQ 233
PCI: Setting latency timer of device 0000:00:1d.3 to 64
uhci_hcd 0000:00:1d.3: UHCI Host Controller
uhci_hcd 0000:00:1d.3: new USB bus registered, assigned bus number 5
uhci_hcd 0000:00:1d.3: irq 233, io base 0x00001860
hub 5-0:1.0: USB hub found
hub 5-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:1e.3[B] -> GSI 23 (level, low) -> IRQ 225
PCI: Setting latency timer of device 0000:00:1e.3 to 64
ieee80211_crypt: registered algorithm 'NULL'
MC'97 1 converters and GPIO not ready (0xff00)
ACPI: PCI Interrupt 0000:04:00.0[A] -> GSI 16 (level, low) -> IRQ 169
Yenta: CardBus bridge found at 0000:04:00.0 [1014:0532]
ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.0.0
ipw2200: Copyright(c) 2003-2004 Intel Corporation
ACPI: PCI Interrupt 0000:00:1e.2[A] -> GSI 22 (level, low) -> IRQ 185
PCI: Setting latency timer of device 0000:00:1e.2 to 64
Yenta: ISA IRQ mask 0x04b8, PCI irq 169
Socket status: 30000006
pcmcia: parent PCI bridge I/O window: 0x5000 - 0x8fff
cs: IO port probe 0x5000-0x8fff: clean.
pcmcia: parent PCI bridge Memory window: 0xa8400000 - 0xb7ffffff
pcmcia: parent PCI bridge Memory window: 0xd0000000 - 0xd7ffffff
ACPI: PCI Interrupt 0000:04:02.0[A] -> GSI 21 (level, low) -> IRQ 66
ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
ohci1394: $Rev: 1313 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt 0000:04:00.1[B] -> GSI 17 (level, low) -> IRQ 50
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[50]  MMIO=[b1000000-b10007ff]  Max Packet=[2048]
intel8x0_measure_ac97_clock: measured 54303 usecs
intel8x0: clocking to 48000
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[000ae40533400918]
Adding 497972k swap on /dev/sda6.  Priority:-1 extents:1 across:497972k
EXT3 FS on sda5, internal journal
ACPI: CPU0 (power states: C1[C1] C2[C2] C3[C3])
ACPI: Processor [CPU] (supports 8 throttling states)
acpi-cpufreq: CPU0 - ACPI performance management activated.
Machine check exception polling timer started.
input: PC Speaker
hdaps: IBM ThinkPad R52 detected.
hdaps: initial latch check good (0x01).
hdaps: device successfully initialized.
hdaps: driver successfully loaded.
Non-volatile memory driver v1.2
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
NTFS driver 2.1.24 [Flags: R/O MODULE].
NTFS volume version 3.1.
pcmcia: Detected deprecated PCMCIA ioctl usage.
pcmcia: This interface will soon be removed from the kernel; please expect breakage unless you upgrade to new tools.
pcmcia: see http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for details.
cs: IO port probe 0x100-0x4ff: excluding 0x3b8-0x3df 0x3f0-0x3ff 0x4d0-0x4d7
cs: IO port probe 0x800-0x8ff: clean.
cs: IO port probe 0xc00-0xcff: excluding 0xcf8-0xcff
cs: IO port probe 0xa00-0xaff: clean.
ACPI: Battery Slot [BAT0] (battery absent)
ACPI: AC Adapter [AC] (on-line)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Thermal Zone [THM0] (56 C)
wifi (WE) : Driver using old /proc/net/wireless support, please fix driver !
fglrx: module license 'Proprietary. (C) 2002 - ATI Technologies, Starnberg, GERMANY' taints kernel.
[fglrx] Maximum main memory to use for locked dma buffers: 431 MBytes.
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 169
[fglrx] module loaded - fglrx 8.18.8 [Oct 25 2005] on minor 0
[fglrx] free  PCIe = 54804480
[fglrx] max   PCIe = 54804480
[fglrx] free  LFB = 55504896
[fglrx] max   LFB = 55504896
[fglrx] free  Inv = 0
[fglrx] max   Inv = 0
[fglrx] total Inv = 0
[fglrx] total TIM = 0
[fglrx] total FB  = 0
[fglrx] total PCIe = 16384
ieee80211_crypt: registered algorithm 'WEP'
NET: Registered protocol family 17
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x51 { IllegalLengthIndication LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 0
Buffer I/O error on device hdc, logical block 0
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x51 { IllegalLengthIndication LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 4
Buffer I/O error on device hdc, logical block 1
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x51 { IllegalLengthIndication LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 8
Buffer I/O error on device hdc, logical block 2
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x51 { IllegalLengthIndication LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 12
Buffer I/O error on device hdc, logical block 3
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x51 { IllegalLengthIndication LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 16
Buffer I/O error on device hdc, logical block 4
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x51 { IllegalLengthIndication LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 20
Buffer I/O error on device hdc, logical block 5
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x51 { IllegalLengthIndication LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 24
Buffer I/O error on device hdc, logical block 6
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x51 { IllegalLengthIndication LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 28
Buffer I/O error on device hdc, logical block 7
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x51 { IllegalLengthIndication LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 32
Buffer I/O error on device hdc, logical block 8
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x51 { IllegalLengthIndication LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 36
Buffer I/O error on device hdc, logical block 9
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x51 { IllegalLengthIndication LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 40
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x51 { IllegalLengthIndication LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 44
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x51 { IllegalLengthIndication LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 48
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x51 { IllegalLengthIndication LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 52
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x51 { IllegalLengthIndication LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 56
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x51 { IllegalLengthIndication LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 60
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x51 { IllegalLengthIndication LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 0
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x51 { IllegalLengthIndication LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 4
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x51 { IllegalLengthIndication LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 512
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x51 { IllegalLengthIndication LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 516
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x51 { IllegalLengthIndication LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 512
hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x51 { IllegalLengthIndication LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 516

--------------000801000907080505020402
Content-Type: text/plain;
 name="lspci"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lspci"

0000:00:00.0 Host bridge: Intel Corporation Mobile 915GM/PM/GMS/910GML Express Processor to DRAM Controller (rev 03)
	Subsystem: IBM: Unknown device 0575
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Capabilities: <available only to root>

0000:00:01.0 PCI bridge: Intel Corporation Mobile 915GM/PM Express PCI Express Root Port (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x08 (32 bytes)
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00003000-00003fff
	Memory behind bridge: a8100000-a81fffff
	Prefetchable memory behind bridge: c0000000-c7ffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
	Capabilities: <available only to root>

0000:00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 1 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x08 (32 bytes)
	Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
	Memory behind bridge: a8200000-a82fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: <available only to root>

0000:00:1c.2 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 3 (rev 03) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x08 (32 bytes)
	Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
	I/O behind bridge: 00004000-00004fff
	Memory behind bridge: a8300000-a83fffff
	Prefetchable memory behind bridge: 00000000c8000000-00000000c8000000
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: <available only to root>

0000:00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #1 (rev 03) (prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 0565
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 169
	Region 4: I/O ports at 1800 [size=32]

0000:00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #2 (rev 03) (prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 0565
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 50
	Region 4: I/O ports at 1820 [size=32]

0000:00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #3 (rev 03) (prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 0565
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin C routed to IRQ 58
	Region 4: I/O ports at 1840 [size=32]

0000:00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB UHCI #4 (rev 03) (prog-if 00 [UHCI])
	Subsystem: IBM: Unknown device 0565
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 233
	Region 4: I/O ports at 1860 [size=32]

0000:00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) USB2 EHCI Controller (rev 03) (prog-if 20 [EHCI])
	Subsystem: IBM: Unknown device 0566
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin D routed to IRQ 233
	Region 0: Memory at a8000000 (32-bit, non-prefetchable) [size=1K]
	Capabilities: <available only to root>

0000:00:1e.0 PCI bridge: Intel Corporation 82801 Mobile PCI Bridge (rev d3) (prog-if 01 [Subtractive decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=04, subordinate=07, sec-latency=64
	I/O behind bridge: 00005000-00008fff
	Memory behind bridge: a8400000-b7ffffff
	Prefetchable memory behind bridge: 00000000d0000000-00000000d7f00000
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: <available only to root>

0000:00:1e.2 Multimedia audio controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Audio Controller (rev 03)
	Subsystem: IBM: Unknown device 0567
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin A routed to IRQ 185
	Region 0: I/O ports at 1c00 [size=256]
	Region 1: I/O ports at 1880 [size=64]
	Region 2: Memory at a8000800 (32-bit, non-prefetchable) [size=512]
	Region 3: Memory at a8000400 (32-bit, non-prefetchable) [size=256]
	Capabilities: <available only to root>

0000:00:1e.3 Modem: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) AC'97 Modem Controller (rev 03) (prog-if 00 [Generic])
	Subsystem: IBM: Unknown device 0576
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Interrupt: pin B routed to IRQ 225
	Region 0: I/O ports at 2400 [size=256]
	Region 1: I/O ports at 2000 [size=128]
	Capabilities: <available only to root>

0000:00:1f.0 ISA bridge: Intel Corporation 82801FBM (ICH6M) LPC Interface Bridge (rev 03)
	Subsystem: IBM: Unknown device 0568
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

0000:00:1f.2 IDE interface: Intel Corporation 82801FBM (ICH6M) SATA Controller (rev 03) (prog-if 80 [Master])
	Subsystem: IBM: Unknown device 056a
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Region 0: I/O ports at <unassigned>
	Region 1: I/O ports at <unassigned>
	Region 2: I/O ports at <unassigned>
	Region 3: I/O ports at <unassigned>
	Region 4: I/O ports at 18c0 [size=16]
	Capabilities: <available only to root>

0000:00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus Controller (rev 03)
	Subsystem: IBM: Unknown device 056b
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 11
	Region 4: I/O ports at 18e0 [size=32]

0000:01:00.0 VGA compatible controller: ATI Technologies Inc M22 [Radeon Mobility M300] (prog-if 00 [VGA])
	Subsystem: IBM: Unknown device 056e
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 169
	Region 0: Memory at c0000000 (32-bit, prefetchable) [size=128M]
	Region 1: I/O ports at 3000 [size=256]
	Region 2: Memory at a8100000 (32-bit, non-prefetchable) [size=64K]
	Expansion ROM at a8120000 [disabled] [size=128K]
	Capabilities: <available only to root>

0000:02:00.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5751M Gigabit Ethernet PCI Express (rev 11)
	Subsystem: IBM: Unknown device 0577
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0, Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 169
	Region 0: Memory at a8200000 (64-bit, non-prefetchable) [size=64K]
	Capabilities: <available only to root>

0000:04:00.0 CardBus bridge: Ricoh Co Ltd RL5c476 II (rev b3)
	Subsystem: IBM: Unknown device 0532
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 168
	Interrupt: pin A routed to IRQ 169
	Region 0: Memory at a8400000 (32-bit, non-prefetchable) [size=4K]
	Bus: primary=04, secondary=05, subordinate=08, sec-latency=176
	Memory window 0: d0000000-d1fff000 (prefetchable)
	Memory window 1: aa000000-abfff000
	I/O window 0: 00005000-000050ff
	I/O window 1: 00005400-000054ff
	BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset- 16bInt+ PostWrite+
	16-bit legacy interface ports at 0001

0000:04:00.1 FireWire (IEEE 1394): Ricoh Co Ltd R5C552 IEEE 1394 Controller (rev 08) (prog-if 10 [OHCI])
	Subsystem: IBM: Unknown device 01cf
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 1000ns max)
	Interrupt: pin B routed to IRQ 50
	Region 0: Memory at b1000000 (32-bit, non-prefetchable) [size=2K]
	Capabilities: <available only to root>

0000:04:02.0 Network controller: Intel Corporation PRO/Wireless 2200BG (rev 05)
	Subsystem: Intel Corporation: Unknown device 2712
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (750ns min, 6000ns max), Cache Line Size: 0x08 (32 bytes)
	Interrupt: pin A routed to IRQ 66
	Region 0: Memory at a8401000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: <available only to root>


--------------000801000907080505020402--
