Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbTJOM31 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 08:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbTJOM31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 08:29:27 -0400
Received: from [203.97.82.178] ([203.97.82.178]:59074 "EHLO treshna.com")
	by vger.kernel.org with ESMTP id S263014AbTJOM3P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 08:29:15 -0400
Message-ID: <3F8D3D97.4020802@treshna.com>
Date: Thu, 16 Oct 2003 01:29:11 +1300
From: Dru <andru@treshna.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.4) Gecko/20031010 Debian/1.4-6
X-Accept-Language: en-nz
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Preemptible kernel makes mpg123 skip a lot under 2.6.0-testing7
 and very high load average under low usage.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I use mpg123 for playing mp3's on my computer and it skips a lot under 
2.6.0-testing7 with preemptible kernel.  I get a lot of skipping, moving 
between virtual desktops, moving mouse between terminals, even editing 
text in editors, writing this email etc causes it to skip. I have to 
nice it in order to play without skipping.  I have pre-emptible kernel 
enabled.  Is there anyway to modify the code here to allow mpg123 keep 
using its 2% of cpu?  Maybe notice if applications are always using cpu 
cycles to not have them intrupted  by taking there resources away for 
pre-emptiable  kernel.  I'm not 100% certain its preemptiable kernel 
causing the problem, as i havn't tried disabling it in my kernel and 
re-testing it.  Xmms has the same problem but not as bad as mpg123.

The other problem I am getting is occasionly I get very high load 
average, 0.5-2 with low cpu usuage and well over my physical memory 
free.  I'm not doing any disk acticivity so I'm not sure whats pushing 
the load average up and if its completely normal
or not.  The kernel and computer itself is quite stable and reliable so 
far. I'm also running testing7 on a opetron, and while its cpu usage 
normally sits between 2-5% usuage due all the applications it runs its 
load average generally stays around the 0.00-0.02 mark.

Some outputs from top/free etc to explain what i mean.

top - 01:25:20 up 5 days,  1:59, 39 users,  load average: 1.69, 0.65, 0.48
Tasks: 179 total,   2 running, 177 sleeping,   0 stopped,   0 zombie
Cpu(s):  7.0% us,  1.0% sy,  0.0% ni, 91.4% id,  0.0% wa,  0.0% hi,  0.7% si
Mem:    904788k total,   896788k used,     8000k free,     8776k buffers
Swap:  1914656k total,   149120k used,  1765536k free,   571172k cached

top - 01:10:18 up 5 days,  1:44, 39 users,  load average: 0.58, 0.56, 0.41
Tasks: 178 total,   1 running, 177 sleeping,   0 stopped,   0 zombie
Cpu(s):  7.0% us,  0.7% sy,  0.0% ni, 91.3% id,  0.3% wa,  0.0% hi,  0.7% si
Mem:    904788k total,   896564k used,     8224k free,     8752k buffers
Swap:  1914656k total,   149156k used,  1765500k free,   573728k cached

top - 01:17:39 up 5 days,  1:52, 39 users,  load average: 0.94, 0.74, 0.51
Tasks: 178 total,   1 running, 177 sleeping,   0 stopped,   0 zombie
Cpu(s):  7.9% us,  1.0% sy,  0.0% ni, 89.1% id,  1.0% wa,  0.0% hi,  1.0% si
Mem:    904788k total,   896084k used,     8704k free,     8808k buffers
Swap:  1914656k total,   149152k used,  1765504k free,   571500k cached
                                                                                

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
22953 andru     15   0 10100 5316 9464 S  3.7  0.6   2:02.39 mpg123
 1067 root       5 -10  595m  58m 539m S  3.3  6.6 391:41.29 XFree86
 1176 andru     15   0 47488  26m  13m S  1.0  3.0  11:52.32 gnome-terminal
25063 root      17   0  2004 1096 1792 R  0.7  0.1   0:00.03 top

             total       used       free     shared    buffers     cached
Mem:        904788     893084      11704          0       8752     570240
-/+ buffers/cache:     314092     590696
Swap:      1914656     149156    1765500

 
Linux nikita 2.6.0-test7 #1 Fri Oct 10 22:54:59 NZDT 2003 i686 GNU/Linux
 
Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      0.9.15-pre2
e2fsprogs              1.35-WIP
nfs-utils              1.0.5
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.12
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91
Modules Loaded         snd nvidia apm sd_mod parport_pc lp parport 
binfmt_misc 8250 serial_core uhci_hcd ohci_hcd ehci_hcd hid usbcore 
emu10k1 soundcore ac97_codec agpgart vfat fat smbfs ide_scsi loop sr_mod 
cdrom sg scsi_mod

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Pentium(R) 4 CPU 2.53GHz
stepping        : 4
cpu MHz         : 2524.859
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 4980.73

snd 38456 0 - Live 0xfada6000
nvidia 1700780 32 - Live 0xf8bc8000
apm 16112 1 - Live 0xf89e0000
sd_mod 11040 0 - Live 0xf8961000
parport_pc 23592 0 - Live 0xf89f0000
lp 8768 0 - Live 0xf8998000
parport 36328 2 parport_pc,lp, Live 0xf89e6000
binfmt_misc 8200 1 - Live 0xf8994000
8250 18400 0 - Live 0xf89d4000
serial_core 19328 1 8250, Live 0xf89ce000
uhci_hcd 29836 0 - Live 0xf89a6000
ohci_hcd 28160 0 - Live 0xf899e000
ehci_hcd 32644 0 - Live 0xf896b000
hid 30016 0 - Live 0xf8975000
usbcore 103644 6 uhci_hcd,ohci_hcd,ehci_hcd,hid, Live 0xf89b3000
emu10k1 73348 5 - Live 0xf8981000
soundcore 6976 6 emu10k1, Live 0xf895e000
ac97_codec 16908 1 emu10k1, Live 0xf8965000
agpgart 25896 0 - Live 0xf893a000
vfat 12544 0 - Live 0xf8935000
fat 39104 1 vfat, Live 0xf8953000
smbfs 61560 0 - Live 0xf8942000
ide_scsi 11904 0 - Live 0xf892a000
loop 13576 0 - Live 0xf8900000
sr_mod 12964 0 - Live 0xf8905000
cdrom 32160 1 sr_mod, Live 0xf88ed000
sg 28696 0 - Live 0xf88f7000
scsi_mod 96056 4 sd_mod,ide_scsi,sr_mod,sg, Live 0xf890c000

0000-001f : dma1
0020-0021 : pic1
0040-005f : timer
0060-006f : keyboard
0070-0077 : rtc
0080-008f : dma page reg
00a0-00a1 : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1
01f0-01f7 : ide0
02f8-02ff : serial
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial
0500-051f : 0000:00:1f.3
0cf8-0cff : PCI conf1
a000-a0ff : 0000:02:01.0
a400-a4ff : 0000:02:03.0
  a400-a4ff : 8139too
a800-a81f : 0000:02:04.0
  a800-a81f : EMU10K1
ac00-ac07 : 0000:02:04.1
b000-b03f : 0000:02:06.0
b400-b40f : 0000:02:06.0
b800-b80f : 0000:02:06.0
bc00-bc03 : 0000:02:06.0
c000-c003 : 0000:02:06.0
d000-d01f : 0000:00:1d.1
  d000-d01f : uhci-hcd
d400-d41f : 0000:00:1d.2
  d400-d41f : uhci-hcd
d800-d81f : 0000:00:1d.0
  d800-d81f : uhci-hcd
e000-e0ff : 0000:00:1f.5
e400-e43f : 0000:00:1f.5
f000-f00f : 0000:00:1f.1
  f000-f007 : ide0
  f008-f00f : ide1

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-3fffffff : System RAM
  00100000-0032d439 : Kernel code
  0032d43a-003f2d7f : Kernel data
40000000-400003ff : 0000:00:1f.1
40000400-400004ff : 0000:02:03.0
  40000400-400004ff : 8139too
c0000000-c7ffffff : PCI Bus #01
  c0000000-c7ffffff : 0000:01:00.0
c8000000-cfffffff : 0000:02:00.0
d0000000-d0ffffff : 0000:02:01.0
d1000000-d107ffff : 0000:02:00.0
d8000000-dbffffff : 0000:00:00.0
dc000000-dcffffff : 0000:02:00.0
dd020000-dd020fff : 0000:02:01.0
de000000-dfffffff : PCI Bus #01
  de000000-deffffff : 0000:01:00.0
e0000000-e00003ff : 0000:00:1d.7
  e0000000-e00003ff : ehci_hcd
e0001000-e00011ff : 0000:00:1f.5
e0002000-e00020ff : 0000:00:1f.5
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffb00000-ffffffff : reserved


00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host 
Bridge (rev 11)
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 9031
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at d8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [e4] #09 [a104]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW- 
Rate=x4
00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge 
(rev 11) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: de000000-dfffffff
        Prefetchable memory behind bridge: c0000000-c7ffffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
 
00:1d.0 USB Controller: Intel Corp. 82801DB USB (Hub #1) (rev 01) 
(prog-if 00 [UHCI])
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 9031
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 4: I/O ports at d800 [size=32]
 
00:1d.1 USB Controller: Intel Corp. 82801DB USB (Hub #2) (rev 01) 
(prog-if 00 [UHCI])
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 9031
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 19
        Region 4: I/O ports at d000 [size=32]
 
00:1d.2 USB Controller: Intel Corp. 82801DB USB (Hub #3) (rev 01) 
(prog-if 00 [UHCI])
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 9031
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin C routed to IRQ 18
        Region 4: I/O ports at d400 [size=32]
 
00:1d.7 USB Controller: Intel Corp. 82801DB USB2 (rev 01) (prog-if 20 
[EHCI])
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 9031
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin D routed to IRQ 23
        Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA/DB/EB PCI Bridge (rev 81) 
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR+
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
        I/O behind bridge: 0000a000-0000cfff
        Memory behind bridge: dc000000-ddffffff
        Prefetchable memory behind bridge: c8000000-d7ffffff
        BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-
 
00:1f.0 ISA bridge: Intel Corp. 82801DB LPC Interface Controller (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
 
00:1f.1 IDE interface: Intel Corp. 82801DB Ultra ATA Storage Controller 
(rev 01) (prog-if 8a [Master SecP PriP])
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 9031
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at <unassigned>
        Region 1: I/O ports at <unassigned>
        Region 2: I/O ports at <unassigned>
        Region 3: I/O ports at <unassigned>
        Region 4: I/O ports at f000 [size=16]
        Region 5: Memory at 40000000 (32-bit, non-prefetchable) [size=1K]
 
00:1f.3 SMBus: Intel Corp. 82801DB/DBM SMBus Controller (rev 01)
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 9031
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 17
        Region 4: I/O ports at 0500 [size=32]
 
00:1f.5 Multimedia audio controller: Intel Corp. 82801DB AC'97 Audio 
Controller (rev 01)
        Subsystem: FIRST INTERNATIONAL Computer Inc: Unknown device 9031
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 17
        Region 0: I/O ports at e000 [size=256]
        Region 1: I/O ports at e400 [size=64]
        Region 2: Memory at e0001000 (32-bit, non-prefetchable) [size=512]
        Region 3: Memory at e0002000 (32-bit, non-prefetchable) [size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
01:00.0 VGA compatible controller: nVidia Corporation NV11 [GeForce2 
MX/MX 400] (rev a1) (prog-if 00 [VGA])
        Subsystem: LeadTek Research Inc.: Unknown device 2830
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at de000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at c0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA- ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                Command: RQ=32 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- 
FW- Rate=x4
 
02:00.0 VGA compatible controller: nVidia Corporation NV17 [GeForce4 MX 
440-SE] (rev a3) (prog-if 00 [VGA])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 16
        Region 0: Memory at dc000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at c8000000 (32-bit, prefetchable) [size=128M]
        Region 2: Memory at d1000000 (32-bit, prefetchable) [size=512K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
02:01.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro 
215GP (rev 5c) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Rage Pro Turbo
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=16M]
        Region 1: I/O ports at a000 [size=256]
        Region 2: Memory at dd020000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
 
02:03.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
RTL-8139/8139C/8139C+ (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 21
        Region 0: I/O ports at a400 [size=256]
        Region 1: Memory at 40000400 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
02:04.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 08)
        Subsystem: Creative Labs CT4832 SBLive! Value
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 22
        Region 0: I/O ports at a800 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
02:04.1 Input device controller: Creative Labs SB Live! MIDI/Game Port 
(rev 08)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at ac00 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 
02:06.0 Multimedia audio controller: ESS Technology ES1969 Solo-1 
Audiodrive (rev 01)
        Subsystem: ESS Technology Solo-1 Audio Adapter
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 17
        Region 0: I/O ports at b000 [size=64]
        Region 1: I/O ports at b400 [size=16]
        Region 2: I/O ports at b800 [size=16]
        Region 3: I/O ports at bc00 [size=4]
        Region 4: I/O ports at c000 [size=4]
        Capabilities: [c0] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

/dev/hda1 on / type xfs (rw)
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
none on /proc/bus/usb type usbdevfs (rw)
/dev/hda2 on /usr type xfs (rw)
/dev/hda3 on /home type xfs (rw)
/dev/hda5 on /var type xfs (rw)
/dev/hda6 on /tmp type ext3 (rw)
192.168.2.3:/home on /home/frederick type nfs 
(rw,rsize=8192,wsize=8192,addr=192.168.2.3)
tyreal:/var/www on /home/www type nfs 
(rw,rsize=8192,wsize=8192,addr=192.168.1.4)
tyreal:/home/storage on /home/storage type nfs 
(rw,rsize=8192,wsize=8192,addr=192.168.1.4)
tyreal:/home on /home/tyrael type nfs 
(rw,rsize=8192,wsize=8192,addr=192.168.1.4)
none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)
automount(pid28472) on /var/autofs/net type autofs 
(rw,fd=5,pgrp=28472,minproto=2,maxproto=4)
automount(pid28467) on /var/autofs/misc type autofs 
(rw,fd=5,pgrp=28467,minproto=2,maxproto=4)

Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/hda1               581320    450124    131196  78% /
/dev/hda2              6830952   5037272   1793680  74% /usr
/dev/hda3             67227916  66852304    375612 100% /home
/dev/hda5               629704    554332     75372  89% /var
/dev/hda6               961352     22940    889576   3% /tmp
192.168.2.3:/home     25472460  19106688   5071828  80% /home/frederick
tyreal:/var/www       15333416   7092908   8240508  47% /home/www
tyreal:/home/storage 134176040 123001776   5721672  96% /home/storage
tyreal:/home          29578896  27790404   1788492  94% /home/tyrael


