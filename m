Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313288AbSC1XLN>; Thu, 28 Mar 2002 18:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313289AbSC1XLE>; Thu, 28 Mar 2002 18:11:04 -0500
Received: from nat-wohnheime.rz.uni-karlsruhe.de ([193.196.41.250]:52662 "EHLO
	t28a301.tennessee.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id <S313288AbSC1XKp> convert rfc822-to-8bit; Thu, 28 Mar 2002 18:10:45 -0500
Date: Fri, 29 Mar 2002 00:10:39 +0100 (CET)
From: Stephan Fuhrmann <fury@t28a301.tennessee.uni-karlsruhe.de>
Reply-To: Stephan.Fuhrmann@stud.uni-karlsruhe.de
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: kernel v2.4.18, faulty virtual mem code?
Message-ID: <Pine.LNX.4.40.0203290003220.2835-100000@t28a301.tennessee.uni-karlsruhe.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I got a small problem while running a game under X11.
It looks to me that there is a problem in the virtual
memory code.
My machine doesn't crash, it just dumps a kernel stack
to the console.

This behaviour is not really critical, but it is not nice!

kernel version is:

----------------------------------------------------------------
Linux version 2.4.18 (root@t28a301) (gcc version 2.95.3 20010315
(release)) #1 Sam Mär 16 12:07:18 CET 2002
----------------------------------------------------------------

ksymoops output:

----------------------------------------------------------------
ksymoops 0.7c on i686 2.4.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m /boot/System.map (specified)

Reading Oops report from the terminal
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012d058>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: c125535c   ebx: c1190e00   ecx: c1190e00   edx: c0242f20
esi: c1190e00   edi: 00000000   ebp: 000001ff   esp: c142ff28
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=c142f000)
Stack: cb4f7f40 c1190e00 00000018 000001ff c1190e00 000001d0 cb4f7f40 c1190e00
       c012c962 c012d74b c012c99b 00000020 000001d0 00000020 00000006 00000006
       c142e000 00001d1f 000001d0 c0243048 c012cba6 00000006 00000004 00000006
Call Trace: [<c012c962>] [<c012d74b>] [<c012c99b>] [<c012cba6>] [<c012cc0c>]
   [<c012cca3>] [<c012cd06>] [<c012ce1d>] [<c0105708>]
Code: 0f 0b 89 d8 2b 05 2c cd 29 c0 c1 f8 06 3b 05 20 cd 29 c0 72

>>EIP; c012d058 <__free_pages_ok+28/200>   <=====
Trace; c012c962 <shrink_cache+1d2/2f0>
Trace; c012d74b <__free_pages+1b/20>
Trace; c012c99b <shrink_cache+20b/2f0>
Trace; c012cba6 <shrink_caches+56/80>
Trace; c012cc0c <try_to_free_pages+3c/60>
Trace; c012cca3 <kswapd_balance_pgdat+43/90>
Trace; c012cd06 <kswapd_balance+16/30>
Trace; c012ce1d <kswapd+9d/c0>
Trace; c0105708 <kernel_thread+28/40>
Code;  c012d058 <__free_pages_ok+28/200>
00000000 <_EIP>:
Code;  c012d058 <__free_pages_ok+28/200>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012d05a <__free_pages_ok+2a/200>
   2:   89 d8                     mov    %ebx,%eax
Code;  c012d05c <__free_pages_ok+2c/200>
   4:   2b 05 2c cd 29 c0         sub    0xc029cd2c,%eax
Code;  c012d062 <__free_pages_ok+32/200>
   a:   c1 f8 06                  sar    $0x6,%eax
Code;  c012d065 <__free_pages_ok+35/200>
   d:   3b 05 20 cd 29 c0         cmp    0xc029cd20,%eax
Code;  c012d06b <__free_pages_ok+3b/200>
  13:   72 00                     jb     15 <_EIP+0x15> c012d06d <__free_pages_ok+3d/200>

 invalid operand: 0000
CPU:    0
EIP:    0010:[<c012d058>]    Tainted: P
EFLAGS: 00010286
eax: c1160c9c   ebx: c1167540   ecx: c1167540   edx: cd759430
esi: c1167540   edi: 00000000   ebp: 00000200   esp: cfcc7dcc
ds: 0018   es: 0018   ss: 0018
Process game.x86 (pid: 30557, stackpage=cfcc7000)
Stack: cfb2b1c0 c1167540 0000001f 00000200 c1167540 000001d2 cfb2b1c0 c1167540
       c012c962 c012d74b c012c99b 00000020 000001d2 00000020 00000006 00000006
       cfcc6000 00001d84 000001d2 c0243048 c012cba6 00000006 00000004 00000006
Call Trace: [<c012c962>] [<c012d74b>] [<c012c99b>] [<c012cba6>] [<c012cc0c>]
   [<c012d44e>] [<c012d67c>] [<c0207f06>] [<c012d3f6>] [<c0124a60>] [<c0124aff>]
   [<c0124c32>] [<c01144f3>] [<c0114390>] [<c010bc9d>] [<c0106f6c>]
Code: 0f 0b 89 d8 2b 05 2c cd 29 c0 c1 f8 06 3b 05 20 cd 29 c0 72

>>EIP; c012d058 <__free_pages_ok+28/200>   <=====
Trace; c012c962 <shrink_cache+1d2/2f0>
Trace; c012d74b <__free_pages+1b/20>
Trace; c012c99b <shrink_cache+20b/2f0>
Trace; c012cba6 <shrink_caches+56/80>
Trace; c012cc0c <try_to_free_pages+3c/60>
Trace; c012d44e <balance_classzone+4e/170>
Trace; c012d67c <__alloc_pages+10c/170>
Trace; c0207f06 <mmx_clear_page+26/30>
Trace; c012d3f6 <_alloc_pages+16/20>
Trace; c0124a60 <do_anonymous_page+30/a0>
Trace; c0124aff <do_no_page+2f/110>
Trace; c0124c32 <handle_mm_fault+52/b0>
Trace; c01144f3 <do_page_fault+163/494>
Trace; c0114390 <do_page_fault+0/494>
Trace; c010bc9d <old_mmap+ed/130>
Trace; c0106f6c <error_code+34/3c>
Code;  c012d058 <__free_pages_ok+28/200>
00000000 <_EIP>:
Code;  c012d058 <__free_pages_ok+28/200>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012d05a <__free_pages_ok+2a/200>
   2:   89 d8                     mov    %ebx,%eax
Code;  c012d05c <__free_pages_ok+2c/200>
   4:   2b 05 2c cd 29 c0         sub    0xc029cd2c,%eax
Code;  c012d062 <__free_pages_ok+32/200>
   a:   c1 f8 06                  sar    $0x6,%eax
Code;  c012d065 <__free_pages_ok+35/200>
   d:   3b 05 20 cd 29 c0         cmp    0xc029cd20,%eax
Code;  c012d06b <__free_pages_ok+3b/200>
  13:   72 00                     jb     15 <_EIP+0x15> c012d06d <__free_pages_ok+3d/200>

----------------------------------------------------------------

cpuinfo:

----------------------------------------------------------------
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1200.057
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca
cmov pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2392.06
----------------------------------------------------------------


Best regards,

 S. Fuhrmann
--
S. Fuhrmann


