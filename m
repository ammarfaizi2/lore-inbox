Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318145AbSHZMb6>; Mon, 26 Aug 2002 08:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318148AbSHZMb6>; Mon, 26 Aug 2002 08:31:58 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:32947 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S318145AbSHZMbx> convert rfc822-to-8bit; Mon, 26 Aug 2002 08:31:53 -0400
Content-Type: text/plain; charset=US-ASCII
From: h.grosenick@t-online.de (Holger Grosenick)
To: linux-kernel@vger.kernel.org
Subject: System freeze on 2.4.18 / 19 SMP
Date: Mon, 26 Aug 2002 14:36:43 +0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208261436.44030.hgrosenick@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

i have a reproducible system freeze using SuSE 8.0 with original kernel 2.4.19 
(same with SuSE 2.4.18 kernel).

Hardware:

Asus P2B-Dual with 2x PIII 700 MHz (Bios 1013 - current)
896 MB RAM
Promise PDC20267 off board IDE Controller (current bios release)
aic7880 scsi-controller for CD-writers
nvidia graphic card
RTL-8139A based network card

/dev/hda: _NEC DV-5700B DVD-ROM on piix onboard controller, ide0
/dev/hdc: IBM IC35L060AVVA07-0 on PDC20267 ide1
/dev/hdd: IBM IC35L080AVVA07-0 on PDC20267 ide1
/dev/hde: IBM IC35L060AVVA07-0 on PDC20267 ide2

So far I have had a complete system freeze once a month, but now i started the 
oracle installer and then this freeze happens within a minute during 
installation and can be reproduced. But the freeze does not always happen 
exactly at the same action. The system gets unstable first, so that for 
example a bash gets a "segementation violation". But then some seconds later 
the system will freeze and i have to power off.

I tried the following:

- run memtest86, everything OK
- stopped most of the other services
- started oracle installation from a remote X server, so that there is no 
XFree running on the SMP-mashine, only xdm without local X-server
- tried boot parameter "idex=serialize"
- tried ext3 and reiserfs as file system for the installation target partition

=> no changes, the system still freezes.

I haven't done any kernel programming so far, but i would be able to give more 
input, if someone has an idea what to do.

Holger Grosenick



partititions:
(The oracle installer copies data from hdc11 / reiser to hdd1 / ext3)
-------------------------------------------------------------

major minor  #blocks  name
  33     0   60051600 hde
  33     1      30208 hde1
  33     2    8192016 hde2
  33     3     660744 hde3
  33     4          1 hde4
  33     5    1570936 hde5
  33     6    1032664 hde6
  33     7    3584416 hde7
  33     8    4608040 hde8
  33     9    5120104 hde9
  33    10    1024096 hde10
  33    11   34228120 hde11
  22     0   60051600 hdc
  22     1      30208 hdc1
  22     2    8192016 hdc2
  22     3     660744 hdc3
  22     4          1 hdc4
  22     5    1570936 hdc5
  22     6    1032664 hdc6
  22     7    3584416 hdc7
  22     8    4608040 hdc8
  22     9    5120104 hdc9
  22    10    1024096 hdc10
  22    11   34228120 hdc11
  22    64   80418240 hdd
  22    65   80418208 hdd1

interrups
-----------------------------------------------------------

           CPU0       CPU1       
  0:     147718     151530    IO-APIC-edge  timer
  1:       2646       2683    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  4:      26150      26083    IO-APIC-edge  serial
  5:       1662       1359    IO-APIC-edge  SoundBlaster
 11:      14748      14638   IO-APIC-level  ide1, ide2, usb-uhci
 12:        171        165   IO-APIC-level  aic7xxx
 14:          4          2    IO-APIC-edge  ide0
 15:       5609       5383   IO-APIC-level  eth0
NMI:          0          0 
LOC:     299187     299066 
ERR:          0
MIS:          0


lspci -vvv
-----------------------------------------------------------

00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge (rev 
03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ 
FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >
SERR- <PERR-
        Latency: 64
        Region 0: Memory at e4000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge (rev 
03) (prog-if 00 
[Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ 
FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >
SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000e000-0000dfff
        Memory behind bridge: e0000000-e1dfffff
        Prefetchable memory behind bridge: e1f00000-e3ffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B+

00:04.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- 
FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >
SERR- <PERR-
        Latency: 0

00:04.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 
80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- 
FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >
SERR- <PERR-
        Latency: 0
        Region 4: I/O ports at d800 [size=16]

00:04.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 
00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- 
FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >
SERR- <PERR-
        Latency: 64
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at d400 [size=32]

00:04.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- 
FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >
SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:09.0 Unknown mass storage controller: Promise Technology, Inc. 20267 (rev 
02)
        Subsystem: Promise Technology, Inc. Ultra100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- 
FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >
SERR- <PERR-
        Latency: 0
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at d000 [size=8]
        Region 1: I/O ports at b800 [size=4]
        Region 2: I/O ports at b400 [size=8]
        Region 3: I/O ports at b000 [size=4]
        Region 4: I/O ports at a800 [size=64]
        Region 5: Memory at df800000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [58] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- 
FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >
SERR- <PERR-
        Latency: 64 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 15
        Region 0: I/O ports at a400 [size=256]
        Region 1: Memory at df000000 (32-bit, non-prefetchable) [size=256]
00:0b.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U (rev 01)
        Subsystem: Adaptec AHA-2940UW SCSI Host Adapter
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- 
FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >
SERR- <PERR-
        Latency: 64 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 12
        Region 0: I/O ports at a000 [disabled] [size=256]
        Region 1: Memory at de800000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation Vanta [NV6] (rev 15) 
(prog-if 00 [VGA]
)
        Subsystem: Elsa AG: Unknown device 0c3a
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- 
FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >
SERR- <PERR-
        Latency: 64 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at e2000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at e1ff0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=31 SBA- 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>


module-list, all compiled for the current kernel release,
no high memory support
---------------------------------------------------------------
snd-pcm-oss            35364   0 (autoclean)
snd-mixer-oss           9312   1 (autoclean)
snd-seq-midi            3168   0 (autoclean) (unused)
snd-emu8000-synth       4804   0 (autoclean)
snd-emux-synth         24064   0 (autoclean) [snd-emu8000-synth]
snd-seq-virmidi         2664   0 (autoclean) [snd-emux-synth]
snd-util-mem            1088   0 (autoclean) [snd-emu8000-synth 
snd-emux-synth]
snd-seq-oss            24896   0 (autoclean)
snd-seq-midi-event      2744   0 (autoclean) [snd-seq-midi snd-seq-virmidi 
snd-seq-oss]
snd-opl3-synth          8732   0
snd-seq-instr           4608   0 [snd-opl3-synth]
snd-seq-midi-emul       4192   0 [snd-emux-synth snd-opl3-synth]
snd-seq                39500   2 [snd-seq-midi snd-emux-synth snd-seq-virmidi 
snd-seq-oss snd-seq-midi-event snd-opl3-synth snd-seq-instr 
snd-seq-midi-emul]
snd-ainstr-fm           1460   0 [snd-opl3-synth]
snd-sbawe              16096   1 [snd-emu8000-synth]
snd-sb16-dsp            5888   0 [snd-sbawe]
snd-pcm                46816   0 [snd-pcm-oss snd-sb16-dsp]
snd-sb16-csp           15776   0 [snd-sbawe]
snd-sb-common           6248   0 [snd-sbawe snd-sb16-dsp snd-sb16-csp]
snd-opl3-lib            5408   0 [snd-opl3-synth snd-sbawe]
snd-hwdep               3648   0 [snd-sb16-csp snd-opl3-lib]
snd-timer              10496   0 [snd-seq snd-pcm snd-opl3-lib]
snd-mpu401-uart         2864   0 [snd-sbawe snd-sb16-dsp]
snd-rawmidi            12288   0 [snd-seq-midi snd-seq-virmidi 
snd-mpu401-uart]
snd-seq-device          3952   0 [snd-seq-midi snd-emu8000-synth 
snd-emux-synth snd-seq-oss snd-opl3-synth snd-seq snd-sbawe snd-opl3-lib 
snd-rawmidi]
snd                    25224   0 [snd-pcm-oss snd-mixer-oss snd-seq-midi 
snd-emu8000-synth snd-emux-synth snd-seq-virmidi snd-util-mem snd-seq-oss 
snd-seq-midi-event snd-opl3-synth snd-seq-instr snd-seq snd-sbawe 
snd-sb16-dsp snd-pcm snd-sb16-csp snd-sb-common snd-opl3-lib snd-hwdep 
snd-timer snd-mpu401-uart snd-rawmidi snd-seq-device]
soundcore               3396  10 [snd]
isa-pnp                27580   0 [snd-sbawe]
sr_mod                 12888   0 (autoclean)
sg                     25156   0 (autoclean)
uhci                   24968   0 (unused)
usbcore                55296   1 [uhci]
8139too                13984   1
reiserfs              157504   1 (autoclean)

