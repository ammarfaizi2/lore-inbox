Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263561AbTLZQe0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 11:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264425AbTLZQe0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 11:34:26 -0500
Received: from mail.aei.ca ([206.123.6.14]:43774 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S263561AbTLZQeH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 11:34:07 -0500
Subject: [2.4.23aa1] multiple oopsen
From: Shane Shrybman <shrybman@aei.ca>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrea Arcangeli <andrea@suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1072456438.10203.38.camel@mars.goatskin.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 26 Dec 2003 11:33:59 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

System is still up, and working, but I found these in the logs. This is
a headless x86,UP,IDE,EXT2 system that does masquerading and runs a few,
mostly idle, daemons. I installed 2.4.23aa1 on Dec. 11th and the first
oops message appeared on Dec. 12th. Before that it ran 2.4.22aa1 since
September without issue. This system has also survived a memtest run
less than a year ago.

ksymoops 2.4.5 on i686 2.4.23aa1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.23aa1/ (default)
     -m /boot/System.map-2.4.23aa1 (specified)

Unable to handle kernel paging request at virtual address 04000000
8013d190
*pde = 00000000
Oops: 0000 2.4.23aa1 #2 Wed Dec 10 21:18:59 EST 2003
CPU:    0
EIP:    0010:[<8013d190>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 84dc1ce0   ebx: 84dc1ce0   ecx: 00000000   edx: 04000000
esi: 82a09f64   edi: 82a09fa4   ebp: 00000008   esp: 82a09f30
ds: 0018   es: 0018   ss: 0018
Process find (pid: 5828, stackpage=82a09000)
Stack: 00000000 8013d967 84dc1960 82a09f64 00000000 82a09fa4 817f2000
00000000 
       00000008 00000008 00000000 817f200a 00000000 817f2000 0000000a
60871e95 
       8013dc1a 8013dd9b 817f2000 817f2000 82a09fa4 8013dff6 82a08000
82a09fa4 
Call Trace:         [<8013d967>] (60) [<8013dc1a>] (04) [<8013dd9b>]
(16)
  [<8013dff6>] (20) [<8013ad69>] (24) [<80133573>] (16) [<80106e93>]
(60)
Code: 83 3a 00 74 29 8b 44 24 10 50 53 8b 02 ff d0 83 c4 08 85 c0 


>>EIP; 8013d190 <cached_lookup+20/60>   <=====

>>eax; 84dc1ce0 <END_OF_CODE+175c481/????>
>>ebx; 84dc1ce0 <END_OF_CODE+175c481/????>
>>edx; 04000000 Before first symbol
>>esi; 82a09f64 <[ip_conntrack].bss.end+a6d731/ccd7cd>
>>edi; 82a09fa4 <[ip_conntrack].bss.end+a6d771/ccd7cd>
>>esp; 82a09f30 <[ip_conntrack].bss.end+a6d6fd/ccd7cd>

Trace; 8013d967 <link_path_walk+5d7/870>
Trace; 8013dc1a <path_walk+1a/20>
Trace; 8013dd9b <path_lookup+1b/30>
Trace; 8013dff6 <__user_walk+26/40>
Trace; 8013ad69 <sys_lstat64+19/80>
Trace; 80133573 <sys_close+43/60>
Trace; 80106e93 <system_call+33/40>

Code;  8013d190 <cached_lookup+20/60>
00000000 <_EIP>:
Code;  8013d190 <cached_lookup+20/60>   <=====
   0:   83 3a 00                  cmpl   $0x0,(%edx)   <=====
Code;  8013d193 <cached_lookup+23/60>
   3:   74 29                     je     2e <_EIP+0x2e> 8013d1be
<cached_lookup+4e/60>
Code;  8013d195 <cached_lookup+25/60>
   5:   8b 44 24 10               mov    0x10(%esp,1),%eax
Code;  8013d199 <cached_lookup+29/60>
   9:   50                        push   %eax
Code;  8013d19a <cached_lookup+2a/60>
   a:   53                        push   %ebx
Code;  8013d19b <cached_lookup+2b/60>
   b:   8b 02                     mov    (%edx),%eax
Code;  8013d19d <cached_lookup+2d/60>
   d:   ff d0                     call   *%eax
Code;  8013d19f <cached_lookup+2f/60>
   f:   83 c4 08                  add    $0x8,%esp
Code;  8013d1a2 <cached_lookup+32/60>
  12:   85 c0                     test   %eax,%eax

 <1>Unable to handle kernel paging request at virtual address 04000000
8013d190
*pde = 00000000
Oops: 0000 2.4.23aa1 #2 Wed Dec 10 21:18:59 EST 2003
CPU:    0
EIP:    0010:[<8013d190>]    Not tainted
EFLAGS: 00010206
eax: 84dc1ce0   ebx: 84dc1ce0   ecx: 00000000   edx: 04000000
esi: 82c97f64   edi: 82c97fa4   ebp: 00000008   esp: 82c97f30
ds: 0018   es: 0018   ss: 0018
Process find (pid: 6014, stackpage=82c97000)
Stack: 00000000 8013d967 84dc1960 82c97f64 00000000 82c97fa4 848f1000
00000000 
       00000008 00000008 00000000 848f100a 00000000 848f1000 0000000a
60871e95 
       8013dc1a 8013dd9b 848f1000 848f1000 82c97fa4 8013dff6 82c96000
82c97fa4 
Call Trace:         [<8013d967>] (60) [<8013dc1a>] (04) [<8013dd9b>]
(16)
  [<8013dff6>] (20) [<8013ad69>] (24) [<80133573>] (16) [<80106e93>]
(60)
Code: 83 3a 00 74 29 8b 44 24 10 50 53 8b 02 ff d0 83 c4 08 85 c0 


>>EIP; 8013d190 <cached_lookup+20/60>   <=====

>>eax; 84dc1ce0 <END_OF_CODE+175c481/????>
>>ebx; 84dc1ce0 <END_OF_CODE+175c481/????>
>>edx; 04000000 Before first symbol
>>esi; 82c97f64 <[slhc].rodata.end+2cea5/45f41>
>>edi; 82c97fa4 <[slhc].rodata.end+2cee5/45f41>
>>esp; 82c97f30 <[slhc].rodata.end+2ce71/45f41>

Trace; 8013d967 <link_path_walk+5d7/870>
Trace; 8013dc1a <path_walk+1a/20>
Trace; 8013dd9b <path_lookup+1b/30>
Trace; 8013dff6 <__user_walk+26/40>
Trace; 8013ad69 <sys_lstat64+19/80>
Trace; 80133573 <sys_close+43/60>
Trace; 80106e93 <system_call+33/40>

Code;  8013d190 <cached_lookup+20/60>
00000000 <_EIP>:
Code;  8013d190 <cached_lookup+20/60>   <=====
   0:   83 3a 00                  cmpl   $0x0,(%edx)   <=====
Code;  8013d193 <cached_lookup+23/60>
   3:   74 29                     je     2e <_EIP+0x2e> 8013d1be
<cached_lookup+4e/60>
Code;  8013d195 <cached_lookup+25/60>
   5:   8b 44 24 10               mov    0x10(%esp,1),%eax
Code;  8013d199 <cached_lookup+29/60>
   9:   50                        push   %eax
Code;  8013d19a <cached_lookup+2a/60>
   a:   53                        push   %ebx
Code;  8013d19b <cached_lookup+2b/60>
   b:   8b 02                     mov    (%edx),%eax
Code;  8013d19d <cached_lookup+2d/60>
   d:   ff d0                     call   *%eax
Code;  8013d19f <cached_lookup+2f/60>
   f:   83 c4 08                  add    $0x8,%esp
Code;  8013d1a2 <cached_lookup+32/60>
  12:   85 c0                     test   %eax,%eax

Unable to handle kernel paging request at virtual address 04000000
8013d190
*pde = 00000000
Oops: 0000 2.4.23aa1 #2 Wed Dec 10 21:18:59 EST 2003
CPU:    0
EIP:    0010:[<8013d190>]    Not tainted
EFLAGS: 00010206
eax: 84dc1ce0   ebx: 84dc1ce0   ecx: 00000000   edx: 04000000
esi: 83b2bf64   edi: 83b2bfa4   ebp: 00000008   esp: 83b2bf30
ds: 0018   es: 0018   ss: 0018
Process find (pid: 25277, stackpage=83b2b000)
Stack: 00000000 8013d967 84dc1960 83b2bf64 00000000 83b2bfa4 867b2000
00000000 
       00000008 00000008 00000000 867b200a 00000000 867b2000 0000000a
60871e95 
       8013dc1a 8013dd9b 867b2000 867b2000 83b2bfa4 8013dff6 83b2a000
83b2bfa4 
Call Trace:         [<8013d967>] (60) [<8013dc1a>] (04) [<8013dd9b>]
(16)
  [<8013dff6>] (20) [<8013ad69>] (24) [<80133573>] (16) [<80106e93>]
(60)
Code: 83 3a 00 74 29 8b 44 24 10 50 53 8b 02 ff d0 83 c4 08 85 c0 


>>EIP; 8013d190 <cached_lookup+20/60>   <=====

>>eax; 84dc1ce0 <END_OF_CODE+175c481/????>
>>ebx; 84dc1ce0 <END_OF_CODE+175c481/????>
>>edx; 04000000 Before first symbol
>>esi; 83b2bf64 <END_OF_CODE+4c6705/????>
>>edi; 83b2bfa4 <END_OF_CODE+4c6745/????>
>>esp; 83b2bf30 <END_OF_CODE+4c66d1/????>

Trace; 8013d967 <link_path_walk+5d7/870>
Trace; 8013dc1a <path_walk+1a/20>
Trace; 8013dd9b <path_lookup+1b/30>
Trace; 8013dff6 <__user_walk+26/40>
Trace; 8013ad69 <sys_lstat64+19/80>
Trace; 80133573 <sys_close+43/60>
Trace; 80106e93 <system_call+33/40>

Code;  8013d190 <cached_lookup+20/60>
00000000 <_EIP>:
Code;  8013d190 <cached_lookup+20/60>   <=====
   0:   83 3a 00                  cmpl   $0x0,(%edx)   <=====
Code;  8013d193 <cached_lookup+23/60>
   3:   74 29                     je     2e <_EIP+0x2e> 8013d1be
<cached_lookup+4e/60>
Code;  8013d195 <cached_lookup+25/60>
   5:   8b 44 24 10               mov    0x10(%esp,1),%eax
Code;  8013d199 <cached_lookup+29/60>
   9:   50                        push   %eax
Code;  8013d19a <cached_lookup+2a/60>
   a:   53                        push   %ebx
Code;  8013d19b <cached_lookup+2b/60>
   b:   8b 02                     mov    (%edx),%eax
Code;  8013d19d <cached_lookup+2d/60>
   d:   ff d0                     call   *%eax
Code;  8013d19f <cached_lookup+2f/60>
   f:   83 c4 08                  add    $0x8,%esp
Code;  8013d1a2 <cached_lookup+32/60>
  12:   85 c0                     test   %eax,%eax

 <1>Unable to handle kernel paging request at virtual address 04000000
8013d190
*pde = 00000000
Oops: 0000 2.4.23aa1 #2 Wed Dec 10 21:18:59 EST 2003
CPU:    0
EIP:    0010:[<8013d190>]    Not tainted
EFLAGS: 00010206
eax: 84dc1ce0   ebx: 84dc1ce0   ecx: 00000000   edx: 04000000
esi: 815c9f64   edi: 815c9fa4   ebp: 00000008   esp: 815c9f30
ds: 0018   es: 0018   ss: 0018
Process find (pid: 25465, stackpage=815c9000)
Stack: 00000000 8013d967 84dc1960 815c9f64 00000000 815c9fa4 84cb7000
00000000 
       00000008 00000008 00000000 84cb700a 00000000 84cb7000 0000000a
60871e95 
       8013dc1a 8013dd9b 84cb7000 84cb7000 815c9fa4 8013dff6 815c8000
815c9fa4 
Call Trace:         [<8013d967>] (60) [<8013dc1a>] (04) [<8013dd9b>]
(16)
  [<8013dff6>] (20) [<8013ad69>] (24) [<80133573>] (16) [<80106e93>]
(60)
Code: 83 3a 00 74 29 8b 44 24 10 50 53 8b 02 ff d0 83 c4 08 85 c0 


>>EIP; 8013d190 <cached_lookup+20/60>   <=====

>>eax; 84dc1ce0 <END_OF_CODE+175c481/????>
>>ebx; 84dc1ce0 <END_OF_CODE+175c481/????>
>>edx; 04000000 Before first symbol
>>esi; 815c9f64 <[8390].rodata.end+1a2945/46b9e1>
>>edi; 815c9fa4 <[8390].rodata.end+1a2985/46b9e1>
>>esp; 815c9f30 <[8390].rodata.end+1a2911/46b9e1>

Trace; 8013d967 <link_path_walk+5d7/870>
Trace; 8013dc1a <path_walk+1a/20>
Trace; 8013dd9b <path_lookup+1b/30>
Trace; 8013dff6 <__user_walk+26/40>
Trace; 8013ad69 <sys_lstat64+19/80>
Trace; 80133573 <sys_close+43/60>
Trace; 80106e93 <system_call+33/40>

Code;  8013d190 <cached_lookup+20/60>
00000000 <_EIP>:
Code;  8013d190 <cached_lookup+20/60>   <=====
   0:   83 3a 00                  cmpl   $0x0,(%edx)   <=====
Code;  8013d193 <cached_lookup+23/60>
   3:   74 29                     je     2e <_EIP+0x2e> 8013d1be
<cached_lookup+4e/60>
Code;  8013d195 <cached_lookup+25/60>
   5:   8b 44 24 10               mov    0x10(%esp,1),%eax
Code;  8013d199 <cached_lookup+29/60>
   9:   50                        push   %eax
Code;  8013d19a <cached_lookup+2a/60>
   a:   53                        push   %ebx
Code;  8013d19b <cached_lookup+2b/60>
   b:   8b 02                     mov    (%edx),%eax
Code;  8013d19d <cached_lookup+2d/60>
   d:   ff d0                     call   *%eax
Code;  8013d19f <cached_lookup+2f/60>
   f:   83 c4 08                  add    $0x8,%esp
Code;  8013d1a2 <cached_lookup+32/60>
  12:   85 c0                     test   %eax,%eax

Unable to handle kernel paging request at virtual address 04000000
8013d190
*pde = 00000000
Oops: 0000 2.4.23aa1 #2 Wed Dec 10 21:18:59 EST 2003
CPU:    0
EIP:    0010:[<8013d190>]    Not tainted
EFLAGS: 00010206
eax: 84dc1ce0   ebx: 84dc1ce0   ecx: 00000000   edx: 04000000
esi: 869d5f64   edi: 869d5fa4   ebp: 00000008   esp: 869d5f30
ds: 0018   es: 0018   ss: 0018
Process find (pid: 11684, stackpage=869d5000)
Stack: 00000000 8013d967 84dc1960 869d5f64 00000000 869d5fa4 82832000
00000000 
       00000008 00000008 00000000 8283200a 00000000 82832000 0000000a
60871e95 
       8013dc1a 8013dd9b 82832000 82832000 869d5fa4 8013dff6 869d4000
869d5fa4 
Call Trace:         [<8013d967>] (60) [<8013dc1a>] (04) [<8013dd9b>]
(16)
  [<8013dff6>] (20) [<8013ad69>] (24) [<80133573>] (16) [<80106e93>]
(60)
Code: 83 3a 00 74 29 8b 44 24 10 50 53 8b 02 ff d0 83 c4 08 85 c0 


>>EIP; 8013d190 <cached_lookup+20/60>   <=====

>>eax; 84dc1ce0 <END_OF_CODE+175c481/????>
>>ebx; 84dc1ce0 <END_OF_CODE+175c481/????>
>>edx; 04000000 Before first symbol
>>esi; 869d5f64 <END_OF_CODE+3370705/????>
>>edi; 869d5fa4 <END_OF_CODE+3370745/????>
>>esp; 869d5f30 <END_OF_CODE+33706d1/????>

Trace; 8013d967 <link_path_walk+5d7/870>
Trace; 8013dc1a <path_walk+1a/20>
Trace; 8013dd9b <path_lookup+1b/30>
Trace; 8013dff6 <__user_walk+26/40>
Trace; 8013ad69 <sys_lstat64+19/80>
Trace; 80133573 <sys_close+43/60>
Trace; 80106e93 <system_call+33/40>

Code;  8013d190 <cached_lookup+20/60>
00000000 <_EIP>:
Code;  8013d190 <cached_lookup+20/60>   <=====
   0:   83 3a 00                  cmpl   $0x0,(%edx)   <=====
Code;  8013d193 <cached_lookup+23/60>
   3:   74 29                     je     2e <_EIP+0x2e> 8013d1be
<cached_lookup+4e/60>
Code;  8013d195 <cached_lookup+25/60>
   5:   8b 44 24 10               mov    0x10(%esp,1),%eax
Code;  8013d199 <cached_lookup+29/60>
   9:   50                        push   %eax
Code;  8013d19a <cached_lookup+2a/60>
   a:   53                        push   %ebx
Code;  8013d19b <cached_lookup+2b/60>
   b:   8b 02                     mov    (%edx),%eax
Code;  8013d19d <cached_lookup+2d/60>
   d:   ff d0                     call   *%eax
Code;  8013d19f <cached_lookup+2f/60>
   f:   83 c4 08                  add    $0x8,%esp
Code;  8013d1a2 <cached_lookup+32/60>
  12:   85 c0                     test   %eax,%eax

 <1>Unable to handle kernel paging request at virtual address 04000000
8013d190
*pde = 00000000
Oops: 0000 2.4.23aa1 #2 Wed Dec 10 21:18:59 EST 2003
CPU:    0
EIP:    0010:[<8013d190>]    Not tainted
EFLAGS: 00010206
eax: 84dc1ce0   ebx: 84dc1ce0   ecx: 00000000   edx: 04000000
esi: 815d9f64   edi: 815d9fa4   ebp: 00000008   esp: 815d9f30
ds: 0018   es: 0018   ss: 0018
Process find (pid: 11868, stackpage=815d9000)
Stack: 00000000 8013d967 84dc1960 815d9f64 00000000 815d9fa4 8340e000
00000000 
       00000008 00000008 00000000 8340e00a 00000000 8340e000 0000000a
60871e95 
       8013dc1a 8013dd9b 8340e000 8340e000 815d9fa4 8013dff6 815d8000
815d9fa4 
Call Trace:         [<8013d967>] (60) [<8013dc1a>] (04) [<8013dd9b>]
(16)
  [<8013dff6>] (20) [<8013ad69>] (24) [<80133573>] (16) [<80106e93>]
(60)
Code: 83 3a 00 74 29 8b 44 24 10 50 53 8b 02 ff d0 83 c4 08 85 c0 


>>EIP; 8013d190 <cached_lookup+20/60>   <=====

>>eax; 84dc1ce0 <END_OF_CODE+175c481/????>
>>ebx; 84dc1ce0 <END_OF_CODE+175c481/????>
>>edx; 04000000 Before first symbol
>>esi; 815d9f64 <[8390].rodata.end+1b2945/46b9e1>
>>edi; 815d9fa4 <[8390].rodata.end+1b2985/46b9e1>
>>esp; 815d9f30 <[8390].rodata.end+1b2911/46b9e1>

Trace; 8013d967 <link_path_walk+5d7/870>
Trace; 8013dc1a <path_walk+1a/20>
Trace; 8013dd9b <path_lookup+1b/30>
Trace; 8013dff6 <__user_walk+26/40>
Trace; 8013ad69 <sys_lstat64+19/80>
Trace; 80133573 <sys_close+43/60>
Trace; 80106e93 <system_call+33/40>

Code;  8013d190 <cached_lookup+20/60>
00000000 <_EIP>:
Code;  8013d190 <cached_lookup+20/60>   <=====
   0:   83 3a 00                  cmpl   $0x0,(%edx)   <=====
Code;  8013d193 <cached_lookup+23/60>
   3:   74 29                     je     2e <_EIP+0x2e> 8013d1be
<cached_lookup+4e/60>
Code;  8013d195 <cached_lookup+25/60>
   5:   8b 44 24 10               mov    0x10(%esp,1),%eax
Code;  8013d199 <cached_lookup+29/60>
   9:   50                        push   %eax
Code;  8013d19a <cached_lookup+2a/60>
   a:   53                        push   %ebx
Code;  8013d19b <cached_lookup+2b/60>
   b:   8b 02                     mov    (%edx),%eax
Code;  8013d19d <cached_lookup+2d/60>
   d:   ff d0                     call   *%eax
Code;  8013d19f <cached_lookup+2f/60>
   f:   83 c4 08                  add    $0x8,%esp
Code;  8013d1a2 <cached_lookup+32/60>
  12:   85 c0                     test   %eax,%eax

Unable to handle kernel paging request at virtual address 04000000
8013d190
*pde = 00000000
Oops: 0000 2.4.23aa1 #2 Wed Dec 10 21:18:59 EST 2003
CPU:    0
EIP:    0010:[<8013d190>]    Not tainted
EFLAGS: 00010206
eax: 84dc1ce0   ebx: 84dc1ce0   ecx: 00000000   edx: 04000000
esi: 85dd1f64   edi: 85dd1fa4   ebp: 00000008   esp: 85dd1f30
ds: 0018   es: 0018   ss: 0018
Process find (pid: 20979, stackpage=85dd1000)
Stack: 00000000 8013d967 84dc1960 85dd1f64 00000000 85dd1fa4 82912000
00000000 
       00000008 00000008 00000000 8291200a 00000000 82912000 0000000a
60871e95 
       8013dc1a 8013dd9b 82912000 82912000 85dd1fa4 8013dff6 85dd0000
85dd1fa4 
Call Trace:         [<8013d967>] (60) [<8013dc1a>] (04) [<8013dd9b>]
(16)
  [<8013dff6>] (20) [<8013ad69>] (24) [<80133573>] (16) [<80106e93>]
(60)
Code: 83 3a 00 74 29 8b 44 24 10 50 53 8b 02 ff d0 83 c4 08 85 c0 


>>EIP; 8013d190 <cached_lookup+20/60>   <=====

>>eax; 84dc1ce0 <END_OF_CODE+175c481/????>
>>ebx; 84dc1ce0 <END_OF_CODE+175c481/????>
>>edx; 04000000 Before first symbol
>>esi; 85dd1f64 <END_OF_CODE+276c705/????>
>>edi; 85dd1fa4 <END_OF_CODE+276c745/????>
>>esp; 85dd1f30 <END_OF_CODE+276c6d1/????>

Trace; 8013d967 <link_path_walk+5d7/870>
Trace; 8013dc1a <path_walk+1a/20>
Trace; 8013dd9b <path_lookup+1b/30>
Trace; 8013dff6 <__user_walk+26/40>
Trace; 8013ad69 <sys_lstat64+19/80>
Trace; 80133573 <sys_close+43/60>
Trace; 80106e93 <system_call+33/40>

Code;  8013d190 <cached_lookup+20/60>
00000000 <_EIP>:
Code;  8013d190 <cached_lookup+20/60>   <=====
   0:   83 3a 00                  cmpl   $0x0,(%edx)   <=====
Code;  8013d193 <cached_lookup+23/60>
   3:   74 29                     je     2e <_EIP+0x2e> 8013d1be
<cached_lookup+4e/60>
Code;  8013d195 <cached_lookup+25/60>
   5:   8b 44 24 10               mov    0x10(%esp,1),%eax
Code;  8013d199 <cached_lookup+29/60>
   9:   50                        push   %eax
Code;  8013d19a <cached_lookup+2a/60>
   a:   53                        push   %ebx
Code;  8013d19b <cached_lookup+2b/60>
   b:   8b 02                     mov    (%edx),%eax
Code;  8013d19d <cached_lookup+2d/60>
   d:   ff d0                     call   *%eax
Code;  8013d19f <cached_lookup+2f/60>
   f:   83 c4 08                  add    $0x8,%esp
Code;  8013d1a2 <cached_lookup+32/60>
  12:   85 c0                     test   %eax,%eax

 <1>Unable to handle kernel paging request at virtual address 04000000
8013d190
*pde = 00000000
Oops: 0000 2.4.23aa1 #2 Wed Dec 10 21:18:59 EST 2003
CPU:    0
EIP:    0010:[<8013d190>]    Not tainted
EFLAGS: 00010206
eax: 84dc1ce0   ebx: 84dc1ce0   ecx: 00000000   edx: 04000000
esi: 81c31f64   edi: 81c31fa4   ebp: 00000008   esp: 81c31f30
ds: 0018   es: 0018   ss: 0018
Process find (pid: 21202, stackpage=81c31000)
Stack: 00000000 8013d967 84dc1960 81c31f64 00000000 81c31fa4 8502c000
00000000 
       00000008 00000008 00000000 8502c00a 00000000 8502c000 0000000a
60871e95 
       8013dc1a 8013dd9b 8502c000 8502c000 81c31fa4 8013dff6 81c30000
81c31fa4 
Call Trace:         [<8013d967>] (60) [<8013dc1a>] (04) [<8013dd9b>]
(16)
  [<8013dff6>] (20) [<8013ad69>] (24) [<80133573>] (16) [<80106e93>]
(60)
Code: 83 3a 00 74 29 8b 44 24 10 50 53 8b 02 ff d0 83 c4 08 85 c0 


>>EIP; 8013d190 <cached_lookup+20/60>   <=====

>>eax; 84dc1ce0 <END_OF_CODE+175c481/????>
>>ebx; 84dc1ce0 <END_OF_CODE+175c481/????>
>>edx; 04000000 Before first symbol
>>esi; 81c31f64 <[rtc].bss.end+4e881/7591d>
>>edi; 81c31fa4 <[rtc].bss.end+4e8c1/7591d>
>>esp; 81c31f30 <[rtc].bss.end+4e84d/7591d>

Trace; 8013d967 <link_path_walk+5d7/870>
Trace; 8013dc1a <path_walk+1a/20>
Trace; 8013dd9b <path_lookup+1b/30>
Trace; 8013dff6 <__user_walk+26/40>
Trace; 8013ad69 <sys_lstat64+19/80>
Trace; 80133573 <sys_close+43/60>
Trace; 80106e93 <system_call+33/40>

Code;  8013d190 <cached_lookup+20/60>
00000000 <_EIP>:
Code;  8013d190 <cached_lookup+20/60>   <=====
   0:   83 3a 00                  cmpl   $0x0,(%edx)   <=====
Code;  8013d193 <cached_lookup+23/60>
   3:   74 29                     je     2e <_EIP+0x2e> 8013d1be
<cached_lookup+4e/60>
Code;  8013d195 <cached_lookup+25/60>
   5:   8b 44 24 10               mov    0x10(%esp,1),%eax
Code;  8013d199 <cached_lookup+29/60>
   9:   50                        push   %eax
Code;  8013d19a <cached_lookup+2a/60>
   a:   53                        push   %ebx
Code;  8013d19b <cached_lookup+2b/60>
   b:   8b 02                     mov    (%edx),%eax
Code;  8013d19d <cached_lookup+2d/60>
   d:   ff d0                     call   *%eax
Code;  8013d19f <cached_lookup+2f/60>
   f:   83 c4 08                  add    $0x8,%esp
Code;  8013d1a2 <cached_lookup+32/60>
  12:   85 c0                     test   %eax,%eax

Linux version 2.4.23aa1 (shane@carl) (gcc version 2.95.4 20011002
(Debian prerelease)) #2 Wed Dec 10 21:18:59 EST 2003
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 0000000009ffc000 (usable)
 BIOS-e820: 0000000009ffc000 - 0000000009fff000 (ACPI data)
 BIOS-e820: 0000000009fff000 - 000000000a000000 (ACPI NVS)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
159MB LOWMEM available.
On node 0 totalpages: 40956
zone(0): 4096 pages.
zone(1): 36860 pages.
zone(2): 0 pages.
Building zonelist for node : 0
Kernel command line: auto BOOT_IMAGE=2.4.23aa1 ro root=301
Initializing CPU#0
Detected 467.739 MHz processor.
Console: colour VGA+ 80x25
Calibrating delay loop... 933.88 BogoMIPS
Memory: 159664k/163824k available (1162k kernel code, 3776k reserved,
487k data, 64k init, 0k highmem)
Dentry cache hash table entries: 32768 (order: 6, 262144 bytes)
Inode cache hash table entries: 16384 (order: 5, 131072 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 65536 (order: 6, 262144 bytes)
CPU: L1 I cache: 16K, L1 D cache: 16K
CPU: L2 cache: 128K
CPU:     After generic, caps: 0183f9ff 00000000 00000000 00000000
CPU:             Common caps: 0183f9ff 00000000 00000000 00000000
CPU: Intel Celeron (Mendocino) stepping 05
Enabling fast FPU save and restore... done.
Checking 'hlt' instruction... OK.
POSIX conformance testing by UNIFIX
PCI: PCI BIOS revision 2.10 entry at 0xf08b0, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Using IRQ router PIIX/ICH [8086/7110] at 00:04.0
Limiting direct PCI/PCI transfers.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
bigpage subsystem: allocated 0 bigpages (=0MB).
aio_setup: num_physpages = 10239
aio_setup: sizeof(struct page) = 44
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
Detected PS/2 Mouse Port.
pty: 512 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
floppy0: no floppy controllers found
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
PIIX4: IDE controller at PCI slot 00:04.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xb800-0xb807, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xb808-0xb80f, BIOS settings: hdc:pio, hdd:pio
hda: ST340014A, ATA DISK drive
blk: queue 802e8380, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=4865/255/63,
UDMA(33)
Partition check:
 hda: hda1 hda2 < hda5 hda6 hda7 hda8 hda9 >
Initializing Cryptographic API
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
Linux IP multicast router 0.06 plus PIM-SM
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 64k freed
Adding Swap: 497972k swap-space (priority -1)
ne.c:v1.10 9/23/94 Donald Becker (becker@scyld.com)
Last modified Nov 1, 2000 by Paul Gortmaker
NE*000 ethercard probe at 0x300: 00 20 18 32 65 fc
eth0: NE2000 found at 0x300, using IRQ 11.
NE*000 ethercard probe at 0x280: 00 00 e8 42 6d 5d
eth1: NE2000 found at 0x280, using IRQ 5.
Real Time Clock Driver v1.10e

Regards,

Shane




