Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263590AbTKKSxW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 13:53:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263632AbTKKSxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 13:53:22 -0500
Received: from av8.netikka.fi ([213.250.83.8]:59275 "EHLO mail.linuxvaasa.com")
	by vger.kernel.org with ESMTP id S263590AbTKKSxC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 13:53:02 -0500
Message-ID: <3FB1300B.8060806@netikka.fi>
Date: Tue, 11 Nov 2003 20:52:59 +0200
From: Johnny Strom <jonny.strom@netikka.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: sv, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: System freezes with 2.4.23-pre7 and later kernels.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello

It seems that I have encountered a bttv problem that is 100%
repeatable.

What happens is that the system freezes and the keyboard
lights are flashing if I press the preview button in Gnomemeeting or
if I start to send video from the bttv card over the network.

My system:

- Fedora core 1
- gnomemeeting-0.98.5-1
- pwlib-1.5.0-2 (used for low level access bye gnomemeeting)
- kernel 2.4.23-pre9
- gcc version 3.3.2


What I have tried is that with the original Fedora kernel and up to
2.4.23-pre5 so does Gnomemeeting work ok, but after 2.4.23-pre7
so dose the system freeze when gnomemeeting is accessing the video 
device, xawtv works without any problems.

So it seems that it might be these bttv driver changes below that causes 
the problem for me:

   o v4l i2c modules update
   o bttv driver update
   o bttv documentation update
   o Tuner update
   o videodev update


When the system is oopsing or freezing so do I get this in the system log:

bttv0: irq: OCERR risc_count=2fd87020
bttv0: irq: SCERR risc_count=2fd87020
bttv0: irq: OCERR risc_count=2fd87020
bttv0: irq: SCERR risc_count=2fd87020
bttv0: irq: SCERR risc_count=2fd87020
bttv0: aiee: error loops
bttv0: resetting chip
bttv0: PLL: 28636363 => 35468950 .. ok


Or like this:

  bttv0: irq: OCERR risc_count=2fd87020
  bttv0: irq: SCERR risc_count=2fd87020
  bttv0: irq: SCERR risc_count=2fd87020
  bttv0: irq: OCERR risc_count=2fd87020
  bttv0: irq: SCERR risc_count=2fd87020
  bttv0: aiee: error loops
  bttv0: irq: SCERR risc_count=2fd6c014
  bttv0: aiee: error loops
  bttv0: resetting chip
  bttv0: PLL: 28636363 => 35468950 .. ok





Some information about my system, I have compiled everything into the
kernel:

Boot message:
kernel: i2c-core.o: i2c core module
kernel: Linux video capture interface: v1.00
kernel: i2c-algo-bit.o: i2c bit algorithm module
kernel: bttv: driver version 0.7.107 loaded
kernel: bttv: using 4 buffers with 2080k (8320k total) for capture
kernel: bttv: Host bridge is VIA Technologies, Inc. VT8363/8365
[KT133/KM133]
kernel: bttv: Bt8xx card found (0).
kernel: PCI: Found IRQ 10 for device 00:0b.0
kernel: PCI: Sharing IRQ 10 with 00:07.2
kernel: PCI: Sharing IRQ 10 with 00:07.3
kernel: PCI: Sharing IRQ 10 with 00:0b.1
kernel: bttv0: Bt878 (rev 17) at 00:0b.0, irq: 10, latency: 32, mmio:
0xeb000000
kernel: bttv0: detected: Hauppauge WinTV [card=10], PCI subsystem ID is
0070:13eb
kernel: bttv0: using: BT878(Hauppauge (bt878)) [card=10,autodetected]
kernel: bttv0: Hauppauge/Voodoo msp34xx: reset line init [5]
kernel: i2c-core.o: adapter bt848 #0 registered as adapter 0.
kernel: bttv0: Hauppauge eeprom: model=44344, tuner=Philips FI1216 MK2
(5), radio=no
kernel: bttv0: using tuner=5
kernel: bttv0: i2c: checking for MSP34xx @ 0x80... found
kernel: i2c-core.o: driver i2c msp3400 driver registered.
kernel: msp34xx: init: chip=MSP3415D-B3 +nicam +simple
kernel: msp3410: daemon started
modprobe: modprobe: Can't locate module char-major-81-1
kernel: i2c-core.o: client [MSP3415D-B3] registered to adapter [bt848
#0](pos. 0).
kernel: bttv0: i2c: checking for TDA9875 @ 0xb0... not found
kernel: bttv0: i2c: checking for TDA7432 @ 0x8a... not found
kernel: tvaudio: TV audio decoder + audio/video mux driver
kernel: tvaudio: known chips:
tda9840,tda9873h,tda9874h/a,tda9850,tda9855,tea6300,tea6420,tda8425,pic1
6c54 (PV951),ta8874z
kernel: i2c-core.o: driver generic i2c audio driver registered.
kernel: i2c-core.o: driver i2c TV tuner driver registered.
kernel: tuner: chip found @ 0xc2
kernel: tuner: type set to 5 (Philips PAL_BG (FI1216 and compatibles))
kernel: i2c-core.o: client [Philips PAL_BG (FI1216 and comp] registered
to adapter [bt848 #0](pos. 1).
kernel: bttv0: PLL: 28636363 => 35468950 .. ok
kernel: bttv0: registered device video0
kernel: bttv0: registered device vbi0





lspci -vv -x:

00:0b.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture
(rev 11)
         Subsystem: Hauppauge computer works Inc. WinTV Series
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (1000ns min, 63750ns max)
         Interrupt: pin A routed to IRQ 10
         Region 0: Memory at eb001000 (32-bit, prefetchable) [size=4K]
         Capabilities: [44] Vital Product Data
         Capabilities: [4c] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: 9e 10 78 08 06 00 90 02 11 00 80 04 00 20 80 00
10: 08 10 00 eb 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 70 00 eb 13
30: 00 00 00 00 44 00 00 00 00 00 00 00 0a 01 04 ff





/sbin/lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] 
(rev 03)
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Latency: 8
         Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
         Capabilities: [a0] AGP version 2.0
                 Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2,x4
                 Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] 
(prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
         Latency: 0
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
         I/O behind bridge: 0000c000-0000cfff
         Memory behind bridge: e4000000-e7ffffff
         Prefetchable memory behind bridge: e8000000-e9ffffff
         BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] 
(rev 40)
         Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping+ SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 0
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06) 
(prog-if 8a [Master SecP PriP])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32
         Region 4: I/O ports at d000 [size=16]
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 1a) (prog-if 00 
[UHCI])
         Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32, cache line size 08
         Interrupt: pin D routed to IRQ 10
         Region 4: I/O ports at d400 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. USB (rev 1a) (prog-if 00 
[UHCI])
         Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32, cache line size 08
         Interrupt: pin D routed to IRQ 10
         Region 4: I/O ports at d800 [size=32]
         Capabilities: [80] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
         Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
         Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Capabilities: [68] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 
AC97 Audio Controller (rev 50)
         Subsystem: VIA Technologies, Inc. VT82C686 AC97 Audio Controller
         Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin C routed to IRQ 9
         Region 0: I/O ports at dc00 [size=256]
         Region 1: I/O ports at e000 [size=4]
         Region 2: I/O ports at e400 [size=4]
         Capabilities: [c0] Power Management version 2
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin A routed to IRQ 10
         Region 0: I/O ports at e800 [size=32]
         Expansion ROM at <unassigned> [disabled] [size=16K]

00:0a.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 06)
         Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
         Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (3000ns min, 32000ns max)
         Interrupt: pin A routed to IRQ 9
         Region 0: I/O ports at ec00 [size=64]
         Capabilities: [dc] Power Management version 1
                 Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA 
PME(D0+,D1-,D2+,D3hot+,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Multimedia video controller: Brooktree Corporation Bt878 Video 
Capture (rev 11)
         Subsystem: Hauppauge computer works Inc. WinTV Series
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (4000ns min, 10000ns max)
         Interrupt: pin A routed to IRQ 10
         Region 0: Memory at eb000000 (32-bit, prefetchable) [size=4K]
         Capabilities: [44] Vital Product Data
         Capabilities: [4c] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture 
(rev 11)
         Subsystem: Hauppauge computer works Inc. WinTV Series
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium 
 >TAbort- <TAbort- <MAbort- >SERR- <PERR-
         Latency: 32 (1000ns min, 63750ns max)
         Interrupt: pin A routed to IRQ 10
         Region 0: Memory at eb001000 (32-bit, prefetchable) [size=4K]
         Capabilities: [44] Vital Product Data
         Capabilities: [4c] Power Management version 2
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo Banshee 
(rev 03) (prog-if 00 [VGA])
         Subsystem: STB Systems Inc: Unknown device 2846
         Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR- FastB2B-
         Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
         Interrupt: pin A routed to IRQ 9
         Region 0: Memory at e4000000 (32-bit, non-prefetchable) [size=32M]
         Region 1: Memory at e8000000 (32-bit, prefetchable) [size=32M]
         Region 2: I/O ports at c000 [size=256]
         Expansion ROM at <unassigned> [disabled] [size=64K]
         Capabilities: [54] AGP version 1.0
                 Status: RQ=7 SBA+ 64bit+ FW- Rate=x1
                 Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
         Capabilities: [60] Power Management version 1
                 Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                 Status: D0 PME-Enable- DSel=0 DScale=0 PME-



cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm)
stepping        : 2
cpu MHz         : 1258.455
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 2510.02


cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
0170-0177 : ide1

01f0-01f7 : ide0
0260-027f : eth0
02f8-02ff : serial(auto)
0376-0376 : ide1
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
c000-cfff : PCI Bus #01
   c000-c0ff : 3Dfx Interactive, Inc. Voodoo Banshee
d000-d00f : VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C 
PIPC Bus Master IDE
   d000-d007 : ide0
   d008-d00f : ide1
d400-d41f : VIA Technologies, Inc. USB
d800-d81f : VIA Technologies, Inc. USB (#2)
dc00-dcff : VIA Technologies, Inc. VT82C686 AC97 Audio Controller
e000-e003 : VIA Technologies, Inc. VT82C686 AC97 Audio Controller
e400-e403 : VIA Technologies, Inc. VT82C686 AC97 Audio Controller
e800-e81f : Realtek Semiconductor Co., Ltd. RTL-8029(AS)
   e800-e81f : ne2k-pci
ec00-ec3f : Ensoniq ES1371 [AudioPCI-97]
   ec00-ec3f : es1371

cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-2fffffff : System RAM
   00100000-0030ea10 : Kernel code
   0030ea11-00443f63 : Kernel data
e0000000-e3ffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
e4000000-e7ffffff : PCI Bus #01
   e4000000-e5ffffff : 3Dfx Interactive, Inc. Voodoo Banshee
e8000000-e9ffffff : PCI Bus #01
   e8000000-e9ffffff : 3Dfx Interactive, Inc. Voodoo Banshee
eb000000-eb000fff : Brooktree Corporation Bt878 Video Capture
   eb000000-eb000fff : bttv
eb001000-eb001fff : Brooktree Corporation Bt878 Audio Capture
   eb001000-eb001fff : btaudio
ffff0000-ffffffff : reserved


cat /proc/version
Linux version 2.4.23-pre9 (gcc version 3.3.2 20031022 (Red Hat Linux 
3.3.2-1)) #1 Fri Nov 7 10:22:05 EET 2003




CC. Me if there is anything you need to know or if there is something I
can test.



Thanks Johnny


