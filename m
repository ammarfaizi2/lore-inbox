Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269695AbSISOfi>; Thu, 19 Sep 2002 10:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269702AbSISOfi>; Thu, 19 Sep 2002 10:35:38 -0400
Received: from mail104.mail.bellsouth.net ([205.152.58.44]:61026 "EHLO
	imf04bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S269695AbSISOfh>; Thu, 19 Sep 2002 10:35:37 -0400
Date: Thu, 19 Sep 2002 10:40:34 -0400 (EDT)
From: Burton Windle <bwindle@fint.org>
X-X-Sender: bwindle@morpheus
To: linux-kernel@vger.kernel.org
Subject: [2.5.36] oops when reading /proc/locks
Message-ID: <Pine.LNX.4.43.0209191037430.332-100000@morpheus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

stock 2.5.36, non-preempt, non-smp.  After enabling and then disabling an
ethernet sniffer, then cat'ting /proc/locks, I can reproduce this oops
easily.

 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000008
c01452aa
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c01452aa>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 00000000   ebx: 00000000   ecx: 00000400   edx: 00000400
esi: c66c8000   edi: c8c1d894   ebp: c66c8000   esp: c7e77ea8
ds: 0068   es: 0068   ss: 0068
Stack: 00000000 00000001 00000000 c56b9344 00000004 00000400 c8c1d898 c8c1d894
       c01455dc c66c8000 c8c1d894 00000001 c0267b11 00000400 00000001 c66c8000
       00000000 00000400 00000400 00000400 c66c8000 c0155f0a c66c8000 c7e77f3c
Call Trace: [<c01455dc>] [<c0155f0a>] [<c0153a6d>] [<c01336c8>] [<c013ab6b>]
   [<c013389a>] [<c01071cf>]
Code: 8b 58 08 8b 44 24 30 50 8b 4c 24 30 51 68 2a 7a 26 c0 56 e8


>>EIP; c01452aa <lock_get_status+1a/260>   <=====

Trace; c01455dc <get_locks_status+5c/100>
Trace; c0155f0a <locks_read_proc+1a/40>
Trace; c0153a6d <proc_file_read+19d/1b0>
Trace; c01336c8 <vfs_read+98/120>
Trace; c013ab6b <sys_fstat64+2b/30>
Trace; c013389a <sys_read+2a/40>
Trace; c01071cf <syscall_call+7/b>

Code;  c01452aa <lock_get_status+1a/260>
00000000 <_EIP>:
Code;  c01452aa <lock_get_status+1a/260>   <=====
   0:   8b 58 08                  mov    0x8(%eax),%ebx   <=====
Code;  c01452ad <lock_get_status+1d/260>
   3:   8b 44 24 30               mov    0x30(%esp,1),%eax
Code;  c01452b1 <lock_get_status+21/260>
   7:   50                        push   %eax
Code;  c01452b2 <lock_get_status+22/260>
   8:   8b 4c 24 30               mov    0x30(%esp,1),%ecx
Code;  c01452b6 <lock_get_status+26/260>
   c:   51                        push   %ecx
Code;  c01452b7 <lock_get_status+27/260>
   d:   68 2a 7a 26 c0            push   $0xc0267a2a
Code;  c01452bc <lock_get_status+2c/260>
  12:   56                        push   %esi
Code;  c01452bd <lock_get_status+2d/260>
  13:   e8 00 00 00 00            call   18 <_EIP+0x18> c01452c2
<lock_get_status+32/260>


Linux razor 2.5.36 #0 Thu Sep 19 09:32:59 EST 2002 i686 unknown unknown
GNU/Linux

Gnu C                  3.0.4
Gnu make               3.79.1
util-linux             2.11n
mount                  2.11n
modutils               2.4.15
e2fsprogs              1.27
Linux C Library        2.2.5
Dynamic linker (ldd)   2.2.5
Procps                 2.0.7
Net-tools              1.60
Console-tools          0.2.3
Sh-utils               2.0.12


--
Burton Windle                           burton@fint.org
Linux: the "grim reaper of innocent orphaned children."
          from /usr/src/linux-2.4.18/init/main.c:461


