Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265424AbRFVODv>; Fri, 22 Jun 2001 10:03:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265420AbRFVODl>; Fri, 22 Jun 2001 10:03:41 -0400
Received: from mta05-svc.ntlworld.com ([62.253.162.45]:45804 "EHLO
	mta05-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S265424AbRFVODZ>; Fri, 22 Jun 2001 10:03:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Gav <gavbaker@ntlworld.com>
To: linux-kernel@vger.kernel.org
Subject: ac17 "kernel BUG at slab.c:1244!" 
Date: Fri, 22 Jun 2001 15:01:43 +0000
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01062215014300.01814@box.penguin.power>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The first occurrence of this I didn't even notice until i checked my logs. 

kernel BUG at slab.c:1244!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0126850>]
EFLAGS: 00010082
eax: 0000001b   ebx: c187f788   ecx: 00000001   edx: 00002765
esi: d9a5f000   edi: d9a5f9aa   ebp: 00012800   esp: d9fcbda4
ds: 0018   es: 0018   ss: 0018
Process kdeinit (pid: 993, stackpage=d9fcb000)
Stack: c023d5c5 000004dc d9a5f000 00001000 d9a5f9aa 00000246 ca0fe000 00000282
       d9fcbf5c 000004c8 dfa43128 00000007 d9fca000 00000002 c01f47d7 0000087c
       00000007 d9dbef40 00000000 c01f3ed5 00000840 00000007 00000000 00000810
Call Trace: [<c01f47d7>] [<c01f3ed5>] [<c0223ab7>] [<c01f1beb>] [<c01f1f23>]
   [<c01f1faa>] [<c012e4e1>] [<c0126d9c>] [<c013c988>] [<c012e651>] 
[<c0106ca7>]
 
 
Code: 0f 0b 5d 8b 6b 10 58 81 e5 00 04 00 00 74 4b b8 a5 c2 0f 17

>>EIP; c0126850 <kmalloc+140/1e0>   <=====
Trace; c01f47d7 <alloc_skb+d7/310>
Trace; c01f3ed5 <sock_alloc_send_skb+85/f0>
Trace; c0223ab7 <ip_rt_ioctl+3a67/5110>
Trace; c01f1beb <sock_sendmsg+6b/90>
Trace; c01f1f23 <sock_recvmsg+313/5b0>
Trace; c01f1faa <sock_recvmsg+39a/5b0>
Trace; c012e4e1 <default_llseek+501/9c0>
Trace; c0126d9c <kfree+1ec/290>
Trace; c013c988 <__pollwait+838/1040>
Trace; c012e651 <default_llseek+671/9c0>
Trace; c0106ca7 <__up_wakeup+10fb/23f4>
Code;  c0126850 <kmalloc+140/1e0>
00000000 <_EIP>:
Code;  c0126850 <kmalloc+140/1e0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0126852 <kmalloc+142/1e0>
   2:   5d                        pop    %ebp
Code;  c0126853 <kmalloc+143/1e0>
   3:   8b 6b 10                  mov    0x10(%ebx),%ebp
Code;  c0126856 <kmalloc+146/1e0>
   6:   58                        pop    %eax
Code;  c0126857 <kmalloc+147/1e0>
   7:   81 e5 00 04 00 00         and    $0x400,%ebp
Code;  c012685d <kmalloc+14d/1e0>
   d:   74 4b                     je     5a <_EIP+0x5a> c01268aa 
<kmalloc+19a/1e0>
Code;  c012685f <kmalloc+14f/1e0>
   f:   b8 a5 c2 0f 17            mov    $0x170fc2a5,%eax
 
 
1 warning and 1 error issued.  Results may not be reliable.




This second one was immediately after rebooting, and hard locked at getty.

kernel BUG at slab.c:1244!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0126850>]
EFLAGS: 00010082
eax: 0000001b   ebx: c187f788   ecx: 00000001   edx: 00002704
esi: dfa5c000   edi: dfa5c9aa   ebp: 00012800   esp: da801e2c
ds: 0018   es: 0018   ss: 0018
Process mingetty (pid: 811, stackpage=da801000)
Stack: c023d5c5 000004dc dfa5c000 00001000 dfa5c9aa 00000246 00000007 00000001
       dfa5c000 c0230b4a c030a2e0 00000006 00000406 00000000 c01931dd 00000c3c
       00000007 00000406 c0193e48 c198df88 00000005 00000000 00000000 dfa5d000
Call Trace: [<c0230b4a>] [<c01931dd>] [<c0193e48>] [<c0126d9c>] [<c019485e>]
   [<c012e932>] [<c010fd26>] [<c012eac6>] [<c012db40>] [<c012da69>] 
[<c0137c5a>]
   [<c012dd43>] [<c0106ca7>]
 
Code: 0f 0b 5d 8b 6b 10 58 81 e5 00 04 00 00 74 4b b8 a5 c2 0f 17

>>EIP; c0126850 <kmalloc+140/1e0>   <=====
Trace; c0230b4a <_mmx_memcpy+fa/260>
Trace; c01931dd <parport_pc_unregister_port+a5d/b90>
Trace; c0193e48 <tty_hung_up_p+588/1d30>
Trace; c0126d9c <kfree+1ec/290>
Trace; c019485e <tty_hung_up_p+f9e/1d30>
Trace; c012e932 <default_llseek+952/9c0>
Trace; c010fd26 <do_BUG+246/740>
Trace; c012eac6 <unregister_chrdev+96/a0>
Trace; c012db40 <dentry_open+c0/140>
Trace; c012da69 <filp_open+49/60>
Trace; c0137c5a <getname+5a/a0>
Trace; c012dd43 <get_unused_fd+183/220>
Trace; c0106ca7 <__up_wakeup+10fb/23f4>
Code;  c0126850 <kmalloc+140/1e0>
00000000 <_EIP>:
Code;  c0126850 <kmalloc+140/1e0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0126852 <kmalloc+142/1e0>
   2:   5d                        pop    %ebp
Code;  c0126853 <kmalloc+143/1e0>
   3:   8b 6b 10                  mov    0x10(%ebx),%ebp
Code;  c0126856 <kmalloc+146/1e0>
   6:   58                        pop    %eax
Code;  c0126857 <kmalloc+147/1e0>
   7:   81 e5 00 04 00 00         and    $0x400,%ebp
Code;  c012685d <kmalloc+14d/1e0>
   d:   74 4b                     je     5a <_EIP+0x5a> c01268aa 
<kmalloc+19a/1e0>
Code;  c012685f <kmalloc+14f/1e0>
   f:   b8 a5 c2 0f 17            mov    $0x170fc2a5,%eax


1 warning and 1 error issued.  Results may not be reliable.

This kernel was built with gcc 2.96 on an Athlon 1.33Ghz.

Hope this is usefull,

-- Regards, Gavin Baker

