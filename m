Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135789AbRD3TNe>; Mon, 30 Apr 2001 15:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135818AbRD3TNZ>; Mon, 30 Apr 2001 15:13:25 -0400
Received: from wb2-a.mail.utexas.edu ([128.83.126.136]:32784 "HELO
	mail.utexas.edu") by vger.kernel.org with SMTP id <S135789AbRD3TNE>;
	Mon, 30 Apr 2001 15:13:04 -0400
Message-ID: <3AED10B2.7B9DFAB6@mail.utexas.edu>
Date: Mon, 30 Apr 2001 13:13:54 +0600
From: "Bobby D. Bryant" <bdbryant@mail.utexas.edu>
Organization: (I do not speak for) The University of Texas at Austin (nor they for 
 me).
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en,fr,de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: PROBLEM: Athlon/VIA/2.4.4 kernel BUG at page_alloc.c:73!
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apr 30 12:51:00 pollux kernel: kernel BUG at page_alloc.c:73!
Apr 30 12:51:00 pollux kernel: invalid operand: 0000

This begins a cascade of similar messages, after which almost anything I
try to do results in a segfault.

The system is an Athlon on an Epox 8KTA3, with BIOS flashed up to
17-Apr-2001.

The kernel is 2.4.4, compiled as a PIII (since I still can't get an
Athlon kernel to boot.)

I'm subscribed now, so I'll see any requests for more information.

=====
% ksymoops oops.txt  # File contains only the first in the cascade.
ksymoops 2.4.0 on i686 2.4.4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.4/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol
__VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring
ksyms_base entry
Apr 30 12:51:00 pollux kernel: kernel BUG at page_alloc.c:73!
Apr 30 12:51:00 pollux kernel: invalid operand: 0000
Apr 30 12:51:00 pollux kernel: CPU:    0
Apr 30 12:51:00 pollux kernel: EIP:    0010:[__free_pages_ok+34/776]
Apr 30 12:51:00 pollux kernel: EIP:    0010:[<c012a462>]
Using defaults from ksymoops -t elf32-i386 -a i386
Apr 30 12:51:00 pollux kernel: EFLAGS: 00010292
Apr 30 12:51:00 pollux kernel: eax: 0000001f   ebx: c1ca2960   ecx:
00000000   edx: fffffff6
Apr 30 12:51:00 pollux kernel: esi: 00000002   edi: 0002e000   ebp:
00000000   esp: d9423f08
Apr 30 12:51:00 pollux kernel: ds: 0018   es: 0018   ss: 0018
Apr 30 12:51:00 pollux kernel: Process run-parts (pid: 1064,
stackpage=d9423000)
Apr 30 12:51:00 pollux kernel: Stack: c01d4a8b c01d4b80 00000049
2f914025 00000002 0002e000 00000000 c1044010
Apr 30 12:51:00 pollux kernel:        c0202d60 00000216 ffffffff
00016224 c012ad92 c011faaa ec70f660 efd40e20
Apr 30 12:51:00 pollux kernel:        4002e000 00003000 c1ca2960
2f914025 c1fbe0bc 00000000 00031000 c5221400
Apr 30 12:51:00 pollux kernel: Call Trace: [__free_pages+26/28]
[zap_page_range+466/620] [exit_mmap+181/284] [mmput+38/68]
[do_exit+161/552] [sys_exit+14/16] [system_call+51/56]
Apr 30 12:51:00 pollux kernel: Call Trace: [<c012ad92>] [<c011faaa>]
[<c0122185>] [<c0112d76>] [<c01169cd>] [<c0116b7e>] [<c0106ae7>]
Apr 30 12:51:00 pollux kernel: Code: 0f 0b 83 c4 0c 83 7b 08 00 74 16 6a
4b 68 80 4b 1d c0 68 8b

>>EIP; c012a462 <__free_pages_ok+22/308>   <=====
Trace; c012ad92 <__free_pages+1a/1c>
Trace; c011faaa <zap_page_range+1d2/26c>
Trace; c0122185 <exit_mmap+b5/11c>
Trace; c0112d76 <mmput+26/44>
Trace; c01169cd <do_exit+a1/228>
Trace; c0116b7e <sys_exit+e/10>
Trace; c0106ae7 <system_call+33/38>
Code;  c012a462 <__free_pages_ok+22/308>
00000000 <_EIP>:
Code;  c012a462 <__free_pages_ok+22/308>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012a464 <__free_pages_ok+24/308>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c012a467 <__free_pages_ok+27/308>
   5:   83 7b 08 00               cmpl   $0x0,0x8(%ebx)
Code;  c012a46b <__free_pages_ok+2b/308>
   9:   74 16                     je     21 <_EIP+0x21> c012a483
<__free_pages_ok+43/308>
Code;  c012a46d <__free_pages_ok+2d/308>
   b:   6a 4b                     push   $0x4b
Code;  c012a46f <__free_pages_ok+2f/308>
   d:   68 80 4b 1d c0            push   $0xc01d4b80
Code;  c012a474 <__free_pages_ok+34/308>
  12:   68 8b 00 00 00            push   $0x8b


2 warnings issued.  Results may not be reliable.

=====
% cat /proc/version
Linux version 2.4.4 (root@pollux.dioscuri) (gcc version egcs-2.91.66
19990314/Linux (egcs-1.1.2 release)) #4 Sat Apr 28 19:54:44 GMT-6 2001

=====
% cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1202.738
cache size      : 256 KB
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
bogomips        : 2398.61

=====
%  cat /proc/pci
PCI devices found:
  Bus  0, device   0, function  0:
    Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev
3).
      Master Capable.  Latency=8.
      Prefetchable 32 bit memory at 0xd0000000 [0xd3ffffff].
  Bus  0, device   1, function  0:
    PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
(rev 0).
      Master Capable.  No bursts.  Min Gnt=12.
  Bus  0, device   7, function  0:
    ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 64).
  Bus  0, device   7, function  1:
    IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 6).
      Master Capable.  Latency=32.
      I/O at 0xc000 [0xc00f].
  Bus  0, device   7, function  4:
    Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
64).
  Bus  0, device  10, function  0:
    Unknown mass storage controller: Promise Technology, Inc. 20267 (rev
2).
      IRQ 11.
      Master Capable.  Latency=32.
      I/O at 0xd400 [0xd407].
      I/O at 0xd800 [0xd803].
      I/O at 0xcc00 [0xcc07].
      I/O at 0xd000 [0xd003].
      I/O at 0xdc00 [0xdc3f].
      Non-prefetchable 32 bit memory at 0xda000000 [0xda01ffff].
  Bus  0, device  11, function  0:
    Serial controller: US Robotics/3Com 56K FaxModem Model 5610 (rev 1).

      IRQ 5.
      I/O at 0xe000 [0xe007].
  Bus  0, device  12, function  0:
    Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev
16).
      IRQ 11.
      Master Capable.  Latency=32.  Min Gnt=32.Max Lat=64.
      I/O at 0xe400 [0xe4ff].
      Non-prefetchable 32 bit memory at 0xda020000 [0xda0200ff].
  Bus  1, device   0, function  0:
    VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev
130).
      IRQ 10.
      Master Capable.  Latency=64.  Min Gnt=16.Max Lat=32.
      Prefetchable 32 bit memory at 0xd4000000 [0xd5ffffff].
      Non-prefetchable 32 bit memory at 0xd6000000 [0xd6003fff].
      Non-prefetchable 32 bit memory at 0xd7000000 [0xd77fffff].

=====

Bobby Bryant
Austin, Texas


