Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318931AbSH1ToG>; Wed, 28 Aug 2002 15:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318933AbSH1ToG>; Wed, 28 Aug 2002 15:44:06 -0400
Received: from ue250-1.rz.RWTH-Aachen.DE ([134.130.3.33]:29070 "EHLO
	ue250-1.rz.RWTH-Aachen.DE") by vger.kernel.org with ESMTP
	id <S318931AbSH1Tn7>; Wed, 28 Aug 2002 15:43:59 -0400
Message-ID: <3D6D2971.4030509@weh.rwth-aachen.de>
Date: Wed, 28 Aug 2002 21:50:09 +0200
From: cfraas <chris@weh.rwth-aachen.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: found kernelbug about ext3 filesystem journaling
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1)
Summary of the problem:
ext3  filesystem journaling fails by copying/writing data

2,3)
Full description:
by copying data to hdd with ext3 journaling filesystem the job fails. I 
get a errormessage (kernel bug) with the following content:
***********************************************************************************
Aug 28 20:57:17 chris kernel: Assertion failure in 
journal_unmap_buffer() at transaction.c:1859: "transaction == 
journal->j_running_transactio
n"
Aug 28 20:57:17 chris kernel: kernel BUG at transaction.c:1859!
Aug 28 20:57:17 chris kernel: invalid operand: 0000
Aug 28 20:57:17 chris kernel: CPU:    0
Aug 28 20:57:17 chris kernel: EIP:    
0010:[af_packet:__insmod_af_packet_O/lib/modules/2.4.18-6mdk/kernel/net/pac+-2061112/96]    
Not tainted
Aug 28 20:57:17 chris kernel: EIP:    0010:[<f2904cc8>]    Not tainted
Aug 28 20:57:17 chris kernel: EFLAGS: 00010282
Aug 28 20:57:17 chris kernel: eax: 00000022   ebx: 3bd75902   ecx: 
c0262520   edx: 0000569b
Aug 28 20:57:17 chris kernel: esi: ebe02430   edi: daa78480   ebp: 
00000001   esp: e0e9de7c
Aug 28 20:57:17 chris kernel: ds: 0018   es: 0018   ss: 0018
Aug 28 20:57:17 chris kernel: Process mc (pid: 10371, stackpage=e0e9d000)
Aug 28 20:57:17 chris kernel: Stack: f290bbd0 00000743 deca3780 ea409880 
d10a1910 00000000 daa78480 eee90200
Aug 28 20:57:17 chris kernel:        daa78480 00001000 f2904e2c eee90200 
daa78480 00000001 daa78480 c12d5340
*************************************************************************************
4)
kernel version from /proc/version:
Linux version 2.4.18-6mdk (quintela@bi.mandrakesoft.com) (gcc version 
2.96 20000731 (Mandrake Linux 8.2 2.96-0.76mdk)) #1 Fri Mar 15 02:59:08
CET 2002

5)
Output /errormessage see above

6)
the failure occures while using cp, mc and so on, when copying data to 
the hdd with ext3 journaling filesystem

7)
7.1)

software (add the output of the ver_linux script her)

dont know what to write here

7.2)

Processor information (from /proc/cpuinfo):


/proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1009.014
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
bogomips        : 2011.95

7.3)
module information from /proc/modules

nls_iso8859-15          3360   0 (autoclean)
isofs                  25792   0 (autoclean)
inflate_fs             19328   0 (autoclean) [isofs]
sr_mod                 15160   0 (autoclean)
es1371                 26656   2
soundcore               4068   4 [es1371]
ac97_codec              9568   0 [es1371]
gameport                1756   0 [es1371]
nfsd                   69536   8 (autoclean)
lockd                  49344   1 (autoclean) [nfsd]
sunrpc                 62964   1 (autoclean) [nfsd lockd]
lp                      6464   0
parport_pc             22088   1
parport                23968   1 [lp parport_pc]
af_packet              12488   0 (autoclean)
ip_vs                  65400   0 (autoclean)
8139too                14336   1 (autoclean)
mii                     1360   0 (autoclean) [8139too]
supermount             62180   2 (autoclean)
ide-scsi                8032   0
scsi_mod               92488   2 [sr_mod ide-scsi]
rtc                     5912   0 (autoclean)
ext3                   62092   5
jbd                    39356   5 [ext3]
raid0                   3400   3


7.4)

Loaded driver and hardware information (/proc/ioports, /proc/iomem)
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
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial(auto)
0cf8-0cff : PCI conf1
8400-843f : Promise Technology, Inc. 20265
  8400-8407 : ide2
  8408-840f : ide3
  8410-843f : PDC20265
8800-8803 : Promise Technology, Inc. 20265
9000-9007 : Promise Technology, Inc. 20265
9400-9403 : Promise Technology, Inc. 20265
  9402-9402 : ide2
9800-9807 : Promise Technology, Inc. 20265
  9800-9807 : ide2
a000-a03f : Ensoniq 5880 AudioPCI
  a000-a03f : es1371
a400-a4ff : Realtek Semiconductor Co., Ltd. RTL-8139



00000000-0009efff : System RAM
0009f000-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000cc000-000ce7ff : Extension ROM
000f0000-000fffff : System ROM
00100000-2ffebfff : System RAM
  00100000-00224a95 : Kernel code
  00224a96-00277d6b : Kernel data
2ffec000-2ffeefff : ACPI Tables
2ffef000-2fffefff : reserved
2ffff000-2fffffff : ACPI Non-volatile Storage
d5800000-d581ffff : Promise Technology, Inc. 20265
d6000000-d6ffffff : nVidia Corporation NV11 (GeForce2 MX)
d7000000-d70000ff : Realtek Semiconductor Co., Ltd. RTL-8139
  d7000000-d70000ff : 8139too
d8000000-dfffffff : nVidia Corporation NV11 (GeForce2 MX)
  d8000000-d9ffffff : vesafb
e6000000-e7ffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
ffff0000-ffffffff : reserved

7.5)PCI information ('lspci -vvv' as root)
 lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 03)
        Subsystem: Asustek Computer, Inc.: Unknown device 8042
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 8
        Region 0: Memory at e6000000 (32-bit, prefetchable) [size=32M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000e000-0000dfff
        Memory behind bridge: d7f00000-d7efffff
        Prefetchable memory behind bridge: e6000000-e5ffffff
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 40)
        Subsystem: Asustek Computer, Inc.: Unknown device 8042
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at d800 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16) (prog-if 00 [UHCI])
        Subsystem: Unknown device 0925:1234
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 9
        Region 4: I/O ports at d000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 40)
        Subsystem: Asustek Computer, Inc.: Unknown device 8042
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 10)
        Subsystem: Accton Technology Corporation: Unknown device ec01
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at a400 [size=256]
        Region 1: Memory at d7000000 (32-bit, non-prefetchable) [size=256]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
        Subsystem: Ensoniq Creative Sound Blaster AudioPCI128
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort+ <MAbort+ >SERR- <PERR-
        Latency: 32 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at a000 [size=64]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 VGA compatible controller: nVidia Corporation NV11 (GeForce2 MX) (rev a1) (prog-if 00 [VGA])
        Subsystem: Creative Labs: Unknown device 104b
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d6000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at d8000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at 000c0000 [disabled] [size=64K]
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20265 (rev 02)
        Subsystem: Promise Technology, Inc.: Unknown device 4d33
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 9800 [size=8]
        Region 1: I/O ports at 9400 [size=4]
        Region 2: I/O ports at 9000 [size=8]
        Region 3: I/O ports at 8800 [size=4]
        Region 4: I/O ports at 8400 [size=64]
        Region 5: Memory at d5800000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [58] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-




7.6)
SCSI information (from /proc/scsi/scsi)
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: LITE-ON  Model: LTR-0841         Rev: MS86
  Type:   CD-ROM                           ANSI SCSI revision: 02

7.7) Other information that might be relevant to the problem
       (please look in /proc and include all information that you
       think to be relevant):

no more relevant data left i think


x)
Other notes, patches, fixes, workarounds

all mandrake update packages installed. 
But i think its sure that the error is produced by kernel, thats what the output says.





Thank u for Help. I hope that this report can help to find the error.
Ah, i forgot to say, that this error can be repeated. every time when i write some data (not more than 2-3 minutes)
the error comes back. When the error occures i cant use the hdd ones more. I have allways to reboot.

Another part of the problem is: 
first i have had only one ide bus used with one hdd. ...and the raid0 disks
The error occures the first time when i but another hdd as master at the second ide bus.
The error does never occures bevor.
But i need the second disk


hope u have all informations u need too find the problem.
have a nice day.

Christian Fraas



