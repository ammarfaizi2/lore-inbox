Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287293AbRL3Azm>; Sat, 29 Dec 2001 19:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287292AbRL3Azd>; Sat, 29 Dec 2001 19:55:33 -0500
Received: from c007-h015.c007.snv.cp.net ([209.228.33.222]:1988 "HELO
	c007.snv.cp.net") by vger.kernel.org with SMTP id <S287282AbRL3AzW>;
	Sat, 29 Dec 2001 19:55:22 -0500
X-Sent: 30 Dec 2001 00:55:15 GMT
Message-ID: <3C2E65F3.D54E8048@bigfoot.com>
Date: Sat, 29 Dec 2001 16:55:15 -0800
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.20i i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.2.20 - laptop losing 4 seconds every 17 minutes ??
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Toshiba 320CT, 2.2.20.  I noticed a 'synchronization lost' pattern in
xntpd logs.  

Ran a test loop with 'ntpdate -q' to my LAN time server at 1 second
intervals and discovered the laptop is losing precisely 4 seconds (jump)
every 17 minutes.

There are no unusual cron jobs, nor does any obvious process trigger as
far as top output shows.  There is an Abit KA7 using the same kernel,
ntp server and client setup, and on the same LAN with no issues.

Where else can I look?

Rgds,
tim.

[tim@lap ~]# cat /proc/cmdline
auto BOOT_IMAGE=linux ro root=302 linear apm=off


['ntpdate -q' @ 1 second interval, xntpd not running]
...
29 Dec 11:56:52 ntpdate[2780]: adjust time server 192.168.1.11 offset
0.002125 sec
server 192.168.1.11, stratum 3, offset 3.992613, delay 0.02609
29 Dec 11:56:53 ntpdate[2782]: step time server 192.168.1.11 offset
3.992613 sec
server 192.168.1.11, stratum 3, offset 3.992623, delay 0.02609
...
29 Dec 12:13:52 ntpdate[4599]: step time server 192.168.1.11 offset
4.003295 sec
server 192.168.1.11, stratum 3, offset 7.993790, delay 0.02608
29 Dec 12:13:53 ntpdate[4601]: step time server 192.168.1.11 offset
7.993790 sec
server 192.168.1.11, stratum 3, offset 7.993804, delay 0.02609
...
29 Dec 12:30:52 ntpdate[6409]: step time server 192.168.1.11 offset
8.004875 sec
server 192.168.1.11, stratum 3, offset 11.995373, delay 0.02609
29 Dec 12:30:53 ntpdate[6411]: step time server 192.168.1.11 offset
11.995373 sec
server 192.168.1.11, stratum 3, offset 11.995386, delay 0.02609
...
29 Dec 12:47:52 ntpdate[8220]: step time server 192.168.1.11 offset
12.006176 sec
server 192.168.1.11, stratum 3, offset 15.996671, delay 0.02608
29 Dec 12:47:53 ntpdate[8222]: step time server 192.168.1.11 offset
15.996671 sec
server 192.168.1.11, stratum 3, offset 15.996680, delay 0.02609

...
Dec 29 14:36:43 lap xntpd: xntpd startup succeeded 
Dec 29 14:36:44 lap xntpd[806]: xntpd 3-5.93e Fri Apr  6 13:16:48 EDT
2001 (1) 
Dec 29 14:36:44 lap xntpd[806]: tickadj = 5, tick = 10001, tvu_maxslew =
490, est. hz = 99 
Dec 29 14:36:44 lap xntpd[806]: precision = 15 usec 
Dec 29 14:36:44 lap xntpd[806]: read drift of 0 from /etc/ntp/drift 
Dec 29 14:41:01 lap xntpd[806]: synchronized to 192.168.1.11, stratum=3 
Dec 29 14:41:01 lap xntpd[806]: time reset (step) 4.005706 s 
Dec 29 14:41:01 lap xntpd[806]: synchronisation lost 
Dec 29 14:45:18 lap xntpd[806]: synchronized to LOCAL(0), stratum=10 
Dec 29 14:46:21 lap xntpd[806]: synchronized to 192.168.1.11, stratum=3 
Dec 29 14:46:21 lap xntpd[806]: kernel pll status change 89 
Dec 29 14:53:53 lap xntpd[806]: synchronisation lost 
Dec 29 14:53:54 lap xntpd[806]: synchronized to LOCAL(0), stratum=10 
Dec 29 14:55:48 lap xntpd[806]: synchronized to 192.168.1.11, stratum=3 
Dec 29 15:10:32 lap xntpd[806]: synchronisation lost 
...

Linux version 2.2.20i (root@lap) (gcc version egcs-2.91.66
19990314/Linux (egcs-1.1.2 rele
ase)) #11 Fri Dec 28 13:03:21 PST 2001
BIOS-provided physical RAM map:
 BIOS-e820: 0009f000 @ 00000000 (usable)
 BIOS-e820: 03f10000 @ 00100000 (usable)
 BIOS-e820: 00010000 @ 04010000 (usable)
Detected 266622 kHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 530.84 BogoMIPS
Memory: 63172k/65664k available (1044k kernel code, 412k reserved, 988k
data, 48k init)
Dentry hash table entries: 16384 (order 5, 128k)
Buffer cache hash table entries: 65536 (order 6, 256k)
Page cache hash table entries: 16384 (order 4, 64k)
CPU: Intel Mobile Pentium MMX stepping 01
Checking 386/387 coupling... OK, FPU using exception 16 error reporting.
Checking 'hlt' instruction... OK.
Intel Pentium with F0 0F bug - workaround enabled.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xfd557
PCI: Using configuration type 1
PCI: Probing PCI hardware
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
TCP: Hash tables configured (ehash 65536 bhash 65536)
Starting kswapd v 1.5 
parport0: PC-style at 0x3bc (0x7bc) [SPP,ECP,ECPPS2]
parport0: detected irq 7; use procfs to enable interrupt-driven
operation.
Detected PS/2 Mouse Port.
Serial driver version 4.27 with no serial options enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 8250
Toshiba System Managment Mode driver v1.9 22/3/2001
Sound initialization started
Found OPL3-SAx (YMF719)
<MS Sound System (CS4231)> at 0x534 irq 9 dma 0,1
ad1848: Interrupt test failed (IRQ9)
<MPU-401 0.0  Midi interface #1> at 0x330 irq 9 dma 0
Sound initialization complete
loop: registered device at major 7
Uniform Multi-Platform E-IDE driver Revision: 6.30
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
hda: IBM-DTCA-24090, ATA DISK drive
hdc: TOSHIBA CD-ROM XM-1602B, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: IBM-DTCA-24090, 3909MB w/468kB Cache, CHS=993/128/63
ppa: Version 2.07 (for Linux 2.2.x)
WARNING - no ppa compatible devices found.
  As of 31/Aug/1998 Iomega started shipping parallel
  port ZIP drives with a different interface which is
  supported by the imm (ZIP Plus) driver. If the
  cable is marked with "AutoDetect", this is what has
  happened.
scsi : 0 hosts.
scsi : detected total.
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
apm: BIOS version 1.2 Flags 0x02 (Driver version 1.13)
apm: disabled on user request.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 48k freed
Adding Swap: 258040k swap-space (priority -1)
Linux PCMCIA Card Services 3.1.30
  kernel build: 2.2.20i #4 Thu Dec 13 21:36:36 PST 2001
  options:  [pci] [apm]
PCI routing table version 1.0 at 0xf8e80
Intel ISA/PCI/CardBus PCIC probe:
  Intel i82365sl B step rev 00 ISA-to-PCMCIA at port 0x3e0 ofs 0x00
    host opts [0]: none
    host opts [1]: none
    ISA irqs (scanned) = 3,4,5,7,10,12 status change on irq 10
cs: memory probe 0x0d0000-0x0dffff: clean.
xirc2ps_cs.c 1.31 1998/12/09 19:32:55 (dd9jn+kvh)
cs: IO port probe 0x0100-0x04ff: excluding 0x220-0x22f 0x340-0x347
0x388-0x38f 0x3b8-0x3e7
 0x480-0x48f 0x4d0-0x4d7
cs: IO port probe 0x0230-0x033f: clean.
cs: IO port probe 0x0348-0x0387: clean.
cs: IO port probe 0x0390-0x03b7: clean.
cs: IO port probe 0x03e8-0x047f: clean.
cs: IO port probe 0x0490-0x04cf: clean.
cs: IO port probe 0x04d8-0x04ff: clean.
cs: IO port probe 0x0800-0x08ff: clean.
cs: IO port probe 0x0a00-0x0aff: clean.
cs: IO port probe 0x0c00-0x0cff: excluding 0xcf8-0xcff
eth0: Xircom: port 0x300, irq 3, hwaddr 00:80:C7:75:B4:A3
eth0: MII link partner: 41e1
eth0: MII selected
eth0: media 100BaseT, silicon revision 4

--
