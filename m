Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261356AbSLUBU6>; Fri, 20 Dec 2002 20:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261370AbSLUBU6>; Fri, 20 Dec 2002 20:20:58 -0500
Received: from sabre.velocet.net ([216.138.209.205]:44550 "HELO
	sabre.velocet.net") by vger.kernel.org with SMTP id <S261356AbSLUBUz>;
	Fri, 20 Dec 2002 20:20:55 -0500
To: Gregory Stark <gsstark@MIT.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with read blocking for a long time on /dev/scd1
References: <87adj0b3hj.fsf@stark.dyndns.tv>
In-Reply-To: <87adj0b3hj.fsf@stark.dyndns.tv>
From: Greg Stark <gsstark@mit.edu>
Organization: The Emacs Conspiracy; member since 1992
Date: 20 Dec 2002 20:28:58 -0500
Message-ID: <87n0n09n39.fsf@stark.dyndns.tv>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Gregory Stark <gsstark@MIT.EDU> writes:

> I'm having a problem with ogle that seems to be being caused by the scsi or
> ide-scsi driver. The video playback freezes for a second or randomly,
> sometimes every few seconds, sometimes not for several minutes. Every such
> glitch is correlated perfectly with a read syscall reading on /dev/scd1
> blocking for an inordinate amount of time.

I forgot to include the details:

$ uname -a
Linux stark.dyndns.tv 2.4.19 #6 Tue Sep 10 22:08:51 EDT 2002 i686 unknown unknown GNU/Linux

/dev/hdd:
 HDIO_GET_MULTCOUNT failed: Input/output error
 IO_support   =  0 (default 16-bit)
 unmaskirq    =  0 (off)
 using_dma    =  1 (on)
 keepsettings =  0 (off)
 readonly     =  0 (off)
 BLKRAGET failed: Input/output error
 HDIO_GETGEO failed: Invalid argument

(that's the same for /dev/hd{a,b,c,d} actually)

$ cat /proc/scsi/scsi
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: YAMAHA   Model: CRW2100E         Rev: 1.0G
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: LG       Model: DVD-ROM DRD8160B Rev: 1.01
  Type:   CD-ROM                           ANSI SCSI revision: 02
 
$ dmesg
Linux version 2.4.19 (stark@stark.dyndns.tv) (gcc version 2.95.4 20011002 (Debian prerelease)) #6 Tue Sep 10 22:08:51 EDT 2002
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
 BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
255MB LOWMEM available.
Advanced speculative caching feature not present
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
Kernel command line: BOOT_IMAGE=linux-2.4.19 ro root=302 console=ttyS1,9600 console=tty0 hdc=ide-scsi hdd=ide-scsi
ide_setup: hdc=ide-scsi
ide_setup: hdd=ide-scsi
Local APIC disabled by BIOS -- reenabling.
Found and enabled local APIC!
Initializing CPU#0
Detected 551.263 MHz processor.
Console: colour VGA+ 80x50
Calibrating delay loop... 1101.00 BogoMIPS
Memory: 257228k/262080k available (907k kernel code, 4464k reserved, 391k data, 96k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU: Intel Pentium III (Coppermine) stepping 01
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 551.2683 MHz.
..... host bus clock speed is 100.2305 MHz.
cpu: 0, clocks: 1002305, slice: 501152
CPU0<T0:1002304,T1:501152,D:0,S:501152,C:1002305>
mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb2b0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 0: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.16)
Starting kswapd
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hdb: C/H/S=38322/16/255 from BIOS ignored
hda: QUANTUM FIREBALL EL7.6A, ATA DISK drive
hdb: MAXTOR 6L080J4, ATA DISK drive
hdc: YAMAHA CRW2100E, ATAPI CD/DVD-ROM drive
hdd: LG DVD-ROM DRD-8160B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: 15032115 sectors (7696 MB) w/418KiB Cache, CHS=935/255/63, UDMA(33)
hdb: 156355584 sectors (80054 MB) w/1819KiB Cache, CHS=155114/16/63, UDMA(33)
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
 hdb: hdb1 hdb2 hdb3
es1371: version v0.30 time 19:34:43 Aug 19 2002
PCI: Found IRQ 5 for device 00:0b.0
es1371: found chip, vendor id 0x1274 device id 0x1371 revision 0x08
es1371: found es1371 rev 8 at io 0x9800 irq 5
es1371: features: joystick 0x0
ac97_codec: AC97 Audio codec, id: 0x4352:0x5913 (Cirrus Logic CS4297A rev A)
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 96k freed
Adding Swap: 128484k swap-space (priority -1)
Real Time Clock Driver v1.10e
ne2k-pci.c:v1.02 10/19/2000 D. Becker/P. Gortmaker
  http://www.scyld.com/network/ne2k-pci.html
PCI: Found IRQ 10 for device 00:09.0
PCI: Sharing IRQ 10 with 00:07.2
eth0: RealTek RTL-8029 found at 0x9400, IRQ 10, 00:80:C8:DF:59:9E.
CSLIP: code copyright 1989 Regents of the University of California
PPP generic driver version 2.4.2
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: YAMAHA    Model: CRW2100E          Rev: 1.0G
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: LG        Model: DVD-ROM DRD8160B  Rev: 1.01
  Type:   CD-ROM                             ANSI SCSI revision: 02
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Intel 440BX chipset
agpgart: AGP aperture is 128M @ 0xe0000000
[drm] AGP 0.99 on Intel 440BX @ 0xe0000000 128MB
[drm] Initialized mga 3.0.2 20010321 on minor 0
Matrox MGA G200/G400/G450/G550 YUV Video interface v2.01 (c) Aaron Holtzman & A'rpi
mga_vid: Found MGA G400/G450
mga_vid: MMIO at 0xd0881000 IRQ: 11  framebuffer: 0xEC000000
mga_vid: OPTION word: 0x50040120  mem: 0x00  SDRAM
mga_vid: detected RAMSIZE is 16 MB
syncfb (mga): IRQ disabled in mga_vid.c
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE,EPP]
parport0: irq 7 detected
lp0: using parport0 (polling).
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ DETECT_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Linux Kernel Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Intel PCIC probe: not found.
Intel PCIC probe: not found.
Starting AFS cache scan...found 393 non-empty cache files (7%).
mtrr: 0xec000000,0x2000000 overlaps existing 0xec000000,0x1000000
mtrr: 0xec000000,0x2000000 overlaps existing 0xec000000,0x1000000
Adding Swap: 127992k swap-space (priority -2)
Adding Swap: 131064k swap-space (priority -3)
Adding Swap: 1048568k swap-space (priority -4)

(The "tainted" is bogus because of openafs, for which I have source. 
 I've tried it without openafs anyways)

$ lsmod
Module                  Size  Used by    Tainted: PF 
sr_mod                 12304   0 (autoclean)
openafs               403712   2
pcmcia_core            39872   0
serial                 50884   0 (autoclean)
isa-pnp                28708   0 (autoclean) [serial]
parport_pc             25288   1 (autoclean)
lp                      6432   0 (autoclean)
parport                25024   1 (autoclean) [parport_pc lp]
mga_vid                 7800   0
mga                    98104   3
agpgart                16552   3
ide-scsi                7632   0
scsi_mod               51356   2 [sr_mod ide-scsi]
pppoe                   6924   2
pppox                   1128   1 [pppoe]
ppp_generic            16416   3 [pppoe pppox]
slhc                    4480   0 [ppp_generic]
ne2k-pci                4800   1
8390                    5968   0 [ne2k-pci]
rtc                     5916   0 (autoclean)


-- 
greg

