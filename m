Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315206AbSENFuZ>; Tue, 14 May 2002 01:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315210AbSENFuY>; Tue, 14 May 2002 01:50:24 -0400
Received: from mallaury.noc.nerim.net ([62.4.17.82]:14085 "HELO
	mallaury.noc.nerim.net") by vger.kernel.org with SMTP
	id <S315206AbSENFuV>; Tue, 14 May 2002 01:50:21 -0400
Message-ID: <3CE0A52E.F081EBB7@hotmail.com>
Date: Tue, 14 May 2002 07:48:30 +0200
From: "David A. Kosower" <kosower@hotmail.com>
Organization: e-hub1 
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-31 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: System Freeze
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While the incidents I will describe are most likely evidence of bugs in
several software systems, I need some suggestions on how to track it
down.

Brief description: System hangs (freezes) completely.  It does not
respond to any keyboard presses, mouse movement or button clicks.
Indeed, it won't even allow turning off the laptop using the power
button (use of emergency shutdown relay is necessary).   Needless to
say, the filesystem has to be manually cleaned every time, and even once
or twice a week is too much in my opinion.

The problem occurs sporadically when netscape (4.78-2) tries to fetch a
"complicated" page.  It does not occur reproducibly on any given page.
A similar problem occurs so frequently with mozilla
(mozilla-2002032709_trunk-0_rh7) as to render the latter unusable.  The
system -- a Dell Inspiron 3500 -- is running Redhat 7.2
(kernel-2.4.9-31), and is connected to the net via an ethernet
PCMCIA talking to an Alcatel 1000 ADSL (which then obviously connects
via ADSL).  Presumably this is also a sign of bugs in mozilla, but in
any event whatever mozilla is doing should not trigger this.  There are
no messages in /var/log/messages.

Supplementary information:

# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 6
model name      : Mobile Pentium II
stepping        : 10
cpu MHz         : 330.881
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 mmx fxsr
bogomips        : 660.27

# cat /proc/modules
ppp_deflate            39104   0 (autoclean)
bsd_comp                4224   0 (autoclean)
ppp_async               6848   1 (autoclean)
ppp_generic            19336   3 (autoclean) [ppp_deflate bsd_comp
ppp_async]
slhc                    5056   0 (autoclean) [ppp_generic]
autofs                 11300   0 (autoclean) (unused)
nfs                    78432   1 (autoclean)
nfsd                   69664   8 (autoclean)
lockd                  52032   1 (autoclean) [nfs nfsd]
sunrpc                 62832   1 (autoclean) [nfs nfsd lockd]
serial_cs               4608   0 (unused)
pcnet_cs                9700   1
8390                    6176   0 [pcnet_cs]
ds                      6816   2 [serial_cs pcnet_cs]
yenta_socket            9024   2
pcmcia_core            39424   0 [serial_cs pcnet_cs ds yenta_socket]
nls_iso8859-1           2784   1 (autoclean)
nls_cp437               4320   1 (autoclean)
vfat                    9692   1 (autoclean)
fat                    32088   0 (autoclean) [vfat]
ext3                   59872   1 (autoclean)
jbd                    39108   1 (autoclean) [ext3]
usb-uhci               20708   0 (unused)
usbcore                49920   1 [usb-uhci]

# cat /proc/ioports
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
02f8-02ff : serial(set)
0320-033f : pcnet_cs
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
2180-219f : Intel Corporation 82371AB PIIX4 ACPI
4000-40ff : PCI CardBus #02
4400-44ff : PCI CardBus #02
4800-48ff : PCI CardBus #06
4c00-4cff : PCI CardBus #06
8000-803f : Intel Corporation 82371AB PIIX4 ACPI
fcd0-fcdf : Intel Corporation 82371AB PIIX4 IDE
  fcd0-fcd7 : ide0
  fcd8-fcdf : ide1
fce0-fcff : Intel Corporation 82371AB PIIX4 USB
  fce0-fcff : usb-uhci

# cat /proc/iomem
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-0bfeffff : System RAM
  00100000-002b316a : Kernel code
  002b316b-002c9d4b : Kernel data
0bff0000-0bfffbff : ACPI Tables
0bfffc00-0bffffff : ACPI Non-volatile Storage
10000000-10000fff : Texas Instruments PCI1220
10001000-10001fff : Texas Instruments PCI1220 (#2)
10400000-107fffff : PCI CardBus #02
10800000-10bfffff : PCI CardBus #02
10c00000-10ffffff : PCI CardBus #06
11000000-113fffff : PCI CardBus #06
a0000000-a0000fff : card services
e0000000-e3ffffff : Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
fd000000-fe3fffff : PCI Bus #01
  fd000000-fdffffff : Neomagic Corporation [MagicMedia 256AV]
  fe000000-fe3fffff : Neomagic Corporation [MagicMedia 256AV Audio]
fe700000-fecfffff : PCI Bus #01
  fe700000-fe7fffff : Neomagic Corporation [MagicMedia 256AV Audio]
  fe800000-febfffff : Neomagic Corporation [MagicMedia 256AV]
  fec00000-fecfffff : Neomagic Corporation [MagicMedia 256AV]
fffeb000-ffffffff : reserved

# /sbin/lspci -vvv
00:00.0 Host bridge: Intel Corporation 440BX/ZX - 82443BX/ZX Host bridge
(rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440BX/ZX - 82443BX/ZX AGP bridge
(rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fe700000-fecfffff
        Prefetchable memory behind bridge: fd000000-fe3fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B+

00:04.0 CardBus bridge: Texas Instruments PCI1220 (rev 02)
        Subsystem: Dell Computer Corporation: Unknown device 008f
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 04
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 10000000 (32-bit, non-prefetchable)
[size=4K]
        Bus: primary=00, secondary=02, subordinate=05, sec-latency=176
        Memory window 0: 10400000-107ff000 (prefetchable)
        Memory window 1: 10800000-10bff000
        I/O window 0: 00004000-000040ff
        I/O window 1: 00004400-000044ff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+
PostWrite+
        16-bit legacy interface ports at 0001

00:04.1 CardBus bridge: Texas Instruments PCI1220 (rev 02)
        Subsystem: Dell Computer Corporation: Unknown device 008f
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 168, cache line size 04
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at 10001000 (32-bit, non-prefetchable)
[size=4K]
        Bus: primary=00, secondary=06, subordinate=09, sec-latency=176
        Memory window 0: 10c00000-10fff000 (prefetchable)
        Memory window 1: 11000000-113ff000
        I/O window 0: 00004800-000048ff
        I/O window 1: 00004c00-00004cff
        BridgeCtl: Parity- SERR- ISA- VGA- MAbort- >Reset+ 16bInt+
PostWrite+
        16-bit legacy interface ports at 0001

00:07.0 Bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at fcd0 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin D routed to IRQ 10
        Region 4: I/O ports at fce0 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

01:00.0 VGA compatible controller: Neomagic Corporation [MagicMedia
256AV] (rev 20) (prog-if 00 [VGA])
        Subsystem: Dell Computer Corporation: Unknown device 008f
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B+
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 128 (4000ns min, 63750ns max)
        Interrupt: pin A routed to IRQ 0
        Region 0: Memory at fd000000 (32-bit, prefetchable) [size=16M]
        Region 1: Memory at fe800000 (32-bit, non-prefetchable)
[size=4M]
        Region 2: Memory at fec00000 (32-bit, non-prefetchable)
[size=1M]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.1 Multimedia audio controller: Neomagic Corporation [MagicMedia
256AV Audio] (rev 20)
        Subsystem: Dell Computer Corporation MagicMedia 256AV Audio
Device on Colorado Inspiron
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B+
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin B routed to IRQ 11
        Region 0: Memory at fe000000 (32-bit, prefetchable) [size=4M]
        Region 1: Memory at fe700000 (32-bit, non-prefetchable)
[size=1M]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Sincerely

David A. Kosower


