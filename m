Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271952AbRIDMms>; Tue, 4 Sep 2001 08:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271961AbRIDMmg>; Tue, 4 Sep 2001 08:42:36 -0400
Received: from mx7.port.ru ([194.67.57.17]:26553 "EHLO mx7.port.ru")
	by vger.kernel.org with ESMTP id <S271952AbRIDMmX>;
	Tue, 4 Sep 2001 08:42:23 -0400
From: Samium Gromoff <_deepfire@mail.ru>
Message-Id: <200109041539.f84FdLZ00788@vegae.deep.net>
Subject: rmap3 swapoff oopses
To: linux-kernel@vger.kernel.org
Date: Tue, 4 Sep 2001 15:39:21 +0000 (UTC)
Cc: riel@surriel.com, marcelo@conectiva.com.br
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

         Here are ksymoopsed oopses i promised so long ago...
    actually i cut down the warnings in the beginning.

ksymoops 2.4.1 on i586 2.4.8-ac12.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.8-ac12/ (default)
     -m ./sm-2.4.8-ac12-pmap3 (specified)

Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 0000001f   ebx: c02fc000   ecx: c02e1ebc   edx: 00001848
esi: c1057548   edi: 00000000   ebp: 0000170a   esp: c132ff34
ds: 0018   es: 0018   ss: 0018
Process swapoff (pid: 767, stackpage=c132f000)
Stack: c0283953 00000055 c02fc000 c1057548 00170a00 0000170a c1057548 c04c4000
       c1057548 c02fc000 c1057548 c012d022 c012de59 00170a00 c1057548 c132ffa0
       ffffffff c0346320 c132ffbc c132e000 c0346320 c012dfd5 00000000 c132e000
Call Trace: [<c012d022>] [<c012de59>] [<c012dfd5>] [<c0132913>] [<c0106d83>]
Code: 0f 0b 83 c4 08 90 8d 74 26 00 8b 46 18 a9 80 00 00 00 74 16

>>EIP; c012c7a6 <__free_pages_ok+f6/348>   <=====
Trace; c012d022 <__free_pages+1a/1c>
Trace; c012de59 <try_to_unuse+151/1ac>
Trace; c012dfd5 <sys_swapoff+121/27c>
Trace; c0132913 <sys_read+c3/cc>
Trace; c0106d83 <system_call+33/40>
Code;  c012c7a6 <__free_pages_ok+f6/348>
00000000 <_EIP>:
Code;  c012c7a6 <__free_pages_ok+f6/348>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012c7a8 <__free_pages_ok+f8/348>
   2:   83 c4 08                  add    $0x8,%esp
Code;  c012c7ab <__free_pages_ok+fb/348>
   5:   90                        nop
Code;  c012c7ac <__free_pages_ok+fc/348>
   6:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c012c7b0 <__free_pages_ok+100/348>
   a:   8b 46 18                  mov    0x18(%esi),%eax
Code;  c012c7b3 <__free_pages_ok+103/348>
   d:   a9 80 00 00 00            test   $0x80,%eax
Code;  c012c7b8 <__free_pages_ok+108/348>
  12:   74 16                     je     2a <_EIP+0x2a> c012c7d0 <__free_pages_o

29 warnings issued.  Results may not be reliable.
============= AND THE SECOND ONE ========================================
ksymoops 2.4.1 on i586 2.4.8-ac12.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.8-ac12/ (default)
     -m ./sm-2.4.8-ac12-pmap3 (specified)

kernel BUG at swap.c:173!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012ab66>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 0000001a   ebx: c1057548   ecx: c02e1ebc   edx: 00001b27
esi: c1057564   edi: 000009b1   ebp: 00000001   esp: c1095fb4
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 6, stackpage=c1095000)
Stack: c02833c0 000000ad c1057548 c1057564 c012c02a c1057548 c1094000 c0283691
       c1094239 0008e000 000002b3 c012c21b 00010f00 c10edfb8 00000000 c010567c
       00000000 00000078 c02fdfc0
Call Trace: [<c012c02a>] [<c012c21b>] [<c010567c>]
Code: 0f 0b 83 c4 08 90 8d 74 26 00 8b 43 18 a9 40 00 00 00 75 14

>>EIP; c012ab66 <deactivate_page_nolock+a6/130>   <=====
Trace; c012c02a <refill_inactive+fa/134>
Trace; c012c21b <kswapd+87/e4>
Trace; c010567c <kernel_thread+28/38>
Code;  c012ab66 <deactivate_page_nolock+a6/130>
00000000 <_EIP>:
Code;  c012ab66 <deactivate_page_nolock+a6/130>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c012ab68 <deactivate_page_nolock+a8/130>
   2:   83 c4 08                  add    $0x8,%esp
Code;  c012ab6b <deactivate_page_nolock+ab/130>
   5:   90                        nop
Code;  c012ab6c <deactivate_page_nolock+ac/130>
   6:   8d 74 26 00               lea    0x0(%esi,1),%esi
Code;  c012ab70 <deactivate_page_nolock+b0/130>
   a:   8b 43 18                  mov    0x18(%ebx),%eax
Code;  c012ab73 <deactivate_page_nolock+b3/130>
   d:   a9 40 00 00 00            test   $0x40,%eax
Code;  c012ab78 <deactivate_page_nolock+b8/130>
  12:   75 14                     jne    28 <_EIP+0x28> c012ab8e <deactivate_pag

29 warnings issued.  Results may not be reliable.

