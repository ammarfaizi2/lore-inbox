Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286687AbSBKCtZ>; Sun, 10 Feb 2002 21:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286692AbSBKCtQ>; Sun, 10 Feb 2002 21:49:16 -0500
Received: from oe56.law9.hotmail.com ([64.4.8.191]:21510 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S286687AbSBKCtD>;
	Sun, 10 Feb 2002 21:49:03 -0500
X-Originating-IP: [24.29.113.54]
From: "T. A." <tkhoadfdsaf@hotmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Deadlock problem apparently solved with a ICP GDT RAID controller on a ABit VP6 motherboard.
Date: Sun, 10 Feb 2002 21:49:04 -0500
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0073_01C1B27C.C2551810"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <OE56RaqbC8wSA1XvpFV00012e7e@hotmail.com>
X-OriginalArrivalTime: 11 Feb 2002 02:48:57.0584 (UTC) FILETIME=[A6CCCF00:01C1B2A6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_0073_01C1B27C.C2551810
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Hi,

    Just thought I'd mention it in case anyone else has encountered the same
problem I had been having with this combination.  I reported this a couple
of months ago.  After lots of trial and error I finally found that using the
pirq="" kernel option to specify the PCI irqs apparently fixes the deadlock
problem I was having.  Once I set this parameter the RAID is able to survive
a good number of stress tests.  Funny thing is that it doesn't matter much
how I configure the pirq option.  Setting this to pretty much anything and
in any order just makes the system work.  This is despite what the
documentation on pirq says in that you have to specify exactly what the
motherboard assigns to the pci slots, usually found with trial an error.
One weird thing though.  The USB irq and possibly others are consistently
remapped by the kernel on bootup anyway despite the pirq assignments and
this trick still seams to work.  I've attached the dmesg on this system in
case anyone wants to take a look into this weirdness.

------=_NextPart_000_0073_01C1B27C.C2551810
Content-Type: application/octet-stream;
	name="dmesg"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="dmesg"

Linux version 2.4.17 (root@Nadia) (gcc version 2.95.3 20010315 =
(release)) #2 SMP Thu Dec 27 02:09:40 EST 2001=0A=
BIOS-provided physical RAM map:=0A=
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)=0A=
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)=0A=
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)=0A=
 BIOS-e820: 0000000000100000 - 0000000007ff0000 (usable)=0A=
 BIOS-e820: 0000000007ff0000 - 0000000007ff3000 (ACPI NVS)=0A=
 BIOS-e820: 0000000007ff3000 - 0000000008000000 (ACPI data)=0A=
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)=0A=
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)=0A=
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)=0A=
found SMP MP-table at 000f5700=0A=
hm, page 000f5000 reserved twice.=0A=
hm, page 000f6000 reserved twice.=0A=
hm, page 000f1000 reserved twice.=0A=
hm, page 000f2000 reserved twice.=0A=
On node 0 totalpages: 32752=0A=
zone(0): 4096 pages.=0A=
zone(1): 28656 pages.=0A=
zone(2): 0 pages.=0A=
Intel MultiProcessor Specification v1.4=0A=
    Virtual Wire compatibility mode.=0A=
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000=0A=
Processor #0 Pentium(tm) Pro APIC version 17=0A=
Processor #1 Pentium(tm) Pro APIC version 17=0A=
I/O APIC #2 Version 17 at 0xFEC00000.=0A=
Processors: 2=0A=
Kernel command line: auto BOOT_IMAGE=3DLinux ro root=3D301 =
nmi_watchdog=3D1 pirq=3D10,0,0,0,11,11,10=0A=
PIRQ redirection, working around broken MP-BIOS.=0A=
... PIRQ0 -> IRQ 10=0A=
... PIRQ1 -> IRQ 0=0A=
... PIRQ2 -> IRQ 0=0A=
... PIRQ3 -> IRQ 0=0A=
... PIRQ4 -> IRQ 11=0A=
... PIRQ5 -> IRQ 11=0A=
... PIRQ6 -> IRQ 10=0A=
Initializing CPU#0=0A=
Detected 998.365 MHz processor.=0A=
Console: colour VGA+ 80x25=0A=
Calibrating delay loop... 1992.29 BogoMIPS=0A=
Memory: 126232k/131008k available (1197k kernel code, 4388k reserved, =
323k data, 216k init, 0k highmem)=0A=
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)=0A=
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)=0A=
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)=0A=
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)=0A=
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)=0A=
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor =3D 0=0A=
CPU: L1 I cache: 16K, L1 D cache: 16K=0A=
CPU: L2 cache: 256K=0A=
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000=0A=
Intel machine check architecture supported.=0A=
Intel machine check reporting enabled on CPU#0.=0A=
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000=0A=
CPU:             Common caps: 0383fbff 00000000 00000000 00000000=0A=
Enabling fast FPU save and restore... done.=0A=
Enabling unmasked SIMD FPU exception support... done.=0A=
Checking 'hlt' instruction... OK.=0A=
POSIX conformance testing by UNIFIX=0A=
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)=0A=
mtrr: detected mtrr type: Intel=0A=
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor =3D 0=0A=
CPU: L1 I cache: 16K, L1 D cache: 16K=0A=
CPU: L2 cache: 256K=0A=
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000=0A=
Intel machine check reporting enabled on CPU#0.=0A=
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000=0A=
CPU:             Common caps: 0383fbff 00000000 00000000 00000000=0A=
CPU0: Intel Pentium III (Coppermine) stepping 0a=0A=
per-CPU timeslice cutoff: 730.97 usecs.=0A=
enabled ExtINT on CPU#0=0A=
ESR value before enabling vector: 00000000=0A=
ESR value after enabling vector: 00000000=0A=
Booting processor 1/1 eip 2000=0A=
Initializing CPU#1=0A=
masked ExtINT on CPU#1=0A=
ESR value before enabling vector: 00000000=0A=
ESR value after enabling vector: 00000000=0A=
Calibrating delay loop... 1992.29 BogoMIPS=0A=
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor =3D 0=0A=
CPU: L1 I cache: 16K, L1 D cache: 16K=0A=
CPU: L2 cache: 256K=0A=
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000=0A=
Intel machine check reporting enabled on CPU#1.=0A=
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000=0A=
CPU:             Common caps: 0383fbff 00000000 00000000 00000000=0A=
CPU1: Intel Pentium III (Coppermine) stepping 0a=0A=
Total of 2 processors activated (3984.58 BogoMIPS).=0A=
ENABLING IO-APIC IRQs=0A=
Setting 2 in the phys_id_present_map=0A=
...changing IO-APIC physical APIC ID to 2 ... ok.=0A=
init IO_APIC IRQs=0A=
 IO-APIC (apicid-pin) 2-0, 2-5, 2-10, 2-11, 2-17<7>using PIRQ2 -> IRQ 11=0A=
using PIRQ2 -> IRQ 11=0A=
using PIRQ3 -> IRQ 11=0A=
using PIRQ2 -> IRQ 11=0A=
, 2-20, 2-21, 2-22, 2-23 not connected.=0A=
..TIMER: vector=3D0x31 pin1=3D2 pin2=3D0=0A=
activating NMI Watchdog ... done.=0A=
testing NMI watchdog ... OK.=0A=
number of MP IRQ sources: 20.=0A=
number of IO-APIC #2 registers: 24.=0A=
testing the IO APIC.......................=0A=
=0A=
IO APIC #2......=0A=
.... register #00: 02000000=0A=
.......    : physical APIC id: 02=0A=
.... register #01: 00178011=0A=
.......     : max redirection entries: 0017=0A=
.......     : PRQ implemented: 1=0A=
.......     : IO APIC version: 0011=0A=
.... register #02: 00000000=0A=
.......     : arbitration: 00=0A=
.... IRQ redirection table:=0A=
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   =0A=
 00 000 00  1    0    0   0   0    0    0    00=0A=
 01 003 03  0    0    0   0   0    1    1    39=0A=
 02 003 03  0    0    0   0   0    1    1    31=0A=
 03 003 03  0    0    0   0   0    1    1    41=0A=
 04 003 03  0    0    0   0   0    1    1    49=0A=
 05 000 00  1    0    0   0   0    0    0    00=0A=
 06 003 03  0    0    0   0   0    1    1    51=0A=
 07 003 03  0    0    0   0   0    1    1    59=0A=
 08 003 03  0    0    0   0   0    1    1    61=0A=
 09 003 03  0    0    0   0   0    1    1    69=0A=
 0a 000 00  1    0    0   0   0    0    0    00=0A=
 0b 000 00  1    0    0   0   0    0    0    00=0A=
 0c 003 03  0    0    0   0   0    1    1    71=0A=
 0d 003 03  0    0    0   0   0    1    1    79=0A=
 0e 003 03  0    0    0   0   0    1    1    81=0A=
 0f 003 03  0    0    0   0   0    1    1    89=0A=
 10 003 03  1    1    0   1   0    1    1    91=0A=
 11 000 00  1    0    0   0   0    0    0    00=0A=
 12 003 03  1    1    0   1   0    1    1    99=0A=
 13 003 03  1    1    0   1   0    1    1    99=0A=
 14 000 00  1    0    0   0   0    0    0    00=0A=
 15 000 00  1    0    0   0   0    0    0    00=0A=
 16 000 00  1    0    0   0   0    0    0    00=0A=
 17 000 00  1    0    0   0   0    0    0    00=0A=
IRQ to pin mappings:=0A=
IRQ0 -> 0:2=0A=
IRQ1 -> 0:1=0A=
IRQ3 -> 0:3=0A=
IRQ4 -> 0:4=0A=
IRQ6 -> 0:6=0A=
IRQ7 -> 0:7=0A=
IRQ8 -> 0:8=0A=
IRQ9 -> 0:9=0A=
IRQ11 -> 0:18-> 0:19=0A=
IRQ12 -> 0:12=0A=
IRQ13 -> 0:13=0A=
IRQ14 -> 0:14=0A=
IRQ15 -> 0:15=0A=
IRQ16 -> 0:16=0A=
.................................... done.=0A=
Using local APIC timer interrupts.=0A=
calibrating APIC timer ...=0A=
..... CPU clock speed is 998.3838 MHz.=0A=
..... host bus clock speed is 133.1176 MHz.=0A=
cpu: 0, clocks: 1331176, slice: 443725=0A=
CPU0<T0:1331168,T1:887440,D:3,S:443725,C:1331176>=0A=
cpu: 1, clocks: 1331176, slice: 443725=0A=
CPU1<T0:1331168,T1:443712,D:6,S:443725,C:1331176>=0A=
checking TSC synchronization across CPUs: passed.=0A=
Waiting on wait_init_idle (map =3D 0x2)=0A=
All processors have done init_idle=0A=
mtrr: your CPUs had inconsistent variable MTRR settings=0A=
mtrr: probably your BIOS does not setup all CPUs=0A=
PCI: PCI BIOS revision 2.10 entry at 0xfb370, last bus=3D1=0A=
PCI: Using configuration type 1=0A=
PCI: Probing PCI hardware=0A=
PCI: Using IRQ router VIA [1106/0686] at 00:07.0=0A=
using PIRQ3 -> IRQ 11=0A=
PCI->APIC IRQ transform: (B0,I7,P3) -> 11=0A=
using PIRQ3 -> IRQ 11=0A=
PCI->APIC IRQ transform: (B0,I7,P3) -> 11=0A=
PCI->APIC IRQ transform: (B0,I9,P0) -> 16=0A=
using PIRQ2 -> IRQ 11=0A=
PCI->APIC IRQ transform: (B0,I13,P0) -> 11=0A=
using PIRQ2 -> IRQ 11=0A=
PCI->APIC IRQ transform: (B0,I14,P0) -> 11=0A=
PCI->APIC IRQ transform: (B1,I0,P0) -> 16=0A=
PCI: Enabling Via external APIC routing=0A=
PCI: Via IRQ fixup for 00:07.2, from 5 to 11=0A=
PCI: Via IRQ fixup for 00:07.3, from 5 to 11=0A=
Linux NET4.0 for Linux 2.4=0A=
Based upon Swansea University Computer Society NET3.039=0A=
Initializing RT netlink socket=0A=
Starting kswapd=0A=
VFS: Diskquotas version dquot_6.4.0 initialized=0A=
Journalled Block Device driver loaded=0A=
pty: 1024 Unix98 ptys configured=0A=
block: 128 slots per queue, batch=3D32=0A=
Uniform Multi-Platform E-IDE driver Revision: 6.31=0A=
ide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx=0A=
VP_IDE: IDE controller on PCI bus 00 dev 39=0A=
VP_IDE: chipset revision 6=0A=
VP_IDE: not 100% native mode: will probe irqs later=0A=
ide: Assuming 33MHz system bus speed for PIO modes; override with =
idebus=3Dxx=0A=
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1=0A=
    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:pio=0A=
    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:DMA, hdd:pio=0A=
HPT370A: IDE controller on PCI bus 00 dev 70=0A=
HPT370A: chipset revision 4=0A=
HPT370A: not 100% native mode: will probe irqs later=0A=
    ide2: BM-DMA at 0xc000-0xc007, BIOS settings: hde:pio, hdf:pio=0A=
    ide3: BM-DMA at 0xc008-0xc00f, BIOS settings: hdg:pio, hdh:pio=0A=
hda: QUANTUM FIREBALL CX13.6A, ATA DISK drive=0A=
hda: IRQ probe failed (0xfffffff8)=0A=
hdc: IRQ probe failed (0xfffffff8)=0A=
hdc: IDE/ATAPI CD-ROM 52XS, ATAPI CD/DVD-ROM drive=0A=
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14=0A=
ide1 at 0x170-0x177,0x376 on irq 15=0A=
hda: 26760384 sectors (13701 MB) w/418KiB Cache, CHS=3D1665/255/63, =
(U)DMA=0A=
Partition check:=0A=
 hda: hda1 hda2=0A=
SCSI subsystem driver Revision: 1.00=0A=
Configuring GDT-PCI HA at 0/13 IRQ 11=0A=
scsi0 : GDT7528RN=0A=
  Vendor: ICP       Model: Host Drive  #00   Rev:     =0A=
  Type:   Direct-Access                      ANSI SCSI revision: 02=0A=
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0=0A=
SCSI device sda: 35824950 512-byte hdwr sectors (18342 MB)=0A=
 sda: sda1=0A=
NET4: Linux TCP/IP 1.0 for NET4.0=0A=
IP Protocols: ICMP, UDP, TCP, IGMP=0A=
IP: routing cache hash table of 256 buckets, 4Kbytes=0A=
TCP: Hash tables configured (established 4096 bind 5461)=0A=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.=0A=
kjournald starting.  Commit interval 5 seconds=0A=
EXT3-fs: mounted filesystem with ordered data mode.=0A=
VFS: Mounted root (ext3 filesystem) readonly.=0A=
Freeing unused kernel memory: 216k freed=0A=
Adding Swap: 265032k swap-space (priority -1)=0A=
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,1), internal journal=0A=
kjournald starting.  Commit interval 5 seconds=0A=
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on sd(8,1), internal journal=0A=
EXT3-fs: mounted filesystem with ordered data mode.=0A=
Real Time Clock Driver v1.10e=0A=
usb.c: registered new driver usbdevfs=0A=
usb.c: registered new driver hub=0A=
usb-uhci.c: $Revision: 1.268 $ time 02:12:55 Dec 27 2001=0A=
usb-uhci.c: High bandwidth mode enabled=0A=
usb-uhci.c: USB UHCI at I/O 0xa400, IRQ 11=0A=
usb-uhci.c: Detected 2 ports=0A=
usb.c: new USB bus registered, assigned bus number 1=0A=
hub.c: USB hub found=0A=
hub.c: 2 ports detected=0A=
usb-uhci.c: USB UHCI at I/O 0xa800, IRQ 11=0A=
usb-uhci.c: Detected 2 ports=0A=
usb.c: new USB bus registered, assigned bus number 2=0A=
hub.c: USB hub found=0A=
hub.c: 2 ports detected=0A=
usb-uhci.c: v1.268:USB Universal Host Controller Interface driver=0A=
Initializing USB Mass Storage driver...=0A=
usb.c: registered new driver usb-storage=0A=
USB Mass Storage support registered.=0A=
3c59x: Donald Becker and others. www.scyld.com/network/vortex.html=0A=
00:09.0: 3Com PCI 3c905B Cyclone 100baseTx at 0xac00. Vers LK1.1.16=0A=
hdc: ATAPI 52X CD-ROM drive, 128kB Cache, UDMA(33)=0A=
Uniform CD-ROM driver Revision: 3.12=0A=
VFS: Disk change detected on device ide1(22,0)=0A=
ISO 9660 Extensions: RRIP_1991A=0A=

------=_NextPart_000_0073_01C1B27C.C2551810--
