Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264041AbRFEQmv>; Tue, 5 Jun 2001 12:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264039AbRFEQmm>; Tue, 5 Jun 2001 12:42:42 -0400
Received: from AMontpellier-201-1-3-224.abo.wanadoo.fr ([193.252.1.224]:25843
	"EHLO microsoft.com") by vger.kernel.org with ESMTP
	id <S264038AbRFEQmd>; Tue, 5 Jun 2001 12:42:33 -0400
Subject: 2.4.5-ac6: IDE deadlocks/bugs + unexpected IO-APIC
From: Xavier Bestel <xavier.bestel@free.fr>
To: linux-kernel@vger.kernel.org
Cc: linux-smp@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.10 (Preview Release)
Date: 05 Jun 2001 18:39:16 +0200
Message-Id: <991759157.22536.9.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I have an ABit VP6 (Dual PIII, infamous VIA686, onboard IDE + onboard
HPT370). This is a new machine, so I didn't test it on several kernels.

Using 2.4.4-ac11 (SMP), it started to deadlock really often when
accessing the new disk (Seagate Barracuda, udma5, big reiserfs partition
+ swap) I put on the HPT370, even when mounting it.

Using 2.4.5-ac6, things are much better, but sometimes it hangs at boot
around "RAMDISK: Loading 4096 blocks [1 disk] into ram disk ..." - I say
"around" because sometimes it displays "ACPI: Core Subsystem version
...", and sometimes not.
And sometimes it still hangs randomly. No messages, nothing special in
the logs except an "unexpected IO-APIC" (that's why I put linux-smp in
Cc:) and 40 Megs (!!) of:
Jun  2 23:11:58 bip kernel: attempt to access beyond end of device
Jun  2 23:11:58 bip kernel: 07:00: rw=0, want=4906986, limit=4906984
Jun  2 23:11:58 bip kernel: attempt to access beyond end of device
Jun  2 23:11:58 bip kernel: 07:00: rw=0, want=4906988, limit=4906984
Jun  2 23:11:58 bip kernel: attempt to access beyond end of device
Jun  2 23:11:58 bip kernel: 07:00: rw=0, want=4906986, limit=4906984
Jun  2 23:11:58 bip kernel: attempt to access beyond end of device
Jun  2 23:11:58 bip kernel: 07:00: r<6>07:00: rw=0, want=4906988, limi4
Jun  2 23:11:58 bip kernel: att<6>07:4
Jun  2 23:11:58 bip kernel: attemp<6>07:00: rw=0, want=4906988, 4
Jun  2 23:11:58 bip kernel: att<6>07:004
Jun  2 23:11:58 bip kernel: attemp<6>07:00: rw=0, want=4906988, li4
Jun  2 23:11:58 bip kernel: atte<6>07:004
Jun  2 23:11:58 bip kernel: att<6>07:00: rw=0, want=4906988, l4
Jun  2 23:11:58 bip kernel: attempt t<6>074
Jun  2 23:11:58 bip kernel: attem<6>07:00: rw=0, want=4906988, limit=4
Jun  2 23:11:58 bip kernel: at<6>07:00: rw=0, 4
Jun  2 23:11:58 bip kernel: atte<6>07:00: rw=0, want=4906988, limit=4

dated between Jun  2 23:11:58 and Jun  2 23:14:10

The thing that annoys me is that today, I just found the my /etc/motd
with junk appended (a bit of C code). /etc/motd is on my root partition
on a disk (Seagate ST36531A, big ext2 partition + swap) NOT on the
HPT370, but on the first onboard IDE.


I know (now that I looked a bit in the archives) that the VIA686 chipset
isn't reliable. Any hint to make my PC work while keeping reasonable
performance ?
What should I do to help ?

Xav

[root@bip:~]$ lspci -v
00:00.0 Host bridge: VIA Technologies, Inc. VT82C691 [Apollo PRO] (rev
c4)
	Subsystem: ABIT Computer Corp.: Unknown device a204
	Flags: bus master, medium devsel, latency 8
	Memory at d0000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
	Capabilities: [c0] Power Management version 2

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3 AGP]
(prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 00009000-00009fff
	Memory behind bridge: d8000000-d9ffffff
	Prefetchable memory behind bridge: d4000000-d7ffffff
	Capabilities: [80] Power Management version 2

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev
40)
	Subsystem: ABIT Computer Corp.: Unknown device 0000
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: [c0] Power Management version 2

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev
06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. VT82C586 IDE [Apollo]
	Flags: bus master, medium devsel, latency 32
	I/O ports at a000 [size=16]
	Capabilities: [c0] Power Management version 2

00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 16)
(prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at a400 [size=32]
	Capabilities: [80] Power Management version 2

00:07.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 16)
(prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at a800 [size=32]
	Capabilities: [80] Power Management version 2

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
40)
	Flags: medium devsel, IRQ 11
	Capabilities: [68] Power Management version 2

00:09.0 FireWire (IEEE 1394): Texas Instruments: Unknown device 8020
(prog-if 10 [OHCI])
	Subsystem: Ads Technologies Inc: Unknown device 0000
	Flags: bus master, medium devsel, latency 32, IRQ 9
	Memory at db005000 (32-bit, non-prefetchable) [size=2K]
	Memory at db000000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 1

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139
(rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8139
	Flags: bus master, medium devsel, latency 32, IRQ 10
	I/O ports at ac00 [size=256]
	Memory at db004000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=64K]

00:0c.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev
09)
	Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
	Flags: bus master, slow devsel, latency 32, IRQ 11
	I/O ports at b000 [size=64]
	Capabilities: [dc] Power Management version 2

00:0e.0 Unknown mass storage controller: Triones Technologies, Inc.
HPT366 (rev 03)
	Subsystem: Triones Technologies, Inc.: Unknown device 0001
	Flags: bus master, 66Mhz, medium devsel, latency 120, IRQ 11
	I/O ports at b400 [size=8]
	I/O ports at b800 [size=4]
	I/O ports at bc00 [size=8]
	I/O ports at c000 [size=4]
	I/O ports at c400 [size=256]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [60] Power Management version 2

01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF
(prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 0028
	Flags: bus master, stepping, 66Mhz, medium devsel, latency 32, IRQ 9
	Memory at d4000000 (32-bit, prefetchable) [size=64M]
	I/O ports at 9000 [size=256]
	Memory at d9000000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [50] AGP version 2.0
	Capabilities: [5c] Power Management version 2

[root@bip:~]$ hdparm -i /dev/hda

/dev/hda:

 Model=ST36531A, FwRev=3.11, SerialNo=GS741000
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=13446/15/63, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=128kB, MaxMultSect=32, MultSect=32
 CurCHS=13446/15/63, CurSects=12706470, LBA=yes, LBAsects=12706470
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 
[root@bip:~]$ hdparm -i /dev/hde

/dev/hde:

 Model=ST340824A, FwRev=3.05, SerialNo=3HE03HKW
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs RotSpdTol>.5% }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=0
 BuffType=unknown, BuffSize=2048kB, MaxMultSect=16, MultSect=16
 CurCHS=16383/16/63, CurSects=16514064, LBA=yes, LBAsects=78165360
 IORDY=on/off, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4 
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5 
[root@bip:~]$ dmesg
Linux version 2.4.5-ac6 (root@bip) (gcc version 2.95.2 20000220 (Debian
GNU/Linux)) #1 SMP mar jun 5 16:14:09 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000000fff0000 (usable)
 BIOS-e820: 000000000fff0000 - 000000000fff3000 (ACPI NVS)
 BIOS-e820: 000000000fff3000 - 0000000010000000 (ACPI data)
 BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
 BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
found SMP MP-table at 000f5770
hm, page 000f5000 reserved twice.
hm, page 000f6000 reserved twice.
hm, page 000f1000 reserved twice.
hm, page 000f2000 reserved twice.
On node 0 totalpages: 65520
zone(0): 4096 pages.
zone(1): 61424 pages.
zone(2): 0 pages.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
Processor #1 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
Kernel command line: root=/dev/hda5 ro mem=262080K
Initializing CPU#0
Detected 998.379 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1992.29 BogoMIPS
Memory: 250932k/262080k available (1278k kernel code, 10760k reserved,
371k data, 220k init, 0k highmem)
Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000
CPU serial number disabled.
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
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0383fbff 00000000 00000000 00000000
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU0: Intel Pentium III (Coppermine) stepping 06
per-CPU timeslice cutoff: 730.97 usecs.
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Booting processor 1/1 eip 2000
Initializing CPU#1
masked ExtINT on CPU#1
ESR value before enabling vector: 00000000
ESR value after enabling vector: 00000000
Calibrating delay loop... 1992.29 BogoMIPS
CPU: Before vendor init, caps: 0387fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#1.
CPU: After vendor init, caps: 0387fbff 00000000 00000000 00000000
CPU serial number disabled.
CPU:     After generic, caps: 0383fbff 00000000 00000000 00000000
CPU:             Common caps: 0383fbff 00000000 00000000 00000000
CPU1: Intel Pentium III (Coppermine) stepping 06
Total of 2 processors activated (3984.58 BogoMIPS).
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 2 ... ok.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22,
2-23 not connected.
..TIMER: vector=49 pin1=2 pin2=0
number of MP IRQ sources: 17.
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
 09 003 03  1    1    0   1   0    1    1    71
 0a 003 03  1    1    0   1   0    1    1    79
 0b 003 03  1    1    0   1   0    1    1    81
 0c 003 03  0    0    0   0   0    1    1    89
 0d 003 03  0    0    0   0   0    1    1    91
 0e 003 03  0    0    0   0   0    1    1    99
 0f 003 03  0    0    0   0   0    1    1    A1
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
.................................... done.
Using local APIC timer interrupts.
calibrating APIC timer ...
..... CPU clock speed is 998.4143 MHz.
..... host bus clock speed is 133.1217 MHz.
cpu: 0, clocks: 1331217, slice: 443739
CPU0<T0:1331216,T1:887472,D:5,S:443739,C:1331217>
cpu: 1, clocks: 1331217, slice: 443739
CPU1<T0:1331216,T1:443728,D:10,S:443739,C:1331217>
checking TSC synchronization across CPUs: passed.
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: PCI BIOS revision 2.10 entry at 0xfb3a0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Using IRQ router VIA [1106/0686] at 00:07.0
PnP: PNP BIOS installation structure at 0xc00fbdb0
PnP: PNP BIOS version 1.0, entry at f0000:bde0, dseg at f0000
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.14)
apm: disabled - APM is not SMP safe.
Starting kswapd v1.8
VFS: Diskquotas version dquot_6.5.0 initialized
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.10d
block: queued sectors max/low 166669kB/55556kB, 512 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:07.1
    ide0: BM-DMA at 0xa000-0xa007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xa008-0xa00f, BIOS settings: hdc:DMA, hdd:DMA
HPT370: IDE controller on PCI bus 00 dev 70
HPT370: chipset revision 3
HPT370: not 100% native mode: will probe irqs later
    ide2: BM-DMA at 0xc400-0xc407, BIOS settings: hde:DMA, hdf:pio
    ide3: BM-DMA at 0xc408-0xc40f, BIOS settings: hdg:pio, hdh:pio
hd1: C/H/S=0/0/0 from BIOS ignored
hda: ST36531A, ATA DISK drive
hdb: IOMEGA ZIP 100 ATAPI, ATAPI FLOPPY drive
hdc: HITACHI DVD-ROM GD-7500, ATAPI CD/DVD-ROM drive
hdd: LG CD-RW CED-8080B, ATAPI CD/DVD-ROM drive
hde: ST340824A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
ide2 at 0xb400-0xb407,0xb802 on irq 11
hda: 12706470 sectors (6506 MB) w/128KiB Cache, CHS=6204/64/32, UDMA(33)
hde: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63,
UDMA(100)
Partition check:
 hda: [PTBL] [840/240/63] hda1 < hda5 hda6 >
 hdb:<3>ide-scsi: hdb: unsupported command in request queue (0)
end_request: I/O error, dev 03:40 (hdb), sector 0
 unable to read partition table
 hde: hde1 hde2
floppy0: no floppy controllers found
loop: loaded (max 8 devices)
8139too Fast Ethernet driver 0.9.15c loaded
eth0: RealTek RTL8139 Fast Ethernet at 0xd0800000, 00:00:b4:c3:e1:94,
IRQ 10
eth0:  Identified 8139 chip type 'RTL-8139B'
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: IOMEGA    Model: ZIP 100           Rev: 23.D
  Type:   Direct-Access                      ANSI SCSI revision: 00
  Vendor: HITACHI   Model: DVD-ROM GD-7500   Rev: 0005
  Type:   CD-ROM                             ANSI SCSI revision: 02
  Vendor: LG        Model: CD-RW CED-8080B   Rev: 1.06
  Type:   CD-ROM                             ANSI SCSI revision: 02
Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
sda : READ CAPACITY failed.
sda : status = 0, message = 00, host = 0, driver = 28 
sda : extended sense code = 2 
sda : block size assumed to be 512 bytes, disk size 1GB.  
 sda: I/O error: dev 08:00, sector 0
 unable to read partition table
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 1, lun 0
Attached scsi CD-ROM sr1 at scsi0, channel 0, id 2, lun 0
sr0: scsi3-mmc drive: 14x/40x cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
sr1: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb.c: registered new driver keyboard
usbkbd.c:  Vojtech Pavlik <vojtech@suse.cz>
usbkbd.c: USB HID Boot Protocol keyboard driver
md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27
md.c: sizeof(mdp_super_t) = 4096
autodetecting RAID arrays
autorun ...
... autorun DONE.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
RAMDISK: ext2 filesystem found at block 0
RAMDISK: Loading 4096 blocks [1 disk] into ram disk... <6>ACPI: Core
Subsystem version [20010208]
ACPI: Subsystem enabled
ACPI: Using ACPI idle
ACPI: If experiencing system slowness, try adding "acpi=no-idle" to
cmdline
ACPI: System firmware supports: S0 S1 S4 S5
done.


