Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270865AbTG0RPf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 13:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270870AbTG0RPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 13:15:35 -0400
Received: from softers.net ([213.139.168.106]:23012 "EHLO mail.softers.net")
	by vger.kernel.org with ESMTP id S270865AbTG0RPW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 13:15:22 -0400
Message-ID: <3F240C62.D49203FE@softers.net>
Date: Sun, 27 Jul 2003 20:31:14 +0300
From: Jarmo =?iso-8859-1?Q?J=E4rvenp=E4=E4?= 
	<Jarmo.Jarvenpaa@softers.net>
Organization: Softers Oy
X-Mailer: Mozilla 4.8 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: Kernel crash, no known reason
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Kernel crash, scroll lock led blinking (and some sysreq's still
functioned)
- *no* SW-raid even though module is loaded
- one ext2 filesystem
- uses kernel nfs-client to mount some remote directories
- Plain kernel 2.4.20 with freeswan 1.99 with x509patch-0.9.27
- At crash-time, seems somebody was uploading to nfs-mounted directory
(which is normal usage and has been working for a long time).

--
Not a slightest idea why this occurred. 

Jarmo



Information below:

Ksymoops:
Warning (compare_maps): mismatch on symbol zeroes  , ipsec says
c88c6c40, /lib/modules/2.4.20/kernel/net/ipsec/ipsec.o says c88c6b40. 
Ignoring /lib/modules/2.4.20/kerne
l/net/ipsec/ipsec.o entry
Jul 27 10:57:56 ------ kernel: kernel BUG at page_alloc.c:217!
Jul 27 10:57:56 ------ kernel: invalid operand: 0000
Jul 27 10:57:56 ------ kernel: CPU:    0
Jul 27 10:57:56 ------ kernel: EIP:    0010:[rmqueue+140/592]   
Tainted: P
Jul 27 10:57:56 ------ kernel: EIP:    0010:[<c012d45c>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
Jul 27 10:57:56 ------ kernel: EFLAGS: 00010002
Jul 27 10:57:56 ------ kernel: eax: 00001000   ebx: c10f2cd4   ecx:
00000000   edx: 0000584a
Jul 27 10:57:56 ------ kernel: esi: c0254e74   edi: 00000000   ebp:
c0254e60   esp: c4da3e80
Jul 27 10:57:56 ------ kernel: ds: 0018   es: 0018   ss: 0018
Jul 27 10:57:56 ------ kernel: Process proftpd (pid: 27133,
stackpage=c4da3000)
Jul 27 10:57:56 ------ kernel: Stack: 00000000 c10f2cd4 00001a58
c7c0b0e8 0002e5a8 00000282 00000000 c0254e60
Jul 27 10:57:56 ------ kernel:        c0255078 00000201 c4da3f48
00000000 c012d87b c1018670 c0254f10 c0255070
Jul 27 10:57:56 ------ kernel:        000001f0 000005a8 00000000
c24ed3a0 c4da3f48 c3dbb32c c012da05 c0143501
Jul 27 10:57:56 ------ kernel: Call Trace:    [__alloc_pages+75/400]
[__get_free_pages+69/80] [__pollwait+65/192] [tcp_poll+54/400]
Jul 27 10:57:56 ------ kernel: Call Trace:    [<c012d87b>] [<c012da05>]
[<c0143501>] [<c01dfeb6>] [<c01bfd9c>]
Jul 27 10:57:56 ------ kernel:   [<c0143897>] [<c0143c1e>] [<c010741f>]
Jul 27 10:57:56 ------ kernel: Code: 0f 0b d9 00 13 4d 22 c0 8b 53 04 89
dd 8b 03 89 50 04 89 02


>>EIP; c012d45c <rmqueue+8c/250>   <=====

>>ebx; c10f2cd4 <_end+e1969c/858ea28>
>>esi; c0254e74 <contig_page_data+14/340>
>>ebp; c0254e60 <contig_page_data+0/340>
>>esp; c4da3e80 <_end+4aca848/858ea28>

Trace; c012d87b <__alloc_pages+4b/190>
Trace; c012da05 <__get_free_pages+45/50>
Trace; c0143501 <__pollwait+41/c0>
Trace; c01dfeb6 <tcp_poll+36/190>
Trace; c01bfd9c <sock_poll+2c/40>
Trace; c0143897 <do_select+227/230>
Trace; c0143c1e <sys_select+34e/4e0>
Trace; c010741f <system_call+33/38>

Code;  c012d45c <rmqueue+8c/250>
00000000 <_EIP>:
Code;  c012d45c <rmqueue+8c/250>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012d45e <rmqueue+8e/250>
   2:   d9 00                     flds   (%eax)
Code;  c012d460 <rmqueue+90/250>
   4:   13 4d 22                  adc    0x22(%ebp),%ecx
Code;  c012d463 <rmqueue+93/250>
   7:   c0 8b 53 04 89 dd 8b      rorb   $0x8b,0xdd890453(%ebx)
Code;  c012d46a <rmqueue+9a/250>
   e:   03 89 50 04 89 02         add    0x2890450(%ecx),%ecx

Jul 27 10:58:07 ------ kernel:  kernel BUG at page_alloc.c:217!
Jul 27 10:58:07 ------ kernel: invalid operand: 0000
Jul 27 10:58:07 ------ kernel: CPU:    0
Jul 27 10:58:07 ------ kernel: EIP:    0010:[rmqueue+140/592]   
Tainted: P
Jul 27 10:58:07 ------ kernel: EIP:    0010:[<c012d45c>]    Tainted: P
Jul 27 10:58:07 ------ kernel: EFLAGS: 00010002
Jul 27 10:58:07 ------ kernel: eax: 00001000   ebx: c10f2cd4   ecx:
00000000   edx: 0000584a
Jul 27 10:58:07 ------ kernel: esi: c0254e74   edi: 00000000   ebp:
c0254e60   esp: c4da3e60
Jul 27 10:58:07 ------ kernel: ds: 0018   es: 0018   ss: 0018
Jul 27 10:58:07 ------ kernel: Process ps (pid: 27152,
stackpage=c4da3000)
Jul 27 10:58:07 ------ kernel: Stack: 00000282 c10f2cd4 c1010b60
000008a2 000008a2 00000286 00000000 c0254e60
Jul 27 10:58:07 ------ kernel:        c0255098 00000201 0422e025
00000000 c012d87b c14b3540 c0254f10 c0255090
Jul 27 10:58:07 ------ kernel:        000001d2 c4863568 00000000
c10b6004 0422e025 c4863568 c0122c4f c10b6004
Jul 27 10:58:07 ------ kernel: Call Trace:    [__alloc_pages+75/400]
[do_wp_page+159/560] [handle_mm_fault+249/272] [do_page_fault+364/1277]
Jul 27 10:58:07 ------ kernel: Call Trace:    [<c012d87b>] [<c0122c4f>]
[<c01234e9>] [<c011015c>] [<c010c793>]
Jul 27 10:58:07 ------ kernel:   [<c013343d>] [<c010fff0>] [<c0107510>]
Jul 27 10:58:07 ------ kernel: Code: 0f 0b d9 00 13 4d 22 c0 8b 53 04 89
dd 8b 03 89 50 04 89 02


>>EIP; c012d45c <rmqueue+8c/250>   <=====

>>ebx; c10f2cd4 <_end+e1969c/858ea28>
>>esi; c0254e74 <contig_page_data+14/340>
>>ebp; c0254e60 <contig_page_data+0/340>
>>esp; c4da3e60 <_end+4aca828/858ea28>

Trace; c012d87b <__alloc_pages+4b/190>
Trace; c0122c4f <do_wp_page+9f/230>
Trace; c01234e9 <handle_mm_fault+f9/110>
Trace; c011015c <do_page_fault+16c/4fd>
Trace; c010c793 <old_mmap+103/120>
Trace; c013343d <filp_close+4d/80>
Trace; c010fff0 <do_page_fault+0/4fd>
Trace; c0107510 <error_code+34/3c>

Code;  c012d45c <rmqueue+8c/250>
00000000 <_EIP>:
Code;  c012d45c <rmqueue+8c/250>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012d45e <rmqueue+8e/250>
   2:   d9 00                     flds   (%eax)
Code;  c012d460 <rmqueue+90/250>
   4:   13 4d 22                  adc    0x22(%ebp),%ecx
Code;  c012d463 <rmqueue+93/250>
   7:   c0 8b 53 04 89 dd 8b      rorb   $0x8b,0xdd890453(%ebx)
Code;  c012d46a <rmqueue+9a/250>
   e:   03 89 50 04 89 02         add    0x2890450(%ecx),%ecx

Jul 27 10:58:58 ------ kernel:  kernel BUG at page_alloc.c:217!
Jul 27 10:58:58 ------ kernel: invalid operand: 0000
Jul 27 10:58:58 ------ kernel: CPU:    0
Jul 27 10:58:58 ------ kernel: EIP:    0010:[rmqueue+140/592]   
Tainted: P
Jul 27 10:58:58 ------ kernel: EIP:    0010:[<c012d45c>]    Tainted: P
Jul 27 10:58:58 ------ kernel: EFLAGS: 00010002
Jul 27 10:58:58 ------ kernel: eax: 00001000   ebx: c10f2cd4   ecx:
00000000   edx: 0000584a
Jul 27 10:58:58 ------ kernel: esi: c0254e74   edi: 00000000   ebp:
c0254e60   esp: c4da3e60
Jul 27 10:58:58 ------ kernel: ds: 0018   es: 0018   ss: 0018
Jul 27 10:58:58 ------ kernel: Process ps (pid: 27153,
stackpage=c4da3000)
Jul 27 10:58:58 ------ kernel: Stack: 00000282 c10f2cd4 c1017bf4
00000613 00000613 00000286 00000000 c0254e60
Jul 27 10:58:58 ------ kernel:        c0255098 00000201 062d3025
00000000 c012d87b c6b0c5c0 c0254f10 c0255090
Jul 27 10:58:58 ------ kernel:        000001d2 c486355c 00000000
c110fc60 062d3025 c486355c c0122c4f c110fc60
Jul 27 10:58:58 ------ kernel: Call Trace:    [__alloc_pages+75/400]
[do_wp_page+159/560] [handle_mm_fault+249/272] [do_page_fault+364/1277]
Jul 27 10:58:58 ------ kernel: Call Trace:    [<c012d87b>] [<c0122c4f>]
[<c01234e9>] [<c011015c>] [<c010c793>]
Jul 27 10:58:58 ------ kernel:   [<c013343d>] [<c010fff0>] [<c0107510>]
Jul 27 10:58:58 ------ kernel: Code: 0f 0b d9 00 13 4d 22 c0 8b 53 04 89
dd 8b 03 89 50 04 89 02


>>EIP; c012d45c <rmqueue+8c/250>   <=====

>>ebx; c10f2cd4 <_end+e1969c/858ea28>
>>esi; c0254e74 <contig_page_data+14/340>
>>ebp; c0254e60 <contig_page_data+0/340>
>>esp; c4da3e60 <_end+4aca828/858ea28>

Trace; c012d87b <__alloc_pages+4b/190>
Trace; c0122c4f <do_wp_page+9f/230>
Trace; c01234e9 <handle_mm_fault+f9/110>
Trace; c011015c <do_page_fault+16c/4fd>
Trace; c010c793 <old_mmap+103/120>
Trace; c013343d <filp_close+4d/80>
Trace; c010fff0 <do_page_fault+0/4fd>
Trace; c0107510 <error_code+34/3c>

Code;  c012d45c <rmqueue+8c/250>
00000000 <_EIP>:
Code;  c012d45c <rmqueue+8c/250>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012d45e <rmqueue+8e/250>
   2:   d9 00                     flds   (%eax)
Code;  c012d460 <rmqueue+90/250>
   4:   13 4d 22                  adc    0x22(%ebp),%ecx
Code;  c012d463 <rmqueue+93/250>
   7:   c0 8b 53 04 89 dd 8b      rorb   $0x8b,0xdd890453(%ebx)
Code;  c012d46a <rmqueue+9a/250>
   e:   03 89 50 04 89 02         add    0x2890450(%ecx),%ecx

Jul 27 10:58:58 ------ kernel:  kernel BUG at page_alloc.c:217!
Jul 27 10:58:58 ------ kernel: invalid operand: 0000
Jul 27 10:58:58 ------ kernel: CPU:    0
Jul 27 10:58:58 ------ kernel: EIP:    0010:[rmqueue+140/592]   
Tainted: P
Jul 27 10:58:58 ------ kernel: EIP:    0010:[<c012d45c>]    Tainted: P
Jul 27 10:58:58 ------ kernel: EFLAGS: 00010002
Jul 27 10:58:58 ------ kernel: eax: 00001000   ebx: c10f2cd4   ecx:
00000000   edx: 0000584a
Jul 27 10:58:59 ------ kernel: esi: c0254e74   edi: 00000000   ebp:
c0254e60   esp: c4da3c24
Jul 27 10:58:59 ------ kernel: ds: 0018   es: 0018   ss: 0018
Jul 27 10:58:59 ------ kernel: Process ps (pid: 27153,
stackpage=c4da3000)
Jul 27 10:58:59 ------ kernel: Stack: 4a494847 c10f2cd4 5251504f
56555453 c7ffa400 00000286 00000000 c0254e60
Jul 27 10:58:59 ------ kernel:        c0255098 00000201 c11bbc00
00000000 c012d87b c7ffa400 c0254f10 c0255090
Jul 27 10:58:59 ------ kernel:        000001d2 c0132355 000004a4
00000000 c11bbc00 00000040 c0128570 c5190d24
Jul 27 10:58:59 ------ kernel: Call Trace:    [__alloc_pages+75/400]
[vfs_statfs+101/112] [generic_file_write+896/1888]
[do_acct_process+595/624]
Warning (Oops_read): Code line not seen, dumping what data is available

>>EIP; c012d45c <rmqueue+8c/250>   <=====

>>ebx; c10f2cd4 <_end+e1969c/858ea28>
>>esi; c0254e74 <contig_page_data+14/340>
>>ebp; c0254e60 <contig_page_data+0/340>
>>esp; c4da3c24 <_end+4aca5ec/858ea28>


3 warnings issued.  Results may not be reliable.

----------------------------------------------------------------------

scripts/ver_linux:
Linux ------ 2.4.20 #2 Wed Apr 16 08:29:03 EEST 2003 i686 unknown

Gnu C                  3.2.2
Gnu make               3.79.1
util-linux             2.10s
mount                  2.10r
modutils               2.4.20
e2fsprogs              1.30
reiserfsprogs          3.x.0f
PPP                    2.4.1
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Linux C++ Library      5.0.2
Procps                 3.0.3
Net-tools              1.57
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         nfs lockd sunrpc ipsec ipt_TCPMSS md

----------------------------------------------------------------------

cpuinfo

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 3
model name      : Pentium II (Klamath)
stepping        : 4
cpu MHz         : 233.865
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov mmx
bogomips        : 466.94

----------------------------------------------------------------------

modules

nfs                    71896   4 (autoclean)
lockd                  51056   1 (autoclean) [nfs]
sunrpc                 66204   1 (autoclean) [nfs lockd]
ipsec                 257376   2
ipt_TCPMSS              2392   3 (autoclean)
md                     60064   0 (unused)

----------------------------------------------------------------------

ioports & iomem

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
0300-030f : 3c509
03c0-03df : vga+
03f6-03f6 : ide0
0cf8-0cff : PCI conf1
5f00-5f1f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
6100-613f : Intel Corp. 82371AB/EB/MB PIIX4 ACPI
b000-bfff : PCI Bus #01
d800-d8ff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+ (#2)
  d800-d8ff : 8139too
da00-da3f : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  da00-da3f : eepro100
dc00-dcff : Realtek Semiconductor Co., Ltd. RTL-8139/8139C/8139C+
  dc00-dcff : 8139too
de00-de1f : Intel Corp. 82371AB/EB/MB PIIX4 USB
ffa0-ffaf : Intel Corp. 82371AB/EB/MB PIIX4 IDE
  ffa0-ffa7 : ide0
  ffa8-ffaf : ide1
00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000c8000-000c97ff : Extension ROM
000f0000-000fffff : System ROM
00100000-07ffffff : System RAM
  00100000-0021ee7a : Kernel code
  0021ee7b-002637df : Kernel data
e4c00000-e4cfffff : PCI Bus #01
e8000000-ebffffff : Intel Corp. 440LX/EX - 82443LX/EX Host bridge
ed000000-edffffff : Matrox Graphics, Inc. MGA 2164W [Millennium II]
eee00000-eeefffff : PCI Bus #01
ef000000-ef7fffff : Matrox Graphics, Inc. MGA 2164W [Millennium II]
effc0000-effdffff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
efffa000-efffafff : Intel Corp. 82557/8/9 [Ethernet Pro 100]
  efffa000-efffafff : eepro100
efffbe00-efffbeff : Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (#2)
  efffbe00-efffbeff : 8139too
efffbf00-efffbfff : Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+
  efffbf00-efffbfff : 8139too
efffc000-efffffff : Matrox Graphics, Inc. MGA 2164W [Millennium II]
ffff0000-ffffffff : reserved

----------------------------------------------------------------------

lspci

00:00.0 Host bridge: Intel Corporation 440LX/EX - 82443LX/EX Host bridge
(rev 03)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at e8000000 (32-bit, prefetchable) [size=64M]
        Capabilities: [a0] AGP version 1.0
                Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
                Command: RQ=0 SBA- AGP- 64bit- FW- Rate=<none>

00:01.0 PCI bridge: Intel Corporation 440LX/EX - 82443LX/EX AGP bridge
(rev 03) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000b000-0000bfff
        Memory behind bridge: eee00000-eeefffff
        Prefetchable memory behind bridge: e4c00000-e4cfffff
        BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: Intel Corporation 82371AB PIIX4 ISA (rev 01)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:07.1 IDE interface: Intel Corporation 82371AB PIIX4 IDE (rev 01)
(prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at ffa0 [size=16]

00:07.2 USB Controller: Intel Corporation 82371AB PIIX4 USB (rev 01)
(prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin D routed to IRQ 9
        Region 4: I/O ports at de00 [size=32]

00:07.3 Bridge: Intel Corporation 82371AB PIIX4 ACPI (rev 01)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

00:0e.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2164W
[Millennium II] (prog-if 00 [VGA])
        Subsystem: Matrox Graphics, Inc.: Unknown device 2100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at ed000000 (32-bit, prefetchable) [size=16M]
        Region 1: Memory at efffc000 (32-bit, non-prefetchable)
[size=16K]
        Region 2: Memory at ef000000 (32-bit, non-prefetchable)
[size=8M]
        Expansion ROM at effe0000 [disabled] [size=64K]

00:0f.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139
(rev 10)
        Subsystem: Allied Telesyn International: Unknown device 2503
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 12
        Region 0: I/O ports at dc00 [size=256]
        Region 1: Memory at efffbf00 (32-bit, non-prefetchable)
[size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+

00:10.0 Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100]
(rev 0c)
        Subsystem: Intel Corporation: Unknown device 0040
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2000ns min, 14000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 7
        Region 0: Memory at efffa000 (32-bit, non-prefetchable)
[size=4K]
        Region 1: I/O ports at da00 [size=64]
        Region 2: Memory at effc0000 (32-bit, non-prefetchable)
[size=128K]
        Expansion ROM at effb0000 [disabled] [size=64K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-

00:12.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139
(rev 10)
        Subsystem: Allied Telesyn International: Unknown device 2503
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (8000ns min, 16000ns max)
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at d800 [size=256]
        Region 1: Memory at efffbe00 (32-bit, non-prefetchable)
[size=256]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME+
