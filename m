Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbTKCRIp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 12:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbTKCRIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 12:08:45 -0500
Received: from cap175-219-202.pixi.net ([207.175.219.202]:16512 "EHLO
	beaucox.com") by vger.kernel.org with ESMTP id S262164AbTKCRId
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 12:08:33 -0500
From: "Beau E. Cox" <beau@beaucox.com>
Organization: BeauCox.com
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.4.23-pre7,pre8,pre9 hang on starting squid
Date: Mon, 3 Nov 2003 07:08:09 -1000
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311030708.09283.beau@beaucox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] summary:

2.4.23-pre7,pre8,pre9 hang depending on when 'squid' is started.

[2.] Full description:

Running up-to-date Sorcerer.

One machine hangs consistently when this sequence of daemons
is started in runlevel 3:

   S26networking       ifconfig etho, eth1, eth1:1 & routes
   S28firewall         firewall viaiptables
   S30portmap          5beta
   S32ntpd             4.2.0
   S34named            bind 9.2.3
   S36nfs
   S38rpc.bootparamd
   S40xinetd
   S42squid            2.5.STABLE4
   S44mysql            4.0.15a
   S46xmail            xmailserver mail server 1.17
   S48spamd
   S50apachectl        2.0.48

It works flawlessly when squid is put to the bottom:

   S26networking
   S28firewall
   S30portmap
   S32ntpd
   S34named
   S36nfs
   S38rpc.bootparamd
   S40xinetd
   S42mysql
   S44xmail
   S46spamd
   S48apachectl
   S50squid

Why am I bothering you kernel folks with what looks like a pure
SA problem?

   1. This machine works flawlessly (with squid started before
      mysql, etc.) unter 2.4.22.
   2. Four other machines running the same software (I compile
      my own packages via Sorcerer) using 2.4.23-pre9 and squid
      above.
   3. This problem is solid on this one machine. Always reproduceable.
      Always hangs with squid. No dumps found. Just HANG.

[3.] Keywords (i.e., modules, networking, kernel):

2.4.23-prex squid

[4.] Kernel version (from /proc/version):

Linux version 2.4.23-pre9 (Beau E. Cox: beau@beaucox.com) (gcc version 3.2.3) 
#1 SMP Mon Nov 3 04:59:14 HST 2003

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

-none-

[6.] A small shell script or example program which triggers the
     problem (if possible)

-n/a-

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Software enumerated above.

ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux cathy.beaucox.com 2.4.23-pre9 #1 SMP Mon Nov 3 04:59:14 HST 2003 i686 
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

Tyan Tiger MP dual AMD athlon processors.

/proc/cpuinfo
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 6
model name	: AMD Athlon(tm) MP Processor 1600+
stepping	: 2
cpu MHz		: 1400.071
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
cpu MHz		: 1400.071
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

/proc/modules
serial                 50596   0 (autoclean)
isa-pnp                32292   0 (autoclean) [serial]
parport_pc             23496   1 (autoclean)
lp                      6976   0 (autoclean)
parport                27008   1 (autoclean) [parport_pc lp]
ipt_REDIRECT             824   1 (autoclean)
ipt_limit               1016   1 (autoclean)
ipt_state                568   4 (autoclean)
ip_nat_ftp              2992   0 (unused)
iptable_nat            17688   2 [ipt_REDIRECT ip_nat_ftp]
ip_conntrack_ftp        4144   1 [ip_nat_ftp]
ip_conntrack           23016   3 [ipt_REDIRECT ipt_state ip_nat_ftp 
iptable_nat ip_conntrack_ftp]
iptable_filter          1740   1 (autoclean)
ip_tables              13152   7 [ipt_REDIRECT ipt_limit ipt_state iptable_nat 
iptable_filter]
ide-scsi               10480   0
rtc                     7676   0 (autoclean)

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

/proc/ioports
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

/proc/iomem
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000dc000-000dcfff : Advanced Micro Devices [AMD] AMD-766 [ViperPlus] USB
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-3fffffff : System RAM
  00100000-0029caa9 : Kernel code
  0029caaa-00302623 : Kernel data
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
	Subsystem: ATI Technologies Inc Rage 128 PF/PRO AGP 4x TMDS
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

/proc/scsi/scsi
Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SAMSUNG  Model: CD-ROM SC-152L   Rev: C100
  Type:   CD-ROM                           ANSI SCSI revision: 02

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

-n/a-

[X.] Other notes, patches, fixes, workarounds:

I have everthing working now, so this ?bug? is not bothering me.
I may well be something sloppy I have done on my end, having nothing
to do with the kernel, but the kernel is the only thing changed(???)

Aloha => Beau;

