Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317773AbSGZPmU>; Fri, 26 Jul 2002 11:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317777AbSGZPmU>; Fri, 26 Jul 2002 11:42:20 -0400
Received: from roc-24-58-90-11.rochester.rr.com ([24.58.90.11]:60839 "EHLO
	tarnation.dyndns.org") by vger.kernel.org with ESMTP
	id <S317773AbSGZPmN>; Fri, 26 Jul 2002 11:42:13 -0400
Date: Fri, 26 Jul 2002 11:41:57 -0400
From: Aaron Gaudio <prothonotar@tarnation.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Problems assigning IRQs on Sony R505ECK laptop
Message-ID: <20020726114157.A11147@tarnation.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="bCsyhTFzCvuiizWE"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Operating-System: Linux tarnation.dyndns.org 2.4.18-5custom
X-PGP-Fingerprint: 6249 4FF6 F418 F3F9 5DAF 3E92 C170 C6ED 940D F757
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bCsyhTFzCvuiizWE
Content-Type: multipart/mixed; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all. I'm having trouble with linux finding IRQs for several
devices on my Sony R505ECK laptop (just got it yesterday :)

I added the "pci=3Dbiosirq" and I've disabled the "PnP OS" in the
BIOS, however there is nothing in the BIOS that allows me to
manually allocate IRQs to devices, and the problem has not
gone away.

Attached to this is the output of dmesg, which shows the
devices that are not getting IRQs, and the output of /proc/pci,
which shows all the PCI devices that Linux detected. Any help
would be much appreciated.



The laptop came with Windows 2000, and looking through the devices
there, it appears that all the ones causing problems in Linux are=20
assigned IRQ 9. According to Windows, I have the following devices:

00:1d.0 - USB host controller (IRQ 9)
00:1d.1 - USB host controller (IRQ 9)
00:1d.2 - USB host controller (IRQ 9)

-- linux loads two usb drivers (both usb-uhci) with IRQ9, the third it
   can't detect an IRQ for. I haven't tried any USB devices with
   any of the ports yet

00:1f.5 - Yamaha AC-XG sound controller (IRQ 9) - this uses the i810
	audio driver... sound will play, but is choppy (sox
	says "Unable to set audio speed to 44100 (set to 48000)" and
	i810_audio reports "drain_dac, dma timeout?") -- but I haven't
	gotten around to setting up any module options yet

02:0b.0 - Texas Instruments CardBus controller (IRQ 9)
02:05.0 - Ricoh CardBus controller (IRQ 9) - in linux the Ricoh is
	  loaded with IRQ 3

-- i don't have any PC cards, so I haven't even tried setting up
   the CardBus stuff

02:08.0 - Intel 82801CAM ICH3 ethernet controller (IRQ 9)- works fine in
	Linux

00:1f.1 - IDE ATA/ATAPI controller... it appears to work fine in Linux,
	which detects the UDMA(100) hard drive, but I haven't tried
	any hdparm benchmarks

02:02.0 - Texas Instruments OHCI-compliant 1394 (firewire) adapter (IRQ 9)-
	This device is one of the ones which Linux can't detect an IRQ for;
	when I add "irq=3D9" to the module option, the module loads, but
	I'm not sure what to do with it after that (I have the laptop
	connected to the cradle, which uses the Firewire, and has a DVD/CD-RW
	and floppy on it).

Orinoco MiniPCI Card (wireless LAN)- this uses "CardBus Slot 0" and=20
IRQ 9. When the module tries to load, it reports an IRQ conflict. Maybe
there's a way to load the module and tell it to grab a different IRQ?

COM1 (IRQ 4)
LPT1 (IRQ 7 DMA 3)
mouse (IRQ 12)
keyboard (IRQ 1)
Conexant-Ambit softmodem (IRQ 9)


--=20

Aaron Gaudio                           prothontar @ tarnation.dyndns.org
                   http://tarnation.dyndns.org/~aaron
                            ----------------
  "From fullness, aspect. From aspect, being. From being, emptiness."

--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.out"

Linux version 2.4.18 (root@) (gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #4 SMP Thu Jul 25 18:03:31 EDT 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009e000 (usable)
 BIOS-e820: 000000000009e000 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000d8000 - 00000000000e0000 (reserved)
 BIOS-e820: 00000000000e4000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001fcf0000 (usable)
 BIOS-e820: 000000001fcf0000 - 000000001fcfc000 (ACPI data)
 BIOS-e820: 000000001fcfc000 - 000000001fd00000 (ACPI NVS)
 BIOS-e820: 000000001fd00000 - 000000001fe80000 (usable)
 BIOS-e820: 000000001fe80000 - 0000000020000000 (reserved)
 BIOS-e820: 00000000ff800000 - 00000000ffc00000 (reserved)
 BIOS-e820: 00000000fffffc00 - 0000000100000000 (reserved)
On node 0 totalpages: 130688
zone(0): 4096 pages.
zone(1): 126592 pages.
zone(2): 0 pages.
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Kernel command line: ro root=/dev/hda2 pci=biosirq
Initializing CPU#0
Detected 729.135 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1454.89 BogoMIPS
Memory: 511808k/522752k available (1291k kernel code, 10488k reserved, 334k data, 244k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel(R) Pentium(R) III Mobile CPU      1133MHz stepping 01
per-CPU timeslice cutoff: 1463.03 usecs.
SMP motherboard not detected.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 729.1467 MHz.
..... host bus clock speed is 132.5720 MHz.
cpu: 0, clocks: 1325720, slice: 662860
CPU0<T0:1325712,T1:662848,D:4,S:662860,C:1325720>
Waiting on wait_init_idle (map = 0x0)
All processors have done init_idle
PCI: PCI BIOS revision 2.10 entry at 0xfd9aa, last bus=2
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/248c] at 00:1f.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Sony Vaio laptop detected.
Starting kswapd
devfs: v1.10 (20020120) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
ACPI: Core Subsystem version [20011018]
ACPI: Subsystem enabled
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI SERIAL_ACPI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
PCI: Enabling device 00:1f.6 (0000 -> 0001)
PCI: No IRQ known for interrupt pin B of device 00:1f.6.
block: 128 slots per queue, batch=32
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev f9
PCI: Enabling device 00:1f.1 (0005 -> 0007)
PCI: No IRQ known for interrupt pin A of device 00:1f.1.
PIIX4: chipset revision 2
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:pio, hdd:pio
hda: IC25N030ATCS04-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 58605120 sectors (30006 MB) w/1768KiB Cache, CHS=3648/255/63, UDMA(100)
Partition check:
 /dev/ide/host0/bus0/target0/lun0: p1 p2 p3 < p5 p6 p7 p8 >
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
PCI: Found IRQ 3 for device 02:05.0
PCI: Enabling device 02:0b.0 (0000 -> 0002)
PCI: No IRQ known for interrupt pin A of device 02:0b.0.
Intel PCIC probe: not found.
Databook TCIC-2 PCMCIA probe: not found.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 32768)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Yenta IRQ list 04b0, PCI irq3
Socket status: 30000006
Yenta IRQ list 0000, PCI irq0
Socket status: 30000011
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 244k freed
Real Time Clock Driver v1.10e
Adding Swap: 530104k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.275 $ time 17:44:06 Jul 25 2002
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 9 for device 00:1d.0
PCI: Sharing IRQ 9 with 00:02.0
PCI: Setting latency timer of device 00:1d.0 to 64
usb-uhci.c: USB UHCI at I/O 0x1800, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Found IRQ 9 for device 00:1d.1
PCI: Setting latency timer of device 00:1d.1 to 64
usb-uhci.c: USB UHCI at I/O 0x1820, IRQ 9
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
PCI: No IRQ known for interrupt pin C of device 00:1d.2.
usb-uhci.c: found UHCI device with no IRQ assigned. check BIOS settings!
usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
inserting floppy driver for 2.4.18
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Journalled Block Device driver loaded
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,8), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,5), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.17, 10 Jan 2002 on ide0(3,7), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Intel 810 + AC97 Audio, version 0.21, 17:43:51 Jul 25 2002
PCI: Enabling device 00:1f.5 (0000 -> 0001)
PCI: Setting latency timer of device 00:1f.5 to 64
i810: Intel ICH3 found at IO 0x18c0 and 0x1c00, IRQ 9
i810_audio: Audio Controller supports 6 channels.
ac97_codec: AC97 Audio codec, id: 0x594d:0x4803 (Unknown)
i810_audio: only 48Khz playback available.
i810_audio: AC'97 codec 0 supports AMAP, total channels = 2
ac97_codec: AC97 Modem codec, id: 0x4358:0x5421 (Unknown)
i810_audio: timed out waiting for codec 1 analog ready<6>parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport0: irq 7 detected
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
PCI: Found IRQ 9 for device 02:08.0
eth0: Intel Corp. 82801CAM (ICH3) Chipset Ethernet Controller, 08:00:46:4F:5A:F7, IRQ 9.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
cs: IO port probe 0x0c00-0x0cff: clean.
cs: IO port probe 0x0100-0x04ff: excluding 0x378-0x37f 0x4d0-0x4d7
cs: IO port probe 0x0a00-0x0aff: clean.
cs: memory probe 0xa0000000-0xa0ffffff: clean.
apm: BIOS version 1.2 Flags 0x03 (Driver version 1.16)
apm: overridden by ACPI.
hermes.c: 16 Jan 2002 David Gibson <hermes@gibson.dropbear.id.au>
orinoco.c 0.09b (David Gibson <hermes@gibson.dropbear.id.au> and others)
orinoco_cs.c 0.09b (David Gibson <hermes@gibson.dropbear.id.au> and others)
orinoco_cs: RequestIRQ: Resource in use
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 438M
agpgart: Detected an Intel 830M Chipset.
agpgart: detected 892K stolen memory.
agpgart: AGP aperture is 128M @ 0xe8000000
memory : df0a75e0
memory : df0a75a0
memory : df0a75a0
memory : df0a7560
ohci1394: $Revision: 1.80 $ Ben Collins <bcollins@debian.org>
PCI: No IRQ known for interrupt pin A of device 02:02.0.
ohci1394: Failed to allocate shared interrupt 0
Trying to free free IRQ0
memory : d81082e0
memory : d81082a0

--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=proc_pci

PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: PCI device 8086:3575 (Intel Corp.) (rev 4).
      Prefetchable 32 bit memory at 0x0 [0xffffffff].
  Bus  0, device   2, function  0:
    VGA compatible controller: PCI device 8086:3577 (Intel Corp.) (rev 4).
      IRQ 9.
      Prefetchable 32 bit memory at 0xe8000000 [0xefffffff].
      Non-prefetchable 32 bit memory at 0xe0000000 [0xe007ffff].
  Bus  0, device   2, function  1:
    Display controller: PCI device 8086:3577 (Intel Corp.) (rev 0).
      Master Capable.  No bursts.  Max Lat=9.
      Prefetchable 32 bit memory at 0xf0000000 [0xf7ffffff].
      Non-prefetchable 32 bit memory at 0xe0080000 [0xe00fffff].
  Bus  0, device  29, function  0:
    USB Controller: PCI device 8086:2482 (Intel Corp.) (rev 2).
      IRQ 9.
      I/O at 0x1800 [0x181f].
  Bus  0, device  29, function  1:
    USB Controller: PCI device 8086:2484 (Intel Corp.) (rev 2).
      IRQ 9.
      I/O at 0x1820 [0x183f].
  Bus  0, device  29, function  2:
    USB Controller: PCI device 8086:2487 (Intel Corp.) (rev 2).
      I/O at 0x1840 [0x185f].
  Bus  0, device  30, function  0:
    PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (-M) (rev 66).
      Master Capable.  No bursts.  Min Gnt=4.
  Bus  0, device  31, function  0:
    ISA bridge: PCI device 8086:248c (Intel Corp.) (rev 2).
  Bus  0, device  31, function  1:
    IDE interface: PCI device 8086:248a (Intel Corp.) (rev 2).
      I/O at 0x1f0 [0x1f7].
      I/O at 0x3f6 [0x3f6].
      I/O at 0x170 [0x177].
      I/O at 0x376 [0x376].
      I/O at 0x1860 [0x186f].
      Non-prefetchable 32 bit memory at 0xe0100000 [0xe01003ff].
  Bus  0, device  31, function  3:
    SMBus: PCI device 8086:2483 (Intel Corp.) (rev 2).
      I/O at 0x1880 [0x189f].
  Bus  0, device  31, function  5:
    Multimedia audio controller: Intel Corp. AC'97 Audio Controller (rev 2).
      IRQ 9.
      I/O at 0x1c00 [0x1cff].
      I/O at 0x18c0 [0x18ff].
  Bus  0, device  31, function  6:
    Modem: PCI device 8086:2486 (Intel Corp.) (rev 2).
      I/O at 0x2400 [0x24ff].
      I/O at 0x2000 [0x207f].
  Bus  2, device   2, function  0:
    FireWire (IEEE 1394): PCI device 104c:8023 (Texas Instruments) (rev 0).
      Master Capable.  Latency=64.  Min Gnt=3.Max Lat=4.
      Non-prefetchable 32 bit memory at 0xe0205000 [0xe02057ff].
      Non-prefetchable 32 bit memory at 0xe0200000 [0xe0203fff].
  Bus  2, device   5, function  0:
    CardBus bridge: Ricoh Co Ltd RL5c475 (rev 128).
      IRQ 3.
      Master Capable.  Latency=168.  Min Gnt=128.Max Lat=5.
      Non-prefetchable 32 bit memory at 0xe0206000 [0xe0206fff].
  Bus  2, device   8, function  0:
    Ethernet controller: Intel Corp. 82801CAM (ICH3) Chipset Ethernet Controller (rev 66).
      IRQ 9.
      Master Capable.  Latency=66.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xe0204000 [0xe0204fff].
      I/O at 0x3000 [0x303f].
  Bus  2, device  11, function  0:
    CardBus bridge: Texas Instruments PCI1410 PC card Cardbus Controller (rev 1).
      Master Capable.  Latency=168.  Min Gnt=64.Max Lat=5.
      Non-prefetchable 32 bit memory at 0xe0207000 [0xe0207fff].

--liOOAslEiF7prFVr--

--bCsyhTFzCvuiizWE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj1BbcUACgkQwXDG7ZQN91d0FQCgmNTB+u3/s6bIHmYtG3y7v4v0
zrMAoPDVhVu1E3Gmr4/swj0sHMjWiWMb
=MzlZ
-----END PGP SIGNATURE-----

--bCsyhTFzCvuiizWE--
