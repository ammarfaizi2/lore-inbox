Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbVDYWjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbVDYWjp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 18:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVDYWjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 18:39:36 -0400
Received: from 66.237.85.154.ptr.us.xo.net ([66.237.85.154]:55569 "EHLO
	rapsure.net") by vger.kernel.org with ESMTP id S261253AbVDYWeb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 18:34:31 -0400
Message-ID: <426D706D.1070106@rapsure.net>
Date: Mon, 25 Apr 2005 16:34:21 -0600
From: Brian Beardall <brian@rapsure.net>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050327)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bug AMD 756 OHCI isochronous tranfers
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been experiencing IRQ don't cares using webcams that use
isochronous transfers.  These  are reproducible on different
mainboards.  The one is an MSI-6195, and the other is a MSI-6167.  The
bottom two kernel logs occured after usb debugging was enabled.  I am
not quite sure why the USB controller is dying like this.  I have double
checked the drivers, but they are only starting the transfer.  I would
do testing on more mainboards with the AMD 756 southbridge, but I only
have two.  The crash is a little unpredictable.  Sometimes it takes 10
seconds to crash the controller, and other times it can run for 12 hours
without and IRQ don't care.  From my study it will most likely need to
be another AMD 756 work around.  Here are some of the kernel messages:

quickcam: frame lost
hub 1-0:1.0: resubmit --> -108
hub 1-0:1.0: hub_port_status failed (err = -108)
irq 10: nobody cared!
 [<c013216a>] __report_bad_irq+0x2a/0x90
 [<c0131aa0>] handle_IRQ_event+0x30/0x70
 [<c013225c>] note_interrupt+0x6c/0xd0
 [<c0131c26>] __do_IRQ+0x146/0x160
 [<c0104383>] do_IRQ+0x23/0x40
 [<c010294a>] common_interrupt+0x1a/0x20
 [<c011a370>] __do_softirq+0x30/0x90
 [<c011a3f6>] do_softirq+0x26/0x30
 [<c011a4c5>] irq_exit+0x35/0x40
 [<c0104388>] do_IRQ+0x28/0x40
 [<c010294a>] common_interrupt+0x1a/0x20
 [<c01005d3>] default_idle+0x23/0x30
 [<c0100658>] cpu_idle+0x48/0x60
 [<c05a875f>] start_kernel+0x16f/0x1b0
 [<c05a8330>] unknown_bootoption+0x0/0x1b0
handlers:
[<c03305e0>] (usb_hcd_irq+0x0/0x70)
[<c0398c80>] (snd_emu10k1_interrupt+0x0/0x400)
[<c02f4520>] (intr_handler+0x0/0x150)
Disabling IRQ #10
quickcam: qc_stv_set error -108
quickcam: usb_set_interface error



Another instance:

quickcam [41.559367]: qc_isoc_start(qc=ca37a000)
hub 1-0:1.0: resubmit --> -108
hub 1-0:1.0: hub_port_status failed (err = -108)
irq 10: nobody cared!
 [<c01356aa>] __report_bad_irq+0x2a/0x90
 [<c0134fe0>] handle_IRQ_event+0x30/0x70
 [<c013579c>] note_interrupt+0x6c/0xd0
 [<c0135166>] __do_IRQ+0x146/0x160
 [<c0104e03>] do_IRQ+0x23/0x40
 [<c01033ca>] common_interrupt+0x1a/0x20
 [<c011d8b0>] __do_softirq+0x30/0x90
 [<c011d936>] do_softirq+0x26/0x30
 [<c011da05>] irq_exit+0x35/0x40
 [<c0104e08>] do_IRQ+0x28/0x40
 [<c01033ca>] common_interrupt+0x1a/0x20
 [<c02bc242>] acpi_processor_idle+0x123/0x260
 [<c01010d8>] cpu_idle+0x48/0x60
 [<c05b475f>] start_kernel+0x16f/0x1b0
 [<c05b4330>] unknown_bootoption+0x0/0x1b0
handlers:
[<c0335650>] (ohci_irq_handler+0x0/0x7a0)
[<c034ca60>] (usb_hcd_irq+0x0/0x70)
Disabling IRQ #10
quickcam [21.098893]: failed qc_v4l_ioctl()=-512
quickcam [21.104563]: qc_v4l_close(dev=ca37a024,qc=ca37a000)
quickcam [21.104585]: close users=0
quickcam [21.104593]: qc_v4l_cleanup(ca37a000)
quickcam [21.104602]: qc_capt_exit(quickcam=ca37a000)
quickcam [21.104611]: qc_isoc_exit(quickcam=ca37a000)
quickcam [21.104620]: qc_isoc_stop(quickcam=ca37a000)
quickcam: qc_stv_set error -108
quickcam [21.104656]: Failed qc_i2c_nextpacket()=-108
quickcam [21.104664]: i2c_cancel: qc=ca37a000, id=ca37a150
quickcam [21.104673]: i2c_cancel: id->urb=d0856860
quickcam [21.104681]: i2c_cancel: id->urb->dev=caca5800
quickcam [21.104689]: i2c_cancel: id->urb->dev->bus=d3d98800
quickcam [21.104697]: i2c_cancel: id->urb->dev->bus->op=c055ff20
quickcam [21.104706]: Failed qc_i2c_nextpacket()=-108
quickcam [21.104713]: i2c_cancel: qc=ca37a000, id=ca37a150
quickcam [21.104721]: i2c_cancel: id->urb=d0856860
quickcam [21.104729]: i2c_cancel: id->urb->dev=caca5800
quickcam [21.104736]: i2c_cancel: id->urb->dev->bus=d3d98800
quickcam [21.104744]: i2c_cancel: id->urb->dev->bus->op=c055ff20
quickcam: usb_set_interface error
quickcam [21.104760]: isoc urb[0]->status = -115
quickcam [21.104788]: Ignoring isoc interrupt, dev=caca5800 streaming=0
status=-2
quickcam [21.104799]: isoc urb[1]->status = -115
quickcam [21.104813]: Ignoring isoc interrupt, dev=caca5800 streaming=0
status=-2
quickcam [21.104840]: qc_stream_exit(quickcam=ca37a000)
quickcam [21.104851]: qc_frame_exit(qc=ca37a000,tail=1,head=0)

This is the typical startup of the system:

000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000017ff0000 (usable)
 BIOS-e820: 0000000017ff0000 - 0000000017ff8000 (ACPI data)
 BIOS-e820: 0000000017ff8000 - 0000000018000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
383MB LOWMEM available.
On node 0 totalpages: 98288
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 94192 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 AMI                                   ) @ 0x000fa8f0
ACPI: RSDT (v001 AMIINT          0x00000010 MSFT 0x00000097) @ 0x17ff0000
ACPI: FADT (v001 AMIINT          0x00000010 MSFT 0x00000097) @ 0x17ff0030
ACPI: DSDT (v001 AMD75X IRONGATE 0x00001000 MSFT 0x0100000b) @ 0x00000000
Allocating PCI resources starting at 18000000 (gap: 18000000:e7ff0000)
Built 1 zonelists
Kernel command line: video=vesafb:ywrap,pmipal,1024x768-32@75
root=/dev/hda3 splash=silent,theme:livecd-2005.0
fbsplash: silent
fbsplash: theme livecd-2005.0
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 805.807 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 382572k/393152k available (3509k kernel code, 9908k reserved,
1246k data, 212k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay loop... 1589.24 BogoMIPS (lpj=794624)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU: After generic identify, caps: 0183f9ff c1c7f9ff 00000000 00000000
00000000 00000000 00000000
CPU: After vendor identify, caps: 0183f9ff c1c7f9ff 00000000 00000000
00000000 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU: After all inits, caps: 0183f9ff c1c7f9ff 00000000 00000020 00000000
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) Processor stepping 02
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0020 (from 0e00)
checking if image is initramfs... it is
Freeing initrd memory: 1035k freed
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdaf1, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20050211
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *9 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 9 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 9 10 11 12 14 15) *0,
disabled.
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 9 *10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 10 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
Machine check exception polling timer started.
apm: BIOS not found.
inotify device minor=63
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
lp: driver loaded but no devices found
Generic RTC Driver v1.07
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected AMD Irongate chipset
agpgart: Maximum main memory to use for agp memory: 321M
agpgart: AGP aperture is 64M @ 0xe8000000
Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin
is 60 seconds).
vesafb: NVidia Corporation, NV15 Reference Board, Chip Rev A0 (OEM: NVidia)
vesafb: VBE version: 3.0
vesafb: protected mode interface info at c000:0f03
vesafb: pmi: set display start = c00c0f3c, set palette = c00c0fb2
vesafb: pmi: ports = 3b4 3b5 3ba 3c0 3c1 3c4 3c5 3c6 3c7 3c8 3c9 3cc 3ce
3cf 3d0 3d1 3d2 3d3 3d4 3d5 3da
vesafb: hardware supports DCC2 transfers
vesafb: monitor limits: vf = 85 Hz, hf = 80 kHz, clk = 135 MHz
vesafb: scrolling: ywrap using protected mode interface, yres_virtual=1536
Console: switching to colour frame buffer device 128x48
fbsplash: console 0 using theme 'livecd-2005.0'
fbsplash: switched splash state to 'on' on console 0
vesafb: framebuffer at 0xd8000000, mapped to 0xd8880000, using 6144k,
total 32768k
fb0: VESA VGA frame buffer device
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (FF) [SLPF]
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: PS2++ Logitech MX Mouse on isa0060/serio1
input: PC Speaker
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE,EPP]
parport0: Printer, EPSON Stylus COLOR 777
lp0: using parport0 (interrupt-driven).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
natsemi dp8381x driver, version 1.07+LK1.0.17, Sep 27, 2002
  originally by Donald Becker <becker@scyld.com>
  http://www.scyld.com/network/natsemi.html
  2.4.x kernel port by Jeff Garzik, Tjeerd Mulder
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI interrupt 0000:00:08.0[A] -> GSI 10 (level, low) -> IRQ 10
natsemi eth0: NatSemi DP8381[56] at 0xefffe000 (0000:00:08.0),
00:02:e3:03:fa:82, IRQ 10, port TP.
PPP generic driver version 2.4.2
8139too Fast Ethernet driver 0.9.27
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 9
PCI: setting IRQ 9 as level-triggered
ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 9 (level, low) -> IRQ 9
eth1: RealTek RTL8139 at 0xd800, 00:40:c7:7e:45:86, IRQ 9
eth1:  Identified 8139 chip type 'RTL-8139C'
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7409: IDE controller at PCI slot 0000:00:07.1
AMD7409: chipset revision 3
AMD7409: not 100% native mode: will probe irqs later
AMD7409: 0000:00:07.1 (rev 03) UDMA66 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: Maxtor 34098H4, ATA DISK drive
hdb: ST3120026A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: BENQ DVD DD DW1620, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 78156288 sectors (40016 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(66)
hda: cache flushes not supported
 hda: hda1 hda2 hda3
hdb: max request size: 1024KiB
hdb: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63,
UDMA(66)
hdb: cache flushes supported
 hdb: hdb1
hdc: ATAPI 40X DVD-ROM DVD-R CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI interrupt 0000:00:07.4[D] -> GSI 10 (level, low) -> IRQ 10
ohci_hcd 0000:00:07.4: Advanced Micro Devices [AMD] AMD-756 [Viper] USB
ohci_hcd 0000:00:07.4: irq 10, pci mem 0xeffff000
ohci_hcd 0000:00:07.4: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:07.4: AMD756 erratum 4 workaround
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usb 1-1: new full speed USB device using ohci_hcd and address 2
hub 1-1:1.0: USB hub found
hub 1-1:1.0: 4 ports detected
usb 1-2: new full speed USB device using ohci_hcd and address 3
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
usb 1-1.1: new full speed USB device using ohci_hcd and address 4
usb 1-1.2: new low speed USB device using ohci_hcd and address 5
usb 1-1.2: khubd timed out on ep0in
drivers/usb/input/hid-core.c: timeout initializing reports

input: USB HID v1.00 Joystick [STD Interact Gaming Device] on
usb-0000:00:07.4-1.2
usb 1-1.4: new full speed USB device using ohci_hcd and address 6
scsi0 : SCSI emulation for USB Mass Storage devices
usbcore: registered new driver usbnet
usb-storage: device found at 6
usb-storage: waiting for device to settle before scanning
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
drivers/usb/serial/usb-serial.c: USB Serial support registered for
Handspring Visor / Palm OS
drivers/usb/serial/usb-serial.c: USB Serial support registered for Sony
Clie 3.5
drivers/usb/serial/usb-serial.c: USB Serial support registered for Sony
Clie 5.0
usbcore: registered new driver visor
drivers/usb/serial/visor.c: USB HandSpring Visor / Palm OS driver v2.1
gameport: pci0000:00:0c.1 speed 1242 kHz
i2c /dev entries driver
Advanced Linux Sound Architecture Driver Version 1.0.8 (Thu Jan 13
09:39:32 2005 UTC).
ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 10 (level, low) -> IRQ 10
ALSA device list:
  #0: Sound Blaster Live! (rev.8, serial:0x80271102) at 0xd600, irq 10
oprofile: using timer interrupt.
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
IPv4 over IPv4 tunneling driver
ip_conntrack version 2.1 (3071 buckets, 24568 max) - 212 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>. 
http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 212k freed
kjournald starting.  Commit interval 5 seconds
  Vendor: eUSB      Model: Compact Flash     Rev:    
  Type:   Direct-Access                      ANSI SCSI revision: 02
Adding 999992k swap on /dev/hda2.  Priority:-1 extents:1
SCSI device sda: 125184 512-byte hdwr sectors (64 MB)
sda: assuming Write Enabled
sda: assuming drive cache: write through
SCSI device sda: 125184 512-byte hdwr sectors (64 MB)
sda: assuming Write Enabled
sda: assuming drive cache: write through
 sda: sda1
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi generic sg0 at scsi0, channel 0, id 0, lun 0,  type 0
usb-storage: device scan complete
EXT3 FS on hda3, internal journal
nvidia: module license 'NVIDIA' taints kernel.
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI interrupt 0000:01:05.0[A] -> GSI 11 (level, low) -> IRQ 11
NVRM: loading NVIDIA Linux x86 NVIDIA Kernel Module  1.0-6629  Wed Nov 
3 13:12:51 PST 2004
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
hdc: CHECK for good STATUS
ACPI: PCI interrupt 0000:00:0d.0[A] -> GSI 9 (level, low) -> IRQ 9
ttySHCF0 at I/O 0xd400 (irq = 9) is a Conexant HCF controllerless PCI
modem (PCI-14f1:1033-1092:0abe)
Linux video capture interface: v1.00
quickcam: QuickCam USB camera found (driver version QuickCam USB $Date:
2004/07/29 18:12:39 $)
quickcam: Kernel:2.6.11-gentoo-r6 bus:1 class:FF subclass:FF vendor:046D
product:0840
quickcam: Sensor PB-0100/0101 detected
quickcam: Registered device: /dev/video0
usbcore: registered new driver quickcam
usb 1-1.2: cat timed out on ep0in
eth0: DSPCFG accepted after 0 usec.
eth0: link up.
eth0: Setting full-duplex based on negotiated link capability.
eth1: link up, 100Mbps, full-duplex, lpa 0x45E1
process `named' is using obsolete setsockopt SO_BSDCOMPAT
usb 1-1.2: epson timed out on ep0in
usb 1-1.2: epson timed out on ep0in
usb 1-1.2: canon timed out on ep0in
usb 1-1.2: canon timed out on ep0in
fbsplash: console 1 using theme 'livecd-2005.0'
fbsplash: switched splash state to 'on' on console 1
fbsplash: console 2 using theme 'livecd-2005.0'
fbsplash: switched splash state to 'on' on console 2
fbsplash: console 3 using theme 'livecd-2005.0'
fbsplash: switched splash state to 'on' on console 3
fbsplash: console 4 using theme 'livecd-2005.0'
fbsplash: switched splash state to 'on' on console 4
fbsplash: console 5 using theme 'livecd-2005.0'
fbsplash: switched splash state to 'on' on console 5
fbsplash: console 6 using theme 'livecd-2005.0'
fbsplash: switched splash state to 'on' on console 6
fbsplash: console 7 using theme 'livecd-2005.0'
fbsplash: switched splash state to 'on' on console 7
fbsplash: console 8 using theme 'livecd-2005.0'
fbsplash: switched splash state to 'on' on console 8
fbsplash: console 9 using theme 'livecd-2005.0'
fbsplash: switched splash state to 'on' on console 9
fbsplash: console 10 using theme 'livecd-2005.0'
fbsplash: switched splash state to 'on' on console 10
fbsplash: switching to verbose mode
agpgart: Found an AGP 1.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 2x mode
agpgart: Putting AGP V2 device at 0000:01:05.0 into 2x mode
agpgart: Found an AGP 1.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 2x mode
agpgart: Putting AGP V2 device at 0000:01:05.0 into 2x mode
quickcam: frame lost
quickcam: frame lost
quickcam: frame lost
quickcam: frame lost
quickcam: frame lost
quickcam: frame lost
quickcam: frame lost
quickcam: frame lost
quickcam: frame lost
quickcam: frame lost
quickcam: frame lost
quickcam: frame lost
quickcam: frame lost
quickcam: frame lost
quickcam: frame lost
quickcam: frame lost
quickcam: frame lost
quickcam: frame lost
quickcam: frame lost
quickcam: frame lost
quickcam: frame lost
quickcam: frame lost
quickcam: frame lost
quickcam: frame lost
quickcam: frame lost
svc: bad direction 268435456, dropping request
usb 1-1.1: USB disconnect, address 4
usb 1-1.2: less timed out on ep0in
usb 1-1.2: less timed out on ep0in
usb 1-1.2: less timed out on ep0in
usb 1-1.2: less timed out on ep0in


This is with usb debugging, and the crash as the second: 

nterrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 12 14 15) *9
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
** PCI interrupts are no longer routed automatically.  If this
** causes a device to stop working, it is probably because the
** driver failed to call pci_enable_device().  As a temporary
** workaround, the "pci=routeirq" argument restores the old
** behavior.  If this argument makes the device work again,
** please email the output of "lspci" to bjorn.helgaas@hp.com
** so I can fix the driver.
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
apm: overridden by ACPI.
inotify device minor=63
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Initializing Cryptographic API
lp: driver loaded but no devices found
Generic RTC Driver v1.07
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected AMD Irongate chipset
agpgart: Maximum main memory to use for agp memory: 262M
agpgart: AGP aperture is 32M @ 0xdc000000
[drm] Initialized drm 1.0.0 20040925
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI interrupt 0000:01:05.0[A] -> GSI 11 (level, low) -> IRQ 11
[drm] Initialized tdfx 1.0.0 20010216 on minor 0: 3Dfx Interactive, Inc.
Voodoo 3
vesafb: unrecognized option pmipa1
vesafb: 3dfx Interactive, Inc., Voodoo3 3500 TV , 210-0371-00X (OEM:
3dfx Interactive, Inc.)
vesafb: VBE version: 3.0
vesafb: protected mode interface info at c000:83ec
vesafb: pmi: set display start = c00c8415, set palette = c00c8444
vesafb: pmi: ports = 3c8 3c9 3d4 3d5 3da
vesafb: hardware supports DCC2 transfers
vesafb: monitor limits: vf = 120 Hz, hf = 70 kHz, clk = 110 MHz
vesafb: scrolling: ywrap using protected mode interface, yres_virtual=1536
Console: switching to colour frame buffer device 128x48
fbsplash: console 0 using theme 'livecd-2005.0'
fbsplash: switched splash state to 'on' on console 0
vesafb: framebuffer at 0xde000000, mapped to 0xd4880000, using 6144k,
total 16384k
fb0: VESA VGA frame buffer device
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (FF) [SLPF]
ACPI: Fan [FAN] (on)
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 2 throttling states)
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
mice: PS/2 mouse device common for all mice
input: AT Translated Set 2 keyboard on isa0060/serio0
input: ImPS/2 Generic Wheel Mouse on isa0060/serio1
input: PC Speaker
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378, irq 7 [PCSPP,TRISTATE]
lp0: using parport0 (interrupt-driven).
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
8139too Fast Ethernet driver 0.9.27
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI interrupt 0000:00:0c.0[A] -> GSI 11 (level, low) -> IRQ 11
eth0: RealTek RTL8139 at 0xec00, 00:e0:4c:c2:b8:6b, IRQ 11
eth0:  Identified 8139 chip type 'RTL-8100B/8139D'
Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
AMD7409: IDE controller at PCI slot 0000:00:07.1
AMD7409: chipset revision 3
AMD7409: not 100% native mode: will probe irqs later
AMD7409: 0000:00:07.1 (rev 03) UDMA66 controller
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: WDC AC310200R, ATA DISK drive
hdb: WDC WD153AA, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: TOSHIBA DVD-ROM SD-R1002, ATAPI CD/DVD-ROM drive
hdd: CD-ROM CDU701, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 20044080 sectors (10262 MB) w/512KiB Cache, CHS=19885/16/63
hda: cache flushes not supported
 hda: hda1 hda2 hda3
hdb: max request size: 128KiB
hdb: 30064608 sectors (15393 MB) w/2048KiB Cache, CHS=29826/16/63, UDMA(66)
hdb: cache flushes not supported
 hdb: hdb1
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
hdd: ATAPI 14X CD-ROM drive, 128kB Cache, DMA
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI interrupt 0000:00:0a.0[A] -> GSI 10 (level, low) -> IRQ 10
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[10] 
MMIO=[e1003000-e10037ff]  Max Packet=[2048]
video1394: Installed video1394 module
ieee1394: raw1394: /dev/raw1394 device initialized
ohci_hcd: 2004 Nov 08 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
ACPI: PCI interrupt 0000:00:07.4[D] -> GSI 10 (level, low) -> IRQ 10
ohci_hcd 0000:00:07.4: Advanced Micro Devices [AMD] AMD-756 [Viper] USB
ohci_hcd 0000:00:07.4: irq 10, pci mem 0xe1000000
ohci_hcd 0000:00:07.4: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:07.4: AMD756 erratum 4 workaround
ohci_hcd 0000:00:07.4: resetting from state 'reset', control = 0x600
ohci_hcd 0000:00:07.4: OHCI controller state
ohci_hcd 0000:00:07.4: OHCI 1.0, with legacy support registers
ohci_hcd 0000:00:07.4: control 0x683 RWE RWC HCFS=operational CBSR=3
ohci_hcd 0000:00:07.4: cmdstatus 0x00000 SOC=0
ohci_hcd 0000:00:07.4: intrstatus 0x00000044 RHSC SF
ohci_hcd 0000:00:07.4: intrenable 0x8000000a MIE RD WDH
ohci_hcd 0000:00:07.4: hcca frame #0003
ohci_hcd 0000:00:07.4: roothub.a 01000204 POTPGT=1 NPS NDP=4
ohci_hcd 0000:00:07.4: roothub.b 00000000 PPCM=0000 DR=0000
ohci_hcd 0000:00:07.4: roothub.status 00008000 DRWE
ohci_hcd 0000:00:07.4: roothub.portstatus [0] 0x00010101 CSC PPS CCS
ohci_hcd 0000:00:07.4: roothub.portstatus [1] 0x00000100 PPS
ohci_hcd 0000:00:07.4: roothub.portstatus [2] 0x00000100 PPS
ohci_hcd 0000:00:07.4: roothub.portstatus [3] 0x00000100 PPS
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: default language 0x0409
usb usb1: Product: Advanced Micro Devices [AMD] AMD-756 [Viper] USB
usb usb1: Manufacturer: Linux 2.6.11-gentoo-r6 ohci_hcd
usb usb1: SerialNumber: 0000:00:07.4
usb usb1: hotplug
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: no power switching (usb 1.0)
hub 1-0:1.0: global over-current protection
hub 1-0:1.0: power on to power good time: 2ms
hub 1-0:1.0: local power source is good
hub 1-0:1.0: no over-current condition exists
hub 1-0:1.0: state 5 ports 4 chg 001e evt 001f
ohci_hcd 0000:00:07.4: GetStatus roothub.portstatus [0] = 0x00010101 CSC
PPS CCS
hub 1-0:1.0: port 1, status 0101, change 0001, 12 Mb/s
ohci_hcd 0000:00:07.4: created debug files
hub 1-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x101
ohci_hcd 0000:00:07.4: GetStatus roothub.portstatus [0] = 0x00100103
PRSC PPS PES CCS
usb 1-1: new full speed USB device using ohci_hcd and address 2
ohci_hcd 0000:00:07.4: GetStatus roothub.portstatus [0] = 0x00100103
PRSC PPS PES CCS
usb 1-1: ep0 maxpacket = 8
usb 1-1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 1-1: default language 0x0409
usb 1-1: Product: Generic Digital camera
usb 1-1: Manufacturer: Sunplus Technology Co., Ltd.
usb 1-1: hotplug
usb 1-1: adding 1-1:1.0 (config #1, interface 0)
usb 1-1:1.0: hotplug
hub 1-0:1.0: port 2, status 0100, change 0000, 12 Mb/s
hub 1-0:1.0: port 3, status 0100, change 0000, 12 Mb/s
hub 1-0:1.0: port 4, status 0100, change 0000, 12 Mb/s
hub 1-0:1.0: state 5 ports 4 chg 0000 evt 0002
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
usbcore: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
drivers/usb/serial/usb-serial.c: USB Serial support registered for
PocketPC PDA
drivers/usb/serial/ipaq.c: USB PocketPC PDA driver v0.5
usbcore: registered new driver ipaq
drivers/usb/serial/usb-serial.c: USB Serial support registered for
Handspring Visor / Palm OS
drivers/usb/serial/usb-serial.c: USB Serial support registered for Sony
Clie 3.5
drivers/usb/serial/usb-serial.c: USB Serial support registered for Sony
Clie 5.0
usbcore: registered new driver visor
drivers/usb/serial/visor.c: USB HandSpring Visor / Palm OS driver v2.1
i2c /dev entries driver
Advanced Linux Sound Architecture Driver Version 1.0.8 (Thu Jan 13
09:39:32 2005 UTC).
ACPI: PCI interrupt 0000:00:08.0[A] -> GSI 11 (level, low) -> IRQ 11
ALSA device list:
  #0: Ensoniq AudioPCI ENS1371 at 0xe400, irq 11
oprofile: using timer interrupt.
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP established hash table entries: 16384 (order: 5, 131072 bytes)
TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
IPv4 over IPv4 tunneling driver
ip_conntrack version 2.1 (2559 buckets, 20472 max) - 212 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>. 
http://snowman.net/projects/ipt_recent/
arp_tables: (C) 2002 David S. Miller
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
ACPI wakeup devices:
PCI0 USB0  ISA
ACPI: (supports S0 S1 S4 S4bios S5)
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 208k freed
kjournald starting.  Commit interval 5 seconds
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0011060000004144]
Adding 305224k swap on /dev/hda2.  Priority:-1 extents:1
EXT3 FS on hda3, internal journal
hub 1-0:1.0: state 5 ports 4 chg 0000 evt 0002
ohci_hcd 0000:00:07.4: GetStatus roothub.portstatus [0] = 0x00030100
PESC CSC PPS
hub 1-0:1.0: port 1, status 0100, change 0003, 12 Mb/s
usb 1-1: USB disconnect, address 2
usb 1-1: usb_disable_device nuking all URBs
usb 1-1: unregistering interface 1-1:1.0
usb 1-1:1.0: hotplug
usb 1-1: unregistering device
usb 1-1: hotplug
hub 1-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x100
hub 1-0:1.0: state 5 ports 4 chg 0000 evt 0002
ohci_hcd 0000:00:07.4: GetStatus roothub.portstatus [0] = 0x00010101 CSC
PPS CCS
hub 1-0:1.0: port 1, status 0101, change 0001, 12 Mb/s
hub 1-0:1.0: debounce: port 1: total 100ms stable 100ms status 0x101
ohci_hcd 0000:00:07.4: GetStatus roothub.portstatus [0] = 0x00100103
PRSC PPS PES CCS
usb 1-1: new full speed USB device using ohci_hcd and address 3
ohci_hcd 0000:00:07.4: GetStatus roothub.portstatus [0] = 0x00100103
PRSC PPS PES CCS
usb 1-1: ep0 maxpacket = 8
usb 1-1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 1-1: default language 0x0409
usb 1-1: Product: Generic Digital camera
usb 1-1: Manufacturer: Sunplus Technology Co., Ltd.
usb 1-1: hotplug
usb 1-1: adding 1-1:1.0 (config #1, interface 0)
usb 1-1:1.0: hotplug
hub 1-0:1.0: state 5 ports 4 chg 0000 evt 0002
spca50x 1-1:1.0: usb_probe_interface
spca50x 1-1:1.0: usb_probe_interface - got id
/var/tmp/portage/spca5xx-20041224/work/spca5xx-20041224/drivers/usb/spca50x.c:
USB SPCA5XX camera found. Type Flexcam 100 (SPCA561A)
/var/tmp/portage/spca5xx-20041224/work/spca5xx-20041224/drivers/usb/spca50x.c:
[spca50x_probe:7780] Camera type GBRG
bttv: driver version 0.9.15 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
ACPI: PCI interrupt 0000:00:09.0[A] -> GSI 11 (level, low) -> IRQ 11
bttv0: Bt878 (rev 17) at 0000:00:09.0, irq: 11, latency: 32, mmio:
0xe1001000
bttv0: detected: Hauppauge WinTV [card=10], PCI subsystem ID is 0070:13eb
bttv0: using: Hauppauge (bt878) [card=10,autodetected]
bttv0: gpio: en=00000000, out=00000000 in=00ffffdb [init]
bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
tveeprom: Hauppauge: model = 44801, rev = D182, serial# = 7229501
tveeprom: tuner = LG TAPC H791F (idx = 82, type = 39)
tveeprom: tuner fmt = NTSC(M) (eeprom = 0x08, v4l2 = 0x00001000)
tveeprom: audio_processor = None (type = 0)
bttv0: using tuner=39
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips:
tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6320,tea6420,tda8425,pic16c54
(PV951),ta8874z
bttv0: i2c: checking for TDA9887 @ 0x86... not found
tuner: chip found at addr 0xc2 i2c-bus bt878 #0 [sw]
tuner: type set to 39 (LG NTSC (newer TAPC series)) by bt878 #0 [sw]
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: PLL: 28636363 => 35468950 .. ok
usbcore: registered new driver spca50x
/var/tmp/portage/spca5xx-20041224/work/spca5xx-20041224/drivers/usb/spca50x.c:
spca5xx driver 0.55 registered
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
eth0: no IPv6 routers present
nfs warning: mount version older than kernel
NFS: NFSv3 not supported.
nfs warning: mount version older than kernel
fbsplash: console 1 using theme 'livecd-2005.0'
fbsplash: switched splash state to 'on' on console 1
fbsplash: console 2 using theme 'livecd-2005.0'
fbsplash: switched splash state to 'on' on console 2
fbsplash: console 3 using theme 'livecd-2005.0'
fbsplash: switched splash state to 'on' on console 3
fbsplash: console 4 using theme 'livecd-2005.0'
fbsplash: switched splash state to 'on' on console 4
fbsplash: console 5 using theme 'livecd-2005.0'
fbsplash: switched splash state to 'on' on console 5
fbsplash: console 6 using theme 'livecd-2005.0'
fbsplash: switched splash state to 'on' on console 6
fbsplash: console 7 using theme 'livecd-2005.0'
fbsplash: switched splash state to 'on' on console 7
fbsplash: console 8 using theme 'livecd-2005.0'
fbsplash: switched splash state to 'on' on console 8
fbsplash: console 9 using theme 'livecd-2005.0'
fbsplash: switched splash state to 'on' on console 9
fbsplash: console 10 using theme 'livecd-2005.0'
fbsplash: switched splash state to 'on' on console 10
fbsplash: console 11 using theme 'livecd-2005.0'
fbsplash: switched splash state to 'on' on console 11
fbsplash: switching to verbose mode
mtrr: 0xde000000,0x2000000 overlaps existing 0xde000000,0x1000000
mtrr: 0xde000000,0x2000000 overlaps existing 0xde000000,0x1000000

The crash:

/var/tmp/portage/spca5xx-20041224/work/spca5xx-20041224/drivers/usb/spca50x.c:
[outpict_do_tasklet:3043] Jpeg dri marker 45
/var/tmp/portage/spca5xx-20041224/work/spca5xx-20041224/drivers/usb/spca50x.c:
[outpict_do_tasklet:3043] Jpeg dri marker 50
/var/tmp/portage/spca5xx-20041224/work/spca5xx-20041224/drivers/usb/spca50x.c:
[outpict_do_tasklet:3043] Jpeg dri marker 45
ohci_hcd 0000:00:07.4: bogus NDP=255, rereads as NDP=4
irq 10: nobody cared!
 [<c01356aa>] __report_bad_irq+0x2a/0x90
 [<c0134fe0>] handle_IRQ_event+0x30/0x70
 [<c013579c>] note_interrupt+0x6c/0xd0
 [<c0135166>] __do_IRQ+0x146/0x160
 [<c0104e03>] do_IRQ+0x23/0x40
 [<c01033ca>] common_interrupt+0x1a/0x20
 [<c011d8b0>] __do_softirq+0x30/0x90
 [<c011d936>] do_softirq+0x26/0x30
 [<c011da05>] irq_exit+0x35/0x40
 [<c0104e08>] do_IRQ+0x28/0x40
 [<c01033ca>] common_interrupt+0x1a/0x20
 [<c02bc242>] acpi_processor_idle+0x123/0x260
 [<c01010d8>] cpu_idle+0x48/0x60
 [<c05ba75f>] start_kernel+0x16f/0x1b0
 [<c05ba330>] unknown_bootoption+0x0/0x1b0
handlers:
[<c0335650>] (ohci_irq_handler+0x0/0x7a0)
[<c034db70>] (usb_hcd_irq+0x0/0x70)
Disabling IRQ #10
