Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131768AbQLVM41>; Fri, 22 Dec 2000 07:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131653AbQLVM4S>; Fri, 22 Dec 2000 07:56:18 -0500
Received: from NS2.pcscs.com ([207.96.110.42]:12042 "EHLO linux01.pcscs.com")
	by vger.kernel.org with ESMTP id <S131632AbQLVM4J>;
	Fri, 22 Dec 2000 07:56:09 -0500
Message-ID: <01e401c06c12$44aeee60$2b6e60cf@pcscs.com>
From: "Charles Wilkins" <chas@pcscs.com>
To: "Andrzej Krzysztofowicz" <ankry@pg.gda.pl>
Cc: <linux-raid@vger.kernel.org>,
        "Linux Kernel mailing list" <linux-kernel@vger.kernel.org>
In-Reply-To: <200012221057.LAA18410@sunrise.pg.gda.pl>
Subject: Re: max number of ide controllers?
Date: Fri, 22 Dec 2000 07:25:28 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "Charles Wilkins wrote:"
> > I have been running with the 2 onboard VIA ide hd controllers (ide 0 and
=
> > ide 1) along with a creative labs ide contoller on a SB32 soundcard (ide
=
> > 2). This has had the cdrom and zip drive.
> >
> > I just added a Promise Ultra100 and it has assumed the role of ide 2 and
=
> > ide 3. The onboard controllers are still ide 0 and ide 1, but the =
> > creative labs controller isnt coming up.
> >
> > Is there a max number of ide controllers that linux-2.2.18 can support?
>
> Please do not send HTML to the list.

The correction has been made. Thank you.

>
> Linux supports up to 10 IDE channels, however channel numbers of PCI
> controllers seem to be assigned first.

This is good to know.

I also corrected my previous posting regarding which ide controller was
which.

without the promise card.
onboard primary is ide0
onboard secondary is ide1
SB32 is ide 2

with the promise card
onboard primary is ide0
onboard secondary is ide1
promise primary is ide2
promise secondary is ide3
SB32 does not come up

> You can try:
> 1. reprogram your SB32 controller to be visible as ide2
> 2. inform your kernel about ide configuration via parameters
>    (eg.: ide2=0x168,10 ...)

I added this to lilo.conf:
append="ide2=0x168,10" and ran lilo

This is what I got:
ide_setup: ide2=0x168,10
.
.
ide2: ports already in use, skipping probe

The promise controllers then setup as ide3 and ide4, but the SB32 still does
not report.
Any ideas?

I also tried others such as 0x1e8,10 and 0x180,10 and they did the same
thing.

> 3. when you report any problem specify which kernel (+which patches) it
>    concerns...

I am running kernel 2.2.18 with ide.2.2.18.1209.patch as well as the latest
raid patches . . .

I included /var/log/dmesg:

Linux version 2.2.18-RAID-SMP (root@linux02.pcscs.com) (gcc driver version
2.95.3 19991030 (prerelease) executing gcc version egcs-2.91.66) #1 SMP Thu
Dec 21 19:01:13 EST 2000
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Intel MultiProcessor Specification v1.1
    Virtual Wire compatibility mode.
OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
Processor #0 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    Bootup CPU
Processor #1 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
Bus #0 is PCI
Bus #1 is PCI
Bus #2 is ISA
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
Detected 400921 kHz processor.
ide_setup: ide2=0x168,10

Console: colour VGA+ 80x25
Calibrating delay loop... 799.53 BogoMIPS
Memory: 646288k/655360k available (1564k kernel code, 428k reserved, 7000k
data, 80k init)
Dentry hash table entries: 131072 (order 8, 1024k)
Buffer cache hash table entries: 524288 (order 9, 2048k)
Page cache hash table entries: 262144 (order 8, 1024k)
VFS: Diskquotas version dquot_6.4.0 initialized
512K L2 cache (4 way)
CPU: L2 Cache: 512K
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.35a (19990819) Richard Gooch (rgooch@atnf.csiro.au)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
512K L2 cache (4 way)
CPU: L2 Cache: 512K
per-CPU timeslice cutoff: 100.09 usecs.
CPU0: Intel Pentium II (Deschutes) stepping 02
Getting VERSION: 40011
Getting VERSION: 40011
Getting LVT0: 700
Getting LVT1: 400
setup_APIC_clock() called.
calibrating APIC timer ...
..... 4009340 CPU clocks in 1 timer chip tick.
..... 1002332 APIC bus clocks in 1 timer chip tick.
..... CPU clock speed is 400.9340 MHz.
..... system bus clock speed is 100.2332 MHz.
CPU map: 3
Booting processor 1 eip 2000
Setting warm reset code and vector.
1.
2.
3.
Asserting INIT.
Deasserting INIT.
Sending STARTUP #1.
After apic_write.
Before start apic_write.
Startup point 1.
Waiting for send to finish...
+CPU#1 waiting for CALLOUT
Sending STARTUP #2.
After apic_write.
Before start apic_write.
Startup point 1.
Waiting for send to finish...
+After Startup.
Before Callout 1.
After Callout 1.
CALLIN, before enable_local_APIC().
setup_APIC_clock() called.
waiting for other CPU calibrating APIC ... done, continuing.
Calibrating delay loop... 801.17 BogoMIPS
Stack at about e7ffbfbc
Intel machine check reporting enabled on CPU#1.
512K L2 cache (4 way)
CPU: L2 Cache: 512K
OK.
CPU1: Intel Pentium II (Deschutes) stepping 02
CPU has booted.
Before bogomips.
Total of 2 processors activated (1600.71 BogoMIPS).
Before bogocount - setting activated=1.
Boot done.
enabling symmetric IO mode... ...done.
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-9, 2-11, 2-20, 2-21, 2-22, 2-23 not connected.
number of MP IRQ sources: 18.
number of IO-APIC #2 registers: 24.
testing the IO APIC.......................

IO APIC #2......
.... register #00: 02000000
.......    : physical APIC id: 02
.... register #01: 00170011
.......     : max redirection entries: 0017
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  0    0    0   0   0    1    1    59
 02 0FF 0F  0    0    0   0   0    1    1    51
 03 000 00  0    0    0   0   0    1    1    61
 04 000 00  0    0    0   0   0    1    1    69
 05 000 00  0    0    0   0   0    1    1    71
 06 000 00  0    0    0   0   0    1    1    79
 07 000 00  0    0    0   0   0    1    1    81
 08 000 00  0    0    0   0   0    1    1    89
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  0    0    0   0   0    1    1    91
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  0    0    0   0   0    1    1    99
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  0    0    0   0   0    1    1    A1
 0f 000 00  0    0    0   0   0    1    1    A9
 10 0FF 0F  1    1    0   1   0    1    1    B1
 11 0FF 0F  1    1    0   1   0    1    1    B9
 12 0FF 0F  1    1    0   1   0    1    1    B9
 13 0FF 0F  1    1    0   1   0    1    1    B9
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
IRQ9 -> 17-> 18-> 19
IRQ10 -> 10
IRQ11 -> 16
IRQ12 -> 12
IRQ13 -> 13
IRQ14 -> 14
IRQ15 -> 15
.................................... done.
checking TSC synchronization across CPUs: passed.
Setting commenced=1, go go go
mtrr: your CPUs had inconsistent fixed MTRR settings
mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs
PCI: PCI BIOS revision 2.10 entry at 0xfb2c0
PCI: Using configuration type 1
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
TCP: Hash tables configured (ehash 524288 bhash 65536)
Initializing RT netlink socket
Starting kswapd v 1.5
parport0: PC-style at 0x378 [SPP,PS2]
parport_probe: failed
parport0: no IEEE-1284 device present.
Detected PS/2 Mouse Port.
Serial driver version 4.27 with MANY_PORTS SHARE_IRQ enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.09
RAM disk driver initialized:  16 RAM disks of 4096K size
Uniform Multi-Platform E-IDE driver Revision: 6.30
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 16
VP_IDE: not 100% native mode: will probe irqs later
VT 82C691 Apollo Pro
 Chipset Core ATA-66
Split FIFO Configuration:  8 Primary buffers, threshold = 1/2
                           8 Second. buffers, threshold = 1/2
    ide0: BM-DMA at 0xc000-0xc007, BIOS settings: hda:pio, hdb:pio
ide0: VIA Bus-Master (U)DMA Timing Config Success
    ide1: BM-DMA at 0xc008-0xc00f, BIOS settings: hdc:pio, hdd:pio
ide1: VIA Bus-Master (U)DMA Timing Config Success
PDC20267: IDE controller on PCI bus 00 dev 98
PDC20267: chipset revision 2
PDC20267: not 100% native mode: will probe irqs later
PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
    ide3: BM-DMA at 0xe400-0xe407, BIOS settings: hdg:DMA, hdh:pio
    ide4: BM-DMA at 0xe408-0xe40f, BIOS settings: hdi:DMA, hdj:pio
ide2: ports already in use, skipping probe
hdg: IBM-DTLA-307045, ATA DISK drive
hdi: IBM-DTLA-307045, ATA DISK drive
ide3 at 0xd400-0xd407,0xd802 on irq 9
ide4 at 0xdc00-0xdc07,0xe002 on irq 9
hdg: IBM-DTLA-307045, 43979MB w/1916kB Cache, CHS=89355/16/63, UDMA(100)
hdi: IBM-DTLA-307045, 43979MB w/1916kB Cache, CHS=89355/16/63, UDMA(100)
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
md driver 0.90.0 MAX_MD_DEVS=256, MAX_REAL=12
linear personality registered
raid0 personality registered
raid1 personality registered
raid5 personality registered
raid5: measuring checksumming speed
raid5: MMX detected, trying high-speed MMX checksum routines
   pII_mmx   :   882.777 MB/sec
   p5_mmx    :   928.878 MB/sec
   8regs     :   688.848 MB/sec
   32regs    :   421.767 MB/sec
using fastest function: p5_mmx (928.878 MB/sec)
(scsi0) <Adaptec AHA-2940A Ultra SCSI host adapter> found at PCI 0/16/0
(scsi0) Narrow Channel, SCSI ID=7, 3/255 SCBs
(scsi0) Downloading sequencer code... 422 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.31/3.2.4
       <Adaptec AHA-2940A Ultra SCSI host adapter>
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
scsi : 2 hosts.
(scsi0:0:1:0) Synchronous at 10.0 Mbyte/sec, offset 15.
  Vendor: NEC       Model: CD-ROM DRIVE:463  Rev: 1.05
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 1, lun 0
(scsi0:0:2:0) Synchronous at 4.0 Mbyte/sec, offset 8.
  Vendor: TANDBERG  Model:  SLR5 4/8GB       Rev: =09:
  Type:   Sequential-Access                  ANSI SCSI revision: 02
Detected scsi tape st0 at scsi0, channel 0, id 2, lun 0
  Vendor: HP        Model: C4324/C4325       Rev: 1.27
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr1 at scsi0, channel 0, id 4, lun 0
scsi : detected 3 SCSI generics 1 SCSI tape 2 SCSI cdroms total.
Uniform CD-ROM driver Revision: 3.11
md.c: sizeof(mdp_super_t) = 4096
Partition check:
 hdg: [PTBL] [5606/255/63] hdg1 hdg2 hdg3
 hdi: [PTBL] [5606/255/63] hdi1 hdi2 hdi3
autodetecting RAID arrays
(read) hdg1's sb offset: 40064 [events: 00000022]
(read) hdg3's sb offset: 44475840 [events: 00000022]
(read) hdi1's sb offset: 40064 [events: 00000022]
(read) hdi3's sb offset: 44475840 [events: 00000022]
autorun ...
considering hdi3 ...
  adding hdi3 ...
  adding hdg3 ...
created md0
bind<hdg3,1>
bind<hdi3,2>
running: <hdi3><hdg3>
now!
hdi3's event counter: 00000022
hdg3's event counter: 00000022
md: device name has changed from hdg3 to hdi3 since last import!
md: device name has changed from [dev 21:03] to hdg3 since last import!
md0: max total readahead window set to 128k
md0: 1 data-disks, max readahead per data-disk: 128k
raid1: device hdi3 operational as mirror 0
raid1: device hdg3 operational as mirror 1
(checking disk 0)
(really checking disk 0)
(checking disk 1)
(really checking disk 1)
(checking disk 2)
(checking disk 3)
(checking disk 4)
(checking disk 5)
(checking disk 6)
(checking disk 7)
(checking disk 8)
(checking disk 9)
(checking disk 10)
(checking disk 11)
raid1: raid set md0 active with 2 out of 2 mirrors
md: updating md0 RAID superblock on device
hdi3 [events: 00000023](write) hdi3's sb offset: 44475840
hdg3 [events: 00000023](write) hdg3's sb offset: 44475840
.
considering hdi1 ...
  adding hdi1 ...
  adding hdg1 ...
created md1
bind<hdg1,1>
bind<hdi1,2>
running: <hdi1><hdg1>
now!
hdi1's event counter: 00000022
hdg1's event counter: 00000022
md: device name has changed from hdg1 to hdi1 since last import!
md: device name has changed from [dev 21:01] to hdg1 since last import!
md1: max total readahead window set to 128k
md1: 1 data-disks, max readahead per data-disk: 128k
raid1: device hdi1 operational as mirror 0
raid1: device hdg1 operational as mirror 1
(checking disk 0)
(really checking disk 0)
(checking disk 1)
(really checking disk 1)
(checking disk 2)
(checking disk 3)
(checking disk 4)
(checking disk 5)
(checking disk 6)
(checking disk 7)
(checking disk 8)
(checking disk 9)
(checking disk 10)
(checking disk 11)
raid1: raid set md1 active with 2 out of 2 mirrors
md: updating md1 RAID superblock on device
hdi1 [events: 00000023](write) hdi1's sb offset: 40064
hdg1 [events: 00000023](write) hdg1's sb offset: 40064
.
... autorun DONE.
Coda Kernel/Venus communications, v4.6.0, braam@cs.cmu.edu
P6 Microcode Update Driver v1.05 registered
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 80k freed
Adding Swap: 514072k swap-space (priority 1)


>
> Merry Christmas

and happy holidays to you too!


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
