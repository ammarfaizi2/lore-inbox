Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932678AbWCIFPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932678AbWCIFPL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 00:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932680AbWCIFPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 00:15:11 -0500
Received: from mx6.mail.ru ([194.67.23.26]:19983 "EHLO mx6.mail.ru")
	by vger.kernel.org with ESMTP id S932678AbWCIFPJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 00:15:09 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-acpi@vger.kernel.org
Subject: System completely hangs using acpi_cpufreq
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk
References: <200601150118.57542.arvidjaar@mail.ru>
In-Reply-To: <200601150118.57542.arvidjaar@mail.ru>
Content-Disposition: inline
Date: Thu, 9 Mar 2006 08:15:04 +0300
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200603090815.05081.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

[I resend this now with correct ACPI ML address]

For some time I have been experiencing mysterious lockups on my notebook. They 
happened usually shortly after system has been booted (probably 95% of 
power-ups), 5-10 minutes. I normally switch off/on every day and the normal 
sequence was:

- - - switch on
- - - kernel boots, KDE loads
- - - I start doing something and system stalls. The only way out is power 
button 
(keep pressing for 4 sec :) I did not have chance to check if network was 
still active, but both input (keyboard and mouse) and output (no screen 
updates) were dead
- - - I switch on again and now keyboard is dead. I cannot even select kernel to 
load in grub menu
- - - I switch off again (does not matter if I do it before loading kernel while 
in grub or wait until kdm loads and shut down system using menu - fortunately 
mouse still works at this time). If I switch while in grub I do not have to 
wait that long BTW, it reacts almost immediately on button press.
- - - when I finally switch on third time, system works. I do not remember 
having 
lockup after this boot.

Then I switch off and on the next day it usually repeats itself.

This happened in 2.6.14 and now in 2.6.15 (up to 2.6.15.5 when I stopped using 
acpi_cpufreq). I cannot be sure about earlier versions because I did not use 
acpi_cpufreq then. I am not absolutely sure it is the cuplrit but I am 
running for a week now without single lockup with the only change being 
disabled acpi_cpufreq which gives strong confidence.

System is Toshiba Portege 4000, the latest available BIOS, distribution 
Mandriva cooker with vanilla kernel. dmesg at the end, apart from that I am 
not sure what information is needed.

I do not dismiss possibility of BIOS bug, in which case having blacklist 
support may be nice though. Otherwise I am open to any idea how to debug it. 
Unfortunately when lockup happens system is really dead; I may try to cook up 
watchdog driver that generates NMI using chipset capability (this is Ali 
M1533) if this may help; I tried to understand if NMI watchdog is supported 
without APIC but failed.

regards

- - -andrey

Linux version 2.6.15.6-1avb (bor@cooker.home.net) (gcc version 4.0.3 
(4.0.3-0.20060215.2mdk for Mandriva Linux release 2006.1)) #17 Mon Mar 6 
22:15:48 MSK 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 00000000000eee00 (reserved)
 BIOS-e820: 00000000000eee00 - 00000000000ef000 (ACPI NVS)
 BIOS-e820: 00000000000ef000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001ef60000 (usable)
 BIOS-e820: 000000001ef60000 - 000000001ef70000 (ACPI data)
 BIOS-e820: 000000001ef70000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000fff80000 - 0000000100000000 (reserved)
495MB LOWMEM available.
On node 0 totalpages: 126816
  DMA zone: 4096 pages, LIFO batch:0
  DMA32 zone: 0 pages, LIFO batch:0
  Normal zone: 122720 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:0
DMI 2.3 present.
ACPI: RSDP (v000 TOSHIB                                ) @ 0x000f0090
ACPI: RSDT (v001 TOSHIB 750      0x00970814 TASM 0x04010000) @ 0x1ef60000
ACPI: FADT (v002 TOSHIB 750      0x00970814 TASM 0x04010000) @ 0x1ef60054
ACPI: DSDT (v001 TOSHIB 4000     0x20020417 MSFT 0x0100000a) @ 0x00000000
ACPI: PM-Timer IO Port: 0xee08
Allocating PCI resources starting at 30000000 (gap: 20000000:dff80000)
Built 1 zonelists
Kernel command line: root=/dev/hda2 pinit hdc=ide-cd resume=/dev/hda1 
splash=silent elevator=cfq vga=791
Local APIC disabled by BIOS -- you can enable it with "lapic"
mapped APIC to ffffd000 (013e2000)
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 32768 bytes)
Detected 747.751 MHz processor.
Using pmtmr for high-res timesource
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 498936k/507264k available (1937k kernel code, 7684k reserved, 573k 
data, 196k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1497.53 BogoMIPS 
(lpj=2995068)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0387f9ff 00000000 00000000 00000000 
00000000 00000000 00000000
CPU: After vendor identify, caps: 0387f9ff 00000000 00000000 00000000 00000000 
00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
CPU: After all inits, caps: 0383f9ff 00000000 00000000 00000040 00000000 
00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
CPU: Intel Pentium III (Coppermine) stepping 0a
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0200 (from 0a00)
checking if image is initramfs...it isn't (no cpio magic); looks like an 
initrd
Freeing initrd memory: 328k freed
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfe5ae, last bus=5
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
ACPI: Assume root bridge [\_SB_.PCI0] bus is 0
PCI quirk: region ee00-ee3f claimed by ali7101 ACPI
PCI quirk: region ef00-ef1f claimed by ali7101 SMB
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 10 *11)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: Power Resource [PFAN] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: f7f00000-fdffffff
  PREFETCH window: 3c000000-3c0fffff
PCI: Bus 2, cardbus bridge: 0000:00:10.0
  IO window: 00001000-000010ff
  IO window: 00001400-000014ff
  PREFETCH window: 30000000-31ffffff
  MEM window: 32000000-33ffffff
PCI: Bus 6, cardbus bridge: 0000:00:11.0
  IO window: 00001800-000018ff
  IO window: 00001c00-00001cff
  PREFETCH window: 34000000-35ffffff
  MEM window: 36000000-37ffffff
PCI: Bus 10, cardbus bridge: 0000:00:11.1
  IO window: 00002000-000020ff
  IO window: 00002400-000024ff
  PREFETCH window: 38000000-39ffffff
  MEM window: 3a000000-3bffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
PCI: Enabling device 0000:00:10.0 (0000 -> 0003)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKC] -> GSI 11 (level, low) -> 
IRQ 11
PCI: Enabling device 0000:00:11.0 (0000 -> 0003)
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:11.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> 
IRQ 11
PCI: Enabling device 0000:00:11.1 (0000 -> 0003)
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:11.1[B] -> Link [LNKB] -> GSI 11 (level, low) -> 
IRQ 11
audit: initializing netlink socket (disabled)
audit(1141804162.912:1): initialized
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered (default)
Activating ISA DMA hang workarounds.
vesafb: framebuffer at 0xfc000000, mapped to 0xdf880000, using 3072k, total 
16384k
vesafb: mode is 1024x768x16, linelength=2048, pages=9
vesafb: protected mode interface info at c000:775e
vesafb: scrolling: redraw
vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
vesafb: Mode is VGA compatible
Console: switching to colour frame buffer device 128x48
fb0: VESA VGA frame buffer device
Real Time Clock Driver v1.12
PNP: PS/2 Controller [PNP0303:KBC,PNP0f13:PS2M] at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:08: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 32000K size 1024 blocksize
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
mice: PS/2 mouse device common for all mice
md: md driver 0.90.3 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: bitmap version 4.39
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard as /class/input/input0
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 6, 262144 bytes)
TCP bind hash table entries: 16384 (order: 6, 327680 bytes)
TCP: Hash tables configured (established 16384 bind 16384)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
Using IPI Shortcut mode
swsusp: Resume From Partition /dev/hda1
PM: Checking swsusp image.
swsusp: Error -6 check for resume file
PM: Resume from disk failed.
ACPI wakeup devices: 
 COM USB1 ASND VIY0 VIY1  LAN MPC0 MPC1 NOV0  LID 
ACPI: (supports S0 S3 S4 S5)
BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ALI15X3: IDE controller at PCI slot 0000:00:04.0
ACPI: PCI Interrupt 0000:00:04.0[A]: no GSI
ALI15X3: chipset revision 195
ALI15X3: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xeff0-0xeff7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xeff8-0xefff, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
input: ImPS/2 Generic Wheel Mouse as /class/input/input1
hda: IC25N020ATDA04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: TOSHIBA DVD-ROM SD-C2502, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 39070080 sectors (20003 MB) w/1806KiB Cache, CHS=38760/16/63, UDMA(33)
hda: cache flushes not supported
 hda: hda1 hda2
ReiserFS: hda2: found reiserfs format "3.6" with standard journal
ReiserFS: hda2: using ordered data mode
ReiserFS: hda2: journal params: device hda2, size 8192, journal first block 
18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
ReiserFS: hda2: checking transaction log (hda2)
ReiserFS: hda2: Using r5 hash to sort names
Freeing unused kernel memory: 196k freed
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:02.0[A] -> Link [LNKG] -> GSI 11 (level, low) -> 
IRQ 11
ohci_hcd 0000:00:02.0: OHCI Host Controller
ohci_hcd 0000:00:02.0: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:02.0: irq 11, io mem 0xf7eff000
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKC] -> GSI 11 (level, low) -> 
IRQ 11
Yenta: CardBus bridge found at 0000:00:10.0 [12a3:ab01]
Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:10.0, mfunc 0x01000002, devctl 0x60
Yenta: ISA IRQ mask 0x0000, PCI irq 11
Socket status: 30000011
ACPI: PCI Interrupt 0000:00:11.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> 
IRQ 11
Yenta: CardBus bridge found at 0000:00:11.0 [1179:0001]
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000007
pccard: PCMCIA card inserted into slot 0
cs: memory probe 0x0c0000-0x0fffff: excluding 0xc0000-0xcbfff 0xe0000-0xfffff
cs: memory probe 0x60000000-0x60ffffff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
pcmcia: registering new device pcmcia0.0
ACPI: PCI Interrupt 0000:00:11.1[B] -> Link [LNKB] -> GSI 11 (level, low) -> 
IRQ 11
Yenta: CardBus bridge found at 0000:00:11.1 [1179:0001]
wlags49_h1_cs v7.18 for PCMCIA, 03/31/2004 14:31:00 by Agere Systems, 
http://www.agere.com
*** Modified for kernel 2.6 by Andrey Borzenkov <arvidjaar@mail.ru> $Revision: 
19 $
*** Station Mode (STA) Support: YES
*** Access Point Mode (AP) Support: YES
eth0: PRI 31 variant 2 version 9.48
eth0: NIC 5 variant 2 version 1.02
eth0: Wireless, io_addr 0x100, irq 11, mac_address 00:02:2D:26:95:6C
Yenta: ISA IRQ mask 0x04b8, PCI irq 11
Socket status: 30000007
ts: Compaq touchscreen protocol output
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected ALi M1644 chipset
agpgart: AGP aperture is 64M @ 0xf0000000
ACPI: AC Adapter [ADP1] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Battery Slot [BAT2] (battery absent)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
ACPI: Fan [FAN] (off)
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Thermal Zone [THRM] (29 C)
toshiba_acpi: Toshiba Laptop ACPI Extras version 0.18
toshiba_acpi:     HCI method: \_SB_.VALD.GHCI
ACPI: Video Device [VGA] (multi-head: yes  rom: yes  post: no)
Adding 500432k swap on /dev/hda1.  Priority:-1 extents:1 across:500432k
loop: loaded (max 8 devices)
hdc: ATAPI 24X DVD-ROM drive, 128kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQFED7nYR6LMutpd94wRAslzAJ4tS89oAkTM78uizyUjVMi4uQ08gwCggDAt
hsngTxupFGf6K7r5s89+NM4=
=WxDh
-----END PGP SIGNATURE-----
