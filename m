Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbUABBcJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 20:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbUABBcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 20:32:09 -0500
Received: from hell.org.pl ([212.244.218.42]:33285 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S262129AbUABBbA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 20:31:00 -0500
Date: Fri, 2 Jan 2004 02:31:06 +0100
From: Karol Kozimor <sziwan@hell.org.pl>
To: linux-kernel@vger.kernel.org
Subject: [2.4.23] Oops at cached_lookup
Message-ID: <20040102013105.GA16235@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2 consecutive oopses, one approx. 16 hours after another. The machine is a
P200MMX with only IDE, if that matters. The kernel is a 2.4.23 with
grsecurity-1.9.13-2.4.23 patch applied. I'll bve happy to provide more
info.
Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl

Unable to handle kernel paging request at virtual address 40000000
c01bc9bf
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01bc9bf>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 40000000   ebx: c431a340   ecx: 00000008   edx: c6197f50
esi: c5909013   edi: 00000000   ebp: c6197f98   esp: c6197f30
ds: 0018   es: 0018   ss: 0018
Process updatedb (pid: 9082, stackpage=c6197000)
Stack: c5909000 c01bcf5a c281e3e0 c6197f50 00000000 00000008 c2836060 00000000 
       c5909000 00000013 7a947b43 00000008 c6197f98 c5909000 00000000 00000008 
       c01bd441 c5909000 c5909000 c6197f98 c01bd66a c6196000 c6197f98 5dab9280 
Call Trace:    [<c01bcf5a>] [<c01bd441>] [<c01bd66a>] [<c01b9c77>] [<c0188303>]
Code: 8b 00 85 c0 75 0b 89 d8 5b c3 8d b4 26 00 00 00 00 8b 4c 24 


>>EIP; c01bc9bf <cached_lookup+1f/60>   <=====

>>ebx; c431a340 <_end+4038b28/870c848>
>>edx; c6197f50 <_end+5eb6738/870c848>
>>esi; c5909013 <_end+56277fb/870c848>
>>ebp; c6197f98 <_end+5eb6780/870c848>
>>esp; c6197f30 <_end+5eb6718/870c848>

Trace; c01bcf5a <link_path_walk+3aa/700>
Trace; c01bd441 <path_lookup+21/30>
Trace; c01bd66a <__user_walk+2a/40>
Trace; c01b9c77 <sys_lstat64+17/70>
Trace; c0188303 <system_call+33/40>

Code;  c01bc9bf <cached_lookup+1f/60>
00000000 <_EIP>:
Code;  c01bc9bf <cached_lookup+1f/60>   <=====
   0:   8b 00                     mov    (%eax),%eax   <=====
Code;  c01bc9c1 <cached_lookup+21/60>
   2:   85 c0                     test   %eax,%eax
Code;  c01bc9c3 <cached_lookup+23/60>
   4:   75 0b                     jne    11 <_EIP+0x11>
Code;  c01bc9c5 <cached_lookup+25/60>
   6:   89 d8                     mov    %ebx,%eax
Code;  c01bc9c7 <cached_lookup+27/60>
   8:   5b                        pop    %ebx
Code;  c01bc9c8 <cached_lookup+28/60>
   9:   c3                        ret    
Code;  c01bc9c9 <cached_lookup+29/60>
   a:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi
Code;  c01bc9d0 <cached_lookup+30/60>
  11:   8b 4c 24 00               mov    0x0(%esp,1),%ecx

 <1>Unable to handle kernel paging request at virtual address 40000000
c01bc9bf
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01bc9bf>]    Not tainted
EFLAGS: 00010206
eax: 40000000   ebx: c431a340   ecx: 00000008   edx: c32c3f1c
esi: c1e27034   edi: 00000000   ebp: c32c3f84   esp: c32c3efc
ds: 0018   es: 0018   ss: 0018
Process mutt (pid: 2149, stackpage=c32c3000)
Stack: c1e27021 c01bcf5a c281e3e0 c32c3f1c 00000000 00000001 c2836060 00000000 
       c1e27021 00000013 7a947b43 264b1000 c32c3f84 c1e27000 00000000 59b04368 
       c01bd441 00000000 00000001 c32c3f84 c01bd804 c1167cfc 00000000 00000004 
Call Trace:    [<c01bcf5a>] [<c01bd441>] [<c01bd804>] [<c01a4307>] [<c01b21d4>]
  [<c01b254b>] [<c0188303>]
Code: 8b 00 85 c0 75 0b 89 d8 5b c3 8d b4 26 00 00 00 00 8b 4c 24 


>>EIP; c01bc9bf <cached_lookup+1f/60>   <=====

>>ebx; c431a340 <_end+4038b28/870c848>
>>edx; c32c3f1c <_end+2fe2704/870c848>
>>esi; c1e27034 <_end+1b4581c/870c848>
>>ebp; c32c3f84 <_end+2fe276c/870c848>
>>esp; c32c3efc <_end+2fe26e4/870c848>

Trace; c01bcf5a <link_path_walk+3aa/700>
Trace; c01bd441 <path_lookup+21/30>
Trace; c01bd804 <open_namei+74/760>
Trace; c01a4307 <do_munmap+1d7/2b0>
Trace; c01b21d4 <filp_open+34/60>
Trace; c01b254b <sys_open+3b/80>
Trace; c0188303 <system_call+33/40>

Code;  c01bc9bf <cached_lookup+1f/60>
00000000 <_EIP>:
Code;  c01bc9bf <cached_lookup+1f/60>   <=====
   0:   8b 00                     mov    (%eax),%eax   <=====
Code;  c01bc9c1 <cached_lookup+21/60>
   2:   85 c0                     test   %eax,%eax
Code;  c01bc9c3 <cached_lookup+23/60>
   4:   75 0b                     jne    11 <_EIP+0x11>
Code;  c01bc9c5 <cached_lookup+25/60>
   6:   89 d8                     mov    %ebx,%eax
Code;  c01bc9c7 <cached_lookup+27/60>
   8:   5b                        pop    %ebx
Code;  c01bc9c8 <cached_lookup+28/60>
   9:   c3                        ret    
Code;  c01bc9c9 <cached_lookup+29/60>
   a:   8d b4 26 00 00 00 00      lea    0x0(%esi,1),%esi
Code;  c01bc9d0 <cached_lookup+30/60>
  11:   8b 4c 24 00               mov    0x0(%esp,1),%ecx

