Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131256AbQLUSFW>; Thu, 21 Dec 2000 13:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131283AbQLUSFM>; Thu, 21 Dec 2000 13:05:12 -0500
Received: from mta06-svc.ntlworld.com ([62.253.162.46]:30696 "EHLO
	mta06-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S131256AbQLUSFE>; Thu, 21 Dec 2000 13:05:04 -0500
From: ianh@iahastie.clara.net (Ian Hastie)
To: linux-kernel@vger.kernel.org
Date: Thu, 21 Dec 2000 17:27:48 +0000 (UTC)
Subject: Oop in 2.4.0-test12
Organization: home using Linux
Message-ID: <slrn944fck.hdt.ianh@iahastie.local.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like page_launder is still causing problems.  I was using
ReiserFS version 3.6.23.  As far as I remember it was running
Seti@Home 3.03 and compile qt-2.2.3.  I was able to run ksymoops
without rebooting.

ksymoops 2.3.5 on i686 2.4.0-test12.  Options used
     -v /boot/vmlinux-2.4.0-test12 (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test12/ (default)
     -m /boot/System.map-2.4.0-test12 (specified)

Unable to handle kernel NULL pointer dereference at virtual address 0000000c
c012cf63
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c012cf63>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00000000   ebx: c1097d0c   ecx: 000004ba   edx: 00000002
esi: c1097cf0   edi: 00003a33   ebp: 00000000   esp: c1479fb4
ds: 0018   es: 0018   ss: 0018
Process bdflush (pid: 6, stackpage=c1479000)
Stack: c1478000 c027703c 00000000 0008e000 00000000 c1478000 00000000 00003a32 
       00000000 c01361bd 00000003 00000000 00010f00 c145ff8c c145ffd8 c0109043 
       c145ffc4 c145ffc4 c145ffc4 
Call Trace: [<c01361bd>] [<c0109043>] 
Code: 8b 40 0c 8b 10 85 d2 0f 84 85 04 00 00 83 7c 24 18 00 75 4e 

>>EIP; c012cf63 <page_launder+1d3/800>   <=====
Trace; c01361bd <bdflush+8d/120>
Trace; c0109043 <kernel_thread+23/30>
Code;  c012cf63 <page_launder+1d3/800>
00000000 <_EIP>:
Code;  c012cf63 <page_launder+1d3/800>   <=====
   0:   8b 40 0c                  mov    0xc(%eax),%eax   <=====
Code;  c012cf66 <page_launder+1d6/800>
   3:   8b 10                     mov    (%eax),%edx
Code;  c012cf68 <page_launder+1d8/800>
   5:   85 d2                     test   %edx,%edx
Code;  c012cf6a <page_launder+1da/800>
   7:   0f 84 85 04 00 00         je     492 <_EIP+0x492> c012d3f5 <page_launder+665/800>
Code;  c012cf70 <page_launder+1e0/800>
   d:   83 7c 24 18 00            cmpl   $0x0,0x18(%esp,1)
Code;  c012cf75 <page_launder+1e5/800>
  12:   75 4e                     jne    62 <_EIP+0x62> c012cfc5 <page_launder+235/800>

-- 
Ian.

I don't have a sig either!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
