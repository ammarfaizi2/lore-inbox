Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263345AbTK1S0s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 13:26:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263357AbTK1S0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 13:26:48 -0500
Received: from fed1mtao04.cox.net ([68.6.19.241]:17131 "EHLO
	fed1mtao04.cox.net") by vger.kernel.org with ESMTP id S263345AbTK1S0h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 13:26:37 -0500
Date: Fri, 28 Nov 2003 11:26:25 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>, henning@meier-geinitz.de,
       greg@kroah.com
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-usb-users@lists.sourceforge.net
Subject: USB scanner issue (Was: Re: Beaver in Detox!)
Message-ID: <20031128182625.GP2541@stop.crashing.org>
References: <Pine.LNX.4.58.0311261239510.1524@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0311261239510.1524@home.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 26, 2003 at 12:55:00PM -0800, Linus Torvalds wrote:

[snip]
> I give you "Beaver in Detox", aka linux-2.6.0-test11. This is mainly
> brought on by the fact that the old aic7xxx driver was broken in -test10,
> and Ingo found this really evil test program that showed an error case in
> do_fork() that we had never handled right. Well, duh!

I've found an odd problem that's in at least 2.6.0-test11.  I've
reproduced this twice now with an Epson 1240 USB scanner
(0x04b8/0x010b).  What happens is if I run xsane from gimp, acquire a
preview, start to scan and then cancel, the scanner becomes
unresponsive.  If I try and quit xsane, it gets stuck.  Unplugging /
replugging and then trying to kill xsane locked the machine up hard.

Here's ver_linux, dmesg and the versions of gimp/xsane I'm running (I've
used the scanner during this boot, without trying to lock it up):

---
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux Bill-The-Cat 2.6.0-test11 #1 Wed Nov 26 15:09:13 MST 2003 i686 GNU/Linux
 
Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      0.9.15-pre3
e2fsprogs              1.35-WIP
nfs-utils              1.0.6
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.14
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0
Modules Loaded         mousedev hid scanner snd_usb_audio nfsd exportfs lockd sunrpc snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_intel8x0 snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore sis900 crc32 af_packet ohci_hcd usbcore rtc

---

Linux version 2.6.0-test11 (root@Bill-The-Cat) (gcc version 3.3.2 (Debian)) #1 Wed Nov 26 15:09:13 MST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000ee000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fff0000 (usable)
 BIOS-e820: 000000001fff0000 - 000000001fff8000 (ACPI data)
 BIOS-e820: 000000001fff8000 - 0000000020000000 (ACPI NVS)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffee0000 - 00000000fff00000 (reserved)
 BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
511MB LOWMEM available.
On node 0 totalpages: 131056
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 126960 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 AMI                                       ) @ 0x000fa340
ACPI: RSDT (v001 AMIINT SiS735XX 0x00001000 MSFT 0x0100000b) @ 0x1fff0000
ACPI: FADT (v001 AMIINT SiS735XX 0x00001000 MSFT 0x0100000b) @ 0x1fff0030
ACPI: DSDT (v001    SiS      735 0x00000100 MSFT 0x0100000d) @ 0x00000000
Building zonelist for node : 0
Kernel command line: root=/dev/hda1 ro video=1280x1024-8@85 hdc=scsi hdd=scsi
ide_setup: hdc=scsi
ide_setup: hdd=scsi
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1526.853 MHz processor.
Console: colour dummy device 80x25
Memory: 515884k/524224k available (1451k kernel code, 7592k reserved, 641k data, 136k init, 0k highmem)
Calibrating delay loop... 3022.84 BogoMIPS
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0183fbff c1c3fbff 00000000 00000000
CPU:     After vendor identify, caps: 0183fbff c1c3fbff 00000000 00000000
Enabling disabled K7/SSE Support.
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1c3fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Athlon(tm) XP 1800+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 1526.0579 MHz.
..... host bus clock speed is 265.0492 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfdb01, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
ACPI: IRQ 9 was Edge Triggered, setting to Level Triggerd
spurious 8259A interrupt: IRQ7.
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: Power Resource [URP1] (off)
ACPI: Power Resource [URP2] (off)
ACPI: Power Resource [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 12
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
matroxfb: Matrox G450 detected
matroxfb: MTRR's turned on
matroxfb: 1280x1024x8bpp (virtual: 1280x65536)
matroxfb: framebuffer at 0xCC000000, mapped to 0xe080c000, size 33554432
fb0: MATROX frame buffer device
fb0: initializing hardware
ikconfig 0.7 with /proc/config*
ACPI: Processor [CPU1] (supports C1)
Console: switching to colour frame buffer device 160x64
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS735 ATA 100 (2nd gen) controller
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD1200JB-00DUA3, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: ASUS DRW-0402P/D, ATAPI CD/DVD-ROM drive
hdd: MATSHITADVD-ROM SR-8583, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 1024KiB
hda: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
Console: switching to colour frame buffer device 160x64
matroxfb_crtc2: secondary head of fb0 was registered as fb1
NET: Registered protocol family 2
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET: Registered protocol family 1
BIOS EDD facility v0.10 2003-Oct-11, 1 devices found
Please report your BIOS at http://domsch.com/linux/edd30/results.html
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 136k freed
Adding 498004k swap on /dev/hda3.  Priority:-1 extents:1
EXT3 FS on hda1, internal journal
Real Time Clock Driver v1.12
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
ohci_hcd 0000:00:02.2: OHCI Host Controller
ohci_hcd 0000:00:02.2: irq 12, pci mem e2856000
ohci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ohci_hcd 0000:00:02.3: OHCI Host Controller
ohci_hcd 0000:00:02.3: irq 5, pci mem e2858000
ohci_hcd 0000:00:02.3: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
hub 2-0:1.0: new USB device on port 2, assigned address 2
hub 2-2:1.0: USB hub found
hub 2-2:1.0: 4 ports detected
NET: Registered protocol family 17
sis900.c: v1.08.06 9/24/2002
eth0: Realtek RTL8201 PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0xd400, IRQ 11, 00:0a:e6:14:a9:a5.
hub 2-2:1.0: new USB device on port 1, assigned address 3
hub 2-2.1:1.0: USB hub found
hub 2-2.1:1.0: 3 ports detected
hub 2-2:1.0: new USB device on port 2, assigned address 4
hub 2-2:1.0: new USB device on port 3, assigned address 5
hub 2-2:1.0: new USB device on port 4, assigned address 6
hub 2-2.1:1.0: new USB device on port 1, assigned address 7
eth0: Media Link On 100mbps full-duplex 
eth0: Media Link On 100mbps full-duplex 
intel8x0: clocking to 48000
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
drivers/usb/core/usb.c: registered new driver snd-usb-audio
drivers/usb/image/scanner.c: USB scanner device (0x04b8/0x010b) now attached to usb/scanner0
drivers/usb/core/usb.c: registered new driver usbscanner
drivers/usb/image/scanner.c: 0.4.15:USB Scanner Driver
input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse® Optical] on usb-0000:00:02.3-2.4
drivers/usb/input/hid-core.c: ctrl urb status -2 received
drivers/usb/input/hid-core.c: timeout initializing reports

input: USB HID v1.10 Keyboard [Mitsumi Electric Apple Extended USB Keyboard] on usb-0000:00:02.3-2.1.1
input: USB HID v1.10 Device [Mitsumi Electric Apple Extended USB Keyboard] on usb-0000:00:02.3-2.1.1
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
[drm:drm_init] *ERROR* Cannot initialize the agpgart module.
usb 2-2: USB disconnect, address 2
usb 2-2.1: USB disconnect, address 3
usb 2-2.1.1: USB disconnect, address 7
usb 2-2.2: USB disconnect, address 4
usb 2-2.3: USB disconnect, address 5
usb 2-2.4: USB disconnect, address 6
hub 2-0:1.0: new USB device on port 2, assigned address 8
hub 2-2:1.0: USB hub found
hub 2-2:1.0: 4 ports detected
hub 2-2:1.0: new USB device on port 1, assigned address 9
hub 2-2.1:1.0: USB hub found
hub 2-2.1:1.0: 3 ports detected
hub 2-2:1.0: new USB device on port 2, assigned address 10
hub 2-2:1.0: new USB device on port 3, assigned address 11
drivers/usb/image/scanner.c: USB scanner device (0x04b8/0x010b) now attached to usb/scanner0
hub 2-2:1.0: new USB device on port 4, assigned address 12
input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse® Optical] on usb-0000:00:02.3-2.4
hub 2-2.1:1.0: new USB device on port 1, assigned address 13
drivers/usb/input/hid-core.c: ctrl urb status -2 received
drivers/usb/input/hid-core.c: timeout initializing reports

input: USB HID v1.10 Keyboard [Mitsumi Electric Apple Extended USB Keyboard] on usb-0000:00:02.3-2.1.1
input: USB HID v1.10 Device [Mitsumi Electric Apple Extended USB Keyboard] on usb-0000:00:02.3-2.1.1
usb 2-2: USB disconnect, address 8
usb 2-2.1: USB disconnect, address 9
usb 2-2.1.1: USB disconnect, address 13
usb 2-2.2: USB disconnect, address 10
usb 2-2.3: USB disconnect, address 11
usb 2-2.4: USB disconnect, address 12

--

ii  gimp1.2        1.2.3-2.4      The GNU Image Manipulation Program, stable ver
ii  gimpprint-loca 4.2.5-6        Locale data files for Gimp-Print              
ii  libgimp1.2     1.2.3-2.4      Libraries necessary to run the GIMP, version 1
ii  libgimpprint1  4.2.5-6        The Gimp-Print printer driver library         
ii  xsane          0.91-6         A gtk-based X11 frontend for SANE (Scanner Acc

-- 
Tom Rini
http://gate.crashing.org/~trini/
