Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275790AbRJJODv>; Wed, 10 Oct 2001 10:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275816AbRJJODm>; Wed, 10 Oct 2001 10:03:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:54035 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S275790AbRJJOD2>;
	Wed, 10 Oct 2001 10:03:28 -0400
Message-Id: <200110101403.f9AE3DY6006854@PowerBox.MysticWorld.de>
Content-Type: text/plain; charset=US-ASCII
From: Alexander Feigl <Alexander.Feigl@gmx.de>
To: linux-kernel@vger.kernel.org
Date: Wed, 10 Oct 2001 16:03:12 +0200
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Subject: PROBLEM: aic7xxx SCSI system hangs 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary : aic7xxx SCSI system hangs 

Full description : After doing cdrecord -toc with an audio CD (CDDA) on my 
Plextor drive (PX 32TS), the [scsi_eh_0] proccess remains in uninterruptible 
state. All proccesses which will use the SCSI subsystem (e.g. cdrecord, 
mkisofs) will be in uninterruptible state too - which renders the SCSI system 
unusable until the next reboot. The SCSI system crashes only with my CD-ROM 
here. My Plextor PXW1210S does not hang. Reading the TOC with cdda2wav works 
here. Somebody told me  something similar happens with Plextor PX40 and 
cdda2wav. Others reported hangs and didn't tell me anything about  their SCSI 
system. (I'm coding a cd recording UI frontend and received some bug 
reports). The problems remain if I don't use my software but call the 
commands from the shell. I think it is a kernel problem. Userspace bugs  
(cdrecord,mkisofs?) should not hang the SCSI subsystem anyway.

Keywords : SCSI , cdrecord, mkisofs, aic7xxx

Kernel version : Linux version 2.4.11-pre5-xfs (root@PowerBox.MysticWorld.de) 
(gcc version egcs-2.91.66 19990314/Linux (egcs-1.1.2 release / Mandrake Linux 
8.1)) #1 Mon Okt 8 13:38:15 CEST 2001

I also tried stable and non-XFS kernels and the problem remains

Shell command : cdrecord -toc dev=x,y,z (with a CDDA in the drive)

My environment : AMD Athlon 900 Mhz
                 512 MB RAM
                 2 IDE hard drives
                 Plextor PX-32TS (the one which makes problems)  
                 Plextor PX-W1210S
                 Adaptec 2940U2W SCSI controller (both CD drives attached)
                 nVidia Geforce 2 GFX (using XFree86 drivers)
                 ALSA sound system (0.5.10) with a SB Live!
------------------------------------- ver_linux --------------------------- 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.11.90.0.8
util-linux             2.11h
mount                  2.11h
modutils               2.4.10
e2fsprogs              1.24a
PPP                    2.4.1
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.11
----------------------------------------------------------------------------

------------------------------------- cpuinfo -------------------------------
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 4
model name	: AMD Athlon(tm) Processor
stepping	: 2
cpu MHz		: 908.977
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 
mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips	: 1808.79
------------------------------------------------------------------------------
----------------------------------- modules ----------------------------------
ppp_deflate            44576   1 (autoclean)
bsd_comp                4928   0 (autoclean)
ppp_async               8032   1 (autoclean)
ppp_generic            22504   3 (autoclean) [ppp_deflate bsd_comp ppp_async]
slhc                    6436   1 (autoclean) [ppp_generic]
ipt_LOG                 4288   3 (autoclean)
ip6table_filter         2816   0 (autoclean) (unused)
ip6_tables             13920   1 [ip6table_filter]
iptable_filter          2720   0 (autoclean) (unused)
ipt_state               1536   2
ipt_MASQUERADE          2304   1
iptable_nat            19380   0 [ipt_MASQUERADE]
ip_conntrack           22860   2 [ipt_state ipt_MASQUERADE iptable_nat]
ip_tables              13312   7 [ipt_LOG iptable_filter ipt_state 
ipt_MASQUERADE iptable_nat]
nfs                    87420   1 (autoclean)
snd-synth-emu10k1       5568   0 (autoclean) (unused)
snd-synth-emux         31680   0 (autoclean) [snd-synth-emu10k1]
snd-seq-midi-emul       6384   0 (autoclean) [snd-synth-emux]
snd-seq-virmidi        10400   0 (autoclean) [snd-synth-emux]
snd-seq-midi            4640   0 (autoclean) (unused)
snd-seq-oss            33152   0 (unused)
snd-seq-midi-event      5552   0 [snd-seq-virmidi snd-seq-midi snd-seq-oss]
snd-seq                53040   0 [snd-synth-emux snd-seq-virmidi snd-seq-midi 
snd-seq-oss snd-seq-midi-event]
snd-pcm-oss            21312   0 (unused)
snd-pcm-plugin         21552   0 [snd-pcm-oss]
snd-mixer-oss           6432   0 [snd-pcm-oss]
snd-card-emu10k1        3552   0
snd-emu10k1            28608   0 [snd-synth-emu10k1 snd-card-emu10k1]
snd-ac97-codec         29472   0 [snd-emu10k1]
snd-mixer              35368   0 [snd-mixer-oss snd-emu10k1 snd-ac97-codec]
snd-pcm                42880   0 [snd-pcm-oss snd-pcm-plugin snd-emu10k1]
snd-timer              11904   0 [snd-seq snd-pcm]
snd-rawmidi            14624   0 [snd-seq-midi snd-emu10k1]
snd-emux-mem            3744   0 [snd-synth-emux snd-emu10k1]
snd-seq-device          5808   0 [snd-synth-emu10k1 snd-synth-emux 
snd-seq-midi snd-seq-oss snd-seq snd-card-emu10k1 snd-rawmidi]
snd                    49152   1 [snd-synth-emux snd-seq-virmidi snd-seq-midi 
snd-seq-oss snd-seq-midi-event snd-seq snd-pcm-oss snd-pcm-plugin 
snd-mixer-oss snd-card-emu10k1 snd-emu10k1 snd-ac97-codec snd-mixer snd-pcm 
snd-timer snd-rawmidi snd-emux-mem snd-seq-device]
soundcore               6692   9 [snd]
nfsd                   79168   8 (autoclean)
lockd                  58528   1 (autoclean) [nfs nfsd]
sunrpc                 77140   1 (autoclean) [nfs nfsd lockd]
lp                      6400   0
parport_pc             23812   1
parport                35680   1 [lp parport_pc]
ipv6                  150240  -1 (autoclean)
usb-ohci               20992   0 (unused)
usbcore                62496   1 [usb-ohci]
tulip                  42080   1 (autoclean)
sr_mod                 15768   0 (autoclean) (unused)
md                     50624   0 (unused)
tuner                   6020   1 (autoclean)
tvaudio                10464   0 (autoclean) (unused)
msp3400                16176   1 (autoclean)
bttv                   80960   0 (unused)
videodev                8128   3 [bttv]
i2c-algo-bit            8492   1 [bttv]
i2c-core               18400   0 [tuner tvaudio msp3400 bttv i2c-algo-bit]
v4l2-common             8672   0 [bttv]
xfs                   530904   4
aic7xxx               112172   0 (unused)
sd_mod                 10456   0 (unused)
scsi_mod               83916   3 [sr_mod aic7xxx sd_mod]
xfs_support             9508   0 [xfs]
pagebuf                24896   4 [xfs xfs_support]
-----------------------------------------------------------------------------
------------------------------------ ioports --------------------------------
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
0378-037a : parport0
037b-037f : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0778-077a : parport0
0cf8-0cff : PCI conf1
b000-bfff : PCI Bus #01
d200-d203 : Advanced Micro Devices [AMD] AMD-751 [Irongate] System Controller
d400-d41f : Creative Labs SB Live! EMU10k1
  d400-d41f : EMU10K1
d600-d6ff : Lite-On Communications Inc LNE100TX
  d600-d6ff : tulip
d800-d803 : Elsa AG QuickStep 1000
da00-da7f : Elsa AG QuickStep 1000
dc00-dcff : Adaptec AHA-2940U2/W
de00-de07 : Creative Labs SB Live!
f000-f00f : Advanced Micro Devices [AMD] AMD-756 [Viper] IDE
  f000-f007 : ide0
  f008-f00f : ide1
------------------------------------------------------------------------------

--------------------------------------- iomem --------------------------------
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cb800-000d7fff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-001ffeeb : Kernel code
  001ffeec-002cb227 : Kernel data
1fff0000-1fff7fff : ACPI Tables
1fff8000-1fffffff : ACPI Non-volatile Storage
d5c00000-e5cfffff : PCI Bus #01
  d8000000-dfffffff : nVidia Corporation NV11 (GeForce2 MX)
e8000000-ebffffff : Advanced Micro Devices [AMD] AMD-751 [Irongate] System 
Controller
eddfe000-eddfefff : Advanced Micro Devices [AMD] AMD-751 [Irongate] System 
Controller
eddff000-eddfffff : Brooktree Corporation Bt848 TV with DMA push
  eddff000-eddfffff : bttv0
ede00000-efefffff : PCI Bus #01
  ee000000-eeffffff : nVidia Corporation NV11 (GeForce2 MX)
efffd000-efffdfff : Advanced Micro Devices [AMD] AMD-756 [Viper] USB
  efffd000-efffdfff : usb-ohci
efffee00-efffeeff : Lite-On Communications Inc LNE100TX
  efffee00-efffeeff : tulip
efffef80-efffefff : Elsa AG QuickStep 1000
effff000-efffffff : Adaptec AHA-2940U2/W
  effff000-efffffff : aic7xxx
ffff0000-ffffffff : reserved
-------------------------------------------------------------------------------

-------------------------------------- lspci --------------------------------
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] System 
Controller (rev 25)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort+ >SERR- <PERR-
	Latency: 120
	Region 0: Memory at e8000000 (32-bit, prefetchable) [size=64M]
	Region 1: Memory at eddfe000 (32-bit, prefetchable) [size=4K]
	Region 2: I/O ports at d200 [disabled] [size=4]
	Capabilities: [a0] AGP version 1.0
		Status: RQ=15 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP+ 64bit- FW- Rate=x1

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-751 [Irongate] AGP 
Bridge (rev 01) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 120
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000b000-0000bfff
	Memory behind bridge: ede00000-efefffff
	Prefetchable memory behind bridge: d5c00000-e5cfffff
	BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] ISA (rev 01)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-756 [Viper] IDE (rev 
07) (prog-if 8a [Master SecP PriP])
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at f000 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-756 [Viper] ACPI (rev 03)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-

00:07.4 USB Controller: Advanced Micro Devices [AMD] AMD-756 [Viper] USB (rev 
06) (prog-if 10 [OHCI])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 16 (20000ns max), cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 0: Memory at efffd000 (32-bit, non-prefetchable) [size=4K]

00:08.0 Multimedia audio controller: Creative Labs SB Live! EMU10000 (rev 04)
	Subsystem: Creative Labs CT4620 SBLive!
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at d400 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:08.1 Input device controller: Creative Labs SB Live! (rev 01)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64
	Region 0: I/O ports at de00 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Multimedia video controller: Brooktree Corporation Bt848 TV with DMA 
push (rev 12)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at eddff000 (32-bit, prefetchable) [size=4K]

00:0a.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev 20)
	Subsystem: Netgear FA310TX
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at d600 [size=256]
	Region 1: Memory at efffee00 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at eff80000 [disabled] [size=256K]

00:0b.0 SCSI storage controller: Adaptec AHA-2940U2/W
	Subsystem: Adaptec: Unknown device a180
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64 (9750ns min, 6250ns max)
	Interrupt: pin A routed to IRQ 10
	BIST result: 00
	Region 0: I/O ports at dc00 [disabled] [size=256]
	Region 1: Memory at effff000 (64-bit, non-prefetchable) [size=4K]
	Expansion ROM at effc0000 [disabled] [size=128K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 Network controller: Elsa AG QuickStep 1000 (rev 01)
	Subsystem: Elsa AG QuickStep 1000
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at efffef80 (32-bit, non-prefetchable) [size=128]
	Region 1: I/O ports at da00 [size=128]
	Region 3: I/O ports at d800 [size=4]

01:05.0 VGA compatible controller: nVidia Corporation NV11 (rev a1) (prog-if 
00 [VGA])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- 
<MAbort- >SERR- <PERR-
	Latency: 64 (1250ns min, 250ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at ee000000 (32-bit, non-prefetchable) [size=16M]
	Region 1: Memory at d8000000 (32-bit, prefetchable) [size=128M]
	Expansion ROM at efef0000 [disabled] [size=64K]
	Capabilities: [60] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [44] AGP version 2.0
		Status: RQ=31 SBA- 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

--------------------------------------------------------------------------------
----------------------------------- scsi -------------------------------------
Attached devices: 
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: PLEXTOR  Model: CD-ROM PX-32TS   Rev: 1.02
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: PLEXTOR  Model: CD-R   PX-W1210S Rev: 1.03
  Type:   CD-ROM                           ANSI SCSI revision: 02
--------------------------------------------------------------------------------


Alexander Feigl
