Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276877AbRKIDBg>; Thu, 8 Nov 2001 22:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277782AbRKIDB0>; Thu, 8 Nov 2001 22:01:26 -0500
Received: from lorica.ucc.usyd.edu.au ([129.78.64.15]:57298 "EHLO
	lorica.ucc.usyd.edu.au") by vger.kernel.org with ESMTP
	id <S276877AbRKIDBW>; Thu, 8 Nov 2001 22:01:22 -0500
Date: Fri, 9 Nov 2001 14:01:19 +1100 (EST)
From: Michael Chapman <mchapman@beren.hn.org>
Reply-To: Michael Chapman <mchapman@student.usyd.edu.au>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Oops in kmem_cache_free with 2.4.14
Message-ID: <Pine.LNX.4.33.0111091355540.21862-100000@beren.hn.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I got this oops in oops while loading mozilla. It killed my X session, but 
the box appears to be running stable again. I haven't been able to 
reproduce it.

My kernel is non-SMP 2.4.14 with the ext3 patches.

ksymoops 2.4.1 on i686 2.4.14.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.14/ (default)
     -m /boot/System.map-2.4.14 (specified)

Unable to handle kernel paging request at virtual address cfa5b04c
c0128478
*pde = 0f8001b9
Oops: 0003
CPU:    0
EIP:    0010:[kmem_cache_free+56/160]    Not tainted
EIP:    0010:[<c0128478>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210006
eax: 00000000   ebx: c1607360   ecx: cfa5b030   edx: 00000000
esi: 00200086   edi: 00000001   ebp: 0000000e   esp: d4e05ed8
ds: 0018   es: 0018   ss: 0018
Process X (pid: 2186, stackpage=d4e05000)
Stack: 0000000e d4e04568 cfa5b178 d4e05f50 c011c063 c1607360 cfa5b154 
d4e04000 
       0000000e d4e04000 d4e05f30 c011c11d 0000000e d4e04568 d4e05f30 
d4e04000 
       00000000 c01069b9 d4e04560 d4e05f30 d4e04560 d4e05fc4 0000000e 
00000000 
Call Trace: [collect_signal+147/224] [dequeue_signal+109/176] 
[do_signal+89/672] [process_timeout+0/80] [process_timeout+0/80] 
Call Trace: [<c011c063>] [<c011c11d>] [<c01069b9>] [<c0111900>] 
[<c0111900>] 
   [<c011b9f3>] [<c0111c51>] [<c0106d24>] 
Code: 89 44 b9 18 89 79 14 8b 51 10 8d 42 ff 89 41 10 85 c0 75 24 

>>EIP; c0128478 <kmem_cache_free+38/a0>   <=====
Trace; c011c063 <collect_signal+93/e0>
Trace; c011c11d <dequeue_signal+6d/b0>
Trace; c01069b9 <do_signal+59/2a0>
Trace; c0111900 <process_timeout+0/50>
Trace; c0111900 <process_timeout+0/50>
Trace; c011b9f3 <timer_bh+213/250>
Trace; c0111c51 <schedule+251/390>
Trace; c0106d24 <signal_return+14/18>
Code;  c0128478 <kmem_cache_free+38/a0>
00000000 <_EIP>:
Code;  c0128478 <kmem_cache_free+38/a0>   <=====
   0:   89 44 b9 18               mov    %eax,0x18(%ecx,%edi,4)   <=====
Code;  c012847c <kmem_cache_free+3c/a0>
   4:   89 79 14                  mov    %edi,0x14(%ecx)
Code;  c012847f <kmem_cache_free+3f/a0>
   7:   8b 51 10                  mov    0x10(%ecx),%edx
Code;  c0128482 <kmem_cache_free+42/a0>
   a:   8d 42 ff                  lea    0xffffffff(%edx),%eax
Code;  c0128485 <kmem_cache_free+45/a0>
   d:   89 41 10                  mov    %eax,0x10(%ecx)
Code;  c0128488 <kmem_cache_free+48/a0>
  10:   85 c0                     test   %eax,%eax
Code;  c012848a <kmem_cache_free+4a/a0>
  12:   75 24                     jne    38 <_EIP+0x38> c01284b0 
<kmem_cache_free+70/a0>


Michael

