Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312560AbSFFXSJ>; Thu, 6 Jun 2002 19:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312619AbSFFXSJ>; Thu, 6 Jun 2002 19:18:09 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:61939 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S312560AbSFFXSI>;
	Thu, 6 Jun 2002 19:18:08 -0400
Date: Thu, 06 Jun 2002 16:18:01 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Panic from 2.4.19-pre9-aa2
Message-ID: <99570000.1023405481@flay>
In-Reply-To: <20020606212028.GA1004@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> not really sure what could be the problem, it would be interesting to
> see if you can reproduce it. 

Yup, do 2 or 3 kernel compiles and it crashes again. Here's a slightly
different oops:

Unable to handle kernel NULL pointer dereference at virtual address 00000282
c0117feb
*pde = 00000000
Oops: 0000
CPU:    6
EIP:    0010:[<c0117feb>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: c6369f6c   ebx: 00000282   ecx: c029a488   edx: c4ff5b24
esi: c4ff5b20   edi: 00000282   ebp: c6227f70   esp: c6227f54
ds: 0018   es: 0018   ss: 0018
Process cpp (pid: 16679, stackpage=c6227000)
Stack: 00001000 c4ff5b20 c5773180 00000001 c4ff5b24 00000282 00000001 000526a9 
       c0148311 00000000 ffffffea c5eab160 000536a9 c6526000 c6226000 c57731ec 
       00001000 00001000 c013ead7 c5eab160 4011000c 000536a9 c5eab180 c6226000 
Call Trace: [<c0148311>] [<c013ead7>] [<c0108a7b>] 
Code: 8b 3b 0f 18 07 3b 5d f4 75 d0 c6 06 01 ff 75 f8 9d 8d 74 26 

>>EIP; c0117fea <__wake_up+5a/7c>   <=====
Trace; c0148310 <pipe_write+1bc/294>
Trace; c013ead6 <sys_write+8e/100>
Trace; c0108a7a <system_call+2e/34>
Code;  c0117fea <__wake_up+5a/7c>
00000000 <_EIP>:
Code;  c0117fea <__wake_up+5a/7c>   <=====
   0:   8b 3b                     mov    (%ebx),%edi   <=====
Code;  c0117fec <__wake_up+5c/7c>
   2:   0f 18 07                  prefetchnta (%edi)
Code;  c0117fee <__wake_up+5e/7c>
   5:   3b 5d f4                  cmp    0xfffffff4(%ebp),%ebx
Code;  c0117ff2 <__wake_up+62/7c>
   8:   75 d0                     jne    ffffffda <_EIP+0xffffffda> c0117fc4 <__
wake_up+34/7c>
Code;  c0117ff4 <__wake_up+64/7c>
   a:   c6 06 01                  movb   $0x1,(%esi)
Code;  c0117ff6 <__wake_up+66/7c>
   d:   ff 75 f8                  pushl  0xfffffff8(%ebp)
Code;  c0117ffa <__wake_up+6a/7c>
  10:   9d                        popf   
Code;  c0117ffa <__wake_up+6a/7c>
  11:   8d 74 26 00               lea    0x0(%esi,1),%esi

> Also if for example you enabled numa-q you
> may want to try to disable it and see if w/o discontigmem the problem
> goes away, if we could isolate it to a config option, it would help a lot.

OK, will see if I can do that - I'm out for a few days, so it may be next
Tuesday before I can do this

M.
