Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273783AbRJNCoT>; Sat, 13 Oct 2001 22:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273831AbRJNCoL>; Sat, 13 Oct 2001 22:44:11 -0400
Received: from satan.intac.net ([199.173.52.34]:58894 "EHLO source.intac.net")
	by vger.kernel.org with ESMTP id <S273783AbRJNCnx>;
	Sat, 13 Oct 2001 22:43:53 -0400
Date: Sat, 13 Oct 2001 22:37:41 -0400 (EDT)
From: kernellist@source.intac.net
To: linux-kernel@vger.kernel.org
Subject: Linux locks up (100+ node network; Have tried different kernels,
 etc.)
Message-ID: <Pine.LNX.4.21.0110132154160.5530-100000@source.intac.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings all. I have various Linux installations at work, and have never
run into any major problems. But in my new installation I have over 100
IBM X 330 Series servers. The Linux build on the servers are standard VA
6.2 Distribution(based on the RedHat 6.2 distro) w/ some in-house
packages, and with kernels recommended from IBM(for support of their ipo
raid module) and others that I have built.

Now, my problem is that many(most..) of these servers have experienced lock-ups
that result in me having them rebooted, and then going through fsck. Below
is a list of kernels I have tried and also my dmesg and a listing of my
pci table, and I am also listing what I have tried and what I believe
might be the problem:

I have not been able to find any type of error message logged to either
the console or to any file. I at first thought it was that IBM's QA was
incompetent, since we found a bunch of servers that lacked CPU fans!(Those
have been since replaced and all servers have all needed
hardware..). Thought maybe some problem that existed in the 2.2.19 pre
kernels(nfs + high load = crash), but I could not replicate the hangs that
way. I've tried kernels recommended from IBM and others that I have
built(and I have a 2.2.14 kernel on 400 servers in another installation 
without any issues for well over a year). I have applied any patches
available for each kernel I have tried(tcp patches, etc.). I have even
also tried IBM's supplied distribution without me modifying a single item
of the distribution(I pop in their CD and install, and still run into the
lock-ups). I also though the problem might be with this funky IBM KVM
setup, which I still haven't totally ruled out, as it hardly works at all.

So, for about 2 months, I have been in hell, have tried many things that I
haven't listed, but did run into this link 2 days ago, which seems to be
what might be my problem(I will post full article below after my
dmesg/pcitable, as the link didnt work for me right now..). So, the
article explains some issues if the BIOS is set to APIC mode. Now, I hope
I have given enough information to see if I can get a consensus from the
list what my problem might be. I doubt it's an issue with any software on
the systems, as we have tried kernels that have been running on hundreds
of other servers for well over a year w/o any issues. I've tried IBM's
recommended setup and had strictly adhered to it on 5 servers, and all 5
of those servers crashed/locked-up(meaning, I had 5 IBM X 330 w/ IBM
supplied Linux distro CD installed and used everything recommended by
them. I even went so far to space these servers about 6 inches from each
other in case it was an issue of air or heat). Basically, I have tried
everything, except for disabling APIC mode in the BIOS(since I just
recently ran into that article). So, I want to know what my next action
should be from all from the list.

I thank you all for any and all help. I also hope all of this had made
sense to the list.

Also, here is a message that at times is in the dmesg(2.2.19-6.2.7smp):

WARNING: MP table in the EBDA can be UNSAFE,
contact linux-smp@vger.kernel.org if you experience SMP problems!

kernels in use:

2.2.14-5.0smp 
2.2.19-6.2.7smp
2.2.19smp


dmesg:

0E000000
.......    : physical APIC id: 0E
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : IO APIC version: 0011
.... register #02: 01000000
.......     : arbitration: 01
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  0    0    0   0   0    1    1    59
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 000 00  0    0    0   0   0    1    1    61
 05 0FF 0F  1    1    0   1   0    1    1    69
 06 000 00  0    0    0   0   0    1    1    71
 07 0FF 0F  1    1    0   1   0    1    1    79
 08 000 00  0    0    0   0   0    1    1    81
 09 000 00  1    0    0   0   0    0    0    00
 0a 000 00  1    0    0   0   0    0    0    00
 0b 000 00  1    0    0   0   0    0    0    00
 0c 000 00  0    0    0   0   0    1    1    89
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  0    0    0   0   0    1    1    91
 0f 000 00  0    0    0   0   0    1    1    99

IO APIC #13......
.... register #00: 0D000000
.......    : physical APIC id: 0D
.... register #01: 000F0011
.......     : max redirection entries: 000F
.......     : IO APIC version: 0011
.... register #02: 0F000000
.......     : arbitration: 0F
.... IRQ redirection table:
 NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
 00 000 00  1    0    0   0   0    0    0    00
 01 000 00  1    0    0   0   0    0    0    00
 02 000 00  1    0    0   0   0    0    0    00
 03 000 00  1    0    0   0   0    0    0    00
 04 0FF 0F  1    1    0   1   0    1    1    A1
 05 000 00  1    0    0   0   0    0    0    00
 06 000 00  1    0    0   0   0    0    0    00
 07 000 00  1    0    0   0   0    0    0    00
 08 000 00  1    0    0   0   0    0    0    00
 09 0FF 0F  1    1    0   1   0    1    1    A9
 0a 000 00  1    0    0   0   0    0    0    00
 0b 0FF 0F  1    1    0   1   0    1    1    B1
 0c 0FF 0F  1    1    0   1   0    1    1    B9
 0d 000 00  1    0    0   0   0    0    0    00
 0e 000 00  1    0    0   0   0    0    0    00
 0f 000 00  1    0    0   0   0    0    0    00
IRQ to pin mappings:
IRQ0 -> 2
IRQ1 -> 1
IRQ4 -> 4
IRQ5 -> 5
IRQ6 -> 6
IRQ7 -> 7
IRQ8 -> 8
IRQ12 -> 12
IRQ13 -> 13
IRQ14 -> 14
IRQ15 -> 15
IRQ20 -> 4
IRQ25 -> 9
IRQ27 -> 11
IRQ28 -> 12
.................................... done.
checking TSC synchronization across CPUs: passed.
PCI: PCI BIOS revision 2.10 entry at 0xfd61c
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: 00:00 [1166/0009]: Scanning peer host bridges
PCI: Scanning ServerWorks HE/LE Peer Bus Bridge 00/00
PCI: 00:01 [1166/0009]: Scanning peer host bridges
PCI: Scanning ServerWorks HE/LE Peer Bus Bridge 00/01
PCI->APIC IRQ transform: (B0,I2,P0) -> 27
PCI->APIC IRQ transform: (B0,I10,P0) -> 25
PCI->APIC IRQ transform: (B0,I15,P0) -> 7
PCI->APIC IRQ transform: (B1,I3,P0) -> 28
PCI->APIC IRQ transform: (B1,I5,P0) -> 20
Linux NET4.0 for Linux 2.2
Based upon Swansea University Computer Society NET3.039
NET4: Unix domain sockets 1.0 for Linux NET4.0.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
TCP: Hash tables configured (ehash 524288 bhash 65536)
IPVS: Connection hash table configured (size=4096, memory=32Kbytes)
Linux IP multicast router 0.06 plus PIM-SM
Initializing RT netlink socket
Starting kswapd v 1.5
Detected PS/2 Mouse Port.
Serial driver version 4.27 with MANY_PORTS MULTIPORT SHARE_IRQ enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
pty: 256 Unix98 ptys configured
Real Time Clock Driver v1.09
RAM disk driver initialized:  16 RAM disks of 4096K size
PCI_IDE: unknown IDE controller on PCI bus 00 device 79, VID=1166,
DID=0211
PCI_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x0700-0x0707, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0x0708-0x070f, BIOS settings: hdc:DMA, hdd:DMA
hda: CRN-8241B, ATAPI CDROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Floppy drive(s): fd0 is 1.44M
FDC 0 is a National Semiconductor PC87306
md driver 0.90.0 MAX_MD_DEVS=256, MAX_REAL=12
raid5: measuring checksumming speed
raid5: MMX detected, trying high-speed MMX checksum routines
   pII_mmx   :  2051.304 MB/sec
   p5_mmx    :  2157.222 MB/sec
   8regs     :  1599.819 MB/sec
   32regs    :   976.884 MB/sec
using fastest function: p5_mmx (2157.222 MB/sec)
scsi : 0 hosts.
scsi : detected total.
md.c: sizeof(mdp_super_t) = 4096
Partition check:
RAMDISK: Compressed image found at block 0
autodetecting RAID arrays
autorun ...
... autorun DONE.
apm: BIOS not found.
VFS: Mounted root (ext2 filesystem).
(scsi0) <Adaptec AIC-7892 Ultra 160/m SCSI host adapter> found at PCI
1/3/0
(scsi0) Wide Channel, SCSI ID=7, 32/255 SCBs
(scsi0) Downloading sequencer code... 396 instructions downloaded
scsi0 : Adaptec AHA274x/284x/294x (EISA/VLB/PCI-Fast SCSI) 5.1.33/3.2.4
       <Adaptec AIC-7892 Ultra 160/m SCSI host adapter>
scsi : 1 host.
scsi1 : IBM PCI ServeRAID 4.20.20
scsi : 2 hosts.
  Vendor:  IBM      Model:  SERVERAID        Rev:  1.0
  Type:   Direct-Access                      ANSI SCSI revision: 01
Detected scsi disk sda at scsi1, channel 0, id 0, lun 0
  Vendor:  IBM      Model:  SERVERAID        Rev:  1.0
  Type:   Processor                          ANSI SCSI revision: 01
  Vendor: IBM       Model: FTlV1 S2          Rev: 0
  Type:   Processor                          ANSI SCSI revision: 02
SCSI device sda: hdwr sector= 512 bytes. Sectors= 71096320 [34715 MB]
[34.7 GB]
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
autodetecting RAID arrays
autorun ...
... autorun DONE.
VFS: Mounted root (ext2 filesystem) readonly.
change_root: old root has d_count=1
Trying to unmount old root ... okay
Freeing unused kernel memory: 84k freed
Adding Swap: 528024k swap-space (priority -1)
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/driv
ers/eepro100.html
eepro100.c: $Revision: 1.20.2.10 $ 2000/05/31 Modified by Andrey
V. Savochkin <s
aw@saw.sw.com.sg> and others
eepro100.c: VA Linux custom, Dragan Stancevic <visitor@valinux.com>
2000/11/15
eth0: Intel PCI EtherExpress Pro100 82557, 00:02:55:54:9C:72, I/O at
0x2200, IRQ
 27.
  Board assembly 754338-001, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
eth1: Intel PCI EtherExpress Pro100 82557, 00:02:55:54:9C:73, I/O at
0x2240, IRQ
 25.
  Board assembly 754338-001, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
Installing knfsd (copyright (C) 1996 okir@monad.swb.de)
Detected scsi generic sg1 at scsi1, channel 0, id 15, lun 0
Detected scsi generic sg2 at scsi1, channel 1, id 8, lun 0
Detected scsi generic sg1 at scsi1, channel 0, id 15, lun 0
Detected scsi generic sg2 at scsi1, channel 1, id 8, lun 0
hda: ATAPI 24X CD-ROM drive, 128kB Cache
Uniform CD-ROM driver Revision: 3.11

lspci -v:

00:00.0 Host bridge: Relience Computer CNB20HE (rev 06)
        Flags: bus master, medium devsel, latency 96

00:00.1 Host bridge: Relience Computer CNB20HE (rev 06)
        Flags: bus master, medium devsel, latency 96

00:01.0 VGA compatible controller: S3 Inc. Savage 4 (rev 04) (prog-if 00
[VGA])
        Subsystem: IBM: Unknown device 7000
        Flags: bus master, medium devsel, latency 248
        Memory at feb80000 (32-bit, non-prefetchable)
        Memory at f0000000 (32-bit, prefetchable)
        Capabilities: [dc] Power Management version 1

00:02.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
(rev 08)
        Subsystem: IBM Netfinity 10/100
        Flags: bus master, medium devsel, latency 100, IRQ 27
        Memory at feb7f000 (32-bit, non-prefetchable)
        I/O ports at 2200
        Memory at fea00000 (32-bit, non-prefetchable)
        Capabilities: [dc] Power Management version 2

00:0a.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
(rev 08)
        Subsystem: IBM Netfinity 10/100
        Flags: bus master, medium devsel, latency 100, IRQ 25
        Memory at feb7e000 (32-bit, non-prefetchable)
        I/O ports at 2240
        Memory at fe900000 (32-bit, non-prefetchable)
        Capabilities: [dc] Power Management version 2

00:0f.0 ISA bridge: Relience Computer: Unknown device 0200 (rev 50)
        Subsystem: Relience Computer: Unknown device 0200
        Flags: bus master, medium devsel, latency 0

00:0f.1 IDE interface: Relience Computer: Unknown device 0211 (prog-if 8a
[Maste
r SecP PriP])
        Flags: bus master, medium devsel, latency 100
        I/O ports at 0700

00:0f.2 USB Controller: Relience Computer: Unknown device 0220 (rev
04) (prog-if
 10 [OHCI])
        Subsystem: Relience Computer: Unknown device 0220
        Flags: bus master, medium devsel, latency 96, IRQ 7
        Memory at feb7d000 (32-bit, non-prefetchable)
01:03.0 SCSI storage controller: Adaptec 7892P (rev 02)
        Subsystem: Adaptec: Unknown device 008f
        Flags: bus master, 66Mhz, medium devsel, latency 100, IRQ 28
        BIST result: 00
        I/O ports at 2300
        Memory at effff000 (64-bit, non-prefetchable)
        Capabilities: [dc] Power Management version 2

01:05.0 RAID bus controller: IBM: Unknown device 01bd
        Subsystem: IBM: Unknown device 020e
        Flags: bus master, 66Mhz, slow devsel, latency 96, IRQ 20
        Memory at edffe000 (32-bit, prefetchable)
        Capabilities: [80] Power Management version 2

/etc/modules.conf:
alias eth0 eepro100
alias eth1 eepro100
alias scsi_hostadapter ips
alias parport_lowlevel parport_pc

uname -a:
Linux host.lan.domain.tld 2.2.19-6.2.7smp #1 SMP Thu Jun 14 07:42:45 EDT
2001 i686 unknown



>From http://www2.linuxjournal.com/articles/style/0013.html

The Inevitable Horror Story

Sadly, life got much less pleasant for quite a while after that. We
started seeing mysterious hangs: the machine would lock up hard and
random intervals, usually during disk I/O operations. This is almost
the worst kind of problem to troubleshoot, as it leaves no clues
other than the bare fact of the machine's catatonia. You get no oops
message, and all the state you might have used to post-mortem
disappears when the machine is reset. The only kind of problem
that's worse is one that adds irreproducibility to the
catatonia. But fortunately, we found that doing make clean or make
world on an X source tree produced the hang pretty reliably.

Approximately thirty hours of troubleshooting (interrupted by far
too little sleep) ensued as Gary and I tried to track down the
problem. We formed and discarded lots of theories based on where we
had not yet seen the hang. For a while we thought the problem only
occurred in console mode, not in X mode. For another while we
thought it happened only under SMP kernels. For a third while we
thought we could avoid it by compiling kernels for the Pentium II
rather than the Athlon. All these beliefs were eventually falsified
amidst much wailing and gnashing of teeth.

Once it became clear that there was a problem at or near the
hardware level, we still had a lot of hypotheses to choose from,
with all of them having pretty unpleasant ramifications for our
chances of qualifying this box before I was supposed to fly
home. Quite possibly the motherboard was bad. Or we might have been
seeing thermal flakeouts due to insufficient cooling of the
motherboard chips or memory.

About eighteen hours in, just before we both crashed in exhaustion,
we posted the problem to the linux-kernel mailing list. We got a
rather larger number of responses than we expected (nearly twenty)
within a few hours. Several were quite helpful. And the breakthrough
came when a couple of linux-kernel people confirmed that the SB
Live! is a frequent source of hangs and lockups on other fast PCI
machines. With a few more hours of testing, (during which our X
source tree probably got cleaned and rebuilt more times than is
allowed by law), we satisfied ourselves that the lockups stop
happening when the SB Live! has been summarily yanked from the
machine.

The most helpful advice we got came from one Daniel T. Chen, who
reported that he had nailed some similar lockups to the SB Live!
running over a Via chipset. They stopped when he upgraded to 2.4.8
and the newest version of the emu10k1 driver. So while Gary took a
much-needed break (and his wife and kids to a David Byrne concert),
I built 2.4.8 (with emu10k1.o hard-compiled in) and ran our torture
test, first with the SB Live! omitted, and then with it in the
machine. No hang. Several more tests seemed to confirm that the
problem had cleared up. Victory!

But as it turned out, the story didn't end there. The 2.4.8+ driver
doesn't completely banish the hangs; early in the morning of the
third day, while I was asleep, Gary tripped over a way to re-induce
them by logging into the machine via ssh while an X build is
running. I didn't yet know this when I next read my mail and saw a
report from Jeffrey Ingber of the linux-kernel list that he had
continued to see emu10k1 lockups after installing 2.4.8, but that
they were banished by the ALSA drivers.

Further testing proved, in fact, that the presence of the SB Live!
in the machine can make it vulnerable to lockups triggered by
network activity even when the emul10k1 support is not configured in
at all! This takes the operating system out of the picture and
suggests a hardware- or BIOS-level problem. Our suspicions were
immediately directed to PCI IRQ sharing, a well-known source of
loss.

Upon investigation, via /proc/pci, we discovered that the IRQ
assignments looked distinctly dubious. IRQs shared between on-board
devices didn't bother us; we presumed the board designers had been
smart enough to avoid conflicts. But IRQs shared between on-board
and daughtercard devices looked like they might be part of the
problem.

The standard way to attack IRQ conflict problems on a PCI machine is
to move the card with the problem to a different slot. We had put
the sound card in slot 4 (second from the bottom) to avoid some
cables. We moved it to slot 5. This changed the board's IRQ but
didn't seem to solve the hang problem.

Unlike some other PCI BIOSes, the S2464's doesn't give you the
capability to wire IRQs to specific card slots. While looking for
this, however, we found a BIOS setting that seemed relevant, "Use
PCI Interrupt Entries In MP Table".  When we switched it to Yes,
rebooted and looked at /proc/pci, the IRQ assignments looked a lot
saner, and when we tested, the ssh hang was gone!

Alan Cox warns that the AMD766 north-bridge chip on this board has a
bug (which I've seen confirmed in AMD's product errata) that could
potentially cause hangs in APIC mode. The workaround for this is to
run the kernel with the noapic command-line option and accept
something of a performance hit, but we won't do that unless we see
further hangs.

Perhaps it's belaboring the obvious, but the way this problem got
resolved was yet another testimony to the power of open-source
development and the community that has evolved around it. Once
again, our technology and our social machine complemented each other
and delivered the goods.


