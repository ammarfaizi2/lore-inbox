Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279103AbRKHNLF>; Thu, 8 Nov 2001 08:11:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279113AbRKHNK4>; Thu, 8 Nov 2001 08:10:56 -0500
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:15118 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S279103AbRKHNKp> convert rfc822-to-8bit; Thu, 8 Nov 2001 08:10:45 -0500
X-Apparently-From: <murilopontes@yahoo.com.br>
Content-Type: text/plain; charset=US-ASCII
From: Murilo Rebelo Pontes <murilopontes@yahoo.com.br>
Reply-To: murilopontes@yahoo.com.br
Organization: Linux
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: DMA Disable by lost IRQ
Date: Thu, 8 Nov 2001 11:07:45 -0300
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011108131052Z279103-17408+12260@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:
PROBLEM: DMA Disable by lost IRQ

####################################################################

[2.] Full description of the problem/report:
Bug in PCI IRQ routing, causes fail in detect of IRQ from SIS5513 IDE controller, this
crash system in the copy of files >300MB or serevel files (+ - 1000 files ).
I try use pci=pcibios , but no solve this problem
I easy reproduce bug with:
hdparm -d0 /dev/hda

####################################################################

[3.] Keywords (i.e., modules, networking, kernel):
IRQ

####################################################################

[4.] Kernel version (from /proc/version):
10:45:42 root@localhost:~#cat /proc/version
Linux version 2.4.13 (root@localhost.localdomain) (gcc version 2.95.3 20010315 (release)) #5 Qui Nov 8 10:38:57 BRT 2001
10:57:56 root@localhost:~#

####################################################################

[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

####################################################################

[6.] A small shell script or example program which triggers the
     problem (if possible)

####################################################################

[7.] Environment

####################################################################

[7.1.] Software (add the output of the ver_linux script here)
11:00:44 root@localhost:/#sh /usr/src/linux/scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux localhost.localdomain 2.4.13 #5 Qui Nov 8 10:38:57 BRT 2001 i686 unknown

Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.11.2
util-linux             2.11l
mount                  2.11l
modutils               2.4.9
e2fsprogs              1.25
reiserfsprogs          3.x.0j
PPP                    2.4.0
Linux C Library        2.2.4
Dynamic linker (ldd)   2.2.4
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0
Modules Loaded         vmnet vmmon snd-pcm-oss snd-pcm-plugin snd-mixer-oss snd-card-cmipci snd-mixer snd-pcm snd-timer snd-mpu401-uart snd-rawmidi snd ptserial pctel
11:00:57 root@localhost:/#

####################################################################

[7.2.] Processor information (from /proc/cpuinfo):
11:00:57 root@localhost:/#cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 5
model name      : Pentium II (Deschutes)
stepping        : 0
cpu MHz         : 334.095
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips        : 666.82

11:01:50 root@localhost:/#
####################################################################

[7.3.] Module information (from /proc/modules):
11:01:50 root@localhost:/#cat /proc/modules
vmnet                  17568   0 (unused)
vmmon                  18132   0 (unused)
snd-pcm-oss            18112   0 (unused)
snd-pcm-plugin         14192   0 [snd-pcm-oss]
snd-mixer-oss           4896   1 [snd-pcm-oss]
snd-card-cmipci        20704   1
snd-mixer              23880   0 [snd-mixer-oss snd-card-cmipci]
snd-pcm                30208   0 [snd-pcm-oss snd-pcm-plugin snd-card-cmipci]
snd-timer               8416   0 [snd-pcm]
snd-mpu401-uart         2384   0 [snd-card-cmipci]
snd-rawmidi             9888   0 [snd-mpu401-uart]
snd                    32864   1 [snd-pcm-oss snd-pcm-plugin snd-mixer-oss snd-card-cmipci snd-mixer snd-pcm snd-timer snd-mpu401-uart snd-rawmidi]
ptserial               46336   0 (unused)
pctel                 705904   0 [ptserial]
11:02:21 root@localhost:/#
####################################################################

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
11:03:00 root@localhost:/#cat /proc/ioports ; echo  ; cat /proc/iomem
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
0070-007f : rtc
0080-008f : dma page reg
00a0-00bf : pic2
00c0-00df : dma2
00f0-00ff : fpu
01f0-01f7 : ide0
0378-037a : parport0
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
c000-cfff : PCI Bus #01
  cc00-cc7f : Silicon Integrated Systems [SiS] 6306 3D-AGP
da00-da3f : PCTel Inc HSP MicroModem 56
dc00-dcff : C-Media Electronics Inc CM8338A
  dc00-dcff : C-Media PCI
de00-de1f : Realtek Semiconductor Co., Ltd. RTL-8029(AS)
  de00-de1f : ne2k-pci
ffa0-ffaf : Silicon Integrated Systems [SiS] 5513 [IDE]
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-177effff : System RAM
  00100000-0020b1f5 : Kernel code
  0020b1f6-0024f463 : Kernel data
177f0000-177f7fff : ACPI Tables
177f8000-177fffff : ACPI Non-volatile Storage
cec00000-cfcfffff : PCI Bus #01
  cf000000-cf7fffff : Silicon Integrated Systems [SiS] 6306 3D-AGP
cfe00000-cfefffff : PCI Bus #01
  cfef0000-cfefffff : Silicon Integrated Systems [SiS] 6306 3D-AGP
d0000000-dfffffff : Silicon Integrated Systems [SiS] 620 Host
ffef0000-ffefffff : reserved
ffff0000-ffffffff : reserved
11:03:13 root@localhost:/#
####################################################################

[7.5.] PCI information ('lspci -vvv' as root)
00:00.0 Host bridge: Silicon Integrated Systems [SiS] 620 Host (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=256M]
	Capabilities: [c0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:00.1 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE] (rev d0) (prog-if 80 [Master])
	Subsystem: Silicon Integrated Systems [SiS] SiS5513 EIDE Controller (A,B step)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 16
	Interrupt: pin A routed to IRQ 0
	Region 0: I/O ports at <ignored>
	Region 1: I/O ports at <ignored>
	Region 2: I/O ports at <ignored>
	Region 3: I/O ports at <ignored>
	Region 4: I/O ports at ffa0 [size=16]

00:01.0 ISA bridge: Silicon Integrated Systems [SiS] 85C503/5513 (rev b1)
	Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0

00:01.1 Class ff00: Silicon Integrated Systems [SiS] ACPI
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:02.0 PCI bridge: Silicon Integrated Systems [SiS] 5591/5592 AGP (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	I/O behind bridge: 0000c000-0000cfff
	Memory behind bridge: cfe00000-cfefffff
	Prefetchable memory behind bridge: cec00000-cfcfffff
	BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8029(AS)
	Subsystem: Realtek Semiconductor Co., Ltd. RT8029(AS)
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at de00 [size=32]

00:0f.0 Multimedia audio controller: C-Media Electronics Inc CM8338A (rev 10)
	Subsystem: C-Media Electronics Inc: Unknown device 0000
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 12
	Region 0: I/O ports at dc00 [size=256]
	Capabilities: [c0] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 Communication controller: PCTel Inc HSP MicroModem 56 (rev 01)
	Subsystem: PCTel Inc HSP MicroModem 56
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR+
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at da00 [size=64]
	Capabilities: [40] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=55mA PME(D0+,D1-,D2+,D3hot+,D3cold+)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Silicon Integrated Systems [SiS] 6306 3D-AGP (rev 2a) (prog-if 00 [VGA])
	Subsystem: Silicon Integrated Systems [SiS] SiS530,620 GUI Accelerator+3D
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (500ns min)
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at cf000000 (32-bit, prefetchable) [size=8M]
	Region 1: Memory at cfef0000 (32-bit, non-prefetchable) [size=64K]
	Region 2: I/O ports at cc00 [size=128]
	Capabilities: [40] Power Management version 1
		Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [50] AGP version 1.0
		Status: RQ=1 SBA- 64bit- FW- Rate=x1,x2
		Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>



####################################################################

[7.6.] SCSI information (from /proc/scsi/scsi)

####################################################################

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
SIS5513: IDE controller on PCI bus 00 dev 01
PCI: No IRQ known for interrupt pin A of device 00:00.1. Please try using pci=biosirq.
SIS5513: chipset revision 208
SIS5513: not 100% native mode: will probe irqs later
SiS620
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:pio
hda: ST320413A, ATA DISK drive
hdb: MATSHITA CR-585, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 39102336 sectors (20020 MB) w/512KiB Cache, CHS=2434/255/63, UDMA(33)

####################################################################

[X.] Other notes, patches, fixes, workarounds:



####################################################################
Murilo Rebelo Pontes

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

