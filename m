Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262884AbTJ3WLg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 17:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbTJ3WLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 17:11:36 -0500
Received: from rumms.uni-mannheim.de ([134.155.50.52]:25527 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S262884AbTJ3WLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 17:11:09 -0500
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Processes receive SIGSEGV if TCQ is enabled
Date: Thu, 30 Oct 2003 23:10:53 +0100
User-Agent: KMail/1.5.9
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org
References: <200310301601.55588.schlicht@uni-mannheim.de> <20031030133316.6bd00b4a.akpm@osdl.org>
In-Reply-To: <20031030133316.6bd00b4a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_txYo/TYOZT+77L2";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200310302310.53798.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_txYo/TYOZT+77L2
Content-Type: multipart/mixed;
  boundary="Boundary-01=_txYo/MZgDa85GVF"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_txYo/MZgDa85GVF
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello again...

On Thursday 30 October 2003 22:33, Andrew Morton wrote:
> Thomas Schlichter <schlicht@uni-mannheim.de> wrote:
> >  today I tried to test TCQ with the linux-2.6.0-test9-mm1 kernel. The
> > config.gz is attached. But after enabling TCQ with 'hdparm -Q1 /dev/hda'
> > newly started processes die due to a received SIGSEGV. No bad kernel
> > messages appear...
>
> Probably we need to turn off TCQ in kernel config until the confidence
> level is higher.
>
> >  Disabling TCQ again doesn't help, only e reboot does...
>
> That will be because you have incorrect program text in pagecache, left
> over from when the driver was in TCQ mode.

Yes, that would explan it...

Well, I tested it with vanilla test9 and it has exaclty the same problems w=
ith=20
TCQ here as test9-mm1 has. This means:

=2D TCQ enabled at boot time (TCQ depth is set to 8) kills the init script
=2D TCQ set to 1 with hdparm kills nearly everything
=2D TCQ set to 8 kills just some programms
=2D TCQ set to 32 seems to work

Attached is the dmesg from vanilla test9 where I set the TCQ depth to 32. I=
f I=20
set it to 1 the messages are the same (as explained in my original mail,=20
there is no warning or error in the logs) except 'hda: tagged command=20
queueing enabled, command queue depth 32' will be 'hda: tagged command=20
queueing enabled, command queue depth 1'...

Btw. hdparam correctly sets the TCQ buffer depth, but TCQ always has to be=
=20
disabled before setting an other TCQ depth, that confused me... ;-)

Regards
   Thomas

--Boundary-01=_txYo/MZgDa85GVF
Content-Type: text/plain;
  charset="iso-8859-1";
  name="dmesg"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="dmesg"

0000000) @ 0x0fff3040
ACPI: MADT (v001 KT400  AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x0fff7000
ACPI: DSDT (v001 KT400  AWRDACPI 0x00001000 MSFT 0x0100000d) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
Processor #0 6:7 APIC version 16
ACPI: LAPIC_NMI (acpi_id[0x00] polarity[0x1] trigger[0x1] lint[0x1])
ACPI: IOAPIC (id[0x02] address[0xfec00000] global_irq_base[0x0])
IOAPIC[0]: Assigned apic_id 2
IOAPIC[0]: apic_id 2, version 3, address 0xfec00000, IRQ 0-23
ACPI: INT_SRC_OVR (bus[0] irq[0x0] global_irq[0x2] polarity[0x0] trigger[0x=
0])
ACPI: INT_SRC_OVR (bus[0] irq[0x9] global_irq[0x9] polarity[0x0] trigger[0x=
0])
ACPI: INT_SRC_OVR (bus[0] irq[0xe] global_irq[0xe] polarity[0x1] trigger[0x=
1])
ACPI: INT_SRC_OVR (bus[0] irq[0xf] global_irq[0xf] polarity[0x1] trigger[0x=
1])
Enabling APIC mode:  Flat.  Using 1 I/O APICs
Using ACPI (MADT) for SMP configuration information
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=3Dlinux ro root=3D305 BOOT_FILE=3D/boo=
t/vmlinuz video=3Dvesafb:mtrr,pmipal,ywrap
Initializing CPU#0
PID hash table entries: 1024 (order 10: 8192 bytes)
Detected 1307.337 MHz processor.
Console: colour dummy device 80x25
Memory: 255656k/262080k available (1880k kernel code, 5696k reserved, 809k =
data, 192k init, 0k highmem)
Calibrating delay loop... 2572.28 BogoMIPS
Security Scaffold v1.0.0 initialized
SELinux:  Initializing.
SELinux:  Starting in permissive mode
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
CPU:     After generic identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU:     After vendor identify, caps: 0383fbff c1c3fbff 00000000 00000000
CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
CPU: L2 Cache: 64K (64 bytes/line)
CPU:     After all inits, caps: 0383fbff c1c3fbff 00000000 00000020
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: AMD Duron(tm) processor stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 n=
ot connected.
=2E.TIMER: vector=3D0x31 pin1=3D2 pin2=3D-1
number of MP IRQ sources: 15.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................
IO APIC #2......
=2E... register #00: 02000000
=2E......    : physical APIC id: 02
=2E......    : Delivery Type: 0
=2E......    : LTS          : 0
=2E... register #01: 00178003
=2E......     : max redirection entries: 0017
=2E......     : PRQ implemented: 1
=2E......     : IO APIC version: 0003
=2E... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:  =20
 00 000 00  1    0    0   0   0    0    0    00
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    0    0   0   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 001 01  0    0    0   0   0    1    1    91
 0e 001 01  0    0    0   0   0    1    1    99
 0f 001 01  0    0    0   0   0    1    1    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 000 00  1    0    0   0   0    0    0    00
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 0:2
IRQ1 -> 0:1
IRQ3 -> 0:3
IRQ4 -> 0:4
IRQ5 -> 0:5
IRQ6 -> 0:6
IRQ7 -> 0:7
IRQ8 -> 0:8
IRQ9 -> 0:9
IRQ10 -> 0:10
IRQ11 -> 0:11
IRQ12 -> 0:12
IRQ13 -> 0:13
IRQ14 -> 0:14
IRQ15 -> 0:15
=2E................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
=2E.... CPU clock speed is 1306.0989 MHz.
=2E.... host bus clock speed is 201.0075 MHz.
NET: Registered protocol family 16
PCI: PCI BIOS revision 2.10 entry at 0xfb3b0, last bus=3D1
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20031002
IOAPIC[0]: Set PCI routing entry (2-9 -> 0x71 -> IRQ 9 Mode:0 Active:0)
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [ALKA] (IRQs 20)
ACPI: PCI Interrupt Link [ALKB] (IRQs 21)
ACPI: PCI Interrupt Link [ALKC] (IRQs 22)
ACPI: PCI Interrupt Link [ALKD] (IRQs 23)
Linux Plug and Play Support v0.97 (c) Adam Belay
PnPBIOS: Scanning system for PnP BIOS support...
PnPBIOS: Found PnP BIOS installation structure at 0xc00fbe80
PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0xbeb0, dseg 0xf0000
PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver
IOAPIC[0]: Set PCI routing entry (2-16 -> 0xa9 -> IRQ 16 Mode:1 Active:1)
00:00:08[A] -> 2-16 -> IRQ 16
IOAPIC[0]: Set PCI routing entry (2-17 -> 0xb1 -> IRQ 17 Mode:1 Active:1)
00:00:08[B] -> 2-17 -> IRQ 17
IOAPIC[0]: Set PCI routing entry (2-18 -> 0xb9 -> IRQ 18 Mode:1 Active:1)
00:00:08[C] -> 2-18 -> IRQ 18
IOAPIC[0]: Set PCI routing entry (2-19 -> 0xc1 -> IRQ 19 Mode:1 Active:1)
00:00:08[D] -> 2-19 -> IRQ 19
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-16 already programmed
Pin 2-17 already programmed
_CRS returns NULL! Using IRQ 21 for device (PCI Interrupt Link [ALKB]).
ACPI: PCI Interrupt Link [ALKB] enabled at IRQ 21
IOAPIC[0]: Set PCI routing entry (2-21 -> 0xc9 -> IRQ 21 Mode:1 Active:1)
00:00:10[A] -> 2-21 -> IRQ 21
Pin 2-21 already programmed
Pin 2-21 already programmed
Pin 2-21 already programmed
_CRS returns NULL! Using IRQ 20 for device (PCI Interrupt Link [ALKA]).
ACPI: PCI Interrupt Link [ALKA] enabled at IRQ 20
IOAPIC[0]: Set PCI routing entry (2-20 -> 0xd1 -> IRQ 20 Mode:1 Active:1)
00:00:11[A] -> 2-20 -> IRQ 20
Pin 2-21 already programmed
_CRS returns NULL! Using IRQ 22 for device (PCI Interrupt Link [ALKC]).
ACPI: PCI Interrupt Link [ALKC] enabled at IRQ 22
IOAPIC[0]: Set PCI routing entry (2-22 -> 0xd9 -> IRQ 22 Mode:1 Active:1)
00:00:11[C] -> 2-22 -> IRQ 22
_CRS returns NULL! Using IRQ 23 for device (PCI Interrupt Link [ALKD]).
ACPI: PCI Interrupt Link [ALKD] enabled at IRQ 23
IOAPIC[0]: Set PCI routing entry (2-23 -> 0xe1 -> IRQ 23 Mode:1 Active:1)
00:00:11[D] -> 2-23 -> IRQ 23
Pin 2-16 already programmed
Pin 2-17 already programmed
Pin 2-18 already programmed
Pin 2-19 already programmed
Pin 2-23 already programmed
Pin 2-23 already programmed
Pin 2-23 already programmed
Pin 2-23 already programmed
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=3Dnoacpi' or even 'a=
cpi=3Doff'
divert: not allocating divert_blk for non-ethernet device lo
vesafb: framebuffer at 0xd8000000, mapped to 0xd080b000, size 16384k
vesafb: mode is 1024x768x16, linelength=3D2048, pages=3D0
vesafb: protected mode interface info at c000:c2c0
vesafb: pmi: set display start =3D c00cc305, set palette =3D c00cc38a
vesafb: pmi: ports =3D b4c3 b503 ba03 c003 c103 c403 c503 c603 c703 c803 c9=
03 cc03 ce03 cf03 d003 d103 d203 d303 d403 d503 da03 ff03=20
vesafb: scrolling: ywrap using protected mode interface, yres_virtual=3D8192
vesafb: directcolor: size=3D0:5:6:5, shift=3D0:11:5:0
fb0: VESA VGA frame buffer device
Machine check exception polling timer started.
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16ac)
apm: overridden by ACPI.
Total HugeTLB memory allocated, 0
ikconfig 0.7 with /proc/config*
VFS: Disk quotas dquot_6.5.1
Initializing Cryptographic API
PCI: Via IRQ fixup for 0000:00:10.1, from 11 to 5
PCI: Via IRQ fixup for 0000:00:10.2, from 10 to 5
ACPI: Power Button (FF) [PWRF]
ACPI: Fan [FAN] (on)
ACPI: Processor [CPU0] (supports C1 C2)
ACPI: Thermal Zone [THRM] (41 C)
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Console: switching to colour frame buffer device 128x48
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xec00-0xec07, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xec08-0xec0f, BIOS settings: hdc:DMA, hdd:DMA
hda: IBM-DTLA-307030, ATA DISK drive
Using anticipatory io scheduler
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: PLEXTOR CD-R PX-W8432T, ATAPI CD/DVD-ROM drive
hdd: Pioneer DVD-ROM ATAPIModel DVD-105S 013, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 60036480 sectors (30738 MB) w/1916KiB Cache, CHS=3D59560/16/63, UDMA(1=
00)
 hda: hda1 hda2 hda3 < hda5 hda6 >
hdc: ATAPI 32X CD-ROM CD-R/RW drive, 4096kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
hdd: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)
ide-floppy driver 0.99.newide
Console: switching to colour frame buffer device 128x48
mice: PS/2 mouse device common for all mice
input: PC Speaker
serio: i8042 AUX port at 0x60,0x64 irq 12
input: AT Translated Set 2 keyboard on isa0060/serio0
serio: i8042 KBD port at 0x60,0x64 irq 1
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
BIOS EDD facility v0.10 2003-Oct-11, 1 devices found
Please report your BIOS at http://domsch.com/linux/edd30/results.html
PM: Reading pmdisk image.
PM: Resume from disk failed.
ACPI: (supports S0 S1 S3 S4 S5)
found reiserfs format "3.5" with standard journal
Reiserfs journal params: device hda5, size 8192, journal first block 18, ma=
x trans len 1024, max batch 900, max commit age 30, max trans age 30
reiserfs: checking transaction log (hda5) for (hda5)
reiserfs: replayed 63 transactions in 2 seconds
Using r5 hash to sort names
reiserfs: using 3.5.x disk format
VFS: Mounted root (reiserfs filesystem) readonly.
=46reeing unused kernel memory: 192k freed
NET: Registered protocol family 1
Adding 524656k swap on /dev/hda2.  Priority:-1 extents:1
Real Time Clock Driver v1.12
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq =3D 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq =3D 3) is a 16550A
CAPI Subsystem Rev 1.21.6.8
ksysguardd: numerical sysctl 7 2 1 is obsolete.
8139too Fast Ethernet driver 0.9.26
divert: allocating divert_blk for eth0
eth0: RealTek RTL8139 at 0xd191d000, 00:e0:7d:b5:8b:2a, IRQ 17
eth0:  Identified 8139 chip type 'RTL-8139C'
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
drivers/usb/core/usb.c: registered new driver usbfs
drivers/usb/core/usb.c: registered new driver hub
drivers/usb/host/uhci-hcd.c: USB Universal Host Controller Interface driver=
 v2.1
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: irq 21, io base 0000e000
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: irq 21, io base 0000e400
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: irq 21, io base 0000e800
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ehci_hcd 0000:00:10.3: EHCI Host Controller
ehci_hcd 0000:00:10.3: irq 21, pci mem d191f000
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
ehci_hcd 0000:00:10.3: USB 2.0 enabled, EHCI 1.00, driver 2003-Jun-13
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
hub 1-0:1.0: new USB device on port 1, assigned address 2
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
parport0: cpp_daisy: aa5500ff(38)
parport0: assign_addrs: aa5500ff(38)
lp0: using parport0 (polling).
lp0: console ready
NET: Registered protocol family 10
Disabled Privacy Extensions on device c0365ca0(lo)
IPv6 over IPv4 tunneling driver
divert: not allocating divert_blk for non-ethernet device sit0
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
mtrr: 0xd8000000,0x4000000 overlaps existing 0xd8000000,0x1000000
Linux video capture interface: v1.00
bttv: driver version 0.9.12 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
bttv: Bt8xx card found (0).
bttv0: Bt848 (rev 18) at 0000:00:0c.0, irq: 18, latency: 32, mmio: 0xe20020=
00
bttv0: using: Hauppauge (bt848) [card=3D2,insmod option]
bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
bttv0: Hauppauge eeprom: model=3D60004, tuner=3DPhilips FI1216 MK2 (5), rad=
io=3Dno
bttv0: using tuner=3D5
bttv0: i2c: checking for MSP34xx @ 0x80... not found
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips: tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,t=
ea6420,tda8425,pic16c54 (PV951),ta8874z
tuner: chip found @ 0xc2
tuner: type set to 5 (Philips PAL_BG (FI1216 and compatibles))
registering 0-0061
bttv0: registered device video0
bttv0: registered device vbi0
eth0: no IPv6 routers present
usb 1-1: USB disconnect, address 2
hub 1-0:1.0: new USB device on port 1, assigned address 3
drivers/usb/core/usb.c: registered new driver hiddev
drivers/usb/input/hid-ff.c: hid_ff_init could not find initializer
input: USB HID v1.00 Mouse [Logitech USB-PS/2 Mouse M-BA47] on usb-0000:00:=
10.0-1
drivers/usb/core/usb.c: registered new driver hid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
hda: tagged command queueing enabled, command queue depth 32
Creative EMU10K1 PCI Audio Driver, version 0.20a, 21:49:21 Oct 30 2003
emu10k1: EMU10K1 rev 4 model 0x20 found, IO at 0xd800-0xd81f, IRQ 19
ac97_codec: AC97  codec, id: TRA3 (TriTech TR28023)
ksysguardd: numerical sysctl 7 2 1 is obsolete.

--Boundary-01=_txYo/MZgDa85GVF--

--Boundary-03=_txYo/TYOZT+77L2
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/oYxtYAiN+WRIZzQRAiFWAKCIXGyI60ltf94YB6nI0pJVeiUm7QCdFZ9s
wIPVdGVJVLS9H4nlQR/3nGY=
=/UDb
-----END PGP SIGNATURE-----

--Boundary-03=_txYo/TYOZT+77L2--
