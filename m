Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311951AbSCQHvF>; Sun, 17 Mar 2002 02:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311952AbSCQHu5>; Sun, 17 Mar 2002 02:50:57 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:44729 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S311951AbSCQHun>; Sun, 17 Mar 2002 02:50:43 -0500
Date: Sun, 17 Mar 2002 09:33:55 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: kuznet@ms2.inr.ac.ru
Subject: 2.5.7-pre1 oops in rtnetlink
Message-ID: <Pine.LNX.4.44.0203170932490.6387-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can reproduce by doing an ifdown eth0; ifconfig. 
kernel is 2.5.7-pre1 SMP

Unable to handle kernel paging request at virtual address d0841ae0
*pde = cfda1864
Oops: 0000
CPU:    0
EIP:    0010:[<d0841ae0>]    Not tainted
EFLAGS: 00010282
eax: d0841ae0   ebx: cfb82000   ecx: 00000000   edx: 00000010
esi: ced9df40   edi: c0348d73   ebp: 00000000   esp: c2e6fc70
ds: 0018   es: 0018   ss: 0018
Process ip (pid: 15539, threadinfo=c2e6e000 task=ce005be0)
Stack: c026c77a cfb82000 cff3e91c c407716c 000005dc cfb82000 00000002 
c1542584
       00000000 c026c898 ced9df40 cfb82000 00000010 00003cb3 34ad276e 
00000000
       c14e2ca0 ced9df40 c2e6e000 c1542584 c0270ca5 ced9df40 c1542584 
00000246
Call Trace: [<c026c77a>] [<c026c898>] [<c0270ca5>] [<c0271199>] 
[<c026c820>]
   [<c026cc47>] [<c026c820>] [<c026ca00>] [<c0270aab>] [<c0270384>] 
[<c027092c>]
   [<c025cc72>] [<c01f8940>] [<c025c732>] [<c025dd80>] [<c025ca4e>] 
[<c025ca9d>]
   [<c025d7b3>] [<c025e56b>] [<c010791b>]

Code:  Bad EIP value.

>>EIP; d0841ae0 <_end+104114ac/20419a2c>   <=====
Trace; c026c77a <rtnetlink_fill_ifinfo+37a/420>
Trace; c026c898 <rtnetlink_dump_ifinfo+78/b0>
Trace; c0270ca5 <netlink_dump+105/3e0>
Trace; c0271199 <netlink_dump_start+219/230>
Trace; c026c820 <rtnetlink_dump_ifinfo+0/b0>
Trace; c026cc47 <rtnetlink_rcv+237/520>
Trace; c026c820 <rtnetlink_dump_ifinfo+0/b0>
Trace; c026ca00 <rtnetlink_done+0/10>
Trace; c0270aab <netlink_data_ready+1b/60>
Trace; c0270384 <netlink_unicast+364/3b0>
Trace; c027092c <netlink_sendmsg+1dc/1f0>
Trace; c025cc72 <sock_sendmsg+72/90>
Trace; c01f8940 <rb_insert_color+70/f0>
Trace; c025c732 <move_addr_to_kernel+32/50>
Trace; c025dd80 <sys_sendto+d0/f0>
Trace; c025ca4e <sock_map_fd+be/120>
Trace; c025ca9d <sock_map_fd+10d/120>
Trace; c025d7b3 <sock_create+f3/120>
Trace; c025e56b <sys_socketcall+13b/200>
Trace; c010791b <syscall_call+7/b>

0xc025bc07 <rtnetlink_fill_ifinfo+887>: push   %ebx
0xc025bc08 <rtnetlink_fill_ifinfo+888>: call   *%eax	<==
0xc025bc0a <rtnetlink_fill_ifinfo+890>: pop    %esi
0xc025bc0b <rtnetlink_fill_ifinfo+891>: test   %eax,%eax



