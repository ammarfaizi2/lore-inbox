Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbTGFUsR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 16:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbTGFUsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 16:48:17 -0400
Received: from lea.ulyssis.student.kuleuven.ac.be ([193.190.253.45]:11922 "HELO
	ulyssis.org") by vger.kernel.org with SMTP id S263452AbTGFUsK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 16:48:10 -0400
Date: Sun, 6 Jul 2003 23:02:43 +0200
From: Vincent Touquet <vincent@ulyssis.org>
To: linux-kernel@vger.kernel.org
Subject: [Bug report] System lockups on Tyan S2469 and lots of io [smp boot time problems too :(]
Message-ID: <20030706210243.GA25645@lea.ulyssis.org>
Reply-To: vincent@ulyssis.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[1.] One line summary of the problem

System hangs on high I/O and doesn't boot properly in smp mode.

[2.] Full description of the problem/report:

Copying large amounts of data from an IDE disk to a SCSI raid array (3Ware 
Escalade 7800) hangs the system completely. 

System is a Tyan S2469 with two Athlon MP cpus.
Only one is used, because when booting with an SMP kernel, there are
endless time-outs and resets on the 3ware card.

The exact same behaviour was observed on a Tyan S2468 system with 
the same 3Ware card. The 3Ware card has been RMAd (it wasn't faulty,
but I did it anyway to be sure), all the disks on the array have
been checked.

[3.] Keywords (i.e., modules, networking, kernel):

kernel, vm, ide, scsi

[4.] Kernel version (from /proc/version):

Linux version 2.4.20-3-k7 (herbert@gondolin) (gcc version 3.3 (Debian)) #1 Sun Jun 8 01:35:14 EST 2003

[5.] Output of Oops.. message (if applicable) with symbolic information 
     resolved (see Documentation/oops-tracing.txt)

No oops

[6.] A small shell script or example program which triggers the
     problem (if possible)

cp large amount of data from ide disk to scsi array

[7.] Environment
[7.1.] Software (add the output of the ver_linux script here)
Gnu C                  3.2.3
Gnu make               3.80
util-linux             2.11z
mount                  2.11z
modutils               2.4.21
e2fsprogs              1.34-WIP
PPP                    2.4.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.9
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               5.0
Modules Loaded         mousedev input agpgart lp parport autofs4 af_packet ext2 i2c-dev i2c-core isa-pnp lvm-mod loop 3w-xxxx sd_mod scsi_mod e1000 eepro100 mii rtc ext3 jbd ide-disk ide-probe-mod ide-mod unix

[7.2.] Processor information (from /proc/cpuinfo):
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 6
model name      : AMD Athlon(tm) MP 2000+
stepping        : 2
cpu MHz         : 1666.741
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3322.67

Only one cpu active, though it is a dual cpu system.
The system doesn't even boot with two cpus :(, on bootup there are continuously
time-outs on the 3ware card and it gets reset ad infinitum (and ad nauseam...).

[7.3.] Module information (from /proc/modules):
mousedev                4148   0 (autoclean)
input                   3520   0 (autoclean) [mousedev]
agpgart                37344   0 (autoclean) (unused)
lp                      6816   0 (autoclean) (unused)
parport                25992   0 (autoclean) [lp]
autofs4                 9780   2 (autoclean)
af_packet              13448   1 (autoclean)
ext2                   34688   1 (autoclean)
i2c-dev                 4676   0 (unused)
i2c-core               13476   0 [i2c-dev]
isa-pnp                31888   0 (unused)
lvm-mod                58624  12
loop                    9560   0
3w-xxxx                32992   1
sd_mod                 11660   2
scsi_mod               93984   2 [3w-xxxx sd_mod]
e1000                  51340   1
eepro100               19732   1
mii                     2432   0 [eepro100]
rtc                     6792   0 (autoclean)
ext3                   63808   6 (autoclean)
jbd                    41764   6 (autoclean) [ext3]
ide-disk               12448   4 (autoclean)
ide-probe-mod           9744   0 (autoclean)
ide-mod               167736   4 (autoclean) [ide-disk ide-probe-mod]
unix                   15148  76 (autoclean)

[7.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
/proc/ioports
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
0376-0376 : ide1
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
1000-103f : Intel Corp. 82545EM Gigabit Ethernet Controller
  1000-103f : e1000
1050-105f : 3ware Inc 3ware 7000-series ATA-RAID
  1050-105f : 3ware Storage Controller
1060-1063 : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller
2000-2fff : PCI Bus #02
  2000-20ff : ATI Technologies Inc Rage XL
  2400-243f : Intel Corp. 82557/8/9 [Ethernet Pro 100]
    2400-243f : eepro100
f000-f00f : Advanced Micro Devices [AMD] AMD-768 [Opus] IDE
  f000-f007 : ide0
  f008-f00f : ide1

/proc/iomem
00000000-0009efff : System RAM
0009f000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c8fff : Extension ROM
000e0000-000effff : Extension ROM
000f0000-000fffff : System ROM
00100000-3feeffff : System RAM
  00100000-001f6826 : Kernel code
  001f6827-00258503 : Kernel data
3fef0000-3fef5fff : ACPI Tables
3fef6000-3fefffff : ACPI Non-volatile Storage
3ff00000-3ff7ffff : System RAM
3ff80000-3fffffff : reserved
f4000000-f47fffff : 3ware Inc 3ware 7000-series ATA-RAID
f4800000-f481ffff : Intel Corp. 82545EM Gigabit Ethernet Controller
  f4800000-f481ffff : e1000
f4820000-f482000f : 3ware Inc 3ware 7000-series ATA-RAID
f4900000-f5ffffff : PCI Bus #02
  f4900000-f4900fff : Advanced Micro Devices [AMD] AMD-768 [Opus] USB
  f4901000-f4901fff : ATI Technologies Inc Rage XL
  f4902000-f4902fff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
    f4902000-f4902fff : eepro100
  f4920000-f493ffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  f5000000-f5ffffff : ATI Technologies Inc Rage XL
f6200000-f6200fff : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller
f8000000-fbffffff : Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller
fec00000-fec03fff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved

[7.5.] PCI information ('lspci -vvv' as root)
kalimero:~# lspci -vvv
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller (rev 11)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32
        Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
        Region 1: Memory at f6200000 (32-bit, prefetchable) [size=4K]
        Region 2: I/O ports at 1060 [disabled] [size=4]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit- FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA+ AGP+ GART64- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP Bridge (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 05)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE (rev 04) (prog-if 8a [Master SecP PriP])
        Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Region 4: I/O ports at f000 [size=16]

00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 03)
        Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:08.0 RAID bus controller: 3ware Inc 3ware 7000-series ATA-RAID (rev 01)
        Subsystem: 3ware Inc 3ware 7000-series ATA-RAID
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 72 (2250ns min), cache line size 10
        Interrupt: pin A routed to IRQ 16
        Region 0: I/O ports at 1050 [size=16]
        Region 1: Memory at f4820000 (32-bit, non-prefetchable) [size=16]
        Region 2: Memory at f4000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [40] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Ethernet controller: Intel Corp. 82545EM Gigabit Ethernet Controller (Copper) (rev 01)
        Subsystem: Intel Corp. PRO/1000 MT Server Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (63750ns min), cache line size 10
        Interrupt: pin A routed to IRQ 19
        Region 0: Memory at f4800000 (32-bit, non-prefetchable) [size=128K]
        Region 2: I/O ports at 1000 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [e4] PCI-X non-bridge device.
                Command: DPERE- ERO+ RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-      Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000

00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev 05) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 99
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=68
        I/O behind bridge: 00002000-00002fff
        Memory behind bridge: f4900000-f5ffffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA+ MAbort- >Reset- FastB2B-

02:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-768 [Opus] USB (rev 07) (prog-if 10 [OHCI])
        Subsystem: Advanced Micro Devices [AMD] AMD-768 [Opus] USB
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (20000ns max)
        Interrupt: pin D routed to IRQ 19
        Region 0: Memory at f4900000 (32-bit, non-prefetchable) [size=4K]

02:07.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Rage XL
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min), cache line size 10
        Region 0: Memory at f5000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: I/O ports at 2000 [size=256]
        Region 2: Memory at f4901000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [5c] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

02:08.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100] (rev 10)
        Subsystem: Intel Corp. EtherExpress PRO/100 S Server Adapter
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 66 (2000ns min, 14000ns max), cache line size 10
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at f4902000 (32-bit, non-prefetchable) [size=4K]
        Region 1: I/O ports at 2400 [size=64]
        Region 2: Memory at f4920000 (32-bit, non-prefetchable) [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

[7.6.] SCSI information (from /proc/scsi/scsi)
kalimero:~# cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: 3ware    Model: 3w-xxxx          Rev: 1.0
  Type:   Direct-Access                    ANSI SCSI revision: ffffffff

[7.7.] Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):
The output of vmstat while the copying took place (after the last line, the
system just hangs):

vincent@kalimero:~$ vmstat -n 100
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 0  0      0 821768  12628  57364    0    0  5176    44  296   421  2  4 94  0
 1  1      0 451012  20380 392808    0    0  1804  1500  246   804 11  4 86  0
 0  2   1412   9580  14752 914764    0   10 16251 16529  574  1399  4 19 77  0
