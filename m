Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932480AbVKMMMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbVKMMMm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 07:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbVKMMMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 07:12:42 -0500
Received: from pa208.myslowice.sdi.tpnet.pl ([213.76.228.208]:33745 "EHLO
	finwe.eu.org") by vger.kernel.org with ESMTP id S932480AbVKMMMm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 07:12:42 -0500
Date: Sun, 13 Nov 2005 13:13:34 +0100
From: Jacek Kawa <jfk@zeus.polsl.gliwice.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Resume from swsusp stopped working with 2.6.14 and 2.6.15-rc1
Message-ID: <20051113121334.GA25369@finwe.eu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200511130408.45771.bdonner@physik.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511130408.45771.bdonner@physik.tu-muenchen.de>
Organization: Kreatorzy Kreacji Bialej
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Donner wrote:

> I experienced the same problem on an Dell Inspiron 4100.

I was about to report the same (?) issue, heh...

0. It's Compaq Armada 110
1. All -rcs up to 4th work fine, while -rc5, -final, -stable2 doesn't
   (well, I did suspend and resume correctly just once with stable2:
   restart, login, modprobe -r uhci_hcd, sync, sync, suspend)
2. While resuming, all seems to freeze while "Stopping tasks: =============..."
   appears on the screen; no sysrq

More details:

short hibernating script:
-------------------------
 http://zeus.polsl.gliwice.pl/~jfk/kernel/hib

config:
-------
 http://zeus.polsl.gliwice.pl/~jfk/kernel/config-2.6.14-rc4-laptop
 and went through oldconfig without changes (+# CONFIG_AIRO is not set)
lspci:
------ 
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8601 [Apollo ProMedia] (rev 05)
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8601 [Apollo ProMedia AGP]
0000:00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
0000:00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 10)
0000:00:07.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 10)
0000:00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
0000:00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 Audio Controller (rev 20)
0000:00:09.0 Ethernet controller: Intel Corporation 82557/8/9 [Ethernet Pro 100] (rev 09)
0000:00:09.1 Serial controller: Agere Systems LT WinModem
0000:00:0a.0 CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 01)
0000:01:00.0 VGA compatible controller: Trident Microsystems CyberBlade i1 (rev 6a)

lspci -v ...
------------
http://zeus.polsl.gliwice.pl/~jfk/kernel/lspci-v
http://zeus.polsl.gliwice.pl/~jfk/kernel/lspci-v-v
http://zeus.polsl.gliwice.pl/~jfk/kernel/lspci-v-v-v


dmesg (there is no difference in dmesg betwen -rc4 and -rc5)
------------------------------------------------------------

Linux version 2.6.14-rc5-laptop (jfk@finwe) (gcc version 4.0.3 20051023 (prerelease) (Debian 4.0.2-3)) #4 PREEMPT Fri Nov 11 21:08:03 CET 2005
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
 BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e9c00 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000f7f0000 (usable)
 BIOS-e820: 000000000f7f0000 - 000000000f7ffc00 (ACPI data)
 BIOS-e820: 000000000f7ffc00 - 000000000f800000 (ACPI NVS)
 BIOS-e820: 00000000fffe0000 - 0000000100000000 (reserved)
247MB LOWMEM available.
On node 0 totalpages: 63472
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 59376 pages, LIFO batch:31
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 PTLTD                                 ) @ 0x000f6e90
ACPI: RSDT (v001 PTLTD    RSDT   0x06040000  LTP 0x00000000) @ 0x0f7fbdc2
ACPI: FADT (v001 COMPAQ Borg     0x06040000 PTL_ 0x000f4240) @ 0x0f7ffb64
ACPI: BOOT (v001 PTLTD  $SBFTBL$ 0x06040000  LTP 0x00000001) @ 0x0f7ffbd8
ACPI: DSDT (v001 Compaq Wrangler 0x06040000 MSFT 0x0100000d) @ 0x00000000
Allocating PCI resources starting at 10000000 (gap: 0f800000:f07e0000)
Built 1 zonelists
Kernel command line: root=/dev/hda5 ro nolapic pci=noacpi pmdisk=/dev/hda9 resume=/dev/hda9
mapped APIC to ffffd000 (011f1000)
Initializing CPU#0
CPU 0 irqstacks, hard=c0378000 soft=c0377000
PID hash table entries: 1024 (order: 10, 16384 bytes)
Detected 846.914 MHz processor.
Using tsc for high-res timesource
Console: colour VGA+ 80x25
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 248340k/253888k available (1801k kernel code, 4980k reserved, 549k data, 148k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 1696.68 BogoMIPS (lpj=848344)
Security Framework v1.0.0 initialized
Capability LSM initialized
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0387f9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: After vendor identify, caps: 0387f9ff 00000000 00000000 00000000 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
CPU: After all inits, caps: 0383f9ff 00000000 00000000 00000040 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
mtrr: v2.0 (20020519)
CPU: Intel Pentium III (Coppermine) stepping 06
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
ACPI: setting ELCR to 0e00 (from 0a00)
NET: Registered protocol family 16
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfd83e, last bus=1
PCI: Using configuration type 1
ACPI: Subsystem revision 20050902
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
(gpe 1)
(on)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Boot video device is 0000:01:00.0
at 0000:00:07.0
PCI: IRQ 0 for device 0000:00:0a.0 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 11 for device 0000:00:0a.0
PCI: Sharing IRQ 11 with 0000:00:07.2
pnp: 00:05: ioport range 0x4d0-0x4d1 has been reserved
pnp: 00:05: ioport range 0x220-0x22f has been reserved
pnp: 00:05: ioport range 0x388-0x38b has been reserved
pnp: 00:05: ioport range 0x8000-0x808f could not be reserved
pnp: 00:05: ioport range 0x9050-0x9051 has been reserved
pnp: 00:0a: ioport range 0x958-0x96f has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: f4100000-f57fffff
  PREFETCH window: 14000000-140fffff
PCI: Bus 2, cardbus bridge: 0000:00:0a.0
  IO window: 00002000-00002fff
  IO window: 00003000-00003fff
  PREFETCH window: 10000000-11ffffff
  MEM window: 12000000-13ffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
PCI: Enabling device 0000:00:0a.0 (0000 -> 0003)
PCI: Found IRQ 11 for device 0000:00:0a.0
PCI: Sharing IRQ 11 with 0000:00:07.2
Simple Boot Flag at 0x37 set to 0x1
Initializing Cryptographic API
PCI: Disabling Via external APIC routing
at 0x60,0x64 irq 1,12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
io scheduler cfq registered
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci0000:00:07.1
    ide0: BM-DMA at 0x1460-0x1467, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1468-0x146f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: IC25N040ATCS04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: LG DVD-ROM DRN-8060B, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB) w/1768KiB Cache, CHS=65535/16/63, UDMA(33)
hda: cache flushes not supported
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 >
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.20
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 3, 32768 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
ACPI wakeup devices: 
PWRB  LID PCI0 USB0 MODM PMOD CRD0 
ACPI: (supports S0 S1 S4 S5)
input: AT Translated Set 2 keyboard on isa0060/serio0
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 148k freed
kjournald starting.  Commit interval 5 seconds
Adding 265032k swap on /dev/hda9.  Priority:-1 extents:1 across:265032k
EXT3 FS on hda5, internal journal
pegasus: v0.6.12 (2005/01/13), Pegasus/Pegasus II USB Ethernet driver
usbcore: registered new driver pegasus
mice: PS/2 mouse device common for all mice
USB Universal Host Controller Interface driver v2.3
PCI: Found IRQ 11 for device 0000:00:07.2
PCI: Sharing IRQ 11 with 0000:00:0a.0
uhci_hcd 0000:00:07.2: UHCI Host Controller
uhci_hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:07.2: irq 11, io base 0x00001440
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
input: PS/2 Synaptics TouchPad on isa0060/serio1
Real Time Clock Driver v1.12
Generic RTC Driver v1.07
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
loop: loaded (max 8 devices)
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
EXT3 FS on loop0, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
parport_pc: VIA 686A/8231 detected
parport_pc: probing current configuration
parport_pc: Current parallel port base: 0x0
parport_pc: VIA parallel port disabled in BIOS
parport: PnPBIOS parport detected.

via686a 0000:00:07.4: base address not set - upgrade BIOS or use force_addr=0xaddr
PCI: Found IRQ 9 for device 0000:00:07.5
PCI: Setting latency timer of device 0000:00:07.5 to 64
e100: Intel(R) PRO/100 Network Driver, 3.4.14-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
PCI: Found IRQ 11 for device 0000:00:09.0
PCI: Sharing IRQ 11 with 0000:00:09.1
e100: eth0: e100_probe: addr 0xf4020000, irq 11, MAC addr 00:D0:59:66:88:17
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
PCI: Found IRQ 11 for device 0000:00:09.1
PCI: Sharing IRQ 11 with 0000:00:09.0
PCI: Found IRQ 11 for device 0000:00:0a.0
PCI: Sharing IRQ 11 with 0000:00:07.2

Yenta: Enabling burst memory read transactions
Yenta: Using CSCINT to route CSC interrupts to PCI
Yenta: Routing CardBus interrupts to PCI
Yenta TI: socket 0000:00:0a.0, mfunc 0x00001012, devctl 0x64
Yenta: ISA IRQ mask 0x0038, PCI irq 11
Socket status: 30000006
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
pcmcia: Detected deprecated PCMCIA ioctl usage.
pcmcia: This interface will soon be removed from the kernel; please expect breakage unless you upgrade to new tools.
pcmcia: see http://www.kernel.org/pub/linux/utils/kernel/pcmcia/pcmcia.html for details.

ver-linux
---------

Linux miriel 2.6.14-rc4-laptop #5 PREEMPT Fri Nov 11 21:36:41 CET 2005 i686 GNU/Linux
 
Gnu C                  4.0.3
Gnu make               3.80
binutils               2.16.91
util-linux             2.12p
mount                  2.12p
module-init-tools      3.2-pre9
e2fsprogs              1.38
reiserfsprogs          line
reiser4progs           line
pcmcia-cs              3.2.8
PPP                    2.4.3
Linux C Library        2.3.5
Dynamic linker (ldd)   2.3.5
Procps                 3.2.6
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.2.1
Modules Loaded         uhci_hcd floppy sd_mod scsi_mod ipx p8022 psnap llc thermal fan button processor ac battery ipt_multiport ipt_state ipt_pkttype ipt_LOG ipt_limit ipt_REJECT iptable_nat ip_nat iptable_filter ip_tables ip_conntrack_ftp ip_conntrack nfnetlink pcmcia firmware_class crc32 8250_pnp yenta_socket rsrc_nonstatic pcmcia_core 8250_pci 8250 serial_core e100 snd_seq_oss snd_seq_midi snd_seq_midi_event snd_seq snd_via82xx gameport snd_ac97_codec snd_ac97_bus snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi snd_seq_device snd soundcore via686a i2c_isa i2c_core parport_pc parport nls_iso8859_2 nls_cp852 vfat fat loop rtc psmouse mousedev pegasus mii

bye!

-- 
Jacek Kawa  **The real trouble with reality is that
                 there's no background music.**
