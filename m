Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261859AbSJIRcV>; Wed, 9 Oct 2002 13:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261862AbSJIRcV>; Wed, 9 Oct 2002 13:32:21 -0400
Received: from tailtiu.davidcoulson.net ([194.159.156.4]:37553 "EHLO
	mail.mx.davidcoulson.net") by vger.kernel.org with ESMTP
	id <S261859AbSJIRcQ>; Wed, 9 Oct 2002 13:32:16 -0400
Message-ID: <3DA46975.2060200@davidcoulson.net>
Date: Wed, 09 Oct 2002 18:37:57 +0100
From: David Coulson <david@davidcoulson.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020723
X-Accept-Language: en-gb
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: user-mode-linux-devel@lists.sourceforge.net
Subject: kernel BUG in page_alloc.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel: 2.4.19-pre9

My system is purely used as a host for UML installations, and the 
following occured after around 5 days uptime under reasonable load for 
much of that time.

kernel BUG at page_alloc.c:102!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0135dc3>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: c17130dc   ebx: c194d5d0   ecx: c194d5ec   edx: c18a459c
esi: c02a9a60   edi: 00000000   ebp: 00000000   esp: e35e1e3c
ds: 0018   es: 0018   ss: 0018
Process linux-12um (pid: 29284, stackpage=e35e1000)
Stack: 00000000 f7ee6000 00000292 f0959ea0 9bd5c000 c194d5d0 00000001 
9ca49000
        00000001 00000001 9ca49000 00000001 c0129351 c194d5d0 ca4e79c8 
9ca48000
        00001000 9ce48000 c030bda0 00000001 9ca49000 ca4e79cc c0f3e320 
00001000
Call Trace:    [<c0129351>] [<c012c5c0>] [<c011805b>] [<c011d574>] 
[<c0123a93>]
   [<c0123ca4>] [<c0107432>] [<c01fc03e>] [<c01fc03e>] [<c013e1a9>] 
[<c0107780>]
Code: 0f 0b 66 00 da 01 28 c0 8b 0d d0 f9 32 c0 89 d8 29 c8 c1 f8


 >>EIP; c0135dc3 <kmem_find_general_cachep+1ff3/24b0>   <=====

 >>eax; c17130dc <___strtok+13af39c/3849e320>
 >>ebx; c194d5d0 <___strtok+15e9890/3849e320>
 >>ecx; c194d5ec <___strtok+15e98ac/3849e320>
 >>edx; c18a459c <___strtok+154085c/3849e320>
 >>esi; c02a9a60 <vm_min_readahead+2d8/9d8>
 >>esp; e35e1e3c <___strtok+2327e0fc/3849e320>

Trace; c0129351 <flush_scheduled_tasks+ae1/b90>
Trace; c012c5c0 <do_brk+360/6d0>
Trace; c011805b <remove_wait_queue+38b/1770>
Trace; c011d574 <exit_mm+454/690>
Trace; c0123a93 <exit_sighand+193/1a0>
Trace; c0123ca4 <dequeue_signal+64/540>
Trace; c0107432 <__read_lock_failed+112e/182c>
Trace; c01fc03e <sock_recvmsg+24e/8d0>
Trace; c01fc03e <sock_recvmsg+24e/8d0>
Trace; c013e1a9 <default_llseek+4f9/f40>
Trace; c0107780 <__read_lock_failed+147c/182c>

Code;  c0135dc3 <kmem_find_general_cachep+1ff3/24b0>
00000000 <_EIP>:
Code;  c0135dc3 <kmem_find_general_cachep+1ff3/24b0>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  c0135dc5 <kmem_find_general_cachep+1ff5/24b0>
    2:   66                        data16
Code;  c0135dc6 <kmem_find_general_cachep+1ff6/24b0>
    3:   00 da                     add    %bl,%dl
Code;  c0135dc8 <kmem_find_general_cachep+1ff8/24b0>
    5:   01 28                     add    %ebp,(%eax)
Code;  c0135dca <kmem_find_general_cachep+1ffa/24b0>
    7:   c0 8b 0d d0 f9 32 c0      rorb   $0xc0,0x32f9d00d(%ebx)
Code;  c0135dd1 <kmem_find_general_cachep+2001/24b0>
    e:   89 d8                     mov    %ebx,%eax
Code;  c0135dd3 <kmem_find_general_cachep+2003/24b0>
   10:   29 c8                     sub    %ecx,%eax
Code;  c0135dd5 <kmem_find_general_cachep+2005/24b0>
   12:   c1 f8 00                  sar    $0x0,%eax



David

-- 
David Coulson                                  http://davidcoulson.net/
d@vidcoulson.com                       http://journal.davidcoulson.net/

