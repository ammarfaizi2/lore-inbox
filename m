Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263730AbTICPww (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 11:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263737AbTICPw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 11:52:26 -0400
Received: from pimout5-ext.prodigy.net ([207.115.63.73]:22009 "EHLO
	pimout5-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S263440AbTICPuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 11:50:32 -0400
Message-ID: <3F560DC6.2090709@ameritech.net>
Date: Wed, 03 Sep 2003 10:50:30 -0500
From: watermodem <aquamodem@ameritech.net>
Reply-To: aquamodem@ameritech.net
Organization: not at all
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030718
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test4
Content-Type: multipart/mixed;
 boundary="------------070703080008000607010707"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070703080008000607010707
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Error report from this version.
  .config  not attached as it made post too large for vger
  earlier post was a follow up to this one.

  dmesg attached
  pieces of logs attached

OS variant Mandrake 9.2 rc2
Kernel: 2.6.0-test4

Lots of problems with this kernel starting up, however, with manual 
intervention along the boot process I can make it come up with fair 
functionality.

1) The only way I could get console on boot was to have this config in 
lilo.conf and boot to single user mode (-s)
    image=/boot/vmlinuz
         label="new_linux"
         root=/dev/hdb1
         initrd=/boot/initrd.img
         append="devfs=mount video=rivafb:1024x768-24@100"
         read-only

2) Next problem is modules some auto load with existing scripts but most 
don't.  (With this compile attempt almost everything was built in and 
not modules so you don't see any modules loaded at single user boot) The 
worst offenders are the NLS modules.
I manually went down the list of all modules compiled and loaded them 1 
by 1 with insmod.

3) At this point I do a mount -a and can now mount the NTFS and VFAT 
modules.  So I walk the the init ladder 1,2,3,4,5 and have a somewhat 
functional X environment.

4) Problems include:
    The USB and CUPs problem that I see the USB tree under 
"/sys/bus/usb" where-as under /proc/bus/usb I see nothing.
This may break a lot of existing code such as CUPS Is is suppose to be 
this way? This means USB printer is not seen by the environment but seen 
on boot.

    request_module: failed /sbin/modprobe -- snd-card-0. error = -16
      (Is this related to XINE's sound not working but just ALSA sound 
card or just OSS sound from TV working?)  BTW in 2.4.x everything works.


    videodev: "BT878(Pinnacle PCTV Studio/Ra)" has no release callback. 
Please fix your driver for proper sysfs support, see 
http://lwn.net/Articles/36850/
    videodev: "bt848/878 vbi" has no release callback. Please fix your 
driver for proper sysfs support, see http://lwn.net/Articles/36850/

    process `named' is using obsolete setsockopt SO_BSDCOMPAT
    nmbd[2950]:   find_response_record: response packet id 25574 
received with no matching record.
    nmbd[2950]:   find_response_record: response packet id 25575 
received with no matching record.


    FAT: codepage cp850 not found


    JAVA
    java_binfmt: /etc/rc4.d/S83java_binfmt: line 13: 
/proc/sys/fs/binfmt_misc/register: No such file or directory
    java_binfmt: /etc/rc4.d/S83java_binfmt: line 14: 
/proc/sys/fs/binfmt_misc/register: No such file or directory
    java_binfmt: /etc/rc4.d/S83java_binfmt: line 15: 
/proc/sys/fs/binfmt_misc/register: No such file or directory
Sep  2 22:51:16 dali rc: Starting java_binfmt:  failed

    Going to init level 5 I got a bunch of strange errors...
    I am wondering if something got called when it should not have been 
(maybe another xinitd typ process) as I see:
modprobe: FATAL: Module /dev/beep not found.
rc: Starting java_binfmt:  failed
modprobe: FATAL: Module /dev/aload* not found.
Module /dev/sndstat not found etc...
    Some of this may just be that I compiled lots of stuff non-modular 
to get around most of the module loading problems and the Mandrake 
scripts are expecting those particular modules.


    Back to the printer... I see
    ...
    modprobe: FATAL: Module /dev/ptal_mlcd not found
    modprobe: FATAL: Module /dev/ptal_printd not found.
    ptal-mlcd: SYSLOG at ExMgr.cpp:652, dev=<mlc:usb:PHOTOSMART_P1000>, 
pid=5656, e=2, t=1062565032         ptal-mlcd successfully initialized.
    ptal-printd: ptal-printd(mlc:usb:PHOTOSMART_P1000) successfully 
initialized using /var/run/ptal-printd/mlc_usb_PHOTOSMART_P1000*.
Sep  2 23:57:12 dali ptal-photod: ptal-photod(mlc:usb:PHOTOSMART_P1000) 
successfully initialized, listening on port 5703.
    But it doesn't...
    A restart on CUPS gets:
Stopping CUPS printing system:                                  [  OK  ]
Starting CUPS printing system:
ptal-mlcd: ERROR at ExMgr.cpp:4058, 
dev=<mlc:usb:PHOTOSMART_P1000@/dev/usb/lp0>, pid=6502, e=20, t=1062569016
libusbFindDevice: Couldn't find device!



--------------070703080008000607010707
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="dmesg"

f3000 (ACPI NVS)
 BIOS-e820: 0000000037ff3000 - 0000000038000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
895MB LOWMEM available.
On node 0 totalpages: 229360
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 225264 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.2 present.
ACPI: RSDP (v000 GBT                                       ) @ 0x000f6b60
ACPI: RSDT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x37ff3000
ACPI: FADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x37ff3040
ACPI: DSDT (v001 GBT    AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: MADT not present
Building zonelist for node : 0
Kernel command line: BOOT_IMAGE=new_linux ro root=341 devfs=mount video=rivafb:1024x768-24@100 -s
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
PID hash table entries: 4096 (order 12: 32768 bytes)
Detected 997.828 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1970.17 BogoMIPS
Memory: 903208k/917440k available (2797k kernel code, 13452k reserved, 1085k data, 188k init, 0k highmem)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU:     After generic identify, caps: 0383fbff 00000000 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff 00000000 00000000 00000000
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU:     After all inits, caps: 0383fbff 00000000 00000000 00000040
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: Intel Pentium III (Coppermine) stepping 0a
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 997.0327 MHz.
..... host bus clock speed is 132.0976 MHz.
PM: Adding info for No Bus:legacy
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xfb380, last bus=1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030813
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PM: Adding info for No Bus:pci0000:00
PM: Adding info for pci:0000:00:00.0
PM: Adding info for pci:0000:00:01.0
PM: Adding info for pci:0000:00:07.0
PM: Adding info for pci:0000:00:07.1
PM: Adding info for pci:0000:00:07.2
PM: Adding info for pci:0000:00:07.3
PM: Adding info for pci:0000:00:09.0
PM: Adding info for pci:0000:00:0a.0
PM: Adding info for pci:0000:00:0a.1
PM: Adding info for pci:0000:00:0b.0
PM: Adding info for pci:0000:00:0b.1
PM: Adding info for pci:0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fc060
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xc088, dseg 0xf0000
PM: Adding info for No Bus:pnp0
PM: Adding info for pnp:00:00
PM: Adding info for pnp:00:01
PM: Adding info for pnp:00:02
PM: Adding info for pnp:00:03
PM: Adding info for pnp:00:04
PM: Adding info for pnp:00:05
PM: Adding info for pnp:00:06
PM: Adding info for pnp:00:07
PM: Adding info for pnp:00:08
PM: Adding info for pnp:00:09
PM: Adding info for pnp:00:0c
PM: Adding info for pnp:00:0d
PM: Adding info for pnp:00:0f
PM: Adding info for pnp:00:10
PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
SCSI subsystem initialized
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
rivafb: nVidia device/chipset 10DE0110
rivafb: Detected CRTC controller 0 being used
rivafb: RIVA MTRR set to ON
rivafb: PCI nVidia NV10 framebuffer ver 0.9.5b (nVidiaGeForce2-M, 32MB @ 0xD8000000)
pty: 256 Unix98 ptys configured
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
ikconfig 0.5 with /proc/ikconfig
Journalled Block Device driver loaded
devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
udf: registering filesystem
Activating ISA DMA hang workarounds.
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Processor [CPU0] (supports C1 C2, 2 throttling states)
PM: Adding info for No Bus:pnp1
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Real Time Clock Driver v1.11a
Non-volatile memory driver v1.2
Linux agpgart interface v0.100 (c) Dave Jones
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
Using anticipatory scheduling elevator
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
PM: Adding info for platform:floppy0
Intel(R) PRO/100 Network Driver - version 2.3.18-k1
Copyright (c) 2003 Intel Corporation

e100: selftest OK.
e100: eth0: Intel(R) PRO/100 Network Connection

Linux video capture interface: v1.00
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:07.1
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c596b (rev 23) IDE UDMA66 controller on pci0000:00:07.1
    ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC WD600BB-32BSA0, ATA DISK drive
PM: Adding info for No Bus:ide0
hdb: WDC WD800BB-75CAA0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
PM: Adding info for ide:0.0
PM: Adding info for ide:0.1
hdc: SAMSUNG CD-R/RW SW-216B Q001 20010913, ATAPI CD/DVD-ROM drive
PM: Adding info for No Bus:ide1
hdd: DVD-ROM DDU1621, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
PM: Adding info for ide:1.0
PM: Adding info for ide:1.1
hda: max request size: 128KiB
hda: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(66)
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
hdb: max request size: 128KiB
hdb: Host Protected Area detected.
	current capacity is 156250000 sectors (80000 MB)
	native  capacity is 156301488 sectors (80026 MB)
hdb: 156250000 sectors (80000 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(66)
 /dev/ide/host0/bus0/target1/lun0: p1 p2 p3 p4 < p5 p6 p7 >
hdc: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev hdd, sector 0
hdd: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
uhci-hcd 0000:00:07.2: UHCI Host Controller
uhci-hcd 0000:00:07.2: irq 10, io base 0000d400
uhci-hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
PM: Adding info for usb:usb1
hub 1-0:0: USB hub found
hub 1-0:0: 2 ports detected
PM: Adding info for usb:1-0:0
drivers/usb/core/usb.c: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
drivers/usb/core/usb.c: registered new driver usb-storage
USB Mass Storage support registered.
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
drivers/usb/core/usb.c: registered new driver usbscanner
drivers/usb/image/scanner.c: 0.4.14:USB Scanner Driver
mice: PS/2 mouse device common for all mice
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
I2O Core - (C) Copyright 1999 Red Hat Software
I2O: Event thread created as pid 12
i2o: Checking for PCI I2O controllers...
I2O configuration manager v 0.04.
  (C) Copyright 1999 Red Hat Software
I2O Block Storage OSM v0.9
   (c) Copyright 1999-2001 Red Hat Software.
i2o_block: Checking for Boot device...
i2o_block: Checking for I2O Block devices...
i2c /dev entries driver module version 2.7.0 (20021208)
Advanced Linux Sound Architecture Driver Version 0.9.6 (Wed Aug 20 20:27:13 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
ALSA device list:
  #0: Sound Blaster Live! (rev.10) at 0xdc00, irq 5
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
BIOS EDD facility v0.09 2003-Jan-22, 2 devices found
ACPI: (supports S0 S1 S4 S4bios S5)
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 188k freed
hub 1-0:0: new USB device on port 1, assigned address 2
PM: Adding info for usb:1-1
input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse® Optical] on usb-0000:00:07.2-1
PM: Adding info for usb:1-1:0
hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
hub 1-0:0: new USB device on port 2, assigned address 3
PM: Adding info for usb:1-2
drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 3 if 0 alt 1 proto 2 vid 0x03F0 pid 0x3002
PM: Adding info for usb:1-2:0
EXT3 FS on hdb1, internal journal
Adding 2096472k swap on /dev/hdb2.  Priority:-1 extents:1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb5, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
FAT: codepage cp850 not found
FAT: codepage cp850 not found
bttv: driver version 0.9.11 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Host bridge is 0000:00:00.0
bttv: Host bridge is 0000:00:07.3
bttv: Bt8xx card found (0).
bttv0: Bt878 (rev 17) at 0000:00:0b.0, irq: 10, latency: 64, mmio: 0xe5101000
bttv0: detected: Pinnacle PCTV [card=39], PCI subsystem ID is 11bd:0012
bttv0: using: BT878(Pinnacle PCTV Studio/Ra) [card=39,autodetected]
PM: Adding info for No Bus:i2c-0
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: miro: id=3 tuner=2 radio=no stereo=no
bttv0: using tuner=2
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
videodev: "BT878(Pinnacle PCTV Studio/Ra)" has no release callback. Please fix your driver for proper sysfs support, see http://lwn.net/Articles/36850/
bttv0: registered device video0
videodev: "bt848/878 vbi" has no release callback. Please fix your driver for proper sysfs support, see http://lwn.net/Articles/36850/
bttv0: registered device vbi0
bttv0: PLL: 28636363 => 35468950 .. ok
loop: loaded (max 8 devices)
btaudio: driver version 0.7 loaded [digital+analog]
btaudio: Bt878 (rev 17) at 00:0b.1, irq: 10, latency: 64, mmio: 0xe5102000
btaudio: using card config "default"
btaudio: registered device dsp1 [digital]
btaudio: registered device dsp2 [analog]
btaudio: registered device mixer1
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
apm: overridden by ACPI.
nls_big5: Unknown parameter `nls_cp1250.ko'
NTFS driver 2.1.4 [Flags: R/O MODULE].
nbd: registered device at major 43
PM: Adding info for No Bus:i2c-1
tuner: chip found @ 0xc0
tuner: type set to 2 (Philips NTSC (FI1236,FM1236 and compatibles))
registering 0-0060
PM: Adding info for i2c:0-0060
Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
pwc Philips PCA645/646 + PCVC675/680/690 + PCVC730/740/750 webcam module version 8.11 loaded.
pwc Also supports the Askey VC010, various Logitech QuickCams, Samsung MPC-C10 and MPC-C30,
pwc the Creative WebCam 5, SOTEC Afina Eye and Visionite VCS-UC300 and VCS-UM100.
drivers/usb/core/usb.c: registered new driver Philips webcam
drivers/usb/media/se401.c: SE401 usb camera driver version 0.24 registering
drivers/usb/core/usb.c: registered new driver se401
drivers/usb/core/usb.c: registered new driver ov511
drivers/usb/media/ov511.c: v1.64 for Linux 2.5 : ov511 USB Camera Driver
drivers/usb/core/usb.c: registered new driver rio500
drivers/usb/misc/rio500.c: v1.1:USB Rio 500 driver
drivers/usb/core/usb.c: registered new driver uss720
drivers/usb/misc/uss720.c: v0.5:USB Parport Cable driver for Cables using the Lucent Technologies USS720 Chip
drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
drivers/usb/core/usb.c: registered new driver usbserial
drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
drivers/usb/core/usb.c: registered new driver microtekX6
drivers/usb/core/usb.c: registered new driver hpusbscsi
NTFS-fs warning (device hda1): parse_options(): Option iocharset is deprecated. Please use option nls=<charsetname> in the future.
NTFS volume version 3.0.
e100: eth0 NIC Link is Up 100 Mbps Full duplex
microcode: CPU0 already at revision 1 (current=1)
microcode: freed 2048 bytes
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
process `named' is using obsolete setsockopt SO_BSDCOMPAT
smbfs: Unrecognized mount option noexec
smbfs: Unrecognized mount option noexec
smbfs: Unrecognized mount option noexec
smbfs: Unrecognized mount option noexec

--------------070703080008000607010707
Content-Type: text/plain;
 name="kernel_errors"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kernel_errors"

Sep  2 22:47:56 dali kernel: FAT: codepage cp850 not found
Sep  2 22:47:56 dali kernel: FAT: codepage cp850 not found
Sep  2 22:47:56 dali kernel: nls_big5: Unknown parameter `nls_cp1250.ko'
Sep  2 22:47:56 dali kernel: NTFS-fs warning (device hda1): parse_options(): Option iocharset is deprecated. Please use option nls=<charsetname> in the future.
Sep  2 22:47:56 dali kernel: e100: eth0 NIC Link is Up 100 Mbps Full duplex

--------------070703080008000607010707
Content-Type: text/plain;
 name="kernel_info"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="kernel_info"

Sep  2 22:47:55 dali kernel: klogd 1.4.1, log source = /proc/kmsg started.
Sep  2 22:47:55 dali kernel: Inspecting /boot/System.map-2.6.0-test4
Sep  2 22:47:56 dali kernel: Loaded 34081 symbols from /boot/System.map-2.6.0-test4.
Sep  2 22:47:56 dali kernel: Symbols match kernel version 2.6.0.
Sep  2 22:47:56 dali kernel: No module symbols loaded - kernel modules not enabled. 
Sep  2 22:47:56 dali kernel: BIOS-provided physical RAM map:
Sep  2 22:47:56 dali kernel: 895MB LOWMEM available.
Sep  2 22:47:56 dali kernel: DMI 2.2 present.
Sep  2 22:47:56 dali kernel: ACPI: RSDP (v000 GBT                                       ) @ 0x000f6b60
Sep  2 22:47:56 dali kernel: ACPI: RSDT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x37ff3000
Sep  2 22:47:56 dali kernel: ACPI: FADT (v001 GBT    AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x37ff3040
Sep  2 22:47:56 dali kernel: ACPI: DSDT (v001 GBT    AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
Sep  2 22:47:56 dali kernel: Initializing CPU#0
Sep  2 22:47:56 dali kernel: Memory: 903208k/917440k available (2797k kernel code, 13452k reserved, 1085k data, 188k init, 0k highmem)
Sep  2 22:47:56 dali kernel: Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Sep  2 22:47:56 dali kernel: -> /dev
Sep  2 22:47:56 dali kernel: -> /dev/console
Sep  2 22:47:56 dali kernel: -> /root
Sep  2 22:47:56 dali kernel: CPU:     After generic identify, caps: 0383fbff 00000000 00000000 00000000
Sep  2 22:47:56 dali kernel: CPU:     After vendor identify, caps: 0383fbff 00000000 00000000 00000000
Sep  2 22:47:56 dali kernel: CPU: L1 I cache: 16K, L1 D cache: 16K
Sep  2 22:47:56 dali kernel: CPU: L2 cache: 256K
Sep  2 22:47:56 dali kernel: CPU:     After all inits, caps: 0383fbff 00000000 00000000 00000040
Sep  2 22:47:56 dali kernel: Intel machine check architecture supported.
Sep  2 22:47:56 dali kernel: Intel machine check reporting enabled on CPU#0.
Sep  2 22:47:56 dali kernel: Enabling fast FPU save and restore... done.
Sep  2 22:47:56 dali kernel: Enabling unmasked SIMD FPU exception support... done.
Sep  2 22:47:56 dali kernel: Checking 'hlt' instruction... OK.
Sep  2 22:47:56 dali kernel: PM: Adding info for No Bus:legacy
Sep  2 22:47:56 dali kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb380, last bus=1
Sep  2 22:47:56 dali kernel: PCI: Using configuration type 1
Sep  2 22:47:56 dali kernel: mtrr: v2.0 (20020519)
Sep  2 22:47:56 dali kernel: ACPI: Subsystem revision 20030813
Sep  2 22:47:56 dali kernel: ACPI: Interpreter enabled
Sep  2 22:47:56 dali kernel: ACPI: Using PIC for interrupt routing
Sep  2 22:47:56 dali kernel: ACPI: PCI Root Bridge [PCI0] (00:00)
Sep  2 22:47:56 dali kernel: PM: Adding info for No Bus:pci0000:00
Sep  2 22:47:56 dali kernel: PM: Adding info for pci:0000:00:00.0
Sep  2 22:47:56 dali kernel: PM: Adding info for pci:0000:00:01.0
Sep  2 22:47:56 dali kernel: PM: Adding info for pci:0000:00:07.0
Sep  2 22:47:56 dali kernel: PM: Adding info for pci:0000:00:07.1
Sep  2 22:47:56 dali kernel: PM: Adding info for pci:0000:00:07.2
Sep  2 22:47:56 dali kernel: PM: Adding info for pci:0000:00:07.3
Sep  2 22:47:56 dali kernel: PM: Adding info for pci:0000:00:09.0
Sep  2 22:47:56 dali kernel: PM: Adding info for pci:0000:00:0a.0
Sep  2 22:47:56 dali kernel: PM: Adding info for pci:0000:00:0a.1
Sep  2 22:47:56 dali kernel: PM: Adding info for pci:0000:00:0b.0
Sep  2 22:47:56 dali kernel: PM: Adding info for pci:0000:00:0b.1
Sep  2 22:47:56 dali kernel: PM: Adding info for pci:0000:01:00.0
Sep  2 22:47:56 dali kernel: ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
Sep  2 22:47:56 dali kernel: Linux Plug and Play Support v0.97 (c) Adam Belay
Sep  2 22:47:56 dali kernel: PnPBIOS: Scanning system for PnP BIOS support...
Sep  2 22:47:56 dali kernel: PnPBIOS: Found PnP BIOS installation structure at 0xc00fc060
Sep  2 22:47:56 dali kernel: PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xc088, dseg 0xf0000
Sep  2 22:47:56 dali kernel: PM: Adding info for No Bus:pnp0
Sep  2 22:47:56 dali kernel: PM: Adding info for pnp:00:00
Sep  2 22:47:56 dali kernel: PM: Adding info for pnp:00:01
Sep  2 22:47:56 dali kernel: PM: Adding info for pnp:00:02
Sep  2 22:47:56 dali kernel: PM: Adding info for pnp:00:03
Sep  2 22:47:56 dali kernel: PM: Adding info for pnp:00:04
Sep  2 22:47:56 dali kernel: PM: Adding info for pnp:00:05
Sep  2 22:47:56 dali kernel: PM: Adding info for pnp:00:06
Sep  2 22:47:56 dali kernel: PM: Adding info for pnp:00:07
Sep  2 22:47:56 dali kernel: PM: Adding info for pnp:00:08
Sep  2 22:47:56 dali kernel: PM: Adding info for pnp:00:09
Sep  2 22:47:56 dali kernel: PM: Adding info for pnp:00:0c
Sep  2 22:47:56 dali kernel: PM: Adding info for pnp:00:0d
Sep  2 22:47:56 dali kernel: PM: Adding info for pnp:00:0f
Sep  2 22:47:56 dali kernel: PM: Adding info for pnp:00:10
Sep  2 22:47:56 dali kernel: PnPBIOS: 14 nodes reported by PnP BIOS; 14 recorded by driver
Sep  2 22:47:56 dali kernel: SCSI subsystem initialized
Sep  2 22:47:56 dali kernel: drivers/usb/core/usb.c: registered new driver usbfs
Sep  2 22:47:56 dali kernel: drivers/usb/core/usb.c: registered new driver hub
Sep  2 22:47:56 dali kernel: PCI: Using ACPI for IRQ routing
Sep  2 22:47:56 dali kernel: PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
Sep  2 22:47:56 dali kernel: rivafb: nVidia device/chipset 10DE0110
Sep  2 22:47:56 dali kernel: rivafb: Detected CRTC controller 0 being used
Sep  2 22:47:56 dali kernel: rivafb: RIVA MTRR set to ON
Sep  2 22:47:56 dali kernel: rivafb: PCI nVidia NV10 framebuffer ver 0.9.5b (nVidiaGeForce2-M, 32MB @ 0xD8000000)
Sep  2 22:47:56 dali kernel: IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
Sep  2 22:47:56 dali kernel: ikconfig 0.5 with /proc/ikconfig
Sep  2 22:47:56 dali kernel: Journalled Block Device driver loaded
Sep  2 22:47:56 dali kernel: devfs: v1.22 (20021013) Richard Gooch (rgooch@atnf.csiro.au)
Sep  2 22:47:56 dali kernel: devfs: boot_options: 0x1
Sep  2 22:47:56 dali kernel: udf: registering filesystem
Sep  2 22:47:56 dali kernel: Activating ISA DMA hang workarounds.
Sep  2 22:47:56 dali kernel: ACPI: Power Button (FF) [PWRF]
Sep  2 22:47:56 dali kernel: ACPI: Sleep Button (CM) [SLPB]
Sep  2 22:47:56 dali kernel: ACPI: Processor [CPU0] (supports C1 C2, 2 throttling states)
Sep  2 22:47:56 dali kernel: PM: Adding info for No Bus:pnp1
Sep  2 22:47:56 dali kernel: isapnp: Scanning for PnP cards...
Sep  2 22:47:56 dali kernel: isapnp: No Plug & Play device found
Sep  2 22:47:56 dali kernel: Real Time Clock Driver v1.11a
Sep  2 22:47:56 dali kernel: Non-volatile memory driver v1.2
Sep  2 22:47:56 dali kernel: Linux agpgart interface v0.100 (c) Dave Jones
Sep  2 22:47:56 dali kernel: Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
Sep  2 22:47:56 dali kernel: parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
Sep  2 22:47:56 dali kernel: parport0: irq 7 detected
Sep  2 22:47:56 dali kernel: parport0: cpp_daisy: aa5500ff(38)
Sep  2 22:47:56 dali kernel: parport0: assign_addrs: aa5500ff(38)
Sep  2 22:47:56 dali kernel: parport0: cpp_daisy: aa5500ff(38)
Sep  2 22:47:56 dali kernel: parport0: assign_addrs: aa5500ff(38)
Sep  2 22:47:56 dali kernel: Floppy drive(s): fd0 is 1.44M
Sep  2 22:47:56 dali kernel: FDC 0 is a post-1991 82077
Sep  2 22:47:56 dali kernel: PM: Adding info for platform:floppy0
Sep  2 22:47:56 dali kernel: Intel(R) PRO/100 Network Driver - version 2.3.18-k1
Sep  2 22:47:56 dali kernel: Copyright (c) 2003 Intel Corporation
Sep  2 22:47:56 dali kernel: 
Sep  2 22:47:56 dali kernel: e100: selftest OK.
Sep  2 22:47:56 dali kernel: e100: eth0: Intel(R) PRO/100 Network Connection
Sep  2 22:47:56 dali kernel: 
Sep  2 22:47:56 dali kernel: Linux video capture interface: v1.00
Sep  2 22:47:56 dali kernel: Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
Sep  2 22:47:56 dali kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Sep  2 22:47:56 dali kernel: VP_IDE: IDE controller at PCI slot 0000:00:07.1
Sep  2 22:47:56 dali kernel: VP_IDE: chipset revision 16
Sep  2 22:47:56 dali kernel: VP_IDE: not 100%% native mode: will probe irqs later
Sep  2 22:47:56 dali kernel: ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
Sep  2 22:47:56 dali kernel: VP_IDE: VIA vt82c596b (rev 23) IDE UDMA66 controller on pci0000:00:07.1
Sep  2 22:47:56 dali kernel:     ide0: BM-DMA at 0xd000-0xd007, BIOS settings: hda:DMA, hdb:DMA
Sep  2 22:47:56 dali kernel:     ide1: BM-DMA at 0xd008-0xd00f, BIOS settings: hdc:DMA, hdd:DMA
Sep  2 22:47:56 dali kernel: PM: Adding info for No Bus:ide0
Sep  2 22:47:56 dali kernel: PM: Adding info for ide:0.0
Sep  2 22:47:56 dali kernel: PM: Adding info for ide:0.1
Sep  2 22:47:56 dali kernel: PM: Adding info for No Bus:ide1
Sep  2 22:47:56 dali kernel: PM: Adding info for ide:1.0
Sep  2 22:47:56 dali kernel: PM: Adding info for ide:1.1
Sep  2 22:47:56 dali kernel: hda: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(66)
Sep  2 22:47:56 dali kernel:  /dev/ide/host0/bus0/target0/lun0: p1 p2 p3
Sep  2 22:47:56 dali kernel: hdb: Host Protected Area detected.
Sep  2 22:47:56 dali kernel: hdb: 156250000 sectors (80000 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(66)
Sep  2 22:47:56 dali kernel:  /dev/ide/host0/bus0/target1/lun0: p1 p2 p3 p4 < p5 p6 p7 >
Sep  2 22:47:56 dali kernel: Uniform CD-ROM driver Revision: 3.12
Sep  2 22:47:56 dali kernel: drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver v2.1
Sep  2 22:47:56 dali kernel: uhci-hcd 0000:00:07.2: UHCI Host Controller
Sep  2 22:47:56 dali kernel: uhci-hcd 0000:00:07.2: irq 10, io base 0000d400
Sep  2 22:47:56 dali kernel: uhci-hcd 0000:00:07.2: new USB bus registered, assigned bus number 1
Sep  2 22:47:56 dali kernel: PM: Adding info for usb:usb1
Sep  2 22:47:56 dali kernel: hub 1-0:0: USB hub found
Sep  2 22:47:56 dali kernel: hub 1-0:0: 2 ports detected
Sep  2 22:47:56 dali kernel: PM: Adding info for usb:1-0:0
Sep  2 22:47:56 dali kernel: drivers/usb/core/usb.c: registered new driver usblp
Sep  2 22:47:56 dali kernel: drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Sep  2 22:47:56 dali kernel: Initializing USB Mass Storage driver...
Sep  2 22:47:56 dali kernel: drivers/usb/core/usb.c: registered new driver usb-storage
Sep  2 22:47:56 dali kernel: USB Mass Storage support registered.
Sep  2 22:47:56 dali kernel: drivers/usb/core/usb.c: registered new driver hiddev
Sep  2 22:47:56 dali kernel: drivers/usb/core/usb.c: registered new driver hid
Sep  2 22:47:56 dali kernel: drivers/usb/input/hid-core.c: v2.0:USB HID core driver
Sep  2 22:47:56 dali kernel: drivers/usb/core/usb.c: registered new driver usbscanner
Sep  2 22:47:56 dali kernel: drivers/usb/image/scanner.c: 0.4.14:USB Scanner Driver
Sep  2 22:47:56 dali kernel: mice: PS/2 mouse device common for all mice
Sep  2 22:47:56 dali kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
Sep  2 22:47:56 dali kernel: input: AT Set 2 keyboard on isa0060/serio0
Sep  2 22:47:56 dali kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
Sep  2 22:47:56 dali kernel: I2O Core - (C) Copyright 1999 Red Hat Software
Sep  2 22:47:56 dali kernel: I2O: Event thread created as pid 12
Sep  2 22:47:56 dali kernel: i2o: Checking for PCI I2O controllers...
Sep  2 22:47:56 dali kernel: I2O configuration manager v 0.04.
Sep  2 22:47:56 dali kernel:   (C) Copyright 1999 Red Hat Software
Sep  2 22:47:56 dali kernel: I2O Block Storage OSM v0.9
Sep  2 22:47:56 dali kernel:    (c) Copyright 1999-2001 Red Hat Software.
Sep  2 22:47:56 dali kernel: i2o_block: Checking for Boot device...
Sep  2 22:47:56 dali kernel: i2o_block: Checking for I2O Block devices...
Sep  2 22:47:56 dali kernel: i2c /dev entries driver module version 2.7.0 (20021208)
Sep  2 22:47:56 dali kernel: Advanced Linux Sound Architecture Driver Version 0.9.6 (Wed Aug 20 20:27:13 2003 UTC).
Sep  2 22:47:56 dali kernel: request_module: failed /sbin/modprobe -- snd-card-0. error = -16
Sep  2 22:47:56 dali kernel: ALSA device list:
Sep  2 22:47:56 dali kernel:   #0: Sound Blaster Live! (rev.10) at 0xdc00, irq 5
Sep  2 22:47:56 dali kernel: NET4: Linux TCP/IP 1.0 for NET4.0
Sep  2 22:47:56 dali kernel: IP: routing cache hash table of 8192 buckets, 64Kbytes
Sep  2 22:47:56 dali kernel: TCP: Hash tables configured (established 262144 bind 65536)
Sep  2 22:47:56 dali kernel: NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Sep  2 22:47:56 dali kernel: BIOS EDD facility v0.09 2003-Jan-22, 2 devices found
Sep  2 22:47:56 dali kernel: ACPI: (supports S0 S1 S4 S4bios S5)
Sep  2 22:47:56 dali kernel: hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
Sep  2 22:47:56 dali kernel: EXT3-fs: INFO: recovery required on readonly filesystem.
Sep  2 22:47:56 dali kernel: EXT3-fs: write access will be enabled during recovery.
Sep  2 22:47:56 dali kernel: kjournald starting.  Commit interval 5 seconds
Sep  2 22:47:56 dali kernel: EXT3-fs: recovery complete.
Sep  2 22:47:56 dali kernel: EXT3-fs: mounted filesystem with ordered data mode.
Sep  2 22:47:56 dali kernel: Mounted devfs on /dev
Sep  2 22:47:56 dali kernel: Freeing unused kernel memory: 188k freed
Sep  2 22:47:56 dali kernel: hub 1-0:0: new USB device on port 1, assigned address 2
Sep  2 22:47:56 dali kernel: PM: Adding info for usb:1-1
Sep  2 22:47:56 dali kernel: input: USB HID v1.00 Mouse [Microsoft Microsoft IntelliMouse® Optical] on usb-0000:00:07.2-1
Sep  2 22:47:56 dali kernel: PM: Adding info for usb:1-1:0
Sep  2 22:47:56 dali kernel: hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x101
Sep  2 22:47:56 dali kernel: hub 1-0:0: new USB device on port 2, assigned address 3
Sep  2 22:47:56 dali kernel: PM: Adding info for usb:1-2
Sep  2 22:47:56 dali kernel: drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 3 if 0 alt 1 proto 2 vid 0x03F0 pid 0x3002
Sep  2 22:47:56 dali kernel: PM: Adding info for usb:1-2:0
Sep  2 22:47:56 dali kernel: EXT3 FS on hdb1, internal journal
Sep  2 22:47:56 dali kernel: Adding 2096472k swap on /dev/hdb2.  Priority:-1 extents:1
Sep  2 22:47:56 dali kernel: kjournald starting.  Commit interval 5 seconds
Sep  2 22:47:56 dali kernel: EXT3 FS on hdb3, internal journal
Sep  2 22:47:56 dali kernel: EXT3-fs: mounted filesystem with ordered data mode.
Sep  2 22:47:56 dali kernel: kjournald starting.  Commit interval 5 seconds
Sep  2 22:47:56 dali kernel: EXT3 FS on hdb7, internal journal
Sep  2 22:47:56 dali kernel: EXT3-fs: mounted filesystem with ordered data mode.
Sep  2 22:47:56 dali kernel: kjournald starting.  Commit interval 5 seconds
Sep  2 22:47:56 dali kernel: EXT3 FS on hdb5, internal journal
Sep  2 22:47:56 dali kernel: EXT3-fs: mounted filesystem with ordered data mode.
Sep  2 22:47:56 dali kernel: kjournald starting.  Commit interval 5 seconds
Sep  2 22:47:56 dali kernel: EXT3 FS on hdb6, internal journal
Sep  2 22:47:56 dali kernel: EXT3-fs: mounted filesystem with ordered data mode.
Sep  2 22:47:56 dali kernel: bttv: driver version 0.9.11 loaded
Sep  2 22:47:56 dali kernel: bttv: using 8 buffers with 2080k (520 pages) each for capture
Sep  2 22:47:56 dali kernel: bttv: Host bridge is 0000:00:00.0
Sep  2 22:47:56 dali kernel: bttv: Host bridge is 0000:00:07.3
Sep  2 22:47:56 dali kernel: bttv: Bt8xx card found (0).
Sep  2 22:47:56 dali kernel: bttv0: Bt878 (rev 17) at 0000:00:0b.0, irq: 10, latency: 64, mmio: 0xe5101000
Sep  2 22:47:56 dali kernel: bttv0: detected: Pinnacle PCTV [card=39], PCI subsystem ID is 11bd:0012
Sep  2 22:47:56 dali kernel: bttv0: using: BT878(Pinnacle PCTV Studio/Ra) [card=39,autodetected]
Sep  2 22:47:56 dali kernel: PM: Adding info for No Bus:i2c-0
Sep  2 22:47:56 dali kernel: bttv0: i2c: checking for MSP34xx @ 0x80... not found
Sep  2 22:47:56 dali kernel: bttv0: miro: id=3 tuner=2 radio=no stereo=no
Sep  2 22:47:56 dali kernel: bttv0: i2c: checking for MSP34xx @ 0x80... not found
Sep  2 22:47:56 dali kernel: bttv0: i2c: checking for TDA9875 @ 0xb0... not found
Sep  2 22:47:56 dali kernel: bttv0: i2c: checking for TDA7432 @ 0x8a... not found
Sep  2 22:47:56 dali kernel: bttv0: registered device video0
Sep  2 22:47:56 dali kernel: bttv0: registered device vbi0
Sep  2 22:47:56 dali kernel: bttv0: PLL: 28636363 => 35468950 .. ok
Sep  2 22:47:56 dali kernel: loop: loaded (max 8 devices)
Sep  2 22:47:56 dali kernel: btaudio: driver version 0.7 loaded [digital+analog]
Sep  2 22:47:56 dali kernel: btaudio: Bt878 (rev 17) at 00:0b.1, irq: 10, latency: 64, mmio: 0xe5102000
Sep  2 22:47:56 dali kernel: btaudio: registered device dsp1 [digital]
Sep  2 22:47:56 dali kernel: btaudio: registered device dsp2 [analog]
Sep  2 22:47:56 dali kernel: btaudio: registered device mixer1
Sep  2 22:47:56 dali kernel: apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
Sep  2 22:47:56 dali kernel: apm: overridden by ACPI.
Sep  2 22:47:56 dali kernel: NTFS driver 2.1.4 [Flags: R/O MODULE].
Sep  2 22:47:56 dali kernel: nbd: registered device at major 43
Sep  2 22:47:56 dali kernel: PM: Adding info for No Bus:i2c-1
Sep  2 22:47:56 dali kernel: PM: Adding info for i2c:0-0060
Sep  2 22:47:56 dali kernel: Universal TUN/TAP device driver 1.5 (C)1999-2002 Maxim Krasnyansky
Sep  2 22:47:56 dali kernel: pwc Philips PCA645/646 + PCVC675/680/690 + PCVC730/740/750 webcam module version 8.11 loaded.
Sep  2 22:47:56 dali kernel: pwc Also supports the Askey VC010, various Logitech QuickCams, Samsung MPC-C10 and MPC-C30,
Sep  2 22:47:56 dali kernel: pwc the Creative WebCam 5, SOTEC Afina Eye and Visionite VCS-UC300 and VCS-UM100.
Sep  2 22:47:56 dali kernel: drivers/usb/core/usb.c: registered new driver Philips webcam
Sep  2 22:47:56 dali kernel: drivers/usb/media/se401.c: SE401 usb camera driver version 0.24 registering
Sep  2 22:47:56 dali kernel: drivers/usb/core/usb.c: registered new driver se401
Sep  2 22:47:56 dali kernel: drivers/usb/core/usb.c: registered new driver ov511
Sep  2 22:47:56 dali kernel: drivers/usb/media/ov511.c: v1.64 for Linux 2.5 : ov511 USB Camera Driver
Sep  2 22:47:56 dali kernel: drivers/usb/core/usb.c: registered new driver rio500
Sep  2 22:47:56 dali kernel: drivers/usb/misc/rio500.c: v1.1:USB Rio 500 driver
Sep  2 22:47:56 dali kernel: drivers/usb/core/usb.c: registered new driver uss720
Sep  2 22:47:56 dali kernel: drivers/usb/misc/uss720.c: v0.5:USB Parport Cable driver for Cables using the Lucent Technologies USS720 Chip
Sep  2 22:47:56 dali kernel: drivers/usb/serial/usb-serial.c: USB Serial support registered for Generic
Sep  2 22:47:56 dali kernel: drivers/usb/core/usb.c: registered new driver usbserial
Sep  2 22:47:56 dali kernel: drivers/usb/serial/usb-serial.c: USB Serial Driver core v2.0
Sep  2 22:47:56 dali kernel: drivers/usb/core/usb.c: registered new driver microtekX6
Sep  2 22:47:56 dali kernel: drivers/usb/core/usb.c: registered new driver hpusbscsi
Sep  2 22:47:56 dali kernel: NTFS volume version 3.0.
Sep  2 22:48:05 dali kernel: microcode: CPU0 already at revision 1 (current=1)
Sep  2 22:48:05 dali kernel: microcode: freed 2048 bytes
Sep  2 23:31:15 dali kernel: bttv0: PLL can sleep, using XTAL (28636363).
Sep  2 23:34:33 dali kernel: bttv0: PLL: 28636363 => 35468950 .. ok
Sep  2 23:34:33 dali kernel: bttv0: PLL can sleep, using XTAL (28636363).

--------------070703080008000607010707
Content-Type: text/plain;
 name="kernel_warnings"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kernel_warnings"

Sep  2 22:47:56 dali kernel: Linux version 2.6.0-test4 (root@dali.aqua.com) (gcc version 3.3.1 (Mandrake Linux 9.2 3.3.1-0.7mdk)) #2 Tue Sep 2 19:55:57 CDT 2003
Sep  2 22:47:56 dali kernel: Video mode to be used for restore is f00
Sep  2 22:47:56 dali kernel:  BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
Sep  2 22:47:56 dali kernel:  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
Sep  2 22:47:56 dali kernel:  BIOS-e820: 0000000000100000 - 0000000037ff0000 (usable)
Sep  2 22:47:56 dali kernel:  BIOS-e820: 0000000037ff0000 - 0000000037ff3000 (ACPI NVS)
Sep  2 22:47:56 dali kernel:  BIOS-e820: 0000000037ff3000 - 0000000038000000 (ACPI data)
Sep  2 22:47:56 dali kernel:  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
Sep  2 22:47:56 dali kernel: On node 0 totalpages: 229360
Sep  2 22:47:56 dali kernel:   DMA zone: 4096 pages, LIFO batch:1
Sep  2 22:47:56 dali kernel:   Normal zone: 225264 pages, LIFO batch:16
Sep  2 22:47:56 dali kernel:   HighMem zone: 0 pages, LIFO batch:1
Sep  2 22:47:56 dali kernel: ACPI: MADT not present
Sep  2 22:47:56 dali kernel: Building zonelist for node : 0
Sep  2 22:47:56 dali kernel: Kernel command line: BOOT_IMAGE=new_linux ro root=341 devfs=mount video=rivafb:1024x768-24@100 -s
Sep  2 22:47:56 dali kernel: Local APIC disabled by BIOS -- reenabling.
Sep  2 22:47:56 dali kernel: Found and enabled local APIC!
Sep  2 22:47:56 dali kernel: PID hash table entries: 4096 (order 12: 32768 bytes)
Sep  2 22:47:56 dali kernel: Detected 997.828 MHz processor.
Sep  2 22:47:56 dali kernel: Console: colour VGA+ 80x25
Sep  2 22:47:56 dali kernel: Calibrating delay loop... 1970.17 BogoMIPS
Sep  2 22:47:56 dali kernel: Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Sep  2 22:47:56 dali kernel: Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Sep  2 22:47:56 dali kernel: CPU: Intel Pentium III (Coppermine) stepping 0a
Sep  2 22:47:56 dali kernel: POSIX conformance testing by UNIFIX
Sep  2 22:47:56 dali kernel: enabled ExtINT on CPU#0
Sep  2 22:47:56 dali kernel: ESR value before enabling vector: 00000000
Sep  2 22:47:56 dali kernel: ESR value after enabling vector: 00000000
Sep  2 22:47:56 dali kernel: Using local APIC timer interrupts.
Sep  2 22:47:56 dali kernel: calibrating APIC timer ...
Sep  2 22:47:56 dali kernel: ..... CPU clock speed is 997.0327 MHz.
Sep  2 22:47:56 dali kernel: ..... host bus clock speed is 132.0976 MHz.
Sep  2 22:47:56 dali kernel: Initializing RT netlink socket
Sep  2 22:47:56 dali kernel: BIO: pool of 256 setup, 14Kb (56 bytes/bio)
Sep  2 22:47:56 dali kernel: biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
Sep  2 22:47:56 dali kernel: biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
Sep  2 22:47:56 dali kernel: biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
Sep  2 22:47:56 dali kernel: biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
Sep  2 22:47:56 dali kernel: biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
Sep  2 22:47:56 dali kernel: biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
Sep  2 22:47:56 dali kernel: PCI: Probing PCI hardware (bus 00)
Sep  2 22:47:56 dali kernel: ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
Sep  2 22:47:56 dali kernel: ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 *12 14 15)
Sep  2 22:47:56 dali kernel: ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
Sep  2 22:47:56 dali kernel: ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
Sep  2 22:47:56 dali kernel: ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 10
Sep  2 22:47:56 dali kernel: ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 11
Sep  2 22:47:56 dali kernel: ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
Sep  2 22:47:56 dali kernel: ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
Sep  2 22:47:56 dali kernel: pty: 256 Unix98 ptys configured
Sep  2 22:47:56 dali kernel: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
Sep  2 22:47:56 dali kernel: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Sep  2 22:47:56 dali kernel: Using anticipatory scheduling elevator
Sep  2 22:47:56 dali kernel: hda: WDC WD600BB-32BSA0, ATA DISK drive
Sep  2 22:47:56 dali kernel: hdb: WDC WD800BB-75CAA0, ATA DISK drive
Sep  2 22:47:56 dali kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Sep  2 22:47:56 dali kernel: hdc: SAMSUNG CD-R/RW SW-216B Q001 20010913, ATAPI CD/DVD-ROM drive
Sep  2 22:47:56 dali kernel: hdd: DVD-ROM DDU1621, ATAPI CD/DVD-ROM drive
Sep  2 22:47:56 dali kernel: ide1 at 0x170-0x177,0x376 on irq 15
Sep  2 22:47:56 dali kernel: hda: max request size: 128KiB
Sep  2 22:47:56 dali kernel: hdb: max request size: 128KiB
Sep  2 22:47:56 dali kernel: ^Icurrent capacity is 156250000 sectors (80000 MB)
Sep  2 22:47:56 dali kernel: ^Inative  capacity is 156301488 sectors (80026 MB)
Sep  2 22:47:56 dali kernel: hdc: ATAPI 32X CD-ROM CD-R/RW drive, 2048kB Cache, DMA
Sep  2 22:47:56 dali kernel: end_request: I/O error, dev hdd, sector 0
Sep  2 22:47:56 dali kernel: hdd: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)
Sep  2 22:47:56 dali kernel: VFS: Mounted root (ext3 filesystem) readonly.
Sep  2 22:47:56 dali kernel: bttv0: using tuner=2
Sep  2 22:47:56 dali kernel: videodev: "BT878(Pinnacle PCTV Studio/Ra)" has no release callback. Please fix your driver for proper sysfs support, see http://lwn.net/Articles/36850/
Sep  2 22:47:56 dali kernel: videodev: "bt848/878 vbi" has no release callback. Please fix your driver for proper sysfs support, see http://lwn.net/Articles/36850/
Sep  2 22:47:56 dali kernel: btaudio: using card config "default"
Sep  2 22:47:56 dali kernel: tuner: chip found @ 0xc0
Sep  2 22:47:56 dali kernel: tuner: type set to 2 (Philips NTSC (FI1236,FM1236 and compatibles))
Sep  2 22:47:56 dali kernel: registering 0-0060
Sep  2 22:50:26 dali kernel: process `named' is using obsolete setsockopt SO_BSDCOMPAT
Sep  2 22:50:26 dali last message repeated 5 times
Sep  2 22:50:31 dali kernel: smbfs: Unrecognized mount option noexec
Sep  2 22:51:16 dali last message repeated 2 times

--------------070703080008000607010707--

