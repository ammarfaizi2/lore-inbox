Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267146AbSK2UNb>; Fri, 29 Nov 2002 15:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267145AbSK2UNa>; Fri, 29 Nov 2002 15:13:30 -0500
Received: from mk-smarthost-2.mail.uk.tiscali.com ([212.74.114.38]:51978 "EHLO
	mk-smarthost-2.mail.uk.tiscali.com") by vger.kernel.org with ESMTP
	id <S267143AbSK2UNU>; Fri, 29 Nov 2002 15:13:20 -0500
Subject: UDMA causes IDE corruption on Shuttle AK32L mobo (VIA KT266A),
	kernel 2.4.1[89]
From: Jim Halfpenny <jimvin@lineone.net>
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8-3mdk 
Date: 29 Nov 2002 20:15:01 +0000
Message-Id: <1038600903.2074.2.camel@fox>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm experiencing corrupted writes to IDE disks using a Shuttle AK32
V2.1 motherboard, Athlon XP1800+, 256Mb DDR RAM when DMA is enabled.
Disabling DMA using `hdparm -d0 /dev/hda` fixes this. I have tried
two different hard disks, so I don't think that it is a fault with
the drive itself.

I have seen the behaviour using the stock 2.4.18 kernel from Mandrake
8.2. and the 2.4.19 kernel from Mandrake 9.0:
Linux version 2.4.19-16mdk (quintela@bi.mandrakesoft.com) (gcc version
3.2 (Mandrake Linux 9.0 3.2-1mdk)) #1 Fri Sep 20 18:15:05 CEST 2002

There are no log entries in /var/log/messages or /var/log/syslog when
these faulty writes take place to indicate that there are any problems
but copying a large file and checking it's md5sum shows it to be
damaged.

Below is the output of various commands / logs which may be relevant.

Regards,
Jim Halfpenny

########################

Startup log messages (/var/log/messages):
Nov 24 12:24:47 fox kernel: ide: Assuming 33MHz system bus speed for PIO
modes; override with idebus=xx
Nov 24 12:24:47 fox kernel: VP_IDE: IDE controller on PCI bus 00 dev 89
Nov 24 12:24:47 fox kernel: PCI: No IRQ known for interrupt pin A of
device 00:11.1. Please try using pci=biosirq.
Nov 24 12:24:47 fox kernel: VP_IDE: chipset revision 6
Nov 24 12:24:47 fox kernel: VP_IDE: not 100%% native mode: will probe
irqs later
Nov 24 12:24:47 fox kernel: VP_IDE: VIA vt8233 (rev 00) IDE UDMA100
controller on pci00:11.1
Nov 24 12:24:47 fox kernel:     ide0: BM-DMA at 0xe000-0xe007, BIOS
settings: hda:DMA, hdb:pio
Nov 24 12:24:47 fox kernel:     ide1: BM-DMA at 0xe008-0xe00f, BIOS
settings: hdc:DMA, hdd:DMA
Nov 24 12:24:47 fox kernel: hda: FUJITSU MPD3130AT, ATA DISK drive
Nov 24 12:24:47 fox kernel: hdc: YAMAHA CRW8824E, ATAPI CD/DVD-ROM drive
Nov 24 12:24:47 fox kernel: hdd: MATSHITADVD-ROM SR-8585, ATAPI
CD/DVD-ROM drive
Nov 24 12:24:47 fox kernel: ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Nov 24 12:24:47 fox kernel: ide1 at 0x170-0x177,0x376 on irq 15
Nov 24 12:24:47 fox kernel: hda: 25431840 sectors (13021 MB) w/512KiB
Cache, CHS=2909/141/62, UDMA(66)
Nov 24 12:24:47 fox kernel: Partition check:
Nov 24 12:24:47 fox kernel:  /dev/ide/host0/bus0/target0/lun0:<6> [PTBL]
[1583/255/63] p1 p2

########################

$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) XP 1800+
stepping        : 2
cpu MHz         : 1535.230
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3060.53

########################

$ cat /proc/ide/via (With DMA disabled for /dev/hda)
----------VIA BusMastering IDE Configuration----------------
Driver Version:                     3.34
South Bridge:                       VIA vt8233
Revision:                           ISA 0x0 IDE 0x6
Highest DMA rate:                   UDMA100
BM-DMA base:                        0xe000
PCI clock:                          33.3MHz
Master Read  Cycle IRDY:            0ws
Master Write Cycle IRDY:            0ws
BM IDE Status Register Read Retry:  yes
Max DRDY Pulse Width:               No limit
-----------------------Primary IDE-------Secondary IDE------
Read DMA FIFO flush:          yes                 yes
End Sector FIFO flush:         no                  no
Prefetch Buffer:              yes                 yes
Post Write Buffer:            yes                 yes
Enabled:                      yes                 yes
Simplex only:                  no                  no
Cable Type:                   80w                 40w
-------------------drive0----drive1----drive2----drive3-----
Transfer Mode:        PIO       PIO       PIO       PIO
Address Setup:       30ns     120ns      30ns      30ns
Cmd Active:          90ns      90ns      90ns      90ns
Cmd Recovery:        30ns      30ns      30ns      30ns
Data Active:         90ns     330ns      90ns      90ns
Data Recovery:       30ns     270ns      30ns      30ns
Cycle Time:         120ns     600ns     120ns     120ns
Transfer Rate:   16.6MB/s   3.3MB/s  16.6MB/s  16.6MB/s

########################

$ cat /proc/modules
floppy                 49340   0 (autoclean)
snd-seq-midi            3680   0 (autoclean) (unused)
snd-emu10k1-synth       4220   0 (autoclean) (unused)
snd-emux-synth         25532   0 (autoclean) [snd-emu10k1-synth]
snd-seq-midi-emul       4880   0 (autoclean) [snd-emux-synth]
snd-seq-virmidi         2888   0 (autoclean) [snd-emux-synth]
snd-seq-oss            26176   0 (unused)
snd-seq-midi-event      3208   0 [snd-seq-midi snd-seq-virmidi
snd-seq-oss]
snd-seq                33264   2 [snd-seq-midi snd-emux-synth
snd-seq-midi-emul snd-seq-virmidi snd-seq-oss snd-seq-midi-event]
snd-pcm-oss            36932   0
snd-mixer-oss           9016   1 [snd-pcm-oss]
snd-emu10k1            56592   1 [snd-emu10k1-synth]
snd-pcm                55808   0 [snd-pcm-oss snd-emu10k1]
snd-timer               9964   0 [snd-seq snd-pcm]
snd-util-mem            1280   0 [snd-emux-synth snd-emu10k1]
snd-rawmidi            12864   0 [snd-seq-midi snd-seq-virmidi
snd-emu10k1]
snd-seq-device          3836   0 [snd-seq-midi snd-emu10k1-synth
snd-emux-synth snd-seq-oss snd-seq snd-emu10k1 snd-rawmidi]
snd-ac97-codec         25508   0 [snd-emu10k1]
snd-hwdep               3840   0 [snd-emu10k1]
snd                    24804   0 [snd-seq-midi snd-emux-synth
snd-seq-virmidi snd-seq-oss snd-seq-midi-event snd-seq snd-pcm-oss
snd-mixer-oss snd-emu10k1 snd-pcm snd-timer snd-util-mem snd-rawmidi
snd-seq-device snd-ac97-codec snd-hwdep]
soundcore               3780   0 [snd]
ppp_async               7456   0 (unused)
ppp_generic            20064   0 [ppp_async]
slhc                    5072   0 [ppp_generic]
af_packet              13000   0 (autoclean)
8139too                14472   1 (autoclean)
mii                     1152   0 (autoclean) [8139too]
supermount             14340   1 (autoclean)
isofs                  25652   0 (autoclean)
inflate_fs             17892   0 (autoclean) [isofs]
sr_mod                 15096   0 (autoclean)
ide-cd                 28712   0
cdrom                  26848   0 [sr_mod ide-cd]
ide-scsi                8212   0
usb-uhci               21676   0 (unused)
usbcore                58304   1 [usb-uhci]
rtc                     6560   0 (autoclean)
reiserfs              169776   5
sd_mod                 11612   8
eata                   20472   4
scsi_mod               91140   4 [sr_mod ide-scsi sd_mod eata]

########################

$ cat /proc/ioports
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
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
d000-d01f : Distributed Processing Technology SmartCache/Raid I-IV
Controller
  d010-d018 : EATA
d400-d4ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C
  d400-d4ff : 8139too
d800-d81f : Creative Labs SB Live! EMU10k1
  d800-d81f : EMU10K1
dc00-dc07 : Creative Labs SB Live! MIDI/Game Port
e000-e00f : VIA Technologies, Inc. Bus Master IDE
  e000-e007 : ide0
  e008-e00f : ide1
e400-e41f : VIA Technologies, Inc. UHCI USB
  e400-e41f : usb-uhci
e800-e81f : VIA Technologies, Inc. UHCI USB (#2)
  e800-e81f : usb-uhci
ec00-ec1f : VIA Technologies, Inc. UHCI USB (#3)
  ec00-ec1f : usb-uhci



$ cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000ccfff : Extension ROM
000f0000-000fffff : System ROM
00100000-0fffffff : System RAM
  00100000-0022614c : Kernel code
  0022614d-0029547f : Kernel data
e0000000-e3ffffff : VIA Technologies, Inc. VT8367 [KT266]
e4000000-e5ffffff : PCI Bus #01
  e4000000-e5ffffff : nVidia Corporation Vanta [NV6]
    e4000000-e4ffffff : vesafb
e6000000-e7ffffff : PCI Bus #01
  e6000000-e6ffffff : nVidia Corporation Vanta [NV6]
e9000000-e90000ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C
  e9000000-e90000ff : 8139too
ffff0000-ffffffff : reserved



# lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT8367 [KT266]
        Subsystem: VIA Technologies, Inc. VT8367 [KT266]
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR+
        Latency: 8
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2,x4
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8367 [KT266 AGP] (prog-if
00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: e6000000-e7ffffff
        Prefetchable memory behind bridge: e4000000-e5ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 SCSI storage controller: Distributed Processing Technology
SmartCache/Raid I-IV Controller (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        BIST result: 00
        Region 0: I/O ports at d000 [size=32]
        Expansion ROM at <unassigned> [disabled] [size=32K]

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C (rev 10)
        Subsystem: Realtek Semiconductor Co., Ltd. RT8139
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at d400 [size=256]
        Region 1: Memory at e9000000 (32-bit, non-prefetchable)
[size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
07)
        Subsystem: Creative Labs CT4780 SBLive! Value
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (500ns min, 5000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at d800 [size=32]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.1 Input device controller: Creative Labs SB Live! MIDI/Game Port
(rev 07)
        Subsystem: Creative Labs Gameport Joystick
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 0: I/O ports at dc00 [size=8]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
        Subsystem: VIA Technologies, Inc. VT8233 PCI to ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
        Subsystem: VIA Technologies, Inc. Bus Master IDE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 0
        Region 4: I/O ports at e000 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.2 USB Controller: VIA Technologies, Inc. USB (rev 1b) (prog-if 00
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 9
        Region 4: I/O ports at e400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.3 USB Controller: VIA Technologies, Inc. USB (rev 1b) (prog-if 00
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 9
        Region 4: I/O ports at e800 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.4 USB Controller: VIA Technologies, Inc. USB (rev 1b) (prog-if 00
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 9
        Region 4: I/O ports at ec00 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: nVidia Corporation NV6 [Vanta] (rev
15) (prog-if 00 [VGA])
        Subsystem: Micro-star International Co Ltd MSI-8808
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e6000000 (32-bit, non-prefetchable)
[size=16M]
        Region 1: Memory at e4000000 (32-bit, prefetchable) [size=32M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [60] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [44] AGP version 2.0
                Status: RQ=31 SBA- 64bit- FW- Rate=x1,x2,x4
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>


