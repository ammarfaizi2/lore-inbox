Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbVAIKwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbVAIKwq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 05:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbVAIKwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 05:52:44 -0500
Received: from out007pub.verizon.net ([206.46.170.107]:52957 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S262079AbVAIKwD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 05:52:03 -0500
Date: Sun, 9 Jan 2005 05:52:01 -0500
From: Hikaru1@verizon.net
To: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: PROBLEM: ide-cd in 2.6.8-2.6.10 and 2.4.26-2.4.28 high cpu use with dma
Message-ID: <20050109105201.GB12497@roll>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [70.19.162.94] at Sun, 9 Jan 2005 04:52:02 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I'm using the bug reporting format described at
http://www.kernel.org/pub/linux/docs/lkml/reporting-bugs.html - if you need
any additional information, please contact me.

[1.] One line summary of the problem:
Burning cd's causes extremely high cpu use with dma enabled.

[2.] Full description of the problem/report:
Burning cd's with linux kernel versions 2.4.26-2.4.28 and 2.6.8-2.6.10 with
cdrecord as root user causes extremely high 'system' cpu use according to
top even though dma is enabled on the cdrom drive. Earlier kernel versions
do not have this problem. The problem is so bad that with 2.6.7 a cd can be
burned at 28x while with later kernel versions, only 15x or slower can be
used. Note that the test machine was at one point clean booted without the
nvidia driver loaded, and still experienced the problem. The test machine is
a server, so it's not nice to keep rebooting it; therefore the nvidia module
is shown as loaded in the environment section of this bug report since at
the time ver_linux was run, it was being used normally.

[3.] Keywords (i.e., modules, networking, kernel):
modules, kernel, ide-cd, cd burning

[4.] Kernel version (from /proc/version):
2.6.10 on the current test machine, however 2.6.8-2.6.10 and 2.4.26-2.4.28
also experience the same problems.

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)
No oops information, kernel has no panics or oopsing. No misbehavior is
recorded in syslog.

[6.] A small shell script or example program which triggers the
     problem (if possible)
cdrecord run in -dummy mode on any data will reproduce the problem.

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux qserv 2.6.10 #9 Fri Jan 7 07:16:36 EST 2005 i686 unknown unknown GNU/Linux
 
Gnu C                  3.3.4
Gnu make               3.80
binutils               2.15.92.0.2
util-linux             2.12p
mount                  2.12p
module-init-tools      3.1
e2fsprogs              1.35
reiserfsprogs          3.6.18
reiser4progs           line
Linux C Library        2.3.3
Dynamic linker (ldd)   2.3.3
Linux C++ Library      5.0.6
Procps                 3.2.3
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.2.1
Modules Loaded         snd_pcm_oss snd_mixer_oss sch_ingress cls_u32 sch_sfq sch_cbq iptable_nat ipt_limit ipt_state iptable_filter ip_tables snd_emu10k1 snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_util_mem snd_hwdep snd 3c59x 8139too uhci_hcd nvidia

[7.2.] Processor information (from /proc/cpuinfo):
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 8
model name	: AMD Athlon(tm) XP Processor
stepping	: 1
cpu MHz		: 1986.867
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse pni syscall mmxext 3dnowext 3dnow
bogomips	: 3915.77

[7.3.] Module information (from /proc/modules):
snd_pcm_oss 47904 0 - Live 0xf8c1b000
snd_mixer_oss 17280 1 snd_pcm_oss, Live 0xf8c05000
sch_ingress 3268 1 - Live 0xf89fd000
cls_u32 6596 5 - Live 0xf8a6d000
sch_sfq 4608 2 - Live 0xf8a70000
sch_cbq 15616 1 - Live 0xf8a73000
iptable_nat 22152 0 - Live 0xf8b06000
ipt_limit 1920 1 - Live 0xf8a20000
ipt_state 1472 2 - Live 0xf8a1e000
iptable_filter 2944 1 - Live 0xf89de000
ip_tables 16320 4 iptable_nat,ipt_limit,ipt_state,iptable_filter, Live 0xf8a28000
snd_emu10k1 95172 0 - Live 0xf8a78000
snd_rawmidi 20192 1 snd_emu10k1, Live 0xf8a22000
snd_seq_device 7116 2 snd_emu10k1,snd_rawmidi, Live 0xf89ff000
snd_ac97_codec 72928 1 snd_emu10k1, Live 0xf8a49000
snd_pcm 84296 3 snd_pcm_oss,snd_emu10k1,snd_ac97_codec, Live 0xf8a33000
snd_timer 21252 2 snd_emu10k1,snd_pcm, Live 0xf8a03000
snd_page_alloc 7556 2 snd_emu10k1,snd_pcm, Live 0xf89e7000
snd_util_mem 3264 1 snd_emu10k1, Live 0xf89e5000
snd_hwdep 7364 1 snd_emu10k1, Live 0xf89e2000
snd 46948 9 snd_pcm_oss,snd_mixer_oss,snd_emu10k1,snd_rawmidi,snd_seq_device,snd_ac97_codec,snd_pcm,snd_timer,snd_hwdep, Live 0xf89ee000
3c59x 36136 0 - Live 0xf89c4000
8139too 20544 0 - Live 0xf89d7000
uhci_hcd 30160 0 - Live 0xf89ce000
nvidia 3464788 12 - Live 0xf8d7e000

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0cf8-0cff : PCI conf1
1000-10ff : 0000:00:0a.0
  1000-10ff : 8139too
1400-147f : 0000:00:09.0
  1400-147f : 0000:00:09.0
1480-14bf : 0000:00:07.0
  1480-14bf : EMU10K1
14c0-14df : 0000:00:14.2
  14c0-14df : uhci_hcd
14e0-14ff : 0000:00:14.3
  14e0-14ff : uhci_hcd
1800-180f : 0000:00:14.1
  1800-1807 : ide0
  1808-180f : ide1
1810-1817 : 0000:00:07.1
1818-181b : 0000:00:00.0
ec00-ec0f : 0000:00:14.4
ee00-ee7f : motherboard
  ee00-ee03 : PM1a_EVT_BLK
  ee04-ee05 : PM1a_CNT_BLK
  ee08-ee0b : PM_TMR
  ee20-ee23 : GPE0_BLK
ee80-eeff : motherboard

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cffff : Video ROM
000d0000-000d07ff : Adapter ROM
000ec000-000effff : ACPI Non-volatile Storage
000f0000-000fffff : System ROM
00100000-3fffffff : System RAM
  00100000-003053ac : Kernel code
  003053ad-003db2ff : Kernel data
80000000-80ffffff : PCI Bus #01
  80000000-80ffffff : 0000:01:05.0
    80000000-80ffffff : nvidia
81000000-81003fff : 0000:00:07.2
81100000-811007ff : 0000:00:07.2
  81100000-811007ff : ohci1394
81200000-812000ff : 0000:00:0a.0
  81200000-812000ff : 8139too
81300000-8130007f : 0000:00:09.0
81400000-81400fff : 0000:00:00.0
88000000-8fffffff : PCI Bus #01
  88000000-8fffffff : 0000:01:05.0
90000000-93ffffff : 0000:00:00.0
fffc0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
Attached devices:
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] System Controller (rev 12)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at 90000000 (32-bit, prefetchable) [size=64M]
	Region 1: Memory at 81400000 (32-bit, prefetchable) [size=4K]
	Region 2: I/O ports at 1818 [disabled] [size=4]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW+ Rate=x4

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 [IGD4-1P] AGP Bridge (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: 80000000-80ffffff
	Prefetchable memory behind bridge: 88000000-8fffffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 Multimedia audio controller: Creative Labs SB Audigy (rev 04)
	Subsystem: Creative Labs: Unknown device 2002
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at 1480 [size=64]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 Input device controller: Creative Labs SB Audigy MIDI/Game port (rev 04)
	Subsystem: Creative Labs SB Audigy MIDI/Game Port
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at 1810 [size=8]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port (rev 04) (prog-if 10 [OHCI])
	Subsystem: Creative Labs SB Audigy FireWire Port
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max), cache line size 08
	Interrupt: pin B routed to IRQ 11
	Region 0: Memory at 81100000 (32-bit, non-prefetchable) [size=2K]
	Region 1: Memory at 81000000 (32-bit, non-prefetchable) [size=16K]
	Capabilities: [44] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME+

00:09.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 74)
	Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (2500ns min, 2500ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at 1400 [size=128]
	Region 1: Memory at 81300000 (32-bit, non-prefetchable) [size=128]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0a.0 Ethernet controller: Accton Technology Corporation SMC2-1211TX (rev 10)
	Subsystem: Accton Technology Corporation EN-1207D Fast Ethernet Adapter
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (8000ns min, 16000ns max)
	Interrupt: pin A routed to IRQ 3
	Region 0: I/O ports at 1000 [size=256]
	Region 1: Memory at 81200000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [50] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:14.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:14.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C/VT8235 PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at 1800 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:14.2 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 16) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at 14c0 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:14.3 USB Controller: VIA Technologies, Inc. VT6202 [USB 2.0 controller] (rev 16) (prog-if 00 [UHCI])
	Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 11
	Region 4: I/O ports at 14e0 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:14.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin ? routed to IRQ 9
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:05.0 VGA compatible controller: nVidia Corporation NV34 [GeForce FX 5200] (rev a1) (prog-if 00 [VGA])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 248 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 3
	Region 0: Memory at 80000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at 88000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 3.0
		Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
		Command: RQ=16 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW+ Rate=x4

[7.6.] SCSI information (from /proc/scsi/scsi)
Nonexistent proc file. No scsi drivers are loaded.

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

Checked with hdparm multiple times during cd writes and dma was enabled
correctly on the drive even though performance was horrible. BIOS settings
were checked thoroughly although the settings were unable to be set
manually, the BIOS is enabling dma on the cd drive.

The cd drive for all the tests is a PIONEER DVD-RW DVR-108 on /dev/hdd

[X.] Other notes, patches, fixes, workarounds:

I had to help the user who owns this system with this problem remotely via
IRC, but I will direct any questions you have about his computer to him, or
you can email him yourself at admin [at] tuxq.com. His real name is Steven E.
Woolard.

Again, note that even though the environment data shows the nvidia driver is
loaded on this machine, the machine was tested both with it loaded and
unloaded with the same effects. The environment data only shows it loaded
because the machine is a server and the owner doesn't like rebooting it all
the time. I felt it was fairly pointless to ask him to fetch the environment
data all over again.

(workaround? fix? What's this thing DO that I found?)
After hearing him yell repeatedly that something had broken in the linux
kernel and determining that 2.6.7 had worked but 2.6.8 didn't, I eyeballed
the diff of the drivers/ide subdirectory, and found a curious... oddity. On
a whim, I had him check and it was set the same in 2.6.10, so I had him
change it to what it had been in 2.6.7 - suddenly cd burning works correctly
for him.

For both examples, the line changed is in drivers/ide/ide-cd.c

In 2.6.8 and later, the line reads:
blk_queue_dma_alignment(drive->queue, 31);

In 2.6.7, the line reads:
blk_queue_dma_alignment(drive->queue, 3);

To be completely clear, the line from 2.6.7 works correctly while the line
from 2.6.8 does not. I don't know what this does, only that it causes his
hardware to work again.

I tried to find a similar line in the 2.4 series, but was unable to. When I
have more time I'll try eyeballing the ide diff between 2.4.25 and 2.4.26 and
see if I stumble into something.

Honestly, I don't know what this patch actually changes. I'm a novice coder
in C at best and am just learning the basics, so forgive me for throwing
this at you without any idea of what its meaning is.

At a guess, I'd say this is a typo - but whatever it is, I'd love to know.

I have attached a patch which applies to 2.6.10, or 2.6.8/2.6.9 if you use
-p1

Timothy Charles McGrath
