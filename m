Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310422AbSCGRYy>; Thu, 7 Mar 2002 12:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310421AbSCGRYo>; Thu, 7 Mar 2002 12:24:44 -0500
Received: from [151.17.201.167] ([151.17.201.167]:55050 "EHLO mail.teamfab.it")
	by vger.kernel.org with ESMTP id <S310418AbSCGRY1>;
	Thu, 7 Mar 2002 12:24:27 -0500
Message-ID: <3C87A2D1.9D25EB3A@teamfab.it>
Date: Thu, 07 Mar 2002 18:26:41 +0100
From: Luca Montecchiani <luca.montecchiani@teamfab.it>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19-i586-SMP-modular i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: SOLVED Re: [OOPS] Linux 2.2.21pre[23]
In-Reply-To: <E16j0fe-0002m9-00@the-village.bc.nu> <3C879558.A727E265@teamfab.it> <20020307173948.I29587@suse.de> <3C879E01.B2BFAFCD@teamfab.it> <20020307181136.J29587@suse.de>
Content-Type: multipart/mixed;
 boundary="------------935393E8A3A454A55D7E36DB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------935393E8A3A454A55D7E36DB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Dave Jones wrote:

:
> 2.2 has
> extern inline unsigned int cpuid_eax(unsigned int op)
> {
>     unsigned int eax, ebx, ecx, edx;
> 
>     __asm__("cpuid"
>         : "=a" (eax), "=b" (ebx), "=c" (ecx), "=d" (edx)
>         : "a" (op));
>     return eax;
> }
> 
> 2.4 has
>     unsigned int eax;
> 
>     __asm__("cpuid"
>         : "=a" (eax)
>         : "0" (op)
>         : "bx", "cx", "dx");
>     return eax;
> 
> Though, that shouldn't make any noticable difference unless.

It was!
I've applied that changes and the oops disappear :P
I've attached the 2.2.21pre2+processor.h patch dmesg.

Problem START: Thu, 07 Mar 2002 17:05:28 +0100
Problem END  : Thu, 07 Mar 2002 18:25:00 +0100

really not bad ;)
luca
--------------935393E8A3A454A55D7E36DB
Content-Type: text/plain; charset=us-ascii;
 name="2221pre2.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2221pre2.txt"

Linux version 2.2.21pre2 (root@localhost.localdomain.net) (gcc version egcs-2.91.66 19990314 (egcs-1.1.2 release)) #2 SMP Thu Mar 7 18:04:46 CET 2002
USER-provided physical RAM map:
 USER: 0009f000 @ 00000000 (usable)
 USER: 0fef0000 @ 00100000 (usable)
Intel MultiProcessor Specification v1.4
    Virtual Wire compatibility mode.
OEM ID: INTEL    Product ID: Lancewood    APIC at: 0xFEE00000
Processor #1 Pentium(tm) Pro APIC version 17
Processor #0 Pentium(tm) Pro APIC version 17
I/O APIC #2 Version 17 at 0xFEC00000.
Processors: 2
mapped APIC to ffffe000 (fee00000)
mapped IOAPIC to ffffd000 (fec00000)
Detected 696421 kHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 1389.36 BogoMIPS
Memory: 257204k/262080k available (1352k kernel code, 424k reserved, 3004k data, 96k init)
Dentry hash table entries: 32768 (order 6, 256k)
Buffer cache hash table entries: 262144 (order 8, 1024k)
Page cache hash table entries: 65536 (order 6, 256k)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#1.
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
Intel machine check reporting enabled on CPU#1.
per-CPU timeslice cutoff: 50.02 usecs.
CPU1: Intel Pentium III (Coppermine) stepping 03
calibrating APIC timer ... 
..... CPU clock speed is 696.4595 MHz.
..... system bus clock speed is 99.4940 MHz.
Booting processor 0 eip 2000
Calibrating delay loop... 1392.64 BogoMIPS
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 256K
CPU serial number disabled.
Intel machine check reporting enabled on CPU#0.
OK.
CPU0: Intel Pentium III (Coppermine) stepping 03
Total of 2 processors activated (2782.00 BogoMIPS).
enabling symmetric IO mode... ...done.
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-9, 2-10, 2-11, 2-16, 2-17, 2-18, 2-20, 2-22, 2-23 not connected.
number of MP IRQ sources: 17.
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
 01 0FF 0F  1    0    0   0   0    1    1    59
 02 0FF 0F  0    0    0   0   0    1    1    51
 03 0FF 0F  1    0    0   0   0    1    1    61
 04 0FF 0F  1    0    0   0   0    1    1    69
 05 0FF 0F  1    0    0   0   0    1    1    71
 06 0FF 0F  1    0    0   0   0    1    1    79
 07 0FF 0F  1    0    0   0   0    1    1    81
 08 0FF 0F  1    0    0   0   0    1    1    89
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 0FF 0F  1    0    0   0   0    1    1    91
 0d 000 00  1    0    0   0   0    0    0    00
 0e 0FF 0F  1    0    0   0   0    1    1    99
 0f 0FF 0F  1    0    0   0   0    1    1    A1
 10 000 00  1    0    0   0   0    0    0    00
 11 000 00  1    0    0   0   0    0    0    00
 12 000 00  1    0    0   0   0    0    0    00
 13 0FF 0F  1    1    0   1   0    1    1    A9
 14 000 00  1    0    0   0   0    0    0    00
 15 0FF 0F  1    1    0   1   0    1    1    B1
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
IRQ19 -> 19
IRQ21 -> 21
.................................... done.
checking TSC synchronization across CPUs: passed.
PCI: PCI BIOS revision 2.10 entry at 0xfdab0
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI->APIC IRQ transform: (B0,I12,P0) -> 19
PCI->APIC IRQ transform: (B0,I12,P0) -> 19
PCI->APIC IRQ transform: (B0,I14,P0) -> 21
PCI->APIC IRQ transform: (B0,I18,P3) -> 21
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 262144 bhash 65536)
Starting kswapd v 1.5 
Detected PS/2 Mouse Port.
Serial driver version 4.27 with no serial options enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
pty: 256 Unix98 ptys configured
lp: no devices found
RAM disk driver initialized:  16 RAM disks of 4096K size
loop: registered device at major 7
PIIX4: IDE controller on PCI bus 00 dev 91
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x2860-0x2867, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x2868-0x286f, BIOS settings: hdc:DMA, hdd:pio
hdc: CRD-8520B, ATAPI CDROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hdc: ATAPI 52X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.11
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
(scsi0) <Adaptec AIC-7896/7 Ultra2 SCSI host adapter> found at PCI 0/12/0
(scsi0) Wide Channel A, SCSI ID=7, 32/255 SCBs
(scsi0) Downloading sequencer code... 393 instructions downloaded
(scsi1) <Adaptec AIC-7896/7 Ultra2 SCSI host adapter> found at PCI 0/12/1
(scsi1) Wide Channel B, SCSI ID=7, 32/255 SCBs
(scsi1) Downloading sequencer code... 393 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.33/3.2.4
       <Adaptec AIC-7896/7 Ultra2 SCSI host adapter>
scsi1 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.33/3.2.4
       <Adaptec AIC-7896/7 Ultra2 SCSI host adapter>
scsi : 2 hosts.
  Vendor: IBM       Model: DDYS-T09170N      Rev: S80D
  Type:   Direct-Access                      ANSI SCSI revision: 03
Detected scsi disk sda at scsi0, channel 0, id 0, lun 0
(scsi0:0:0:2) Synchronous at 80.0 Mbyte/sec, offset 63.
scsi : detected 1 SCSI generic 1 SCSI disk total.
SCSI device sda: hdwr sector= 512 bytes. Sectors= 17916240 [8748 MB] [8.7 GB]
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.20.2.10 $ 2000/05/31 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eepro100.c: VA Linux custom, Dragan Stancevic <visitor@valinux.com> 2000/11/15
eth0: Intel PCI EtherExpress Pro100 82557, 00:D0:B7:A7:91:2F, IRQ 21.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.20.2.10 $ 2000/05/31 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eepro100.c: VA Linux custom, Dragan Stancevic <visitor@valinux.com> 2000/11/15
Partition check:
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 96k freed
Adding Swap: 265064k swap-space (priority -1)

--------------935393E8A3A454A55D7E36DB--

