Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130308AbQLCMzq>; Sun, 3 Dec 2000 07:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130490AbQLCMzg>; Sun, 3 Dec 2000 07:55:36 -0500
Received: from linux.kappa.ro ([194.102.255.131]:26636 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id <S130308AbQLCMz0>;
	Sun, 3 Dec 2000 07:55:26 -0500
Date: Sun, 3 Dec 2000 14:24:33 +0200
From: Mircea Damian <dmircea@kappa.ro>
To: linux-kernel@vger.kernel.org
Subject: corruption on my ext2fs with 2.4.0-test10
Message-ID: <20001203142433.A3806@linux.kappa.ro>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hello people,

Since I've seen that there are some problems with corruption on ext2fs I
thought that it would be a good idea to report my problem too.

I have a 2.4.0-test10 patched with reiserfs (but I do not use it - it was
just in my plan to create a partition sometime; so I think that it does not
matter to much). Kernel compiled with egcs-1.1.2:

root@invasion:~# gcc -v
Reading specs from /usr/lib/gcc-lib/i386-slackware-linux/egcs-2.91.66/specs
gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release)

The problem is that I tried to build perl-5.6.0 and some of my tests were
failing. First I thought that it is a problem with shared libraries but I
was wrong, in the test directory I have a file named "big" which has 5Gb
(almost):

root@invasion:/# debugfs /dev/hda2
debugfs 1.19, 13-Jul-2000 for EXT2 FS 0.5b, 95/08/09
debugfs:  cd /usr/src/perl-5.6.0/t/
debugfs:  ls
1097360 (12) .   1354979 (184) ..   1097503 (3900) big   
debugfs:  ls -l
1097360  40700    504   1001    4096  3-Dec-2000 13:43 .
1354979  40755    504   1001    4096  3-Dec-2000 13:43 ..
1097503 100644      0      0   5000000003  3-Dec-2000 10:00 big

Ofcourse this is wrong because:
debugfs:  q
root@invasion:/# df
Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/hda2              5999072    756772   4932648  13% /


I've checked my syslog and messages for ext2 warnings but I found nothing
unusual.

The system is UP and dmesg output is attached.

OTOH does anyone know how to silent messages like:
NAT: 0 dropping untracked packet c7d205c0 1 192.129.3.151 -> 224.0.0.1
NAT: 0 dropping untracked packet c7d129a0 1 192.129.3.151 -> 224.0.0.1
They are annoying and after some time they just fill up my dmesg output
(all dropped packets are multicast just like the two above).



-- 
Mircea Damian
E-mails: dmircea@kappa.ro, dmircea@roedu.net
WebPage: http://taz.mania.k.ro/~dmircea/

--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg-2.4.0-test10-reiserfs"

uto BOOT_IMAGE=Linux ro root=302 console=ttyS0,38400
Initializing CPU#0
Detected 400.914 MHz processor.
Console: colour VGA+ 80x30
Calibrating delay loop... 799.54 BogoMIPS
Memory: 126788k/131072k available (1207k kernel code, 3896k reserved, 85k data, 196k init, 0k highmem)
Dentry-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 8192 (order: 4, 65536 bytes)
CPU: Before vendor init, caps: 0183fbff 00000000 00000000, vendor = 0
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 512K
Intel machine check architecture supported.
Intel machine check reporting enabled on CPU#0.
CPU: After vendor init, caps: 0183fbff 00000000 00000000 00000000
CPU: After generic, caps: 0183fbff 00000000 00000000 00000000
CPU: Common caps: 0183fbff 00000000 00000000 00000000
CPU: Intel Pentium II (Deschutes) stepping 02
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
enabled ExtINT on CPU#0
ESR value before enabling vector: 00000004
ESR value after enabling vector: 00000000
ENABLING IO-APIC IRQs
...changing IO-APIC physical APIC ID to 2 ... ok.
Synchronizing Arb IDs.
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=49 pin1=2 pin2=0
activating NMI Watchdog ... done.
number of MP IRQ sources: 20.
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
 01 001 01  0    0    0   0   0    1    1    39
 02 001 01  0    0    0   0   0    1    1    31
 03 001 01  0    0    0   0   0    1    1    41
 04 001 01  0    0    0   0   0    1    1    49
 05 001 01  0    0    0   0   0    1    1    51
 06 001 01  0    0    0   0   0    1    1    59
 07 001 01  0    0    0   0   0    1    1    61
 08 001 01  0    0    0   0   0    1    1    69
 09 001 01  0    0    0   0   0    1    1    71
 0a 001 01  0    0    0   0   0    1    1    79
 0b 001 01  0    0    0   0   0    1    1    81
 0c 001 01  0    0    0   0   0    1    1    89
 0d 000 00  1    0    0   0   0    0    0    00
 0e 001 01  0    0    0   0   0    1    1    91
 0f 001 01  0    0    0   0   0    1    1    99
 10 000 00  1    0    0   0   0    0    0    00
 11 001 01  1    1    0   1   0    1    1    A1
 12 001 01  1    1    0   1   0    1    1    A9
 13 001 01  1    1    0   1   0    1    1    B1
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
IRQ9 -> 9
IRQ10 -> 10
IRQ11 -> 11
IRQ12 -> 12
IRQ13 -> 13
IRQ14 -> 14
IRQ15 -> 15
IRQ17 -> 17
IRQ18 -> 18
IRQ19 -> 19
.................................... done.
calibrating APIC timer ...
..... CPU clock speed is 400.9180 MHz.
..... host bus clock speed is 100.2292 MHz.
cpu: 0, clocks: 1002292, slice: 501146
CPU0<T0:1002288,T1:501136,D:6,S:501146,C:1002292>
mtrr: v1.37 (20001109) Richard Gooch (rgooch@atnf.csiro.au)
mtrr: detected mtrr type: Intel
PCI: PCI BIOS revision 2.10 entry at 0xfb340, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
Unknown bridge resource 2: assuming transparent
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
PCI->APIC IRQ transform: (B0,I9,P0) -> 17
PCI->APIC IRQ transform: (B0,I10,P0) -> 18
PCI->APIC IRQ transform: (B0,I11,P0) -> 19
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
apm: BIOS version 1.2 Flags 0x07 (Driver version 1.13)
ACPI: found PIIX4 at 0x4000
acpi: APM is already active.
Starting kswapd v1.8
i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
i2c-algo-pcf.o: i2c pcf8584 algorithm module
i2c-elektor.o: i2c pcf8584-isa adapter module
i2c-dev.o: Registered 'PCF8584 ISA adapter' as minor 0
i2c-core.o: adapter PCF8584 ISA adapter registered as adapter 0.
i2c-elektor.o: found device at 0x300.
Detected PS/2 Mouse Port.
pty: 256 Unix98 ptys configured
keyboard: Timeout - AT keyboard not present?
keyboard: Timeout - AT keyboard not present?
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: enabling 8 loop devices
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PIIX4: IDE controller on PCI bus 00 dev 39
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
hda: WDC AC26400R, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 12594960 sectors (6449 MB) w/512KiB Cache, CHS=784/255/63, UDMA(33)
Partition check:
 hda: hda1 hda2
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
PPP generic driver version 2.4.1
Registered PPPoX v0.5
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html
eepro100.c: $Revision: 1.35 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eth0: Intel Corporation 82557 [Ethernet Pro 100], 00:90:27:51:87:42, IRQ 17.
  Board assembly 689661-004, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x24c9f043).
  Receiver lock-up workaround activated.
eth1: Intel Corporation 82557 [Ethernet Pro 100] (#2), 00:90:27:51:87:75, IRQ 18.
  Board assembly 689661-004, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x24c9f043).
  Receiver lock-up workaround activated.
eth2: Intel Corporation 82557 [Ethernet Pro 100] (#3), 00:90:27:51:87:79, IRQ 19.
  Board assembly 689661-004, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x24c9f043).
  Receiver lock-up workaround activated.
PPP Deflate Compression module registered
PPP BSD Compression module registered
Registered PPPoE v0.6.4
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
ip_conntrack (1024 buckets, 8192 max)
ip_tables: (c)2000 Netfilter core team
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 196k freed
Adding Swap: 104384k swap-space (priority -1)
NAT: 0 dropping untracked packet c7d205c0 1 192.129.3.151 -> 224.0.0.1
NAT: 0 dropping untracked packet c7d129a0 1 192.129.3.151 -> 224.0.0.1

--17pEHd4RhPHOinZp--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
