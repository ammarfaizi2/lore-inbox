Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265356AbRFVHK2>; Fri, 22 Jun 2001 03:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265355AbRFVHKT>; Fri, 22 Jun 2001 03:10:19 -0400
Received: from ns.viventus.no ([195.18.200.139]:32519 "EHLO viventus.no")
	by vger.kernel.org with ESMTP id <S265356AbRFVHJ7>;
	Fri, 22 Jun 2001 03:09:59 -0400
From: Rafael Martinez <rafael@viewpoint.no>
To: linux-kernel@vger.kernel.org
Reply-To: rafael@viewpoint.no
Subject: [Bug report] (Oops) Filesystem? - Unable to handle kernel NULL pointer dereference at virtual address
Date: Fri, 22 Jun 2001 09:08:18 +0100 (CEST)
X-Mailer: XCmail 1.2 - with PGP support, PGP engine version 0.5 (Linux)
X-Mailerorigin: http://www.fsai.fh-trier.de/~schmitzj/Xclasses/XCmail/
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Message-ID: <auto-000000273334@viventus.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

****************************************************
I have got a error in my syslog about a Null pointer in the kernel (OOPS):

/proc/version: 
Linux version 2.4.5 (root@coper) (gcc version 2.96 20000731 (Red Hat Linux
7.0)) 
#4 SMP Tue Jun 12 10:05:20 EDT 2001

*******************************************
ksymoops 2.3.4 on i686 2.4.5.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -L (specified)
     -o /lib/modules/2.4.5/ (default)
     -M (specified)

No modules in ksyms, skipping objects
cpu: 0, clocks: 995673, slice: 331891
cpu: 1, clocks: 995673, slice: 331891
Unable to handle kernel NULL pointer dereference at virtual address
00000015
c014db72
*pde = 00000000
Oops: 0002
CPU:    1
EIP:    0010:[<c014db72>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 00000005   ebx: cc870440   ecx: 00000020   edx: c1c12000
esi: c0287140   edi: 0000000c   ebp: c0287490   esp: c63e7e6c
ds: 0018   es: 0018   ss: 0018
Process top (pid: 21710, stackpage=c63e7000)
Stack: c0149366 cc870440 c1c12000 00000000 c014ee0c cc870440 c1c12000
0000000c 
       c023b269 c014f096 c144f000 c1c12000 0000000c c1c12000 ffffffea
cf6190e0 
       c01470d6 c1445060 00000007 c63e6000 fffffff4 cf6190e0 cc80b260
c013e403 
Call Trace: [<c0149366>] [<c014ee0c>] [<c014f096>] [<c01470d6>]
[<c013e403>] [<c013ec85>] [<c013f5a2>] 
       [<c0132f26>] [<c013e08b>] [<c013322a>] [<c0106df7>] [<c010002b>] 
Code: f0 ff 48 10 8b 42 24 83 48 14 08 52 e8 dd fe ff ff 5a c3 8d 

>>EIP; c014db72 <kiobuf_wait_for_io+3a62/5c90>   <=====
Trace; c0149366 <iput+b6/170>
Trace; c014ee0c <kiobuf_wait_for_io+4cfc/5c90>
Trace; c014f096 <kiobuf_wait_for_io+4f86/5c90>
Trace; c01470d6 <d_alloc+16/180>
Trace; c013e403 <path_release+f3/190>
Trace; c013ec85 <path_walk+685/ab0>
Trace; c013f5a2 <vfs_create+192/750>
Trace; c0132f26 <filp_open+36/60>
Trace; c013e08b <getname+5b/a0>
Trace; c013322a <get_unused_fd+19a/260>
Trace; c0106df7 <__read_lock_failed+115b/27c4>
Trace; c010002b Before first symbol
Code;  c014db72 <kiobuf_wait_for_io+3a62/5c90>
00000000 <_EIP>:
Code;  c014db72 <kiobuf_wait_for_io+3a62/5c90>   <=====
   0:   f0 ff 48 10               lock decl 0x10(%eax)   <=====
Code;  c014db76 <kiobuf_wait_for_io+3a66/5c90>
   4:   8b 42 24                  mov    0x24(%edx),%eax
Code;  c014db79 <kiobuf_wait_for_io+3a69/5c90>
   7:   83 48 14 08               orl    $0x8,0x14(%eax)
Code;  c014db7d <kiobuf_wait_for_io+3a6d/5c90>
   b:   52                        push   %edx
Code;  c014db7e <kiobuf_wait_for_io+3a6e/5c90>
   c:   e8 dd fe ff ff            call   fffffeee <_EIP+0xfffffeee>
c014da60 <kiobuf_wait_for_io+3950/5c90>
Code;  c014db83 <kiobuf_wait_for_io+3a73/5c90>
  11:   5a                        pop    %edx
Code;  c014db84 <kiobuf_wait_for_io+3a74/5c90>
  12:   c3                        ret    
Code;  c014db85 <kiobuf_wait_for_io+3a75/5c90>
  13:   8d 00                     lea    (%eax),%eax

Unable to handle kernel NULL pointer dereference at virtual address
00000015
c014db72
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c014db72>]
EFLAGS: 00010206
eax: 00000005   ebx: cfbf1080   ecx: 00000020   edx: ca546000
esi: c0287140   edi: 0000000c   ebp: c0287490   esp: cb817e6c
ds: 0018   es: 0018   ss: 0018
Process top (pid: 25765, stackpage=cb817000)
Stack: c0149366 cfbf1080 ca546000 00000000 c014ee0c cfbf1080 ca546000
0000000c 
       c023b269 c014f096 c144f000 ca546000 0000000c ca546000 ffffffea
cfbf1260 
       c01470d6 c1445060 00000007 cb816000 fffffff4 cfbf1260 cd9075a0
c013e403 
Call Trace: [<c0149366>] [<c014ee0c>] [<c014f096>] [<c01470d6>]
[<c013e403>] [<c013ec85>] [<c013f5a2>] 
       [<c0132f26>] [<c013e08b>] [<c013322a>] [<c0106df7>] [<c010002b>] 
Code: f0 ff 48 10 8b 42 24 83 48 14 08 52 e8 dd fe ff ff 5a c3 8d 

>>EIP; c014db72 <kiobuf_wait_for_io+3a62/5c90>   <=====
Trace; c0149366 <iput+b6/170>
Trace; c014ee0c <kiobuf_wait_for_io+4cfc/5c90>
Trace; c014f096 <kiobuf_wait_for_io+4f86/5c90>
Trace; c01470d6 <d_alloc+16/180>
Trace; c013e403 <path_release+f3/190>
Trace; c013ec85 <path_walk+685/ab0>
Trace; c013f5a2 <vfs_create+192/750>
Trace; c0132f26 <filp_open+36/60>
Trace; c013e08b <getname+5b/a0>
Trace; c013322a <get_unused_fd+19a/260>
Trace; c0106df7 <__read_lock_failed+115b/27c4>
Trace; c010002b Before first symbol
Code;  c014db72 <kiobuf_wait_for_io+3a62/5c90>
00000000 <_EIP>:
Code;  c014db72 <kiobuf_wait_for_io+3a62/5c90>   <=====
   0:   f0 ff 48 10               lock decl 0x10(%eax)   <=====
Code;  c014db76 <kiobuf_wait_for_io+3a66/5c90>
   4:   8b 42 24                  mov    0x24(%edx),%eax
Code;  c014db79 <kiobuf_wait_for_io+3a69/5c90>
   7:   83 48 14 08               orl    $0x8,0x14(%eax)
Code;  c014db7d <kiobuf_wait_for_io+3a6d/5c90>
   b:   52                        push   %edx
Code;  c014db7e <kiobuf_wait_for_io+3a6e/5c90>
   c:   e8 dd fe ff ff            call   fffffeee <_EIP+0xfffffeee>
c014da60 <kiobuf_wait_for_io+3950/5c90>
Code;  c014db83 <kiobuf_wait_for_io+3a73/5c90>
  11:   5a                        pop    %edx
Code;  c014db84 <kiobuf_wait_for_io+3a74/5c90>
  12:   c3                        ret    
Code;  c014db85 <kiobuf_wait_for_io+3a75/5c90>
  13:   8d 00                     lea    (%eax),%eax

Unable to handle kernel NULL pointer dereference at virtual address
00000015
c014db72
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c014db72>]
EFLAGS: 00010206
eax: 00000005   ebx: cf5ca2a0   ecx: 00000020   edx: cf544000
esi: c0287140   edi: 0000000a   ebp: c0287470   esp: c2b5fe6c
ds: 0018   es: 0018   ss: 0018
Process top (pid: 20825, stackpage=c2b5f000)
Stack: c0149366 cf5ca2a0 cf544000 00000000 c014ee0c cf5ca2a0 cf544000
0000000a 
       c023b276 c014f096 c144f000 cf544000 0000000a cf544000 ffffffea
c4a42860 
       c01470d6 c1445060 00000007 c2b5e000 fffffff4 c4a42860 cca15c40
c013e403 
Call Trace: [<c0149366>] [<c014ee0c>] [<c014f096>] [<c01470d6>]
[<c013e403>] [<c013ec85>] [<c013f5a2>] 
       [<c0132f26>] [<c013e08b>] [<c013322a>] [<c0106df7>] [<c010002b>] 
Code: f0 ff 48 10 8b 42 24 83 48 14 08 52 e8 dd fe ff ff 5a c3 8d 

>>EIP; c014db72 <kiobuf_wait_for_io+3a62/5c90>   <=====
Trace; c0149366 <iput+b6/170>
Trace; c014ee0c <kiobuf_wait_for_io+4cfc/5c90>
Trace; c014f096 <kiobuf_wait_for_io+4f86/5c90>
Trace; c01470d6 <d_alloc+16/180>
Trace; c013e403 <path_release+f3/190>
Trace; c013ec85 <path_walk+685/ab0>
Trace; c013f5a2 <vfs_create+192/750>
Trace; c0132f26 <filp_open+36/60>
Trace; c013e08b <getname+5b/a0>
Trace; c013322a <get_unused_fd+19a/260>
Trace; c0106df7 <__read_lock_failed+115b/27c4>
Trace; c010002b Before first symbol
Code;  c014db72 <kiobuf_wait_for_io+3a62/5c90>
00000000 <_EIP>:
Code;  c014db72 <kiobuf_wait_for_io+3a62/5c90>   <=====
   0:   f0 ff 48 10               lock decl 0x10(%eax)   <=====
Code;  c014db76 <kiobuf_wait_for_io+3a66/5c90>
   4:   8b 42 24                  mov    0x24(%edx),%eax
Code;  c014db79 <kiobuf_wait_for_io+3a69/5c90>
   7:   83 48 14 08               orl    $0x8,0x14(%eax)
Code;  c014db7d <kiobuf_wait_for_io+3a6d/5c90>
   b:   52                        push   %edx
Code;  c014db7e <kiobuf_wait_for_io+3a6e/5c90>
   c:   e8 dd fe ff ff            call   fffffeee <_EIP+0xfffffeee>
c014da60 <kiobuf_wait_for_io+3950/5c90>
Code;  c014db83 <kiobuf_wait_for_io+3a73/5c90>
  11:   5a                        pop    %edx
Code;  c014db84 <kiobuf_wait_for_io+3a74/5c90>
  12:   c3                        ret    
Code;  c014db85 <kiobuf_wait_for_io+3a75/5c90>
  13:   8d 00                     lea    (%eax),%eax
*******************************************************************
Linux 2.4.5 #4 SMP Tue Jun 12 10:05:20 EDT 2001
i686 unknown
 
Gnu C                  2.96
Gnu make               3.79.1
binutils               2.10.0.18
util-linux             2.10m
mount                  2.10m
modutils               2.3.21
e2fsprogs              1.18
pcmcia-cs              3.1.19
PPP                    2.3.11
isdn4k-utils           3.1pre1
Linux C Library        > libc.2.2
Dynamic linker (ldd)   2.2
Procps                 2.0.7
Net-tools              1.56
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         
*******************************************

cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 846.332
cache size      : 256 KB
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
bogomips        : 1690.82

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 3
cpu MHz         : 846.332
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 3
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr sse
bogomips        : 1690.82

*****************************************************
cat /proc/ioports 
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
02f8-02ff : serial(auto)
0376-0376 : ide1
03c0-03df : vga+
03f8-03ff : serial(auto)
0c00-0c3f : Intel Corporation 82371AB PIIX4 ACPI
0cf8-0cff : PCI conf1
1040-105f : Intel Corporation 82371AB PIIX4 ACPI
2000-20ff : Adaptec 7896
2400-24ff : Adaptec 7896 (#2)
2800-283f : Intel Corporation 82557 [Ethernet Pro 100]
  2800-283f : eepro100
2840-285f : Intel Corporation 82371AB PIIX4 USB
2860-286f : Intel Corporation 82371AB PIIX4 IDE
3000-3fff : PCI Bus #01
  3000-3fff : PCI Bus #02
    3000-303f : Intel Corporation 82557 [Ethernet Pro 100] (#2)
      3000-303f : eepro100
    3040-307f : Intel Corporation 82557 [Ethernet Pro 100] (#3)
      3040-307f : eepro100
***********************************************

cat /proc/iomem   
00000000-0009f7ff : System RAM
0009f800-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000cd7ff : Extension ROM
000cd800-000ce7ff : Extension ROM
000ce800-000cffff : Extension ROM
000d0000-000d17ff : Extension ROM
000f0000-000fffff : System ROM
00100000-0ffeffff : System RAM
  00100000-0022b0e7 : Kernel code
  0022b0e8-0029a05f : Kernel data
0fff0000-0ffffbff : ACPI Tables
0ffffc00-0fffffff : ACPI Non-volatile Storage
f4000000-f40fffff : Intel Corporation 82557 [Ethernet Pro 100]
f4100000-f4100fff : Adaptec 7896
  f4100000-f4100fff : aic7xxx
f4101000-f4101fff : Adaptec 7896 (#2)
  f4101000-f4101fff : aic7xxx
f4102000-f4102fff : Intel Corporation 82557 [Ethernet Pro 100]
  f4102000-f4102fff : eepro100
f4103000-f4103fff : Cirrus Logic GD 5480
f4200000-f44fffff : PCI Bus #01
  f4200000-f44fffff : PCI Bus #02
    f4200000-f42fffff : Intel Corporation 82557 [Ethernet Pro 100] (#2)
    f4300000-f43fffff : Intel Corporation 82557 [Ethernet Pro 100] (#3)
    f4400000-f4400fff : Intel Corporation 82557 [Ethernet Pro 100] (#2)
      f4400000-f4400fff : eepro100
    f4401000-f4401fff : Intel Corporation 82557 [Ethernet Pro 100] (#3)
      f4401000-f4401fff : eepro100
f6000000-f7ffffff : Cirrus Logic GD 5480
f8000000-fbffffff : Intel Corporation 440GX - 82443GX Host bridge
fec00000-fec0ffff : reserved
fee00000-fee00fff : reserved
fff80000-ffffffff : reserved

*****************************************************

lspci -vvv

00:00.0 Host bridge: Intel Corporation 440GX - 82443GX Host bridge
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
    Latency: 64
    Region 0: Memory at f8000000 (32-bit, prefetchable) [size=64M]
    Capabilities: [a0] AGP version 1.0
        Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
        Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440GX - 82443GX AGP bridge (prog-if
00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
    Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 64
    Bus: primary=00, secondary=01, subordinate=02, sec-latency=64
    I/O behind bridge: 00003000-00003fff
    Memory behind bridge: f4200000-f44fffff
    Prefetchable memory behind bridge: fff00000-000fffff
    BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B+

00:0c.0 SCSI storage controller: Adaptec 7896
    Subsystem: Adaptec: Unknown device 0053
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 64 (9750ns min, 6250ns max), cache line size 08
    Interrupt: pin A routed to IRQ 11
    BIST result: 00
    Region 0: I/O ports at 2000 [disabled] [size=256]
    Region 1: Memory at f4100000 (64-bit, non-prefetchable) [size=4K]
    Expansion ROM at <unassigned> [disabled] [size=128K]
    Capabilities: [dc] Power Management version 1
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.1 SCSI storage controller: Adaptec 7896
    Subsystem: Adaptec: Unknown device 0053
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 64 (9750ns min, 6250ns max), cache line size 08
    Interrupt: pin A routed to IRQ 11
    BIST result: 00
    Region 0: I/O ports at 2400 [disabled] [size=256]
    Region 1: Memory at f4101000 (64-bit, non-prefetchable) [size=4K]
    Capabilities: [dc] Power Management version 1
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0e.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
(rev 08)
    Subsystem: Intel Corporation 82559 Fast Ethernet LAN on Motherboard
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 64 (2000ns min, 14000ns max), cache line size 08
    Interrupt: pin A routed to IRQ 10
    Region 0: Memory at f4102000 (32-bit, non-prefetchable) [size=4K]
    Region 1: I/O ports at 2800 [size=64]
    Region 2: Memory at f4000000 (32-bit, non-prefetchable) [size=1M]
    Expansion ROM at <unassigned> [disabled] [size=1M]
    Capabilities: [dc] Power Management version 2
        Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:12.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 02)
    Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 0

00:12.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 64
    Region 4: I/O ports at 2860 [size=16]

00:12.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
    Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 64
    Interrupt: pin D routed to IRQ 10
    Region 4: I/O ports at 2840 [size=32]

00:12.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 02)
    Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Interrupt: pin ? routed to IRQ 9

00:14.0 VGA compatible controller: Cirrus Logic GD 5480 (rev 23) (prog-if
00 [VGA])
    Subsystem: Cirrus Logic CL-GD5480
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 64 (500ns min, 2500ns max)
    Region 0: Memory at f6000000 (32-bit, prefetchable) [size=32M]
    Region 1: Memory at f4103000 (32-bit, non-prefetchable) [size=4K]
    Expansion ROM at <unassigned> [disabled] [size=32K]

01:0f.0 PCI bridge: Digital Equipment Corporation DECchip 21150 (rev 06)
(prog-if 00 [Normal decode])
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B+
    Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 240, cache line size 08
    Bus: primary=01, secondary=02, subordinate=02, sec-latency=68
    I/O behind bridge: 00003000-00003fff
    Memory behind bridge: f4200000-f44fffff
    Prefetchable memory behind bridge: 00000000fff00000-0000000000000000
    BridgeCtl: Parity- SERR+ NoISA+ VGA- MAbort- >Reset- FastB2B-
    Capabilities: [dc] Power Management version 1
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Bridge: PM- B3+

02:04.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
(rev 08)
    Subsystem: Intel Corporation EtherExpress PRO/100+ Server Adapter
(PILA8470B)
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 208 (2000ns min, 14000ns max), cache line size 08
    Interrupt: pin A routed to IRQ 5
    Region 0: Memory at f4400000 (32-bit, non-prefetchable) [size=4K]
    Region 1: I/O ports at 3000 [size=64]
    Region 2: Memory at f4200000 (32-bit, non-prefetchable) [size=1M]
    Expansion ROM at <unassigned> [disabled] [size=1M]
    Capabilities: [dc] Power Management version 2
        Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 PME-Enable- DSel=0 DScale=2 PME-

02:07.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
(rev 08)
    Subsystem: Intel Corporation EtherExpress PRO/100+ Server Adapter
(PILA8470B)
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr-
Stepping- SERR- FastB2B-
    Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
    Latency: 208 (2000ns min, 14000ns max), cache line size 08
    Interrupt: pin A routed to IRQ 11
    Region 0: Memory at f4401000 (32-bit, non-prefetchable) [size=4K]
    Region 1: I/O ports at 3040 [size=64]
    Region 2: Memory at f4300000 (32-bit, non-prefetchable) [size=1M]
    Expansion ROM at <unassigned> [disabled] [size=1M]
    Capabilities: [dc] Power Management version 2
        Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
        Status: D0 PME-Enable- DSel=0 DScale=2 PME-

********************************************************

cat /proc/scsi/scsi 

Attached devices: 
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: QUANTUM  Model: ATLAS 10K 9SCA   Rev: UCH0
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 01 Lun: 00
  Vendor: QUANTUM  Model: ATLAS 10K 9SCA   Rev: UCH0
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: QUANTUM  Model: ATLAS10K2-TY184J Rev: DA40
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 03 Lun: 00
  Vendor: QUANTUM  Model: ATLAS10K2-TY184J Rev: DA40
  Type:   Direct-Access                    ANSI SCSI revision: 03
Host: scsi0 Channel: 00 Id: 06 Lun: 00
  Vendor: ESG-SHV  Model: SCA HSBP M10     Rev: 0.04
  Type:   Processor                        ANSI SCSI revision: 02

*****************************************************

I hope this will help.

Rafael Martinez


