Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317680AbSGOWls>; Mon, 15 Jul 2002 18:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317681AbSGOWlr>; Mon, 15 Jul 2002 18:41:47 -0400
Received: from elektroni.ee.tut.fi ([130.230.131.11]:45184 "HELO
	elektroni.ee.tut.fi") by vger.kernel.org with SMTP
	id <S317680AbSGOWlq>; Mon, 15 Jul 2002 18:41:46 -0400
Date: Tue, 16 Jul 2002 01:44:40 +0300
From: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
To: linux-kernel@vger.kernel.org
Subject: oops 2.4.19-rc1
Message-ID: <20020715224440.GA595@elektroni.ee.tut.fi>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I tried to compile mozilla and the compilation stopped after maybe half an
hour at a compiler internal error. It was compiling c++ code using gcc 3.1
so I thought it was gcc's fault, decided to rm the mozilla tree but rm
segfaulted and I got the oops below. Processes stuck when I tried to do
something in my shells and then I rebooted. ext3 replayed its journals and
the system seemed ok. I fscked the file systems but didn't find any
problems. I just ran memtest for a couple of hours and it didn't find any
problems in the memory.

Kernel 2.4.19-rc1 compiled with gcc 2.95.3, CONFIG_MK7=y. It's a 1400 MHz
athlon thunderbird, VIA KT266 chipset, 512MB DDR RAM, Seagate ide ST360021A
using ext3, display card ATI Rage XL AGP (Mach64), eepro100. It's the first
oops or other problem for this box, in use from last october. On the other
hand, it's been rather warm here these days. Could this be caused by overheat?


ksymoops 2.4.5 on i686 2.4.19-rc1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-rc1/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Jul 15 22:16:06 elektroni kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Jul 15 22:16:06 elektroni kernel: c01139c3
Jul 15 22:16:06 elektroni kernel: *pde = 00000000
Jul 15 22:16:06 elektroni kernel: Oops: 0000
Jul 15 22:16:06 elektroni kernel: CPU:    0
Jul 15 22:16:06 elektroni kernel: EIP:    0010:[<c01139c3>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jul 15 22:16:06 elektroni kernel: EFLAGS: 00010093
Jul 15 22:16:06 elektroni kernel: eax: 01c0d788   ebx: d8330d84   ecx: 00000000   edx: 00000003
Jul 15 22:16:06 elektroni kernel: esi: d8330d8c   edi: 00000001   ebp: c833bea4   esp: c833be8c
Jul 15 22:16:06 elektroni kernel: ds: 0018   es: 0018   ss: 0018
Jul 15 22:16:06 elektroni kernel: Process rm (pid: 13895, stackpage=c833b000)
Jul 15 22:16:06 elektroni kernel: Stack: d8330d88 00000002 d8330d40 d8330d8c 00000286 00000003 00001000 c0131b6a 
Jul 15 22:16:06 elektroni kernel:        d8330d40 c0159d30 dfcfa600 d8330d40 c13ef1bc 00000000 c833bf44 00000000 
Jul 15 22:16:06 elektroni kernel:        dfcfa694 00000001 d8330d40 c0151f02 dfcfa600 c13ef1bc 00000000 c0124d39 
Jul 15 22:16:06 elektroni kernel: Call Trace: [<c0131b6a>] [<c0159d30>] [<c0151f02>] [<c0124d39>] [<c0124d63>] 
Jul 15 22:16:06 elektroni kernel:    [<c0124ee8>] [<c0124f91>] [<c0143412>] [<c0141adc>] [<c013b309>] [<c013b3e8>] 
Jul 15 22:16:06 elektroni kernel:    [<c01086cf>] 
Jul 15 22:16:06 elektroni kernel: Code: 8b 01 85 45 fc 74 4d 31 c0 9c 5e fa c7 01 00 00 00 00 83 79 


>>EIP; c01139c3 <__wake_up+33/a0>   <=====

>>eax; 01c0d788 Before first symbol
>>ebx; d8330d84 <_end+180a1314/20624590>
>>esi; d8330d8c <_end+180a131c/20624590>
>>ebp; c833bea4 <_end+80ac434/20624590>
>>esp; c833be8c <_end+80ac41c/20624590>

Trace; c0131b6a <unlock_buffer+3a/40>
Trace; c0159d30 <journal_flushpage+a0/130>
Trace; c0151f02 <ext3_flushpage+22/30>
Trace; c0124d39 <do_flushpage+19/30>
Trace; c0124d63 <truncate_complete_page+13/50>
Trace; c0124ee8 <truncate_list_pages+148/1b0>
Trace; c0124f91 <truncate_inode_pages+41/70>
Trace; c0143412 <iput+a2/1a0>
Trace; c0141adc <d_delete+4c/70>
Trace; c013b309 <vfs_unlink+109/140>
Trace; c013b3e8 <sys_unlink+a8/120>
Trace; c01086cf <system_call+33/38>

Code;  c01139c3 <__wake_up+33/a0>
00000000 <_EIP>:
Code;  c01139c3 <__wake_up+33/a0>   <=====
   0:   8b 01                     mov    (%ecx),%eax   <=====
Code;  c01139c5 <__wake_up+35/a0>
   2:   85 45 fc                  test   %eax,0xfffffffc(%ebp)
Code;  c01139c8 <__wake_up+38/a0>
   5:   74 4d                     je     54 <_EIP+0x54> c0113a17 <__wake_up+87/a0>
Code;  c01139ca <__wake_up+3a/a0>
   7:   31 c0                     xor    %eax,%eax
Code;  c01139cc <__wake_up+3c/a0>
   9:   9c                        pushf  
Code;  c01139cd <__wake_up+3d/a0>
   a:   5e                        pop    %esi
Code;  c01139ce <__wake_up+3e/a0>
   b:   fa                        cli    
Code;  c01139cf <__wake_up+3f/a0>
   c:   c7 01 00 00 00 00         movl   $0x0,(%ecx)
Code;  c01139d5 <__wake_up+45/a0>
  12:   83 79 00 00               cmpl   $0x0,0x0(%ecx)


1 warning issued.  Results may not be reliable.
