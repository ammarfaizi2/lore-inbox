Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267617AbTA3T6K>; Thu, 30 Jan 2003 14:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267618AbTA3T6K>; Thu, 30 Jan 2003 14:58:10 -0500
Received: from [144.132.128.125] ([144.132.128.125]:9116 "EHLO fsm.dyndns.org")
	by vger.kernel.org with ESMTP id <S267617AbTA3T6E>;
	Thu, 30 Jan 2003 14:58:04 -0500
From: "James Bourne" <james@fsm.com.au>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: drivers/scsi/sd.c - Incorrect Reporting of Blocks and Capacity of Large SCSI Disk Arrays
Date: Fri, 31 Jan 2003 06:07:05 +1000
Message-Id: <20030130200705.M57065@fsm.com.au>
X-Mailer: Open WebMail 1.71 20020917
X-OriginatingIP: 15.17.20.159 (jbourne)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-Scanner: exiscan *18eKxl-0005cJ-00*cs.wUFW6w0A* on Astaro Security Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have attempt to fill out the Bug Report as per REPORTING-BUGS. I have 
attempted to forward the report to the respective authors of the appropriate 
module but the email bounced (-> ericy@andante.org, drew@colorado.edu). 
Please let me know if I can be of further assistance.

Regards,

James

1. drivers/scsi/sd.c - Incorrect Reporting of Blocks and Capacity of Large 
SCSI Disk Arrays

2. The size of very large SCSI Disk arrays is incorrectly reported by code
in 'drivers/scsi/sd.c' as a result of perhaps inadequate precision of field
'capacity' in structure: 'typedef struct scsi_disk' found in drives/scsi/sd.h.

This problem exists on both a custom 2.4.20 kernel and on a stock RedHat 
2.4.18-19.8.0smp kernel. This problem report pertains to the latter kernel.

For example:

SCSI device sdb: -562247552 512-byte hdwr sectors (4294679426 MB)
 sdb: sdb1
SCSI device sdc: -1997908992 512-byte hdwr sectors (76582 MB)
 sdc: sdc1

Server:
   IBM xSeries 220 (2 x PIII 1Ghz, 512MB RAM)
HBAs:
   Onboard Adaptec HBA to 1 x 36GB HDD
   Offboard Adaptec AHA39160 HBA in slot 4 (64-bit/33Mhz)
Channels:
   Channel A connected to Adaptec Durstor 6220SS
   Channel B connected to Quantum ATL 1500 (2 x SDLT320, 20-slots)
Storage:
   Adaptec Durstor 6220SS Connected to 3 Adaptec 312R JBODs
   Each JBOD populated with 8 x 147GB Fujitsu HDD (MAP3147NC)
RAID:
   RAID-3 Array 1 created comprising 14 x HDD (@ 140201MB per spindle)
   RAID-3 Array 2 created comprising 9 x HDD (@ 140201MB per spindle)
Spares:
   One pool spare allocated
Array Capacity
   Total unformatted capacity for Array 1: 1962814MB (1916.81GB, 1.87TB)
   Total unformatted capacity for Array 2: 1261809MB (1232.23GB, 1.20TB)
Partition
   Array 1: Single Partition
   Array 2: Single Partition
FileSystem:
   Array 1: EXT3
   Array 2: EXT3

3. scsi, modules, kernel

4. Linux version 2.4.18-19.8.0smp (bhcompile@stripples.devel.redhat.com) (gcc 
version 3.2 20020903 (Red Hat Linux 8.0 3.2-7)) #1 SMP Thu Dec 12 04:36:25 
EST 2002

5. From dmesg:

SCSI subsystem driver Revision: 1.00
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
       <Adaptec aic7892 Ultra160 SCSI adapter>
       aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
       <Adaptec 3960D Ultra160 SCSI adapter>
       aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs

scsi2 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
       <Adaptec 3960D Ultra160 SCSI adapter>
       aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs

blk: queue c251a618, I/O limit 4095Mb (mask 0xffffffff)
 Vendor: IBM-PSG   Model: DDYS-T36950M  M   Rev: S9HA
 Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue c251a418, I/O limit 4095Mb (mask 0xffffffff)
 Vendor: IBM       Model: YGLv3 S2          Rev: 0   
 Type:   Processor                          ANSI SCSI revision: 02
blk: queue dfd1be18, I/O limit 4095Mb (mask 0xffffffff)
scsi0:A:0:0: Tagged Queuing enabled.  Depth 253
blk: queue dfd1be18, I/O limit 4095Mb (mask 0xffffffff)
 Vendor: Adaptec   Model: DuraStor 6200S    Rev: L421
 Type:   Direct-Access                      ANSI SCSI revision: 03
blk: queue dfd01218, I/O limit 4095Mb (mask 0xffffffff)
scsi1:A:1:0: Tagged Queuing enabled.  Depth 253
blk: queue dfd01218, I/O limit 4095Mb (mask 0xffffffff)
 Vendor: M4 DATA   Model: MagFile           Rev: 3.01
 Type:   Medium Changer                     ANSI SCSI revision: 02
blk: queue dfce5818, I/O limit 4095Mb (mask 0xffffffff)
 Vendor: QUANTUM   Model: SDLT320           Rev: 2E2E
 Type:   Sequential-Access                  ANSI SCSI revision: 02
blk: queue dfce5418, I/O limit 4095Mb (mask 0xffffffff)
 Vendor: QUANTUM   Model: SDLT320           Rev: 2E2E
 Type:   Sequential-Access                  ANSI SCSI revision: 02
blk: queue dfce5018, I/O limit 4095Mb (mask 0xffffffff)
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
Attached scsi disk sdb at scsi1, channel 0, id 1, lun 0
(scsi0:A:0): 160.000MB/s transfers (80.000MHz DT, offset 63, 16bit)
SCSI device sda: 71096640 512-byte hdwr sectors (36401 MB)
Partition check:
sda: sda1 sda2 sda3
(scsi1:A:1): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
SCSI device sdb: -562247552 512-byte hdwr sectors (-287870 MB)

6. N/a

7. Environment

7.1 Software

ver_linux:

Linux firedaemon 2.4.18-19.8.0smp #1 SMP Thu Dec 12 04:36:25 EST 2002 i686 
i686 i386 GNU/Linux

Gnu C                  3.2
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
modutils               2.4.18
e2fsprogs              1.27
jfsutils               1.0.17
reiserfsprogs          3.6.2
pcmcia-cs              3.1.31
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        2.2.93
Dynamic linker (ldd)   2.2.93
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.12
Modules Loaded         sg nfsd lockd sunrpc sk98lin e100 iptable_filter 
ip_tables st mousedev keybdev hid input usb-ohci usbcore ext3 jbd aic7xxx 
sd_mod scsi_mod

7.2 Processor Info

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 999.753
cache size      : 256 KB
Physical processor ID   : 0
Number of siblings      : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse
bogomips        : 1985.67

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10
cpu MHz         : 999.753
cache size      : 256 KB
Physical processor ID   : 0
Number of siblings      : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse
bogomips        : 1997.32

7.3 Modules

sg                     37644   0 (autoclean)
nfsd                   81424   8 (autoclean)
lockd                  58800   1 (autoclean) [nfsd]
sunrpc                 84604   1 (autoclean) [nfsd lockd]
sk98lin               138624   1
e100                   64596   1
iptable_filter          2412   0 (autoclean) (unused)
ip_tables              15640   1 [iptable_filter]
st                     31440   0 (unused)
mousedev                5688   1
keybdev                 2976   0 (unused)
hid                    22404   0 (unused)
input                   6240   0 [mousedev keybdev hid]
usb-ohci               22088   0 (unused)
usbcore                80512   1 [hid usb-ohci]
ext3                   72960   3
jbd                    56752   3 [ext3]
aic7xxx               138452   4
sd_mod                 13552   8
scsi_mod              110408   4 [sg st aic7xxx sd_mod]

7.4 Loaded Driver/Hardware Info

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
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0700-070f : ServerWorks OSB4 IDE Controller
 0700-0707 : ide0
 0708-070f : ide1
0cf8-0cff : PCI conf1
2200-223f : Intel Corp. 82557/8/9 [Ethernet Pro 100]
 2200-223f : e100
2300-23ff : Adaptec AIC-7892P U160/m
2400-24ff : Adaptec AHA-3960D / AIC-7899A U160/m
2500-25ff : Adaptec AHA-3960D / AIC-7899A U160/m (#2)
2600-26ff : Syskonnect (Schneider & Koch) Gigabit Ethernet

00000000-0009dbff : System RAM
0009dc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000ca000-000ce7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-1ffebc3f : System RAM
 00100000-0026af59 : Kernel code
 0026af5a-00375f03 : Kernel data
1ffebc40-1ffeffff : ACPI Tables
1fff0000-1fffffff : reserved
efff8000-efffbfff : Syskonnect (Schneider & Koch) Gigabit Ethernet
efffd000-efffdfff : Adaptec AHA-3960D / AIC-7899A U160/m (#2)
 efffd000-efffdfff : aic7xxx
efffe000-efffefff : Adaptec AHA-3960D / AIC-7899A U160/m
 efffe000-efffefff : aic7xxx
effff000-efffffff : Adaptec AIC-7892P U160/m
 effff000-efffffff : aic7xxx
f0000000-f7ffffff : S3 Inc. Savage 4
fea00000-feafffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
 fea00000-feafffff : e100
feb7e000-feb7efff : ServerWorks OSB4/CSB5 OHCI USB Controller
 feb7e000-feb7efff : usb-ohci
feb7f000-feb7ffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
 feb7f000-feb7ffff : e100
feb80000-febfffff : S3 Inc. Savage 4
fec00000-ffffffff : reserved

7.5 PCI Information

00:00.0 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
       Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium  >TAbort- 
<TAbort-  <MAbort+  >SERR-  <PERR-
       Latency: 64, cache line size 08

00:00.1 Host bridge: ServerWorks CNB20LE Host Bridge (rev 06)
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+ 
Stepping- SERR+ FastB2B-
       Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium  >TAbort- 
<TAbort-  <MAbort-  >SERR-  <PERR-
       Latency: 64, cache line size 08

00:01.0 VGA compatible controller: S3 Inc. Savage 4 (rev 04) (prog-if 00 
[VGA])
       Subsystem: IBM: Unknown device 01c5
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
       Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium  >TAbort- 
<TAbort-  <MAbort-  >SERR-  <PERR-
       Latency: 248 (1000ns min, 63750ns max), cache line size 08
       Interrupt: pin A routed to IRQ 0
       Region 0: Memory at feb80000 (32-bit, non-prefetchable) [size=512K]
       Region 1: Memory at f0000000 (32-bit, prefetchable) [size=128M]
       Expansion ROM at  <unassigned> [disabled] [size=64K]
       Capabilities: [dc] Power Management version 1
               Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-
,D3hot-,D3cold-)
               Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:02.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 08)
       Subsystem: IBM Netfinity 10/100
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
       Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium  >TAbort- 
<TAbort-  <MAbort-  >SERR-  <PERR-
       Latency: 64 (2000ns min, 14000ns max), cache line size 08
       Interrupt: pin A routed to IRQ 27
       Region 0: Memory at feb7f000 (32-bit, non-prefetchable) [size=4K]
       Region 1: I/O ports at 2200 [size=64]
       Region 2: Memory at fea00000 (32-bit, non-prefetchable) [size=1M]
       Expansion ROM at  <unassigned> [disabled] [size=1M]
       Capabilities: [dc] Power Management version 2
               Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME
(D0+,D1+,D2+,D3hot+,D3cold-)
               Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 50)
       Subsystem: ServerWorks OSB4 South Bridge
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
       Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium  >TAbort- 
<TAbort-  <MAbort-  >SERR-  <PERR-
       Latency: 0

00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller (prog-if 8a [Master 
SecP PriP])
       Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
       Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium  >TAbort- 
<TAbort-  <MAbort-  >SERR-  <PERR-
       Latency: 64
       Region 4: I/O ports at 0700 [size=16]

00:0f.2 USB Controller: ServerWorks OSB4/CSB5 USB Controller (rev 04) (prog-
if 10 [OHCI])
       Subsystem: ServerWorks OSB4/CSB5 USB Controller
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
       Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium  >TAbort- 
<TAbort-  <MAbort-  >SERR-  <PERR-
       Latency: 64 (20000ns max), cache line size 08
       Interrupt: pin A routed to IRQ 9
       Region 0: Memory at feb7e000 (32-bit, non-prefetchable) [size=4K]

01:03.0 SCSI storage controller: Adaptec AIC-7892P U160/m (rev 02)
       Subsystem: Adaptec AIC-7892P U160/m
       Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ 
Stepping- SERR+ FastB2B-
       Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium  >TAbort- 
<TAbort-  <MAbort-  >SERR-  <PERR-
       Latency: 64 (10000ns min, 6250ns max), cache line size 08
       Interrupt: pin A routed to IRQ 28
       BIST result: 00
       Region 0: I/O ports at 2300 [disabled] [size=256]
       Region 1: Memory at effff000 (64-bit, non-prefetchable) [size=4K]
       Expansion ROM at  <unassigned> [disabled] [size=128K]
       Capabilities: [dc] Power Management version 2
               Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-
,D3hot-,D3cold-)
               Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:06.0 SCSI storage controller: Adaptec AHA-3960D / AIC-7899A U160/m (rev 01)
       Subsystem: Adaptec AHA-3960D U160/m
       Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ 
Stepping- SERR+ FastB2B-
       Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium  >TAbort- 
<TAbort-  <MAbort-  >SERR-  <PERR-
       Latency: 64 (10000ns min, 6250ns max), cache line size 08
       Interrupt: pin A routed to IRQ 22
       BIST result: 00
       Region 0: I/O ports at 2400 [disabled] [size=256]
       Region 1: Memory at efffe000 (64-bit, non-prefetchable) [size=4K]
       Expansion ROM at  <unassigned> [disabled] [size=128K]
       Capabilities: [dc] Power Management version 2
               Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-
,D3hot-,D3cold-)
               Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:06.1 SCSI storage controller: Adaptec AHA-3960D / AIC-7899A U160/m (rev 01)
       Subsystem: Adaptec AHA-3960D U160/m
       Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ 
Stepping- SERR+ FastB2B-
       Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium  >TAbort- 
<TAbort-  <MAbort-  >SERR-  <PERR-
       Latency: 64 (10000ns min, 6250ns max), cache line size 08
       Interrupt: pin B routed to IRQ 23
       BIST result: 00
       Region 0: I/O ports at 2500 [disabled] [size=256]
       Region 1: Memory at efffd000 (64-bit, non-prefetchable) [size=4K]
       Expansion ROM at  <unassigned> [disabled] [size=128K]
       Capabilities: [dc] Power Management version 2
               Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-
,D3hot-,D3cold-)
               Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:07.0 Ethernet controller: Syskonnect (Schneider & Koch) Gigabit Ethernet 
(rev 12)
       Subsystem: Syskonnect (Schneider & Koch) SK-9843 (1000Base-SX single 
link)
       Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr+ 
Stepping- SERR+ FastB2B-
       Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium  >TAbort- 
<TAbort-  <MAbort-  >SERR-  <PERR-
       Latency: 64 (5750ns min, 7750ns max), cache line size 08
       Interrupt: pin A routed to IRQ 24
       Region 0: Memory at efff8000 (32-bit, non-prefetchable) [size=16K]
       Region 1: I/O ports at 2600 [size=256]
       Expansion ROM at  <unassigned> [disabled] [size=128K]
       Capabilities: [48] Power Management version 1
               Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-
,D3hot-,D3cold-)
               Status: D0 PME-Enable- DSel=0 DScale=1 PME-
       Capabilities: [50] Vital Product Data

7.6 SCSI Information

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
 Vendor: IBM-PSG  Model: DDYS-T36950M  M  Rev: S9HA
 Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 08 Lun: 00
 Vendor: IBM      Model: YGLv3 S2         Rev: 0   
 Type:   Processor                        ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 01 Lun: 00
 Vendor: Adaptec  Model: DuraStor 6200S   Rev: L421
 Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi2 Channel: 00 Id: 00 Lun: 00
 Vendor: M4 DATA  Model: MagFile          Rev: 3.01
 Type:   Medium Changer                   ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 01 Lun: 00
 Vendor: QUANTUM  Model: SDLT320          Rev: 2E2E
 Type:   Sequential-Access                ANSI SCSI revision: 02
Host: scsi2 Channel: 00 Id: 02 Lun: 00
 Vendor: QUANTUM  Model: SDLT320          Rev: 2E2E
 Type:   Sequential-Access                ANSI SCSI revision: 02

7.7 N/a




