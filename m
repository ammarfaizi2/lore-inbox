Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270946AbRHNX6D>; Tue, 14 Aug 2001 19:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270948AbRHNX5p>; Tue, 14 Aug 2001 19:57:45 -0400
Received: from www.casdn.neu.edu ([155.33.251.101]:53001 "EHLO
	www.casdn.neu.edu") by vger.kernel.org with ESMTP
	id <S270946AbRHNX51>; Tue, 14 Aug 2001 19:57:27 -0400
From: "Andrew Scott" <A.J.Scott@casdn.neu.edu>
Organization: Northeastern University
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Tue, 14 Aug 2001 19:57:36 -0400
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: 2.2.18 possible timer problem
Reply-to: A.J.Scott@casdn.neu.edu
Message-ID: <3B7982AF.28619.7AB93E7@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm seeing a strange problem on 2.2.18. On _some_ boots of 2.2.18, 
Squid takes an extremely long time to perform it's startup validation 
procedure, at 30 objects per second, rather than at the usual 16 k 
obj/s. When this happens to squid, realserver will also have a 
problem when it detects processors. It will see the first one, and 
then usually detect a second one giving either a very small number 
for performance % or negative % performance number. The normal case 
for realserver is to detect 4 processors at a total of 400% work done.

The computer is an IBM 704, quad PPro/200 with 256 M ram. I'm using 
the built in Adaptec controllers (aic777x) to run several SCSI disks. 
It was running 2.0.39 until recently, with no issues.

I have rebooted the machine several times, and on some reboots 
everything works fine, on others, it doesn't. The only log entry that 
looks suspicious says:

Aug 13 09:26:10 linux kernel: probable hardware bug: clock timer 
configuration lost - probably a VIA686a.

This message has only appeared 3 times, though the machine has been 
rebooted at least a dozen times over the last too days, and there 
doesn't appear to be any relationship between this message, and the 
times I have problems. the motherboard appears to be Intel 'Orion' 
chipset based.

I'm including output from dmesg and cat /proc/pci, will send any 
other relevant information if needed.

Output from /proc/pci follows:

PCI devices found:
  Bus  0, device  11, function  0:
    Ethernet controller: DEC DC21140 (rev 34).
      Medium devsel.  Fast back-to-back capable.  IRQ 16.  Master 
Capable.  Late
ncy=96.  Min Gnt=20.Max Lat=40.
      I/O at 0xfc80 [0xfc81].
      Non-prefetchable 32 bit memory at 0xfeaffc00 [0xfeaffc00].
  Bus  0, device  12, function  0:
    Ethernet controller: Intel 82557 (rev 8).
      Medium devsel.  Fast back-to-back capable.  IRQ 17.  Master 
Capable.  Late
ncy=96.  Min Gnt=8.Max Lat=56.
      Non-prefetchable 32 bit memory at 0xfeafe000 [0xfeafe000].
      I/O at 0xff00 [0xff01].
      Non-prefetchable 32 bit memory at 0xfe900000 [0xfe900000].
  Bus  0, device  13, function  0:
    VGA compatible controller: S3 Inc. Trio32/Trio64 (rev 84).
      Medium devsel.  IRQ 18.
      Non-prefetchable 32 bit memory at 0xf8000000 [0xf8000000].
  Bus  0, device  14, function  0:
    Non-VGA device: Intel 82375EB (rev 21).
      Medium devsel.  Master Capable.  Latency=72.
  Bus  0, device  15, function  0:
    Hot Swap Controller: Intel Unknown device (rev 0).
      Vendor id=8086. Device id=8.
      Fast devsel.  Fast back-to-back capable.
      Prefetchable 32 bit memory at 0xfec01000 [0xfec01008].
      Prefetchable 32 bit memory at 0xfec01000 [0xfec01008].
      Prefetchable 32 bit memory at 0xfec01000 [0xfec01008].
      Prefetchable 32 bit memory at 0xfec01000 [0xfec01008].
      Prefetchable 32 bit memory at 0xfec01000 [0xfec01008].
      Prefetchable 32 bit memory at 0xfec01000 [0xfec01008].
  Bus  0, device  20, function  0:
    RAM memory: Intel 450KX/GX [Orion] - 82453KX/GX Memory Controller 
(rev 5).
      Fast devsel.  Fast back-to-back capable.
  Bus  0, device  25, function  0:
    Host bridge: Intel Orion P6 (rev 6).
      Medium devsel.  Master Capable.  Latency=96.
  Bus  0, device  26, function  0:
    Host bridge: Intel Orion P6 (rev 6).
      Medium devsel.  Master Capable.  Latency=96.
  Bus  1, device  11, function  0:
    SCSI storage controller: Adaptec AIC-7880U (rev 0).
      Medium devsel.  Fast back-to-back capable.  IRQ 28.  Master 
Capable.  Late
ncy=96.  Min Gnt=8.Max Lat=8.
      I/O at 0xec00 [0xec01].
      Non-prefetchable 32 bit memory at 0xf64ff000 [0xf64ff000].
  Bus  1, device  12, function  0:
    SCSI storage controller: Adaptec AIC-7880U (rev 0).
      Medium devsel.  Fast back-to-back capable.  IRQ 29.  Master 
Capable.  Late
ncy=96.  Min Gnt=8.Max Lat=8.
      I/O at 0xe800 [0xe801].
      Non-prefetchable 32 bit memory at 0xf64fe000 [0xf64fe000].
  Bus  1, device  13, function  0:
    SCSI storage controller: IBM ServeRAID (rev 2).
      Medium devsel.  IRQ 20.  Master Capable.  Latency=96.
      I/O at 0xe400 [0xe401].
      Non-prefetchable 20 bit memory at 0xf64fc000 [0xf64fc002].

Output from dmesg follows:

Linux version 2.2.19 (root@linux) (gcc version 2.95.2 19991024 
(release)) #9 SMP
 Tue Aug 14 17:19:38 EDT 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0009f000 @ 00000000 (usable)
 BIOS-e820: 0ff00000 @ 00100000 (usable)
Scan SMP from c0000000 for 1024 bytes.
Scan SMP from c009fc00 for 1024 bytes.
Scan SMP from c00f0000 for 65536 bytes.
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: INTEL    Product ID: ALDER        APIC at: 0xFEC08000
Processor #0 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
    Bootup CPU
Processor #4 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
Processor #1 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
Processor #2 Pentium(tm) Pro APIC version 17
    Floating point unit present.
    Machine Exception supported.
    64 bit compare & exchange supported.
    Internal APIC present.
Bus #0 is PCI
Bus #1 is PCI
Bus #18 is EISA
I/O APIC #14 Version 17 at 0xFEC00000.
I/O APIC #13 Version 17 at 0xFEC01000.
Processors: 4
mapped APIC to ffffe000 (fec08000)
mapped IOAPIC to ffffd000 (fec00000)
mapped IOAPIC to ffffc000 (fec01000)
Detected 198953 kHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 396.49 BogoMIPS
Memory: 257404k/262144k available (1396k kernel code, 424k reserved, 
2860k data,
 60k init)
Dentry hash table entries: 32768 (order 6, 256k)
Buffer cache hash table entries: 262144 (order 8, 1024k)
Page cache hash table entries: 65536 (order 6, 256k)
512K L2 cache (4 way)
CPU: L2 Cache: 512K
Checking 386/387 coupling... OK, FPU using exception 16 error 
reporting.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
mtrr: v1.35a (19990819) Richard Gooch (rgooch@atnf.csiro.au)
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
512K L2 cache (4 way)
CPU: L2 Cache: 512K
per-CPU timeslice cutoff: 100.32 usecs.
CPU0: Intel Pentium Pro stepping 09
Getting VERSION: 40011
Getting VERSION: 40011
Getting LVT0: 10000
Getting LVT1: 400
setup_APIC_clock() called.
calibrating APIC timer ...
..... 1989538 CPU clocks in 1 timer chip tick.
..... 663177 APIC bus clocks in 1 timer chip tick.
..... CPU clock speed is 198.9538 MHz.
..... system bus clock speed is 66.3177 MHz.
CPU map: 17
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
CPU#1 waiting for CALLOUT
Waiting for send to finish...
+Sending STARTUP #2.
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
Calibrating delay loop... 397.31 BogoMIPS
Stack at about cfffbfa4
Intel machine check reporting enabled on CPU#1.
512K L2 cache (4 way)
CPU: L2 Cache: 512K
OK.
CPU1: Intel Pentium Pro stepping 09
CPU has booted.
Booting processor 2 eip 2000
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
CPU#2 waiting for CALLOUT
Waiting for send to finish...
+Sending STARTUP #2.
After apic_write.
Before start apic_write.
Startup point 1.
Waiting for send to finish...
+After Startup.
Before Callout 2.
After Callout 2.
CALLIN, before enable_local_APIC().
setup_APIC_clock() called.
waiting for other CPU calibrating APIC ... done, continuing.
Calibrating delay loop... 397.31 BogoMIPS
Stack at about cfff3fa4
Intel machine check reporting enabled on CPU#2.
512K L2 cache (4 way)
CPU: L2 Cache: 512K
OK.
CPU2: Intel Pentium Pro stepping 09
CPU has booted.
Booting processor 4 eip 2000
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
CPU#4 waiting for CALLOUT
Waiting for send to finish...
+Sending STARTUP #2.
After apic_write.
Before start apic_write.
Startup point 1.
Waiting for send to finish...
+After Startup.
Before Callout 4.
After Callout 4.
CALLIN, before enable_local_APIC().
setup_APIC_clock() called.
waiting for other CPU calibrating APIC ... done, continuing.
Calibrating delay loop... 397.31 BogoMIPS
Stack at about cfff1fa4
Intel machine check reporting enabled on CPU#4.
512K L2 cache (4 way)
CPU: L2 Cache: 512K
OK.
CPU4: Intel Pentium Pro stepping 09
CPU has booted.
Before bogomips.
Total of 4 processors activated (1588.42 BogoMIPS).
Before bogocount - setting activated=1.
Boot done.
enabling symmetric IO mode... ...done.
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 14-0, 13-8, 13-9, 13-10, 13-11WARNING: 
ASSIGN_IRQ_VECTOR w
rapped back to 52
, 13-14 not connected.
number of MP IRQ sources: 42.
number of IO-APIC #14 registers: 16.
number of IO-APIC #13 registers: 16.
testing the IO APIC.......................

IO APIC #14......
.... register #00: 0E000000
.......    : physical APIC id: 0E
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : IO APIC version: 0011
.... register #02: 00000000
.......     : arbitration: 00
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  0    0    0   0   0    1    1    59
 02 0FF 0F  0    0    0   0   0    1    1    51
 03 0FF 0F  1    1    0   0   0    1    1    61
 04 000 00  0    0    0   0   0    1    1    69
 05 0FF 0F  1    1    0   0   0    1    1    71
 06 000 00  0    0    0   0   0    1    1    79
 07 000 00  0    0    0   0   0    1    1    81
 08 000 00  0    0    0   0   0    1    1    89
 09 0FF 0F  1    1    0   0   0    1    1    91
 0a 0FF 0F  1    1    0   0   0    1    1    99
 0b 0FF 0F  1    1    0   0   0    1    1    A1
 0c 000 00  0    0    0   0   0    1    1    A9
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  0    0    0   0   0    1    1    B1
 0f 000 00  0    0    0   0   0    1    1    B9

IO APIC #13......
.... register #00: 0D000000
.......    : physical APIC id: 0D
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : IO APIC version: 0011
.... register #02: 03000000
.......     : arbitration: 03
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 0FF 0F  1    1    0   0   0    1    1    C1
 01 0FF 0F  1    1    0   0   0    1    1    C9
 02 0FF 0F  1    1    0   0   0    1    1    D1
 03 0FF 0F  1    1    0   0   0    1    1    D9
 04 0FF 0F  1    1    0   0   0    1    1    E1
 05 0FF 0F  1    1    0   0   0    1    1    E9
 06 0FF 0F  1    1    0   0   0    1    1    F1
 07 0FF 0F  1    1    0   0   0    1    1    F9
 08 000 00  1    0    0   0   0    0    0    00
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 0FF 0F  1    1    0   0   0    1    1    52
 0d 0FF 0F  1    1    0   0   0    1    1    5A
 0e 000 00  1    0    0   0   0    0    0    00
 0f 0FF 0F  1    1    0   0   0    1    1    62
IRQ to pin mappings:
IRQ0 -> 2
IRQ1 -> 1
IRQ3 -> 3
IRQ4 -> 4
IRQ5 -> 5
IRQ6 -> 6
IRQ7 -> 7
IRQ8 -> 8
IRQ9 -> 9
IRQ10 -> 10
IRQ11 -> 11
IRQ12 -> 12
IRQ13 -> 13
IRQ14 -> 14
IRQ15 -> 15
IRQ16 -> 0
IRQ17 -> 1
IRQ18 -> 2
IRQ19 -> 3
IRQ20 -> 4
IRQ21 -> 5
IRQ22 -> 6
IRQ23 -> 7
IRQ28 -> 12
IRQ29 -> 13
IRQ31 -> 15
.................................... done.
checking TSC synchronization across CPUs: passed.
Setting commenced=1, go go go
PCI: PCI BIOS revision 2.10 entry at 0xfd091
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Discovered primary peer bus 01
PCI->APIC IRQ transform: (B0,I11,P0) -> 16
PCI->APIC IRQ transform: (B0,I12,P0) -> 17
PCI->APIC IRQ transform: (B0,I13,P0) -> 18
PCI->APIC IRQ transform: (B1,I11,P0) -> 28
PCI->APIC IRQ transform: (B1,I12,P0) -> 29
PCI->APIC IRQ transform: (B1,I13,P0) -> 20
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
TCP: Hash tables configured (ehash 262144 bhash 65536)
NET4: Linux IPX 0.38 for NET4.0
IPX Portions Copyright (c) 1995 Caldera, Inc.
NET4: AppleTalk 0.18 for Linux NET4.0
Starting kswapd v 1.5
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.09
Uniform Multi-Platform E-IDE driver Revision: 6.30
ide: Assuming 33MHz system bus speed for PIO modes; override with 
idebus=xx
hda: CD-ROM CDU311, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: ATAPI 8X CD-ROM drive, 256kB Cache
Uniform CD-ROM driver Revision: 3.11
Floppy drive(s): fd0 is 1.44M
FDC 0 is an 82078.
(scsi0) <Adaptec AIC-7880 Ultra SCSI host adapter> found at PCI 1/11/0
(scsi0) Wide Channel, SCSI ID=7, 16/255 SCBs
(scsi0) Downloading sequencer code... 422 instructions downloaded
(scsi1) <Adaptec AIC-7880 Ultra SCSI host adapter> found at PCI 1/12/0
(scsi1) Wide Channel, SCSI ID=7, 16/255 SCBs
(scsi1) Downloading sequencer code... 422 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 
5.1.33/3.2.4
       <Adaptec AIC-7880 Ultra SCSI host adapter>
scsi1 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 
5.1.33/3.2.4
       <Adaptec AIC-7880 Ultra SCSI host adapter>
scsi2 : IBM PCI ServeRAID 4.20.20  <ServeRAID>
scsi : 3 hosts.
  Vendor: ESG-SHV   Model: SCA HSBP M1       Rev: 2.10
  Type:   Processor                          ANSI SCSI revision: 02
Detected scsi generic sg0 at scsi0, channel 0, id 6, lun 0
  Vendor: IBM-PCCO  Model: DDRS-39130Y   !#  Rev: S97B
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sda at scsi0, channel 0, id 8, lun 0
(scsi0:0:8:2) Synchronous at 40.0 Mbyte/sec, offset 8.
(scsi0:0:9:0) Synchronous at 40.0 Mbyte/sec, offset 8.
  Vendor: IBM-PSG   Model: DRHS36D       !#  Rev: 0272
  Type:   Direct-Access                      ANSI SCSI revision: 03
Detected scsi disk sdb at scsi0, channel 0, id 9, lun 0
  Vendor: ESG-SHV   Model: SCA HSBP M1       Rev: 2.10
  Type:   Processor                          ANSI SCSI revision: 02
Detected scsi generic sg3 at scsi1, channel 0, id 6, lun 0
  Vendor: QUANTUM   Model: XP39100J          Rev: LYK8
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdc at scsi1, channel 0, id 8, lun 0
(scsi1:0:8:2) Synchronous at 40.0 Mbyte/sec, offset 8.
  Vendor: QUANTUM   Model: XP39100J          Rev: LYK8
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sdd at scsi1, channel 0, id 9, lun 0
(scsi1:0:9:2) Synchronous at 40.0 Mbyte/sec, offset 8.
  Vendor: QUANTUM   Model: XP39100J          Rev: LYK8
  Type:   Direct-Access                      ANSI SCSI revision: 02
Detected scsi disk sde at scsi1, channel 0, id 10, lun 0
(scsi1:0:10:2) Synchronous at 40.0 Mbyte/sec, offset 8.
  Vendor:  IBM      Model:  SERVERAID        Rev:  1.0
  Type:   Processor                          ANSI SCSI revision: 01
Detected scsi generic sg7 at scsi2, channel 0, id 15, lun 0
scsi : detected 8 SCSI generics 5 SCSI disks total.
SCSI device sda: hdwr sector= 512 bytes. Sectors= 17774160 [8678 MB] 
[8.7 GB]
SCSI device sdb: hdwr sector= 512 bytes. Sectors= 71096640 [34715 MB] 
[34.7 GB]
SCSI device sdc: hdwr sector= 512 bytes. Sectors= 17781520 [8682 MB] 
[8.7 GB]
SCSI device sdd: hdwr sector= 512 bytes. Sectors= 17781520 [8682 MB] 
[8.7 GB]
SCSI device sde: hdwr sector= 512 bytes. Sectors= 17781520 [8682 MB] 
[8.7 GB]
eepro100.c:v1.09j-t 9/29/99 Donald Becker 
http://cesdis.gsfc.nasa.gov/linux/driv
ers/eepro100.html
eepro100.c: $Revision: 1.20.2.10 $ 2000/05/31 Modified by Andrey V. 
Savochkin <s
aw@saw.sw.com.sg> and others
eepro100.c: VA Linux custom, Dragan Stancevic <visitor@valinux.com> 
2000/11/15
eth0: OEM i82557/i82558 10/100 Ethernet, 00:90:27:9B:D2:82, IRQ 17.
  Board assembly 735190-001, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  Forcing 100Mbs full-duplex operation.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
eepro100.c:v1.09j-t 9/29/99 Donald Becker 
http://cesdis.gsfc.nasa.gov/linux/driv
ers/eepro100.html
eepro100.c: $Revision: 1.20.2.10 $ 2000/05/31 Modified by Andrey V. 
Savochkin <s
aw@saw.sw.com.sg> and others
eepro100.c: VA Linux custom, Dragan Stancevic <visitor@valinux.com> 
2000/11/15
probable hardware bug: clock timer configuration lost - probably a 
VIA686a.
Partition check:
probable hardware bug: restoring chip configuration.
 sda: sda1 sda2 sda3
 sdb: sdb1 sdb2
 sdc: sdc1 sdc2
 sdd: sdd1 sdd2 sdd3 sdd4
 sde: sde1 sde2 sde3 < > sde4
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 60k freed
Adding Swap: 130040k swap-space (priority -1)
Adding Swap: 129004k swap-space (priority -2)
linux:/var/log #
                      _
                     / \   / ascott@casdn.neu.edu
                    / \ \ /
                   /   \_/
