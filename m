Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267029AbTAJTfj>; Fri, 10 Jan 2003 14:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267030AbTAJTfj>; Fri, 10 Jan 2003 14:35:39 -0500
Received: from adsl-67-113-154-34.dsl.sntc01.pacbell.net ([67.113.154.34]:43506
	"EHLO postbox.aslab.com") by vger.kernel.org with ESMTP
	id <S267029AbTAJTfc>; Fri, 10 Jan 2003 14:35:32 -0500
Message-ID: <3E1F22C3.4050403@aslab.com>
Date: Fri, 10 Jan 2003 11:45:07 -0800
From: Michael Madore <mmadore@aslab.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.21-pre3-ac3 oops with himem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I received the following oops while running the Cerberus stress test on 
2.4.21-pre3-ac3.  The  hardware is an ASUS A7N8X  single AMD Athlon XP 
motherboard with the Nvidia nforce2 chipset.  The oops occurs as soon as 
the system has used all the RAM and tries to use swap.  The total amount 
of memory on the machine is 1GB, and himem is enabled.  If I turn off 
himem support the kernel starts to use swap without oopsing.  I can 
provide my kernel .config or more hardware details if that would be useful.

Mike

ksymoops 2.4.4 on i686 2.4.21-pre3-ac2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-pre3-ac2/ (default)
     -m /boot/System.map-2.4.21-pre3-ac2 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel NULL pointer dereference at virtual address 00000004
c01354e2
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c01354e2>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c197d960   ecx: f71da000   edx: f71da05c
esi: c197d960   edi: 00000000   ebp: 00003737   esp: f71dbdd0
ds: 0018   es: 0018   ss: 0018
Process cp (pid: 1690, stackpage=f71db000)
Stack: c01415f2 f7e84400 c197d960 000001d2 c013f67f 00000000 c197d960 
00000000
       c197d960 00000020 00003737 c0134ad7 00000004 f71da000 00000200 
000001d2
       c02fabe8 f71da000 00000000 00000000 00000000 00000020 000001d2 
00000006
Call Trace:    [<c01415f2>] [<c013f67f>] [<c0134ad7>] [<c0134c70>] 
[<c0134cec>]
  [<c01357d0>] [<c0135a8b>] [<c012d216>] [<c012d8f5>] [<c012dc5f>] 
[<c0150a9c>]
  [<c012e14a>] [<c012dfe0>] [<c013cf65>] [<c0108b33>]
Code: 89 58 04 89 03 89 53 04 89 59 5c 89 7b 0c ff 41 68 83 c4 1c

 >>EIP; c01354e2 <__free_pages_ok+282/2a0>   <=====
Trace; c01415f2 <try_to_free_buffers+d2/160>
Trace; c013f67f <try_to_release_page+2f/50>
Trace; c0134ad7 <shrink_cache+387/3b0>
Trace; c0134c70 <shrink_caches+50/90>
Trace; c0134cec <try_to_free_pages_zone+3c/60>
Trace; c01357d0 <balance_classzone+60/200>
Trace; c0135a8b <__alloc_pages+11b/170>
Trace; c012d216 <page_cache_read+76/d0>
Trace; c012d8f5 <generic_file_readahead+f5/130>
Trace; c012dc5f <do_generic_file_read+2ef/460>
Trace; c0150a9c <dput+1c/160>
Trace; c012e14a <generic_file_read+7a/110>
Trace; c012dfe0 <file_read_actor+0/f0>
Trace; c013cf65 <sys_read+95/110>
Trace; c0108b33 <system_call+33/38>
Code;  c01354e2 <__free_pages_ok+282/2a0>
00000000 <_EIP>:
Code;  c01354e2 <__free_pages_ok+282/2a0>   <=====
   0:   89 58 04                  mov    %ebx,0x4(%eax)   <=====
Code;  c01354e5 <__free_pages_ok+285/2a0>
   3:   89 03                     mov    %eax,(%ebx)
Code;  c01354e7 <__free_pages_ok+287/2a0>
   5:   89 53 04                  mov    %edx,0x4(%ebx)
Code;  c01354ea <__free_pages_ok+28a/2a0>
   8:   89 59 5c                  mov    %ebx,0x5c(%ecx)
Code;  c01354ed <__free_pages_ok+28d/2a0>
   b:   89 7b 0c                  mov    %edi,0xc(%ebx)
Code;  c01354f0 <__free_pages_ok+290/2a0>
   e:   ff 41 68                  incl   0x68(%ecx)
Code;  c01354f3 <__free_pages_ok+293/2a0>
  11:   83 c4 1c                  add    $0x1c,%esp


1 warning issued.  Results may not be reliable.



