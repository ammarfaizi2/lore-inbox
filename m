Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287630AbRLaTwt>; Mon, 31 Dec 2001 14:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287632AbRLaTwp>; Mon, 31 Dec 2001 14:52:45 -0500
Received: from riseup.net ([216.162.197.233]:8466 "EHLO riseup.net")
	by vger.kernel.org with ESMTP id <S287626AbRLaTwV>;
	Mon, 31 Dec 2001 14:52:21 -0500
Date: Mon, 31 Dec 2001 11:52:17 -0800
From: Micah Anderson <micah@riseup.net>
To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: 2.2.20 crashing every other day
Message-ID: <20011231115217.P19151@riseup.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recenrtly I've installed a new mailserver for our organization,
primarily serves mailing lists, based on debian potato, kernel 2.2.20,
postfix, software raid 1.

It works great, under heavy and light load, except that every day or
every other day, it hangs. It wasn't doing this when I installed and
burned in the box, and only in the last week or two has it started to
do this. I've been unable to track down what could be causing the
problem. I run a vmstat 5 5 and a ps auxwww every minute to a file,
where I dont see anything strange except for zeroed out data beyond
the end of the file, a block looking like this:

^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@^@

I've had to install the software watchdog in order to keep us up, but
we experience data corruption, loosing a mailing list almost every
time the crash happens. Fortunately we have backups, but once a day
restoring the backups is becoming a very problematic task, especially
for an all volunteer organization.

This is an AMD 800mhz system with 256MB RAM, every partition, except
swap on software RAID1. 

I dont have an oops to run ksymoops on, but here is a bunch of
information I hope provides anyone with clues. I can provide any
additional information on request... your help in solving this is VERY
much appreciated!

On boot, I do: hdparm -q -c3 -m16 -d1 -u1 -A1 -k1 /dev/hda
               hdparm -q -c3 -m16 -d1 -u1 -A1 -k1 /dev/hda

The 2.2.20 kernel was patched with the raid-2.2.20-A0 patch, the
.config file is included below.

x86info -a:

x86info v1.7.  Dave Jones 2001
Feedback to <davej@suse.de>.

Need to be root to use specified options.
Found 1 CPU
eax in: 0x00000000, eax = 00000001 ebx = 68747541 ecx = 444d4163 edx = 69746e65
eax in: 0x00000001, eax = 00000642 ebx = 00000000 ecx = 00000000 edx = 0183f9ff
eax in: 0x80000000, eax = 80000006 ebx = 68747541 ecx = 444d4163 edx = 69746e65
eax in: 0x80000001, eax = 00000742 ebx = 00000000 ecx = 00000000 edx = c1c7f9ff
eax in: 0x80000002, eax = 20444d41 ebx = 6c687441 ecx = 74286e6f edx = 7020296d
eax in: 0x80000003, eax = 65636f72 ebx = 726f7373 ecx = 00000000 edx = 00000000
eax in: 0x80000004, eax = 00000000 ebx = 00000000 ecx = 00000000 edx = 00000000
eax in: 0x80000005, eax = 0408ff08 ebx = ff18ff10 ecx = 40020140 edx = 40020140
eax in: 0x80000006, eax = 00000000 ebx = 41004100 ecx = 01008140 edx = 00000000

Feature flags:
 fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr
Extended feature flags:
 syscall mmxext 3dnowext 3dnow

Family: 6 Model: 4 Stepping: 2 [Thunderbird Rev A4-A8]
Processor name string: AMD Athlon(tm) processor

Instruction TLB: Fully associative. 16 entries.
Data TLB: Fully associative. 24 entries.
L1 Data cache:
	Size: 64Kb	2-way associative. 
	lines per tag=1	line size=64 bytes.
L1 Instruction cache:
	Size: 64Kb	2-way associative. 
	lines per tag=1	line size=64 bytes.
L2 (on CPU) cache:
	Size: 256Kb	8-way associative. 
	lines per tag=1	line size=64 bytes.

900.07 MHz processor (estimate).


cpuinfo:
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 4
model name	: AMD Athlon(tm) processor
stepping	: 2
cpu MHz		: 900.051
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
sep_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 psn mmxext mmx fxsr 3dnowext 3dnow
bogomips	: 1795.68


lspci -vvv

00:00.0 Host bridge: VIA Technologies, Inc.: Unknown device 0305 (rev 03)
	Subsystem: ABIT Computer Corp.: Unknown device a401
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 8 set
	Region 0: Memory at e0000000 (32-bit, prefetchable)
	Capabilities: <available only to root>

00:01.0 PCI bridge: VIA Technologies, Inc.: Unknown device 8305 (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0 set
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: <available only to root>

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super] (rev 40)
	Subsystem: ABIT Computer Corp.: Unknown device 0000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0 set
	Capabilities: <available only to root>

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586 IDE [Apollo] (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc.: Unknown device 0571
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 set
	Region 4: I/O ports at e000
	Capabilities: <available only to root>

00:07.2 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 16) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 set, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at e400
	Capabilities: <available only to root>

00:07.3 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev 16) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 set, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at e800
	Capabilities: <available only to root>

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Subsystem: VIA Technologies, Inc.: Unknown device 3057
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Capabilities: <available only to root>

00:11.0 Ethernet controller: 3Com Corporation 3c900B-TPO [Etherlink XL TPO] (rev 04)
	Subsystem: 3Com Corporation: Unknown device 9004
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 10 min, 48 max, 32 set, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at ec00
	Region 1: Memory at e5000000 (32-bit, non-prefetchable)
	Capabilities: <available only to root>


procinfo:

Linux 2.2.20RAID (root@sarai) (gcc 2.95.2 20000220 ) #2 1CPU [sarai.(none)]

Memory:      Total        Used        Free      Shared     Buffers      Cached
Mem:        257700      143064      114636       45608       50048       67184
Swap:       979944           0      979944

Bootup: Mon Dec 31 12:28:12 2001    Load average: 0.09 0.09 0.11 1/59 2015

user  :       0:07:08.56   6.1%  page in : 11674352  disk 1:   695528r   83867w
nice  :       0:00:00.03   0.0%  page out: 10951156
system:       0:03:44.75   3.2%  swap in :        2  disk 3:    29262r  704372w
idle  :       1:46:22.30  90.7%  swap out:        0
uptime:       1:57:15.63         context :  1875496

irq  0:    703564 timer                 irq 11:    101962 eth0                 
irq  1:         2 keyboard              irq 13:         1 fpu                  
irq  2:         0 cascade [4]           irq 14:   2481192 ide0                 
irq  6:         2                       irq 15:    820282 ide1                 

Kernel Command Line:
  auto BOOT_IMAGE=current ro root=901 BOOT_FILE=/boot/vmlinuz-2.2.20RAID_watch ide0=autotune ide1=autotune hda=autotune hdc=autotune

Modules:


Character Devices:                      Block Devices:
  1 mem               7 vcs               2 fd              
  2 pty              10 misc              3 ide0            
  3 ttyp             36 netlink           9 md              
  4 ttyS            128 ptm              22 ide1            
  5 cua             136 pts                                  

File Systems:
ext2                msdos               [proc]              [nfs]               
iso9660             [autofs]            [devpts]            

dmesg:

rial options enabled
keyboard: Timeout - AT keyboard not present?
keyboard: Timeout - AT keyboard not present?
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
pty: 256 Unix98 ptys configured
Software Watchdog Timer: 0.05, timer margin: 60 sec
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:DMA, hdd:pio
hda: IC35L040AVER07-0, ATA DISK drive
hdc: IC35L040AVER07-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
hda: IC35L040AVER07-0, 39266MB w/1916kB Cache, CHS=5005/255/63
hdc: IC35L040AVER07-0, 39266MB w/1916kB Cache, CHS=5005/255/63
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
md driver 0.90.0 MAX_MD_DEVS=256, MAX_REAL=12
translucent personality registered
linear personality registered
raid0 personality registered
raid1 personality registered
raid5 personality registered
raid5: measuring checksumming speed
raid5: MMX detected, trying high-speed MMX checksum routines
   pII_mmx   :  2090.547 MB/sec
   p5_mmx    :  2618.232 MB/sec
   8regs     :  1205.484 MB/sec
   32regs    :   973.074 MB/sec
using fastest function: p5_mmx (2618.232 MB/sec)
scsi : 0 hosts.
scsi : detected total.
3c59x.c 18Feb01 Donald Becker and others http://www.scyld.com/network/vortex.html
eth0: 3Com 3c900 Cyclone 10Mbps TPO at 0xec00,  00:50:da:29:90:2d, IRQ 11
  8K byte-wide RAM 5:3 Rx:Tx split, autoselect/Autonegotiate interface.
  MII transceiver found at address 24, status 182d.
  Enabling bus-master transmits and whole-frame receives.
md.c: sizeof(mdp_super_t) = 4096
Partition check:
 hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 >
 hdc: hdc1 hdc2 hdc3 hdc4 < hdc5 hdc6 hdc7 hdc8 >
autodetecting RAID arrays
(read) hda3's sb offset: 449728 [events: 0000004a]
(read) hdc3's sb offset: 449728 [events: 0000004a]
autorun ...
considering hdc3 ...
  adding hdc3 ...
  adding hda3 ...
created md1
bind<hda3,1>
bind<hdc3,2>
running: <hdc3><hda3>
now!
hdc3's event counter: 0000004a
hda3's event counter: 0000004a
md: md1: raid array is not clean -- starting background reconstruction
md1: max total readahead window set to 128k
md1: 1 data-disks, max readahead per data-disk: 128k
raid1: device hdc3 operational as mirror 1
raid1: device hda3 operational as mirror 0
raid1: raid set md1 not clean; reconstructing mirrors
raid1: raid set md1 active with 2 out of 2 mirrors
md: updating md1 RAID superblock on device
hdc3 [events: 0000004b](write) hdc3's sb offset: 449728
md: syncing RAID array md1
md: minimum _guaranteed_ reconstruction speed: 100 KB/sec.
md: using maximum available idle IO bandwith for reconstruction.
md: using 128k window.
hda3 [events: 0000004b](write) hda3's sb offset: 449728
.
... autorun DONE.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 64k freed
(read) hda1's sb offset: 15936 [events: 00000040]
(read) hdc1's sb offset: 15936 [events: 00000040]
autorun ...
considering hdc1 ...
  adding hdc1 ...
  adding hda1 ...
created md0
bind<hda1,1>
bind<hdc1,2>
running: <hdc1><hda1>
now!
hdc1's event counter: 00000040
hda1's event counter: 00000040
md: md0: raid array is not clean -- starting background reconstruction
md0: max total readahead window set to 128k
md0: 1 data-disks, max readahead per data-disk: 128k
raid1: device hdc1 operational as mirror 1
raid1: device hda1 operational as mirror 0
raid1: raid set md0 not clean; reconstructing mirrors
raid1: raid set md0 active with 2 out of 2 mirrors
md: updating md0 RAID superblock on device
hdc1 [events: 00000041](write) hdc1's sb offset: 15936
md: serializing resync, md0 has overlapping physical units with md1!
hda1 [events: 00000041](write) hda1's sb offset: 15936
.
... autorun DONE.
(read) hda5's sb offset: 5855552 [events: 0000004c]
(read) hdc5's sb offset: 5855552 [events: 0000004c]
autorun ...
considering hdc5 ...
  adding hdc5 ...
  adding hda5 ...
created md2
bind<hda5,1>
bind<hdc5,2>
running: <hdc5><hda5>
now!
hdc5's event counter: 0000004c
hda5's event counter: 0000004c
md: md2: raid array is not clean -- starting background reconstruction
md2: max total readahead window set to 128k
md2: 1 data-disks, max readahead per data-disk: 128k
raid1: device hdc5 operational as mirror 1
raid1: device hda5 operational as mirror 0
raid1: raid set md2 not clean; reconstructing mirrors
raid1: raid set md2 active with 2 out of 2 mirrors
md: updating md2 RAID superblock on device
hdc5 [events: 0000004d](write) hdc5's sb offset: 5855552
md: serializing resync, md2 has overlapping physical units with md1!
hda5 [events: 0000004d](write) hda5's sb offset: 5855552
.
... autorun DONE.
(read) hda6's sb offset: 489856 [events: 0000004e]
(read) hdc6's sb offset: 489856 [events: 0000004e]
autorun ...
considering hdc6 ...
  adding hdc6 ...
  adding hda6 ...
created md3
bind<hda6,1>
bind<hdc6,2>
running: <hdc6><hda6>
now!
hdc6's event counter: 0000004e
hda6's event counter: 0000004e
md: md3: raid array is not clean -- starting background reconstruction
md3: max total readahead window set to 128k
md3: 1 data-disks, max readahead per data-disk: 128k
raid1: device hdc6 operational as mirror 1
raid1: device hda6 operational as mirror 0
raid1: raid set md3 not clean; reconstructing mirrors
raid1: raid set md3 active with 2 out of 2 mirrors
md: updating md3 RAID superblock on device
hdc6 [events: 0000004f](write) hdc6's sb offset: 489856
md: serializing resync, md3 has overlapping physical units with md1!
hda6 [events: 0000004f](write) hda6's sb offset: 489856
.
... autorun DONE.
(read) hda7's sb offset: 96256 [events: 00000050]
(read) hdc7's sb offset: 96256 [events: 00000050]
autorun ...
considering hdc7 ...
  adding hdc7 ...
  adding hda7 ...
created md4
bind<hda7,1>
bind<hdc7,2>
running: <hdc7><hda7>
now!
hdc7's event counter: 00000050
hda7's event counter: 00000050
md: md4: raid array is not clean -- starting background reconstruction
md4: max total readahead window set to 128k
md4: 1 data-disks, max readahead per data-disk: 128k
raid1: device hdc7 operational as mirror 1
raid1: device hda7 operational as mirror 0
raid1: raid set md4 not clean; reconstructing mirrors
raid1: raid set md4 active with 2 out of 2 mirrors
md: updating md4 RAID superblock on device
hdc7 [events: 00000051](write) hdc7's sb offset: 96256
md: serializing resync, md4 has overlapping physical units with md1!
hda7 [events: 00000051](write) hda7's sb offset: 96256
.
... autorun DONE.
(read) hda8's sb offset: 32804608 [events: 0000004c]
(read) hdc8's sb offset: 32804608 [events: 0000004c]
autorun ...
considering hdc8 ...
  adding hdc8 ...
  adding hda8 ...
created md5
bind<hda8,1>
bind<hdc8,2>
running: <hdc8><hda8>
now!
hdc8's event counter: 0000004c
hda8's event counter: 0000004c
md: md5: raid array is not clean -- starting background reconstruction
md5: max total readahead window set to 128k
md5: 1 data-disks, max readahead per data-disk: 128k
raid1: device hdc8 operational as mirror 1
raid1: device hda8 operational as mirror 0
raid1: raid set md5 not clean; reconstructing mirrors
raid1: raid set md5 active with 2 out of 2 mirrors
md: updating md5 RAID superblock on device
hdc8 [events: 0000004d](write) hdc8's sb offset: 32804608
md: serializing resync, md5 has overlapping physical units with md1!
hda8 [events: 0000004d](write) hda8's sb offset: 32804608
.
... autorun DONE.
eth0: Initial media type Autonegotiate.
eth0: MII #24 status 182d, link partner capability 41e1, setting full-duplex.

fdisk -l:

Disk /dev/hda: 255 heads, 63 sectors, 5005 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hda1   *         1         2     16033+  83  Linux
/dev/hda2          4945      5005    489982+  82  Linux swap
/dev/hda3             3        58    449820   fd  Linux raid autodetect
/dev/hda4            59      4944  39246795    5  Extended
/dev/hda5            59       787   5855661   83  Linux
/dev/hda6           788       848    489951   83  Linux
/dev/hda7           849       860     96358+  83  Linux
/dev/hda8           861      4944  32804698+  83  Linux

Disk /dev/hdc: 255 heads, 63 sectors, 5005 cylinders
Units = cylinders of 16065 * 512 bytes

   Device Boot    Start       End    Blocks   Id  System
/dev/hdc1   *         1         2     16033+  83  Linux
/dev/hdc2             3        63    489982+  82  Linux swap
/dev/hdc3            64       119    449820   fd  Linux raid autodetect
/dev/hdc4           120      5005  39246795    5  Extended
/dev/hdc5           120       848   5855661   83  Linux
/dev/hdc6           849       909    489951   83  Linux
/dev/hdc7           910       921     96358+  83  Linux
/dev/hdc8           922      5005  32804698+  83  Linux


df -h:

Filesystem            Size  Used Avail Use% Mounted on
/dev/md1              425M  282M  122M  70% /
/dev/md0               15M  4.0M   10M  28% /boot
/dev/md2              5.5G  845M  4.4G  16% /usr
/dev/md4               91M   13k   86M   0% /tmp
/dev/md3              463M   27M  412M   6% /home
/dev/md5               31G   10G   19G  36% /var

/etc/raidtab:

#
# persistent RAID1 array with 1 spare disk.
#
raiddev /dev/md0
    raid-level                1
    nr-raid-disks             2
    nr-spare-disks            0
    persistent-superblock     1
    chunk-size                4

    device                    /dev/hda1
    raid-disk                 0
    device                    /dev/hdc1
    raid-disk                 1

raiddev /dev/md1
    raid-level                1
    nr-raid-disks             2
    nr-spare-disks            0
    persistent-superblock     1
    chunk-size                4

    device                    /dev/hda3
    raid-disk                 0
    device                    /dev/hdc3
    raid-disk                 1

raiddev /dev/md2
    raid-level                1
    nr-raid-disks             2
    nr-spare-disks            0
    persistent-superblock     1
    chunk-size                4

    device                    /dev/hda5
    raid-disk                 0
    device                    /dev/hdc5
    raid-disk                 1

raiddev /dev/md3
    raid-level                1
    nr-raid-disks             2
    nr-spare-disks            0
    persistent-superblock     1
    chunk-size                4

    device                    /dev/hda6
    raid-disk                 0
    device                    /dev/hdc6
    raid-disk                 1

raiddev /dev/md4
    raid-level                1
    nr-raid-disks             2
    nr-spare-disks            0
    persistent-superblock     1
    chunk-size                4

    device                    /dev/hda7
    raid-disk                 0
    device                    /dev/hdc7
    raid-disk                 1

raiddev /dev/md5
    raid-level                1
    nr-raid-disks             2
    nr-spare-disks            0
    persistent-superblock     1
    chunk-size                4

    device                    /dev/hda8
    raid-disk                 0
    device                    /dev/hdc8
    raid-disk                 1

And finally, /usr/src/linux/.config:

#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
CONFIG_M686=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
CONFIG_X86_CPUID=y
CONFIG_1GB=y
# CONFIG_2GB is not set
# CONFIG_MATH_EMULATION is not set
# CONFIG_MTRR is not set
# CONFIG_SMP is not set

#
# Loadable module support
#
CONFIG_MODULES=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# General setup
#
CONFIG_NET=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_OPTIMIZE is not set
CONFIG_PCI_OLD_PROC=y
# CONFIG_MCA is not set
# CONFIG_VISWS is not set
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_BINFMT_AOUT=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=y
# CONFIG_BINFMT_JAVA is not set
# CONFIG_PARPORT is not set
# CONFIG_APM is not set
# CONFIG_TOSHIBA is not set

#
# Plug and Play support
#
# CONFIG_PNP is not set

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
# CONFIG_BLK_DEV_IDESCSI is not set
CONFIG_BLK_DEV_CMD640=y
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
CONFIG_BLK_DEV_RZ1000=y
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_BLK_DEV_OFFBOARD is not set
CONFIG_IDEDMA_AUTO=y
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_BLK_DEV_TRM290 is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_VIA82C586 is not set
# CONFIG_BLK_DEV_CMD646 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_IDE_CHIPSETS is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_MD=y
CONFIG_AUTODETECT_RAID=y
CONFIG_MD_LINEAR=y
CONFIG_MD_STRIPED=y
CONFIG_MD_MIRRORING=y
CONFIG_MD_RAID5=y
CONFIG_MD_TRANSLUCENT=y
# CONFIG_MD_HSM is not set
CONFIG_MD_BOOT=y
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_XD is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_PARIDE_PARPORT=y
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_HD is not set

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_NETLINK=y
CONFIG_RTNETLINK=y
CONFIG_NETLINK_DEV=y
CONFIG_FIREWALL=y
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
CONFIG_IP_FIREWALL=y
# CONFIG_IP_FIREWALL_NETLINK is not set
# CONFIG_IP_TRANSPARENT_PROXY is not set
# CONFIG_IP_MASQUERADE is not set
# CONFIG_IP_ROUTER is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
CONFIG_IP_ALIAS=y
# CONFIG_ARPD is not set
CONFIG_SYN_COOKIES=y
# CONFIG_INET_RARP is not set
CONFIG_SKB_LARGE=y
# CONFIG_IPV6 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_BRIDGE is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_LLC is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set
# CONFIG_CPU_IS_SLOW is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set

#
# SCSI support
#
CONFIG_SCSI=y
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
# CONFIG_CHR_DEV_SG is not set
CONFIG_SCSI_MULTI_LUN=y
CONFIG_SCSI_CONSTANTS=y
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_7000FASST is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AHA152X is not set
# CONFIG_SCSI_AHA1542 is not set
# CONFIG_SCSI_AHA1740 is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_NCR53C8XX is not set
CONFIG_SCSI_SYM53C8XX=y
CONFIG_SCSI_NCR53C8XX_DEFAULT_TAGS=4
CONFIG_SCSI_NCR53C8XX_MAX_TAGS=32
CONFIG_SCSI_NCR53C8XX_SYNC=20
# CONFIG_SCSI_NCR53C8XX_IOMAPPED is not set
# CONFIG_SCSI_NCR53C8XX_PQS_PDS is not set
# CONFIG_SCSI_NCR53C8XX_SYMBIOS_COMPAT is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_DEBUG is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_SCSI is not set

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#
# CONFIG_ARCNET is not set
CONFIG_DUMMY=m
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL1 is not set
# CONFIG_EL2 is not set
# CONFIG_ELPLUS is not set
# CONFIG_EL16 is not set
# CONFIG_EL3 is not set
# CONFIG_3C515 is not set
CONFIG_VORTEX=y
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_RTL8139 is not set
# CONFIG_RTL8139TOO is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_EISA=y
# CONFIG_PCNET32 is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_LP486E is not set
# CONFIG_CS89x0 is not set
# CONFIG_DM9102 is not set
# CONFIG_DE4X5 is not set
# CONFIG_DEC_ELCP is not set
# CONFIG_DEC_ELCP_OLD is not set
# CONFIG_DGRS is not set
CONFIG_EEXPRESS_PRO100=y
# CONFIG_LNE390 is not set
# CONFIG_NE3210 is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_SIS900 is not set
# CONFIG_ES3210 is not set
# CONFIG_EPIC100 is not set
# CONFIG_ZNET is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_NET_RADIO is not set

#
# Token ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
CONFIG_SHAPER=m

#
# Wan interfaces
#
# CONFIG_HOSTESS_SV11 is not set
# CONFIG_COSA is not set
# CONFIG_SEALEVEL_4021 is not set
# CONFIG_SYNCLINK_SYNCPPP is not set
# CONFIG_LANMEDIA is not set
# CONFIG_COMX is not set
# CONFIG_HDLC is not set
# CONFIG_DLCI is not set
# CONFIG_XPEED is not set
# CONFIG_SBNI is not set

#
# Amateur Radio support
#
# CONFIG_HAMRADIO is not set

#
# IrDA (infrared) support
#
# CONFIG_IRDA is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Old CD-ROM drivers (not SCSI, not IDE)
#
# CONFIG_CD_NO_IDESCSI is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
# CONFIG_SERIAL_CONSOLE is not set
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_MOUSE=y

#
# Mice
#
# CONFIG_ATIXL_BUSMOUSE is not set
# CONFIG_BUSMOUSE is not set
# CONFIG_MS_BUSMOUSE is not set
CONFIG_PSMOUSE=y
CONFIG_82C710_MOUSE=y
# CONFIG_PC110_PAD is not set

#
# Joysticks
#
# CONFIG_JOYSTICK is not set
# CONFIG_QIC02_TAPE is not set
CONFIG_WATCHDOG=y

#
# Watchdog Cards
#
# CONFIG_WATCHDOG_NOWAYOUT is not set
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_PCWATCHDOG is not set
# CONFIG_I810_TCO is not set
# CONFIG_MIXCOMWD is not set
# CONFIG_60XX_WDT is not set
CONFIG_SOFT_WATCHDOG=y
# CONFIG_WDT is not set
# CONFIG_WDTPCI is not set
# CONFIG_MACHZ_WDT is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set

#
# Video For Linux
#
# CONFIG_VIDEO_DEV is not set
# CONFIG_DTLK is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Filesystems
#
# CONFIG_QUOTA is not set
CONFIG_AUTOFS_FS=y
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
# CONFIG_UMSDOS_FS is not set
# CONFIG_VFAT_FS is not set
CONFIG_ISO9660_FS=y
# CONFIG_JOLIET is not set
# CONFIG_MINIX_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
# CONFIG_EFS_FS is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
CONFIG_NFS_FS=y
# CONFIG_NFS_V3 is not set
# CONFIG_NFSD is not set
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set

#
# Partition Types
#
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MAC_PARTITION is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SMD_DISKLABEL is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="cp437"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_ISO8859_1 is not set
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_RU is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VIDEO_SELECT is not set
# CONFIG_MDA_CONSOLE is not set
# CONFIG_FB is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# Kernel hacking
#
CONFIG_MAGIC_SYSRQ=y
