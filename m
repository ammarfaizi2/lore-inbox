Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287979AbSAPWwe>; Wed, 16 Jan 2002 17:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286322AbSAPWwX>; Wed, 16 Jan 2002 17:52:23 -0500
Received: from dialin-145-254-143-113.arcor-ip.net ([145.254.143.113]:4100
	"EHLO picklock.adams.family") by vger.kernel.org with ESMTP
	id <S281787AbSAPWv6> convert rfc822-to-8bit; Wed, 16 Jan 2002 17:51:58 -0500
Message-ID: <3C4603AF.F64F50EA@loewe-komp.de>
Date: Wed, 16 Jan 2002 23:50:23 +0100
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: B16
X-Mailer: Mozilla 4.78 [de] (X11; U; Linux 2.4.17-xfs i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Oopses in scheduler on Linux-2.4.17-xfs
In-Reply-To: <3C44B260.D1FA47BF@loewe-komp.de> <3C44B40E.FEDE24C8@zip.com.au>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton schrieb:
> 
> Peter Wächtler wrote:
> >
> > I recently get oopses on 2.4.14-xfs and 2.4.17-xfs.
> > box is SMP with old Pentium Pro
> 
> Could I please have a description of your hardware?  lspci output,
> lsmod, .config?
> 

Here infos about the machine.
It's using one IDE Disk but has an Adaptec 2940 SCSI adapter
with CDROM and DAT. First I thought the nightly cron (updatedb)
was causing the crashes - but the last one was at midday.
The machine runs 24x7 (despite the crashes:), running 2 seti@home
+ 1 john. It had an update in between the crashes of 9 days.

Can you give me a hint for what to look, I'm completely clueless.
(hoehoe: bad mem?)

When in X11 (DRI enabled):
picklock:~ # cat /proc/mtrr
reg00: base=0x00000000 (   0MB), size= 256MB: write-back, count=1
reg01: base=0xe2000000 (3616MB), size=  32MB: write-combining, count=2

picklock:~ # cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c87ff : Extension ROM
000f0000-000fffff : System ROM
00100000-0fffffff : System RAM
  00100000-00202e4b : Kernel code
  00202e4c-002d408b : Kernel data
e0000000-e1ffffff : 3Dfx Interactive, Inc. Voodoo 3
e2000000-e3ffffff : 3Dfx Interactive, Inc. Voodoo 3
e4000000-e4000fff : Adaptec AHA-294x / AIC-7871
e4001000-e40010ff : Davicom Semiconductor, Inc. Ethernet 100/10 MBit
  e4001000-e40010ff : dmfe
e4002000-e4002fff : Brooktree Corporation Bt848 TV with DMA push
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved


processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 1
model name      : Pentium Pro
stepping        : 7
cpu MHz         : 233.868
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
bogomips        : 465.30

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 1
model name      : Pentium Pro
stepping        : 9
cpu MHz         : 233.868
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
bogomips        : 466.94


Inspecting /boot/System.map-2.4.17-xfs
Loaded 14809 symbols from /boot/System.map-2.4.17-xfs.
Symbols match kernel version 2.4.17.
Loaded 5 symbols from 1 module.
klogd 1.4.1, log source = ksyslog started.
<4>Linux version 2.4.17-xfs (peewee@picklock) (gcc version 2.95.3 20010315 (SuSE)) #1 SMP Son Dez 23 22:37:36 CET 2001
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
<4> BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
<4> BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 0000000010000000 (usable)
<4> BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
<4> BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
<4> BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
<4>found SMP MP-table at 000f5920
<4>hm, page 000f5000 reserved twice.
<4>hm, page 000f6000 reserved twice.
<4>hm, page 000f1000 reserved twice.
<4>hm, page 000f2000 reserved twice.
<4>On node 0 totalpages: 65536
<4>zone(0): 4096 pages.
<4>zone(1): 61440 pages.
<4>zone(2): 0 pages.
<4>Intel MultiProcessor Specification v1.1
<4>    Virtual Wire compatibility mode.
<4>OEM ID: OEM00000 Product ID: PROD00000000 APIC at: 0xFEE00000
<4>Processor #0 Pentium(tm) Pro APIC version 17
<4>Processor #1 Pentium(tm) Pro APIC version 17
<4>I/O APIC #2 Version 17 at 0xFEC00000.
<4>Processors: 2
<4>Kernel command line: auto BOOT_IMAGE=linux2417xfs ro root=309 BOOT_FILE=/boot/vmlinuz-2.4.17-xfs console=ttyS0,19200 console=tty1
<6>Initializing CPU#0
<4>Detected 233.868 MHz processor.
<4>Console: colour VGA+ 80x25
<4>Calibrating delay loop... 465.30 BogoMIPS
<4>Memory: 255128k/262144k available (1035k kernel code, 6628k reserved, 836k data, 220k init, 0k highmem)
<4>kdb version 1.9 by Scott Lurndal, Keith Owens. Copyright SGI, All Rights Reserved
<4>Dentry-cache hash table entries: 32768 (order: 6, 262144 bytes)
<4>Inode-cache hash table entries: 16384 (order: 5, 131072 bytes)
<4>Mount-cache hash table entries: 4096 (order: 3, 32768 bytes)
<4>Buffer-cache hash table entries: 16384 (order: 4, 65536 bytes)
<4>Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
<7>CPU: Before vendor init, caps: 0000fbff 00000000 00000000, vendor = 0
<6>CPU: L1 I cache: 8K, L1 D cache: 8K
<6>CPU: L2 cache: 256K
<7>CPU: After vendor init, caps: 0000fbff 00000000 00000000 00000000
<6>Intel machine check architecture supported.
<6>Intel machine check reporting enabled on CPU#0.
<7>CPU:     After generic, caps: 0000fbff 00000000 00000000 00000000
<7>CPU:             Common caps: 0000fbff 00000000 00000000 00000000
<6>Checking 'hlt' instruction... OK.
<4>POSIX conformance testing by UNIFIX
<4>mtrr: v1.40 (20010327) Richard Gooch (rgooch@atnf.csiro.au)
<4>mtrr: detected mtrr type: Intel
<7>CPU: Before vendor init, caps: 0000fbff 00000000 00000000, vendor = 0
<6>CPU: L1 I cache: 8K, L1 D cache: 8K
<6>CPU: L2 cache: 256K
<7>CPU: After vendor init, caps: 0000fbff 00000000 00000000 00000000
<6>Intel machine check reporting enabled on CPU#0.
<7>CPU:     After generic, caps: 0000fbff 00000000 00000000 00000000
<7>CPU:             Common caps: 0000fbff 00000000 00000000 00000000
<4>CPU0: Intel Pentium Pro stepping 07
<4>per-CPU timeslice cutoff: 732.90 usecs.
<4>enabled ExtINT on CPU#0
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>Booting processor 1/1 eip 2000
<6>Initializing CPU#1
<4>masked ExtINT on CPU#1
<4>ESR value before enabling vector: 00000000
<4>ESR value after enabling vector: 00000000
<4>Calibrating delay loop... 466.94 BogoMIPS
<7>CPU: Before vendor init, caps: 0000fbff 00000000 00000000, vendor = 0
<6>CPU: L1 I cache: 8K, L1 D cache: 8K
<6>CPU: L2 cache: 256K
<7>CPU: After vendor init, caps: 0000fbff 00000000 00000000 00000000
<6>Intel machine check reporting enabled on CPU#1.
<7>CPU:     After generic, caps: 0000fbff 00000000 00000000 00000000
<7>CPU:             Common caps: 0000fbff 00000000 00000000 00000000
<4>CPU1: Intel Pentium Pro stepping 09
<6>Total of 2 processors activated (932.24 BogoMIPS).
<4>ENABLING IO-APIC IRQs
<4>Setting 2 in the phys_id_present_map
<6>...changing IO-APIC physical APIC ID to 2 ... ok.
<7>init IO_APIC IRQs
<7> IO-APIC (apicid-pin) 2-0, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
<6>..TIMER: vector=0x31 pin1=2 pin2=0
<7>number of MP IRQ sources: 21.
<7>number of IO-APIC #2 registers: 24.
<6>testing the IO APIC.......................
<4>
<7>IO APIC #2......
<7>.... register #00: 02000000
<7>.......    : physical APIC id: 02
<7>.... register #01: 00170011
<7>.......     : max redirection entries: 0017
<7>.......     : PRQ implemented: 0
<7>.......     : IO APIC version: 0011
<7>.... register #02: 00000000
<7>.......     : arbitration: 00
<7>.... IRQ redirection table:
<7> NR Log Phy Mask Trig IRR Pol Stat Dest Deli Vect:
<7> 00 000 00  1    0    0   0   0    0    0    00
<7> 01 003 03  0    0    0   0   0    1    1    39
<7> 02 003 03  0    0    0   0   0    1    1    31
<7> 03 003 03  0    0    0   0   0    1    1    41
<7> 04 003 03  0    0    0   0   0    1    1    49
<7> 05 003 03  0    0    0   0   0    1    1    51
<7> 06 003 03  0    0    0   0   0    1    1    59
<7> 07 003 03  0    0    0   0   0    1    1    61
<7> 08 003 03  0    0    0   0   0    1    1    69
<7> 09 003 03  0    0    0   0   0    1    1    71
<7> 0a 003 03  0    0    0   0   0    1    1    79
<7> 0b 003 03  0    0    0   0   0    1    1    81
<7> 0c 003 03  0    0    0   0   0    1    1    89
<7> 0d 003 03  0    0    0   0   0    1    1    91
<7> 0e 003 03  0    0    0   0   0    1    1    99
<7> 0f 003 03  0    0    0   0   0    1    1    A1
<7> 10 003 03  1    1    0   1   0    1    1    A9
<7> 11 003 03  1    1    0   1   0    1    1    B1
<7> 12 003 03  1    1    0   1   0    1    1    B9
<7> 13 000 00  1    0    0   0   0    0    0    00
<7> 14 000 00  1    0    0   0   0    0    0    00
<7> 15 000 00  1    0    0   0   0    0    0    00
<7> 16 000 00  1    0    0   0   0    0    0    00
<7> 17 000 00  1    0    0   0   0    0    0    00
<7>IRQ to pin mappings:
<7>IRQ0 -> 0:2
<7>IRQ1 -> 0:1
<7>IRQ3 -> 0:3
<7>IRQ4 -> 0:4
<7>IRQ5 -> 0:5
<7>IRQ6 -> 0:6
<7>IRQ7 -> 0:7
<7>IRQ8 -> 0:8
<7>IRQ9 -> 0:9
<7>IRQ10 -> 0:10
<7>IRQ11 -> 0:11
<7>IRQ12 -> 0:12
<7>IRQ13 -> 0:13
<7>IRQ14 -> 0:14
<7>IRQ15 -> 0:15
<7>IRQ16 -> 0:16
<7>IRQ17 -> 0:17
<7>IRQ18 -> 0:18
<6>.................................... done.
<4>Using local APIC timer interrupts.
<4>calibrating APIC timer ...
<4>..... CPU clock speed is 233.8798 MHz.
<4>..... host bus clock speed is 66.8225 MHz.
<4>cpu: 0, clocks: 668225, slice: 222741
<4>CPU0<T0:668224,T1:445472,D:11,S:222741,C:668225>
<4>cpu: 1, clocks: 668225, slice: 222741
<4>CPU1<T0:668224,T1:222736,D:6,S:222741,C:668225>
<4>checking TSC synchronization across CPUs: passed.
<4>Waiting on wait_init_idle (map = 0x2)
<4>All processors have done init_idle
<4>PCI: PCI BIOS revision 2.10 entry at 0xfb2c0, last bus=0
<4>PCI: Using configuration type 1
<4>PCI: Probing PCI hardware
<6>PCI: Using IRQ router PIIX [8086/7000] at 00:07.0
<6>PCI->APIC IRQ transform: (B0,I8,P0) -> 16
<6>PCI->APIC IRQ transform: (B0,I9,P0) -> 17
<6>PCI->APIC IRQ transform: (B0,I10,P0) -> 18
<6>PCI->APIC IRQ transform: (B0,I11,P0) -> 18
<6>Limiting direct PCI/PCI transfers.
<6>Activating ISA DMA hang workarounds.
<6>isapnp: Scanning for PnP cards...
<7>isapnp: Calling quirk for 01:00
<6>isapnp: SB audio device quirk - increasing port range
<7>isapnp: Calling quirk for 01:02
<6>isapnp: AWE32 quirk - adding two ports
<6>isapnp: Card 'Creative SB32 PnP'
<6>isapnp: 1 Plug & Play card detected total
<6>Linux NET4.0 for Linux 2.4
<6>Based upon Swansea University Computer Society NET3.039
<4>Initializing RT netlink socket
<4>Starting kswapd
<5>VFS: Diskquotas version dquot_6.4.0 initialized
<4>pty: 256 Unix98 ptys configured
<6>Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI ISAPNP enabled
<6>ttyS00 at 0x03f8 (irq = 4) is a 16550A
<6>ttyS01 at 0x02f8 (irq = 3) is a 16550A
<4>block: 128 slots per queue, batch=32
<6>Uniform Multi-Platform E-IDE driver Revision: 6.31
<4>ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
<4>PIIX3: IDE controller on PCI bus 00 dev 39
<4>PIIX3: chipset revision 0
<4>PIIX3: not 100%% native mode: will probe irqs later
<4>    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
<4>hda: IBM-DJNA-352030, ATA DISK drive
<4>hdb: IOMEGA ZIP 100 ATAPI Floppy, ATAPI FLOPPY drive
<4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
<6>hda: 39876480 sectors (20417 MB) w/1966KiB Cache, CHS=2482/255/63
<6>Partition check:
<6> hda: hda1 hda2 hda3 hda4 < hda5 hda6 hda7 hda8 hda9 hda10 hda11 >
<6>Floppy drive(s): fd0 is 1.44M
<6>FDC 0 is a post-1991 82077
<6>Linux agpgart interface v0.99 (c) Jeff Hartmann
<6>agpgart: Maximum main memory to use for agp memory: 204M
<7>agpgart: no supported devices found.
<6>[drm] Initialized tdfx 1.0.0 20010216 on minor 0
<6>LVM version 1.0.1-rc4(ish)(03/10/2001)
<6>NET4: Linux TCP/IP 1.0 for NET4.0
<6>IP Protocols: ICMP, UDP, TCP, IGMP
<4>IP: routing cache hash table of 2048 buckets, 16Kbytes
<4>TCP: Hash tables configured (established 16384 bind 16384)
<6>Linux IP multicast router 0.06 plus PIM-SM
<6>NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
<4>VFS: Mounted root (ext2 filesystem) readonly.
<4>Freeing unused kernel memory: 220k freed
<4>EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
<4>invalidate: busy buffer
<4>invalidate: busy buffer
<4>invalidate: busy buffer
<4>invalidate: busy buffer
<4>invalidate: busy buffer
<4>invalidate: busy buffer
<6>Adding Swap: 265032k swap-space (priority -1)
<4>reiserfs: checking transaction log (device 3a:00) ...
<4>reiserfs: replayed 24 transactions in 4 seconds
<4>Using tea hash to sort names
<4>reiserfs: using 3.5.x disk format
<4>ReiserFS version 3.6.25
<4>reiserfs: checking transaction log (device 3a:01) ...
<4>reiserfs: replayed 2 transactions in 4 seconds
<4>Using r5 hash to sort names
<4>reiserfs: using 3.5.x disk format
<4>ReiserFS version 3.6.25
Kernel logging (ksyslog) stopped.
Kernel log daemon terminating.


#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y
CONFIG_ISA=y
# CONFIG_SBUS is not set
CONFIG_UID16=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Loadable module support
#
CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

#
# Processor type and features
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
# CONFIG_M586TSC is not set
# CONFIG_M586MMX is not set
CONFIG_M686=y
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_PPRO_FENCE=y
# CONFIG_TOSHIBA is not set
# CONFIG_I8K is not set
# CONFIG_MICROCODE is not set
# CONFIG_X86_MSR is not set
CONFIG_X86_CPUID=m
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set
# CONFIG_MATH_EMULATION is not set
CONFIG_MTRR=y
CONFIG_SMP=y
# CONFIG_MULTIQUAD is not set
CONFIG_HAVE_DEC_LOCK=y

#
# General setup
#
CONFIG_NET=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
# CONFIG_PCI_GOBIOS is not set
# CONFIG_PCI_GODIRECT is not set
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
# CONFIG_EISA is not set
# CONFIG_MCA is not set
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=m
CONFIG_CARDBUS=y
# CONFIG_I82092 is not set
CONFIG_I82365=y
# CONFIG_TCIC is not set

#
# PCI Hotplug Support
#
# CONFIG_HOTPLUG_PCI is not set
# CONFIG_HOTPLUG_PCI_COMPAQ is not set
# CONFIG_HOTPLUG_PCI_COMPAQ_NVRAM is not set
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
# CONFIG_PM is not set
# CONFIG_ACPI is not set
# CONFIG_APM is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
# CONFIG_PARPORT_SERIAL is not set
# CONFIG_PARPORT_PC_FIFO is not set
# CONFIG_PARPORT_PC_SUPERIO is not set
# CONFIG_PARPORT_PC_PCMCIA is not set
# CONFIG_PARPORT_AMIGA is not set
# CONFIG_PARPORT_MFC3 is not set
# CONFIG_PARPORT_ATARI is not set
# CONFIG_PARPORT_GSC is not set
# CONFIG_PARPORT_SUNBPP is not set
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Plug and Play configuration
#
CONFIG_PNP=y
CONFIG_ISAPNP=y

#
# Block devices
#
CONFIG_BLK_DEV_FD=y
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_BLK_DEV_LOOP=m
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set

#
# Multi-device support (RAID and LVM)
#
CONFIG_MD=y
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_MD_MULTIPATH is not set
CONFIG_BLK_DEV_LVM=y

#
# Networking options
#
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=m
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
CONFIG_FILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
# CONFIG_NET_IPGRE is not set
CONFIG_IP_MROUTE=y
# CONFIG_IP_PIMSM_V1 is not set
# CONFIG_IP_PIMSM_V2 is not set
# CONFIG_ARPD is not set
CONFIG_INET_ECN=y
CONFIG_SYN_COOKIES=y

#
#   IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_QUEUE=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_LIMIT=m
CONFIG_IP_NF_MATCH_MAC=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_TOS=m
CONFIG_IP_NF_MATCH_LENGTH=m
CONFIG_IP_NF_MATCH_TTL=m
CONFIG_IP_NF_MATCH_TCPMSS=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_UNCLEAN=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_MIRROR=m
CONFIG_IP_NF_NAT=m
CONFIG_IP_NF_NAT_NEEDED=y
CONFIG_IP_NF_TARGET_MASQUERADE=m
CONFIG_IP_NF_TARGET_REDIRECT=m
CONFIG_IP_NF_NAT_SNMP_BASIC=m
CONFIG_IP_NF_NAT_IRC=m
CONFIG_IP_NF_NAT_FTP=m
CONFIG_IP_NF_MANGLE=m
CONFIG_IP_NF_TARGET_TOS=m
CONFIG_IP_NF_TARGET_MARK=m
CONFIG_IP_NF_TARGET_LOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set
# CONFIG_IP_NF_COMPAT_IPFWADM is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
CONFIG_VLAN_8021Q=m
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
CONFIG_BRIDGE=m
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set
# CONFIG_PHONE_IXJ is not set
# CONFIG_PHONE_IXJ_PCMCIA is not set

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
# CONFIG_BLK_DEV_HD_IDE is not set
# CONFIG_BLK_DEV_HD is not set
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
# CONFIG_BLK_DEV_IDEDISK_IBM is not set
# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
# CONFIG_BLK_DEV_IDEDISK_WD is not set
# CONFIG_BLK_DEV_COMMERIAL is not set
# CONFIG_BLK_DEV_TIVO is not set
# CONFIG_BLK_DEV_IDECS is not set
CONFIG_BLK_DEV_IDECD=y
# CONFIG_BLK_DEV_IDETAPE is not set
CONFIG_BLK_DEV_IDEFLOPPY=m
CONFIG_BLK_DEV_IDESCSI=m
# CONFIG_BLK_DEV_CMD640 is not set
# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
# CONFIG_BLK_DEV_ISAPNP is not set
# CONFIG_BLK_DEV_RZ1000 is not set
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
# CONFIG_BLK_DEV_OFFBOARD is not set
# CONFIG_IDEDMA_PCI_AUTO is not set
CONFIG_BLK_DEV_IDEDMA=y
# CONFIG_IDEDMA_PCI_WIP is not set
# CONFIG_IDEDMA_NEW_DRIVE_LISTINGS is not set
# CONFIG_BLK_DEV_AEC62XX is not set
# CONFIG_AEC62XX_TUNING is not set
# CONFIG_BLK_DEV_ALI15X3 is not set
# CONFIG_WDC_ALI15X3 is not set
# CONFIG_BLK_DEV_AMD74XX is not set
# CONFIG_AMD74XX_OVERRIDE is not set
# CONFIG_BLK_DEV_CMD64X is not set
# CONFIG_BLK_DEV_CY82C693 is not set
# CONFIG_BLK_DEV_CS5530 is not set
# CONFIG_BLK_DEV_HPT34X is not set
# CONFIG_HPT34X_AUTODMA is not set
# CONFIG_BLK_DEV_HPT366 is not set
CONFIG_BLK_DEV_PIIX=y
# CONFIG_PIIX_TUNING is not set
# CONFIG_BLK_DEV_NS87415 is not set
# CONFIG_BLK_DEV_OPTI621 is not set
# CONFIG_BLK_DEV_PDC202XX is not set
# CONFIG_PDC202XX_BURST is not set
# CONFIG_PDC202XX_FORCE is not set
# CONFIG_BLK_DEV_SVWKS is not set
# CONFIG_BLK_DEV_SIS5513 is not set
# CONFIG_BLK_DEV_SLC90E66 is not set
# CONFIG_BLK_DEV_TRM290 is not set
CONFIG_BLK_DEV_VIA82CXXX=y
# CONFIG_IDE_CHIPSETS is not set
# CONFIG_IDEDMA_AUTO is not set
# CONFIG_IDEDMA_IVB is not set
# CONFIG_DMA_NONPCI is not set
CONFIG_BLK_DEV_IDE_MODES=y
# CONFIG_BLK_DEV_ATARAID is not set
# CONFIG_BLK_DEV_ATARAID_PDC is not set
# CONFIG_BLK_DEV_ATARAID_HPT is not set

#
# SCSI support
#
CONFIG_SCSI=m
CONFIG_BLK_DEV_SD=m
CONFIG_SD_EXTRA_DEVS=40
CONFIG_CHR_DEV_ST=m
# CONFIG_CHR_DEV_OSST is not set
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_DEBUG_QUEUES=y
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
CONFIG_SCSI_AHA1740=m
# CONFIG_SCSI_AACRAID is not set
CONFIG_SCSI_AIC7XXX=m
CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
CONFIG_AIC7XXX_RESET_DELAY_MS=15000
# CONFIG_AIC7XXX_BUILD_FIRMWARE is not set
CONFIG_SCSI_AIC7XXX_OLD=m
# CONFIG_AIC7XXX_OLD_TCQ_ON_BY_DEFAULT is not set
CONFIG_AIC7XXX_OLD_CMDS_PER_DEVICE=8
CONFIG_AIC7XXX_OLD_PROC_STATS=y
# CONFIG_SCSI_DPT_I2O is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_IN2000 is not set
# CONFIG_SCSI_AM53C974 is not set
# CONFIG_SCSI_MEGARAID is not set
CONFIG_SCSI_BUSLOGIC=m
# CONFIG_SCSI_OMIT_FLASHPOINT is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_DTC3280 is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_DMA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_GENERIC_NCR5380 is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INITIO is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
# CONFIG_SCSI_NCR53C406A is not set
# CONFIG_SCSI_NCR53C7xx is not set
# CONFIG_SCSI_SYM53C8XX_2 is not set
# CONFIG_SCSI_NCR53C8XX is not set
# CONFIG_SCSI_SYM53C8XX is not set
# CONFIG_SCSI_PAS16 is not set
# CONFIG_SCSI_PCI2000 is not set
# CONFIG_SCSI_PCI2220I is not set
# CONFIG_SCSI_PSI240I is not set
# CONFIG_SCSI_QLOGIC_FAS is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_SEAGATE is not set
# CONFIG_SCSI_SIM710 is not set
# CONFIG_SCSI_SYM53C416 is not set
# CONFIG_SCSI_DC390T is not set
# CONFIG_SCSI_T128 is not set
# CONFIG_SCSI_U14_34F is not set
# CONFIG_SCSI_ULTRASTOR is not set
# CONFIG_SCSI_DEBUG is not set

#
# PCMCIA SCSI adapter support
#
# CONFIG_SCSI_PCMCIA is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set
# CONFIG_FUSION_BOOT is not set
# CONFIG_FUSION_ISENSE is not set
# CONFIG_FUSION_CTL is not set
# CONFIG_FUSION_LAN is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set
# CONFIG_I2O_PCI is not set
# CONFIG_I2O_BLOCK is not set
# CONFIG_I2O_LAN is not set
# CONFIG_I2O_SCSI is not set
# CONFIG_I2O_PROC is not set

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
# CONFIG_TUN is not set
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_SUNLANCE is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNBMAC is not set
# CONFIG_SUNQE is not set
# CONFIG_SUNLANCE is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
CONFIG_TULIP=m
# CONFIG_TULIP_MWI is not set
# CONFIG_TULIP_MMIO is not set
# CONFIG_DE4X5 is not set
# CONFIG_DGRS is not set
CONFIG_DM9102=m
CONFIG_EEPRO100=m
# CONFIG_LNE390 is not set
# CONFIG_FEALNX is not set
# CONFIG_NATSEMI is not set
CONFIG_NE2K_PCI=m
# CONFIG_NE3210 is not set
# CONFIG_ES3210 is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_8139TOO_PIO is not set
# CONFIG_8139TOO_TUNE_TWISTER is not set
# CONFIG_8139TOO_8129 is not set
# CONFIG_SIS900 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SUNDANCE is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_RHINE_MMIO is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_MYRI_SBUS is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
CONFIG_PLIP=m
CONFIG_PPP=m
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPP_FILTER is not set
CONFIG_PPP_ASYNC=m
CONFIG_PPP_SYNC_TTY=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_PPPOE=m
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
# CONFIG_SLIP_SMART is not set
# CONFIG_SLIP_MODE_SLIP6 is not set

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Token Ring devices
#
# CONFIG_TR is not set
# CONFIG_NET_FC is not set
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set

#
# PCMCIA network device support
#
# CONFIG_NET_PCMCIA is not set

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
# Input core support
#
CONFIG_INPUT=m
CONFIG_INPUT_KEYBDEV=m
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
# CONFIG_SERIAL_EXTENDED is not set
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_COMPUTONE is not set
# CONFIG_ROCKETPORT is not set
# CONFIG_CYCLADES is not set
# CONFIG_DIGIEPCA is not set
# CONFIG_DIGI is not set
# CONFIG_ESPSERIAL is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_ISI is not set
# CONFIG_SYNCLINK is not set
CONFIG_N_HDLC=m
# CONFIG_RISCOM8 is not set
# CONFIG_SPECIALIX is not set
# CONFIG_SX is not set
# CONFIG_RIO is not set
# CONFIG_STALDRV is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
# CONFIG_PPDEV is not set

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_ALGOBIT=m
# CONFIG_I2C_PHILIPSPAR is not set
# CONFIG_I2C_ELV is not set
# CONFIG_I2C_VELLEMAN is not set
# CONFIG_I2C_ALGOPCF is not set
CONFIG_I2C_CHARDEV=m
CONFIG_I2C_PROC=m

#
# Mice
#
# CONFIG_BUSMOUSE is not set
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
# CONFIG_82C710_MOUSE is not set
# CONFIG_PC110_PAD is not set

#
# Joysticks
#
CONFIG_INPUT_GAMEPORT=m
CONFIG_INPUT_NS558=m
# CONFIG_INPUT_LIGHTNING is not set
CONFIG_INPUT_PCIGAME=m
CONFIG_INPUT_CS461X=m
# CONFIG_INPUT_EMU10K1 is not set
CONFIG_INPUT_SERIO=m
CONFIG_INPUT_SERPORT=m
CONFIG_INPUT_ANALOG=m
# CONFIG_INPUT_A3D is not set
# CONFIG_INPUT_ADI is not set
# CONFIG_INPUT_COBRA is not set
# CONFIG_INPUT_GF2K is not set
# CONFIG_INPUT_GRIP is not set
# CONFIG_INPUT_INTERACT is not set
# CONFIG_INPUT_TMDC is not set
CONFIG_INPUT_SIDEWINDER=m
# CONFIG_INPUT_IFORCE_USB is not set
# CONFIG_INPUT_IFORCE_232 is not set
# CONFIG_INPUT_WARRIOR is not set
# CONFIG_INPUT_MAGELLAN is not set
# CONFIG_INPUT_SPACEORB is not set
# CONFIG_INPUT_SPACEBALL is not set
# CONFIG_INPUT_STINGER is not set
# CONFIG_INPUT_DB9 is not set
# CONFIG_INPUT_GAMECON is not set
# CONFIG_INPUT_TURBOGRAFX is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_INTEL_RNG is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_SONYPI is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
# CONFIG_AGP_I810 is not set
CONFIG_AGP_VIA=y
CONFIG_AGP_AMD=y
CONFIG_AGP_SIS=y
# CONFIG_AGP_ALI is not set
# CONFIG_AGP_SWORKS is not set
CONFIG_DRM=y
CONFIG_DRM_TDFX=y
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
# CONFIG_DRM_RADEON is not set
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set

#
# PCMCIA character devices
#
# CONFIG_PCMCIA_SERIAL_CS is not set
# CONFIG_MWAVE is not set

#
# Multimedia devices
#
CONFIG_VIDEO_DEV=m

#
# Video For Linux
#
CONFIG_VIDEO_PROC_FS=y
# CONFIG_I2C_PARPORT is not set
CONFIG_VIDEO_BT848=m
# CONFIG_VIDEO_PMS is not set
# CONFIG_VIDEO_BWQCAM is not set
# CONFIG_VIDEO_CQCAM is not set
# CONFIG_VIDEO_W9966 is not set
# CONFIG_VIDEO_CPIA is not set
# CONFIG_VIDEO_SAA5249 is not set
# CONFIG_TUNER_3036 is not set
# CONFIG_VIDEO_STRADIS is not set
# CONFIG_VIDEO_ZORAN is not set
# CONFIG_VIDEO_ZORAN_BUZ is not set
# CONFIG_VIDEO_ZORAN_DC10 is not set
# CONFIG_VIDEO_ZORAN_LML33 is not set
# CONFIG_VIDEO_ZR36120 is not set
# CONFIG_VIDEO_MEYE is not set

#
# Radio Adapters
#
# CONFIG_RADIO_CADET is not set
# CONFIG_RADIO_RTRACK is not set
# CONFIG_RADIO_RTRACK2 is not set
# CONFIG_RADIO_AZTECH is not set
# CONFIG_RADIO_GEMTEK is not set
# CONFIG_RADIO_GEMTEK_PCI is not set
# CONFIG_RADIO_MAXIRADIO is not set
# CONFIG_RADIO_MAESTRO is not set
# CONFIG_RADIO_MIROPCM20 is not set
# CONFIG_RADIO_MIROPCM20_RDS is not set
# CONFIG_RADIO_SF16FMI is not set
# CONFIG_RADIO_TERRATEC is not set
# CONFIG_RADIO_TRUST is not set
# CONFIG_RADIO_TYPHOON is not set
# CONFIG_RADIO_ZOLTRIX is not set

#
# File systems
#
CONFIG_QUOTA=y
CONFIG_FS_POSIX_ACL=y
# CONFIG_AUTOFS_FS is not set
CONFIG_AUTOFS4_FS=y
CONFIG_REISERFS_FS=m
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=y
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
# CONFIG_JBD_DEBUG is not set
CONFIG_FAT_FS=m
CONFIG_MSDOS_FS=m
# CONFIG_UMSDOS_FS is not set
CONFIG_VFAT_FS=m
CONFIG_EFS_FS=m
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
CONFIG_CRAMFS=m
CONFIG_TMPFS=y
# CONFIG_RAMFS is not set
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
# CONFIG_MINIX_FS is not set
# CONFIG_VXFS_FS is not set
CONFIG_NTFS_FS=m
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
CONFIG_QNX4FS_FS=m
CONFIG_QNX4FS_RW=y
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
CONFIG_UDF_FS=m
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set
CONFIG_PAGE_BUF=m
CONFIG_XFS_FS=m
# CONFIG_XFS_RT is not set
CONFIG_XFS_QUOTA=y
CONFIG_HAVE_ATTRCTL=y
CONFIG_XFS_DMAPI=y

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
# CONFIG_ROOT_NFS is not set
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=m
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp850"
# CONFIG_NCP_FS is not set
# CONFIG_NCPFS_PACKET_SIGNING is not set
# CONFIG_NCPFS_IOCTL_LOCKING is not set
# CONFIG_NCPFS_STRONG is not set
# CONFIG_NCPFS_NFS_NS is not set
# CONFIG_NCPFS_OS2_NS is not set
# CONFIG_NCPFS_SMALLDOS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set
CONFIG_ZISOFS_FS=m
CONFIG_ZLIB_FS_INFLATE=m

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_BSD_DISKLABEL=y
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
CONFIG_SGI_PARTITION=y
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
# CONFIG_NLS_CODEPAGE_437 is not set
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
CONFIG_NLS_CODEPAGE_850=m
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
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ISO8859_1=m
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=m
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_UTF8 is not set

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
# CONFIG_VIDEO_SELECT is not set
# CONFIG_MDA_CONSOLE is not set

#
# Frame-buffer support
#
# CONFIG_FB is not set

#
# Sound
#
CONFIG_SOUND=y
CONFIG_SOUND_BT878=m
# CONFIG_SOUND_CMPCI is not set
# CONFIG_SOUND_EMU10K1 is not set
# CONFIG_MIDI_EMU10K1 is not set
CONFIG_SOUND_FUSION=m
CONFIG_SOUND_CS4281=m
CONFIG_SOUND_ES1370=m
CONFIG_SOUND_ES1371=m
# CONFIG_SOUND_ESSSOLO1 is not set
# CONFIG_SOUND_MAESTRO is not set
# CONFIG_SOUND_MAESTRO3 is not set
# CONFIG_SOUND_ICH is not set
# CONFIG_SOUND_RME96XX is not set
# CONFIG_SOUND_SONICVIBES is not set
CONFIG_SOUND_TRIDENT=m
# CONFIG_SOUND_MSNDCLAS is not set
# CONFIG_SOUND_MSNDPIN is not set
# CONFIG_SOUND_VIA82CXXX is not set
# CONFIG_MIDI_VIA82CXXX is not set
CONFIG_SOUND_OSS=m
# CONFIG_SOUND_TRACEINIT is not set
CONFIG_SOUND_DMAP=y
# CONFIG_SOUND_AD1816 is not set
# CONFIG_SOUND_SGALAXY is not set
# CONFIG_SOUND_ADLIB is not set
# CONFIG_SOUND_ACI_MIXER is not set
# CONFIG_SOUND_CS4232 is not set
CONFIG_SOUND_SSCAPE=m
# CONFIG_SOUND_GUS is not set
# CONFIG_SOUND_VMIDI is not set
# CONFIG_SOUND_TRIX is not set
CONFIG_SOUND_MSS=m
# CONFIG_SOUND_MPU401 is not set
# CONFIG_SOUND_NM256 is not set
# CONFIG_SOUND_MAD16 is not set
CONFIG_SOUND_PAS=m
# CONFIG_PAS_JOYSTICK is not set
# CONFIG_SOUND_PSS is not set
CONFIG_SOUND_SB=m
CONFIG_SOUND_AWE32_SYNTH=m
# CONFIG_SOUND_WAVEFRONT is not set
# CONFIG_SOUND_MAUI is not set
CONFIG_SOUND_YM3812=m
# CONFIG_SOUND_OPL3SA1 is not set
# CONFIG_SOUND_OPL3SA2 is not set
# CONFIG_SOUND_YMFPCI is not set
# CONFIG_SOUND_YMFPCI_LEGACY is not set
# CONFIG_SOUND_UART6850 is not set
# CONFIG_SOUND_AEDSP16 is not set
# CONFIG_SOUND_TVMIXER is not set

#
# USB support
#
CONFIG_USB=m
# CONFIG_USB_DEBUG is not set
CONFIG_USB_DEVICEFS=y
# CONFIG_USB_BANDWIDTH is not set
# CONFIG_USB_LONG_TIMEOUT is not set
CONFIG_USB_UHCI=m
CONFIG_USB_UHCI_ALT=m
CONFIG_USB_OHCI=m
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_BLUETOOTH is not set
CONFIG_USB_STORAGE=m
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_HP8200e=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_JUMPSHOT=y
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_HID=m
CONFIG_USB_HIDDEV=y
CONFIG_USB_KBD=m
CONFIG_USB_MOUSE=m
# CONFIG_USB_WACOM is not set
# CONFIG_USB_DC2XX is not set
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_SCANNER is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USB_HPUSBSCSI is not set
# CONFIG_USB_IBMCAM is not set
# CONFIG_USB_OV511 is not set
# CONFIG_USB_PWC is not set
# CONFIG_USB_SE401 is not set
# CONFIG_USB_DSBR is not set
# CONFIG_USB_DABUSB is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_CATC is not set
# CONFIG_USB_CDCETHER is not set
# CONFIG_USB_USBNET is not set
# CONFIG_USB_USS720 is not set

#
# USB Serial Converter support
#
CONFIG_USB_SERIAL=m
CONFIG_USB_SERIAL_GENERIC=y
# CONFIG_USB_SERIAL_BELKIN is not set
# CONFIG_USB_SERIAL_WHITEHEAT is not set
# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
# CONFIG_USB_SERIAL_EMPEG is not set
# CONFIG_USB_SERIAL_FTDI_SIO is not set
# CONFIG_USB_SERIAL_VISOR is not set
# CONFIG_USB_SERIAL_IR is not set
# CONFIG_USB_SERIAL_EDGEPORT is not set
# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
# CONFIG_USB_SERIAL_KEYSPAN is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XA is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA28XB is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set
# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
# CONFIG_USB_SERIAL_MCT_U232 is not set
# CONFIG_USB_SERIAL_PL2303 is not set
# CONFIG_USB_SERIAL_CYBERJACK is not set
# CONFIG_USB_SERIAL_XIRCOM is not set
# CONFIG_USB_SERIAL_OMNINET is not set
# CONFIG_USB_RIO500 is not set

#
# Bluetooth support
#
# CONFIG_BLUEZ is not set

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_HIGHMEM is not set
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_IOVIRT=y
CONFIG_MAGIC_SYSRQ=y
# CONFIG_DEBUG_SPINLOCK is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_KDB=y
# CONFIG_KDB_MODULES is not set
# CONFIG_KDB_OFF is not set
CONFIG_KALLSYMS=y
CONFIG_FRAME_POINTER=y


00:00.0 Host bridge: Intel Corporation 440FX - 82441FX PMC [Natoma] (rev 02)
00:07.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II] (rev 01)
00:07.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]
00:08.0 SCSI storage controller: Adaptec AHA-294x / AIC-7871 (rev 03)
00:09.0 Ethernet controller: Davicom Semiconductor, Inc. Ethernet 100/10 MBit (rev 31)
00:0a.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev 01)
00:0b.0 Multimedia video controller: Brooktree Corporation Bt848 TV with DMA push (rev 12)

lsmod:

Module                  Size  Used by
aic7xxx               133905   0 (autoclean) (unused)
sr_mod                 15268   0 (autoclean)
scsi_mod               98800   2 (autoclean) [aic7xxx sr_mod]
isofs                  27716   0 (autoclean)
inflate_fs             20603   0 (autoclean) [isofs]
tuner                   9583   1 (autoclean)
tvaudio                12153   0 (autoclean) (unused)
msp3400                16578   1 (autoclean)
bttv                   68812   1 (autoclean)
i2c-algo-bit            8308   1 (autoclean) [bttv]
i2c-core               18968   0 (autoclean) [tuner tvaudio msp3400 bttv i2c-algo-bit]
videodev                6804   4 (autoclean) [bttv]
ppp_deflate            42603   0 (autoclean)
bsd_comp                4795   0 (autoclean)
ppp_async               8040   0 (autoclean)
snd-mixer-oss           6362   3 (autoclean)
nfsd                   75422   4 (autoclean)
lockd                  56676   1 (autoclean) [nfsd]
sunrpc                 81296   1 (autoclean) [nfsd lockd]
af_packet              14981   2 (autoclean)
parport_pc             17746   1 (autoclean)
lp                      7290   0 (autoclean)
parport                38250   1 (autoclean) [parport_pc lp]
snd-card-sbawe          6789   4
snd-opl3                6327   0 [snd-card-sbawe]
snd-sb16-csp           17938   0 [snd-card-sbawe]
snd-sb16-dsp           20994   0 [snd-card-sbawe snd-sb16-csp]
snd-pcm                44469   1 [snd-sb16-dsp]
snd-timer              12738   0 [snd-opl3 snd-pcm]
snd-mixer              35810   0 [snd-mixer-oss snd-sb16-csp snd-sb16-dsp]
snd-hwdep               4577   0 [snd-opl3 snd-sb16-csp]
snd-mpu401-uart         4387   0 [snd-card-sbawe]
snd-rawmidi            15244   0 [snd-mpu401-uart]
snd-seq-device          5905   0 [snd-card-sbawe snd-rawmidi]
snd                    49774   4 [snd-mixer-oss snd-card-sbawe snd-opl3 snd-sb16-csp snd-sb16-dsp snd-pcm snd-timer snd-mixer
snd-hwdep snd-mpu401-uart snd-rawmidi snd-seq-device]
ipt_TCPMSS              3208   1 (autoclean)
ipt_TOS                 1799  22 (autoclean)
ipt_MASQUERADE          2349   1 (autoclean)
ipt_LOG                 4180  74 (autoclean)
ipt_state               1409  87 (autoclean)
ip_nat_ftp              4245   0 (unused)
ip_conntrack_ftp        4760   0 [ip_nat_ftp]
ppp_generic            21008   0 (autoclean) [ppp_deflate bsd_comp ppp_async]
slhc                    6108   0 (autoclean) [ppp_generic]
dmfe                   16035   1 (autoclean)
ipt_REJECT              3683   3 (autoclean)
iptable_mangle          2574   0 (autoclean) (unused)
iptable_nat            20503   1 (autoclean) [ipt_MASQUERADE ip_nat_ftp]
ip_conntrack           21772   3 (autoclean) [ipt_MASQUERADE ipt_state ip_nat_ftp ip_conntrack_ftp iptable_nat]
iptable_filter          2597   0 (autoclean) (unused)
ip_tables              13572  11 [ipt_TCPMSS ipt_TOS ipt_MASQUERADE ipt_LOG ipt_state ipt_REJECT iptable_mangle iptable_nat
iptable_filter]
reiserfs              175582   2 (autoclean)


           CPU0       CPU1
  0:    2759982    2496821    IO-APIC-edge  timer
  1:       4662       5298    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  3:     466861     466076    IO-APIC-edge  serial
  5:      22179      28603    IO-APIC-edge  Sound Blaster AWE32/64
 12:       4688       4514    IO-APIC-edge  PS/2 Mouse
 14:      53925      64201    IO-APIC-edge  ide0
 16:        174        169   IO-APIC-level  aic7xxx
 17:       7869       7886   IO-APIC-level  eth0
 18:          0          0   IO-APIC-level  bttv
NMI:          0          0
LOC:    5256354    5256347
ERR:          0
MIS:          0
Oops from 6.1.2002

ksymoops 2.4.2 on i686 2.4.17-xfs.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17-xfs/ (default)
     -m /boot/System.map-2.4.17-xfs (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Oops: 0000
CPU:    0
EIP:    0010:[<c0113db0>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210207
eax: 00000005   ebx: 00000014   ecx: 00000000   edx: 00000006
esi: c3c80000   edi: 00000080   ebp: c4723f14   esp: c4723ee0
ds: 0018   es: 0018   ss: 0018
Process kmix (pid: 25786, stackpage=c4723000)
Stack: c4723f28 03493705 00000080 c68ab884 c02c11c0 ccc3c000 00000000 c0bd2e34
       00000001 00000000 00000000 c4722000 c03148e0 c4723f3c c0113aba c4723f28
       00000000 c0bd2e34 00000000 00000000 03493705 c4722000 c01139e0 c4723f70
Call Trace: [<c0113aba>] [<c01139e0>] [<c014343c>] [<c01437de>] [<c0106e7b>]
Code: 8b 51 20 d1 fa 89 d8 2b 41 24 c1 f8 02 8d 54 10 01 89 51 20

>>EIP; c0113db0 <schedule+248/580>   <=====
Trace; c0113aba <schedule_timeout+7a/9c>
Trace; c01139e0 <process_timeout+0/60>
Trace; c014343c <do_select+1c4/1fc>
Trace; c01437de <sys_select+33e/474>
Trace; c0106e7a <system_call+32/38>
Code;  c0113db0 <schedule+248/580>
00000000 <_EIP>:
Code;  c0113db0 <schedule+248/580>   <=====
   0:   8b 51 20                  mov    0x20(%ecx),%edx   <=====
Code;  c0113db2 <schedule+24a/580>
   3:   d1 fa                     sar    %edx
Code;  c0113db4 <schedule+24c/580>
   5:   89 d8                     mov    %ebx,%eax
Code;  c0113db6 <schedule+24e/580>
   7:   2b 41 24                  sub    0x24(%ecx),%eax
Code;  c0113dba <schedule+252/580>
   a:   c1 f8 02                  sar    $0x2,%eax
Code;  c0113dbc <schedule+254/580>
   d:   8d 54 10 01               lea    0x1(%eax,%edx,1),%edx
Code;  c0113dc0 <schedule+258/580>
  11:   89 51 20                  mov    %edx,0x20(%ecx)


1 warning issued.  Results may not be reliable.

Oops on 15.1.2002:

ksymoops 2.4.2 on i686 2.4.17-xfs.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17-xfs/ (default)
     -m /boot/System.map-2.4.17-xfs (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

eax = 0xe4242385 ebx = 0x00000014 ecx = 0x746f6f72 edx = 0x1e5bdb3f
esi = 0xc9d20000 edi = 0x00000010 esp = 0xc9d21f88 eip = 0xc0113db0
ebp = 0xc9d21fbc xss = 0x00000018 xcs = 0x00000010 eflags = 0x00010a87
Oops: 0000
CPU:    0
EIP:    0010:[<c0113db0>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010a87
eax: e4242385   ebx: 00000014   ecx: 746f6f72   edx: 1e5bdb3f
esi: c9d20000   edi: 00000010   ebp: c9d21fbc   esp: c9d21f88
ds: 0018   es: 0018   ss: 0018
Process setiathome (pid: 803, stackpage=c9d21000)
Stack: c9d20000 00000a4c 00000010 ca2b1eb4 c02c11c0 c9d20000 00000000 00000001
       00000001 00000000 00000000 c9d20000 c03148e0 bfffeddc c0106f29 40eebcd0
       00000809 40eea040 00000a4c 00000010 bfffeddc 00000000 0809002b 0000002b
Call Trace: [<c0106f29>]
Code: 8b 51 20 d1 fa 89 d8 2b 41 24 c1 f8 02 8d 54 10 01 89 51 20

>>EIP; c0113db0 <schedule+248/580>   <=====
Trace; c0106f28 <reschedule+4/c>
Code;  c0113db0 <schedule+248/580>
00000000 <_EIP>:
Code;  c0113db0 <schedule+248/580>   <=====
   0:   8b 51 20                  mov    0x20(%ecx),%edx   <=====
Code;  c0113db2 <schedule+24a/580>
   3:   d1 fa                     sar    %edx
Code;  c0113db4 <schedule+24c/580>
   5:   89 d8                     mov    %ebx,%eax
Code;  c0113db6 <schedule+24e/580>
   7:   2b 41 24                  sub    0x24(%ecx),%eax
Code;  c0113dba <schedule+252/580>
   a:   c1 f8 02                  sar    $0x2,%eax
Code;  c0113dbc <schedule+254/580>
   d:   8d 54 10 01               lea    0x1(%eax,%edx,1),%edx
Code;  c0113dc0 <schedule+258/580>
  11:   89 51 20                  mov    %edx,0x20(%ecx)


1 warning issued.  Results may not be reliable.
