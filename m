Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267431AbTBUNXL>; Fri, 21 Feb 2003 08:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267432AbTBUNXL>; Fri, 21 Feb 2003 08:23:11 -0500
Received: from pae99.poznan.sdi.tpnet.pl ([217.98.164.99]:27804 "HELO
	pae99.poznan.sdi.tpnet.pl") by vger.kernel.org with SMTP
	id <S267431AbTBUNXJ>; Fri, 21 Feb 2003 08:23:09 -0500
Reply-To: <Lukasz.Tylski@bdi.net.pl>
From: =?iso-8859-2?Q?=A3ukasz_Tylski?= <Lukasz.Tylski@bdi.net.pl>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.20 cbq oops
Date: Fri, 21 Feb 2003 14:33:10 +0100
Organization: BDI
Message-ID: <001101c2d9ad$c85a83e0$0c07010a@apltyl>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there.

Does somebody could tell me what could make this happen :


ksymoops 2.4.8 on i686 2.4.20.  Options used
     -v vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20/ (default)
     -m System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Warning (compare_maps): mismatch on symbol state b, System.map says
c02f8580, vmlinux says 0.  Ignoring System.map entry Warning
(compare_maps): mismatch on symbol state a, vmlinux says 0, System.map
says c02f8580.  Ignoring System.map entry Unable to handle kernel NULL
pointer dereference at virtual address 00000000 c01cf7d0 *pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01cf7d0>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010296
eax: 00000004   ebx: ced2b05c   ecx: 00000000   edx: 00000000
esi: c0288380   edi: ced2b000   ebp: ced2b000   esp: cedb7c24
ds: 0018   es: 0018   ss: 0018
Process tc (pid: 47, stackpage=cedb7000)
Stack: cedb7c34 00000007 00000004 000001f0 c12c3540 c12c3538 00000246
000001f0 
       00000202 00000008 00000000 00000268 00000268 c0288380 c01cf7a0
c01cabf4 
       ced2b000 00000000 cef2d898 cfed5ea4 cfed5e90 00010000 cf3a7780
cfedc800 
Call Trace:    [<c01cf7a0>] [<c01cabf4>] [<c01cb2fb>] [<c01c8143>]
[<c01c8888>]
  [<c01c84a0>] [<c01c81d0>] [<c01e188a>] [<c01e1129>] [<c01e15ed>]
[<c01baa05>]
  [<c01bbf57>] [<c0120fc7>] [<c0110248>] [<c01bb38d>] [<c01bc446>]
[<c01100d0>]
  [<c0107510>] [<c010741f>]
Code: 0f b7 02 83 e8 04 89 44 24 0c e8 41 82 ff ff 85 c0 78 1d 8b 


>>EIP; c01cf7d0 <cbq_init+30/240>   <=====

>>esi; c0288380 <cbq_qdisc_ops+0/40>

Trace; c01cf7a0 <cbq_init+0/240>
Trace; c01cabf4 <qdisc_create+154/190>
Trace; c01cb2fb <tc_modify_qdisc+30b/520>
Trace; c01c8143 <rtnetlink_fill_ifinfo+3e3/470>
Trace; c01c8888 <rtnetlink_rcv_msg+1a8/26d>
Trace; c01c84a0 <rtnetlink_rcv+b0/1d0>
Trace; c01c81d0 <rtnetlink_dump_ifinfo+0/80>
Trace; c01e188a <netlink_data_ready+7a/80>
Trace; c01e1129 <netlink_unicast+249/2b0>
Trace; c01e15ed <netlink_sendmsg+1ed/280>
Trace; c01baa05 <sock_sendmsg+75/c0>
Trace; c01bbf57 <sys_sendmsg+1b7/210>
Trace; c0120fc7 <handle_mm_fault+77/110>
Trace; c0110248 <do_page_fault+178/523>
Trace; c01bb38d <sys_socket+3d/60>
Trace; c01bc446 <sys_socketcall+246/270>
Trace; c01100d0 <do_page_fault+0/523>
Trace; c0107510 <error_code+34/3c>
Trace; c010741f <system_call+33/38>

Code;  c01cf7d0 <cbq_init+30/240>
00000000 <_EIP>:
Code;  c01cf7d0 <cbq_init+30/240>   <=====
   0:   0f b7 02                  movzwl (%edx),%eax   <=====
Code;  c01cf7d3 <cbq_init+33/240>
   3:   83 e8 04                  sub    $0x4,%eax
Code;  c01cf7d6 <cbq_init+36/240>
   6:   89 44 24 0c               mov    %eax,0xc(%esp,1)
Code;  c01cf7da <cbq_init+3a/240>
   a:   e8 41 82 ff ff            call   ffff8250 <_EIP+0xffff8250>
Code;  c01cf7df <cbq_init+3f/240>
   f:   85 c0                     test   %eax,%eax
Code;  c01cf7e1 <cbq_init+41/240>
  11:   78 1d                     js     30 <_EIP+0x30>
Code;  c01cf7e3 <cbq_init+43/240>
  13:   8b 00                     mov    (%eax),%eax


2 warnings and 1 error issued.  Results may not be reliable.


I think the problem could be with glibc 2.3/2.3.1 but I am not sure.
Maybe someone had the same.

Regards,

Lukasz Tylski


