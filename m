Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265578AbSKTCmS>; Tue, 19 Nov 2002 21:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265587AbSKTCmS>; Tue, 19 Nov 2002 21:42:18 -0500
Received: from ns2.jaj.com ([66.93.21.106]:57292 "EHLO disaster.jaj.com")
	by vger.kernel.org with ESMTP id <S265578AbSKTCmQ>;
	Tue, 19 Nov 2002 21:42:16 -0500
Date: Tue, 19 Nov 2002 21:49:21 -0500
From: Phil Edwards <phil@jaj.com>
To: linux-kernel@vger.kernel.org
Subject: OOPS: invalid operand in __free_pages_ok
Message-ID: <20021119214921.A23241@disaster.jaj.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My first OOPS report.  Please bear with me.  I'm not a kernel expert.

Over the last two days, this has happened four times.  Three times it was
in kswapd, and seems to be recoverable (well, the machine didn't crash,
and I didn't notice until I examined the syslogs).  Once the process was
cvs, which then reported a segfault and died.

The system is a dual Athlon running the 2.4.19 kernel, and usually very
stable.  (Once a month or so it hangs on shutdown, kind of scary since
this is my primary machine.)

The most recent occasion was in kswapd, and the output from ksymoops is
below.  The tainted kernel comes from the nVidia driver.  (I know, I know,
but I don't really have a choice.)  I don't know what triggers the oops,
or I'd try to reproduce it in console mode before the X11 kicks in.


I don't know what other information would be helpful, and what would just
be noise.  Please ask, I'll hunt down whatever I can.


My ISP would kill me if I susbscribed to this list (mail traffic), so
please cc me on replies.

Much thanks,
Phil


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

kernel BUG at page_alloc.c:91!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0132c2d>]    Tainted: P 
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: c1379a7c   ebx: c134a870   ecx: c134a870   edx: c0259344
esi: 00000000   edi: 00000008   ebp: 000001ff   esp: c1625f18
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=c1625000)
Stack: ceae8740 c134a870 00000008 000001ff c013e3d5 c134a870 000001d0 00000008 
       000001ff c013c649 ceae8740 c134a870 c01323e2 c013347c c0132429 00000020 
       000001d0 00000020 00000006 c1624000 c1624000 00002fc8 000001d0 c02594d4 
Call Trace:    [<c013e3d5>] [<c013c649>] [<c01323e2>] [<c013347c>] [<c0132429>]
  [<c01326a6>] [<c013271c>] [<c01327b3>] [<c0132816>] [<c013292d>] [<c0107118>]
Code: 0f 0b 5b 00 73 72 22 c0 89 d8 2b 05 10 38 2e c0 69 c0 ab aa 


>>EIP; c0132c2d <__free_pages_ok+2d/280>   <=====

>>eax; c1379a7c <_end+104af84/20552568>
>>ebx; c134a870 <_end+101bd78/20552568>
>>ecx; c134a870 <_end+101bd78/20552568>
>>edx; c0259344 <inactive_list+0/8>
>>esp; c1625f18 <_end+12f7420/20552568>

Trace; c013e3d5 <try_to_free_buffers+c5/150>
Trace; c013c649 <try_to_release_page+49/50>
Trace; c01323e2 <shrink_cache+232/3b0>
Trace; c013347c <__free_pages+1c/20>
Trace; c0132429 <shrink_cache+279/3b0>
Trace; c01326a6 <shrink_caches+56/90>
Trace; c013271c <try_to_free_pages+3c/60>
Trace; c01327b3 <kswapd_balance_pgdat+43/90>
Trace; c0132816 <kswapd_balance+16/30>
Trace; c013292d <kswapd+9d/b8>
Trace; c0107118 <kernel_thread+28/40>

Code;  c0132c2d <__free_pages_ok+2d/280>
00000000 <_EIP>:
Code;  c0132c2d <__free_pages_ok+2d/280>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0132c2f <__free_pages_ok+2f/280>
   2:   5b                        pop    %ebx
Code;  c0132c30 <__free_pages_ok+30/280>
   3:   00 73 72                  add    %dh,0x72(%ebx)
Code;  c0132c33 <__free_pages_ok+33/280>
   6:   22 c0                     and    %al,%al
Code;  c0132c35 <__free_pages_ok+35/280>
   8:   89 d8                     mov    %ebx,%eax
Code;  c0132c37 <__free_pages_ok+37/280>
   a:   2b 05 10 38 2e c0         sub    0xc02e3810,%eax
Code;  c0132c3d <__free_pages_ok+3d/280>
  10:   69 c0 ab aa 00 00         imul   $0xaaab,%eax,%eax


1 warning issued.  Results may not be reliable.
