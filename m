Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbTLPIoG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 03:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261270AbTLPIoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 03:44:06 -0500
Received: from smtp14.fre.skanova.net ([195.67.227.31]:11988 "EHLO
	smtp14.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261193AbTLPInu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 03:43:50 -0500
Message-ID: <3FDEC5BE.2070200@ida.liu.se>
Date: Tue, 16 Dec 2003 09:43:42 +0100
From: Ola Leifler <olale@ida.liu.se>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031020 Debian/1.5-1
X-Accept-Language: sv, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: olale@ida.liu.se
Subject: PROBLEM: siimage.o on AMD768 platform
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
[Formatted according to 
http://www.kernel.org/pub/linux/docs/lkml/reporting-bugs.html]
1. Brief description:
My Silicon Image 3112A controller doesn't recognize any of the two 
Seagate 7200.7 80Gb discs attached to it. Neither do the ide2/ide3 
interfaces show up in /proc, according to the information below.

2. Full description:
When using siimage.o  to access a  dual channel Serial ATA controller 
with a Silicon Image 3112 chipset, none of the two hard discs are 
detected (No program can access /dev/hd[e-h]). However, the module 
refuses to unload (device busy).  During boot, the card BIOS lists both 
discs.

3. Keywords:
modules, sata, siimage.o, amd768

4. Version information from /proc/version
Linux version 2.4.23 (root@localhost) (gcc version 3.2.3 (Debian)) #1 
SMP mån dec 15 20:19:54 CET 2003

7. Environment
7.1 scripts/ver_linux output
 
Gnu C                  3.2.3
Gnu make               3.80
binutils               2.13.90.0.18
util-linux             2.12
mount                  2.11u
modutils               2.4.25
e2fsprogs              1.34-WIP
Linux C Library        2.3.2
Dynamic linker (ldd)   2.3.2
Procps                 3.1.14
Net-tools              1.60
Kbd                    1.06
Sh-utils               5.0
Modules Loaded         nvidia sg sr_mod autofs4 snd-seq-midi snd-seq-oss 
snd-seq-midi-event snd-seq snd-pcm-oss snd-mixer-oss snd-cmipci snd-pcm 
snd-page-alloc snd-opl3-lib snd-hwdep snd-timer snd-mpu401-uart 
snd-rawmidi snd-seq-device snd soundcore ipt_MASQUERADE ipt_state 
iptable_nat ip_conntrack iptable_filter ip_tables af_packet w83781d 
i2c-proc i2c-amd756 i2c-dev i2c-core ide-scsi siimage tulip crc32 rtc unix

7.2 Processor information from /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(TM) MP 1700+
stepping        : 2
cpu MHz         : 1466.768
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 2922.90

processor       : 1
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(TM) MP 1700+
stepping        : 2
cpu MHz         : 1466.768
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 2929.45

7.3 Module information from /proc/modules
nvidia               1629504  22 (autoclean)
sg                     33644   0 (autoclean)
sr_mod                 16120   0 (autoclean)
autofs4                10420   1 (autoclean)
snd-seq-midi            4096   0 (autoclean) (unused)
snd-seq-oss            29920   0 (unused)
snd-seq-midi-event      3488   0 [snd-seq-midi snd-seq-oss]
snd-seq                40464   2 [snd-seq-midi snd-seq-oss 
snd-seq-midi-event]
snd-pcm-oss            38148   0 (unused)
snd-mixer-oss          13328   0 [snd-pcm-oss]
snd-cmipci             20992   0
snd-pcm                63168   0 [snd-pcm-oss snd-cmipci]
snd-page-alloc          6260   0 [snd-pcm]
snd-opl3-lib            6852   0 [snd-cmipci]
snd-hwdep               5440   0 [snd-opl3-lib]
snd-timer              15748   0 [snd-seq snd-pcm snd-opl3-lib]
snd-mpu401-uart         3600   0 [snd-cmipci]
snd-rawmidi            14176   0 [snd-seq-midi snd-mpu401-uart]
snd-seq-device          4244   0 [snd-seq-midi snd-seq-oss snd-seq 
snd-opl3-lib snd-rawmidi]
snd                    34436   0 [snd-seq-midi snd-seq-oss 
snd-seq-midi-event snd-seq snd-pcm-oss snd-mixer-oss snd-cmipci snd-pcm 
snd-opl3-lib snd-hwdep snd-timer snd-mpu401-uart snd-rawmidi snd-seq-device]
soundcore               4356   8 [snd]
ipt_MASQUERADE          1880   1 (autoclean)
ipt_state                568  25 (autoclean)
iptable_nat            17688   1 (autoclean) [ipt_MASQUERADE]
ip_conntrack           22984   2 (autoclean) [ipt_MASQUERADE ipt_state 
iptable_nat]
iptable_filter          1740   1 (autoclean)
ip_tables              13152   6 [ipt_MASQUERADE ipt_state iptable_nat 
iptable_filter]
af_packet              14856   2 (autoclean)
w83781d                22608   0 (unused)
i2c-proc                6292   0 [w83781d]
i2c-amd756              2952   0 (unused)
i2c-dev                 4096   0 (unused)
i2c-core               14212   0 [w83781d i2c-proc i2c-amd756 i2c-dev]
ide-scsi               10480   0
siimage                 8964   1
tulip                  40960   2
crc32                   2880   0 [tulip]
rtc                     7644   0 (autoclean)
unix                   17512  47 (autoclean)

7.4 Loaded driver and hardware information from /proc/ioports first, 
/proc/iomem next
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
0330-0331 : MPU401 UART
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
a000-cfff : PCI Bus #02
  a400-a40f : CMD Technology Inc Silicon Image SiI 3112 SATARaid Controller
  a800-a803 : CMD Technology Inc Silicon Image SiI 3112 SATARaid Controller
  b000-b007 : CMD Technology Inc Silicon Image SiI 3112 SATARaid Controller
  b400-b403 : CMD Technology Inc Silicon Image SiI 3112 SATARaid Controller
  b800-b807 : CMD Technology Inc Silicon Image SiI 3112 SATARaid Controller
  c000-c0ff : LSI Logic / Symbios Logic 53c895
    c000-c07f : sym53c8xx
  c400-c4ff : Accton Technology Corporation EN-1216 Ethernet Adapter (#2)
    c400-c4ff : tulip
  c800-c8ff : C-Media Electronics Inc CM8738
    c800-c8ff : CMI8738-MC6
d400-d4ff : Accton Technology Corporation EN-1216 Ethernet Adapter
  d400-d4ff : tulip
d800-d80f : Advanced Micro Devices [AMD] AMD-768 [Opus] IDE
  d800-d807 : ide0
  d808-d80f : ide1
e4e0-e4ef : amd756-smbus
e800-e803 : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System 
Controller

00000000-0009f3ff : System RAM
0009f400-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000d0000-000d1fff : Extension ROM
000d4000-000d87ff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffebfff : System RAM
  00100000-00252dfd : Kernel code
  00252dfe-002a5da3 : Kernel data
1ffec000-1ffeefff : ACPI Tables
1ffef000-1fffefff : reserved
1ffff000-1fffffff : ACPI Non-volatile Storage
db000000-dd7fffff : PCI Bus #02
  db000000-db0001ff : CMD Technology Inc Silicon Image SiI 3112 SATARaid 
Controller
    db000000-db0001ff : SiI3112 Serial ATA
  db800000-db800fff : LSI Logic / Symbios Logic 53c895
  dc000000-dc0000ff : LSI Logic / Symbios Logic 53c895
  dc800000-dc8003ff : Accton Technology Corporation EN-1216 Ethernet 
Adapter (#2)
    dc800000-dc8003ff : tulip
dd800000-dd8003ff : Accton Technology Corporation EN-1216 Ethernet Adapter
  dd800000-dd8003ff : tulip
de000000-df4fffff : PCI Bus #01
  de000000-deffffff : nVidia Corporation NV20 [GeForce3 Ti 200]
df500000-df5fffff : PCI Bus #02
df700000-ef7fffff : PCI Bus #01
  df800000-df87ffff : nVidia Corporation NV20 [GeForce3 Ti 200]
  e0000000-e7ffffff : nVidia Corporation NV20 [GeForce3 Ti 200]
ef800000-ef800fff : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] 
System Controller
f0000000-f7ffffff : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] 
System Controller
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

7.5 PCI information from lspci -vvv as root
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] 
System Controller (rev 11)
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
    Latency: 32
    Region 0: Memory at f0000000 (32-bit, prefetchable) [size=128M]
    Region 1: Memory at ef800000 (32-bit, prefetchable) [size=4K]
    Region 2: I/O ports at e800 [disabled] [size=4]
    Capabilities: [a0] AGP version 2.0
        Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
64bit- FW- AGP3- Rate=x1,x2,x4
        Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW- Rate=x4

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] 
AGP Bridge (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0
    Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
    I/O behind bridge: 0000e000-0000dfff
    Memory behind bridge: de000000-df4fffff
    Prefetchable memory behind bridge: df700000-ef7fffff
    BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 04)
    Subsystem: Asustek Computer, Inc. A7M-D Mainboard
    Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE 
(rev 04) (prog-if 8a [Master SecP PriP])
    Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32
    Region 4: I/O ports at d800 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 03)
    Subsystem: Asustek Computer, Inc. A7M-D Mainboard
    Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-

00:09.0 Ethernet controller: Accton Technology Corporation EN-1216 
Ethernet Adapter (rev 11)
    Subsystem: Standard Microsystems Corp [SMC]: Unknown device 1255
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32 (63750ns min, 63750ns max), Cache Line Size: 0x08 (32 bytes)
    Interrupt: pin A routed to IRQ 17
    Region 0: I/O ports at d400 [size=256]
    Region 1: Memory at dd800000 (32-bit, non-prefetchable) [size=1K]
    Expansion ROM at <unassigned> [disabled] [size=128K]
    Capabilities: [c0] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=100mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev 
04) (prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
    Latency: 32
    Bus: primary=00, secondary=02, subordinate=02, sec-latency=32
    I/O behind bridge: 0000a000-0000cfff
    Memory behind bridge: db000000-dd7fffff
    Prefetchable memory behind bridge: df500000-df5fffff
    BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

01:05.0 VGA compatible controller: nVidia Corporation NV20 [GeForce3 Ti 
200] (rev a3) (prog-if 00 [VGA])
    Subsystem: CardExpert Technology: Unknown device 0c3c
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 248 (1250ns min, 250ns max)
    Interrupt: pin A routed to IRQ 16
    Region 0: Memory at de000000 (32-bit, non-prefetchable) [size=16M]
    Region 1: Memory at e0000000 (32-bit, prefetchable) [size=128M]
    Region 2: Memory at df800000 (32-bit, prefetchable) [size=512K]
    Expansion ROM at df7f0000 [disabled] [size=64K]
    Capabilities: [60] Power Management version 2
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [44] AGP version 2.0
        Status: RQ=32 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 
64bit- FW- AGP3- Rate=x1,x2,x4
        Command: RQ=16 ArqSz=0 Cal=0 SBA- AGP+ GART64- 64bit- FW- Rate=x4

02:04.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
    Subsystem: Asustek Computer, Inc. CMI8738 6-channel audio controller
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32 (500ns min, 6000ns max)
    Interrupt: pin A routed to IRQ 17
    Region 0: I/O ports at c800 [size=256]
    Capabilities: [c0] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:05.0 Ethernet controller: Accton Technology Corporation EN-1216 
Ethernet Adapter (rev 11)
    Subsystem: Standard Microsystems Corp [SMC]: Unknown device 1255
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32 (63750ns min, 63750ns max), Cache Line Size: 0x08 (32 bytes)
    Interrupt: pin A routed to IRQ 18
    Region 0: I/O ports at c400 [size=256]
    Region 1: Memory at dc800000 (32-bit, non-prefetchable) [size=1K]
    Expansion ROM at <unassigned> [disabled] [size=128K]
    Capabilities: [c0] Power Management version 2
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=100mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:06.0 SCSI storage controller: LSI Logic / Symbios Logic 53c895 (rev 01)
    Subsystem: Tekram Technology Co.,Ltd. DC-390U2W
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ 
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32 (7500ns min, 16000ns max), Cache Line Size: 0x08 (32 bytes)
    Interrupt: pin A routed to IRQ 17
    Region 0: I/O ports at c000 [size=256]
    Region 1: Memory at dc000000 (32-bit, non-prefetchable) [size=256]
    Region 2: Memory at db800000 (32-bit, non-prefetchable) [size=4K]
    Expansion ROM at <unassigned> [disabled] [size=64K]

02:08.0 Unknown mass storage controller: CMD Technology Inc Silicon 
Image SiI 3112 SATARaid Controller (rev 02)
    Subsystem: CMD Technology Inc Silicon Image SiI 3112 SATARaid Controller
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 32, Cache Line Size: 0x01 (4 bytes)
    Interrupt: pin A routed to IRQ 19
    Region 0: I/O ports at b800 [size=8]
    Region 1: I/O ports at b400 [size=4]
    Region 2: I/O ports at b000 [size=8]
    Region 3: I/O ports at a800 [size=4]
    Region 4: I/O ports at a400 [size=16]
    Region 5: Memory at db000000 (32-bit, non-prefetchable) [size=512]
    Expansion ROM at <unassigned> [disabled] [size=512K]
    Capabilities: [60] Power Management version 2
        Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA 
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=2 PME-

7.6 SCSI information from /proc/scsi/scsi

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: SEAGATE  Model: ST318438LW       Rev: 0002
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: ATAPI    Model: CD-RW 52XMax     Rev: 150D
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 01
  Vendor: ATAPI    Model: CD-RW 52XMax     Rev: 150D
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 02
  Vendor: ATAPI    Model: CD-RW 52XMax     Rev: 150D
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 03
  Vendor: ATAPI    Model: CD-RW 52XMax     Rev: 150D
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 04
  Vendor: ATAPI    Model: CD-RW 52XMax     Rev: 150D
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 05
  Vendor: ATAPI    Model: CD-RW 52XMax     Rev: 150D
  Type:   CD-ROM                           ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 06
  Vendor: ATAPI    Model: CD-RW 52XMax     Rev: 150D
  Type:   CD-ROM                           ANSI SCSI revision: 02

7.7 Other information

 From dmesg:
SiI3112 Serial ATA: IDE controller at PCI slot 02:08.0
SiI3112 Serial ATA: chipset revision 2
SiI3112 Serial ATA: not 100% native mode: will probe irqs later
    ide2: MMIO-DMA , BIOS settings: hde:pio, hdf:pio
    ide3: MMIO-DMA , BIOS settings: hdg:pio, hdh:pio

TIA!

/Ola Leifler


