Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbTK1RB7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 12:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbTK1RB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 12:01:59 -0500
Received: from www13.mailshell.com ([209.157.66.247]:36832 "HELO mailshell.com")
	by vger.kernel.org with SMTP id S262674AbTK1RBl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 12:01:41 -0500
Message-ID: <20031128170138.9513.qmail@mailshell.com>
Date: Fri, 28 Nov 2003 19:01:31 +0200
X-Accept-Language: en-us, en
MIME-Version: 1.0
Subject: PROBLEM: 2.6test11 kernel panic on "head -1 /proc/net/tcp"
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
From: lkml-031128@amos.mailshell.com
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Please CC to me directly, I'm not on the linix kernel mailing list]

[1.] One line summary of the problem:

2.6test11 kernel panic on "head -1 /proc/net/tcp"

[2.] Full description of the problem/report:

Simply boot kernel 2.6test11 (got the same with test10) and type
"head -1 /proc/net/tcp". The system hangs hard with a message:

"bad: scheduling while atomic!
Call Trace:
   schedule+0x55d/0x570

There is a long call trace following that.

Doing "cat /proc/net/tcp" before that doesn't cause any problem.

The problem is persistant - it happens every time I tried this.

I tried both a kernel with and without pre-emption.

[3.] Keywords (i.e., modules, networking, kernel):

2.6test11, /proc filesystem, head

[4.] Kernel version (from /proc/version):

Linux version 2.6.0-test11-nopreempt (root@picton) (gcc version 3.3.2 
(Debian)) #1 Fri Nov 28 11:33:40 IST 2003

[5.] Output of Oops.. message (if applicable) with symbolic information
      resolved (see Documentation/oops-tracing.txt)

Just the first line:

Call Trace:
   schedule+0x55d/0x570

[6.] A small shell script or example program which triggers the
      problem (if possible)

"head -1 /proc/net/tcp"

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)

Linux picton 2.6.0-test11-nopreempt #1 Fri Nov 28 11:33:40 IST 2003 i686 
GNU/Linux

Gnu C                  3.3.2
Gnu make               3.80
util-linux             2.12
mount                  2.12
module-init-tools      0.9.15-pre3
e2fsprogs              1.35-WIP
PPP                    2.4.2b3
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.14
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0.91
Modules Loaded         sr_mod cdrom radeon ohci_hcd snd_seq_oss 
snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss snd_intel8x0 
snd_pcm snd_timer snd_ac97_codec snd_page_alloc snd_mpu401_uart 
snd_rawmidi snd_seq_device snd


[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Athlon(tm) XP 2500+
stepping        : 0
cpu MHz         : 1830.191
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3620.86


[7.3.] Module information (from /proc/modules):

sr_mod 16164 1 - Live 0xe0a51000
cdrom 34720 1 sr_mod, Live 0xe0a5d000
radeon 117676 34 - Live 0xe0a75000
ohci_hcd 26688 0 - Live 0xe0a49000
snd_seq_oss 36160 0 - Live 0xe09f4000
snd_seq_midi_event 7552 1 snd_seq_oss, Live 0xe09e4000
snd_seq 59664 4 snd_seq_oss,snd_seq_midi_event, Live 0xe0a30000
snd_pcm_oss 61668 0 - Live 0xe0a1f000
snd_mixer_oss 21056 2 snd_pcm_oss, Live 0xe09a0000
snd_intel8x0 24676 1 - Live 0xe09c3000
snd_pcm 104228 2 snd_pcm_oss,snd_intel8x0, Live 0xe0a04000
snd_timer 26116 2 snd_seq,snd_pcm, Live 0xe09cc000
snd_ac97_codec 53508 1 snd_intel8x0, Live 0xe09d5000
snd_page_alloc 12292 2 snd_intel8x0,snd_pcm, Live 0xe09be000
snd_mpu401_uart 7616 1 snd_intel8x0, Live 0xe099d000
snd_rawmidi 25824 1 snd_mpu401_uart, Live 0xe09b6000
snd_seq_device 8456 3 snd_seq_oss,snd_seq,snd_rawmidi, Live 0xe0999000
snd 53476 12 
snd_seq_oss,snd_seq_midi_event,snd_seq,snd_pcm_oss,snd_mixer_oss,snd_intel8x0,snd_pcm,snd_timer,snd_ac97_codec,snd_mpu401_uart,snd_rawmidi,snd_seq_device, 
Live 0xe09a7000

I also tried this from single user, when most modules are not loaded.

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)

/proc/ioports:

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
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1c00-1c07 : nForce2 SMBus
2000-2007 : nForce2 SMBus
9000-9fff : PCI Bus #01
   9000-907f : 0000:01:07.0
     9000-907f : 0000:01:07.0
   9400-947f : 0000:01:08.0
     9400-947f : 0000:01:08.0
a000-afff : PCI Bus #02
   a000-a0ff : 0000:02:00.0
b000-b0ff : 0000:00:06.0
b400-b47f : 0000:00:06.0
   b400-b43f : NVidia nForce2 - Controller
c000-c01f : 0000:00:01.1
c400-c407 : 0000:00:04.0
f000-f00f : 0000:00:09.0
   f000-f007 : ide0
   f008-f00f : ide1

/proc/iomem:

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
   00100000-002feecd : Kernel code
   002feece-003a813f : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
d0000000-d3ffffff : 0000:00:00.0
d4000000-dbffffff : PCI Bus #02
   d4000000-d7ffffff : 0000:02:00.0
   d8000000-dbffffff : 0000:02:00.1
dc000000-ddffffff : PCI Bus #02
   dd000000-dd00ffff : 0000:02:00.0
   dd010000-dd01ffff : 0000:02:00.1
de000000-dfffffff : PCI Bus #01
   df000000-df00007f : 0000:01:07.0
   df001000-df00107f : 0000:01:08.0
e0000000-e0000fff : 0000:00:04.0
e0001000-e0001fff : 0000:00:06.0
   e0001000-e00011ff : NVidia nForce2 - AC'97
e0003000-e0003fff : 0000:00:02.0
   e0003000-e0003fff : ohci_hcd
e0004000-e0004fff : 0000:00:02.1
   e0004000-e0004fff : ohci_hcd
e0005000-e00050ff : 0000:00:02.2
   e0005000-e00050ff : ehci_hcd
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved


[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different version?) 
(rev c1)
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
         Capabilities: [40] AGP version 2.0
                 Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                 Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- 
FW- Rate=x4
         Capabilities: [60] #08 [2001]

00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1 (rev c1)
         Subsystem: nVidia Corporation: Unknown device 0c17
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4 (rev c1)
         Subsystem: nVidia Corporation: Unknown device 0c17
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3 (rev c1)
         Subsystem: nVidia Corporation: Unknown device 0c17
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2 (rev c1)
         Subsystem: nVidia Corporation: Unknown device 0c17
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5 (rev c1)
         Subsystem: nVidia Corporation: Unknown device 0c17
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
         Subsystem: Giga-byte Technology: Unknown device 0c11
         Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Capabilities: [48] #08 [01e1]

00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
         Subsystem: Giga-byte Technology: Unknown device 0c11
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin A routed to IRQ 5
         Region 0: I/O ports at c000 [size=32]
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev 
a4) (prog-if 10 [OHCI])
         Subsystem: Giga-byte Technology: Unknown device 5004
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 (750ns min, 250ns max)
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at e0003000 (32-bit, non-prefetchable) [size=4K]
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev 
a4) (prog-if 10 [OHCI])
         Subsystem: Giga-byte Technology: Unknown device 5004
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 (750ns min, 250ns max)
         Interrupt: pin B routed to IRQ 9
         Region 0: Memory at e0004000 (32-bit, non-prefetchable) [size=4K]
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev 
a4) (prog-if 20 [EHCI])
         Subsystem: Giga-byte Technology: Unknown device 5004
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 (750ns min, 250ns max)
         Interrupt: pin C routed to IRQ 5
         Region 0: Memory at e0005000 (32-bit, non-prefetchable) [size=256]
         Capabilities: [44] #0a [2080]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 Ethernet controller: nVidia Corporation nForce2 Ethernet 
Controller (rev a1)
         Subsystem: Giga-byte Technology: Unknown device e000
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 (250ns min, 5000ns max)
         Interrupt: pin A routed to IRQ 11
         Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=4K]
         Region 1: I/O ports at c400 [size=8]
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:06.0 Multimedia audio controller: nVidia Corporation nForce2 AC97 
Audio Controler (MCP) (rev a1)
         Subsystem: nVidia Corporation: Unknown device 4144
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 (500ns min, 1250ns max)
         Interrupt: pin A routed to IRQ 11
         Region 0: I/O ports at b000 [size=256]
         Region 1: I/O ports at b400 [size=128]
         Region 2: Memory at e0001000 (32-bit, non-prefetchable) [size=4K]
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge (rev 
a3) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
         I/O behind bridge: 00009000-00009fff
         Memory behind bridge: de000000-dfffffff
         Prefetchable memory behind bridge: fff00000-000fffff
         BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2) (prog-if 
8a [Master SecP PriP])
         Subsystem: Giga-byte Technology: Unknown device 5002
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 0 (750ns min, 250ns max)
         Region 4: I/O ports at f000 [size=16]
         Capabilities: [44] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1) (prog-if 00 
[Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32
         Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
         I/O behind bridge: 0000a000-0000afff
         Memory behind bridge: dc000000-ddffffff
         Prefetchable memory behind bridge: d4000000-dbffffff
         BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

01:07.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] 
(rev 28)
         Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (2500ns min, 2500ns max), Cache Line Size: 0x08 (32 
bytes)
         Interrupt: pin A routed to IRQ 9
         Region 0: I/O ports at 9000 [size=128]
         Region 1: Memory at df000000 (32-bit, non-prefetchable) [size=128]
         Expansion ROM at <unassigned> [disabled] [size=128K]
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:08.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] 
(rev 30)
         Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (2500ns min, 2500ns max), Cache Line Size: 0x08 (32 
bytes)
         Interrupt: pin A routed to IRQ 5
         Region 0: I/O ports at 9400 [size=128]
         Region 1: Memory at df001000 (32-bit, non-prefetchable) [size=128]
         Expansion ROM at <unassigned> [disabled] [size=128K]
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:00.0 VGA compatible controller: ATI Technologies Inc Radeon R250 If 
[Radeon 9000] (rev 01) (prog-if 00 [VGA])
         Subsystem: Giga-byte Technology: Unknown device 4010
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (2000ns min), Cache Line Size: 0x08 (32 bytes)
         Interrupt: pin A routed to IRQ 9
         Region 0: Memory at d4000000 (32-bit, prefetchable) [size=64M]
         Region 1: I/O ports at a000 [size=256]
         Region 2: Memory at dd000000 (32-bit, non-prefetchable) [size=64K]
         Expansion ROM at <unassigned> [disabled] [size=128K]
         Capabilities: [58] AGP version 2.0
                 Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- 
HTrans- 64bit- FW+ AGP3- Rate=x1,x2,x4
                 Command: RQ=32 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- 
FW- Rate=x4
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:00.1 Display controller: ATI Technologies Inc Radeon R250 [Radeon 
9000] (Secondary) (rev 01)
         Subsystem: Giga-byte Technology: Unknown device 4011
         Control: I/O- Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (2000ns min), Cache Line Size: 0x08 (32 bytes)
         Region 0: Memory at d8000000 (32-bit, prefetchable) [disabled] 
[size=64M]
         Region 1: Memory at dd010000 (32-bit, non-prefetchable) 
[disabled] [size=64K]
         Capabilities: [50] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-


[7.6.] SCSI information (from /proc/scsi/scsi)

There is no /proc/scsi/scsi file on my system.
It's a non-scsi system. I do use SCSI to access the CD writer and USB.
Maybe the "REPORTING-BUG" file should be updated to direct to files
under /sys?

[7.7.] Other information that might be relevant to the problem
        (please look in /proc and include all information that you
        think to be relevant):

I think that turning APIC on causes problems on my system, so it's off,
even local APIC.

I use a single large ReiserFS filesystem on an 80Gb Maxtor disk.
No Windows installed on this system.

[X.] Other notes, patches, fixes, workarounds:

I think this is a critical bug because any user on the system can cause
it to crash.

I can try to copy the call trace by hand if you think you must have it
in order to analyze the problem.

Thanks,

--Amos

