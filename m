Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262492AbSLEHyz>; Thu, 5 Dec 2002 02:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262604AbSLEHyz>; Thu, 5 Dec 2002 02:54:55 -0500
Received: from hqhost.ip-ua.net ([212.1.90.150]:4102 "EHLO hqhost.ip-ua.net")
	by vger.kernel.org with ESMTP id <S262492AbSLEHyy>;
	Thu, 5 Dec 2002 02:54:54 -0500
Date: Thu, 5 Dec 2002 10:03:04 +0200
From: maple@maple.org.ua
To: linux-kernel@vger.kernel.org
Subject: kswapd oopses in 2.4.18
Message-ID: <20021205080304.GA18889@valinor.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've using stock 2.4.18 in our production server, and today it oopses
after week of uptime. After first oops followed many next, LA grows
to ~3 from .3 and finally, machine stop pinging.

Machine is 1.6G P4 UP, 512M RAM, AIC-7899P, ext3, reiserfs
Can you give me idea whats happened?

Here is ksymoops output of first oops.


ksymoops 2.4.6 on i686 2.4.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m /boot/System.map-2.4.18 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_system_map stat /boot/System.map-2.4.18 failed
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01340d8>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: df878274   ebx: c6ef1454   ecx: c6ef145c   edx: c6ef146c
esi: c1969f5c   edi: c99d808c   ebp: c1969f64   esp: c1969f28
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=c1969000)
Stack: c013ff66 df878274 c6ef1454 c013ffbf c6ef1454 c99d8644 c99d863c c01401e4 
       c1969f5c 0000000e 000001d0 00000017 000003e4 c6b6d274 c8869bfc 00000005 
       c0140227 00000000 c01278c7 00000005 000001d0 00000005 000001d0 00000005 
Call Trace: [<c013ff66>] [<c013ffbf>] [<c01401e4>] [<c0140227>] [<c01278c7>] 
   [<c012791c>] [<c01279b3>] [<c0127a0e>] [<c0127b1d>] [<c0105478>] 
Code: 8f 4c 24 04 ff 49 08 0f 94 c0 84 c0 74 1a 8b 51 04 8b 01 89 


>>EIP; c01340d8 <cdput+0/888>   <=====

>>eax; df878274 <___strtok+1f5c58a0/207de68c>
>>ebx; c6ef1454 <___strtok+6c3ea80/207de68c>
>>ecx; c6ef145c <___strtok+6c3ea88/207de68c>
>>edx; c6ef146c <___strtok+6c3ea98/207de68c>
>>esi; c1969f5c <___strtok+16b7588/207de68c>
>>edi; c99d808c <___strtok+97256b8/207de68c>
>>ebp; c1969f64 <___strtok+16b7590/207de68c>
>>esp; c1969f28 <___strtok+16b7554/207de68c>

Trace; c013ff66 <clear_inode+ee/208>
Trace; c013ffbf <clear_inode+147/208>
Trace; c01401e4 <invalidate_device+fc/258>
Trace; c0140227 <invalidate_device+13f/258>
Trace; c01278c7 <kmem_find_general_cachep+f87/1920>
Trace; c012791c <kmem_find_general_cachep+fdc/1920>
Trace; c01279b3 <kmem_find_general_cachep+1073/1920>
Trace; c0127a0e <kmem_find_general_cachep+10ce/1920>
Trace; c0127b1d <kmem_find_general_cachep+11dd/1920>
Trace; c0105478 <kernel_thread+28/1cc>

Code;  c01340d8 <cdput+0/888>
00000000 <_EIP>:
Code;  c01340d8 <cdput+0/888>   <=====
   0:   8f 4c 24 04               popl   0x4(%esp,1)   <=====
Code;  c01340dc <cdput+4/888>
   4:   ff 49 08                  decl   0x8(%ecx)
Code;  c01340df <cdput+7/888>
   7:   0f 94 c0                  sete   %al
Code;  c01340e2 <cdput+a/888>
   a:   84 c0                     test   %al,%al
Code;  c01340e4 <cdput+c/888>
   c:   74 1a                     je     28 <_EIP+0x28> c0134100 <cdput+28/888>
Code;  c01340e6 <cdput+e/888>
   e:   8b 51 04                  mov    0x4(%ecx),%edx
Code;  c01340e9 <cdput+11/888>
  11:   8b 01                     mov    (%ecx),%eax
Code;  c01340eb <cdput+13/888>
  13:   89 00                     mov    %eax,(%eax)


1 warning and 1 error issued.  Results may not be reliable.


			SY, Vladimir

