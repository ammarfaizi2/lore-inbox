Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267200AbTGOLSX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 07:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267201AbTGOLSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 07:18:23 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:2478 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S267200AbTGOLSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 07:18:01 -0400
X-Sender-Authentification: net64
Date: Tue, 15 Jul 2003 13:32:44 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Bug Report: 2.4.22-pre5: BUG in page_alloc
Message-Id: <20030715133244.2d244ace.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

here comes...

ksymoops 2.4.8 on i686 2.4.22-pre5.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22-pre5/ (default)
     -m /boot/System.map-2.4.22-pre5 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Jul 15 11:19:24 admin kernel: kernel BUG at page_alloc.c:102!
Jul 15 11:19:24 admin kernel: invalid operand: 0000
Jul 15 11:19:24 admin kernel: CPU:    1
Jul 15 11:19:24 admin kernel: EIP:    0010:[__free_pages_ok+82/720]    Not
tainted
Jul 15 11:19:24 admin kernel: EIP:    0010:[<c0139e02>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jul 15 11:19:24 admin kernel: EFLAGS: 00010282
Jul 15 11:19:24 admin kernel: eax: f0413d64   ebx: c29e0440   ecx: c29e045c  
edx: c243d84c
Jul 15 11:19:24 admin kernel: esi: c29e0440   edi: 00000000   ebp: c02e2b08  
esp: c345df0c
Jul 15 11:19:24 admin kernel: ds: 0018   es: 0018   ss: 0018
Jul 15 11:19:24 admin kernel: Process kswapd (pid: 5, stackpage=c345d000)
Jul 15 11:19:24 admin kernel: Stack: 00000282 00000003 f547f660 f547f660
f547f660 c29e0440 c0147ccb f547f660 
Jul 15 11:19:24 admin kernel:        f0413d64 c29e0440 0001ad4c c02e2b08
c0139141 c29e0440 000001d0 00000200
Jul 15 11:19:24 admin kernel:        000001d0 0000001e 00000020 000001d0
00000020 00000006 c0139343 00000006
Jul 15 11:19:24 admin kernel: Call Trace:    [try_to_free_buffers+235/368]
[shrink_cache+801/944] [shrink_caches+99/160] [try_to_free_pages_zone+62/96]
[kswapd_balance_pgdat+76/176]
Jul 15 11:19:24 admin kernel: Call Trace:    [<c0147ccb>] [<c0139141>]
[<c0139343>] [<c01393be>] [<c01394cc>]
Jul 15 11:19:24 admin kernel:   [<c0139558>] [<c0139688>] [<c01395f0>]
[<c0105000>] [<c010592e>] [<c01395f0>]
Jul 15 11:19:24 admin kernel: Code: 0f 0b 66 00 8e b8 2a c0 8b 2d 90 e5 36 c0
89 d8 29 e8 c1 f8


>>EIP; c0139e02 <__free_pages_ok+52/2d0>   <=====

>>eax; f0413d64 <_end+300761a4/3853c4a0>
>>ebx; c29e0440 <_end+2642880/3853c4a0>
>>ecx; c29e045c <_end+264289c/3853c4a0>
>>edx; c243d84c <_end+209fc8c/3853c4a0>
>>esi; c29e0440 <_end+2642880/3853c4a0>
>>ebp; c02e2b08 <contig_page_data+168/340>
>>esp; c345df0c <_end+30c034c/3853c4a0>

Trace; c0147ccb <try_to_free_buffers+eb/170>
Trace; c0139141 <shrink_cache+321/3b0>
Trace; c0139343 <shrink_caches+63/a0>
Trace; c01393be <try_to_free_pages_zone+3e/60>
Trace; c01394cc <kswapd_balance_pgdat+4c/b0>
Trace; c0139558 <kswapd_balance+28/40>
Trace; c0139688 <kswapd+98/c0>
Trace; c01395f0 <kswapd+0/c0>
Trace; c0105000 <_stext+0/0>
Trace; c010592e <arch_kernel_thread+2e/40>
Trace; c01395f0 <kswapd+0/c0>

Code;  c0139e02 <__free_pages_ok+52/2d0>
00000000 <_EIP>:
Code;  c0139e02 <__free_pages_ok+52/2d0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0139e04 <__free_pages_ok+54/2d0>
   2:   66                        data16
Code;  c0139e05 <__free_pages_ok+55/2d0>
   3:   00 8e b8 2a c0 8b         add    %cl,0x8bc02ab8(%esi)
Code;  c0139e0b <__free_pages_ok+5b/2d0>
   9:   2d 90 e5 36 c0            sub    $0xc036e590,%eax
Code;  c0139e10 <__free_pages_ok+60/2d0>
   e:   89 d8                     mov    %ebx,%eax
Code;  c0139e12 <__free_pages_ok+62/2d0>
  10:   29 e8                     sub    %ebp,%eax
Code;  c0139e14 <__free_pages_ok+64/2d0>
  12:   c1 f8 00                  sar    $0x0,%eax

Jul 15 12:34:09 admin kernel: kernel BUG at page_alloc.c:102!
Jul 15 12:34:09 admin kernel: invalid operand: 0000
Jul 15 12:34:09 admin kernel: CPU:    0
Jul 15 12:34:09 admin kernel: EIP:    0010:[__free_pages_ok+82/720]    Not
tainted
Jul 15 12:34:09 admin kernel: EIP:    0010:[<c0139e02>]    Not tainted
Jul 15 12:34:09 admin kernel: EFLAGS: 00010282
Jul 15 12:34:09 admin kernel: eax: f0413d64   ebx: c29e0440   ecx: c29e0440  
edx: 00000000
Jul 15 12:34:09 admin kernel: esi: c29e0440   edi: 00000000   ebp: 00001d87  
esp: d430fed8
Jul 15 12:34:09 admin kernel: ds: 0018   es: 0018   ss: 0018
Jul 15 12:34:09 admin kernel: Process tar (pid: 20492, stackpage=d430f000)
Jul 15 12:34:09 admin kernel: Stack: d430ff74 c014024c c29e0440 00000000
c0131db8 c0225e90 00000000 00001600
Jul 15 12:34:09 admin kernel:        00001000 c29e0440 f0413d64 00001d87
c013176a d430ff74 c29e0440 00000000
Jul 15 12:34:09 admin kernel:        00001000 00001000 00000001 00000000
00000000 f0413ca0 c0131cc0 d430ff74
Jul 15 12:34:09 admin kernel: Call Trace:    [kmap_high+76/128]
[file_read_actor+248/272] [st_sleep_done+0/256] [do_generic_file_read+538/1136]
[file_read_actor+0/272]
Jul 15 12:34:09 admin kernel: Call Trace:    [<c014024c>] [<c0131db8>]
[<c0225e90>] [<c013176a>] [<c0131cc0>]
Jul 15 12:34:09 admin kernel:   [<c0131f6c>] [<c0131cc0>] [<c014291b>]
[<c010782f>]
Jul 15 12:34:09 admin kernel: Code: 0f 0b 66 00 8e b8 2a c0 8b 2d 90 e5 36 c0
89 d8 29 e8 c1 f8


>>EIP; c0139e02 <__free_pages_ok+52/2d0>   <=====

>>eax; f0413d64 <_end+300761a4/3853c4a0>
>>ebx; c29e0440 <_end+2642880/3853c4a0>
>>ecx; c29e0440 <_end+2642880/3853c4a0>
>>esi; c29e0440 <_end+2642880/3853c4a0>
>>esp; d430fed8 <_end+13f72318/3853c4a0>

Trace; c014024c <kmap_high+4c/80>
Trace; c0131db8 <file_read_actor+f8/110>
Trace; c0225e90 <st_sleep_done+0/100>
Trace; c013176a <do_generic_file_read+21a/470>
Trace; c0131cc0 <file_read_actor+0/110>
Trace; c0131f6c <generic_file_read+19c/1b0>
Trace; c0131cc0 <file_read_actor+0/110>
Trace; c014291b <sys_read+9b/180>
Trace; c010782f <system_call+33/38>

Code;  c0139e02 <__free_pages_ok+52/2d0>
00000000 <_EIP>:
Code;  c0139e02 <__free_pages_ok+52/2d0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0139e04 <__free_pages_ok+54/2d0>
   2:   66                        data16
Code;  c0139e05 <__free_pages_ok+55/2d0>
   3:   00 8e b8 2a c0 8b         add    %cl,0x8bc02ab8(%esi)
Code;  c0139e0b <__free_pages_ok+5b/2d0>
   9:   2d 90 e5 36 c0            sub    $0xc036e590,%eax
Code;  c0139e10 <__free_pages_ok+60/2d0>
   e:   89 d8                     mov    %ebx,%eax
Code;  c0139e12 <__free_pages_ok+62/2d0>
  10:   29 e8                     sub    %ebp,%eax
Code;  c0139e14 <__free_pages_ok+64/2d0>
  12:   c1 f8 00                  sar    $0x0,%eax


1 warning issued.  Results may not be reliable.


# uname -r
2.4.22-pre5

# cat /proc/cpuinfo 
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 11
model name      : Intel(R) Pentium(R) III CPU family      1400MHz
stepping        : 1
cpu MHz         : 1400.118
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 mmx fxsr sse
bogomips        : 2791.83

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 6
model           : 11
model name      : Intel(R) Pentium(R) III CPU family      1400MHz
stepping        : 1
cpu MHz         : 1400.118
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 mmx fxsr sse
bogomips        : 2798.38


# cat /proc/meminfo 
        total:    used:    free:  shared: buffers:  cached:
Mem:  3180212224 3142021120 38191104        0 281440256 2462392320
Swap: 2154979328 71847936 2083131392
MemTotal:      3105676 kB
MemFree:         37296 kB
MemShared:           0 kB
Buffers:        274844 kB
Cached:        2375540 kB
SwapCached:      29140 kB
Active:         252228 kB
Inactive:      2502676 kB
HighTotal:     2228204 kB
HighFree:        34972 kB
LowTotal:       877472 kB
LowFree:          2324 kB
SwapTotal:     2104472 kB
SwapFree:      2034308 kB


Problem showed up during tar from disk (3ware RAID) to tape (aic-SDLT).
Box is completely stable under 2.4.22-pre2, but my long-term bug-report
regarding verification errors during tar verify cycle still holds.

Any further information needed? Just tell me...

Regards,
Stephan
