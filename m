Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266249AbUAGRV1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 12:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266255AbUAGRV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 12:21:27 -0500
Received: from natsmtp00.rzone.de ([81.169.145.165]:58776 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S266249AbUAGRU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 12:20:57 -0500
Subject: 2.6.* + suspend/resume kills USB
From: Matthias Hentges <mailinglisten@hentges.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-NSbR6de+IqL/gWA9r7SI"
Organization: 
Message-Id: <1073496054.26280.42.camel@mhcln02>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 07 Jan 2004 18:20:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NSbR6de+IqL/gWA9r7SI
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello all!

Fist of all let me thank the kernel developers for their _great_ work.
Kernel 2.6 is really amazing, especially on my old laptop (Celeron 600)
it worked pure wonders performance-wise. Thank you! :)

I'm running 2.6.0-mm2 right now which fixed some serious problems with
encrypted loop devices on my machine.

Now i've run into a problem with USB after a suspend/resume event on my
laptop. USB won't wakeup after a resume event which is a pain if you
happen to depend on an USB mouse (the build-in touchpad is toast...)

I've googled for more info on this issue and found a thread from
linux-usb-devel:
http://www.mail-archive.com/linux-usb-devel@lists.sourceforge.net/msg17660.html

The poster (Michael Vogt) had the exact same problem and came up with a
solution:

"When I change drivers/usb/host/uhci-hcd.c:suspend_allowed() to always
return 0 (don't suspend on uhci_suspend the but reset), usb seems to
work after a suspend/resume with apm."

This worked for me, too. 

Now i wonder if a fix will be included into the 2.6 line. 
The solution works ATM but it's a very "hacky" way to do it IMO.

I'm continuously checking the changelogs of the 2.6 -rc and -mm kernels
but didn't see any mention of the problem (or a fix) there, so i thought
i'd ask here if the bug is known and if someone is working on it or is
planning to do so (if i had any coding skills, i'd try it myself).

If someone is planning to work on it, please feel free to contact me
if you need a tester. I'll do what i can to help resolve this issue.

I have attached a lspci and dmesg dumps in case they are needed.

TIA and HAND
-- 

Matthias Hentges 
Cologne / Germany

[www.hentges.net] -> PGP welcome, HTML tolerated
ICQ: 97 26 97 4   -> No files, no URL's

My OS: Debian Woody. Geek by Nature, Linux by Choice

--=-NSbR6de+IqL/gWA9r7SI
Content-Disposition: attachment; filename=lcpci.txt
Content-Type: text/plain; name=lcpci.txt; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

00:00.0 Host bridge: Intel Corp. 440BX/ZX - 82443BX/ZX Host bridge (rev 03)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX - 82443BX/ZX AGP bridge (rev 03)
00:03.0 CardBus bridge: Texas Instruments PCI1225 (rev 01)
00:03.1 CardBus bridge: Texas Instruments PCI1225 (rev 01)
00:07.0 Bridge: Intel Corp. 82371AB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corp. 82371AB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB PIIX4 ACPI (rev 03)
00:08.0 Multimedia audio controller: ESS Technology ES1983S Maestro-3i PCI Audio Accelerator (rev 10)
00:08.1 Communication controller: ESS Technology ES1983S Maestro-3i PCI Modem Accelerator (rev 10)
01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility P/M AGP 2x (rev 64)

--=-NSbR6de+IqL/gWA9r7SI
Content-Disposition: attachment; filename=dmesg.txt
Content-Type: text/plain; name=dmesg.txt; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Linux version 2.6.0-mm2 (root@mhcln02) (gcc version 2.95.4 20011002 (Debian prerelease)) #9 Mon Jan 5 20:59:13 CET 2004
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000c0000 - 00000000000cc000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000ffec000 (usable)
 BIOS-e820: 000000000ffec000 - 000000000fff0000 (reserved)
 BIOS-e820: 00000000100a0000 - 0000000010100000 (reserved)
 BIOS-e820: 00000000ffe00000 - 0000000100000000 (reserved)
255MB LOWMEM available.
On node 0 totalpages: 65516
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 61420 pages, LIFO batch:14
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=Linux_2.6.0 ro root=303
current: c05169a0
current->thread_info: c05b8000
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 598.375 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Memory: 253328k/262064k available (3383k kernel code, 8024k reserved, 1441k data, 176k init, 0k highmem)
zapping low mappings.
Calibrating delay loop... 1183.74 BogoMIPS
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383f9ff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0383f9ff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU:     After all inits, caps: 0383f9ff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Celeron (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfc0be, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
Linux Plug and Play Support v0.97 (c) Adam Belay
i8k: unable to get SMM BIOS version
Dell laptop SMM driver v1.13 14/05/2002 Massimo Dal Zotto (dz@debian.org)
SCSI subsystem initialized
Linux Kernel Card Services
  options:  [pci] [cardbus] [pm]
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router PIIX/ICH [8086/7110] at 0000:00:07.0
irda_init()
NET: Registered protocol family 23
Bluetooth: Core ver 2.3
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
atyfb: 3D RAGE Mobility (PCI) [0x4c4d rev 0x64] 8M SDRAM, 29.498928 MHz XTAL, 230 MHz PLL, 50 Mhz MCLK
fb0: ATY Mach64 frame buffer device on PCI
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
fb1: VGA16 VGA frame buffer device
Machine check exception polling timer started.
speedstep-smi: signature:0x00000000, command:0x0000e6f5, event:0x00000000, perf_level:0x47534943.
IA-32 Microcode Update Driver: v1.13 <tigran@veritas.com>
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16ac)
ikconfig 0.7 with /proc/config*
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
udf: registering filesystem
SGI XFS for Linux with ACLs, large block numbers, no debug enabled
Initializing Cryptographic API
Limiting direct PCI/PCI transfers.
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Console: switching to colour frame buffer device 80x25
pty: 256 Unix98 ptys configured
request_module: failed /sbin/modprobe -- parport_lowlevel. error = -16
lp: driver loaded but no devices found
Real Time Clock Driver v1.12
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected an Intel 440BX Chipset.
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: AGP aperture is 64M @ 0xf4000000
[drm] Initialized r128 2.5.0 20030725 on minor 0
[drm] Initialized radeon 1.9.0 20020828 on minor 1
Serial: 8250/16550 driver $Revision: 1.90 $ 8 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
Using anticipatory io scheduler
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
PPP generic driver version 2.4.2
found SMC SuperIO Chip (devid=0x09 rev=08 base=0x03f0): FDC37N958FR
smsc_ircc_present: can't get sir_base of 0x2f8
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller at PCI slot 0000:00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x0860-0x0867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x0868-0x086f, BIOS settings: hdc:DMA, hdd:pio
hda: IBM-DJSA-210, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: LG DVD-ROM DRN-8080B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 19640880 sectors (10056 MB) w/384KiB Cache, CHS=19485/16/63, UDMA(33)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
end_request: I/O error, dev hdc, sector 0
end_request: I/O error, dev hdc, sector 0
cdrom: : unknown mrw mode page
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
ide-floppy driver 0.99.newide
Console: switching to colour frame buffer device 80x25
PCI: Found IRQ 11 for device 0000:00:03.0
PCI: Sharing IRQ 11 with 0000:00:03.1
PCI: Sharing IRQ 11 with 0000:00:07.2
Yenta: CardBus bridge found at 0000:00:03.0 [1028:00bb]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ mask 0x0698, PCI irq 11
Socket status: 30000006
PCI: Found IRQ 11 for device 0000:00:03.1
PCI: Sharing IRQ 11 with 0000:00:03.0
PCI: Sharing IRQ 11 with 0000:00:07.2
Yenta: CardBus bridge found at 0000:00:03.1 [1028:00bb]
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta: ISA IRQ mask 0x0698, PCI irq 11
Socket status: 30000010
Intel ISA PCIC probe: not found.
Databook TCIC-2 PCMCIA probe: not found.
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
PCI: Found IRQ 11 for device 0000:00:07.2
PCI: Sharing IRQ 11 with 0000:00:03.0
PCI: Sharing IRQ 11 with 0000:00:03.1
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: irq 11, io base 0000dce0
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
drivers/usb/host/uhci-hcd.c: detected 2 ports
uhci_hcd 0000:00:07.2: root hub device address 1
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
drivers/usb/core/message.c: USB device number 1 default language ID 0x409
usb usb1: Product: UHCI Host Controller
usb usb1: Manufacturer: Linux 2.6.0-mm2 uhci_hcd
usb usb1: SerialNumber: 0000:00:07.2
drivers/usb/core/usb.c: usb_hotplug
usb usb1: registering 1-0:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: ganged power switching
hub 1-0:1.0: global over-current protection
hub 1-0:1.0: Port indicators are not supported
hub 1-0:1.0: power on to power good time: 2ms
hub 1-0:1.0: hub controller current requirement: 0mA
hub 1-0:1.0: local power source is good
hub 1-0:1.0: no over-current condition exists
hub 1-0:1.0: enabling power on all ports
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
mice: PS/2 mouse device common for all mice
input: PC Speaker
serio: i8042 AUX port at 0x60,0x64 irq 12
input: PS/2 Generic Mouse on isa0060/serio1
serio: i8042 KBD port at 0x60,0x64 irq 1
input: AT Translated Set 2 keyboard on isa0060/serio0
I2O Core - (C) Copyright 1999 Red Hat Software
I2O: Event thread created as pid 19
i2o: Checking for PCI I2O controllers...
I2O configuration manager v 0.04.
  (C) Copyright 1999 Red Hat Software
I2O Block Storage OSM v0.9
   (c) Copyright 1999-2001 Red Hat Software.
i2o_block: Checking for Boot device...
i2o_block: Checking for I2O Block devices...
i2c /dev entries driver
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:36 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
PCI: Found IRQ 5 for device 0000:00:08.0
PCI: Sharing IRQ 5 with 0000:00:08.1
hub 1-0:1.0: port 1, status 301, change 1, 1.5 Mb/s
hub 1-0:1.0: debounce: port 1: delay 100ms stable 4 status 0x301
hub 1-0:1.0: new USB device on port 1, assigned address 2
usb 1-1: new device strings: Mfr=1, Product=2, SerialNumber=0
drivers/usb/core/message.c: USB device number 2 default language ID 0x409
usb 1-1: Product: USB-PS/2 Trackball
usb 1-1: Manufacturer: Logitech
drivers/usb/core/usb.c: usb_hotplug
usb 1-1: registering 1-1:1.0 (config #1, interface 0)
drivers/usb/core/usb.c: usb_hotplug
hid 1-1:1.0: usb_probe_interface
hid 1-1:1.0: usb_probe_interface - got id
input: USB HID v1.00 Mouse [Logitech USB-PS/2 Trackball] on usb-0000:00:07.2-1
ALSA device list:
  #0: ESS Maestro3 PCI at 0xd800, irq 5
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
ip_conntrack version 2.1 (2047 buckets, 16376 max) - 304 bytes per conntrack
ip_tables: (C) 2000-2002 Netfilter core team
ipt_recent v0.3.1: Stephen Frost <sfrost@snowman.net>.  http://snowman.net/projects/ipt_recent/
NET: Registered protocol family 1
NET: Registered protocol family 17
found reiserfs format "3.6" with standard journal
Reiserfs journal params: device hda3, size 8192, journal first block 18, max trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda3) for (hda3)
reiserfs: replayed 24 transactions in 9 seconds
Using r5 hash to sort names
VFS: Mounted root (reiserfs filesystem) readonly.
Freeing unused kernel memory: 176k freed
Adding 281096k swap on /dev/hda1.  Priority:-1 extents:1
Adding 297192k swap on /dev/hda2.  Priority:-2 extents:1
Removing [911796 911646 0x0 SD]..done
There were 1 uncompleted unlinks/truncates. Completed
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on hda6, internal journal
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on hda5, internal journal
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
request_module: failed /sbin/modprobe -- sound-slot-1. error = 256
process `syslogd' is using obsolete setsockopt SO_BSDCOMPAT
request_module: failed /sbin/modprobe -- net-pf-10. error = 256
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0800-0x08ff: excluding 0x800-0x84f
cs: IO port probe 0x0100-0x04ff: excluding 0x200-0x207 0x280-0x287 0x3c0-0x3df 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
eth0: OfficeConnect 572B at io 0x300, irq 3, hw_addr 00:00:86:5D:FA:2C.
  ASIC rev 1, 64K FIFO split 1:1 Rx:Tx, autoselect MII interface.
eth0: remote fault detected
eth0: found link beat
eth0: autonegotiation complete: 100baseT-FD selected
eth0: remote fault detected
process `snmptrapd' is using obsolete setsockopt SO_BSDCOMPAT
process `snmpd' is using obsolete setsockopt SO_BSDCOMPAT

--=-NSbR6de+IqL/gWA9r7SI--

