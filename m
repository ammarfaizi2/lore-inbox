Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317991AbSGLHSB>; Fri, 12 Jul 2002 03:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317993AbSGLHSB>; Fri, 12 Jul 2002 03:18:01 -0400
Received: from inway106.cdi.cz ([213.151.81.106]:56298 "EHLO luxik.cdi.cz")
	by vger.kernel.org with ESMTP id <S317991AbSGLHR7>;
	Fri, 12 Jul 2002 03:17:59 -0400
Date: Fri, 12 Jul 2002 09:20:45 +0200 (CEST)
From: Martin Devera <devik@cdi.cz>
To: linux-kernel@vger.kernel.org
Subject: Oops on SMP after upgrade to 2.4.18
Message-ID: <Pine.LNX.4.44.0207120912240.24106-100000@luxik.cdi.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
2.4.18 compiled with gcc version 2.95.2. After change
from 2.4.3 and 1 day of uptime it oopsed during doing
du on IDE hdd. SCSI tape command was run at the same time.
du is still here locked in D state. I can't restart machine
because it is production server and still running after oops.
Details:
ksymoops 2.4.5 on i686 2.4.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18/ (default)
     -m /boot/System.map-2.4.18 (specified)

Unable to handle kernel paging request at virtual address 8bd4189c
c0113920
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c0113920>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010087
eax: cbd418a0   ebx: 8bd418a0   ecx: 00000001   edx: 00000003
esi: cbd41800   edi: cbd4189c   ebp: cdae5ed0   esp: cdae5eb4
ds: 0018   es: 0018   ss: 0018
Process du (pid: 5816, stackpage=cdae5000)
Stack: 00000000 cbd41800 c16515e0 cbd418a0 00000001 00000286 00000003 c1707800
       c0149254 00000000 c16515e0 00311283 c1707800 c0149491 c1707800 00311283
       c16515e0 00000000 00000000 d43b9920 d511f0a0 d511f0a0 d43b9920 c0169d83
Call Trace: [<c0149254>] [<c0149491>] [<c0169d83>] [<c013e5b2>] [<c013ed88>]
   [<c013f00a>] [<c013f4f1>] [<c013bc19>] [<c01345ff>] [<c0106eaf>]
Code: 8b 4b fc 8b 01 85 45 fc 74 66 31 d2 9c 5e fa f0 fe 0d a0 88


>>EIP; c0113920 <__wake_up+38/c0>   <=====

>>eax; cbd418a0 <_end+b9c24e8/184c4c48>
>>ebx; 8bd418a0 Before first symbol
>>esi; cbd41800 <_end+b9c2448/184c4c48>
>>edi; cbd4189c <_end+b9c24e4/184c4c48>
>>ebp; cdae5ed0 <_end+d766b18/184c4c48>
>>esp; cdae5eb4 <_end+d766afc/184c4c48>

Trace; c0149254 <get_new_inode+10c/180>
Trace; c0149491 <iget4+d9/e4>
Trace; c0169d83 <ext2_lookup+43/68>
Trace; c013e5b2 <real_lookup+7a/11c>
Trace; c013ed88 <link_path_walk+5f8/860>
Trace; c013f00a <path_walk+1a/1c>
Trace; c013f4f1 <__user_walk+35/50>
Trace; c013bc19 <sys_newlstat+19/70>
Trace; c01345ff <sys_close+5b/70>
Trace; c0106eaf <system_call+33/38>

Code;  c0113920 <__wake_up+38/c0>
00000000 <_EIP>:
Code;  c0113920 <__wake_up+38/c0>   <=====
   0:   8b 4b fc                  movl   0xfffffffc(%ebx),%ecx   <=====
Code;  c0113923 <__wake_up+3b/c0>
   3:   8b 01                     movl   (%ecx),%eax
Code;  c0113925 <__wake_up+3d/c0>
   5:   85 45 fc                  testl  %eax,0xfffffffc(%ebp)
Code;  c0113928 <__wake_up+40/c0>
   8:   74 66                     je     70 <_EIP+0x70> c0113990 <__wake_up+a8/c0>
Code;  c011392a <__wake_up+42/c0>
   a:   31 d2                     xorl   %edx,%edx
Code;  c011392c <__wake_up+44/c0>
   c:   9c                        pushf
Code;  c011392d <__wake_up+45/c0>
   d:   5e                        popl   %esi
Code;  c011392e <__wake_up+46/c0>
   e:   fa                        cli
Code;  c011392f <__wake_up+47/c0>
   f:   f0 fe 0d a0 88 00 00      lock decb 0x88a0



