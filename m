Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319399AbSH2VNR>; Thu, 29 Aug 2002 17:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319402AbSH2VNR>; Thu, 29 Aug 2002 17:13:17 -0400
Received: from irvmail2.bdi.gte.com ([192.76.80.130]:51372 "EHLO
	irvmail2.bdi.gte.com") by vger.kernel.org with ESMTP
	id <S319399AbSH2VNM>; Thu, 29 Aug 2002 17:13:12 -0400
Date: Thu, 29 Aug 2002 17:16:06 -0400
From: Scott Edlund <scott.edlund@verizon.com>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Assertion failure in journal_write_metadata_buffer()
Message-ID: <20020829171606.B25777@verizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Editor: Vim-601 http://www.vim.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Getting this in my syslog:

Assertion failure in journal_write_metadata_buffer() at journal.c:406
------------[ cut here ]------------
kernel BUG at journal.c:406!
invalid operand: 0000
binfmt_misc nfs lockd sunrpc autofs eepro100 loop ext3 jbd lvm-mod aic7xxx meg
CPU:    1
EIP:    0010:[<f8872984>]    Not tainted
EFLAGS: 00010282

EIP is at journal_write_metadata_buffer [jbd] 0x74 (2.4.18-3smp)
eax: 0000001d   ebx: 00000000   ecx: c02eee60   edx: 000042b9
esi: 00000000   edi: f4b3c8e0   ebp: e0042eb0   esp: f7423e44
ds: 0018   es: 0018   ss: 0018
Process kjournald (pid: 162, stackpage=f7423000)
Stack: f8877161 00000196 00001955 f75d2000 00000000 00000000 f33e5700 00000000 
f4b3c8e0 e0042eb0 f886fdc4 f4b3c8e0 f33e5700 f7423e98 00001b66 f7fd0084 
00000001 00000ff4 e3c5000c 00000001 f4b3c8e0 e0042a30 00001b66 00000202 
Call Trace: [<f8877161>] .rodata.str1.1 [jbd] 0x4e1 
[<f886fdc4>] journal_commit_transaction [jbd] 0x7e4 
[<c010a53e>] handle_IRQ_event [kernel] 0x5e 
[<c010a53e>] handle_IRQ_event [kernel] 0x5e 
[<c010758d>] __switch_to [kernel] 0x3d 
[<c0119048>] schedule [kernel] 0x348 
[<f88727d6>] kjournald [jbd] 0x136 
[<f8872680>] commit_timeout [jbd] 0x0 
[<c0107286>] kernel_thread [kernel] 0x26 
[<f88726a0>] kjournald [jbd] 0x0 

Code: 0f 0b 5e 5f 8b 7c 24 28 8b 4f 0c 85 c9 74 2e c7 44 24 0c 01 

Here is my /proc/version:
Linux version 2.4.18-3smp (bhcompile@daffy.perf.redhat.com) (gcc
version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)) #1 SMP Thu Apr 18
07:27:31 EDT 2002

/proc/cpuinfo :

processor : 0
vendor_id : GenuineIntel
cpu family     : 6
model          : 10
model name     : Pentium III (Cascades)
stepping  : 4
cpu MHz        : 700.084
cache size     : 1024 KB
fdiv_bug  : no
hlt_bug        : no
f00f_bug  : no
coma_bug  : no
fpu       : yes
fpu_exception  : yes
cpuid level    : 2
wp        : yes
flags          : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips  : 1395.91

processor : 1
vendor_id : GenuineIntel
cpu family     : 6
model          : 10
model name     : Pentium III (Cascades)
stepping  : 4
cpu MHz        : 700.084
cache size     : 1024 KB
fdiv_bug  : no
hlt_bug        : no
f00f_bug  : no
coma_bug  : no
fpu       : yes
fpu_exception  : yes
cpuid level    : 2
wp        : yes
flags          : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips  : 1399.19

processor : 2
vendor_id : GenuineIntel
cpu family     : 6
model          : 10
model name     : Pentium III (Cascades)
stepping  : 4
cpu MHz        : 700.084
cache size     : 1024 KB
fdiv_bug  : no
hlt_bug        : no
f00f_bug  : no
coma_bug  : no
fpu       : yes
fpu_exception  : yes
cpuid level    : 2
wp        : yes
flags          : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips  : 1399.19

processor : 3
vendor_id : GenuineIntel
cpu family     : 6
model          : 10
model name     : Pentium III (Cascades)
stepping  : 4
cpu MHz        : 700.084
cache size     : 1024 KB
fdiv_bug  : no
hlt_bug        : no
f00f_bug  : no
coma_bug  : no
fpu       : yes
fpu_exception  : yes
cpuid level    : 2
wp        : yes
flags          : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
mca cmov pat pse36 mmx fxsr sse
bogomips  : 1399.19

/proc/modules:
binfmt_misc             7780   1
nfs                    90268   1 (autoclean)
lockd                  57760   1 (autoclean) [nfs]
sunrpc                 81684   1 (autoclean) [nfs lockd]
autofs                 12804   0 (autoclean) (unused)
eepro100               20816   1
loop                   11632   0 (autoclean)
ext3                   70752   8
jbd                    53632   8 [ext3]
lvm-mod                65728   5
aic7xxx               125440   1
megaraid               28640   8
sd_mod                 12896  18
scsi_mod              112272   3 [aic7xxx megaraid sd_mod]

/proc/ioports:
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
02f8-02ff : serial(auto)
03c0-03df : vga+
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
1400-14ff : ATI Technologies Inc 3D Rage IIC
1800-183f : Intel Corp. 82557 [Ethernet Pro 100]
  1800-183f : eepro100
1840-184f : ServerWorks OSB4 IDE Controller
  1840-1847 : ide0
  1848-184f : ide1
4000-40ff : Hewlett-Packard Company NetServer PCI Hot-Plug Controller
4400-44ff : Hewlett-Packard Company NetServer SMIC Controller
4800-48ff : Adaptec 7892A

/proc/iomem:
00000000-0009e7ff : System RAM
0009e800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c8fff : Extension ROM
000f0000-000fffff : System ROM
00100000-c40effff : System RAM
  00100000-002342b0 : Kernel code
  002342b1-00306b3f : Kernel data
c40f0000-c40ffbff : ACPI Tables
c40ffc00-c40fffff : ACPI Non-volatile Storage
c4100000-edffffff : System RAM
ee001000-ee001fff : Intel Corp. 82557 [Ethernet Pro 100]
  ee001000-ee001fff : eepro100
ee002000-ee002fff : ATI Technologies Inc 3D Rage IIC
ee100000-ee1fffff : Intel Corp. 82557 [Ethernet Pro 100]
ef000000-efffffff : ATI Technologies Inc 3D Rage IIC
f3000000-f3000fff : Adaptec 7892A
  f3000000-f3000fff : aic7xxx
f3100000-f31fffff : PCI Bus #05
  f3100000-f3107fff : Hewlett-Packard Company NetServer Smart IRQ
Router
f8000000-fbffffff : Intel Corp. 80960RP [i960RP Microprocessor]
fec00000-fecfffff : reserved
fee00000-feefffff : reserved
fff80000-ffffffff : reserved

lspci -vvv:
00:00.0 Host bridge: ServerWorks CNB20HE Host Bridge (rev 21)
     Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
     Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR-

00:00.1 Host bridge: ServerWorks CNB20HE Host Bridge (rev 01)
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
     Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
     Latency: 64, cache line size 08

00:00.2 Host bridge: ServerWorks: Unknown device 0006
     Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
     Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-

00:00.3 Host bridge: ServerWorks: Unknown device 0006
     Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
     Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-

00:06.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
(rev 08)
     Subsystem: Hewlett-Packard Company NetServer 10/100TX
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
     Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
     Latency: 64 (2000ns min, 14000ns max), cache line size 08
     Interrupt: pin A routed to IRQ 18
     Region 0: Memory at ee001000 (32-bit, non-prefetchable) [size=4K]
     Region 1: I/O ports at 1800 [size=64]
     Region 2: Memory at ee100000 (32-bit, non-prefetchable) [size=1M]
     Capabilities: [dc] Power Management version 2
          Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
          Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:07.0 VGA compatible controller: ATI Technologies Inc 3D Rage IIC
(rev 7a) (prog-if 00 [VGA])
     Subsystem: Hewlett-Packard Company: Unknown device 10c4
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
     Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
     Latency: 66 (2000ns min), cache line size 08
     Region 0: Memory at ef000000 (32-bit, non-prefetchable)
[size=16M]
     Region 1: I/O ports at 1400 [size=256]
     Region 2: Memory at ee002000 (32-bit, non-prefetchable) [size=4K]
     Expansion ROM at <unassigned> [disabled] [size=128K]
     Capabilities: [5c] Power Management version 1
          Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
          Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 4f)
     Subsystem: ServerWorks OSB4 South Bridge
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
     Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
     Latency: 0

00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller (prog-if 8a
[Master SecP PriP])
     Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
     Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
     Latency: 64
     Region 4: I/O ports at 1840 [size=16]

04:02.0 System peripheral: Hewlett-Packard Company NetServer PCI
Hot-Plug Controller (rev 0d)
     Subsystem: Hewlett-Packard Company: Unknown device 0001
     Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
     Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
     Interrupt: pin A routed to IRQ 16
     Region 0: I/O ports at 4000 [size=256]

04:02.1 InfiniBand: Hewlett-Packard Company NetServer SMIC Controller
(rev 09)
     Subsystem: Hewlett-Packard Company: Unknown device 0001
     Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
     Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
     Interrupt: pin B routed to IRQ 17
     Region 0: I/O ports at 4400 [size=256]

04:03.0 PCI bridge: Intel Corp. 80960RP [i960 RP
Microprocessor/Bridge] (rev 02) (prog-if 00 [Normal decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
     Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
     Latency: 64, cache line size 08
     Bus: primary=04, secondary=05, subordinate=05, sec-latency=64
     I/O behind bridge: 0000f000-00000fff
     Memory behind bridge: f3100000-f31fffff
     Prefetchable memory behind bridge: fff00000-000fffff
     BridgeCtl: Parity+ SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
     Capabilities: [68] Power Management version 2
          Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
          Status: D0 PME-Enable- DSel=0 DScale=0 PME-

04:03.1 RAID bus controller: Intel Corp. 80960RP [i960RP
Microprocessor] (rev 09)
     Subsystem: Hewlett-Packard Company MegaRAID, Integrated HP
NetRAID
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B+
     Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
     Latency: 64, cache line size 08
     Interrupt: pin A routed to IRQ 20
     Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
     Expansion ROM at <unassigned> [disabled] [size=32K]
     Capabilities: [80] Power Management version 2
          Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
          Status: D0 PME-Enable- DSel=0 DScale=0 PME-

04:04.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
     Subsystem: Adaptec 29160 Ultra160 SCSI Controller
     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
     Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
     Latency: 64 (10000ns min, 6250ns max), cache line size 08
     Interrupt: pin A routed to IRQ 21
     BIST result: 00
     Region 0: I/O ports at 4800 [disabled] [size=256]
     Region 1: Memory at f3000000 (64-bit, non-prefetchable) [size=4K]
     Expansion ROM at <unassigned> [disabled] [size=128K]
     Capabilities: [dc] Power Management version 2
          Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
          Status: D0 PME-Enable- DSel=0 DScale=0 PME-

05:08.0 System peripheral: Hewlett-Packard Company NetServer Smart IRQ
Router (rev a0)
     Subsystem: Hewlett-Packard Company: Unknown device 0001
     Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr+ Stepping- SERR+ FastB2B-
     Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
     Region 0: Memory at f3100000 (32-bit, non-prefetchable)
[size=32K]

/proc/scsi/scsi:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: MegaRAID Model: LD0 RAID1 34731R Rev:   E 
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 04 Id: 05 Lun: 00
  Vendor: HP       Model: SAFTE; U160/M BP Rev: 1023
  Type:   Processor                        ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 03 Lun: 00
  Vendor:          Model:                  Rev: 0001
  Type:   Direct-Access                    ANSI SCSI revision: 03


