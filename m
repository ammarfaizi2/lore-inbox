Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750908AbWFGImt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908AbWFGImt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 04:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbWFGImt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 04:42:49 -0400
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:52328 "HELO
	smtp114.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750895AbWFGIms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 04:42:48 -0400
Date: Wed, 7 Jun 2006 01:44:42 -0700
From: CE <ceidem@cs.sonoma.edu>
To: linux-kernel@vger.kernel.org
Subject: Wrong interrupt acknowledge with 2.6.16.18
Message-Id: <20060607014442.e7f9ba59.ceidem@cs.sonoma.edu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Wed__7_Jun_2006_01_44_42_-0700_yk/V6zH3ryScZmli"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Multipart=_Wed__7_Jun_2006_01_44_42_-0700_yk/V6zH3ryScZmli
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

	Ever since moving to the 2.6.x kernels I've been experiencing
what I believe are ACPI related IRQ problems.  In short the whole system
gets noticeably choppy (even with preempt) - especially when looking at
webpages with lots of graphics.  I'll leave to your imagination what
these pages are ;)  Since it seems IRQ related I tried all the standard
things.  Disabling ACPI, enabling ACPI (both in kernel and BIOS), PnP
options in the BIOS, kernel boot options (pci=routeirq among others),
removing cards and turning off anything that used an IRQ in the BIOS.
Eventually I was left with nothing but sound and graphics and IDE.
Still, the problem remained.  Trying another sound card was fruitless
as well.  Attached is the dmesg output (with alsa xrun_debug at the
bottom, which pointed me to this being IRQ related) from that basic
configuration. 
	Google turned up some results that showed similar
problems with early implementations of ACPI and / or early 2.6.x
kernels.  Why I seem to be the only one with these problems and such a
recent version of the kernel I don't know.  I'm certainly willing to
what I can in order to get this problem resolved.  Thank you.

Further info (this is with cards back in / USB, etc. turned on):

$ cat /proc/version
Linux version 2.6.16.18 (root@manger) (gcc version 4.0.4 20060507
(prerelease) (Debian 4.0.3-3)) #5 PREEMPT Mon Jun 5 22:40:30 PDT 2006


$ /usr/src/linux-2.6.16.18/scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux manger 2.6.16.18 #5 PREEMPT Mon Jun 5 22:40:30 PDT 2006 i686
GNU/Linux

Gnu C                  4.0.4
Gnu make               3.81
binutils               2.16.91
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.39-WIP
reiserfsprogs          line
reiser4progs           line
PPP                    2.4.4b1
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Procps                 3.2.6
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.94
Modules Loaded         snd_intel8x0 snd_ac97_codec snd_ac97_bus
snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore
snd_page_alloc sis_agp sd_mod tuner tda9887 bttv ohci_hcd sg sr_mod
sym53c8xx scsi_transport_spi sidewinder ns558 gameport joydev radeon
drm agpgart sis900 crc32 video_buf firmware_class i2c_algo_bit
v4l2_common btcx_risc ir_common tveeprom i2c_core nls_iso8859_1 ov511
compat_ioctl32 videodev usb_storage rtc 

$ cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1195.058
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
cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow bogomips        :
2392.22


$ cat /proc/modules
snd_intel8x0 33948 2 - Live 0xf8c3f000
snd_ac97_codec 97696 1 snd_intel8x0, Live 0xf8bf5000
snd_ac97_bus 2432 1 snd_ac97_codec, Live 0xf8ad8000
snd_pcm_oss 62496 1 - Live 0xf8c2e000
snd_mixer_oss 19456 2 snd_pcm_oss, Live 0xf8b7e000
snd_pcm 101768 3 snd_intel8x0,snd_ac97_codec,snd_pcm_oss, Live
0xf8c14000 snd_timer 26756 1 snd_pcm, Live 0xf8bd1000
snd 60672 6
snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,
Live 0xf8be5000 soundcore 10080 3 snd, Live 0xf8b14000 snd_page_alloc
11400 2 snd_intel8x0,snd_pcm, Live 0xf8b10000 sis_agp 8964 1 - Live
0xf8af5000 sd_mod 17680 0 - Live 0xf8aef000
tuner 53932 0 - Live 0xf8b01000
tda9887 17168 0 - Live 0xf8add000
bttv 175420 0 - Live 0xf8b94000
ohci_hcd 21252 0 - Live 0xf8b25000
sg 36508 0 - Live 0xf8b8a000
sr_mod 17188 0 - Live 0xf8b2c000
sym53c8xx 78612 0 - Live 0xf8b4c000
scsi_transport_spi 23808 1 sym53c8xx, Live 0xf8b45000
sidewinder 12800 0 - Live 0xf8b20000
ns558 3016 0 - Live 0xf8a69000
gameport 15112 3 sidewinder,ns558, Live 0xf8ab8000
joydev 10176 0 - Live 0xf8ac4000
radeon 109856 0 - Live 0xf8b62000
drm 73108 1 radeon, Live 0xf8b32000
agpgart 33072 2 sis_agp,drm, Live 0xf8ae5000
sis900 24064 0 - Live 0xf8acc000
crc32 4608 1 sis900, Live 0xf8ab5000
video_buf 22532 1 bttv, Live 0xf8abd000
firmware_class 11008 1 bttv, Live 0xf8a9d000
i2c_algo_bit 9736 1 bttv, Live 0xf8a99000
v4l2_common 7936 2 tuner,bttv, Live 0xf8a70000
btcx_risc 5256 1 bttv, Live 0xf8a76000
ir_common 9988 1 bttv, Live 0xf8a7a000
tveeprom 14992 1 bttv, Live 0xf8a8f000
i2c_core 22288 5 tuner,tda9887,bttv,i2c_algo_bit,tveeprom, Live
0xf8a88000 nls_iso8859_1 4224 0 - Live 0xf8a73000
ov511 76052 0 - Live 0xf8aa1000
compat_ioctl32 1408 2 bttv,ov511, Live 0xf8806000
videodev 9856 2 bttv,ov511, Live 0xf8a65000
usb_storage 35716 0 - Live 0xf8a7e000
rtc 13876 0 - Live 0xf8a6b000


$ cat /proc/ioports
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
0209-0209 : ns558-isa
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0800-0803 : PM1a_EVT_BLK
0804-0805 : PM1a_CNT_BLK
0808-080b : PM_TMR
0820-0823 : GPE0_BLK
0830-0833 : GPE1_BLK
0cf8-0cff : PCI conf1
a000-afff : PCI Bus #01
  a800-a8ff : 0000:01:00.0
d000-d0ff : 0000:00:03.0
  d000-d0ff : sis900
d400-d43f : 0000:00:02.7
  d400-d43f : SiS SI7012
d800-d8ff : 0000:00:11.0
  d800-d8ff : sym53c8xx
dc00-dcff : 0000:00:02.7
  dc00-dcff : SiS SI7012
ff00-ff0f : 0000:00:02.5
  ff00-ff07 : ide0
  ff08-ff0f : ide1

[jebediah@manger]-(~)$ cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000cbfff : Video ROM
000cc000-000cc1ff : Adapter ROM
000cc800-000d47ff : Adapter ROM
000f0000-000fffff : System ROM
00100000-3ffeffff : System RAM
  00100000-002e5caa : Kernel code
  002e5cab-00372713 : Kernel data
3fff0000-3fff7fff : ACPI Tables
3fff8000-3fffffff : ACPI Non-volatile Storage
bfc00000-cfcfffff : PCI Bus #01
  c0000000-c7ffffff : 0000:01:00.0
cfdfe000-cfdfefff : 0000:00:0b.0
  cfdfe000-cfdfefff : bttv0
cfdff000-cfdfffff : 0000:00:0b.1
cfe00000-cfefffff : PCI Bus #01
  cfec0000-cfedffff : 0000:01:00.0
  cfef0000-cfefffff : 0000:01:00.0
cffc0000-cffdffff : 0000:00:03.0
cffe0000-cffeffff : 0000:00:11.0
cfffb000-cfffbfff : 0000:00:03.0
  cfffb000-cfffbfff : sis900
cfffc000-cfffcfff : 0000:00:02.2
  cfffc000-cfffcfff : ohci_hcd
cfffd000-cfffdfff : 0000:00:02.3
  cfffd000-cfffdfff : ohci_hcd
cfffe000-cfffefff : 0000:00:11.0
  cfffe000-cfffefff : sym53c8xx
cfffff00-cfffffff : 0000:00:11.0
  cfffff00-cfffffff : sym53c8xx
d0000000-d3ffffff : 0000:00:00.0
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffee0000-ffefffff : reserved
fffc0000-ffffffff : reserved


$ sudo lspci -vvv
0000:00:00.0 Host bridge: Silicon Integrated Systems [SiS] 735 Host
(rev 01) Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- Status: Cap+ 66MHz- UDF- FastB2B-
ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR- Latency:
32 Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=64M]
        Capabilities: [c0] AGP version 2.0
                Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4 Command: RQ=1 ArqSz=0 Cal=0 SBA-
AGP- GART64- 64bit- FW- Rate=<none>

0000:00:01.0 PCI bridge: Silicon Integrated Systems [SiS] Virtual
PCI-to-PCI bridge (AGP) (prog-if 00 [Normal decode]) Control: I/O+ Mem+
BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+
FastB2B- Status: Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- Latency: 64 Bus: primary=00,
secondary=01, subordinate=01, sec-latency=64 I/O behind bridge:
0000a000-0000afff Memory behind bridge: cfe00000-cfefffff
        Prefetchable memory behind bridge: bfc00000-cfcfffff
        BridgeCtl: Parity- SERR+ NoISA- VGA+ MAbort- >Reset- FastB2B-

0000:00:02.0 ISA bridge: Silicon Integrated Systems [SiS]
SiS85C503/5513 (LPC Bridge) Control: I/O+ Mem+ BusMaster+ SpecCycle+
MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- Status: Cap- 66MHz-
UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR-
<PERR- Latency: 0

0000:00:02.2 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
Controller (rev 07) (prog-if 10 [OHCI]) Subsystem: Elitegroup Computer
Systems K7S5A motherboard Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B- Status: Cap- 66MHz-
UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR-
<PERR- Latency: 64 (20000ns max), Cache Line Size: 0x08 (32 bytes)
Interrupt: pin D routed to IRQ 4 Region 0: Memory at cfffc000 (32-bit,
non-prefetchable) [size=4K]

0000:00:02.3 USB Controller: Silicon Integrated Systems [SiS] USB 1.0
Controller (rev 07) (prog-if 10 [OHCI]) Subsystem: Elitegroup Computer
Systems K7S5A motherboard Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV+ VGASnoop- ParErr- Stepping- SERR+ FastB2B- Status: Cap- 66MHz-
UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR-
<PERR- Latency: 64 (20000ns max), Cache Line Size: 0x08 (32 bytes)
Interrupt: pin A routed to IRQ 3 Region 0: Memory at cfffd000 (32-bit,
non-prefetchable) [size=4K]

0000:00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]
(rev d0) (prog-if 80 [Master]) Subsystem: Silicon Integrated Systems
[SiS] SiS5513 EIDE Controller (A,B step) Control: I/O+ Mem- BusMaster+
SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- Status:
Cap- 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort-
<MAbort- >SERR- <PERR- Latency: 128 Region 4: I/O ports at ff00
[size=16]

0000:00:02.7 Multimedia audio controller: Silicon Integrated Systems
[SiS] Sound Controller (rev a0) Subsystem: Elitegroup Computer Systems:
Unknown device 0a14 Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV-
VGASnoop- ParErr- Stepping- SERR+ FastB2B- Status: Cap+ 66MHz- UDF-
FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
Latency: 64 (13000ns min, 2750ns max) Interrupt: pin C routed to IRQ 10
        Region 0: I/O ports at dc00 [size=256]
        Region 1: I/O ports at d400 [size=64]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME
(D0-,D1-,D2-,D3hot+,D3cold+) Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:03.0 Ethernet controller: Silicon Integrated Systems [SiS]
SiS900 PCI Fast Ethernet (rev 90) Subsystem: Elitegroup Computer
Systems K7S5A motherboard Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- Status: Cap+ 66MHz-
UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR-
<PERR- Latency: 64 (13000ns min, 2750ns max) Interrupt: pin A routed to
IRQ 11 Region 0: I/O ports at d000 [size=256]
        Region 1: Memory at cfffb000 (32-bit, non-prefetchable)
[size=4K] Expansion ROM at cffc0000 [disabled] [size=128K]
        Capabilities: [40] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1
+,D2+,D3hot+,D3cold+) Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0b.0 Multimedia video controller: Brooktree Corporation Bt878
Video Capture (rev 11) Subsystem: LeadTek Research Inc.: Unknown device
6609 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B- Status: Cap+ 66MHz- UDF- FastB2B+
ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- Latency:
64 (4000ns min, 10000ns max) Interrupt: pin A routed to IRQ 5
        Region 0: Memory at cfdfe000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME
(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:0b.1 Multimedia controller: Brooktree Corporation Bt878 Audio
Capture (rev 11) Subsystem: LeadTek Research Inc.: Unknown device 6609
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B- Status: Cap+ 66MHz- UDF- FastB2B+
ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- Latency:
64 (1000ns min, 63750ns max) Interrupt: pin A routed to IRQ 5
        Region 0: Memory at cfdff000 (32-bit, prefetchable) [size=4K]
        Capabilities: [44] Vital Product Data
        Capabilities: [4c] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME
(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:00:11.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875
(rev 26) Subsystem: Tekram Technology Co.,Ltd. DC390F/U Ultra Wide SCSI
Adapter Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B- Status: Cap+ 66MHz- UDF- FastB2B-
ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- Latency:
64 (4250ns min, 16000ns max), Cache Line Size: 0x10 (64 bytes)
Interrupt: pin A routed to IRQ 5 Region 0: I/O ports at d800 [size=256]
        Region 1: Memory at cfffff00 (32-bit, non-prefetchable)
[size=256] Region 2: Memory at cfffe000 (32-bit, non-prefetchable)
[size=4K] Expansion ROM at cffe0000 [disabled] [size=64K]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME
(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 PME-Enable- DSel=0 DScale=0 PME-

0000:01:00.0 VGA compatible controller: ATI Technologies Inc Radeon
RV200 QW [Radeon 7500] (prog-if 00 [VGA]) Subsystem: ATI Technologies
Inc: Unknown device 0f2a Control: I/O+ Mem+ BusMaster+ SpecCycle-
MemWINV- VGASnoop- ParErr- Stepping+ SERR+ FastB2B- Status: Cap+ 66MHz+
UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR-
<PERR- Latency: 64 (2000ns min), Cache Line Size: 0x08 (32 bytes)
Interrupt: pin A routed to IRQ 11 Region 0: Memory at c0000000 (32-bit,
prefetchable) [size=128M] Region 1: I/O ports at a800 [size=256]
        Region 2: Memory at cfef0000 (32-bit, non-prefetchable)
[size=64K] Expansion ROM at cfec0000 [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
                Status: RQ=48 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64-
HTrans- 64bit- FW- AGP3- Rate=x1,x2,x4 Command: RQ=1 ArqSz=0 Cal=0 SBA+
AGP- GART64- 64bit- FW- Rate=<none> Capabilities: [50] Power Management
version 2 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME
(D0-,D1-,D2-,D3hot-,D3cold-) Status: D0 PME-Enable- DSel=0 DScale=0 PME-
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEhpH6fNjOqXY1FhIRAtfQAJ43NLXU0UfXFC5gzZecAkosSDl8/wCfcB2j
dsaYUTchd4J7z3sUvOjbaHw=
=Rem2
-----END PGP SIGNATURE-----

--Multipart=_Wed__7_Jun_2006_01_44_42_-0700_yk/V6zH3ryScZmli
Content-Type: text/plain;
 name="dmesg_-_no_shared.txt"
Content-Disposition: attachment;
 filename="dmesg_-_no_shared.txt"
Content-Transfer-Encoding: 7bit

source [FDDP] (off)
ACPI: Power Resource [LPTP] (off)
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 *4 5 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 *5 7 10 11 12 14 15)
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a report
PCI: Bridge: 0000:00:01.0
  IO window: b000-bfff
  MEM window: cfe00000-cfefffff
  PREFETCH window: bfc00000-cfcfffff
Machine check exception polling timer started.
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered (default)
io scheduler cfq registered
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 0000:00:02.5
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SIS5513: SiS735 ATA 100 (2nd gen) controller
    ide0: BM-DMA at 0xff00-0xff07, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xff08-0xff0f, BIOS settings: hdc:DMA, hdd:DMA
Probing IDE interface ide0...
hda: ST340016A, ATA DISK drive
hdb: ST3200822A, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: CD-ROM 52X/AKH, ATAPI CD/DVD-ROM drive
hdd: ST3120026A, ATA DISK drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 78165360 sectors (40020 MB) w/2048KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes not supported
 hda: hda1 hda2 hda3
hdb: max request size: 512KiB
hdb: 390721968 sectors (200049 MB) w/8192KiB Cache, CHS=24321/255/63, UDMA(100)
hdb: cache flushes supported
 hdb: unknown partition table
hdd: max request size: 512KiB
hdd: 234441648 sectors (120034 MB) w/8192KiB Cache, CHS=16383/255/63, UDMA(100)
hdd: cache flushes supported
 hdd: hdd1 < >
hdc: ATAPI 52X CD-ROM drive, 192kB Cache, DMA
Uniform CD-ROM driver Revision: 3.20
usbmon: debugfs is not available
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
mice: PS/2 mouse device common for all mice
NET: Registered protocol family 2
input: AT Translated Set 2 keyboard as /class/input/input0
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 7, 524288 bytes)
TCP bind hash table entries: 65536 (order: 6, 262144 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
Using IPI Shortcut mode
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 152k freed
input: PS2++ Logitech Wheel Mouse as /class/input/input1
Adding 4899816k swap on /dev/hda3.  Priority:10 extents:1 across:4899816k
EXT3 FS on hda1, internal journal
Real Time Clock Driver v1.12ac
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
Linux video capture interface: v1.00
usbcore: registered new driver ov511
drivers/usb/media/ov511.c: v1.64 for Linux 2.5 : ov511 USB Camera Driver
bttv: driver version 0.9.16 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
sis900.c: v1.08.09 Sep. 19 2005
ACPI: PCI Interrupt Link [LNKG] enabled at IRQ 4
PCI: setting IRQ 4 as level-triggered
ACPI: PCI Interrupt 0000:00:03.0[A] -> Link [LNKG] -> GSI 4 (level, low) -> IRQ 4
0000:00:03.0: Realtek RTL8201 PHY transceiver found at address 1.
0000:00:03.0: Using transceiver found at address 1 as default
eth0: SiS 900 PCI Fast Ethernet at 0xd400, IRQ 4, 00:00:00:00:00:00.
Linux agpgart interface v0.101 (c) Dave Jones
[drm] Initialized drm 1.0.1 20051102
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 11
[drm] Initialized radeon 1.22.0 20051229 on minor 0
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
EXT3-fs warning: maximal mount count reached, running e2fsck is recommended
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdd, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 3
PCI: setting IRQ 3 as level-triggered
ACPI: PCI Interrupt 0000:00:02.2[D] -> Link [LNKD] -> GSI 3 (level, low) -> IRQ 3
ohci_hcd 0000:00:02.2: OHCI Host Controller
ohci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
ohci_hcd 0000:00:02.2: irq 3, io mem 0xcfffe000
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 3 ports detected
ACPI: PCI Interrupt Link [LNKH] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:02.3[A] -> Link [LNKH] -> GSI 5 (level, low) -> IRQ 5
ohci_hcd 0000:00:02.3: OHCI Host Controller
ohci_hcd 0000:00:02.3: new USB bus registered, assigned bus number 2
ohci_hcd 0000:00:02.3: irq 5, io mem 0xcffff000
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 3 ports detected
eth0: Media Link On 100mbps full-duplex 
bttv: driver version 0.9.16 loaded
bttv: using 8 buffers with 2080k (520 pages) each for capture
device eth0 entered promiscuous mode
agpgart: Detected SiS 735 chipset
agpgart: AGP aperture is 64M @ 0xd0000000
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:02.7[C] -> Link [LNKC] -> GSI 10 (level, low) -> IRQ 10
intel8x0_measure_ac97_clock: measured 65917 usecs
intel8x0: clocking to 48000
[drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
[drm:drm_unlock] *ERROR* Process 3570 using kernel context 0
ALSA sound/core/pcm_lib.c:254: Unexpected hw_pointer value [2] (stream = 0, delta: -547, max jitter = 4456): wrong interrupt acknowledge?
 [<f8be4c89>] snd_pcm_update_hw_ptr+0x139/0x280 [snd_pcm]
 [<f8bdef8e>] snd_pcm_common_ioctl1+0x42e/0xf80 [snd_pcm]
 [<c02e3875>] schedule+0x315/0x640
 [<c02e44ac>] schedule_timeout+0x4c/0xc0
 [<c016c0c8>] poll_freewait+0x48/0x60
 [<f8be00ff>] snd_pcm_playback_ioctl1+0x5f/0x620 [snd_pcm]
 [<f8be11ac>] snd_pcm_kernel_playback_ioctl+0x2c/0x40 [snd_pcm]
 [<f8bf6fa5>] snd_pcm_oss_ioctl+0xa95/0xc10 [snd_pcm_oss]
 [<c016b6d5>] do_ioctl+0x35/0xa0
 [<c016b79d>] vfs_ioctl+0x5d/0x320
 [<c016d4eb>] sys_select+0x11b/0x200
 [<c016baa5>] sys_ioctl+0x45/0x70
 [<c0102d81>] syscall_call+0x7/0xb
ALSA sound/core/pcm_lib.c:138: XRUN: pcmC0D0p
 [<f8be26fe>] snd_pcm_period_elapsed+0x1be/0x3b0 [snd_pcm]
 [<f8b5406e>] snd_intel8x0_interrupt+0x18e/0x240 [snd_intel8x0]
 [<c01366bd>] handle_IRQ_event+0x3d/0x70
 [<c0136766>] __do_IRQ+0x76/0x100
 [<c0102555>] sys_sigreturn+0xa5/0xc0
 [<c0104be9>] do_IRQ+0x19/0x30
 [<c0102f4e>] common_interrupt+0x1a/0x20
ALSA sound/core/pcm_lib.c:138: XRUN: pcmC0D0p
 [<f8be26fe>] snd_pcm_period_elapsed+0x1be/0x3b0 [snd_pcm]
 [<f8b5406e>] snd_intel8x0_interrupt+0x18e/0x240 [snd_intel8x0]
 [<c01366bd>] handle_IRQ_event+0x3d/0x70
 [<c0136766>] __do_IRQ+0x76/0x100
 [<c0104be9>] do_IRQ+0x19/0x30
 [<c0102f4e>] common_interrupt+0x1a/0x20
ALSA sound/core/pcm_lib.c:138: XRUN: pcmC0D0p
 [<f8be26fe>] snd_pcm_period_elapsed+0x1be/0x3b0 [snd_pcm]
 [<f8b5406e>] snd_intel8x0_interrupt+0x18e/0x240 [snd_intel8x0]
 [<c01366bd>] handle_IRQ_event+0x3d/0x70
 [<c0136766>] __do_IRQ+0x76/0x100
 [<c0104be9>] do_IRQ+0x19/0x30
 [<c0102f4e>] common_interrupt+0x1a/0x20
ALSA sound/core/pcm_lib.c:138: XRUN: pcmC0D0p
 [<f8be26fe>] snd_pcm_period_elapsed+0x1be/0x3b0 [snd_pcm]
 [<f8b5406e>] snd_intel8x0_interrupt+0x18e/0x240 [snd_intel8x0]
 [<c01366bd>] handle_IRQ_event+0x3d/0x70
 [<c0136766>] __do_IRQ+0x76/0x100
 [<c0104be9>] do_IRQ+0x19/0x30
 [<c0102f4e>] common_interrupt+0x1a/0x20
 [<c0136698>] handle_IRQ_event+0x18/0x70
 [<c0136766>] __do_IRQ+0x76/0x100
 [<c0104be9>] do_IRQ+0x19/0x30
 [<c0102f4e>] common_interrupt+0x1a/0x20
ALSA sound/core/pcm_lib.c:138: XRUN: pcmC0D0p
 [<f8be26fe>] snd_pcm_period_elapsed+0x1be/0x3b0 [snd_pcm]
 [<f8b5406e>] snd_intel8x0_interrupt+0x18e/0x240 [snd_intel8x0]
 [<c01366bd>] handle_IRQ_event+0x3d/0x70
 [<c0136766>] __do_IRQ+0x76/0x100
 [<c0104be9>] do_IRQ+0x19/0x30
 [<c0102f4e>] common_interrupt+0x1a/0x20
ALSA sound/core/pcm_lib.c:138: XRUN: pcmC0D0p
 [<f8be26fe>] snd_pcm_period_elapsed+0x1be/0x3b0 [snd_pcm]
 [<f8b5406e>] snd_intel8x0_interrupt+0x18e/0x240 [snd_intel8x0]
 [<c01366bd>] handle_IRQ_event+0x3d/0x70
 [<c0136766>] __do_IRQ+0x76/0x100
 [<c0104be9>] do_IRQ+0x19/0x30
 [<c0102f4e>] common_interrupt+0x1a/0x20
ALSA sound/core/pcm_lib.c:138: XRUN: pcmC0D0p
 [<f8be26fe>] snd_pcm_period_elapsed+0x1be/0x3b0 [snd_pcm]
 [<f8b5406e>] snd_intel8x0_interrupt+0x18e/0x240 [snd_intel8x0]
 [<c01366bd>] handle_IRQ_event+0x3d/0x70
 [<c0136766>] __do_IRQ+0x76/0x100
 [<c0104be9>] do_IRQ+0x19/0x30
 [<c0102f4e>] common_interrupt+0x1a/0x20
ALSA sound/core/pcm_lib.c:138: XRUN: pcmC0D0p
 [<f8be26fe>] snd_pcm_period_elapsed+0x1be/0x3b0 [snd_pcm]
 [<f8b5406e>] snd_intel8x0_interrupt+0x18e/0x240 [snd_intel8x0]
 [<c01366bd>] handle_IRQ_event+0x3d/0x70
 [<c0136766>] __do_IRQ+0x76/0x100
 [<c011cd13>] __do_softirq+0x43/0x90
 [<c0104be9>] do_IRQ+0x19/0x30
 [<c0102f4e>] common_interrupt+0x1a/0x20
ALSA sound/core/pcm_lib.c:138: XRUN: pcmC0D0p
 [<f8be26fe>] snd_pcm_period_elapsed+0x1be/0x3b0 [snd_pcm]
 [<f8b5406e>] snd_intel8x0_interrupt+0x18e/0x240 [snd_intel8x0]
 [<c01366bd>] handle_IRQ_event+0x3d/0x70
 [<c0136766>] __do_IRQ+0x76/0x100
 [<c0102555>] sys_sigreturn+0xa5/0xc0
 [<c0104be9>] do_IRQ+0x19/0x30
 [<c0102f4e>] common_interrupt+0x1a/0x20
ALSA sound/core/pcm_lib.c:138: XRUN: pcmC0D0p
 [<f8be26fe>] snd_pcm_period_elapsed+0x1be/0x3b0 [snd_pcm]
 [<f8b5406e>] snd_intel8x0_interrupt+0x18e/0x240 [snd_intel8x0]
 [<c01366bd>] handle_IRQ_event+0x3d/0x70
 [<c0136766>] __do_IRQ+0x76/0x100
 [<c011cd13>] __do_softirq+0x43/0x90
 [<c0104be9>] do_IRQ+0x19/0x30
 [<c0102f4e>] common_interrupt+0x1a/0x20
ALSA sound/core/pcm_lib.c:138: XRUN: pcmC0D0p
 [<f8be26fe>] snd_pcm_period_elapsed+0x1be/0x3b0 [snd_pcm]
 [<f8b5406e>] snd_intel8x0_interrupt+0x18e/0x240 [snd_intel8x0]
 [<c01366bd>] handle_IRQ_event+0x3d/0x70
 [<c0136766>] __do_IRQ+0x76/0x100
 [<c0104be9>] do_IRQ+0x19/0x30
 [<c0102f4e>] common_interrupt+0x1a/0x20
ALSA sound/core/pcm_lib.c:254: Unexpected hw_pointer value [2] (stream = 0, delta: -1110, max jitter = 4456): wrong interrupt acknowledge?
 [<f8be4c89>] snd_pcm_update_hw_ptr+0x139/0x280 [snd_pcm]
 [<f8bdef8e>] snd_pcm_common_ioctl1+0x42e/0xf80 [snd_pcm]
 [<c02e3875>] schedule+0x315/0x640
 [<c02e44ac>] schedule_timeout+0x4c/0xc0
 [<c01083aa>] convert_fxsr_to_user+0x11a/0x1d0
 [<f8be00ff>] snd_pcm_playback_ioctl1+0x5f/0x620 [snd_pcm]
 [<c01023e4>] setup_sigcontext+0xe4/0x130
 [<c01028e1>] do_notify_resume+0x371/0x6e8
 [<f8be11ac>] snd_pcm_kernel_playback_ioctl+0x2c/0x40 [snd_pcm]
 [<f8bf6fa5>] snd_pcm_oss_ioctl+0xa95/0xc10 [snd_pcm_oss]
 [<c016b6d5>] do_ioctl+0x35/0xa0
 [<c016b79d>] vfs_ioctl+0x5d/0x320
 [<c01021e1>] restore_sigcontext+0x151/0x170
 [<c016baa5>] sys_ioctl+0x45/0x70
 [<c0102d81>] syscall_call+0x7/0xb
ALSA sound/core/pcm_lib.c:254: Unexpected hw_pointer value [2] (stream = 0, delta: -538, max jitter = 4456): wrong interrupt acknowledge?
 [<f8be4c89>] snd_pcm_update_hw_ptr+0x139/0x280 [snd_pcm]
 [<f8bdef8e>] snd_pcm_common_ioctl1+0x42e/0xf80 [snd_pcm]
 [<c02e3875>] schedule+0x315/0x640
 [<c02e44ac>] schedule_timeout+0x4c/0xc0
 [<c016c0c8>] poll_freewait+0x48/0x60
 [<f8be00ff>] snd_pcm_playback_ioctl1+0x5f/0x620 [snd_pcm]
 [<f8be11ac>] snd_pcm_kernel_playback_ioctl+0x2c/0x40 [snd_pcm]
 [<f8bf6fa5>] snd_pcm_oss_ioctl+0xa95/0xc10 [snd_pcm_oss]
 [<c016b6d5>] do_ioctl+0x35/0xa0
 [<c016b79d>] vfs_ioctl+0x5d/0x320
 [<c016d4eb>] sys_select+0x11b/0x200
 [<c016baa5>] sys_ioctl+0x45/0x70
 [<c0102d81>] syscall_call+0x7/0xb
ALSA sound/core/pcm_lib.c:254: Unexpected hw_pointer value [2] (stream = 0, delta: -593, max jitter = 4456): wrong interrupt acknowledge?
 [<f8be4c89>] snd_pcm_update_hw_ptr+0x139/0x280 [snd_pcm]
 [<f8bdef8e>] snd_pcm_common_ioctl1+0x42e/0xf80 [snd_pcm]
 [<c011cd13>] __do_softirq+0x43/0x90
 [<c02e3875>] schedule+0x315/0x640
 [<c02e44ac>] schedule_timeout+0x4c/0xc0
 [<c016c0c8>] poll_freewait+0x48/0x60
 [<f8be00ff>] snd_pcm_playback_ioctl1+0x5f/0x620 [snd_pcm]
 [<f8be11ac>] snd_pcm_kernel_playback_ioctl+0x2c/0x40 [snd_pcm]
 [<f8bf6fa5>] snd_pcm_oss_ioctl+0xa95/0xc10 [snd_pcm_oss]
 [<c016b6d5>] do_ioctl+0x35/0xa0
 [<c016b79d>] vfs_ioctl+0x5d/0x320
 [<c016d4eb>] sys_select+0x11b/0x200
 [<c016baa5>] sys_ioctl+0x45/0x70
 [<c0102d81>] syscall_call+0x7/0xb
ALSA sound/core/pcm_lib.c:254: Unexpected hw_pointer value [2] (stream = 0, delta: -538, max jitter = 4456): wrong interrupt acknowledge?
 [<f8be4c89>] snd_pcm_update_hw_ptr+0x139/0x280 [snd_pcm]
 [<f8bdef8e>] snd_pcm_common_ioctl1+0x42e/0xf80 [snd_pcm]
 [<c02e3875>] schedule+0x315/0x640
 [<c02e44ac>] schedule_timeout+0x4c/0xc0
 [<c016c0c8>] poll_freewait+0x48/0x60
 [<f8be00ff>] snd_pcm_playback_ioctl1+0x5f/0x620 [snd_pcm]
 [<f8be11ac>] snd_pcm_kernel_playback_ioctl+0x2c/0x40 [snd_pcm]
 [<f8bf6fa5>] snd_pcm_oss_ioctl+0xa95/0xc10 [snd_pcm_oss]
 [<c016b6d5>] do_ioctl+0x35/0xa0
 [<c016b79d>] vfs_ioctl+0x5d/0x320
 [<c016d4eb>] sys_select+0x11b/0x200
 [<c016baa5>] sys_ioctl+0x45/0x70
 [<c0102d81>] syscall_call+0x7/0xb
ALSA sound/core/pcm_lib.c:138: XRUN: pcmC0D0p
 [<f8be26fe>] snd_pcm_period_elapsed+0x1be/0x3b0 [snd_pcm]
 [<f8b5406e>] snd_intel8x0_interrupt+0x18e/0x240 [snd_intel8x0]
 [<c01366bd>] handle_IRQ_event+0x3d/0x70
 [<c0136766>] __do_IRQ+0x76/0x100
 [<c011cd13>] __do_softirq+0x43/0x90
 [<c0104be9>] do_IRQ+0x19/0x30
 [<c0102f4e>] common_interrupt+0x1a/0x20
ALSA sound/core/pcm_lib.c:254: Unexpected hw_pointer value [2] (stream = 0, delta: -523, max jitter = 4456): wrong interrupt acknowledge?
 [<f8be4c89>] snd_pcm_update_hw_ptr+0x139/0x280 [snd_pcm]
 [<f8bdef8e>] snd_pcm_common_ioctl1+0x42e/0xf80 [snd_pcm]
 [<c02e3875>] schedule+0x315/0x640
 [<c02e44ac>] schedule_timeout+0x4c/0xc0
 [<c016c0c8>] poll_freewait+0x48/0x60
 [<f8be00ff>] snd_pcm_playback_ioctl1+0x5f/0x620 [snd_pcm]
 [<f8be11ac>] snd_pcm_kernel_playback_ioctl+0x2c/0x40 [snd_pcm]
 [<f8bf6fa5>] snd_pcm_oss_ioctl+0xa95/0xc10 [snd_pcm_oss]
 [<c016b6d5>] do_ioctl+0x35/0xa0
 [<c016b79d>] vfs_ioctl+0x5d/0x320
 [<c016d4eb>] sys_select+0x11b/0x200
 [<c016baa5>] sys_ioctl+0x45/0x70
 [<c0102d81>] syscall_call+0x7/0xb

--Multipart=_Wed__7_Jun_2006_01_44_42_-0700_yk/V6zH3ryScZmli--
