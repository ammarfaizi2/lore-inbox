Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132484AbRDQBMF>; Mon, 16 Apr 2001 21:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132493AbRDQBL4>; Mon, 16 Apr 2001 21:11:56 -0400
Received: from wb3-a.mail.utexas.edu ([128.83.126.138]:41743 "HELO
	mail.utexas.edu") by vger.kernel.org with SMTP id <S132484AbRDQBLr>;
	Mon, 16 Apr 2001 21:11:47 -0400
Message-ID: <3ADAF034.C4146DB5@mail.utexas.edu>
Date: Mon, 16 Apr 2001 19:14:28 +0600
From: "Bobby D. Bryant" <bdbryant@mail.utexas.edu>
Organization: (I do not speak for) The University of Texas at Austin (nor they for 
 me).
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-ac7 i686)
X-Accept-Language: en,fr,de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: mj@suse.cz
Subject: PROBLEM: Slowdown for ATA/100 drive on PCI card, after 2.4.3 upgrade.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem:

ATA/100 drive on PCI ATA/100 controller was very fast under 2.4.0 and
2.4.2, but becomes *very* slow under 2.4.3


[2.] Full description of the problem/report:

I have an ATA/100 controller card in a PCI slot, and an ATA/100 drive
hanging off it.  Under kernels 2.4.0 and 2.4.2, /sbin/hdparm -t /dev/hde
reported around 36.6 MB/sec for it, but under 2.4.3 it only gives
something in the range of 4.8 - 5.1 MB/sec.  This is true for 2.4.3-ac5,
-ac6, and -ac7.

Under X, the mouse is very sluggish while hdparm is running, and some
animated applications seem to stall out as well.  They recover as soon
as the test is finished.

Under a console login, I got the message "Spurious 8259A interrupt:
IRQ7" when I ran the hdparm test.

The drive and controller are both Maxtor parts of recent vintage.  Alas,
manufacturers are getting bad about not putting a model number on their
products anymore, so if you need more than you can derive from the
listings below, drop me a line and I'll open my case and try to find
something on the parts' labels.

Before you get too bogged down in the details of my configuration just
below, skip to the bottom and see my note on interrupts.


[3.] Keywords (i.e., modules, networking, kernel):

ata, disk, controller, pci, interrupt, 2.4.3


[4.] Kernel version (from /proc/version):

The problem occurs under 2.4.3-ac5, -ac6, -ac7; it does *not* appear
under 2.4.2.


[5.] Output of Oops.. message (if applicable) with symbolic information
     resolved (see Documentation/oops-tracing.txt)

N/A, however I do get the "Spurious 8259A interrupt: IRQ7" in my
/var/log/messages file intermittently.


[6.] A small shell script or example program which triggers the
     problem (if possible)

N/A, but I can readily reproduce it by rebooting to the various kernels.



[7.] Environment

[7.1.] Software (add the output of the ver_linux script here)

Linux pollux.dioscuri 2.4.3-ac7 #1 Mon Apr 16 12:38:43 GMT-6 2001 i686
unknown

Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.1.0.2
util-linux             2.10p
mount                  2.10r
modutils               2.4.2
e2fsprogs              1.19
reiserfsprogs          3.x.0b
PPP                    2.4.0
Linux C Library        2.2.1
Dynamic linker (ldd)   2.2.1
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         ide-cd cdrom ppp_async ppp_generic slhc
binfmt_misc via686a eeprom lm80 adm1021 sensors i2c-isa i2c-viapro
i2c-core autofs 8139too ipchains sb sb_lib uart401 sound soundcore


[7.2.] Processor information (from /proc/cpuinfo):

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1202.769
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
mca cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2398.61


[7.3.] Module information (from /proc/modules):

ide-cd                 26768   0 (autoclean)
cdrom                  28000   0 (autoclean) [ide-cd]
ppp_async               6096   1 (autoclean)
ppp_generic            13200   3 (autoclean) [ppp_async]
slhc                    4432   1 (autoclean) [ppp_generic]
binfmt_misc             5824   1
via686a                 8176   0
eeprom                  2960   0
lm80                    5296   0
adm1021                 5248   0 (unused)
sensors                 5920   0 [via686a eeprom lm80 adm1021]
i2c-isa                 1168   0 (unused)
i2c-viapro              3664   0 (unused)
i2c-core               12400   0 [via686a eeprom lm80 adm1021 sensors
i2c-isa i2c-viapro]
autofs                  9248   1 (autoclean)
8139too                10656   1 (autoclean)
ipchains               29600   0 (unused)
sb                      7136   0
sb_lib                 32928   0 [sb]
uart401                 6224   0 [sb_lib]
sound                  53744   0 [sb_lib uart401]
soundcore               3504   5 [sb_lib sound]


[7.4.] Loaded driver and hardware information (/proc/ioports,
/proc/iomem)

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
0213-0213 : isapnp read
0220-022f : soundblaster
02f8-02ff : serial(auto)
0330-0333 : MPU-401 UART
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0a79-0a79 : isapnp write
0cf8-0cff : PCI conf1
5000-500f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
  5000-5007 : via2-smbus
6000-607f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
  6000-607f : via686a
c000-c00f : VIA Technologies, Inc. Bus Master IDE
  c000-c007 : ide0
  c008-c00f : ide1
cc00-cc07 : Promise Technology, Inc. 20267
  cc00-cc07 : ide3
d000-d003 : Promise Technology, Inc. 20267
  d002-d002 : ide3
d400-d407 : Promise Technology, Inc. 20267
  d400-d407 : ide2
d800-d803 : Promise Technology, Inc. 20267
  d802-d802 : ide2
dc00-dc3f : Promise Technology, Inc. 20267
  dc00-dc07 : ide2
  dc08-dc0f : ide3
  dc10-dc3f : PDC20267
e000-e007 : US Robotics/3Com 56K FaxModem Model 5610
  e000-e007 : serial(auto)
e400-e4ff : Realtek Semiconductor Co., Ltd. RTL-8139
  e400-e4ff : 8139too

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000cdfff : Extension ROM
000f0000-000fffff : System ROM
00100000-2fffffff : System RAM
  00100000-001c7149 : Kernel code
  001c714a-001fd77f : Kernel data
d0000000-d3ffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
d4000000-d5ffffff : PCI Bus #01
  d4000000-d5ffffff : Matrox Graphics, Inc. MGA G400 AGP
d6000000-d8ffffff : PCI Bus #01
  d6000000-d6003fff : Matrox Graphics, Inc. MGA G400 AGP
  d7000000-d77fffff : Matrox Graphics, Inc. MGA G400 AGP
da000000-da01ffff : Promise Technology, Inc. 20267
da020000-da0200ff : Realtek Semiconductor Co., Ltd. RTL-8139
  da020000-da0200ff : 8139too
ffff0000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)

00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
(rev 03)
 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
 Latency: 8
 Region 0: Memory at d0000000 (32-bit, prefetchable) [size=64M]
 Capabilities: [a0] AGP version 2.0
  Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2
  Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
 Capabilities: [c0] Power Management version 2
  Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
  Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
(prog-if 00 [Normal decode])
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
 Latency: 0
 Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
 I/O behind bridge: 0000f000-00000fff
 Memory behind bridge: d6000000-d8ffffff
 Prefetchable memory behind bridge: d4000000-d5ffffff
 BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-
 Capabilities: [80] Power Management version 2
  Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
  Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 40)
 Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
 Latency: 0
 Capabilities: [c0] Power Management version 2
  Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
  Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
 Subsystem: VIA Technologies, Inc. Bus Master IDE
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
 Latency: 32
 Region 4: I/O ports at c000 [size=16]
 Capabilities: [c0] Power Management version 2
  Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
  Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
40)
 Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
 Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
 Capabilities: [68] Power Management version 2
  Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
  Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Unknown mass storage controller: Promise Technology, Inc. 20267
(rev 02)
 Subsystem: Promise Technology, Inc.: Unknown device 4d33
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
 Latency: 32
 Interrupt: pin A routed to IRQ 11
 Region 0: I/O ports at d400 [size=8]
 Region 1: I/O ports at d800 [size=4]
 Region 2: I/O ports at cc00 [size=8]
 Region 3: I/O ports at d000 [size=4]
 Region 4: I/O ports at dc00 [size=64]
 Region 5: Memory at da000000 (32-bit, non-prefetchable) [size=128K]
 Expansion ROM at <unassigned> [disabled] [size=64K]
 Capabilities: [58] Power Management version 1
  Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
  Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Serial controller: US Robotics/3Com 56K FaxModem Model 5610 (rev
01) (prog-if 02 [16550])
 Subsystem: US Robotics/3Com: Unknown device 00d7
 Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
 Interrupt: pin A routed to IRQ 9
 Region 0: I/O ports at e000 [size=8]
 Capabilities: [dc] Power Management version 2
  Flags: PMEClk- DSI- D1- D2+ AuxCurrent=0mA
PME(D0+,D1-,D2+,D3hot+,D3cold+)
  Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0c.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139
(rev 10)
 Subsystem: Realtek Semiconductor Co., Ltd. RT8139
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
 Latency: 32 (8000ns min, 16000ns max)
 Interrupt: pin A routed to IRQ 11
 Region 0: I/O ports at e400 [size=256]
 Region 1: Memory at da020000 (32-bit, non-prefetchable) [size=256]
 Expansion ROM at <unassigned> [disabled] [size=64K]
 Capabilities: [50] Power Management version 2
  Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
  Status: D0 PME-Enable+ DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP
(rev 82) (prog-if 00 [VGA])
 Subsystem: Matrox Graphics, Inc.: Unknown device 0641
 Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
 Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
 Latency: 64 (4000ns min, 8000ns max), cache line size 08
 Interrupt: pin A routed to IRQ 10
 Region 0: Memory at d4000000 (32-bit, prefetchable) [size=32M]
 Region 1: Memory at d6000000 (32-bit, non-prefetchable) [size=16K]
 Region 2: Memory at d7000000 (32-bit, non-prefetchable) [size=8M]
 Expansion ROM at <unassigned> [disabled] [size=128K]
 Capabilities: [dc] Power Management version 2
  Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
  Status: D0 PME-Enable- DSel=0 DScale=0 PME-
 Capabilities: [f0] AGP version 2.0
  Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
  Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x1


[7.6.] SCSI information (from /proc/scsi/scsi)

N/A


[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

>From /proc/interrupts:

           CPU0
  0:     236537          XT-PIC  timer
  1:       8093          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  4:          3          XT-PIC  serial
  5:          2          XT-PIC  soundblaster
  8:          1          XT-PIC  rtc
  9:      95604          XT-PIC  serial
 11:     276854          XT-PIC  ide2, ide3, eth0
 12:      85293          XT-PIC  PS/2 Mouse
 14:       7542          XT-PIC  ide0
 15:      69059          XT-PIC  ide1
NMI:          0
LOC:     236502
ERR:         90
MIS:          0


[X.] Other notes, patches, fixes, workarounds:

Between 2.4.2 and 2.4.3 something seems to have jacked my interrupts
around.  I had all my toys working under 2.4.2, but the first time I
booted to 2.4.3 the Kudzu program "detected" that I had removed my PCI
modem and "detected" that I had a new one as well, and thus switched it
from ttyS2 to ttyS4.  It wants to do the opposite if I ever boot back to
2.4.2.


N.B. -- I will be glad to provide more info or run some tests, but I am
not a linux-kernel subscriber, so please CC me if you reply with such
requests.

Thanks,

Bobby Bryant
Austin, Texas


