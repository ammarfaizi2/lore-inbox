Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266730AbTAIOit>; Thu, 9 Jan 2003 09:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266735AbTAIOis>; Thu, 9 Jan 2003 09:38:48 -0500
Received: from bay2-f18.bay2.hotmail.com ([65.54.247.18]:8720 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id <S266730AbTAIOim>;
	Thu, 9 Jan 2003 09:38:42 -0500
X-Originating-IP: [66.38.177.73]
From: "Jean-Philippe Grenier" <jp_grenier@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: [2.4.20] Again with the __free_pages_ok oops
Date: Thu, 09 Jan 2003 14:47:19 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY2-F18jrRZ1UbDBRA0001b0d0@hotmail.com>
X-OriginalArrivalTime: 09 Jan 2003 14:47:19.0885 (UTC) FILETIME=[02EAFFD0:01C2B7EE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having this problem since I've updated from 2.2.16 to 2.4.18. A fix was 
released by hch and Marcelo in 2.4.20, but I still have the problem using 
2.4.20.

Please CC me in any response since I am not in the mailing list.

Here's the oops in 2.4.20:
-----------------------------------------
kernel BUG at page_alloc.c:100!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0132ba4>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 1a000000   ebx: c165bbfc   ecx: c165bc18   edx: c1653a54
esi: 000001fc   edi: 00000000   ebp: e4dd5458   esp: e41d9ee8
ds: 0018   es: 0018   ss: 0018
Process cc1 (pid: 854, stackpage=e41d9000)
Stack: c028f464 00026ff0 c100001c c165bc80 c028f3d4 c102c01c 00000217 
fffffffe
       00008ffa 0000001d 000001fc 00116000 e4dd5458 c012895f c165bbfc 
00000114
       08800000 e4825088 08696000 00000000 c0126ee0 c02eeda0 e4825084 
08400000
Call Trace:    [<c012895f>] [<c0126ee0>] [<c0129f5c>] [<c01170e6>] 
[<c011c163>]
  [<c011c3cf>] [<c01073e3>]
Code: 0f 0b 64 00 6d 63 25 c0 8b 6b 08 85 ed 74 08 0f 0b 66 00 6d


>>EIP; c0132ba4 <__free_pages_ok+44/340>   <=====

>>eax; 1a000000 Before first symbol
>>ebx; c165bbfc <_end+131bb18/284bff7c>
>>ecx; c165bc18 <_end+131bb34/284bff7c>
>>edx; c1653a54 <_end+1313970/284bff7c>
>>ebp; e4dd5458 <_end+24a95374/284bff7c>
>>esp; e41d9ee8 <_end+23e99e04/284bff7c>

Trace; c012895f <zap_pte_range+1af/1ff>
Trace; c0126ee0 <zap_page_range+c0/170>
Trace; c0129f5c <exit_mmap+bc/120>
Trace; c01170e6 <mmput+56/a0>
Trace; c011c163 <do_exit+b3/2f0>
Trace; c011c3cf <sys_exit+f/10>
Trace; c01073e3 <system_call+33/40>

Code;  c0132ba4 <__free_pages_ok+44/340>
00000000 <_EIP>:
Code;  c0132ba4 <__free_pages_ok+44/340>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0132ba6 <__free_pages_ok+46/340>
   2:   64 00 6d 63               add    %ch,%fs:0x63(%ebp)
Code;  c0132baa <__free_pages_ok+4a/340>
   6:   25 c0 8b 6b 08            and    $0x86b8bc0,%eax
Code;  c0132baf <__free_pages_ok+4f/340>
   b:   85 ed                     test   %ebp,%ebp
Code;  c0132bb1 <__free_pages_ok+51/340>
   d:   74 08                     je     17 <_EIP+0x17>
Code;  c0132bb3 <__free_pages_ok+53/340>
   f:   0f 0b                     ud2a
Code;  c0132bb5 <__free_pages_ok+55/340>
  11:   66                        data16
Code;  c0132bb6 <__free_pages_ok+56/340>
  12:   00 6d 00                  add    %ch,0x0(%ebp)


Here's the oops in 2.4.18-14
-----------------------------------------
kernel BUG at page_alloc.c:145!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0132a59>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 00000000   ebx: 01000000   ecx: c02e1280   edx: 00000000
esi: c1738bec   edi: 00000000   ebp: c100000c   esp: e413dec8
ds: 0018   es: 0018   ss: 0018
Process cc1 (pid: 13418, stackpage=e413d000)
Stack: c02e1354 c1738c54 c02e1280 c103400c 00000000 c02e1280 c0137aef 
e3e12a30
       e53ad630 0003e000 00100000 238d8067 c01288dd c1738bec 0000003f 
40800000
       e3538408 4064e000 00000000 c0126f10 c19abf20 e3538404 4054e000 
00100000
Call Trace: [<c0137aef>] page_remove_rmap [kernel] 0x5f (0xe413dee0))
[<c01288dd>] zap_pte_range [kernel] 0xdd (0xe413def8))
[<c0126f10>] do_zap_page_range [kernel] 0x80 (0xe413df14))
[<c0127409>] zap_page_range [kernel] 0x49 (0xe413df48))
[<c0129ecb>] exit_mmap [kernel] 0xbb (0xe413df6c))
[<c011779d>] mmput [kernel] 0x2d (0xe413df94))
[<c011be8b>] do_exit [kernel] 0x9b (0xe413dfa0))
[<c011c05f>] sys_exit [kernel] 0xf (0xe413dfb8))
[<c0108d13>] system_call [kernel] 0x33 (0xe413dfc0))
Code: 0f 0b 91 00 e7 83 23 c0 8b 46 18 89 f9 83 e0 eb 89 f3 89 46


>>EIP; c0132a59 <__free_pages_ok+b9/320>   <=====

>>ebx; 01000000 Before first symbol
>>ecx; c02e1280 <contig_page_data+100/440>
>>esi; c1738bec <_end+139d42c/284718a0>
>>ebp; c100000c <_end+c6484c/284718a0>
>>esp; e413dec8 <_end+23da2708/284718a0>

Trace; c0137aef <page_remove_rmap+5f/70>
Trace; c01288dd <zap_pte_range+dd/115>
Trace; c0126f10 <do_zap_page_range+80/100>
Trace; c0127409 <zap_page_range+49/80>
Trace; c0129ecb <exit_mmap+bb/150>
Trace; c011779d <mmput+2d/70>
Trace; c011be8b <do_exit+9b/240>
Trace; c011c05f <sys_exit+f/10>
Trace; c0108d13 <system_call+33/40>

Code;  c0132a59 <__free_pages_ok+b9/320>
00000000 <_EIP>:
Code;  c0132a59 <__free_pages_ok+b9/320>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0132a5b <__free_pages_ok+bb/320>
   2:   91                        xchg   %eax,%ecx
Code;  c0132a5c <__free_pages_ok+bc/320>
   3:   00 e7                     add    %ah,%bh
Code;  c0132a5e <__free_pages_ok+be/320>
   5:   83 23 c0                  andl   $0xffffffc0,(%ebx)
Code;  c0132a61 <__free_pages_ok+c1/320>
   8:   8b 46 18                  mov    0x18(%esi),%eax
Code;  c0132a64 <__free_pages_ok+c4/320>
   b:   89 f9                     mov    %edi,%ecx
Code;  c0132a66 <__free_pages_ok+c6/320>
   d:   83 e0 eb                  and    $0xffffffeb,%eax
Code;  c0132a69 <__free_pages_ok+c9/320>
  10:   89 f3                     mov    %esi,%ebx
Code;  c0132a6b <__free_pages_ok+cb/320>
  12:   89 46 00                  mov    %eax,0x0(%esi)


And here's my system info :
-----------------------------------------
[root@scavenger linux-2.4.20]# cat /proc/version
Linux version 2.4.20 (root@scavenger) (gcc version 3.2 20020903 (Red Hat 
Linux 8.0 3.2-7)) #5 SMP Wed Jan 8 19:26:31 EST 2003


[root@scavenger linux-2.4.20]# sh ./scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux scavenger 2.4.20 #5 SMP Wed Jan 8 19:26:31 EST 2003 i586 i586 i386 
GNU/Linux

Gnu C                  3.2
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
modutils               2.4.18
e2fsprogs              1.27
jfsutils               1.0.17
reiserfsprogs          3.6.2
PPP                    2.4.1
Linux C Library        2.2.93
Dynamic linker (ldd)   2.2.93
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.12
Modules Loaded         ipt_MASQUERADE iptable_nat ip_conntrack ppp_synctty 
ppp_async ppp_generic slhc tulip iptable_filter ip_tables mousedev keybdev 
input


[root@scavenger linux-2.4.20]# cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 12
cpu MHz         : 501.145
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 pge mmx syscall 3dnow 
k6_mtrr
bogomips        : 999.42


[root@scavenger linux-2.4.20]# cat /proc/modules
ipt_MASQUERADE          2200   2 (autoclean)
iptable_nat            20504   1 (autoclean) [ipt_MASQUERADE]
ip_conntrack           28512   1 (autoclean) [ipt_MASQUERADE iptable_nat]
ppp_synctty             7872   0 (unused)
ppp_async               9504   1
ppp_generic            23296   3 [ppp_synctty ppp_async]
slhc                    6684   0 [ppp_generic]
tulip                  44160   2
iptable_filter          2316   1 (autoclean)
ip_tables              15224   5 [ipt_MASQUERADE iptable_nat iptable_filter]
mousedev                5400   0 (unused)
keybdev                 2688   0 (unused)
input                   5952   0 [mousedev keybdev]


[root@scavenger linux-2.4.20]# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
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
5000-50ff : VIA Technologies, Inc. VT82C586B ACPI
6400-640f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
  6400-6407 : ide0
  6408-640f : ide1
6800-681f : VIA Technologies, Inc. USB
  6800-681f : usb-uhci
6c00-6cff : Linksys Network Everywhere Fast Ethernet 10/100 model NC100
  6c00-6cff : tulip
7000-70ff : Linksys Network Everywhere Fast Ethernet 10/100 model NC100 (#2)
  7000-70ff : tulip


[root@scavenger linux-2.4.20]# cat /proc/ioports
0000-001f : dma1
0020-003f : pic1
0040-005f : timer
0060-006f : keyboard
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
5000-50ff : VIA Technologies, Inc. VT82C586B ACPI
6400-640f : VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE
  6400-6407 : ide0
  6408-640f : ide1
6800-681f : VIA Technologies, Inc. USB
  6800-681f : usb-uhci
6c00-6cff : Linksys Network Everywhere Fast Ethernet 10/100 model NC100
  6c00-6cff : tulip
7000-70ff : Linksys Network Everywhere Fast Ethernet 10/100 model NC100 (#2)
  7000-70ff : tulip


[root@scavenger linux-2.4.20]# cat /proc/iomem
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-27feffff : System RAM
  00100000-0024865c : Kernel code
  0024865d-002c7dbf : Kernel data
27ff0000-27ff2fff : ACPI Non-volatile Storage
27ff3000-27ffffff : ACPI Tables
e0000000-e3ffffff : VIA Technologies, Inc. VT82C598 [Apollo MVP3]
e6000000-e6003fff : Matrox Graphics, Inc. MGA 1064SG [Mystique]
e7000000-e77fffff : Matrox Graphics, Inc. MGA 1064SG [Mystique]
e8000000-e87fffff : Matrox Graphics, Inc. MGA 1064SG [Mystique]
ea000000-ea0003ff : Linksys Network Everywhere Fast Ethernet 10/100 model 
NC100 (#2)
  ea000000-ea0003ff : tulip
ea001000-ea0013ff : Linksys Network Everywhere Fast Ethernet 10/100 model 
NC100
  ea001000-ea0013ff : tulip
ffff0000-ffffffff : reserved


[root@scavenger src]# cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  661073920 656482304  4591616        0 69111808 450326528
Swap: 123367424        0 123367424
MemTotal:       645580 kB
MemFree:          4484 kB
MemShared:           0 kB
Buffers:         67492 kB
Cached:         439772 kB
SwapCached:          0 kB
Active:          64468 kB
Inactive:       447044 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       645580 kB
LowFree:          4484 kB
SwapTotal:      120476 kB
SwapFree:       120476 kB


[root@scavenger linux-2.4.20]# lspci -vvv
00:00.0 Host bridge: VIA Technologies, Inc. VT82C598 [Apollo MVP3] (rev 04)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 16
        Region 0: Memory at e0000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=7 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo 
MVP3/Pro133x AGP] (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 0000f000-00000fff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo 
VP] (rev 47)
        Subsystem: VIA Technologies, Inc. MVP3 ISA Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: VIA Technologies, Inc. VT82C586B PIPC Bus Master IDE 
(rev 06) (prog-if 8a [Master SecP PriP])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Region 4: I/O ports at 6400 [size=16]

00:07.2 USB Controller: VIA Technologies, Inc. USB (rev 02) (prog-if 00 
[UHCI])
        Subsystem: VIA Technologies, Inc. (Wrong ID) USB Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at 6800 [size=32]

00:07.3 Host bridge: VIA Technologies, Inc. VT82C586B ACPI (rev 10)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:0a.0 Ethernet controller: Linksys Network Everywhere Fast Ethernet 10/100 
model NC100 (rev 11)
        Subsystem: Linksys: Unknown device 0570
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (63750ns min, 63750ns max), cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at 6c00 [size=256]
        Region 1: Memory at ea001000 (32-bit, non-prefetchable) [size=1K]
        Expansion ROM at e4000000 [disabled] [size=128K]
        Capabilities: [c0] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.0 Ethernet controller: Linksys Network Everywhere Fast Ethernet 10/100 
model NC100 (rev 11)
        Subsystem: Linksys: Unknown device 0570
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (63750ns min, 63750ns max), cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at 7000 [size=256]
        Region 1: Memory at ea000000 (32-bit, non-prefetchable) [size=1K]
        Expansion ROM at e5000000 [disabled] [size=128K]
        Capabilities: [c0] Power Management version 1
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA 
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 VGA compatible controller: Matrox Graphics, Inc. MGA 1064SG 
[Mystique] (rev 02) (prog-if 00 [VGA])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping+ SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e6000000 (32-bit, non-prefetchable) [size=16K]
        Region 1: Memory at e7000000 (32-bit, prefetchable) [size=8M]
        Region 2: Memory at e8000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]


Jean-Philippe




_________________________________________________________________
MSN 8: advanced junk mail protection and 2 months FREE*. 
http://join.msn.com/?page=features/junkmail

