Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275425AbRJATeM>; Mon, 1 Oct 2001 15:34:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275421AbRJATeD>; Mon, 1 Oct 2001 15:34:03 -0400
Received: from tungsten.btinternet.com ([194.73.73.81]:41669 "EHLO
	tungsten.btinternet.com") by vger.kernel.org with ESMTP
	id <S275425AbRJATdy>; Mon, 1 Oct 2001 15:33:54 -0400
Date: Mon, 1 Oct 2001 20:37:28 +0000 (GMT)
From: James Stevenson <mistral@stev.org>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Linux Kernel Newbies <kernelnewbies@nl.linux.org>
Subject: 2.4.10 [opps] sock_sendmsg
Message-ID: <Pine.LNX.4.30.0110012033050.16609-100000@cyrix.stev.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

i came accross this when i got home from gnome-terminal

Unable to handle kernel NULL pointer dereference at virtual address
00000034
c01f1d19
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01f1d19>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: c3315f0c   ecx: 00000000   edx: 00000064
esi: c3315f54   edi: 00000070   ebp: c3b20d3c   esp: c3315eec
ds: 0018   es: 0018   ss: 0018
Process gnome-terminal (pid: 1181, stackpage=c3315000)
Stack: c3b20d3c c3315f54 00000070 c3315f0c 00000005 c44b0620 c203a7a0
c12f6a00
       0000049d 000001f5 00000064 00000000 00000000 00000000 c0203b30
00000057
       00000070 c3b20d3c 00000000 00000070 c01f1f40 c3b20d3c c3315f54
00000070
Call Trace: [<c0203b30>] [<c01f1f40>] [<c0131166>] [<c0118b63>]
[<c01082bc>]
   [<c0106d03>]
Code: ff 50 34 83 c4 10 89 c7 8b 4c 24 1c 85 c9 74 07 53 e8 11 56

>>EIP; c01f1d19 <sock_sendmsg+69/90>   <=====
Trace; c0203b30 <ip_rcv+350/e70>
Trace; c01f1f40 <sock_recvmsg+200/640>
Trace; c0131166 <default_llseek+336/9c0>
Trace; c0118b63 <do_softirq+53/a0>
Trace; c01082bc <enable_irq+11c/130>
Trace; c0106d03 <__up_wakeup+1137/2574>
Code;  c01f1d19 <sock_sendmsg+69/90>
00000000 <_EIP>:
Code;  c01f1d19 <sock_sendmsg+69/90>   <=====
   0:   ff 50 34                  call   *0x34(%eax)   <=====
Code;  c01f1d1c <sock_sendmsg+6c/90>
   3:   83 c4 10                  add    $0x10,%esp
Code;  c01f1d1f <sock_sendmsg+6f/90>
   6:   89 c7                     mov    %eax,%edi
Code;  c01f1d21 <sock_sendmsg+71/90>
   8:   8b 4c 24 1c               mov    0x1c(%esp,1),%ecx
Code;  c01f1d25 <sock_sendmsg+75/90>
   c:   85 c9                     test   %ecx,%ecx
Code;  c01f1d27 <sock_sendmsg+77/90>
   e:   74 07                     je     17 <_EIP+0x17> c01f1d30
<sock_sendmsg+80/90>
Code;  c01f1d29 <sock_sendmsg+79/90>
  10:   53                        push   %ebx
Code;  c01f1d2a <sock_sendmsg+7a/90>
  11:   e8 11 56 00 00            call   5627 <_EIP+0x5627> c01f7340
<__scm_destroy+0/40>

so far i have tracked it down to

net/socket.c

504: int sock_sendmsg(struct socket *sock, struct msghdr *msg, int size)
505: {
506:         int err;
507:         struct scm_cookie scm; 509:         err = scm_send(sock, msg,
&scm);
510:         if (err >= 0) {
511:                 err = sock->ops->sendmsg(sock, msg, size, &scm);

on line 511 i think caused it would this be correct.
and i am assumingf that the sock->ops->sendmsg
should never be NULL but is there anyway to find out which protocol
was being used at the time and which 1 left it NULL ?

thanks
	James

-- 
---------------------------------------------
Web: http://www.stev.org
Mobile: +44 07779080838
E-Mail: mistral@stev.org
  8:30pm  up 6 days, 20:41,  3 users,  load average: 0.05, 0.40, 0.25

