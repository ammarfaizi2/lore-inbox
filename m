Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267468AbTASOok>; Sun, 19 Jan 2003 09:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267471AbTASOok>; Sun, 19 Jan 2003 09:44:40 -0500
Received: from jdi.jdimedia.nl ([212.204.192.51]:40880 "EHLO jdi.jdimedia.nl")
	by vger.kernel.org with ESMTP id <S267468AbTASOoi>;
	Sun, 19 Jan 2003 09:44:38 -0500
Date: Sun, 19 Jan 2003 15:53:39 +0100 (CET)
From: Igmar Palsenberg <i.palsenberg@jdimedia.nl>
X-X-Sender: igmar@jdi.jdimedia.nl
To: linux-kernel@vger.kernel.org
Subject: [OOPS] vmscan.c:358
Message-ID: <Pine.LNX.4.44.0301191540270.28865-100000@jdi.jdimedia.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

This OOPS is one I've seen on a number of different systems. The first one 
is a decoded one fished out of /var/log/messages, the second one I typed 
over from the console and decoded by hand.

In the second case, the system is still alive, but all new processes 
created create the same oops again, with a slightly different stack, and 
the process is the OOPS is the process that was just created.

I've also seen similair OOPS'ses on usenet, with a similair call trace.

Sysinfo for the two OOPS'ses below :

[root@igmar igmar]# uname -a
Linux igmar.base.jdimedia.local 2.4.20 #1 Tue Dec 24 21:42:30 CET 2002 
i586 unknown
[root@igmar igmar]# cat /proc/modules
vfat                    9696   3 (autoclean)
fat                    30496   0 (autoclean) [vfat]

System is a AMD K6-2.


Please contact me directly if more info is needed.



	Regards,


		Igmar




kernel BUG at vmscan.c:358!
invalid operand: 0000
CPU:    0
EIP:    0010:[shrink_cache+174/848]    Not tainted
EIP:    0010:[<c0128bae>]    Not tainted
EFLAGS: 00010202
eax: 00000040   ebx: 00000200   ecx: c1193d2c   edx: c197e000
esi: c1193d10   edi: 00000020   ebp: 000016fc   esp: c197fe18
ds: 0018   es: 0018   ss: 0018
Process updatedb (pid: 17963, stackpage=c197f000)
Stack: 0001800b c197e000 00000200 000001d2 c0281a30 c11c8168 c0124cd2 d7ffb3b4 
       00000000 00000020 000001d2 00000006 00000020 c0128fa6 00000006 00000017 
       c0281a30 00000006 000001d2 c0281a30 00000000 c0129010 00000020 c197e000 
Call Trace:    [read_cache_page+66/320] [shrink_caches+86/144] [try_to_free_pages_zone+48/80] [balance_classzone+84/496] [__alloc_pages+283/384]
Call Trace:    [<c0124cd2>] [<c0128fa6>] [<c0129010>] [<c0129a64>] [<c0129d1b>]
[read_cache_page+97/320] [link_path_walk+1964/2256] [ext2_get_page+32/128] [ext2_readpage+0/32] [real_lookup+77/192] [ext2_readdir+237/576]
[<c0124cf1>] [<c0138e4c>] [<c0163e40>] [<c0165d70>] [<c013852d>] [<c0163f8d>]
[vfs_readdir+88/128] [filldir64+0/320] [sys_getdents64+79/177] [filldir64+0/320] [sys_fchdir+189/208] [system_call+51/64]
[<c013c5b8>] [<c013cb80>] [<c013cd0f>] [<c013cb80>] [<c012eaed>] [<c0106e73>]

Code: 0f 0b 66 01 fc fb 23 c0 8b 41 fc a9 80 00 00 00 74 08 0f 0b 

---------------------------------------------------------------------------
ksymoops 2.4.0 on i586 2.4.20.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20/ (default)
     -m /boot/System.map (specified)

kernel BUG at vmscan.c:358
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0128bae>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000040   ebx: 00000200   ecx: c1193d2c   edx: d7cf2000
esi: c1193d10   edi: 00000020   ebp: 00001704   esp: d7cf3ddc
ds: 0018   es: 0018   ss: 0018
Stack: 00000000 d7cf2000 00000200 000001d2 c0281a30 c1427348 c4fa0080 c1427204
       00000001 00000020 000001d2 00000006 00000020 c0128fa6 00000006 00000017
       c0281a30 00000006 000001d2 c0281a30 00000000 c0129010 00000020 d7cf2000
Call Trace:    [<c0128fa6>] [<c0129010>] [<c0129a64>] [<c0129d1b>] [<c0120308>]
  [<c01203e0>] [<c01205a8>] [<c012106a>] [<c010f0fb>] [<c013983d>] [<c010bbdd>]
  [<c012ef22>] [<c013825e>] [<c010ef80>] [<c0106f84>] 
Code: 0f 0b 66 01 fc fb 23 c0 8b 41 fc a9 80 00 00 00 74 08 0f 0b

>>EIP; c0128bae <shrink_cache+ae/350>   <=====
Trace; c0128fa6 <shrink_caches+56/90>
Trace; c0129010 <try_to_free_pages_zone+30/50>
Trace; c0129a64 <balance_classzone+54/1f0>
Trace; c0129d1b <__alloc_pages+11b/180>
Trace; c0120308 <do_anonymous_page+38/e0>
Trace; c01203e0 <do_no_page+30/1a0>
Trace; c01205a8 <handle_mm_fault+58/c0>
Trace; c012106a <do_mmap_pgoff+4aa/560>
Trace; c010f0fb <do_page_fault+17b/4cb>
Trace; c013983d <open_namei+3ed/580>
Trace; c010bbdd <old_mmap+ed/130>
Trace; c012ef22 <filp_open+32/50>
Trace; c013825e <getname+5e/b0>
Trace; c010ef80 <do_page_fault+0/4cb>
Trace; c0106f84 <error_code+34/40>
Code;  c0128bae <shrink_cache+ae/350>
00000000 <_EIP>:
Code;  c0128bae <shrink_cache+ae/350>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0128bb0 <shrink_cache+b0/350>
   2:   66 01 fc                  add    %di,%sp
Code;  c0128bb3 <shrink_cache+b3/350>
   5:   fb                        sti    
Code;  c0128bb4 <shrink_cache+b4/350>
   6:   23 c0                     and    %eax,%eax
Code;  c0128bb6 <shrink_cache+b6/350>
   8:   8b 41 fc                  mov    0xfffffffc(%ecx),%eax
Code;  c0128bb9 <shrink_cache+b9/350>
   b:   a9 80 00 00 00            test   $0x80,%eax
Code;  c0128bbe <shrink_cache+be/350>
  10:   74 08                     je     1a <_EIP+0x1a> c0128bc8 <shrink_cache+c8/350>
Code;  c0128bc0 <shrink_cache+c0/350>
  12:   0f 0b                     ud2a   


-- 

Igmar Palsenberg
JDI Media Solutions

Helhoek 30
6923PE Groessen
Tel: +31 (0)316 - 596695
Fax: +31 (0)316 - 596699
The Netherlands

mailto: i.palsenberg@jdimedia.nl
PGP/GPG key : http://www.jdimedia.nl/formulier/pgp/igmar

