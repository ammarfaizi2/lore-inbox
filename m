Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265079AbSJaBPE>; Wed, 30 Oct 2002 20:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265083AbSJaBPE>; Wed, 30 Oct 2002 20:15:04 -0500
Received: from n1x6.imsa.edu ([143.195.1.6]:45462 "EHLO mail.imsa.edu")
	by vger.kernel.org with ESMTP id <S265079AbSJaBPD>;
	Wed, 30 Oct 2002 20:15:03 -0500
Date: Wed, 30 Oct 2002 19:21:28 -0600
From: Maciej Babinski <maciej@imsa.edu>
To: linux-kernel@vger.kernel.org
Subject: 2.5.44 networking crash
Message-ID: <20021030192128.A18328@imsa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found the following oops on my console when I got home tonight.

ksymoops 2.4.6 on i586 2.5.44.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.44/ (default)
     -m /kernel/System.map-2.5.44 (specified)

kernel BUG at net/core/skbuff.c:177!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c01d15c4>]  Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 0000003a   ebx: c42dd080     ecx: 00000000       edx: c024cbbc
esi: 000001d0   edi: 00000000     ebp: 00000018       esp: c0e65e94
ds: 0068        es: 0068       ss:0068
Stack: c0239940 c01d09b4 c42dd080 c42dd4a0 c01d09b4 00000001 000001d0 00000000
       c020f347 c42dd080 00000001 00000000 000001d0 7fffffff c42dd080 fffffff4
       c0e65f00 c3a80bc0 c0e65f00 0000006e bffff788 c01cf386 c3a80bc0 c0e65f00
Call Trace: [<c01d09b4>] [<c01d09b4>] [<c020f347>] [<c01cf386>] [<c01cfc2b>] [<c0107357>]
Code: 0f 0b b1 00 e3 98 23 c0 5b 58 e9 6f fe ff ff 90 8d b6 00 00


>>EIP; c01d15c4 <alloc_skb+1b4/1d0>   <=====

>>ebx; c42dd080 <_end+3ff5dcc/651adac>
>>edx; c024cbbc <log_wait+0/8>
>>esp; c0e65e94 <_end+b7ebe0/651adac>

Trace; c01d09b4 <sock_wmalloc+24/50>
Trace; c01d09b4 <sock_wmalloc+24/50>
Trace; c020f347 <unix_stream_connect+97/350>
Trace; c01cf386 <sys_connect+56/80>
Trace; c01cfc2b <sys_socketcall+8b/1b0>
Trace; c0107357 <syscall_call+7/b>

Code;  c01d15c4 <alloc_skb+1b4/1d0>
00000000 <_EIP>:
Code;  c01d15c4 <alloc_skb+1b4/1d0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01d15c6 <alloc_skb+1b6/1d0>
   2:   b1 00                     mov    $0x0,%cl
Code;  c01d15c8 <alloc_skb+1b8/1d0>
   4:   e3 98                     jecxz  ffffff9e <_EIP+0xffffff9e> c01d1562 <alloc_skb+152/1d0>
Code;  c01d15ca <alloc_skb+1ba/1d0>
   6:   23 c0                     and    %eax,%eax
Code;  c01d15cc <alloc_skb+1bc/1d0>
   8:   5b                        pop    %ebx
Code;  c01d15cd <alloc_skb+1bd/1d0>
   9:   58                        pop    %eax
Code;  c01d15ce <alloc_skb+1be/1d0>
   a:   e9 6f fe ff ff            jmp    fffffe7e <_EIP+0xfffffe7e> c01d1442 <alloc_skb+32/1d0>
Code;  c01d15d3 <alloc_skb+1c3/1d0>
   f:   90                        nop    
Code;  c01d15d4 <alloc_skb+1c4/1d0>
  10:   8d b6 00 00 00 00         lea    0x0(%esi),%esi

 <0>Kernel panic: Aiee, killing interrupt handler!
