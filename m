Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262472AbSKMUIV>; Wed, 13 Nov 2002 15:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262457AbSKMUIV>; Wed, 13 Nov 2002 15:08:21 -0500
Received: from n1x6.imsa.edu ([143.195.1.6]:20893 "EHLO mail.imsa.edu")
	by vger.kernel.org with ESMTP id <S262807AbSKMUIO>;
	Wed, 13 Nov 2002 15:08:14 -0500
Date: Wed, 13 Nov 2002 14:15:07 -0600
From: Maciej Babinski <maciej@imsa.edu>
To: linux-kernel@vger.kernel.org
Subject: BUG at net/core/skbuff.c
Message-ID: <20021113141506.A24428@imsa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I sporadically get this crash while running "arp" under both 2.5.46
and 2.5.47.

ksymoops 2.4.6 on i586 2.5.47.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.47/ (default)
     -m /usr/src/linux/System.map (default)

kernel BUG at net/core/skbuff.c:178!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c01d1be7>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 0000003a   ebx: c3e54ce0     ecx: 00000000       edx: c024c69c
esi: 000001d0   edi: 00000000     ebp: 00000018       esp: c055de94
ds: 0068        es: 0068       ss: 0068
Stack: c023df60 c01d1044 c3e54ce0 c3e548c0 c01d1044 00000001 000001d0 00000000
       c0214497 c3e54ce0 00000001 00000000 000001d0 7fffffff c3e54ce0 fffffff4
       c3743620 c3743620 c055df00 0000006e bfffeda8 c01cfa46 c3743620 c055df00
Call Trace: [<c01d1044>] [<c01d1044>] [<c0214497>] [<c01cfa46>] [<c01894d2>] [<c01d02fb>] [<c0108d67>]
Code: 0f 0b b2 00 c7 d2 23 c0 5b 58 e9 6c fe ff ff 8d 76 00 8d bc


>>EIP; c01d1be7 <alloc_skb+1b7/1d0>   <=====

>>ebx; c3e54ce0 <_end+3b7772c/6524aac>
>>edx; c024c69c <log_wait+0/8>
>>esp; c055de94 <_end+2808e0/6524aac>

Trace; c01d1044 <sock_wmalloc+24/50>
Trace; c01d1044 <sock_wmalloc+24/50>
Trace; c0214497 <unix_stream_connect+97/340>
Trace; c01cfa46 <sys_connect+56/80>
Trace; c01894d2 <copy_from_user+32/3c>
Trace; c01d02fb <sys_socketcall+8b/1b0>
Trace; c0108d67 <syscall_call+7/b>

Code;  c01d1be7 <alloc_skb+1b7/1d0>
00000000 <_EIP>:
Code;  c01d1be7 <alloc_skb+1b7/1d0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01d1be9 <alloc_skb+1b9/1d0>
   2:   b2 00                     mov    $0x0,%dl
Code;  c01d1beb <alloc_skb+1bb/1d0>
   4:   c7 d2 23 c0 5b 58         mov    $0x585bc023,%edx
Code;  c01d1bf1 <alloc_skb+1c1/1d0>
   a:   e9 6c fe ff ff            jmp    fffffe7b <_EIP+0xfffffe7b> c01d1a62 <alloc_skb+32/1d0>
Code;  c01d1bf6 <alloc_skb+1c6/1d0>
   f:   8d 76 00                  lea    0x0(%esi),%esi
Code;  c01d1bf9 <alloc_skb+1c9/1d0>
  12:   8d bc 00 00 00 00 00      lea    0x0(%eax,%eax,1),%edi

 <0>Kernel Panic: Aiee, killing interrupt handler!
