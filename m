Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263395AbTHWM6b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 08:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263288AbTHWM6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 08:58:31 -0400
Received: from adsl-217-226.38-151.net24.it ([151.38.226.217]:14602 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S263529AbTHWM6Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 08:58:16 -0400
Date: Sat, 23 Aug 2003 14:58:12 +0200
From: Daniele Venzano <webvenza@libero.it>
To: acpi-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Invalid PBLK length for athlon XP-M on Asus laptop
Message-ID: <20030823125812.GC913@renditai.milesteg.arr>
Mail-Followup-To: acpi-devel@lists.sourceforge.net,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.21
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

My laptop is an Asus L3100 with an AMD Athlon XP-M 2000. ACPI says it
has only C1 power state:

# cat /proc/acpi/processor/CPU0/power
active state:            C1
default state:           C1
bus master activity:     00000000
states:
   *C1:                  promotion[--] demotion[--] latency[000] usage[00000000]
    C2:                  <not supported>
    C3:                  <not supported>

and
# cat /proc/acpi/processor/CPU0/info
processor id:            0
acpi id:                 1
bus mastering control:   no
power management:        no
throttling control:      no
performance management:  no
limit interface:         no

Since this is a laptop it seemed a bit strange to me 8), so I checked
dmesg with acpi debugging turned on (full dmesg is attached), and I
found these:

[.....]
ACPI: Fan [FAN0] (on)
acpi_processor-1626 [30] acpi_processor_get_inf: Invalid PBLK length [5]
ACPI: Processor [CPU0] (supports C1)
ACPI: Thermal Zone [THRM] (44 C)
Asus Laptop ACPI Extras version 0.24a
  L3D model detected, supported
  Notify Handler installed successfully

[.....]

NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
acpi_processor_perf-0104 [28] acpi_processor_get_per: Unsupported address space [127] (control_register)
cpufreq: No CPUs supporting ACPI performance management found.
ACPI: (supports S0 S1 S3 S4 S5)
[.....]

Is there something I can do to add support for this laptop ? I'm not
feeling confortable with a battery that lasts ~40 minutes...

Everything else works fine, even swsusp and additional leds thanks to
acpi4asus. I'm using 2.6.0-test4, but I tested also 2.6.0-test3 and
2.5.72.

Other /proc/acpi files follows.

/proc/acpi/asus/info
Asus Laptop ACPI Extras Driver 0.24a
Model reference    : L3D
ACPI signature     : DSDT
Table length       : 16940
ACPI minor version : 1
Checksum           : 80
OEM identification : ASUS
OEM table id       : L3000D  
OEM rev number     : 0x1000
ASL comp vendor ID : MSFT
ASL comp rev number: 0x100000e

/proc/acpi/thermal_zone/THRM/trip_points
critical (S5):           103 C
passive:                 90 C: tc1=1 tc2=4 tsp=300 devices=0xddf37768 
active[0]:               70 C: devices=0xddf2c7e8 

/proc/acpi/thermal_zone/THRM/temperature
temperature:             58 C

/proc/acpi/thermal_zone/THRM/state
state:                   ok

/proc/acpi/processor/CPU0/limit
<not supported>

/proc/acpi/processor/CPU0/throttling
<not supported>

/proc/acpi/fan/FAN0/state
status:                  on

/proc/acpi/button/lid/LID/state
state:      open

/proc/acpi/button/lid/LID/info
type:                    Lid Switch

present:                 yes
design capacity:         5000 mAh
last full capacity:      5000 mAh
battery technology:      rechargeable
design voltage:          14000 mV
design capacity warning: 500 mAh
design capacity low:     50 mAh
capacity granularity 1:  100 mAh
capacity granularity 2:  100 mAh
model number:            BA-03
serial number:            
battery type:            LIon
OEM info:                ASUSTek

/proc/acpi/debug_level
0x0000000f
/proc/acpi/debug_layer
0xffff3fff

/proc/acpi/info
version:                 20030813

Any help is much appreciated.
-- 
----------------------------------------
Daniele Venzano
Web: http://digilander.iol.it/webvenza/


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg-acpi

Linux version 2.6.0-test4 (root@tabr) (gcc version 3.3.1 20030626 (Debian prerelease)) #3 Sat Aug 23 11:49:00 CEST 2003
Video mode to be used for restore is ffff
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001dfea000 (usable)
 BIOS-e820: 000000001dfea000 - 000000001dfef000 (ACPI data)
 BIOS-e820: 000000001dfef000 - 000000001dfff000 (reserved)
 BIOS-e820: 000000001dfff000 - 000000001e000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
479MB LOWMEM available.
On node 0 totalpages: 122858
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 118762 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
DMI 2.3 present.
ACPI: RSDP (v000 ASUS                                      ) @ 0x000f6e10
ACPI: RSDT (v001 ASUS   L3000D   0x42302e31 MSFT 0x31313031) @ 0x1dfea000
ACPI: FADT (v001 ASUS   L3000D   0x42302e31 MSFT 0x31313031) @ 0x1dfea080
ACPI: BOOT (v001 ASUS   L3000D   0x42302e31 MSFT 0x31313031) @ 0x1dfea040
ACPI: DSDT (v001   ASUS L3000D   0x00001000 MSFT 0x0100000e) @ 0x00000000
Building zonelist for node : 0
Kernel command line: root=/dev/hda3
Initializing CPU#0
PID hash table entries: 2048 (order 11: 16384 bytes)
Detected 1673.782 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 3309.56 BogoMIPS
Memory: 483024k/491432k available (1703k kernel code, 7616k reserved, 733k data, 124k init, 0k highmem)
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
-> /dev
-> /dev/console
-> /root
CPU:     After generic identify, caps: 0383f9ff c1cbf9ff 00000000 00000000
CPU:     After vendor identify, caps: 0383f9ff c1cbf9ff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 256K (64 bytes/line)
CPU:     After all inits, caps: 0383f9ff c1cbf9ff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD mobile AMD Athlon(tm) XP-M 2000+ stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PM: Adding info for No Bus:legacy
Initializing RT netlink socket
PCI: PCI BIOS revision 2.10 entry at 0xf1050, last bus=1
mtrr: v2.0 (20020519)
BIO: pool of 256 setup, 14Kb (56 bytes/bio)
biovec pool[0]:   1 bvecs: 256 entries (12 bytes)
biovec pool[1]:   4 bvecs: 256 entries (48 bytes)
biovec pool[2]:  16 bvecs: 256 entries (192 bytes)
biovec pool[3]:  64 bvecs: 256 entries (768 bytes)
biovec pool[4]: 128 bvecs: 256 entries (1536 bytes)
biovec pool[5]: 256 bvecs: 256 entries (3072 bytes)
ACPI: Subsystem revision 20030813
 tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
Parsing all Control Methods:....................................................................................................................................................................................................
Table [DSDT](id F004) - 558 Objects with 54 Devices 196 Methods 22 Regions
ACPI Namespace successfully loaded at root c039161c
evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 15 [_GPE] 2 regs at 000000000000E420 on int 9
evgpeblk-0748 [06] ev_create_gpe_block   : GPE 16 to 31 [_GPE] 2 regs at 000000000000E430 on int 9
Completing Region/Field/Buffer/Package initialization:....................................................................
Initialized 22/22 Regions 0/0 Fields 21/21 Buffers 25/25 Packages (566 nodes)
Executing all Device _STA and_INI methods:.......................................................
55 Devices found containing: 55 _STA, 2 _INI methods
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 *11 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 11 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 11 14 15, enabled at IRQ 9)
ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 *11 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 *9 11 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 *9 11 14 15)
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 *9 11 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *9 11 14 15)
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
PM: Adding info for No Bus:pci0000:00
PM: Adding info for pci:0000:00:00.0
PM: Adding info for pci:0000:00:01.0
PM: Adding info for pci:0000:00:02.0
PM: Adding info for pci:0000:00:02.5
PM: Adding info for pci:0000:00:02.6
PM: Adding info for pci:0000:00:02.7
PM: Adding info for pci:0000:00:03.0
PM: Adding info for pci:0000:00:03.1
PM: Adding info for pci:0000:00:03.2
PM: Adding info for pci:0000:00:03.3
PM: Adding info for pci:0000:00:04.0
PM: Adding info for pci:0000:00:0a.0
PM: Adding info for pci:0000:00:0a.1
PM: Adding info for pci:0000:00:0a.2
PM: Adding info for pci:0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
ACPI: Power Resource [FN0] (on)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbf10
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbf40, dseg 0xf0000
PM: Adding info for No Bus:pnp0
PM: Adding info for pnp:00:01
PM: Adding info for pnp:00:02
PM: Adding info for pnp:00:05
PM: Adding info for pnp:00:06
PM: Adding info for pnp:00:07
PM: Adding info for pnp:00:08
PM: Adding info for pnp:00:09
PM: Adding info for pnp:00:0a
PM: Adding info for pnp:00:0b
PM: Adding info for pnp:00:0c
PM: Adding info for pnp:00:0d
PM: Adding info for pnp:00:0e
PM: Adding info for pnp:00:0f
PM: Adding info for pnp:00:10
PM: Adding info for pnp:00:11
PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 5
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
pty: 256 Unix98 ptys configured
SBF: Simple Boot Flag extension found and enabled.
SBF: Setting boot flags 0x1
Machine check exception polling timer started.
powernow: AMD K7 CPU detected.
powernow: PowerNOW! Technology present. Can scale: frequency and voltage.
powernow: Found PSB header at c00f0320
powernow: Table version: 0x12
powernow: Flags: 0x0 (Mobile voltage regulator)
powernow: Settling Time: 100 microseconds.
powernow: Has 1 PST tables. (Only dumping ones relevant to this CPU).
powernow: PST:0 (@c00f0330)
powernow:  cpuid: 0x781	fsb: 133	maxFID: 0x3	startvid: 0xb
powernow:    FID: 0x12 (4.0x [532MHz])	VID: 0x13 (1.200V)
powernow:    FID: 0x4 (5.0x [665MHz])	VID: 0x13 (1.200V)
powernow:    FID: 0x8 (7.0x [931MHz])	VID: 0x13 (1.200V)
powernow:    FID: 0xc (9.0x [1197MHz])	VID: 0xe (1.300V)
powernow:    FID: 0x0 (11.0x [1463MHz])	VID: 0xc (1.400V)
powernow:    FID: 0x3 (12.5x [1662MHz])	VID: 0xb (1.450V)

powernow: Minimum speed 532 MHz. Maximum speed 1662 MHz.
Journalled Block Device driver loaded
Initializing Cryptographic API
ACPI: AC Adapter [AC] (on-line)
ACPI: Battery Slot [BAT0] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Sleep Button (CM) [SLPB]
ACPI: Lid Switch [LID]
ACPI: Fan [FAN0] (on)
acpi_processor-1626 [30] acpi_processor_get_inf: Invalid PBLK length [5]
ACPI: Processor [CPU0] (supports C1)
ACPI: Thermal Zone [THRM] (44 C)
Asus Laptop ACPI Extras version 0.24a
  L3D model detected, supported
  Notify Handler installed successfully
Real Time Clock Driver v1.11a
Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected SiS 740 chipset
agpgart: Maximum main memory to use for agp memory: 409M
agpgart: AGP aperture is 64M @ 0xe8000000
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0 at I/O 0x3f8 (irq = 4) is a NS16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a NS16550A
Using anticipatory scheduling elevator
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
PM: Adding info for platform:floppy0
sis900.c: v1.08.06 9/24/2002
eth0: ICS LAN PHY transceiver found at address 1.
eth0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0xa000, IRQ 11, 00:0c:6e:6c:29:6e.
PPP generic driver version 2.4.2
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS 962/963 MuTIOL IDE UDMA133 controller
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:DMA, hdd:pio
hda: IC25N040ATMR04-0, ATA DISK drive
PM: Adding info for No Bus:ide0
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
PM: Adding info for ide:0.0
hdc: TOSHIBA DVD-ROM SD-R2312, ATAPI CD/DVD-ROM drive
PM: Adding info for No Bus:ide1
ide1 at 0x170-0x177,0x376 on irq 15
PM: Adding info for ide:1.0
hda: max request size: 1024KiB
hda: 78140160 sectors (40007 MB) w/1740KiB Cache, CHS=16383/255/63, UDMA(100)
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 >
mice: PS/2 mouse device common for all mice
i8042.c: Detected active multiplexing controller, rev 1.1.
serio: i8042 AUX0 port at 0x60,0x64 irq 12
serio: i8042 AUX1 port at 0x60,0x64 irq 12
serio: i8042 AUX2 port at 0x60,0x64 irq 12
Synaptics Touchpad, model: 1
 Firware: 4.6
 180 degree mounted touchpad
 Sensor: 18
 new absolute packet format
 Touchpad has extended capability bits
 -> four buttons
 -> multifinger detection
 -> palm detection
input: Synaptics Synaptics TouchPad on isa0060/serio4
serio: i8042 AUX3 port at 0x60,0x64 irq 12
input: AT Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
acpi_processor_perf-0104 [28] acpi_processor_get_per: Unsupported address space [127] (control_register)
cpufreq: No CPUs supporting ACPI performance management found.
ACPI: (supports S0 S1 S3 S4 S5)
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 124k freed
Adding 3654748k swap on /dev/hda7.  Priority:-1 extents:1
EXT3 FS on hda3, internal journal
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
ehci_hcd 0000:00:03.3: EHCI Host Controller
ehci_hcd 0000:00:03.3: irq 5, pci mem de9ee000
ehci_hcd 0000:00:03.3: new USB bus registered, assigned bus number 1
PCI: cache line size of 64 is not supported by device 0000:00:03.3
ehci_hcd 0000:00:03.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
PM: Adding info for usb:usb1
hub 1-0:0: USB hub found
hub 1-0:0: 6 ports detected
PM: Adding info for usb:1-0:0
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
intel8x0: clocking to 48000
EXT2-fs warning (device hda5): ext2_fill_super: mounting ext3 filesystem as ext2

EXT2-fs warning (device hda6): ext2_fill_super: mounting ext3 filesystem as ext2

ohci-hcd: 2003 Feb 24 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ohci-hcd: block sizes: ed 64 td 64
ohci-hcd 0000:00:03.0: OHCI Host Controller
ohci-hcd 0000:00:03.0: irq 11, pci mem dea47000
ohci-hcd 0000:00:03.0: new USB bus registered, assigned bus number 2
PM: Adding info for usb:usb2
hub 2-0:0: USB hub found
hub 2-0:0: 2 ports detected
PM: Adding info for usb:2-0:0
ohci-hcd 0000:00:03.1: OHCI Host Controller
ohci-hcd 0000:00:03.1: irq 5, pci mem dea49000
ohci-hcd 0000:00:03.1: new USB bus registered, assigned bus number 3
PM: Adding info for usb:usb3
hub 3-0:0: USB hub found
hub 3-0:0: 2 ports detected
PM: Adding info for usb:3-0:0
ohci-hcd 0000:00:03.2: OHCI Host Controller
ohci-hcd 0000:00:03.2: irq 11, pci mem dea4b000
ohci-hcd 0000:00:03.2: new USB bus registered, assigned bus number 4
PM: Adding info for usb:usb4
hub 4-0:0: USB hub found
hub 4-0:0: 2 ports detected
PM: Adding info for usb:4-0:0
Disabled Privacy Extensions on device c0333be0(lo)
MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
Bank 0: 8002000000008001
eth0: Media Link On 10mbps half-duplex 
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(28)
parport0: assign_addrs: aa5500ff(28)
parport0: cpp_daisy: aa5500ff(28)
parport0: assign_addrs: aa5500ff(28)
lp0: using parport0 (polling).
hdc: ATAPI 24X DVD-ROM CD-R/RW drive, 2048kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
hdc: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hdc: drive_cmd: error=0x04Aborted Command 
SCSI subsystem initialized
eth0: no IPv6 routers present

--pWyiEgJYm5f9v55/--
