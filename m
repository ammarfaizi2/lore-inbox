Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289711AbSAJVzi>; Thu, 10 Jan 2002 16:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289714AbSAJVz3>; Thu, 10 Jan 2002 16:55:29 -0500
Received: from petrus.schuldei.org ([217.27.175.140]:28265 "HELO
	petrus.schuldei.org") by vger.kernel.org with SMTP
	id <S289711AbSAJVzV>; Thu, 10 Jan 2002 16:55:21 -0500
Date: Thu, 10 Jan 2002 23:09:29 +0100
From: Andreas Schuldei <andreas@schuldei.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: viro@math.psu.edu
Subject: oops in the filesystem code (ext3) during find (cron)
Message-ID: <20020110220928.GA975@sigrid.schuldei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I regularly get this oops during daily cron jobs.

uname -a
Linux johannes 2.4.17-pre6 #4 Sat Dec 15 21:54:55 CET 2001 i686
ext3 fs

i think i can reproduce this at will for debugging.

the defaults for ksymoops are correct in this case.
andreas@johannes:~> ksymoops < /root/oops-2002-01-10
ksymoops 2.4.3 on i686 2.4.17-pre6.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17-pre6/ (default)
     -m /boot/System.map-2.4.17-pre6 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Call Trace: [<c01352f4>] [<c01359f8>] [<c013510d>] [<c0135c6a>] [<c0136021>]
   [<c01332bd>] [<c012ce27>] [<c0106d3b>]
Code: 8b 6d 00 8b 54 24 18 39 53 44 75 7c 8b 44 24 24 39 43 0c 75
Using defaults from ksymoops -t elf32-i386 -a i386

Trace; c01352f4 <cached_lookup+10/54>
Trace; c01359f8 <link_path_walk+500/758>
Trace; c013510c <getname+5c/9c>
Trace; c0135c6a <path_walk+1a/1c>
Trace; c0136020 <__user_walk+34/50>
Trace; c01332bc <sys_lstat64+18/70>
Trace; c012ce26 <sys_close+42/54>
Trace; c0106d3a <system_call+32/38>
Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 6d 00                  mov    0x0(%ebp),%ebp
Code;  00000002 Before first symbol
   3:   8b 54 24 18               mov    0x18(%esp,1),%edx
Code;  00000006 Before first symbol
   7:   39 53 44                  cmp    %edx,0x44(%ebx)
Code;  0000000a Before first symbol
   a:   75 7c                     jne    88 <_EIP+0x88> 00000088 Before first symbol
Code;  0000000c Before first symbol
   c:   8b 44 24 24               mov    0x24(%esp,1),%eax
Code;  00000010 Before first symbol
  10:   39 43 0c                  cmp    %eax,0xc(%ebx)
Code;  00000012 Before first symbol
  13:   75 00                     jne    15 <_EIP+0x15> 00000014 Before first symbol

 <1>Unable to handle kernel paging request at virtual address 5d856915
c013d030
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c013d030>]    Not tainted
EFLAGS: 00010207
eax: efe5f020   ebx: 5d856905   ecx: 00000011   edx: cacf0437
esi: 00000000   edi: df409fa4   ebp: 5d856915   esp: df409f14
ds: 0018   es: 0018   ss: 0018
Process find (pid: 23101, stackpage=df409000)
Stack: df409f74 00000000 df409fa4 e1b942c0 efe5f020 e7aef000 cacf0437 0000000d
       c01352f4 e63a59a0 df409f74 df409f74 c01359f8 e63a59a0 df409f74 00000000
       e7aef000 00000000 df409fa4 00000008 c013510d 00000008 e7aef00d 00000000
Call Trace: [<c01352f4>] [<c01359f8>] [<c013510d>] [<c0135c6a>] [<c0136021>]
   [<c01332bd>] [<c012ce27>] [<c0106d3b>]
Code: 8b 6d 00 8b 54 24 18 39 53 44 75 7c 8b 44 24 24 39 43 0c 75

>>EIP; c013d030 <d_lookup+60/100>   <=====
Trace; c01352f4 <cached_lookup+10/54>
Trace; c01359f8 <link_path_walk+500/758>
Trace; c013510c <getname+5c/9c>
Trace; c0135c6a <path_walk+1a/1c>
Trace; c0136020 <__user_walk+34/50>
Trace; c01332bc <sys_lstat64+18/70>
Trace; c012ce26 <sys_close+42/54>
Trace; c0106d3a <system_call+32/38>
Code;  c013d030 <d_lookup+60/100>
00000000 <_EIP>:
Code;  c013d030 <d_lookup+60/100>   <=====
   0:   8b 6d 00                  mov    0x0(%ebp),%ebp   <=====
Code;  c013d032 <d_lookup+62/100>
   3:   8b 54 24 18               mov    0x18(%esp,1),%edx
Code;  c013d036 <d_lookup+66/100>
   7:   39 53 44                  cmp    %edx,0x44(%ebx)
Code;  c013d03a <d_lookup+6a/100>
   a:   75 7c                     jne    88 <_EIP+0x88> c013d0b8 <d_lookup+e8/100>
Code;  c013d03c <d_lookup+6c/100>
   c:   8b 44 24 24               mov    0x24(%esp,1),%eax
Code;  c013d040 <d_lookup+70/100>
  10:   39 43 0c                  cmp    %eax,0xc(%ebx)
Code;  c013d042 <d_lookup+72/100>
  13:   75 00                     jne    15 <_EIP+0x15> c013d044 <d_lookup+74/100>


1 warning issued.  Results may not be reliable.

