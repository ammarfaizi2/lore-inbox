Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129141AbRBKCfX>; Sat, 10 Feb 2001 21:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131760AbRBKCfE>; Sat, 10 Feb 2001 21:35:04 -0500
Received: from [64.160.188.242] ([64.160.188.242]:7428 "HELO
	mail.hislinuxbox.com") by vger.kernel.org with SMTP
	id <S129141AbRBKCfB>; Sat, 10 Feb 2001 21:35:01 -0500
Date: Sat, 10 Feb 2001 18:34:56 -0800 (PST)
From: "David D.W. Downey" <pgpkeys@hislinuxbox.com>
To: Shawn Starr <Shawn.Starr@Home.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.2-pre3
In-Reply-To: <3A8481C0.2756BA1D@Home.net>
Message-ID: <Pine.LNX.4.30.0102101818110.963-100000@ns-01.hislinuxbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


OK, got some problems here.


Here is the dmesg dump for my machine. Please grep for IO-APIC and APIC
errors on CPU#. I get TONS of these messages whenever I do any heavy I/O
like a   dd if=/dev/zero of=/tmp/testing.img bs=1024k count=1500.

I also get errors about exceeding the file size. As far as I know 1.0GB is
NOT the file size limit. 2GB is correct?

The APIC errors on CPU# dump to both my logs and my screen. Since *.emerg
are the only ones I have set in my logs to dump to the console it must be
something heavily wrong or something the driver is set to do.

SYSTEM SPECS
============
Abit VP6 dual FC-PGA mobo
Dual PIII-733 133MHz FC-PGA CPUs
1GB Corsair SDRAM (4x256MB)
VIA VT82C686B chipset (ATA33/66 controller NOT being used)
(3) 30GB WDC WD300BB-00AU1 ATA100 drives
* Using the HighPoint Technology HPT370 Controller
* Kernel params are ide2=ata66 ide3=ata66
* Drives show as hde, hdf, and hdg
* Drives are shown as being in UDMA100 mode
* Drive have been tested with/without hdparm
* /sbin/hdparm -A1 -c1 -d1 -k1 -X69 /dev/hd{e,f,g}
AdvanSys ASB3940UW PCI Ultra-Wide SCSI Adapter
Yamaha SCSI CRW8424S CD-RW


DMESG OUTPUT
============

01109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Coppermine) stepping 03
per-CPU timeslice cutoff: 730.56 usecs.
Getting VERSION: 40011
Getting VERSION: 40011
Getting ID: 0
Getting ID: f000000
Getting LVT0: 700
Getting LVT1: 400
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
CPU present map: 3
Booting processor 1/1 eip 2000
Setting warm reset code and vector.
1.
2.
3.
Asserting INIT.
Waiting for send to finish...
+Deasserting INIT.
Waiting for send to finish...
+#startup loops: 2.
Sending STARTUP #1.
After apic_write.
Initializing CPU#1
CPU#1 (phys ID: 1) waiting for CALLOUT
Startup point 1.
Waiting for send to finish...
+Sending STARTUP #2.
After apic_write.
Startup point 1.
Waiting for send to finish...
+After Startup.
Before Callout 1.
After Callout 1.
CALLIN, before setup_local_APIC().
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1461.45 BogoMIPS
Stack at about c211dfbc
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#1.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU: After generic, caps: 0383fbff 00000000 00000000 00000000
CPU: Common caps: 0383fbff 00000000 00000000 00000000
OK.
CPU1: Intel Pentium III (Coppermine) stepping 03
CPU has booted.
Before bogomips.
Total of 2 processors activated (2922.90 BogoMIPS).
Before bogocount - setting activated=1.
Boot done.
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 2 ... ok.
Synchronizing Arb IDs.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-9, 2-10, 2-11, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=49 pin1=2 pin2=0
activating NMI Watchdog ... done.
number of MP IRQ sources: 21.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00178011
.......     : max redirection entries: 0017
.......     : IO APIC version: 0011
 WARNING: unexpected IO-APIC, please mail
          to linux-smp@vger.kernel.org
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  0    0    0   0   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 003 03  0    0    0   0   0    1    1    71
 0d 003 03  0    0    0   0   0    1    1    79
 0e 003 03  0    0    0   0   0    1    1    81
 0f 003 03  0    0    0   0   0    1    1    89
 10 003 03  1    1    0   1   0    1    1    91
 11 003 03  1    1    0   1   0    1    1    99
 12 003 03  1    1    0   1   0    1    1    A1
 13 003 03  1    1    0   1   0    1    1    A9
 14 000 00  1    0    0   0   0    0    0    00
 15 000 00  1    0    0   0   0    0    0    00
 16 000 00  1    0    0   0   0    0    0    00
 17 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 2
IRQ1 -> 1
IRQ3 -> 3
IRQ4 -> 4
IRQ5 -> 5
IRQ6 -> 6
IRQ7 -> 7
IRQ8 -> 8
IRQ12 -> 12
IRQ13 -> 13
IRQ14 -> 14
IRQ15 -> 15
IRQ16 -> 16
IRQ17 -> 17
IRQ18 -> 18
IRQ19 -> 19
.................................... done.
calibrating APIC timer ...
..... CPU clock speed is 732.1504 MHz.
..... host bus clock speed is 133.1182 MHz.
cpu: 0, clocks: 1331182, slice: 443727
CPU0<T0:1331168,T1:887440,D:1,S:443727,C:1331182>
cpu: 1, clocks: 1331182, slice: 443727
CPU1<T0:1331168,T1:443712,D:2,S:443727,C:1331182>
checking TSC synchronization across CPUs: passed.
Setting commenced=1, go go go
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: PCI BIOS revision 2.10 entry at 0xfb3a0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
PCI->APIC IRQ transform: (B0,I7,P3) -> 19
PCI->APIC IRQ transform: (B0,I7,P3) -> 19
PCI->APIC IRQ transform: (B0,I10,P0) -> 17
PCI->APIC IRQ transform: (B0,I12,P0) -> 19
PCI->APIC IRQ transform: (B0,I13,P0) -> 18
PCI->APIC IRQ transform: (B0,I14,P0) -> 18
PCI->APIC IRQ transform: (B1,I0,P0) -> 16
isapnp: Scanning for Pnp cards...
isapnp: No Plug & Play device found
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
DMI 2.3 present.
40 structures occupying 1195 bytes.
DMI table at 0x000F0800.
BIOS Vendor: Award Software International, Inc.
BIOS Version: 6.00 PG
BIOS Release: 11/06/2000
System Vendor: VIA Technologies, Inc..
Product Name: VT82C694X.
Version  .
Serial Number  .
Board Vendor: ABIT <http://www.abit.com.tw>.
Board Name: 694X-686B (VP6).
Board Version: v1.0 ~.
Starting kswapd v1.8
fb: Voodoo3 memory = 16384K
fb: MTRR's  turned on
tdfxfb: reserving 1024 bytes for the hwcursor at f97ff000
Console: switching to colour frame buffer device 80x30
fb0: 3Dfx Voodoo3 frame buffer device
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
fb1: VGA16 VGA frame buffer device
pty: 1024 Unix98 ptys configured
block: queued sectors max/low 682882kB/551810kB, 2048 slots per queue
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:pio, hdd:pio
HPT370: IDE controller on PCI bus 00 dev 70
HPT370: chipset revision 3
HPT370: not 100% native mode: will probe irqs later
HPT370: ATA-66/100 forced bit set (WARNING)!!
    ide2: BM-DMA at 0xc800-0xc807, BIOS settings: hde:DMA, hdf:DMA
HPT370: ATA-66/100 forced bit set (WARNING)!!
    ide3: BM-DMA at 0xc808-0xc80f, BIOS settings: hdg:DMA, hdh:pio
hde: WDC WD300BB-00AUA1, ATA DISK drive
hdf: WDC WD300BB-00AUA1, ATA DISK drive
hdg: WDC WD300BB-00AUA1, ATA DISK drive
ide2 at 0xb800-0xb807,0xbc02 on irq 18
ide3 at 0xc000-0xc007,0xc402 on irq 18
hde: 58633344 sectors (30020 MB) w/2048KiB Cache, CHS=58168/16/63, UDMA(100)
hdf: 58633344 sectors (30020 MB) w/2048KiB Cache, CHS=58168/16/63, UDMA(100)
hdg: 58633344 sectors (30020 MB) w/2048KiB Cache, CHS=58168/16/63, UDMA(100)
Partition check:
 /dev/ide/host2/bus0/target0/lun0: p1 p2 p3
 /dev/ide/host2/bus0/target1/lun0: p1 p2
 /dev/ide/host2/bus1/target0/lun0: p1 p2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Coda Kernel/Venus communications, v5.3.9, coda@cs.cmu.edu
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
Real Time Clock Driver v1.10d
Non-volatile memory driver v1.1
Software Watchdog Timer: 0.05, timer margin: 60 sec
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
PPP BSD Compression module registered
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: Detected Via Apollo Pro chipset
agpgart: AGP aperture is 64M @ 0xd0000000
[drm] AGP 0.99 on VIA Apollo Pro @ 0xd0000000 64MB
[drm] Initialized tdfx 1.0.0 20000928 on minor 63
[drm] AGP 0.99 on VIA Apollo Pro @ 0xd0000000 64MB
[drm] Initialized r128 2.1.2 20001215 on minor 62
[drm] AGP 0.99 on VIA Apollo Pro @ 0xd0000000 64MB
[drm] Initialized radeon 1.0.0 20010105 on minor 61
SCSI subsystem driver Revision: 1.00
request_module[scsi_hostadapter]: Root fs not mounted
request_module[scsi_hostadapter]: Root fs not mounted
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
uhci.c: USB UHCI at I/O 0xa400, IRQ 19
uhci.c: detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
usb.c: kmalloc IF f7cf5ea0, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI-alt Root Hub
SerialNumber: a400
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface f7cf5ea0
uhci.c: USB UHCI at I/O 0xa800, IRQ 19
uhci.c: detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
usb.c: kmalloc IF f7cf5dc0, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 2 default language ID 0x0
Product: USB UHCI-alt Root Hub
SerialNumber: a800
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface f7cf5dc0
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.
linear personality registered
raid0 personality registered
raid1 personality registered
raid5 personality registered
raid5: measuring checksumming speed
   8regs     :  1212.800 MB/sec
   32regs    :   898.400 MB/sec
uhci.c: root-hub INT complete: port1: 58a port2: 58a data: 6
   pIII_sse  :  1499.600 MB/sec
   pII_mmx   :  1642.000 MB/sec
uhci.c: root-hub INT complete: port1: 58a port2: 58a data: 6
   p5_mmx    :  1728.000 MB/sec
raid5: using function: pIII_sse (1499.600 MB/sec)
md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
hub.c: port 1 connection change
hub.c: port 1, portstatus 300, change 3, 1.5 Mb/s
hub.c: port 2 connection change
hub.c: port 2, portstatus 300, change 3, 1.5 Mb/s
hub.c: port 1 connection change
hub.c: port 1, portstatus 300, change 3, 1.5 Mb/s
hub.c: port 2 connection change
hub.c: port 2, portstatus 300, change 3, 1.5 Mb/s
md.c: sizeof(mdp_super_t) = 4096
autodetecting RAID arrays
autorun ...
... autorun DONE.
LVM version 0.9.1_beta2  by Heinz Mauelshagen  (18/01/2001)
lvm -- Driver successfully initialized
IEEE 802.2 LLC for Linux 2.1 (c) 1996 Tim Alpaerts
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 65536 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
devfs: v0.102 (20000622) Richard Gooch (rgooch@atnf.csiro.au)
devfs: devfs_debug: 0x0
devfs: boot_options: 0x0
VFS: Mounted root (ext2 filesystem) readonly.
Mounted devfs on /dev
Freeing unused kernel memory: 272k freed
uhci.c: root-hub INT complete: port1: 588 port2: 588 data: 6
hub.c: port 1 enable change, status 300
hub.c: port 2 enable change, status 300
uhci.c: root-hub INT complete: port1: 588 port2: 588 data: 6
hub.c: port 1 enable change, status 300
hub.c: port 2 enable change, status 300
Adding Swap: 524656k swap-space (priority -1)
Adding Swap: 524624k swap-space (priority -2)
Adding Swap: 524624k swap-space (priority -3)
reiserfs: checking transaction log (device 21:42) ...
Using r5 hash to sort names
ReiserFS version 3.6.25
Linux Tulip driver version 0.9.13a (January 20, 2001)
eth0: Lite-On 82c168 PNIC rev 32 at 0xb000, 00:A0:CC:D3:44:A5, IRQ 19.
eth0:  MII transceiver #1 config 3000 status 7829 advertising 01e1.
eth0: Setting full-duplex based on MII#1 link partner capability of 45e1.
es1371: version v0.27 time 09:28:50 Feb 10 2001
es1371: found chip, vendor id 0x1274 device id 0x1371 revision 0x09
es1371: found es1371 rev 9 at io 0xb400 irq 18
es1371: features: joystick 0x0
ac97_codec: AC97 Audio codec, id: 0x4352:0x5914 (Unknown)
APIC error on CPU0: 00(04)
APIC error on CPU0: 04(04)
APIC error on CPU1: 00(08)
APIC error on CPU1: 08(08)
APIC error on CPU0: 04(04)
APIC error on CPU0: 04(04)
APIC error on CPU0: 04(02)
APIC error on CPU1: 08(02)
APIC error on CPU0: 02(04)
APIC error on CPU1: 02(08)
APIC error on CPU0: 04(04)
APIC error on CPU0: 04(02)
APIC error on CPU1: 08(04)
APIC error on CPU1: 04(04)
APIC error on CPU1: 04(08)
APIC error on CPU0: 02(04)
APIC error on CPU1: 08(04)
APIC error on CPU1: 04(08)
APIC error on CPU0: 04(04)
APIC error on CPU1: 08(04)
APIC error on CPU0: 04(08)
APIC error on CPU1: 04(04)
APIC error on CPU1: 04(08)
APIC error on CPU0: 08(04)
APIC error on CPU1: 08(08)
APIC error on CPU0: 04(04)
APIC error on CPU0: 04(02)
APIC error on CPU1: 08(04)
APIC error on CPU0: 02(04)
APIC error on CPU1: 04(08)
APIC error on CPU0: 04(02)
APIC error on CPU1: 08(01)
APIC error on CPU0: 02(02)
hde: drive_cmd: status=0x51 { DriveReady SeekComplete Error }
hde: drive_cmd: error=0x04 { DriveStatusError }
APIC error on CPU1: 01(08)
APIC error on CPU0: 02(04)
APIC error on CPU1: 08(08)
APIC error on CPU0: 04(04)
APIC error on CPU1: 08(08)
APIC error on CPU0: 04(04)
APIC error on CPU0: 04(04)
APIC error on CPU1: 08(08)
APIC error on CPU0: 04(04)
APIC error on CPU1: 08(08)
APIC error on CPU0: 04(04)
scsi0 : AdvanSys SCSI 3.2M: PCI Ultra-Wide: BIOS C8000/7FFF, IO AC00/3F, IRQ 17
  Vendor: YAMAHA    Model: CRW8424S          Rev: 1.0j
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 3, lun 0
sr0: scsi3-mmc drive: 24x/16x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12

**POST NOTE** The scsi0 and APIC errors were not part of bootup. They came
after the system was already up and running.


Any info on the file size problem and the APIC errors would be
appreciated.

-- 
David D.W. Downey - RHCE
Consulting Engineer
Ensim Corporation - Sunnyvale, CA

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
