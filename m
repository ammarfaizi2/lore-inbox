Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317140AbSGCSPe>; Wed, 3 Jul 2002 14:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317148AbSGCSPd>; Wed, 3 Jul 2002 14:15:33 -0400
Received: from 077-115.onebb.com ([202.69.77.115]:59532 "EHLO
	nicksbox.tyict.vtc.edu.hk") by vger.kernel.org with ESMTP
	id <S317140AbSGCSP3>; Wed, 3 Jul 2002 14:15:29 -0400
Message-ID: <3D233FD5.BBD3D040@vtc.edu.hk>
Date: Thu, 04 Jul 2002 02:17:57 +0800
From: Nick Urbanik <nicku@vtc.edu.hk>
Organization: Institute of Vocational Education (Tsing Yi)
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: CMD649 on SMP 2.4.19-pre10-ac2: still not working: please help
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear team,

I still have never had our cheap CMD 649 IDE controller cards work on
SMP systems, never any problem with single CPU systems.  I would really
appreciate some help to determine what I can do to get them working.  I have 3
SCSI disks, 2 IDE, 1 a slave on ide1 (working), the other a master on ide2 (not
working),

The IDE controller isn't getting an interrupt allocated.  What can I do to make
sure it is?  Notice the line in the dmesg output:
ide2: DISABLED, NO IRQ


$ lspi
00:00.0 Host bridge: VIA Technologies, Inc. VT82C693A/694x [Apollo PRO133x] (rev
c4)
00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x
AGP]
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev
22)
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 10)
00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
30)
00:08.0 RAID bus controller: CMD Technology Inc PCI0649 (rev 02)
00:0a.0 Ethernet controller: National Semiconductor Corporation DP83820
10/100/1000 Ethernet Controller
00:0d.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
00:0f.0 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
00:0f.1 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
01:00.0 VGA compatible controller: ATI Technologies Inc Rage XL AGP 2X (rev 65)

part of dmesg output:

Calibrating delay loop... 1736.70 BogoMIPS
CPU: Before vendor init, caps: 0383fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
Intel machine check reporting enabled on CPU#1.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU1: Intel Pentium III (Coppermine) stepping 06
Total of 2 processors activated (3466.85 BogoMIPS).
ENABLING IO-APIC IRQs
Setting 2 in the phys_id_present_map
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=0
number of MP IRQ sources: 23.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : PRQ implemented: 0
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 003 03  0    0    0   0   0    1    1    39
 02 003 03  0    0    0   0   0    1    1    31
 03 003 03  0    0    0   0   0    1    1    41
 04 003 03  0    0    0   0   0    1    1    49
 05 003 03  1    1    0   1   0    1    1    51
 06 003 03  0    0    0   0   0    1    1    59
 07 003 03  0    0    0   0   0    1    1    61
 08 003 03  0    0    0   0   0    1    1    69
 09 003 03  1    1    0   1   0    1    1    71
 0a 003 03  1    1    0   1   0    1    1    79
 0b 003 03  1    1    0   1   0    1    1    81
 0c 003 03  0    0    0   0   0    1    1    89
 0d 003 03  0    0    0   0   0    1    1    91
 0e 003 03  0    0    0   0   0    1    1    99
 0f 003 03  0    0    0   0   0    1    1    A1
 10 003 03  1    1    0   1   0    1    1    A9
 11 003 03  1    1    0   1   0    1    1    B1
 12 003 03  1    1    0   1   0    1    1    B9
 13 003 03  1    1    0   1   0    1    1    C1
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
IRQ16 -> 0:16
IRQ17 -> 0:17
IRQ18 -> 0:18
IRQ19 -> 0:19
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 869.8836 MHz.
..... host bus clock speed is 133.8280 MHz.
cpu: 0, clocks: 1338280, slice: 446093
CPU0<T0:1338272,T1:892176,D:3,S:446093,C:1338280>
cpu: 1, clocks: 1338280, slice: 446093
CPU1<T0:1338272,T1:446080,D:6,S:446093,C:1338280>
checking TSC synchronization across CPUs: passed.
migration_task 0 on cpu=0
migration_task 1 on cpu=1
PCI: PCI BIOS revision 2.10 entry at 0xf0220, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
PCI->APIC IRQ transform: (B0,I7,P3) -> 19
PCI->APIC IRQ transform: (B0,I8,P0) -> 16
PCI->APIC IRQ transform: (B0,I10,P0) -> 18
PCI->APIC IRQ transform: (B0,I13,P0) -> 18
PCI->APIC IRQ transform: (B0,I15,P0) -> 19
PCI->APIC IRQ transform: (B0,I15,P1) -> 19
PCI->APIC IRQ transform: (B1,I0,P0) -> 17
PCI: Enabling Via external APIC routing
PCI: Via IRQ fixup for 00:07.2, from 5 to 3
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
PnPBIOS: Found PnP BIOS installation structure at 0xc00f6210
PnPBIOS: PnP BIOS version 1.0, entry 0xf75a0:0x0, dseg 0xf0000
PnPBIOS: 15 nodes reported by PnP BIOS; 15 recorded by driver


another part of dmesg output:

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686a (rev 22) IDE UDMA66 controller on pci00:07.1
    ide0: BM-DMA at 0x98c0-0x98c7, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x98c8-0x98cf, BIOS settings: hdc:DMA, hdd:DMA
CMD649: IDE controller on PCI bus 00 dev 40
CMD649: chipset revision 2
CMD649: not 100% native mode: will probe irqs later
CMD649: ROM enabled at 0x82100000
    ide2: BM-DMA at 0x8400-0x8407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x8408-0x840f, BIOS settings: hdg:pio, hdh:pio
hda: ATAPI CD-ROM DRIVE 50X MAXIMUM, ATAPI CD/DVD-ROM drive
hdc: ST360021A, ATA DISK drive
hde: ST320420A, ATA DISK drive
hde: IRQ probe failed (0xfffffef8)
hdf: IRQ probe failed (0xfffffef8)
hdf: IRQ probe failed (0xfffffef8)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2: DISABLED, NO IRQ
^^^^^^^^^^^^^^^^^^^^____________Oh dear!!!!
hdc: host protected area => 1
hdc: 117231408 sectors (60022 MB) w/2048KiB Cache, CHS=116301/16/63, UDMA(33)
ide-floppy driver 0.99.newide
Partition check:
 hdc: hdc1
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
ide-floppy driver 0.99.newide
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
md: raid1 personality registered as nr 3
md: raid5 personality registered as nr 4
raid5: measuring checksumming speed
   8regs     :  1603.600 MB/sec
   32regs    :   782.000 MB/sec
   pIII_sse  :  1782.000 MB/sec
   pII_mmx   :  1955.200 MB/sec
   p5_mmx    :  1721.600 MB/sec
raid5: using function: pIII_sse (1782.000 MB/sec)
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
LVM version 1.0.3(19/02/2002)

$ cat /proc/interrupts
           CPU0       CPU1
  0:    1815773    1787348    IO-APIC-edge  timer
  1:       1274        944    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          1          0    IO-APIC-edge  rtc
 12:         45        152    IO-APIC-edge  PS/2 Mouse
 14:          1         21    IO-APIC-edge  ide0
 15:      18156      16725    IO-APIC-edge  ide1
 18:     249413     250012   IO-APIC-level  eth0, eth1
 19:      76815      76806   IO-APIC-level  aic7xxx, aic7xxx, usb-uhci
NMI:          0          0
LOC:    3602881    3602880
ERR:          0
MIS:          0

$ cat /proc/ide/cmd64x

Controller: 0
CMD649 Chipset.
--------------- Primary Channel ---------------- Secondary Channel -------------

                 enabled                          enabled
--------------- drive0 --------- drive1 -------- drive0 ---------- drive1 ------

DMA enabled:    no               no              no                no
DMA Mode:        PIO(?)           PIO(?)          PIO(?)            PIO(?)
PIO Mode:       ?                ?               ?                 ?
                polling                          polling
                pending                          clear
                enabled                          enabled

$ cat /proc/ide/via
----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.34
South Bridge:                       VIA vt82c686a
Revision:                           ISA 0x22 IDE 0x10
Highest DMA rate:                   UDMA66
BM-DMA base:                        0x98c0
PCI clock:                          33.3MHz
Master Read  Cycle IRDY:            1ws
Master Write Cycle IRDY:            1ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:               no                  no
Post Write Buffer:             no                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   40w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:        PIO       DMA      UDMA       DMA
Address Setup:       30ns     120ns      30ns     120ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns     330ns      90ns     330ns
Data Recovery:       30ns     270ns      30ns     270ns
Cycle Time:         120ns     600ns      60ns     600ns
Transfer Rate:   16.6MB/s   3.3MB/s  33.3MB/s   3.3MB/s

Please could you give me any pointers on how to enable interrupt support for the
CMD649 card(s) on this system (and similar systems)?  I am sorry, but it's not
at all clear to me what to try next.

Yours with hair missing from worry at 2.17am, Nick.

--
Nick Urbanik   RHCE                                  nicku@vtc.edu.hk
Dept. of Information & Communications Technology
Hong Kong Institute of Vocational Education (Tsing Yi)
Tel:   (852) 2436 8576, (852) 2436 8579          Fax: (852) 2436 8526
PGP: 53 B6 6D 73 52 EE 1F EE EC F8 21 98 45 1C 23 7B     ID: 7529555D
GPG: 7FFA CDC7 5A77 0558 DC7A 790A 16DF EC5B BB9D 2C24   ID: BB9D2C24



