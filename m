Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286365AbSAMQ12>; Sun, 13 Jan 2002 11:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286372AbSAMQ1J>; Sun, 13 Jan 2002 11:27:09 -0500
Received: from camus.xss.co.at ([194.152.162.19]:41989 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id <S286365AbSAMQ06>;
	Sun, 13 Jan 2002 11:26:58 -0500
Message-ID: <3C41B539.2C7808BA@xss.co.at>
Date: Sun, 13 Jan 2002 17:26:33 +0100
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Reid Hekman <reid.hekman@ndsu.nodak.edu>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.2.20 SMP & Asus CUR-DLS: "stuck on TLB IPI wait (CPU#3)"
In-Reply-To: <E16Pmjk-0007FH-00@the-village.bc.nu>
Content-Type: multipart/mixed;
 boundary="------------DF902DE13DDB9FF2DC6CD4B5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------DF902DE13DDB9FF2DC6CD4B5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi!

Alan Cox wrote:
> 
> > switch. To see if it's a hardware problem I already switched
> > back to 2.2.18 once, and the problem went away.
> > Under 2.2.20 I have to boot with "noapic" to have it running
> > smoothly.
> 
> Does 2.2.19 work ?

I quickly installed 2.2.19 on this machine. It is running
this kernel right now, and everything seems to run fine
_without_ the "noapic" option, i.e. no need to give any
special command line option to the kernel in order to get
it running smoothly!

I also have MPS 1.4 support _enabled_ in the BIOS (if that's
of any importance, anyway)

It's running for about 15 minutes now, under some load (several
"find" jobs locally and over NFS), and it seems to be stable.
With 2.2.20 I almost immediately get those "stuck on TLB IPI wait"
messages, whereas with 2.2.19 I haven't seen any of them yet.

(Note that this machine has 2GB of RAM, but the 2.2.19 kernel
I have running right now was compiled with CONFIG_1GB, only)

root@schiller:~ {515} $ uptime
  5:17pm  up 15 min,  3 users,  load average: 2.08, 1.71, 0.98

root@schiller:~ {516} $ cat /proc/interrupts
           CPU0       CPU1
  0:      92841          0          XT-PIC  timer
  1:        235        295    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  4:          6         14    IO-APIC-edge  serial
  8:          1          3    IO-APIC-edge  rtc
 13:          1          0          XT-PIC  fpu
 18:     432265     431482   IO-APIC-level  eth0
 22:     243311     244776   IO-APIC-level  aic7xxx
NMI:          0
ERR:          0

Please find the output of "dmesg" and "lspci -v" attached
to this mail.

If you have anything more for me to test (maybe a small
kernel patch for 2.2.20 ;-) I'll be glad if I can help.

- andreas

-- 
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
--------------DF902DE13DDB9FF2DC6CD4B5
Content-Type: text/plain; charset=us-ascii;
 name="schiller-2.2.19.dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="schiller-2.2.19.dmesg"

Linux version 2.2.19 (root@dante) (gcc version 2.95.2 19991024 (release)) #1 SMP Sun Aug 26 19:29:51 CEST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0009f000 @ 00000000 (usable)
 BIOS-e820: 7fefb000 @ 00100000 (usable)
Warning only 960MB will be used.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #3 Pentium(tm) Pro APIC version 17
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
I/O APIC #3 Version 17 at 0xFEC01000.
Processors: 2
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
mapped IOAPIC to ffffc000 (fec01000)
Detected 866770 kHz processor.
Console: colour VGA+ 80x50
Calibrating delay loop... 1730.15 BogoMIPS
Memory: 970936k/983040k available (816k kernel code, 424k reserved, 9980k data, 60k init)
Dentry hash table entries: 131072 (order 8, 1024k)
Buffer cache hash table entries: 524288 (order 9, 2048k)
Page cache hash table entries: 262144 (order 8, 1024k)
VFS: Diskquotas version dquot_6.4.0 initialized
256K L2 cache (8 way)
CPU: L2 Cache: 256K
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
Checking for popad bug... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.35a (19990819) Richard Gooch (rgooch@atnf.csiro.au)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#3.
256K L2 cache (8 way)
CPU: L2 Cache: 256K
per-CPU timeslice cutoff: 50.01 usecs.
CPU3: Intel Pentium III (Coppermine) stepping 03
calibrating APIC timer ... 
..... CPU clock speed is 866.6991 MHz.
..... system bus clock speed is 133.3380 MHz.
Booting processor 0 eip 2000
Calibrating delay loop... 1730.15 BogoMIPS
Intel machine check reporting enabled on CPU#0.
256K L2 cache (8 way)
CPU: L2 Cache: 256K
OK.
CPU0: Intel Pentium III (Coppermine) stepping 03
Total of 2 processors activated (3460.30 BogoMIPS).
enabling symmetric IO mode... ...done.
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-5, 2-10, 2-11, 2-15, 3-0, 3-1, 3-3, 3-4, 3-5, 3-7, 3-10, 3-11, 3-12, 3-13, 3-14, 3-15 not connected.
..MP-BIOS bug: 8254 timer not connected to IO-APIC
...trying to set up timer as ExtINT... .. (found pin 0) ... works.
number of MP IRQ sources: 17.
number of IO-APIC #2 registers: 16.
number of IO-APIC #3 registers: 16.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 003 03  0    0    0   0   0    0    7    51
 01 000 00  0    0    0   0   0    1    1    59
 02 000 00  0    0    0   0   0    1    1    51
 03 000 00  0    0    0   0   0    1    1    61
 04 000 00  0    0    0   0   0    1    1    69
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  0    0    0   0   0    1    1    71
 07 000 00  0    0    0   0   0    1    1    79
 08 000 00  0    0    0   0   0    1    1    81
 09 0FF 0F  1    1    0   1   0    1    1    89
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  0    0    0   0   0    1    1    91
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  0    0    0   0   0    1    1    99
 0f 000 00  1    0    0   0   0    0    0    00

IO APIC #3......
.... register #00: 03000000
.......    : physical APIC id: 03
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : IO APIC version: 0011
.... register #02: 0B000000
.......     : arbitration: 0B
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:   
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 0FF 0F  1    1    0   1   0    1    1    A1
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  1    0    0   0   0    0    0    00
 05 000 00  1    0    0   0   0    0    0    00
 06 0FF 0F  1    1    0   1   0    1    1    A9
 07 000 00  1    0    0   0   0    0    0    00
 08 0FF 0F  1    1    0   1   0    1    1    B1
 09 0FF 0F  1    1    0   1   0    1    1    B9
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  1    0    0   0   0    0    0    00
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 2
IRQ1 -> 1
IRQ3 -> 3
IRQ4 -> 4
IRQ6 -> 6
IRQ7 -> 7
IRQ8 -> 8
IRQ9 -> 9
IRQ12 -> 12
IRQ13 -> 13
IRQ14 -> 14
IRQ18 -> 2
IRQ22 -> 6
IRQ24 -> 8
IRQ25 -> 9
.................................... done.
PCI: PCI BIOS revision 2.10 entry at 0xf0a80
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: 00:00 [1166/0009]: Scanning peer host bridges
PCI: Scanning ServerWorks HE/LE Peer Bus Bridge 00/00
PCI: 00:01 [1166/0009]: Scanning peer host bridges
PCI: Scanning ServerWorks HE/LE Peer Bus Bridge 00/01
PCI->APIC IRQ transform: (B0,I5,P0) -> 18
PCI->APIC IRQ transform: (B1,I3,P0) -> 22
PCI->APIC IRQ transform: (B1,I5,P0) -> 24
PCI->APIC IRQ transform: (B1,I5,P1) -> 25
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 524288 bhash 65536)
Initializing RT netlink socket
Starting kswapd v 1.5 
Detected PS/2 Mouse Port.
Serial driver version 4.27 with no serial options enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.09
RAM disk driver initialized:  16 RAM disks of 4096K size
md driver 0.90.0 MAX_MD_DEVS=256, MAX_REAL=12
raid5: measuring checksumming speed
raid5: MMX detected, trying high-speed MMX checksum routines
   pII_mmx   :  1910.715 MB/sec
   p5_mmx    :  2053.590 MB/sec
   8regs     :  1490.853 MB/sec
   32regs    :   818.388 MB/sec
using fastest function: p5_mmx (2053.590 MB/sec)
NET4: Ethernet Bridge 007 for NET4.0
early initialization of device brg0 is deferred
brg0: network interface for Ethernet Bridge 007/NET4.0
brg0: generated MAC address FE:FD:01:00:AF:A5
brg0: attached to bridge instance 0
md.c: sizeof(mdp_super_t) = 4096
Partition check:
RAMDISK: Compressed image found at block 0
apm: BIOS version 1.2 Flags 0x0b (Driver version 1.13)
apm: disabled - APM is not SMP safe (power off active).
devfs: v0.90d (20010202) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
VFS: Mounted root (romfs filesystem).
Mounted devfs on /dev
(scsi0) <Adaptec AIC-7892 Ultra 160/m SCSI host adapter> found at PCI 1/3/0
(scsi0) Wide Channel, SCSI ID=7, 32/255 SCBs
(scsi0) Downloading sequencer code... 396 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.33/3.2.4
       <Adaptec AIC-7892 Ultra 160/m SCSI host adapter>
scsi : 1 host.
  Vendor: IBM       Model: DDYS-T18350M      Rev: S96H
  Type:   Direct-Access                      ANSI SCSI revision: 03
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
(scsi0:0:0:1) Synchronous at 160.0 Mbyte/sec, offset 63.
  Vendor: IBM       Model: DDYS-T18350M      Rev: S96H
  Type:   Direct-Access                      ANSI SCSI revision: 03
Detected scsi disk sdb at scsi0, channel 0, id 1, lun 0
(scsi0:0:1:1) Synchronous at 160.0 Mbyte/sec, offset 63.
  Vendor: IBM       Model: DDYS-T18350M      Rev: S96H
  Type:   Direct-Access                      ANSI SCSI revision: 03
Detected scsi disk sdc at scsi0, channel 0, id 2, lun 0
(scsi0:0:2:1) Synchronous at 160.0 Mbyte/sec, offset 63.
  Vendor: IBM       Model: DDYS-T18350M      Rev: S96H
  Type:   Direct-Access                      ANSI SCSI revision: 03
Detected scsi disk sdd at scsi0, channel 0, id 3, lun 0
(scsi0:0:3:1) Synchronous at 160.0 Mbyte/sec, offset 63.
  Vendor: IBM       Model: DDYS-T18350M      Rev: S96H
  Type:   Direct-Access                      ANSI SCSI revision: 03
Detected scsi disk sde at scsi0, channel 0, id 4, lun 0
(scsi0:0:4:1) Synchronous at 160.0 Mbyte/sec, offset 63.
SCSI device sda: hdwr sector= 512 bytes. Sectors= 35843670 [17501 MB] [17.5 GB]
 /dev/scsi/host0/bus0/target0/lun0: p1 p2 p3 p4 < p5 p6 p7 p8 >
SCSI device sdb: hdwr sector= 512 bytes. Sectors= 35843670 [17501 MB] [17.5 GB]
 /dev/scsi/host0/bus0/target1/lun0: unknown partition table
SCSI device sdc: hdwr sector= 512 bytes. Sectors= 35843670 [17501 MB] [17.5 GB]
 /dev/scsi/host0/bus0/target2/lun0: unknown partition table
SCSI device sdd: hdwr sector= 512 bytes. Sectors= 35843670 [17501 MB] [17.5 GB]
 /dev/scsi/host0/bus0/target3/lun0: unknown partition table
SCSI device sde: hdwr sector= 512 bytes. Sectors= 35843670 [17501 MB] [17.5 GB]
 /dev/scsi/host0/bus0/target4/lun0: unknown partition table
VFS: Mounted root (ext2 filesystem) readonly.
change_root: old root has d_count=1
Mounted devfs on /dev
Trying to unmount old root ... okay
Freeing unused kernel memory: 60k freed
Adding Swap: 2097136k swap-space (priority -1)
(read) scsi/host0/bus0/target1/lun0/disc's sb offset: 17921728 [events: 0000002b]
(read) scsi/host0/bus0/target2/lun0/disc's sb offset: 17921728 [events: 0000002b]
(read) scsi/host0/bus0/target3/lun0/disc's sb offset: 17921728 [events: 0000002b]
(read) scsi/host0/bus0/target4/lun0/disc's sb offset: 17921728 [events: 0000002b]
autorun ...
considering scsi/host0/bus0/target4/lun0/disc ...
  adding scsi/host0/bus0/target4/lun0/disc ...
  adding scsi/host0/bus0/target3/lun0/disc ...
  adding scsi/host0/bus0/target2/lun0/disc ...
  adding scsi/host0/bus0/target1/lun0/disc ...
created md0
bind<scsi/host0/bus0/target1/lun0/disc,1>
bind<scsi/host0/bus0/target2/lun0/disc,2>
bind<scsi/host0/bus0/target3/lun0/disc,3>
bind<scsi/host0/bus0/target4/lun0/disc,4>
running: <scsi/host0/bus0/target4/lun0/disc><scsi/host0/bus0/target3/lun0/disc><scsi/host0/bus0/target2/lun0/disc><scsi/host0/bus0/target1/lun0/disc>
now!
scsi/host0/bus0/target4/lun0/disc's event counter: 0000002b
scsi/host0/bus0/target3/lun0/disc's event counter: 0000002b
scsi/host0/bus0/target2/lun0/disc's event counter: 0000002b
scsi/host0/bus0/target1/lun0/disc's event counter: 0000002b
raid5 personality registered
md0: max total readahead window set to 384k
md0: 3 data-disks, max readahead per data-disk: 128k
raid5: device scsi/host0/bus0/target4/lun0/disc operational as raid disk 3
raid5: device scsi/host0/bus0/target3/lun0/disc operational as raid disk 2
raid5: device scsi/host0/bus0/target2/lun0/disc operational as raid disk 1
raid5: device scsi/host0/bus0/target1/lun0/disc operational as raid disk 0
raid5: allocated 4248kB for md0
raid5: raid level 5 set md0 active with 4 out of 4 devices, algorithm 2
RAID5 conf printout:
 --- rd:4 wd:4 fd:0
 disk 0, s:0, o:1, n:0 rd:0 us:1 dev:scsi/host0/bus0/target1/lun0/disc
 disk 1, s:0, o:1, n:1 rd:1 us:1 dev:scsi/host0/bus0/target2/lun0/disc
 disk 2, s:0, o:1, n:2 rd:2 us:1 dev:scsi/host0/bus0/target3/lun0/disc
 disk 3, s:0, o:1, n:3 rd:3 us:1 dev:scsi/host0/bus0/target4/lun0/disc
 disk 4, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
 disk 5, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
 disk 6, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
 disk 7, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
 disk 8, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
 disk 9, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
 disk 10, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
 disk 11, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
RAID5 conf printout:
 --- rd:4 wd:4 fd:0
 disk 0, s:0, o:1, n:0 rd:0 us:1 dev:scsi/host0/bus0/target1/lun0/disc
 disk 1, s:0, o:1, n:1 rd:1 us:1 dev:scsi/host0/bus0/target2/lun0/disc
 disk 2, s:0, o:1, n:2 rd:2 us:1 dev:scsi/host0/bus0/target3/lun0/disc
 disk 3, s:0, o:1, n:3 rd:3 us:1 dev:scsi/host0/bus0/target4/lun0/disc
 disk 4, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
 disk 5, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
 disk 6, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
 disk 7, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
 disk 8, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
 disk 9, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
 disk 10, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
 disk 11, s:0, o:0, n:0 rd:0 us:0 dev:[dev 00:00]
md: updating md0 RAID superblock on device
scsi/host0/bus0/target4/lun0/disc [events: 0000002c](write) scsi/host0/bus0/target4/lun0/disc's sb offset: 17921728
scsi/host0/bus0/target3/lun0/disc [events: 0000002c](write) scsi/host0/bus0/target3/lun0/disc's sb offset: 17921728
scsi/host0/bus0/target2/lun0/disc [events: 0000002c](write) scsi/host0/bus0/target2/lun0/disc's sb offset: 17921728
scsi/host0/bus0/target1/lun0/disc [events: 0000002c](write) scsi/host0/bus0/target1/lun0/disc's sb offset: 17921728
.
... autorun DONE.
Software Watchdog Timer: 0.05, timer margin: 60 sec
3c59x.c 18Feb01 Donald Becker and others http://www.scyld.com/network/vortex.html
eth0: 3Com 3c905B Cyclone 100baseTx at 0xd800,  00:01:02:a6:76:c9, IRQ 18
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 786d.
  Enabling bus-master transmits and whole-frame receives.
eth0: Initial media type Autonegotiate.
eth0: MII #24 status 786d, link partner capability 45e1, setting full-duplex.
Installing knfsd (copyright (C) 1996 okir@monad.swb.de)

--------------DF902DE13DDB9FF2DC6CD4B5
Content-Type: text/plain; charset=us-ascii;
 name="schiller-2.2.19.lspci"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="schiller-2.2.19.lspci"

00:00.0 Host bridge: Relience Computer CNB20HE (rev 05)
	Flags: bus master, medium devsel, latency 32

00:00.1 Host bridge: Relience Computer CNB20HE (rev 05)
	Flags: bus master, medium devsel, latency 48

00:05.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] (rev 30)
	Subsystem: 3Com Corporation: Unknown device 9055
	Flags: bus master, medium devsel, latency 32, IRQ 18
	I/O ports at d800
	Memory at fe000000 (32-bit, non-prefetchable)
	Capabilities: [dc] Power Management version 1

00:07.0 VGA compatible controller: ATI Technologies Inc: Unknown device 4752 (rev 27) (prog-if 00 [VGA])
	Subsystem: Asustek Computer, Inc.: Unknown device 802b
	Flags: bus master, stepping, medium devsel, latency 32
	Memory at fd000000 (32-bit, non-prefetchable)
	I/O ports at f000
	Memory at fc800000 (32-bit, non-prefetchable)
	Expansion ROM at febc0000 [disabled]
	Capabilities: [5c] Power Management version 2

00:0f.0 ISA bridge: Relience Computer: Unknown device 0200 (rev 50)
	Subsystem: Relience Computer: Unknown device 0200
	Flags: bus master, medium devsel, latency 0

00:0f.1 IDE interface: Relience Computer: Unknown device 0211 (prog-if 8a [Master SecP PriP])
	Flags: bus master, medium devsel, latency 32
	I/O ports at d000

01:03.0 SCSI storage controller: Adaptec 7892A (rev 02)
	Subsystem: Adaptec: Unknown device e2a0
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 22
	BIST result: 00
	I/O ports at b800
	Memory at fb800000 (64-bit, non-prefetchable)
	Capabilities: [dc] Power Management version 2

01:05.0 SCSI storage controller: Symbios Logic Inc. (formerly NCR): Unknown device 0020 (rev 01)
	Flags: bus master, medium devsel, latency 72, IRQ 24
	I/O ports at b400
	Memory at fb000000 (64-bit, non-prefetchable)
	Memory at fa800000 (64-bit, non-prefetchable)
	Capabilities: [40] Power Management version 2

01:05.1 SCSI storage controller: Symbios Logic Inc. (formerly NCR): Unknown device 0020 (rev 01)
	Flags: bus master, medium devsel, latency 72, IRQ 25
	I/O ports at b000
	Memory at fa000000 (64-bit, non-prefetchable)
	Memory at f9800000 (64-bit, non-prefetchable)
	Capabilities: [40] Power Management version 2


--------------DF902DE13DDB9FF2DC6CD4B5--

