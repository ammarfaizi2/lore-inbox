Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbTKMAnn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 19:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbTKMAnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 19:43:43 -0500
Received: from cap175-219-202.pixi.net ([207.175.219.202]:10112 "EHLO
	beaucox.com") by vger.kernel.org with ESMTP id S261782AbTKMAnW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 19:43:22 -0500
From: "Beau E. Cox" <beau@beaucox.com>
Organization: BeauCox.com
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.4.23-rc4 -> rc1 hang with change to ip_nat_core.c made in pre4
Date: Wed, 12 Nov 2003 14:42:27 -1000
User-Agent: KMail/1.5.4
Cc: netfilter-devel@lists.netfilter.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311121442.27406.beau@beaucox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

submitted Wed Nov 12 14:12:56 HST 2003 by Beau E. Cox <beau@beaucox.com>

*******************************************************************
* This problem is driving me crazy. This is the forth  
* report I have made and the only response has been 
* a request that I isolate where in the development 
* line the problem began to appear; I have done this
* and, after compliing and testing lots of kernels  
* have isolated the problem to a patch made to      
* ip_nat_core.c in pre4 (see X). I am trying to let the 
* right developer know of my woes, and would really
* like some help in solving this problem. Please let
* me know if I should address someone else or if I can
* provide more information and/or testing. I would
* like to reslove this before 23 comes out. 
******************************************************************

[1.] One line summary of the problem:

Starting with 2.4.23-pre4 my system hangs during startup and/or is
generally unstable - may be network related (see [ X. ] below.)

[2.] Full description of the problem/report:

Origionally I had catagorized this problem with the startup sequence;
the system always seemed to hang when squid was started before
mysql, etc. Moving squid near the end of the startup process, I
thought the problem was in hand. However, the system (pre9) proved
unstable (would not stay up for longer than one day.)

The problem exibits itself with a solid 'hang'; no oops, no dumps,
nada.

[3.] Keywords (i.e., modules, networking, kernel):

networking, netfilter

[4.] Kernel version (from /proc/version):

--- /proc/version ---
Linux version 2.4.23-rc1 (Beau E. Cox: beau@beaucox.com) (gcc version 3.2.3) 
#1 SMP Sat Nov 8 04:33:36 HST 2003

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

n/a

[6.] A small shell script or example program which triggers the
     problem (if possible)

n/a

[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)

--- ver_linux ---
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux cathy.beaucox.com 2.4.23-rc1 #1 SMP Wed Nov 12 13:33:36 HST 2003 i686 
unknown unknown GNU/Linux
 
Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.12
mount                  2.12
modutils               2.4.26
e2fsprogs              1.34
jfsutils               1.1.4
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.14
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0
Modules Loaded         serial isa-pnp parport_pc lp parport ipt_REDIRECT 
ipt_limit ipt_state ip_nat_ftp iptable_nat ip_conntrack_ftp ip_conntrack 
iptable_filter ip_tables ide-scsi rtc

[7.2.] Processor information (from /proc/cpuinfo):

--- /proc/cpuinfo ---
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(tm) MP Processor 1600+
stepping	: 2
cpu MHz		: 1400.048
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat 
pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips	: 2791.83

processor	: 1
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(tm) Processor
stepping	: 2
cpu MHz		: 1400.048
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat 
pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips	: 2798.38


[7.3.] Module information (from /proc/modules):

--- /proc/modules ---
serial                 50628   0 (autoclean)
isa-pnp                32292   0 (autoclean) [serial]
parport_pc             23496   1 (autoclean)
lp                      6976   0 (autoclean)
parport                27008   1 (autoclean) [parport_pc lp]
ipt_REDIRECT             824   1 (autoclean)
ipt_limit               1016   1 (autoclean)
ipt_state                568   4 (autoclean)
ip_nat_ftp              3024   0 (unused)
iptable_nat            17848   2 [ipt_REDIRECT ip_nat_ftp]
ip_conntrack_ftp        4144   1 [ip_nat_ftp]
ip_conntrack           21544   3 [ipt_REDIRECT ipt_state ip_nat_ftp 
iptable_nat ip_conntrack_ftp]
iptable_filter          1740   1 (autoclean)
ip_tables              13152   7 [ipt_REDIRECT ipt_limit ipt_state iptable_nat 
iptable_filter]
ide-scsi               10480   0
rtc                     7676   0 (autoclean)

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

--- /proc/ioports ---
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial(auto)
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
1000-10ff : Linksys Network Everywhere Fast Ethernet 10/100 model NC100
  1000-10ff : tulip
1400-14ff : National Semiconductor Corporation DP83815 (MacPhyter) Ethernet 
Controller
  1400-14ff : eth1
1810-1813 : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System 
Controller
2000-2fff : PCI Bus #01
  2000-20ff : ATI Technologies Inc Rage 128 PF/PRO AGP 4x TMDS
f000-f00f : Advanced Micro Devices [AMD] AMD-766 [ViperPlus] IDE
  f000-f007 : ide0
  f008-f00f : ide1
--- /proc/iomem ---
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000dc000-000dcfff : Advanced Micro Devices [AMD] AMD-766 [ViperPlus] USB
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-3fffffff : System RAM
  00100000-0029be69 : Kernel code
  0029be6a-00300543 : Kernel data
f0001000-f0001fff : National Semiconductor Corporation DP83815 (MacPhyter) 
Ethernet Controller
  f0001000-f0001fff : eth1
f0002000-f00023ff : Linksys Network Everywhere Fast Ethernet 10/100 model 
NC100
  f0002000-f00023ff : tulip
f0003000-f0003fff : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System 
Controller
f0100000-f01fffff : PCI Bus #01
  f0100000-f0103fff : ATI Technologies Inc Rage 128 PF/PRO AGP 4x TMDS
f4000000-f7ffffff : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System 
Controller
f8000000-fbffffff : PCI Bus #01
  f8000000-fbffffff : ATI Technologies Inc Rage 128 PF/PRO AGP 4x TMDS

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System 
Controller (rev 11)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at f4000000 (32-bit, prefetchable) [size=64M]
	Region 1: Memory at f0003000 (32-bit, prefetchable) [size=4K]
	Region 2: I/O ports at 1810 [disabled] [size=4]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ 
AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x4

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP 
Bridge (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 99
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=68
	I/O behind bridge: 00002000-00002fff
	Memory behind bridge: f0100000-f01fffff
	Prefetchable memory behind bridge: f8000000-fbffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-766 [ViperPlus] ISA (rev 
02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-766 [ViperPlus] IDE 
(rev 01) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64
	Region 4: I/O ports at f000 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-766 [ViperPlus] ACPI (rev 01)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-

00:07.4 USB Controller: Advanced Micro Devices [AMD] AMD-766 [ViperPlus] USB 
(rev 07) (prog-if 10 [OHCI])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 16 (20000ns max)
	Interrupt: pin D routed to IRQ 11
	Region 0: Memory at 000dc000 (32-bit, non-prefetchable) [size=4K]

00:0a.0 Ethernet controller: Linksys Network Everywhere Fast Ethernet 10/100 
model NC100 (rev 11)
	Subsystem: Linksys: Unknown device 0574
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64 (63750ns min, 63750ns max), cache line size 10
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 1000 [size=256]
	Region 1: Memory at f0002000 (32-bit, non-prefetchable) [size=1K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=100mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Ethernet controller: National Semiconductor Corporation DP83815 
(MacPhyter) Ethernet Controller
	Subsystem: Netgear: Unknown device f311
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- 
SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 90 (2750ns min, 13000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 1400 [size=256]
	Region 1: Memory at f0001000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=320mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+

01:05.0 VGA compatible controller: ATI Technologies Inc Rage 128 PF/PRO AGP 4x 
TMDS (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc Rage Fury Pro/Xpert 2000 Pro
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ 
SERR- FastB2B+
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 66 (2000ns min), cache line size 10
	Interrupt: pin A routed to IRQ 10
	Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Region 1: I/O ports at 2000 [size=256]
	Region 2: Memory at f0100000 (32-bit, non-prefetchable) [size=16K]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [50] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- 
AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP- GART64- 64bit- FW- Rate=<none>
	Capabilities: [5c] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-


[7.6.] SCSI information (from /proc/scsi/scsi)

--- /proc/scsi/scsi ---
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SAMSUNG  Model: CD-ROM SC-152L   Rev: C100
  Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

--- /proc/ide/amd74xx ---
----------AMD BusMastering IDE Configuration----------------
Driver Version:                     2.10
South Bridge:                       Advanced Micro Devices [AMD] AMD-766 
[ViperPlus] IDE
Revision:                           IDE 0x1
Highest DMA rate:                   UDMA100
BM-DMA base:                        0xf000
PCI clock:                          33.3MHz
-----------------------Primary IDE-------Secondary IDE------
Prefetch Buffer:               no                  no
Post Write Buffer:             no                  no
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   80w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:       UDMA       PIO       DMA       PIO
Address Setup:       30ns      90ns      30ns      90ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns     180ns      90ns     180ns
Data Recovery:       30ns     450ns      30ns     450ns
Cycle Time:          20ns     630ns     120ns     630ns
Transfer Rate:   99.9MB/s   3.1MB/s  16.6MB/s   3.1MB/s
--- /proc/ide/drivers ---
ide-scsi version 0.93
ide-disk version 1.17
ide-default version 0.9.newide

--- all config settings (grep -v "is not set" .config) ---

#
# Automatically generated by make menuconfig: don't edit
#
CONFIG_X86=y
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
CONFIG_MK7=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_HAS_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_USE_3DNOW=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_F00F_WORKS_OK=y
CONFIG_X86_MCE=y
CONFIG_X86_CPUID=y
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_HIGHIO=y
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_NR_CPUS=32
CONFIG_X86_TSC=y
CONFIG_HAVE_DEC_LOCK=y

#
# General setup
#
CONFIG_NET=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_ISA=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y

#
# ACPI Support
#
CONFIG_ACPI_BOOT=y

#
# Memory Technology Devices (MTD)
#

#
# Parallel port support
#
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_1284=y

#
# Plug and Play configuration
#
CONFIG_PNP=m
CONFIG_ISAPNP=m

#
# Block devices
#
CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096

#
# Multi-device support (RAID and LVM)
#

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_NETFILTER=y
CONFIG_UNIX=y
CONFIG_INET=y

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
CONFIG_IP_NF_MATCH_AH_ESP=m
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
CONFIG_IP_NF_TARGET_ULOG=m
CONFIG_IP_NF_TARGET_TCPMSS=m

#
#   IP: Virtual Server Configuration
#

#
#    SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y

#
# Appletalk devices
#

#
# QoS and/or fair queueing
#

#
# Network testing
#

#
# Telephony Support
#

#
# ATA/IDE/MFM/RLL support
#
CONFIG_IDE=y

#
# IDE, ATA and ATAPI Block devices
#
CONFIG_BLK_DEV_IDE=y
CONFIG_BLK_DEV_IDEDISK=y
CONFIG_IDEDISK_MULTI_MODE=y
CONFIG_BLK_DEV_IDECD=m
CONFIG_BLK_DEV_IDESCSI=m
CONFIG_BLK_DEV_IDEPCI=y
CONFIG_IDEPCI_SHARE_IRQ=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_IDEDMA_PCI_WIP=y
CONFIG_BLK_DEV_ADMA100=y
CONFIG_BLK_DEV_AMD74XX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y

#
# SCSI support
#
CONFIG_SCSI=y
CONFIG_BLK_DEV_SR=m
CONFIG_BLK_DEV_SR_VENDOR=y
CONFIG_SR_EXTRA_DEVS=2
CONFIG_CHR_DEV_SG=m
CONFIG_SCSI_CONSTANTS=y

#
# SCSI low-level drivers
#

#
# Fusion MPT device support
#

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#

#
# I2O device support
#

#
# Network device support
#
CONFIG_NETDEVICES=y

#
# ARCnet devices
#

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_TULIP=y
CONFIG_NATSEMI=y

#
# Ethernet (1000 Mbit)
#

#
# Wireless LAN (non-hamradio)
#

#
# Token Ring devices
#

#
# Wan interfaces
#

#
# Amateur Radio support
#

#
# IrDA (infrared) support
#

#
# ISDN subsystem
#

#
# Old CD-ROM drivers (not SCSI, not IDE)
#

#
# Input core support
#
CONFIG_INPUT=m
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=m
CONFIG_SERIAL_EXTENDED=y
CONFIG_SERIAL_SHARE_IRQ=y
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m

#
# I2C support
#

#
# Mice
#
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y

#
# Joysticks
#

#
# Watchdog Cards
#
CONFIG_RTC=m

#
# Ftape, the floppy tape device driver
#

#
# Direct Rendering Manager (XFree86 DRI support)
#

#
# Multimedia devices
#

#
# File systems
#
CONFIG_AUTOFS_FS=y
CONFIG_AUTOFS4_FS=y
CONFIG_REISERFS_FS=y
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_FAT_FS=m
CONFIG_VFAT_FS=m
CONFIG_TMPFS=y
CONFIG_RAMFS=y
CONFIG_ISO9660_FS=y
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y

#
# Network File Systems
#
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
CONFIG_NFS_DIRECTIO=y
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_TCP=y
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_SMB_FS=y
CONFIG_SMB_NLS_DEFAULT=y
CONFIG_SMB_NLS_REMOTE="cp437"
CONFIG_ZISOFS_FS=y

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
CONFIG_MSDOS_PARTITION=y
CONFIG_SMB_NLS=y
CONFIG_NLS=y

#
# Native Language Support
#
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_ISO8859_1=m

#
# Console drivers
#
CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y

#
# Frame-buffer support
#

#
# Sound
#

#
# USB support
#
CONFIG_USB=m
CONFIG_USB_PRINTER=m

#
# USB Serial Converter support
#

#
# Support for USB gadgets
#

#
# Bluetooth support
#

#
# Kernel hacking
#
CONFIG_LOG_BUF_SHIFT=0

#
# Cryptographic options
#

#
# Library routines
#
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=m

[X.] Other notes, patches, fixes, workarounds:

I rolled back the change to ip_nat_core.c made in pre4 (to pre3 level)
and the system is stable. My patch:

--- linux-2.4.23-pre4/net/ipv4/netfilter/ip_nat_core.c	2003-11-08 
03:01:59.000000000 -1000
+++ linux-2.4.23-pre3/net/ipv4/netfilter/ip_nat_core.c	2003-11-08 
03:00:47.000000000 -1000
@@ -157,8 +157,8 @@
 				continue;
 		}
 
-		if (!(mr->range[i].flags & IP_NAT_RANGE_PROTO_SPECIFIED)
-		    || proto->in_range(&newtuple, IP_NAT_MANIP_SRC,
+		if ((mr->range[i].flags & IP_NAT_RANGE_PROTO_SPECIFIED)
+		    && proto->in_range(&newtuple, IP_NAT_MANIP_SRC,
 				       &mr->range[i].min, &mr->range[i].max))
 			return 1;
 	}


Aloha => Beau;



