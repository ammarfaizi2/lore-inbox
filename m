Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271938AbTHDRBa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 13:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271939AbTHDRB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 13:01:29 -0400
Received: from shaggy.siteprotect.com ([64.26.0.136]:9878 "EHLO
	shaggy.siteprotect.com") by vger.kernel.org with ESMTP
	id S271938AbTHDRBH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 13:01:07 -0400
Reply-To: <replies@omershenker.net>
From: "Omer Shenker" <mail@omershenker.net>
To: <linux-kernel@vger.kernel.org>
Subject: PROBLEM: bttv/btaudio use slowing down entire CPU?
Date: Mon, 4 Aug 2003 12:00:47 -0500
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAX7c43NMI70azKMxH2Tac8cKAAAAQAAAAWA3FzNbg5Ee+ktq2VtWZBgEAAAAA@omershenker.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is a bug report in the format suggested by
<http://www.kernel.org/pub/linux/docs/lkml/reporting-bugs.html>. My
apologies for the large size of this message, but I didn't really know what
would be relevant so I erred on the side of detail.

[1.] One line summary of the problem:

The more bttv tuners in use by MythTV, the more CPU top(1) claims to use for
itself.

[2.] Full description of the problem/report:

I'm getting some really strange behavior using MythTV 0.10. I've recently
installed a second tuner and I've noticed that each tuner I use seems to
slow down the CPU. With no tuners in use on my Athlon XP 2400+, top takes
0.7-1.3% CPU (according to itself, though ps agrees). With 1 tuner active,
top takes 2.2-2.9% and mythbackend takes about 34-40%. With 2 tuners active,
top takes 4.2-5.5% CPU and each of the two major mythbackends takes about
42-48% CPU. (Now, I can understand that top may take polynomial time in the
number of processes, but we're talking an extra two or three processes out
of 100-something, and running extra copies of top doesn't have the same
effect.)

Both tuners are Hauppauge 401s, using bttv and btaudio, and there are no
unusual messages in the logs so far as I can tell.

This also happens with one recording and one being watched live, though of
course that's really just two recording and one playing. With one recording
and an old recording being watched, top takes 3.1-4.0% CPU and the one major
mythbackend takes 42-60%.

This problem does *not* show up when using xawtv, but as I understand that
uses a different interface. I don't know of any good way to simulate MythTV
except itself. Rebooting, removing/reinsterting various modules, restarting
various processes: none of these makes any difference so far as I've found.

It looks to me like something isn't scaling here. It's not something I see
for other parts of the system (e.g. making lots of requests at Apache might
cause it to fork more children and take up more overall CPU, but top (and
each individual httpd) doesn't take up any more CPU). If it were just MythTV
taking more CPU that would be one thing, but that top and other processes
also seem to need a larger share of the pie makes me suspect a problem in
the kernel.

I've asked on the relevant MythTV list but (as of now) none of the responses
have helped. See
<http://www.gossamer-threads.com/archive/MythTV_C2/Users_F11/tuner_use_slowi
ng_down_entire_CPU_P74097/> for that thread.

[3.] Keywords (i.e., modules, networking, kernel):

bttv, btaudio, video4linux, v4l, mythtv, xawtv, hauppauge, bt878, msp3400,
top 

[4.] Kernel version (from /proc/version):

Linux version 2.4.21-0.25mdk-omer-stable7 (root@helium) (gcc version 3.2.2
(Mandrake Linux 9.1 3.2.2-3mdk)) #2 Sun Jul 27 18:55:44 CDT 2003

This is based on the latest source package for Mandrake 9.1, using a custom
configuration (not a terribly strange one though).

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

N/A

[6.] A small shell script or example program which triggers the
     problem (if possible)

See [2].

[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)

This is Mandrake Linux release 9.1 (Bamboo) for i586.

Linux helium 2.4.21-0.25mdk-omer-stable7 #2 Sun Jul 27 18:55:44 CDT 2003
i686 unknown unknown GNU/Linux
 
Gnu C                  3.2.2
Gnu make               3.80
util-linux             2.11x
mount                  2.11x
modutils               2.4.22
e2fsprogs              1.32
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.6
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.7
Modules Loaded         serial af_packet ide-floppy ide-tape ide-cd cdrom
ipt_LOG ipt_limit iptable_mangle iptable_nat ip_conntrack iptable_filter
ip_tables softdog via-rhine 8139too mii tuner tvaudio msp3400 bttv videodev
i2c-algo-bit btaudio snd-via82xx snd-ac97-codec snd-pcm-oss snd-mixer-oss
snd-cmipci snd-pcm snd-page-alloc snd-mpu401-uart snd-rawmidi snd-opl3-lib
snd-timer snd-hwdep snd-seq-device snd soundcore w83781d eeprom i2c-proc
i2c-isa i2c-viapro i2c-core rtc

[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 8
model name      : AMD Athlon(tm) XP 2400+
stepping        : 1
cpu MHz         : 1994.353
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3971.48

[7.3.] Module information (from /proc/modules):

serial                 60484   1 (autoclean)
af_packet              13800   2 (autoclean)
ide-floppy             14396   0 (autoclean)
ide-tape               47728   0 (autoclean)
ide-cd                 32384   0 (autoclean)
cdrom                  29568   0 (autoclean) [ide-cd]
ipt_LOG                 3480   2 (autoclean)
ipt_limit                920   2 (autoclean)
iptable_mangle          2168   0 (autoclean) (unused)
iptable_nat            23800   0 (autoclean) (unused)
ip_conntrack           30184   1 (autoclean) [iptable_nat]
iptable_filter          1740   1 (autoclean)
ip_tables              14776   7 [ipt_LOG ipt_limit iptable_mangle
iptable_nat iptable_filter]
softdog                 1916   0 (unused)
via-rhine              14224   1 (autoclean)
8139too                18408   1 (autoclean)
mii                     2608   0 (autoclean) [via-rhine 8139too]
tuner                  10848   2 (autoclean)
tvaudio                13372   0 (autoclean) (unused)
msp3400                17452   2 (autoclean)
bttv                   83200   2
videodev                6272   8 [bttv]
i2c-algo-bit            8360   2 [bttv]
btaudio                11564   1
snd-via82xx            14668   0
snd-ac97-codec         39680   0 [snd-via82xx]
snd-pcm-oss            49540   0
snd-mixer-oss          15864   0 [snd-pcm-oss]
snd-cmipci             22848   0
snd-pcm                73920   0 [snd-via82xx snd-pcm-oss snd-cmipci]
snd-page-alloc          5532   0 [snd-via82xx snd-pcm]
snd-mpu401-uart         3936   0 [snd-via82xx snd-cmipci]
snd-rawmidi            16288   0 [snd-mpu401-uart]
snd-opl3-lib            7908   0 [snd-cmipci]
snd-timer              17800   0 [snd-pcm snd-opl3-lib]
snd-hwdep               6272   0 [snd-opl3-lib]
snd-seq-device          4832   0 [snd-rawmidi snd-opl3-lib]
snd                    40324   0 [snd-via82xx snd-ac97-codec snd-pcm-oss
snd-mixer-oss snd-cmipci snd-pcm snd-mpu401-uart snd-rawmidi snd-opl3-lib
snd-timer snd-hwdep snd-seq-device]
soundcore               3972   0 [bttv btaudio snd]
w83781d                20560   0
eeprom                  3604   0
i2c-proc                7472   0 [w83781d eeprom]
i2c-isa                 1160   0 (unused)
i2c-viapro              3952   0 (unused)
i2c-core               15816   0 [tuner tvaudio msp3400 bttv i2c-algo-bit
w83781d eeprom i2c-proc i2c-isa i2c-viapro]
rtc                     7068   0 (autoclean)

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

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
0290-0297 : w83697hf
02f8-02ff : serial(auto)
0330-0331 : MPU401 UART
0376-0376 : ide1
0388-0389 : OPL2/3 (left)
038a-038b : OPL2/3 (right)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
5000-5007 : viapro-smbus
c000-c0ff : Accton Technology Corporation SMC2-1211TX
  c000-c0ff : 8139too
c400-c4ff : C-Media Electronics Inc CM8738
  c400-c4ff : CMI8738-MC6
c800-c81f : VIA Technologies, Inc. USB
cc00-cc1f : VIA Technologies, Inc. USB (#2)
d000-d01f : VIA Technologies, Inc. USB (#3)
d400-d40f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
  d400-d407 : ide0
  d408-d40f : ide1
d800-d8ff : VIA Technologies, Inc. VT8233 AC97 Audio Controller
  d800-d8ff : VIA8233
e000-e0ff : VIA Technologies, Inc. VT6102 [Rhine-II]
  e000-e0ff : via-rhine

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-002829fb : Kernel code
  002829fc-00312f1f : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
e0000000-e7ffffff : nVidia Corporation NV11 [GeForce2 MX]
e8000000-e8ffffff : nVidia Corporation NV11 [GeForce2 MX]
e9000000-e93fffff : VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge
e9410000-e9410fff : Brooktree Corporation Bt878 Video Capture
  e9410000-e9410fff : bttv
e9411000-e9411fff : Brooktree Corporation Bt878 Video Capture (#2)
  e9411000-e9411fff : bttv
e9412000-e9412fff : Brooktree Corporation Bt878 Audio Capture (#2)
  e9412000-e9412fff : btaudio
e9413000-e9413fff : Brooktree Corporation Bt878 Audio Capture
  e9413000-e9413fff : btaudio
e9414000-e94140ff : Accton Technology Corporation SMC2-1211TX
  e9414000-e94140ff : 8139too
e9415000-e94150ff : VIA Technologies, Inc. USB 2.0
e9416000-e94160ff : VIA Technologies, Inc. VT6102 [Rhine-II]
  e9416000-e94160ff : via-rhine
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge
	Subsystem: VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 8
	Region 0: Memory at e9000000 (32-bit, prefetchable) [size=4M]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4
		Command: RQ=32 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW-
Rate=<none>
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge (prog-if 00
[Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: fff00000-000fffff
	Prefetchable memory behind bridge: fff00000-000fffff
	BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 Multimedia video controller: Brooktree Corporation Bt878 Video
Capture (rev 11)
	Subsystem: Hauppauge computer works Inc. WinTV Series
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at e9410000 (32-bit, prefetchable) [size=4K]
	Capabilities: [44] Vital Product Data
	Capabilities: [4c] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture
(rev 11)
	Subsystem: Hauppauge computer works Inc. WinTV Series
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at e9413000 (32-bit, prefetchable) [size=4K]
	Capabilities: [44] Vital Product Data
	Capabilities: [4c] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: Accton Technology Corporation SMC2-1211TX (rev
10)
	Subsystem: Accton Technology Corporation EN-1207D Fast Ethernet
Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 17
	Region 0: I/O ports at c000 [size=256]
	Region 1: Memory at e9414000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
	Subsystem: C-Media Electronics Inc CMI8738/C3DX PCI Audio Device
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 18
	Region 0: I/O ports at c400 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Multimedia video controller: Brooktree Corporation Bt878 Video
Capture (rev 11)
	Subsystem: Hauppauge computer works Inc. WinTV Series
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at e9411000 (32-bit, prefetchable) [size=4K]
	Capabilities: [44] Vital Product Data
	Capabilities: [4c] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture
(rev 11)
	Subsystem: Hauppauge computer works Inc. WinTV Series
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 19
	Region 0: Memory at e9412000 (32-bit, prefetchable) [size=4K]
	Capabilities: [44] Vital Product Data
	Capabilities: [4c] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 MX/MX
400] (rev b2) (prog-if 00 [VGA])
	Subsystem: Jaton Corp: Unknown device 0000
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 16
	Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at e0000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at <unassigned> [disabled] [size=64K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00
[UHCI])
	Subsystem: VIA Technologies, Inc. USB
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 4: I/O ports at c800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00
[UHCI])
	Subsystem: VIA Technologies, Inc. USB
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin B routed to IRQ 5
	Region 4: I/O ports at cc00 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00
[UHCI])
	Subsystem: VIA Technologies, Inc. USB
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin C routed to IRQ 5
	Region 4: I/O ports at d000 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 20
[EHCI])
	Subsystem: VIA Technologies, Inc. USB 2.0
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 11
	Region 0: Memory at e9415000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
	Subsystem: VIA Technologies, Inc. VT8235 ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586/B/686A/B PIPC Bus
Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. VT8235 Bus Master ATA133/100/66/33
IDE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 255
	Region 4: I/O ports at d400 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233 AC97
Audio Controller (rev 50)
	Subsystem: Biostar Microtech Int'l Corp: Unknown device f614
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 5
	Region 0: I/O ports at d800 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev
74)
	Subsystem: Biostar Microtech Int'l Corp: Unknown device 2200
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (750ns min, 2000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at e000 [size=256]
	Region 1: Memory at e9416000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)

N/A

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

Excerpts from dmesg:

i2c-core.o: i2c core module version 2.7.0 (20021208)
i2c-viapro.o version 2.7.0 (20021208)
i2c-viapro.o: Found Via VT8233A/8235 device
i2c-viapro.o: Via Pro SMBus detected and initialized
i2c-isa.o version 2.7.0 (20021208)
i2c-isa.o: ISA bus access for i2c modules initialized.
i2c-proc.o version 2.7.0 (20021208)
btaudio: driver version 0.7 loaded [digital+analog]
btaudio: Bt878 (rev 17) at 00:08.1, irq: 16, latency: 32, mmio: 0xe9413000
btaudio: using card config "default"
btaudio: registered device dsp2 [digital]
btaudio: registered device dsp3 [analog]
btaudio: registered device mixer2
btaudio: Bt878 (rev 17) at 00:0b.1, irq: 19, latency: 32, mmio: 0xe9412000
btaudio: using card config "default"
btaudio: registered device dsp4 [digital]
btaudio: registered device dsp5 [analog]
btaudio: registered device mixer3
i2c-algo-bit.o: i2c bit algorithm module version 2.7.0 (20021208)
Linux video capture interface: v1.00
bttv: driver version 0.7.100 loaded
bttv: using 64 buffers with 2080k (133120k total) for capture
bttv: Host bridge is VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge
bttv: Bt8xx card found (0).
bttv0: Bt878 (rev 17) at 00:08.0, irq: 16, latency: 32, mmio: 0xe9410000
bttv0: detected: Hauppauge WinTV [card=10], PCI subsystem ID is 0070:13eb
bttv0: using: BT878(Hauppauge (bt878)) [card=10,autodetected]
bttv0: gpio: en=00000000, out=00000000 in=00ffffdb [init #1]
bttv0: gpio: en=00000000, out=00000000 in=00ffffdb [init #1]
bttv0: gpio: en=00000000, out=00000000 in=00ffffdb [init #2]
bttv0: gpio: en=0000002f, out=00000004 in=00ffffd0 [audio: off]
bttv0: gpio: en=0000002f, out=00000024 in=00ffffd0 [msp34xx]
bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
bttv0: i2c attach [client=EEPROM chip,ok]
bttv0: Hauppauge eeprom: model=61381, tuner=Philips FM1236 (2), radio=yes
bttv0: using tuner=2
bttv0: i2c: checking for MSP34xx @ 0x80... found
msp34xx: init: chip=MSP3430G-B6, has NICAM support
msp3410: daemon started
bttv0: i2c attach [client=MSP3430G-B6,ok]
bttv0: i2c: checking for TDA9875 @ 0xb0... not found
bttv0: i2c: checking for TDA7432 @ 0x8a... not found
tvaudio: TV audio decoder + audio/video mux driver
tvaudio: known chips:
tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6420,tda8425,pic16c54
(PV951)
tuner: ignoring SMBus Via Pro adapter at 5000 i2c adapter [id=0x40002]
tuner: ignoring ISA main adapter i2c adapter [id=0x50000]
tuner: probing bt848 #0 i2c adapter [id=0x10005]
tuner: chip found @ 0xc2
tuner: type set to 2 (Philips NTSC (FI1236,FM1236 and compatibles))
bttv0: i2c attach [client=Philips NTSC (FI1236,FM1236 and ,ok]
bttv0: gpio: en=0000002f, out=00000020 in=00ffffd0 [audio: tuner]
bttv0: gpio: en=0000002f, out=00000024 in=00ffffd0 [audio: off]
bttv0: gpio: en=0000002f, out=00000022 in=00ffffd0 [audio: extern]
bttv0: gpio: en=0000002f, out=00000022 in=00ffffd0 [muxsel]
bttv0: PLL: 28636363 => 35468950 ... ok
bttv0: gpio: en=0000002f, out=00000024 in=00ffffd0 [audio: off]
bttv0: registered device video0
bttv0: registered device vbi0
bttv0: registered device radio0
bttv: Bt8xx card found (1).
bttv1: Bt878 (rev 17) at 00:0b.0, irq: 19, latency: 32, mmio: 0xe9411000
bttv1: detected: Hauppauge WinTV [card=10], PCI subsystem ID is 0070:13eb
bttv1: using: BT878(Hauppauge (bt878)) [card=10,autodetected]
bttv1: gpio: en=00000000, out=00000000 in=00ffffdb [init #1]
bttv1: gpio: en=00000000, out=00000000 in=00ffffdb [init #1]
bttv1: gpio: en=00000000, out=00000000 in=00ffffdb [init #2]
bttv1: gpio: en=0000002f, out=00000004 in=00ffffd0 [audio: off]
bttv1: gpio: en=0000002f, out=00000024 in=00ffffd0 [msp34xx]
bttv1: Hauppauge/Voodoo msp34xx: reset line init [5]
bttv1: i2c attach [client=EEPROM chip,ok]
msp34xx: init: chip=MSP3430G-A4, has NICAM support
msp3410: daemon started
bttv1: i2c attach [client=MSP3430G-A4,ok]
tuner: probing bt848 #1 i2c adapter [id=0x10005]
tuner: chip found @ 0xc2
bttv1: i2c attach [client=(tuner unset),ok]
bttv1: Hauppauge eeprom: model=61381, tuner=Philips FM1236 (2), radio=yes
tuner: type set to 2 (Philips NTSC (FI1236,FM1236 and compatibles))
bttv1: using tuner=2
bttv1: i2c: checking for MSP34xx @ 0x80... found
bttv1: i2c: checking for TDA9875 @ 0xb0... not found
bttv1: i2c: checking for TDA7432 @ 0x8a... not found
bttv1: gpio: en=0000002f, out=00000020 in=00ffffd0 [audio: tuner]
bttv1: gpio: en=0000002f, out=00000024 in=00ffffd0 [audio: off]
bttv1: gpio: en=0000002f, out=00000022 in=00ffffd0 [audio: extern]
bttv1: gpio: en=0000002f, out=00000022 in=00ffffd0 [muxsel]
bttv1: PLL: 28636363 => 35468950 ... ok
bttv1: gpio: en=0000002f, out=00000024 in=00ffffd0 [audio: off]
bttv1: registered device video1
bttv1: registered device vbi1
bttv1: registered device radio1

I can tail -f the relevant logs and watch them while I reproduce the
problem. So far as I can tell, there are no relevent log messages except
these:

# starting one recording
Aug  4 08:20:23 helium kernel: bttv1: gpio: en=0000002f, out=00000024
in=00ffffd0 [audio: off]
Aug  4 08:20:23 helium kernel: bttv1: gpio: en=0000002f, out=00000024
in=00ffffd0 [audio: off]
Aug  4 08:20:23 helium kernel: bttv1: gpio: en=0000002f, out=00000020
in=00ffffd0 [audio: tuner]
# starting a second recording
Aug  4 08:21:21 helium kernel: bttv0: gpio: en=0000002f, out=00000024
in=00ffffd0 [audio: off]
Aug  4 08:21:21 helium kernel: bttv0: gpio: en=0000002f, out=00000024
in=00ffffd0 [audio: off]
Aug  4 08:21:22 helium kernel: bttv0: gpio: en=0000002f, out=00000020
in=00ffffd0 [audio: tuner]
# stopping one recording
Aug  4 08:22:00 helium kernel: bttv1: gpio: en=0000002f, out=00000024
in=00ffffd0 [audio: off]
# stopping the other recording
Aug  4 08:22:02 helium kernel: bttv0: gpio: en=0000002f, out=00000024
in=00ffffd0 [audio: off]

[X.] Other notes, patches, fixes, workarounds:

Let me know if there's anything I can do to help debug this.

-- 
Omer Shenker                          http://omershenker.net/


