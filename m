Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261637AbSITIIS>; Fri, 20 Sep 2002 04:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261653AbSITIIR>; Fri, 20 Sep 2002 04:08:17 -0400
Received: from cpe-024-024-103-044.midsouth.rr.com ([24.24.103.44]:8695 "EHLO
	braindead") by vger.kernel.org with ESMTP id <S261637AbSITIIE>;
	Fri, 20 Sep 2002 04:08:04 -0400
From: Warren Turkal <wturkal@cbu.edu>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: maestro3 driver for linux
Date: Fri, 20 Sep 2002 03:12:59 -0500
User-Agent: KMail/1.4.6
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200209200309.04741.wturkal@cbu.edu>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not sure if this is the right place to send this to, but I cannot get my 
maestro3/allegro (ESS1988) sound card working with the alsa or oss from 
2.5.34 kernel (The newer ones oops on me before getting to init). The Alsa 
driver does not even appear to detect the card although it will load. Playing 
a wav causes a deadlock that does not allow the process to be killed.
Thanks, Warren

keywords: allegro, maestro, sound, oss, alsa

If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux braindead 2.5.33 #1 SMP Thu Sep 19 19:34:37 CDT 2002 i686 unknown 
unknown GNU/Linux

Gnu C                  2.95.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.19
e2fsprogs              1.28
pcmcia-cs              3.2.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.1
Modules Loaded         ds yenta_socket pcmcia_core hid wacom uhci-hcd maestro3 
ac97_codec floppy thermal processor fan button battery ac microcode msr cpuid 
mousedev joydev evdev video1394 ohci1394 ieee1394 parport_pc lp ppdev parport 
nvram rtc

After loading the alsa driver (snd-maestro3), "wavp 
/usr/share/sound/KDE_Startup.wav" deadlocks the process. It doesn't lock up 
the whole box. I just cannot kill the process, even via kill -9.

wt@braindead:/usr/src/linux-2.5.36$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : 00/02
stepping        : 4
cpu MHz         : 1894.604
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat 
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 3735.55

wt@braindead:/usr/src/linux-2.5.36$ cat /proc/modules
ds                      6712   2
yenta_socket            9376   2
pcmcia_core            40384   0 [ds yenta_socket]
hid                    17800   0 (unused)
wacom                   4372   0 (unused)
uhci-hcd               23936   0 (unused)
maestro3               26336   0
ac97_codec              9672   0 [maestro3]
floppy                 45820   0 (autoclean)
thermal                 6272   0 (unused)
processor               9164   0 [thermal]
fan                     1600   0 (unused)
button                  2348   0 (unused)
battery                 6016   0 (unused)
ac                      1792   0 (unused)
microcode               3904   0 (unused)
msr                     1784   0 (unused)
cpuid                   1368   0 (unused)
mousedev                4628   1
joydev                  6656   0 (unused)
evdev                   5716   0 (unused)
video1394              14096   0 (unused)
ohci1394               16828   0 [video1394]
ieee1394               33676   0 [video1394 ohci1394]
parport_pc             22856   1 (autoclean)
lp                      6304   0
ppdev                   6972   0 (unused)
parport                27616   1 [parport_pc lp ppdev]
nvram                   5380   0 (unused)
rtc                     8108   0 (autoclean)

wt@braindead:/usr/src/linux-2.5.36$ sudo lspci -vvv
00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge 
(rev 04)
        Subsystem: Gateway 2000: Unknown device 0600
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at ec000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [e4] #09 [d104]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2,x4
                Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x1

00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 
04) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 96
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 00003000-00003fff
        Memory behind bridge: e8100000-e81fffff
        Prefetchable memory behind bridge: f0000000-f7ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:1d.0 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #1) (rev 02) (prog-if 
00 [UHCI])
        Subsystem: Gateway 2000: Unknown device 0600
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 10
        Region 4: I/O ports at 1800 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801CA/CAM USB (Hub #2) (rev 02) (prog-if 
00 [UHCI])
        Subsystem: Gateway 2000: Unknown device 0600
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 5
        Region 4: I/O ports at 1820 [size=32]

00:1e.0 PCI bridge: Intel Corp. 82801BAM/CAM PCI Bridge (rev 42) (prog-if 00 
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
        I/O behind bridge: 00004000-00005fff
        Memory behind bridge: e8200000-e87fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:1f.0 ISA bridge: Intel Corp. 82801CAM ISA Bridge (LPC) (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:1f.1 IDE interface: Intel Corp. 82801CAM IDE U100 (rev 02) (prog-if 8a 
[Master SecP PriP])
        Subsystem: Gateway 2000: Unknown device 0600
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 01f0
        Region 1: I/O ports at 03f4
        Region 2: I/O ports at 0170
        Region 3: I/O ports at 0374
        Region 4: I/O ports at 1860 [size=16]
        Region 5: Memory at e8000000 (32-bit, non-prefetchable) [size=1K]

00:1f.3 SMBus: Intel Corp. 82801CA/CAM SMBus (rev 02)
        Subsystem: Gateway 2000: Unknown device 0600
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 10
        Region 4: I/O ports at 1880 [size=32]

00:1f.6 Modem: Intel Corp. 82801CA/CAM AC'97 Modem (rev 02) (prog-if 00 
[Generic])
        Subsystem: Askey Computer Corp.: Unknown device 1050
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 10
        Region 0: I/O ports at 2000 [size=256]
        Region 1: I/O ports at 1c00 [size=128]

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility M7 LW 
(prog-if 00 [VGA])
        Subsystem: Gateway 2000: Unknown device 0600
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR+ FastB2B+
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Region 1: I/O ports at 3000 [size=256]
        Region 2: Memory at e8100000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=47 SBA+ 64bit- FW- Rate=x1,x2,x4
                Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x1
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:02.0 CardBus bridge: Texas Instruments: Unknown device ac55 (rev 01)
        Subsystem: Gateway 2000: Unknown device 0600
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 20
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e8204000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=02, secondary=03, subordinate=06, sec-latency=176
        Memory window 0: e8400000-e87ff000 (prefetchable)
        Memory window 1: 00000000-00000000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

02:02.1 CardBus bridge: Texas Instruments: Unknown device ac55 (rev 01)
        Subsystem: Gateway 2000: Unknown device 0600
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 20
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e8205000 (32-bit, non-prefetchable) [size=4K]
        Bus: primary=02, secondary=07, subordinate=0a, sec-latency=176
        Memory window 0: 00000000-00000000 (prefetchable)
        Memory window 1: 00000000-00000000
        I/O window 0: 00004800-000048ff
        I/O window 1: 00004c00-00004cff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+ PostWrite+
        16-bit legacy interface ports at 0001

02:03.0 Multimedia audio controller: ESS Technology ES1988 Allegro-1 (rev 12)
        Subsystem: Gateway 2000: Unknown device 0600
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at 5000 [size=256]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:05.0 FireWire (IEEE 1394): Texas Instruments TSB43AB21 IEEE-1394 Controller 
(PHY/Link) 1394a-2000 (prog-if 10 [OHCI])
        Subsystem: Gateway 2000: Unknown device 0600
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (500ns min, 1000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e8207000 (32-bit, non-prefetchable) [size=2K]
        Region 1: Memory at e8200000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

02:08.0 Ethernet controller: Intel Corp. 82801CAM (ICH3) Chipset Ethernet 
Controller (rev 42)
        Subsystem: Gateway 2000: Unknown device 0600
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e8206000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at 5400 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-



-- 
Treasurer, GOLUM, Inc.
http://www.golum.org

