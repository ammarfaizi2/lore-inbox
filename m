Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317338AbSFGVAg>; Fri, 7 Jun 2002 17:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317344AbSFGVAf>; Fri, 7 Jun 2002 17:00:35 -0400
Received: from bird2.de.uu.net ([193.101.111.28]:26792 "EHLO bird2.de.uu.net")
	by vger.kernel.org with ESMTP id <S317338AbSFGVAc>;
	Fri, 7 Jun 2002 17:00:32 -0400
Date: Fri, 7 Jun 2002 22:58:07 +0200
From: Hans Streibel <hans@streibel.net>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Access to (external?) EXT2 file system is much too slow
Message-ID: <20020607225807.A2198@df8xq-l.streibel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello to all of you,

this mail is meant to be a bug report.
Please send replies not only to this email list but also (CC)
to me (hans@streibel.net) because I am not a member of this list.

1. Problem:
===========
Writing files to (external?) media with an EXT2 file system is very very slow.

2. Full Description:
====================
I recognized this problem while copying files to external media like a floppy
disk or to my SCSI Zip (100) drive. Both media had an EXT2 file system. The
copying did succeed without any errors. However here are the times. I copied a
1MB file:
- about 11 (!!!) minutes to write it to a floppy (ext2)
- more than 2 minutes to write it to a ZIP media (ext2)

After that I formatted both media with a vfat file system (mkdosfs) and
made the same copies again. Here is the timing:
- about 1 minute to write it to a floppy
- maybe 3-5 seconds(!) to write it to the ZIP media
Both measures include a "sync-ing".

3. Keywords:
============
EXT2, speed, floppy, ZIP-drive, SCSI, Symbios

4. Kernel Version:
==================
Linux version 2.4.18 (root@df8xq-l)
(gcc version 2.95.3 20010315 (SuSE)) #9 Wed Jun 5 20:03:55 CEST 2002

6. How to trigger this problem:
===============================
cp ... /floppy
cp ... /media/zip

7. Environment:
===============
This is in essence a SuSE 7.3 system. But I compiled the linux kernel 2.4.18.

7.1 Software:
=============
df8xq-l:/usr/src/linux/scripts # ./ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.
 
Linux df8xq-l 2.4.18 #9 Wed Jun 5 20:03:55 CEST 2002 i586 unknown
 
Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11.90.0.29
util-linux             2.11i
mount                  2.11i
modutils               2.4.8
e2fsprogs              1.24a
reiserfsprogs          3.x.0k-pre9
PPP                    2.4.1
Linux C Library        x    1 root     root      1384168 Sep 20  2001 /lib/libc.so.6
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.04
Sh-utils               2.0
Modules Loaded         snd-pcm-oss snd-mixer-oss snd-sb16 isa-pnp snd-sb16-dsp snd-pcm snd-opl3-lib snd-timer snd-sb16-csp snd-sb-common snd-hwdep snd-mpu401-uart snd-rawmidi ppp_deflate snd-seq-device snd bsd_comp soundcore ppp_async ppp_generic slhc floppy isofs parport_pc lp parport usb-ohci usbcore ne2k-pci 8390

7.2 Processor:
==============
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 0
cpu MHz         : 300.689
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 mmx syscall 3dnow
bogomips        : 599.65

7.3 Module information:
=======================
nls_iso8859-1           2880   4 (autoclean)
msdos                   4752   0 (autoclean)
vfat                    9168   2 (autoclean)
fat                    28768   0 (autoclean) [msdos vfat]
snd-pcm-oss            34400   0 (autoclean)
snd-mixer-oss           8656   1 (autoclean)
snd-sb16                4512   1 (autoclean)
isa-pnp                27760   0 (autoclean) [snd-sb16]
snd-sb16-dsp            5168   0 (autoclean) [snd-sb16]
snd-pcm                46624   0 (autoclean) [snd-pcm-oss snd-sb16-dsp]
snd-opl3-lib            5104   0 (autoclean) [snd-sb16]
snd-timer               9008   0 (autoclean) [snd-pcm snd-opl3-lib]
snd-sb16-csp           14992   0 (autoclean) [snd-sb16]
snd-sb-common           5984   0 (autoclean) [snd-sb16 snd-sb16-dsp snd-sb16-csp]
snd-hwdep               3440   0 (autoclean) [snd-opl3-lib snd-sb16-csp]
snd-mpu401-uart         2560   0 (autoclean) [snd-sb16 snd-sb16-dsp]
snd-rawmidi            11744   0 (autoclean) [snd-mpu401-uart]
ppp_deflate            39040   0 (autoclean)
snd-seq-device          3696   0 (autoclean) [snd-opl3-lib snd-rawmidi]
snd                    23488   0 (autoclean) [snd-pcm-oss snd-mixer-oss snd-sb16 snd-sb16-dsp snd-pcm snd-opl3-lib snd-timer snd-sb16-csp snd-sb-common snd-hwdep snd-mpu401-uart snd-rawmidi snd-seq-device]
bsd_comp                3968   0 (autoclean)
soundcore               3472   6 (autoclean) [snd]
ppp_async               6064   0 (autoclean)
ppp_generic            14048   0 (autoclean) [ppp_deflate bsd_comp ppp_async]
slhc                    4384   0 (autoclean) [ppp_generic]
floppy                 44720   2 (autoclean)
isofs                  16816   0 (autoclean)
parport_pc             14448   1 (autoclean)
lp                      5664   0 (autoclean)
parport                24480   1 (autoclean) [parport_pc lp]
usb-ohci               17424   0 (unused)
usbcore                47872   1 [usb-ohci]
ne2k-pci                4736   1 (autoclean)
8390                    5856   0 (autoclean) [ne2k-pci]

7.4 Loaded driver and hardware information:
===========================================
df8xq-l:/usr/src/linux # cat /proc/ioports
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
0213-0213 : isapnp read
0220-022f : SoundBlaster
02f8-02ff : serial(auto)
0330-0331 : MPU401 UART
0376-0376 : ide1
0378-037a : parport0
0388-0389 : OPL2/3 (left)
038a-038b : OPL2/3 (right)
03c0-03df : vga+
03f0-03f5 : floppy
03f6-03f6 : ide0
03f7-03f7 : floppy DIR
03f8-03ff : serial(auto)
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
5c20-5c3f : Acer Laboratories Inc. [ALi] M7101 PMU
a800-a80f : Acer Laboratories Inc. [ALi] M5229 IDE
  a800-a807 : ide0
  a808-a80f : ide1
b000-b01f : Realtek Semiconductor Co., Ltd. RTL-8029(AS)
  b000-b01f : ne2k-pci
b400-b4ff : LSI Logic / Symbios Logic (formerly NCR) 53c860
  b400-b47f : sym53c8xx
b800-b8ff : Adaptec AHA-7850
  b800-b8ff : aic7xxx
d000-dfff : PCI Bus #01
  d800-d8ff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
df8xq-l:/usr/src/linux # 
df8xq-l:/usr/src/linux # 
df8xq-l:/usr/src/linux # cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-07ffbfff : System RAM
  00100000-002213c4 : Kernel code
  002213c5-0027b157 : Kernel data
07ffc000-07ffefff : ACPI Tables
07fff000-07ffffff : ACPI Non-volatile Storage
de000000-de0000ff : LSI Logic / Symbios Logic (formerly NCR) 53c860
de800000-de800fff : Adaptec AHA-7850
  de800000-de800fff : aic7xxx
df000000-df000fff : Acer Laboratories Inc. [ALi] M5237 USB
  df000000-df000fff : usb-ohci
df800000-dfffffff : PCI Bus #01
  df800000-df800fff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
e0000000-e3ffffff : Acer Laboratories Inc. [ALi] M1541
e5800000-e5800fff : Brooktree Corporation Bt878
e6000000-e6000fff : Brooktree Corporation Bt878
e6f00000-e7ffffff : PCI Bus #01
  e7000000-e7ffffff : ATI Technologies Inc 3D Rage Pro AGP 1X/2X
ffff0000-ffffffff : reserved

7.5 PCI information:
====================
df8xq-l:/usr/src/linux # lspci -vvv
00:00.0 Host bridge: Acer Laboratories Inc. [ALi] M1541 (rev 04)
	Subsystem: Acer Laboratories Inc. [ALi] ALI M1541 Aladdin V/V+ AGP System Controller
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 64
	Region 0: Memory at e0000000 (32-bit, non-prefetchable) [size=64M]
	Capabilities: [b0] AGP version 1.0
		Status: RQ=28 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
	Capabilities: [e0] #00 [0000]

00:01.0 PCI bridge: Acer Laboratories Inc. [ALi] M5243 (rev 04) (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
	I/O behind bridge: 0000d000-0000dfff
	Memory behind bridge: df800000-dfffffff
	Prefetchable memory behind bridge: e6f00000-e7ffffff
	BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:02.0 USB Controller: Acer Laboratories Inc. [ALi] M5237 USB (rev 03) (prog-if 10 [OHCI])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Latency: 64 (20000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: Memory at df000000 (32-bit, non-prefetchable) [size=4K]

00:03.0 Bridge: Acer Laboratories Inc. [ALi] M7101 PMU
	Subsystem: Acer Laboratories Inc. [ALi] ALI M7101 Power Management Controller
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:07.0 ISA bridge: Acer Laboratories Inc. [ALi] M1533 PCI to ISA Bridge [Aladdin IV] (rev c3)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
	Latency: 0

00:09.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)
	Subsystem: Adaptec AHA-2904/Integrated AIC-7850
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 1000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at b800 [disabled] [size=256]
	Region 1: Memory at de800000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 SCSI storage controller: LSI Logic Corp. / Symbios Logic Inc. (formerly NCR) 53c860 (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min, 16000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at b400 [size=256]
	Region 1: Memory at de000000 (32-bit, non-prefetchable) [size=256]

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at b000 [size=32]

00:0c.0 Multimedia video controller: Brooktree Corporation Bt878 (rev 11)
	Subsystem: Avermedia Technologies Inc: Unknown device 0003
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e6000000 (32-bit, prefetchable) [size=4K]
	Capabilities: [44] Vital Product Data
	Capabilities: [4c] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.1 Multimedia controller: Brooktree Corporation Bt878 (rev 11)
	Subsystem: Avermedia Technologies Inc: Unknown device 0003
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at e5800000 (32-bit, prefetchable) [size=4K]
	Capabilities: [44] Vital Product Data
	Capabilities: [4c] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 IDE interface: Acer Laboratories Inc. [ALi] M5229 IDE (rev c1) (prog-if fa)
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 1000ns max)
	Interrupt: pin A routed to IRQ 0
	Region 4: I/O ports at a800 [size=16]

01:00.0 VGA compatible controller: ATI Technologies Inc 3D Rage Pro AGP 1X/2X (rev 5c) (prog-if 00 [VGA])
	Subsystem: ATI Technologies Inc: Unknown device 0080
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop+ ParErr- Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (2000ns min), cache line size 08
	Region 0: Memory at e7000000 (32-bit, prefetchable) [size=16M]
	Region 1: I/O ports at d800 [size=256]
	Region 2: Memory at df800000 (32-bit, non-prefetchable) [size=4K]
	Expansion ROM at e6fe0000 [disabled] [size=128K]
	Capabilities: [50] AGP version 1.0
		Status: RQ=255 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

7.6 SCSI information:
=====================
df8xq-l:/usr/src/linux # cat /proc/scsi/scsi
Attached devices: 
Host: scsi1 Channel: 00 Id: 03 Lun: 00
  Vendor: TEAC     Model: CD-R55S          Rev: 1.0L
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 04 Lun: 00
  Vendor: PIONEER  Model: CD-ROM DR-124X   Rev: 1.08
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 05 Lun: 00
  Vendor: IOMEGA   Model: ZIP 100          Rev: E.08
  Type:   Direct-Access                    ANSI SCSI revision: 02


X. Other notes:
===============
I noticed this problem after I had switched from kernel 2.2.18pre21 to 2.4.18:
- First of all I thought it would be a problem of the SCSI driver for the zip
  drive. But it isn't. I tried both of the Symbios SCSI drivers (both
  compiled into the kernel) and got the same results. 
- I think we can exclude cable problems here because both the zip drive and
  the floppy disk show up the same problem.
- I booted up an old kernel (2.2.18pre21) after I had switched over to
  Suse 7.3 (and my new kernel 2.4.18). Access to the Zip drive was about 5
  times faster (fast enough?). I did not check the access time to my
  floppy drive.

