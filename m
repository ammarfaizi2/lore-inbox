Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261530AbSL2UIQ>; Sun, 29 Dec 2002 15:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261523AbSL2UIP>; Sun, 29 Dec 2002 15:08:15 -0500
Received: from amsfep11-int.chello.nl ([213.46.243.20]:41797 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id <S261689AbSL2UHv>; Sun, 29 Dec 2002 15:07:51 -0500
Subject: Kernel panic on 2.4.19 when running netstat (relevant info added)
From: Frederik Vanrenterghem <frederik.vanrenterghem@chello.be>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1041192942.1344.21.camel@maui>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 29 Dec 2002 21:15:42 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'd like to resubmit yesterday's problem report, this time with the
necessary information included (Thanks Dan!).

Thanks in advance!

Frederik

1. When running netstat -a, the kernel panics (not always, but easily
reproducable)
2. I'm experiencing frequent kernel panics, when doing netstat -a. This
is as a regular user.I recompiled my 2.4.19 kernel with serial console
support earlier, which seemed to have removed the problem. Not so.
3. kernel panic; netstat
4. Linux version 2.4.19 (root@maui) (gcc version 2.95.4 20011002 (Debian
prerelease)) #1 Sat Dec 28 20:55:03 CET 2002 
5. Output of ksymoops:
ksymoops 2.4.6 on i686 2.4.19.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19/ (default)
     -m /boot/System.map-2.4.19 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.


Unable to handle kernel paging request at virtual address
00800024              
*pde = 00000000
Oops: 0000 
CPU:  0                                                                 
EIP:    0010:[<c02a0647>]    Not tainted                         
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206                                
eax: 00004eca   ebx: 00800000   ecx: d582fed0   edx: c1540000           
esi: d582fed0   edi: 00000c00   ebp: 00001000   esp: d582fea4
ds: 0018   es: 0018   ss: 0018
Process netstat (pid: 870, stackpage=d582f000)                       
Stack: 00000000 00000c00 cf90f000 00001000 00001177 00000000 00000c00
00000b22
       00000eca 00000012 00000b22 37312020 3031203a 32413144 383a3343
20373030
       46343732 34443632 3634313a 31302036 30303020 30303030 30303a30
30303030  
Call Trace:    [<c012c810>] [<c014cac7>] [<c01320a6>] [<c01086cf>]
Code: 66 83 7b 24 02 75 4a 8b 94 24 d0 00 00 00 81 44 24 1c 96
00         


>>EIP; c02a0647 <tcp_get_info+327/410>   <=====

>>ecx; d582fed0 <_end+1544ad0c/1d463e9c>
>>edx; c1540000 <_end+115ae3c/1d463e9c>
>>esi; d582fed0 <_end+1544ad0c/1d463e9c>
>>esp; d582fea4 <_end+1544ace0/1d463e9c>

Trace; c012c810 <__alloc_pages+40/170>
Trace; c014cac7 <proc_file_read+b7/1a0>
Trace; c01320a6 <sys_read+96/f0>
Trace; c01086cf <system_call+33/38>

Code;  c02a0647 <tcp_get_info+327/410>
00000000 <_EIP>:
Code;  c02a0647 <tcp_get_info+327/410>   <=====
   0:   66 83 7b 24 02            cmpw   $0x2,0x24(%ebx)   <=====
Code;  c02a064c <tcp_get_info+32c/410>
   5:   75 4a                     jne    51 <_EIP+0x51>
Code;  c02a064e <tcp_get_info+32e/410>
   7:   8b 94 24 d0 00 00 00      mov    0xd0(%esp,1),%edx
Code;  c02a0655 <tcp_get_info+335/410>
   e:   81 44 24 1c 96 00 00      addl   $0x96,0x1c(%esp,1)
Code;  c02a065c <tcp_get_info+33c/410>
  15:   00 

 <0>Kernel panic: Aiee, killing interrupt
handler!                              

1 warning issued.  Results may not be reliable.

6. netstat -a does it for me almost every time
7. Environment info: (Debian unstable)

7.1 Output of ver_linux:

Linux maui 2.4.19 #1 Sat Dec 28 20:55:03 CET 2002 i686 unknown unknown
GNU/Linux
 
Gnu C                  2.95.4
Gnu make               3.80
util-linux             2.11x
mount                  2.11x
modutils               2.4.21
e2fsprogs              1.32
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Procps                 3.1.1
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               4.5.3
Modules Loaded         ipt_LOG iptable_mangle nls_cp437 mga agpgart
w83781d i2c-proc i2c-dev i2c-viapro i2c-core es1371 ne2k-pci 8390
nls_iso8859-1 nls_cp850

7.2 

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 3
model name      : AMD Athlon(tm) Processor
stepping        : 1
cpu MHz         : 706.307
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 1409.02

7.3 cat /proc/modules 
ipt_LOG                 3096   1 (autoclean)
iptable_mangle          2100   0 (autoclean) (unused)
nls_cp437               4348   1 (autoclean)
mga                   103448   1
agpgart                12616   3
w83781d                17100   0
i2c-proc                6288   0 [w83781d]
i2c-dev                 3684   0 (unused)
i2c-viapro              3700   0 (unused)
i2c-core               12868   0 [w83781d i2c-proc i2c-dev i2c-viapro]
es1371                 26856   1
ne2k-pci                5024   1
8390                    5968   0 [ne2k-pci]
nls_iso8859-1           2844   1
nls_cp850               3580   0 (unused)

7.4 cat /proc/ioports 
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
0376-0376 : ide1
0378-037a : parport0
03c0-03df : vesafb
03f6-03f6 : ide0
03f8-03ff : serial(set)
0cf8-0cff : PCI conf1
8400-843f : Promise Technology, Inc. 20265
  8400-8407 : ide2
  8408-840f : ide3
  8410-843f : PDC20265
8800-8803 : Promise Technology, Inc. 20265
9000-9007 : Promise Technology, Inc. 20265
9400-9403 : Promise Technology, Inc. 20265
9800-9807 : Promise Technology, Inc. 20265
a000-a03f : Ensoniq 5880 AudioPCI
  a000-a03f : es1371
a400-a41f : Realtek Semiconductor Co., Ltd. RTL-8029(AS)
  a400-a41f : ne2k-pci
d000-d01f : VIA Technologies, Inc. UHCI USB (#2)
  d000-d01f : usb-uhci
d400-d41f : VIA Technologies, Inc. UHCI USB
  d400-d41f : usb-uhci
d800-d80f : VIA Technologies, Inc. Bus Master IDE
  d800-d807 : ide0
  d808-d80f : ide1
e400-e4ff : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
e800-e80f : VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
  e800-e807 : via2-smbus

 cat /proc/iomem 
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1bfebfff : System RAM
  00100000-002e58a1 : Kernel code
  002e58a2-0038be9f : Kernel data
1bfec000-1bfeefff : ACPI Tables
1bfef000-1bffefff : reserved
1bfff000-1bffffff : ACPI Non-volatile Storage
e2000000-e201ffff : Promise Technology, Inc. 20265
e2800000-e3dfffff : PCI Bus #01
  e2800000-e2ffffff : Matrox Graphics, Inc. MGA G400 AGP
  e3000000-e3003fff : Matrox Graphics, Inc. MGA G400 AGP
e3f00000-e6ffffff : PCI Bus #01
  e4000000-e5ffffff : Matrox Graphics, Inc. MGA G400 AGP
    e4000000-e4ffffff : vesafb
e7000000-e7ffffff : VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
ffff0000-ffffffff : reserved

7.5 lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
(rev 02)
        Subsystem: Asustek Computer, Inc. A7V Mainboard
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Region 0: Memory at e7000000 (32-bit, prefetchable) [size=16M]
        Capabilities: [a0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW+ Rate=x1,x2,x4
                Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x4
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
(prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000e000-0000dfff
        Memory behind bridge: e2800000-e3dfffff
        Prefetchable memory behind bridge: e3f00000-e6ffffff
        BridgeCtl: Parity- SERR- NoISA- VGA+ MAbort- >Reset- FastB2B-
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 22)
        Subsystem: Asustek Computer, Inc. A7V Mainboard
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:04.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 10)
(prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at d800 [size=16]
        Capabilities: [c0] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.2 USB Controller: VIA Technologies, Inc. USB (rev 10) (prog-if 00
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at d400 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.3 USB Controller: VIA Technologies, Inc. USB (rev 10) (prog-if 00
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 5
        Region 4: I/O ports at d000 [size=32]
        Capabilities: [80] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:04.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
(rev 30)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9
        Capabilities: [68] Power Management version 2
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8029(AS)
        Subsystem: Acer Incorporated [ALI]: Unknown device 0201
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 3
        Region 0: I/O ports at a400 [size=32]
00:0b.0 Multimedia audio controller: Ensoniq 5880 AudioPCI (rev 02)
        Subsystem: Ensoniq Creative Sound Blaster AudioPCI128
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at a000 [size=64]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:11.0 Unknown mass storage controller: Promise Technology, Inc. 20265
(rev 02)
        Subsystem: Promise Technology, Inc. Ultra100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 10
        Region 0: I/O ports at 9800 [size=8]
        Region 1: I/O ports at 9400 [size=4]
        Region 2: I/O ports at 9000 [size=8]
        Region 3: I/O ports at 8800 [size=4]
        Region 4: I/O ports at 8400 [size=64]
        Region 5: Memory at e2000000 (32-bit, non-prefetchable)
[size=128K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [58] Power Management version 1
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP
(rev 82) (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc. Millennium G450 Dual Head LE
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (4000ns min, 8000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at e4000000 (32-bit, prefetchable) [size=32M]
        Region 1: Memory at e3000000 (32-bit, non-prefetchable)
[size=16K]
        Region 2: Memory at e2800000 (32-bit, non-prefetchable)
[size=8M]
        Expansion ROM at e3fe0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [f0] AGP version 2.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2,x4
                Command: RQ=31 SBA+ AGP+ 64bit- FW- Rate=x4

Sorry if this is a bit lenghty...


-- 
Frederik Vanrenterghem <frederik.vanrenterghem@chello.be>

