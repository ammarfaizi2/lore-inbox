Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266459AbUJID2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266459AbUJID2f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 23:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266463AbUJID2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 23:28:35 -0400
Received: from imo-d01.mx.aol.com ([205.188.157.33]:19097 "EHLO
	imo-d01.mx.aol.com") by vger.kernel.org with ESMTP id S266459AbUJID2R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 23:28:17 -0400
Date: Fri, 08 Oct 2004 23:28:09 -0400
From: Ciucioni@netscape.net (Gustavo Solari-Bortolotti)
To: linux-kernel@vger.kernel.org
Subject: Mouse lock when any keyboard key is pressed at same time mouse moves
MIME-Version: 1.0
Message-ID: <6FCCD038.7E24D4F9.006FAE0F@netscape.net>
X-Mailer: Atlas Mailer 2.0
X-AOL-IP: 64.169.154.41
X-AOL-Language: english
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am sorry I don't know who to exactly send this message to, so please bare with me.

I have noticed a mouse problem since the 2.6.5 kernel release (when I actually upgraded from 2.4.X) where the mouse locks up every time any key is pressed while the mouse is moving.  An example of using a key press, while moving the mouse would be to hold the ctrl key while moving the mouse to make a non linear selected on any window environment.


Here is how to reproduce:

With any Desktop manager, or virtual console loaded with gpm, hold any key while moving the mouse.  The mouse will lock up, and not respond.  Only when the numlock key is pressed a couple of time (most of the time) the mouse acts again.  The first numlock press most of the time will make the mouse active, but acting out of wack.  If the first numlock press did not bring the mouse back to normal, then a second numlock press will bring the mouse back to normal.

Once the mouse comes back to normal, the syslog throws these messages:

Oct  7 19:51:22 ciucioni kernel: psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, throwing 3 bytes away.
Oct  7 19:51:22 ciucioni kernel: psmouse.c: Wheel Mouse at isa0060/serio1/input0 lost synchronization, throwing 1 bytes away.

Below you will find all the information I was able to get as best as I could as asked for by the guidelines.  If anyone has any questions, feel free to email me at the email above.

Thanks for your time.

----------------------- >8 -----------------------------

My environment:

Slackware 9.1 with kernel 2.6.8.1
Gygabyte 7nnxp motherboard
1GB ram
logitec Mousman ps2 mouse
NVidia FX5200

----------------------------- >8 --------------------------

/proc/cpuinfo:

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Athlon(tm) XP 2500+
stepping        : 0
cpu MHz         : 1830.378
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3620.86

----------------------------- >8 --------------------------

/proc/modules:

nvidia 2071688 12 - Live 0xf8c6d000
ipv6 216036 8 - Live 0xf89f2000
snd_pcm_oss 47240 0 - Live 0xf89a6000
snd_mixer_oss 15904 3 snd_pcm_oss, Live 0xf889e000
snd_emu10k1 78472 3 - Live 0xf890d000
snd_rawmidi 18688 1 snd_emu10k1, Live 0xf88c9000
snd_pcm 78432 2 snd_pcm_oss,snd_emu10k1, Live 0xf88f8000
snd_timer 19104 1 snd_pcm, Live 0xf88c3000
snd_seq_device 6084 2 snd_emu10k1,snd_rawmidi, Live 0xf889b000
snd_ac97_codec 60420 1 snd_emu10k1, Live 0xf88d0000
snd_page_alloc 8616 2 snd_emu10k1,snd_pcm, Live 0xf888e000
snd_util_mem 3040 1 snd_emu10k1, Live 0xf8895000
snd_hwdep 6656 1 snd_emu10k1, Live 0xf8892000
snd 43908 12 snd_pcm_oss,snd_mixer_oss,snd_emu10k1,snd_rawmidi,snd_pcm,snd_timer,snd_seq_device,snd_ac97_codec,snd_util_mem,snd_hwdep, Live 0xf886a000
soundcore 6464 3 snd, Live 0xf8854000
ehci_hcd 24928 0 - Live 0xf8886000
usbcore 95668 3 ehci_hcd, Live 0xf88a3000
adm8211 56608 0 - Live 0xf8877000
crc32 3776 1 adm8211, Live 0xf8857000
ide_scsi 12996 0 - Live 0xf8859000
agpgart 27176 0 - Live 0xf885e000

----------------------------- >8 --------------------------

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
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
8000-cfff : PCI Bus #01
  8000-8fff : PCI Bus #02
    8000-807f : 0000:02:04.0
    8400-847f : 0000:02:05.0
    8800-887f : 0000:02:06.0
    8c00-8c7f : 0000:02:07.0
  9000-9007 : 0000:01:08.1
  9400-94ff : 0000:01:09.0
    9400-94ff : adm8211
  9800-981f : 0000:01:08.0
    9800-981f : EMU10K1
e400-e41f : 0000:00:01.1
f000-f00f : 0000:00:09.0
  f000-f007 : ide0
  f008-f00f : ide1

----------------------------- >8 --------------------------

/proc/iomem:

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cefff : Video ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
  00100000-00316555 : Kernel code
  00316556-003f9ecf : Kernel data
3fff0000-3fff2fff : ACPI Non-volatile Storage
3fff3000-3fffffff : ACPI Tables
d0000000-dfffffff : PCI Bus #04
  d0000000-dfffffff : 0000:04:00.0
e0000000-e3ffffff : 0000:00:00.0
e6000000-e7ffffff : PCI Bus #04
  e6000000-e6ffffff : 0000:04:00.0
e8000000-ebffffff : PCI Bus #01
  e9000000-eaffffff : PCI Bus #02
    ea000000-ea0003ff : 0000:02:04.0
    ea001000-ea0013ff : 0000:02:05.0
    ea002000-ea0023ff : 0000:02:06.0
    ea003000-ea0033ff : 0000:02:07.0
  eb020000-eb0203ff : 0000:01:09.0
    eb020000-eb0203ff : adm8211
ec000000-ec000fff : 0000:00:02.0
ec001000-ec001fff : 0000:00:02.1
ec002000-ec0020ff : 0000:00:02.2
  ec002000-ec0020ff : ehci_hcd
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

----------------------------- >8 --------------------------

lspci -vvv

00:00.0 Host bridge: nVidia Corporation: Unknown device 01e0 (rev c1)
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
    Latency: 0
    Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
    Capabilities: [40] AGP version 3.0
        Status: RQ=32 Iso- ArqSz=2 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
        Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x8
    Capabilities: [60] #08 [2001]

00:00.1 RAM memory: nVidia Corporation: Unknown device 01eb (rev c1)
    Subsystem: nVidia Corporation: Unknown device 0c17
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.2 RAM memory: nVidia Corporation: Unknown device 01ee (rev c1)
    Subsystem: nVidia Corporation: Unknown device 0c17
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.3 RAM memory: nVidia Corporation: Unknown device 01ed (rev c1)
    Subsystem: nVidia Corporation: Unknown device 0c17
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.4 RAM memory: nVidia Corporation: Unknown device 01ec (rev c1)
    Subsystem: nVidia Corporation: Unknown device 0c17
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.5 RAM memory: nVidia Corporation: Unknown device 01ef (rev c1)
    Subsystem: nVidia Corporation: Unknown device 0c17
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
    Subsystem: Giga-byte Technology: Unknown device 0c11
    Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
    Latency: 0
    Capabilities: [48] #08 [01e1]

00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
    Subsystem: Giga-byte Technology: Unknown device 0c11
    Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
    Interrupt: pin A routed to IRQ 10
    Region 0: I/O ports at e400 [size=32]
    Capabilities: [44] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.0 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4) (prog-if 10 [OHCI])
    Subsystem: Giga-byte Technology: Unknown device 5004
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
    Latency: 0 (750ns min, 250ns max)
    Interrupt: pin A routed to IRQ 11
    Region 0: Memory at ec000000 (32-bit, non-prefetchable) [size=4K]
    Capabilities: [44] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.1 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4) (prog-if 10 [OHCI])
    Subsystem: Giga-byte Technology: Unknown device 5004
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
    Latency: 0 (750ns min, 250ns max)
    Interrupt: pin B routed to IRQ 9
    Region 0: Memory at ec001000 (32-bit, non-prefetchable) [size=4K]
    Capabilities: [44] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.2 USB Controller: nVidia Corporation nForce2 USB Controller (rev a4) (prog-if 20 [EHCI])
    Subsystem: Giga-byte Technology: Unknown device 5004
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
    Latency: 0 (750ns min, 250ns max)
    Interrupt: pin C routed to IRQ 10
    Region 0: Memory at ec002000 (32-bit, non-prefetchable) [size=256]
    Capabilities: [44] #0a [2080]
    Capabilities: [80] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.0 PCI bridge: nVidia Corporation: Unknown device 006c (rev a3) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
    Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
    Latency: 0
    Bus: primary=00, secondary=01, subordinate=02, sec-latency=32
    I/O behind bridge: 00008000-0000cfff
    Memory behind bridge: e8000000-ebffffff
    Prefetchable memory behind bridge: fff00000-000fffff
    BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2) (prog-if 8a [Master SecP PriP])
    Subsystem: Giga-byte Technology: Unknown device 5002
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
    Latency: 0 (750ns min, 250ns max)
    Region 4: I/O ports at f000 [size=16]
    Capabilities: [44] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
    Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
    Latency: 32
    Bus: primary=00, secondary=04, subordinate=04, sec-latency=32
    I/O behind bridge: 0000f000-00000fff
    Memory behind bridge: e6000000-e7ffffff
    Prefetchable memory behind bridge: d0000000-dfffffff
    BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

01:08.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev 04)
    Subsystem: Creative Labs CT4850 SBLive! Value
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
    Latency: 32 (500ns min, 5000ns max)
    Interrupt: pin A routed to IRQ 9
    Region 0: I/O ports at 9800 [size=32]
    Capabilities: [dc] Power Management version 1
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:08.1 Input device controller: Creative Labs SB Live! MIDI/Game Port (rev 01)
    Subsystem: Creative Labs Gameport Joystick
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
    Latency: 32
    Region 0: I/O ports at 9000 [size=8]
    Capabilities: [dc] Power Management version 1
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:09.0 Network controller: Linksys: Unknown device 8201 (rev 11)
    Subsystem: Abocom Systems Inc: Unknown device ab60
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
    Latency: 32 (16000ns min, 32000ns max), cache line size 10
    Interrupt: pin A routed to IRQ 10
    Region 0: I/O ports at 9400 [size=256]
    Region 1: Memory at eb020000 (32-bit, non-prefetchable) [size=1K]
    Expansion ROM at <unassigned> [disabled] [size=128K]
    Capabilities: [c0] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=100mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=2 PME+

01:0a.0 PCI bridge: Digital Equipment Corporation DECchip 21152 (rev 03) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
    Latency: 32, cache line size 08
    Bus: primary=01, secondary=02, subordinate=02, sec-latency=32
    I/O behind bridge: 00008000-00008fff
    Memory behind bridge: e9000000-eaffffff
    Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
    BridgeCtl: Parity- SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
    Capabilities: [dc] Power Management version 1
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=220mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Bridge: PM- B3+

02:04.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
    Subsystem: Phobos corporation: Unknown device 0430
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
    Latency: 32 (5000ns min, 10000ns max), cache line size 08
    Interrupt: pin A routed to IRQ 11
    Region 0: I/O ports at 8000 [size=128]
    Region 1: Memory at ea000000 (32-bit, non-prefetchable) [size=1K]
    Expansion ROM at <unassigned> [disabled] [size=256K]

02:05.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
    Subsystem: Phobos corporation: Unknown device 0430
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
    Latency: 32 (5000ns min, 10000ns max), cache line size 08
    Interrupt: pin A routed to IRQ 11
    Region 0: I/O ports at 8400 [size=128]
    Region 1: Memory at ea001000 (32-bit, non-prefetchable) [size=1K]
    Expansion ROM at <unassigned> [disabled] [size=256K]

02:06.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
    Subsystem: Phobos corporation: Unknown device 0430
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
    Latency: 32 (5000ns min, 10000ns max), cache line size 08
    Interrupt: pin A routed to IRQ 9
    Region 0: I/O ports at 8800 [size=128]
    Region 1: Memory at ea002000 (32-bit, non-prefetchable) [size=1K]
    Expansion ROM at <unassigned> [disabled] [size=256K]

02:07.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 41)
    Subsystem: Phobos corporation: Unknown device 0430
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
    Latency: 32 (5000ns min, 10000ns max), cache line size 08
    Interrupt: pin A routed to IRQ 10
    Region 0: I/O ports at 8c00 [size=128]
    Region 1: Memory at ea003000 (32-bit, non-prefetchable) [size=1K]
    Expansion ROM at <unassigned> [disabled] [size=256K]

04:00.0 VGA compatible controller: nVidia Corporation: Unknown device 0322 (rev a1) (prog-if 00 [VGA])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
    Latency: 248 (1250ns min, 250ns max)
    Interrupt: pin A routed to IRQ 11
    Region 0: Memory at e6000000 (32-bit, non-prefetchable) [size=16M]
    Region 1: Memory at d0000000 (32-bit, prefetchable) [size=256M]
    Expansion ROM at <unassigned> [disabled] [size=128K]
    Capabilities: [60] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [44] AGP version 3.0
        Status: RQ=32 Iso- ArqSz=0 Cal=3 SBA+ ITACoh- GART64- HTrans- 64bit- FW+ AGP3+ Rate=x4,x8
        Command: RQ=32 ArqSz=2 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=x8






__________________________________________________________________
Switch to Netscape Internet Service.
As low as $9.95 a month -- Sign up today at http://isp.netscape.com/register

Netscape. Just the Net You Need.

New! Netscape Toolbar for Internet Explorer
Search from anywhere on the Web and block those annoying pop-ups.
Download now at http://channels.netscape.com/ns/search/install.jsp
