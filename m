Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbWFSSHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWFSSHB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 14:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWFSSHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 14:07:01 -0400
Received: from web52908.mail.yahoo.com ([206.190.49.18]:50338 "HELO
	web52908.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751268AbWFSSG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 14:06:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=T3r7cn8ZfSBA+i2zSxkWhWZ0kdKc4ofhKzN7TSmnJ5Q8JgdnMPrgffUMjueHqGGSCDm0cta3UGLX65TLlwVxya6VOLR85smce9yoJCKsLCOdWbqXNigEGRpaE3VatjS53dNojHOWReRd535WOuOQGmsZX+2MVi/xGN65IOeKHRQ=  ;
Message-ID: <20060619180658.58945.qmail@web52908.mail.yahoo.com>
Date: Mon, 19 Jun 2006 19:06:58 +0100 (BST)
From: Chris Rankin <rankincj@yahoo.com>
Subject: Linux 2.6.17: IRQ handler mismatch in serial code?
To: linux-kernel@vger.kernel.org
Cc: linux-serial@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have just booted Linux 2.6.17 on an old 350 MHz PII, and have discovered this message in the
boot log:

setup_irq: irq handler mismatch
 <c0131a86> setup_irq+0x10d/0x11a  <c01f3889> serial8250_interrupt+0x0/0x107
 <c0131b00> request_irq+0x6d/0x89  <c01f34ba> serial8250_startup+0x2d6/0x42b
 <c01f01e1> uart_startup+0x64/0x121  <c01f0401> uart_open+0x163/0x3a2
 <c01e214f> tty_open+0x175/0x2bc  <c0152fb1> chrdev_open+0x160/0x17c
 <c0152e51> chrdev_open+0x0/0x17c  <c014b093> __dentry_open+0xe0/0x1cf
 <c014b1e6> nameidata_to_filp+0x19/0x28  <c014b220> do_filp_open+0x2b/0x31
 <c014b30c> do_sys_open+0x3c/0xa9  <c014b3a6> sys_open+0x16/0x18
 <c0102adb> syscall_call+0x7/0xb 

Here is the full boot-log, to put this in context:

Linux version 2.6.17 (chris@hypercube.homenet) (gcc version 4.0.2 20051125 (Red Hat 4.0.2-8)) #1
PREEMPT Mon Jun 19 17:19:42 BST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e7000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000017ffdc00 (usable)
 BIOS-e820: 0000000017ffdc00 - 0000000017fffc00 (ACPI data)
 BIOS-e820: 0000000017fffc00 - 0000000018000000 (ACPI NVS)
 BIOS-e820: 00000000fffe7000 - 0000000100000000 (reserved)
383MB LOWMEM available.
On node 0 totalpages: 98301
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 94205 pages, LIFO batch:31
DMI 2.1 present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f6ad0
ACPI: RSDT (v001 PTLTD    RSDT   0x00000001 PTL  0x01000000) @ 0x17ffdd69
ACPI: FADT (v001 INTEL  SEATTLE2 0x20000817 PTL  0x000f4240) @ 0x17fffb8c
ACPI: DSDT (v001  Intel  S2440BX 0x00000001 MSFT 0x01000004) @ 0x00000000
ACPI: PM-Timer IO Port: 0x8008
Allocating PCI resources starting at 20000000 (gap: 18000000:e7fe7000)
Built 1 zonelists
Kernel command line: ro root=LABEL=/ lapic video=matroxfb:vesa:0x117 nmi_watchdog=1 clock=tsc
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
mapped APIC to ffffd000 (fee00000)
Enabling fast FPU save and restore... done.
Initializing CPU#0
CPU 0 irqstacks, hard=c032d000 soft=c032e000
PID hash table entries: 2048 (order: 11, 8192 bytes)
Detected 349.232 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 385564k/393204k available (1494k kernel code, 7076k reserved, 550k data, 156k init, 0k
highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 699.62 BogoMIPS (lpj=1399255)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0183fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0183fbff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After all inits, caps: 0183fbff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium II (Deschutes) stepping 02
Checking 'hlt' instruction... OK.
SMP alternatives: switching to UP code
Freeing SMP alternatives: 0k freed
ACPI: setting ELCR to 0200 (from 0e20)
checking if image is initramfs... it is
Freeing initrd memory: 1062k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd9b4, last bus=1
Setting up standard PCI resources
ACPI: Subsystem revision 20060127
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI quirk: region 8000-803f claimed by PIIX4 ACPI
PCI quirk: region 7000-700f claimed by PIIX4 SMB
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 9 10 *11 12)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 7 9 10 11 12)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 9 *10 11 12)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 *9 10 11 12)
ACPI: Power Resource [PFAN] (on)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 12 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
TC classifier action (bugs to netdev@vger.kernel.org cc hadi@cyberus.ca)
pnp: 00:01: ioport range 0x7000-0x700f has been reserved
pnp: 00:01: ioport range 0x8000-0x803f could not be reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: f4100000-f4ffffff
  PREFETCH window: fc000000-fdffffff
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
audit: initializing netlink socket (disabled)
audit(1150736964.248:1): initialized
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler deadline registered (default)
io scheduler cfq registered
Limiting direct PCI/PCI transfers.
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
matroxfb: Matrox G400 (AGP) detected
PInS memtype = 3
matroxfb: MTRR's turned on
matroxfb: 1024x768x16bpp (virtual: 1024x8192)
matroxfb: framebuffer at 0xFC000000, mapped to 0xd8880000, size 33554432
Console: switching to colour frame buffer device 128x48
fb0: MATROX frame buffer device
matroxfb_crtc2: secondary head of fb0 was registered as fb1
ACPI: Fan [FAN1] (on)
ACPI: CPU0 (power states: C1[C1] C2[C2])
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.12ac
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
pnp: Device 00:07 activated.
00:07: ttyS2 at I/O 0x3e8 (irq = 4) is a 16550A
pnp: Device 00:08 activated.
00:08: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 16384K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1060-0x1067, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x1068-0x106f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: QUANTUM FIREBALL EL7.6A, ATA DISK drive
hdb: ExcelStor Technology J680, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: Pioneer DVD-ROM ATAPIModel DVD-106S 012, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 15032115 sectors (7696 MB) w/418KiB Cache, CHS=15907/15/63, UDMA(33)
hda: cache flushes not supported
 hda: hda1
hdb: max request size: 512KiB
hdb: 160836480 sectors (82348 MB) w/1794KiB Cache, CHS=16383/255/63, UDMA(33)
hdb: cache flushes supported
 hdb: hdb1 hdb2 hdb3 hdb4 < hdb5 hdb6 >
PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:MICE] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Testing NMI watchdog ... OK.
Using IPI Shortcut mode
ACPI wakeup devices: 
PCI0 USB0 UAR1 UAR2  KBC MICE 
ACPI: (supports S0 S1 S5)
Freeing unused kernel memory: 156k freed
input: AT Translated Set 2 keyboard as /class/input/input0
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
input: ImExPS/2 Generic Explorer Mouse as /class/input/input1
hdc: ATAPI 40X DVD-ROM drive, 256kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
Driver for 1-wire Dallas network protocol.
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
ne.c:v1.10 9/23/94 Donald Becker (becker@scyld.com)
Last modified Nov 1, 2000 by Paul Gortmaker
NE*000 ethercard probe at 0x300: 00 c0 f0 44 02 eb
eth%d: NE2000 found at 0x300, using IRQ 3.
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:0f.0[A] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
usbcore: registered new driver snd-usb-audio
piix4_smbus 0000:00:07.3: Found 0000:00:07.3 device
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected an Intel 440BX Chipset.
agpgart: AGP aperture is 64M @ 0xf8000000
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 9
PCI: setting IRQ 9 as level-triggered
ACPI: PCI Interrupt 0000:00:0e.2[C] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
ehci_hcd 0000:00:0e.2: EHCI Host Controller
ehci_hcd 0000:00:0e.2: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:0e.2: irq 9, io mem 0xf4002000
ehci_hcd 0000:00:0e.2: USB 2.0 started, EHCI 0.95, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 5 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:0e.0[A] -> Link [LNKB] -> GSI 5 (level, low) -> IRQ 5
ohci_hcd 0000:00:0e.0: OHCI Host Controller
ohci_hcd 0000:00:0e.0: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:0e.0: irq 5, io mem 0xf4000000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
ACPI: PCI Interrupt 0000:00:0e.1[B] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
ohci_hcd 0000:00:0e.1: OHCI Host Controller
ohci_hcd 0000:00:0e.1: new USB bus registered, assigned bus number 3
ohci_hcd 0000:00:0e.1: irq 10, io mem 0xf4001000
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:07.2[D] -> Link [LNKD] -> GSI 9 (level, low) -> IRQ 9
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:07.2: irq 9, io base 0x00001040
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 4-1: new full speed USB device using uhci_hcd and address 2
usb 4-1: configuration #1 chosen from 1 choice
ACPI: Power Button (FF) [PWRF]
Linux video capture interface: v1.00
pwc Philips webcam module version 9.0.2-unofficial loaded.
pwc Supports Philips PCA645/646, PCVC675/680/690, PCVC720[40]/730/740/750 & PCVC830/840.
pwc Also supports the Askey VC010, various Logitech Quickcams, Samsung MPC-C10 and MPC-C30,
pwc the Creative WebCam 5 & Pro Ex, SOTEC Afina Eye and Visionite VCS-UC300 and VCS-UM100.
pwc Logitech QuickCam Zoom USB webcam detected.
pwc Registered as /dev/video0.
usbcore: registered new driver Philips webcam
device-mapper: 4.6.0-ioctl (2006-02-17) initialised: dm-devel@redhat.com
EXT3 FS on hdb2, internal journal
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Adding 1020116k swap on /dev/hdb3.  Priority:-1 extents:1 across:1020116k
ip_tables: (C) 2000-2006 Netfilter Core Team
Netfilter messages via NETLINK v0.30.
ip_conntrack version 2.4 (3071 buckets, 24568 max) - 220 bytes per conntrack
NET: Registered protocol family 10
lo: Disabled Privacy Extensions
IPv6 over IPv4 tunneling driver
audit(1150737028.384:2): audit_pid=1891 old=0 by auid=4294967295
i2c_adapter i2c-0: found ADM9240 revision 2
adm9240 0-002d: Using VRM: 8.2
adm9240 0-002d: cold start: config was 0x08 mode 1
parport: PnPBIOS parport detected.
parport0: PC-style at 0x378 (0x778), irq 7, dma 3 [PCSPP,TRISTATE,COMPAT,ECP,DMA]
parport0: Printer, Hewlett-Packard OfficeJet Series 700
lp0: using parport0 (interrupt-driven).
lp0: ECP mode
setup_irq: irq handler mismatch
 <c0131a86> setup_irq+0x10d/0x11a  <c01f3889> serial8250_interrupt+0x0/0x107
 <c0131b00> request_irq+0x6d/0x89  <c01f34ba> serial8250_startup+0x2d6/0x42b
 <c01f01e1> uart_startup+0x64/0x121  <c01f0401> uart_open+0x163/0x3a2
 <c01e214f> tty_open+0x175/0x2bc  <c0152fb1> chrdev_open+0x160/0x17c
 <c0152e51> chrdev_open+0x0/0x17c  <c014b093> __dentry_open+0xe0/0x1cf
 <c014b1e6> nameidata_to_filp+0x19/0x28  <c014b220> do_filp_open+0x2b/0x31
 <c014b30c> do_sys_open+0x3c/0xa9  <c014b3a6> sys_open+0x16/0x18
 <c0102adb> syscall_call+0x7/0xb 
eth0: no IPv6 routers present
input: PC Speaker as /class/input/input2
pwc Deregistering driver.
usbcore: deregistering driver Philips webcam
pwc Philips webcam module removed.
pwc: Philips webcam module version 10.0.12-rc1 loaded.
pwc: Supports Philips PCA645/646, PCVC675/680/690, PCVC720[40]/730/740/750 & PCVC830/840.
pwc: Also supports the Askey VC010, various Logitech Quickcams, Samsung MPC-C10 and MPC-C30,
pwc: the Creative WebCam 5 & Pro Ex, SOTEC Afina Eye and Visionite VCS-UC300 and VCS-UM100.
pwc: Logitech QuickCam Zoom USB webcam detected.
pwc: Registered as /dev/video0.
usbcore: registered new driver Philips webcam
u32 classifier
    Actions configured 
[drm] Initialized drm 1.0.1 20051102
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
[drm] Initialized mga 3.2.2 20060319 on minor 0: 
[drm] Used old pci detect: framebuffer loaded
agpgart: Found an AGP 1.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 2x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 2x mode
ISO 9660 Extensions: Microsoft Joliet Level 3
ISOFS: changing to secondary root

And this is what /proc/interrupts has to say:

$ cat /proc/interrupts
           CPU0
  0:     826224          XT-PIC  timer
  1:       2446          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  3:       5189          XT-PIC  NE2000
  5:          0          XT-PIC  ohci_hcd:usb2
  7:          1          XT-PIC  parport0
  8:          1          XT-PIC  rtc
  9:        153          XT-PIC  acpi, ehci_hcd:usb1, uhci_hcd:usb4
 10:        132          XT-PIC  Ensoniq AudioPCI, ohci_hcd:usb3
 11:     192707          XT-PIC  mga@pci:0000:01:00.0
 12:      32048          XT-PIC  i8042
 14:      18574          XT-PIC  ide0
 15:       6705          XT-PIC  ide1
NMI:        889
LOC:     826247
ERR:          0
MIS:          0

Cheers,
Chris



		
___________________________________________________________ 
Try the all-new Yahoo! Mail. "The New Version is radically easier to use" – The Wall Street Journal 
http://uk.docs.yahoo.com/nowyoucan.html
