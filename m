Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265218AbUAPCvr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 21:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265221AbUAPCvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 21:51:47 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:5189 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S265218AbUAPCvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 21:51:38 -0500
Message-ID: <400751B1.40608@kriminell.com>
Date: Fri, 16 Jan 2004 03:51:29 +0100
From: marcel cotta <marcel@kriminell.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.1: kernel BUG at mm/swapfile.c:806
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

i got this oops after the box swapped like crazy under X for about 5 
minutes
while swapping it was nearly unusable (jerky mouse, console switching 
took 10 seconds)
the extreme performance drop is always reproducible when swapping starts


------------[ cut here ]------------
kernel BUG at mm/swapfile.c:806!
invalid operand: 0000 [#1]
CPU:    0
EIP:    0060:[<c014c5a4>]    Not tainted
EFLAGS: 00013246
EIP is at map_swap_page+0x34/0x50
eax: c729c900   ebx: 00000f72   ecx: 00000f76   edx: c729c900
esi: c0534dcc   edi: c729c900   ebp: c0534dc0   esp: ca33fbcc
ds: 007b   es: 007b   ss: 0068
Process XFree86 (pid: 2389, threadinfo=ca33e000 task=ca50ec80)
Stack: 00000f72 c0534dc0 c3942680 c10808e0 c014aad2 c0534dc0 00000f72 
c10808e0
        c10808e0 00000000 ca33e000 c014ac0d 00000010 c10808e0 c014ab30 
ca33e000
        c10808e0 ca33fc5c c013f7b9 c10808e0 ca33fc3c 00003087 ca33e000 
00000000
Call Trace:
  [<c014aad2>] get_swap_bio+0x52/0xb0
  [<c014ac0d>] swap_writepage+0x3d/0xd0
  [<c014ab30>] end_swap_bio_write+0x0/0x50
  [<c013f7b9>] shrink_list+0x349/0x550
  [<c013e7c8>] __pagevec_release+0x28/0x40
  [<c013fb45>] shrink_cache+0x185/0x300
  [<c014032c>] shrink_caches+0xac/0xd0
  [<c01403f2>] try_to_free_pages+0xa2/0x160
  [<c0139c61>] __alloc_pages+0x1d1/0x320
  [<c01432cc>] do_anonymous_page+0x7c/0x1e0
  [<c0143491>] do_no_page+0x61/0x310
  [<c0143934>] handle_mm_fault+0xd4/0x170
  [<c011801c>] do_page_fault+0x32c/0x50c
  [<c0125246>] update_process_times+0x46/0x60
  [<c01250ab>] update_wall_time+0xb/0x40
  [<c012551f>] do_timer+0xdf/0xf0
  [<c010b0ad>] do_IRQ+0xfd/0x130
  [<c0117cf0>] do_page_fault+0x0/0x50c
  [<c0109531>] error_code+0x2d/0x38

Code: 0f 0b 26 03 10 78 44 c0 eb d6 8b 40 04 eb e8 29 cb 03 5a 10
  <4>mtrr: 0xe0000000,0x4000000 overlaps existing 0xe0000000,0x1000000


-------------------------
ksymoops
-------------------------

 >>eax; c729c900 <acqseq_lock.5+6d25108/3fa86808>
 >>edx; c729c900 <acqseq_lock.5+6d25108/3fa86808>
 >>esi; c0534dcc <swap_info+24c/900>
 >>edi; c729c900 <acqseq_lock.5+6d25108/3fa86808>
 >>ebp; c0534dc0 <swap_info+240/900>
 >>esp; ca33fbcc <acqseq_lock.5+9dc83d4/3fa86808>


Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
    0:   0f 0b                     ud2a
Code;  00000002 Before first symbol
    2:   26 03 10                  add    %es:(%eax),%edx
Code;  00000005 Before first symbol
    5:   78 44                     js     4b <_EIP+0x4b>
Code;  00000007 Before first symbol
    7:   c0 eb d6                  shr    $0xd6,%bl
Code;  0000000a Before first symbol
    a:   8b 40 04                  mov    0x4(%eax),%eax
Code;  0000000d Before first symbol
    d:   eb e8                     jmp    fffffff7 <_EIP+0xfffffff7>
Code;  0000000f Before first symbol
    f:   29 cb                     sub    %ecx,%ebx
Code;  00000011 Before first symbol
   11:   03 5a 10                  add    0x10(%edx),%ebx



-------------------------
dmesg
-------------------------

Linux version 2.6.1 (root@hades) (gcc version 3.3.3 20040110 
(prerelease) (Debian)) #19 Tue Jan 13 07:30:08 CET 2004
BIOS-provided physical RAM map:
  BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
  BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
  BIOS-e820: 00000000000d0000 - 0000000000100000 (reserved)
  BIOS-e820: 0000000000100000 - 000000000bef0000 (usable)
  BIOS-e820: 000000000bef0000 - 000000000beff000 (ACPI data)
  BIOS-e820: 000000000beff000 - 000000000bf00000 (ACPI NVS)
  BIOS-e820: 000000000bf00000 - 000000000c000000 (reserved)
  BIOS-e820: 00000000fffc0000 - 0000000100000000 (reserved)
190MB LOWMEM available.
On node 0 totalpages: 48880
   DMA zone: 4096 pages, LIFO batch:1
   Normal zone: 44784 pages, LIFO batch:10
   HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 PTLTD                                     ) @ 0x000f7290
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x0bef8cca
ACPI: FADT (v001 ATI    Raptor   0x06040000 ATI  0x000f4240) @ 0x0befee2b
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x0befee9f
ACPI: SSDT (v001 PTLTD  POWERNOW 0x06040000  LTP 0x00000001) @ 0x0befeec7
ACPI: DSDT (v001    ATI U1_M1535 0x06040000 MSFT 0x0100000d) @ 0x00000000
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=Linux ro root=303 nmi_watchdog=1 
splash=silent pci=noacpi pci=usepirqmask
bootsplash: silent mode.
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 1788.828 MHz processor.
Using tsc for high-res timesource
Console: colour dummy device 80x25
Memory: 188300k/195520k available (3257k kernel code, 6600k reserved, 
822k data, 156k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor 
mode... Ok.
Calibrating delay loop... 3538.94 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
checking if image is initramfs...it isn't (ungzip failed); looks like 
an initrd
Freeing initrd memory: 33k freed
CPU:     After generic identify, caps: 0383f9ff c1cbf9ff 00000000 00000000
CPU:     After vendor identify, caps: 0383f9ff c1cbf9ff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 512K (64 bytes/line)
CPU:     After all inits, caps: 0383f9ff c1cbf9ff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD mobile AMD Athlon(tm) XP2400+ stepping 00
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfd87b, last bus=2
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.AGPB._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 6 *10)
ACPI: PCI Interrupt Link [LNKB] (IRQs 7 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 10)
ACPI: PCI Interrupt Link [LNKD] (IRQs 10)
ACPI: PCI Interrupt Link [LNKE] (IRQs 10)
ACPI: PCI Interrupt Link [LNKF] (IRQs *11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 10)
ACPI: PCI Interrupt Link [LNKH] (IRQs *5 7)
ACPI: PCI Interrupt Link [LNKU] (IRQs 3)
ACPI: Embedded Controller [EC0] (gpe 24)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00f72c0
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xa0ef, dseg 0x400
pnp: 00:00: ioport range 0x370-0x371 has been reserved
pnp: 00:0b: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:0b: ioport range 0x40b-0x40b has been reserved
pnp: 00:0b: ioport range 0x480-0x48f has been reserved
pnp: 00:0b: ioport range 0x4d6-0x4d6 has been reserved
pnp: 00:0b: ioport range 0x8000-0x803f has been reserved
pnp: 00:0b: ioport range 0x8040-0x807f could not be reserved
PnPBIOS: 18 nodes reported by PnP BIOS; 18 recorded by driver
SCSI subsystem initialized
Linux Kernel Card Services
   options:  [pci] [cardbus] [pm]
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Using IRQ router ALI [10b9/1533] at 0000:00:07.0
vesafb: framebuffer at 0xe0000000, mapped to 0xcc80e000, size 16384k
vesafb: mode is 1024x768x16, linelength=2048, pages=41
vesafb: protected mode interface info at c000:51a9
vesafb: scrolling: redraw
vesafb: directcolor: size=0:5:6:5, shift=0:11:5:0
fb0: VESA VGA frame buffer device
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x80
Machine check exception polling timer started.
powernow: AMD K7 CPU detected.
powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
powernow: Found PSB header at c00f15e0
powernow: Table version: 0x12
powernow: Flags: 0x0 (Mobile voltage regulator)
powernow: Settling Time: 100 microseconds.
powernow: Has 14 PST tables. (Only dumping ones relevant to this CPU).
powernow: PST:12 (@c00f16cc)
powernow:  cpuid: 0x781 fsb: 133        maxFID: 0x15    startvid: 0xb
powernow:    FID: 0x12 (4.0x [532MHz])  VID: 0x13 (1.200V)
powernow:    FID: 0x4 (5.0x [665MHz])   VID: 0x13 (1.200V)
powernow:    FID: 0x6 (6.0x [798MHz])   VID: 0x13 (1.200V)
powernow:    FID: 0x8 (7.0x [931MHz])   VID: 0x13 (1.200V)
powernow:    FID: 0xe (10.0x [1330MHz]) VID: 0xe (1.300V)
powernow:    FID: 0x15 (13.5x [1795MHz])        VID: 0xb (1.450V)

powernow: Minimum speed 532 MHz. Maximum speed 1795 MHz.
SGI XFS for Linux with no debug enabled
Initializing Cryptographic API
ATI Northbridge, reserving I/O ports 0x3b0 to 0x3bb.
ACPI: AC Adapter [ACAD] (on-line)
ACPI: Battery Slot [BAT1] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Processor [CPU0] (supports C1 C2)
ACPI: Thermal Zone [THRM] (41 C)
bootsplash 3.1.3-2003/11/14: looking for picture.... silentjpeg size 
14336 bytes, found (1024x768, 19600 bytes, v3).
Console: switching to colour frame buffer device 128x48
pty: 256 Unix98 ptys configured
HDLC line discipline: version $Revision: 4.8 $, maxframe=4096
N_HDLC line discipline registered.
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Software Watchdog Timer: 0.06, soft_margin: 60 sec, nowayout: 0
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected Ati IGP320/M chipset
agpgart: Maximum main memory to use for agp memory: 148M
agpgart: AGP aperture is 64M @ 0xd4000000
[drm] Initialized radeon 1.9.0 20020828 on minor 0
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
PCI: Found IRQ 3 for device 0000:00:08.0
ttyS1 at I/O 0x8828 (irq = 3) is a 8250
ttyS2 at I/O 0x8840 (irq = 3) is a 8250
ttyS3 at I/O 0x8850 (irq = 3) is a 8250
ttyS4 at I/O 0x8860 (irq = 3) is a 8250
ttyS5 at I/O 0x8870 (irq = 3) is a 8250
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
loop: loaded (max 8 devices)
natsemi dp8381x driver, version 1.07+LK1.0.17, Sep 27, 2002
   originally by Donald Becker <becker@scyld.com>
   http://www.scyld.com/network/natsemi.html
   2.4.x kernel port by Jeff Garzik, Tjeerd Mulder
PCI: Found IRQ 11 for device 0000:00:12.0
eth0: NatSemi DP8381[56] at 0xcd845000, 00:0d:9d:5a:5f:35, IRQ 11.
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
NET: Registered protocol family 24
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
Warning: ATI Radeon IGP Northbridge is not yet fully tested.
ALI15X3: IDE controller at PCI slot 0000:00:10.0
ALI15X3: chipset revision 196
ALI15X3: not 100% native mode: will probe irqs later
     ide0: BM-DMA at 0x8080-0x8087, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0x8088-0x808f, BIOS settings: hdc:DMA, hdd:pio
hda: FUJITSU MHS2030AT, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: DW-224E, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 58605120 sectors (30005 MB) w/2048KiB Cache, CHS=58140/16/63, 
UDMA(100)
  hda: hda1 hda2 hda3 hda4
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 1658kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
st: Version 20031228, fixed bufsize 32768, s/g segs 256
Console: switching to colour frame buffer device 128x48
PCI: Found IRQ 11 for device 0000:00:0a.0
Yenta: CardBus bridge found at 0000:00:0a.0 [103c:0024]
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000007
ohci_hcd: 2003 Oct 13 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci_hcd: block sizes: ed 64 td 64
PCI: Assigned IRQ 9 for device 0000:00:02.0
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: irq 9, pci mem cd849000
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 4 ports detected
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
serio: i8042 AUX port at 0x60,0x64 irq 12
synaptics reset failed
synaptics reset failed
synaptics reset failed
Unable to query Synaptics hardware.
input: PS/2 Synaptics TouchPad on isa0060/serio1
psmouse.c: Failed to enable mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
atkbd.c: Unknown key pressed (translated set 2, code 0x6e on 
isa0060/serio0).
input: AT Translated Set 2 keyboard on isa0060/serio0
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 
19:16:36 2003 UTC).
PCI: Found IRQ 5 for device 0000:00:06.0
ALSA device list:
   #0: ALI 5451 at 0x8400, irq 5
NET: Registered protocol family 2
input: ImPS/2 Synaptics Wheel Mouse on isa0060/serio1
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
ip_conntrack version 2.1 (1527 buckets, 12216 max) - 296 bytes per 
conntrack
ip_tables: (C) 2000-2002 Netfilter core team
atkbd.c: Unknown key pressed (translated set 2, code 0xee on 
isa0060/serio0).
atkbd.c: Unknown key released (translated set 2, code 0xee on 
isa0060/serio0).
Initializing IPsec netlink socket
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 15
ACPI: (supports S0 S3 S4 S5)
XFS mounting filesystem hda3
hub 1-0:1.0: new USB device on port 1, assigned address 2
input: USB HID v1.10 Mouse [Logitech USB Mouse] on usb-0000:00:02.0-1
Ending clean XFS mount for filesystem: hda3
VFS: Mounted root (xfs filesystem) readonly.
Freeing unused kernel memory: 156k freed

