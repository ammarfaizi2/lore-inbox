Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262078AbREPUCj>; Wed, 16 May 2001 16:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262063AbREPUCa>; Wed, 16 May 2001 16:02:30 -0400
Received: from boss.staszic.waw.pl ([195.205.163.66]:64262 "EHLO
	boss.staszic.waw.pl") by vger.kernel.org with ESMTP
	id <S262078AbREPUCP>; Wed, 16 May 2001 16:02:15 -0400
Message-ID: <200105162202060520.00371710@boss.staszic.waw.pl>
X-Mailer: Calypso Version 3.20.02.00 (2)
Date: Wed, 16 May 2001 22:02:06 +0200
From: "Marcin Gozdalik" <gozdal_abc@staszic.waw.pl>
To: linux-kernel@vger.kernel.org
Subject: Oops in 2.2.19 when reading /proc/net/ip_masq/app
Content-Type: text/plain; charset="ISO-8859-2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I'm experiencing reproductible oopses on my stock 2.2.19 (with BadRAM
patches, though I seriously doubt thet can affect described behaviour). The
system is Slackware-current, kernel compiled from sources, on Pentium 120
with 32Mb RAM. The oops report is from mc but any process trying to read
from /proc/net/ip_masq/app causes the oops. I suspect it may be caused by
the ip_masq_netmeeting (by Alex Nicolaou,
http://www.cgl.uwaterloo.ca/~anicolao/) module I inserted for a short while
and then removed from the kernel, but I'm not sure as I'm not a pro kernel
hacker ;-). Currently the output of lsmod looks like this:
ip_masq_user            2768   0 (autoclean)
af_packet               6144   0 (autoclean)
ip_masq_portfw          2688   1 (autoclean)
ip_masq_ftp             3808   0

and ipmasqadm portfw -l has one redirection:
TCP  xxx.yy.zzz.www       192.168.2.2              6699     6699    10
10

If you want more details please CC the reply to me as I'm not subscribed to
linux-kernel, though I'll try to keep up-to-dat with replies and respond
appropriately.

Here is what ksymoops has to say about it:

May 16 20:50:50 router kernel: Unable to handle kernel paging request at
virtual address c281bc93
May 16 20:50:50 router kernel: current->tss.cr3 = 008e3000, %cr3 = 008e3000
May 16 20:50:50 router kernel: *pde = 01676063
May 16 20:50:50 router kernel: Oops: 0000
May 16 20:50:50 router kernel: CPU:    0
May 16 20:50:50 router kernel: EIP:    0010:[vsprintf+417/764]
May 16 20:50:50 router kernel: EFLAGS: 00010297
May 16 20:50:50 router kernel: eax: c281bc93   ebx: c10fc03e   ecx:
c281bc93   edx: fffffffe
May 16 20:50:50 router kernel: esi: ffffffff   edi: c0c83f1c   ebp:
00000011   esp: c0c83ebc
May 16 20:50:50 router kernel: ds: 0018   es: 0018   ss: 0018
May 16 20:50:50 router kernel: Process mc (pid: 6995, process nr: 63,
stackpage=c0c83000)
May 16 20:50:50 router kernel: Stack: 00000050 00000003 c178ef60 00000000
00000002 00000010 00000000 c0c83f28 
May 16 20:50:50 router kernel:        00000026 c01b1e8a c10fc028 c01bde97
c0c83f0c c01b1e8a c10fc000 c01bde81 
May 16 20:50:50 router kernel:        c0c83f1c c0154fd1 c10fc028 c01bde82
c01bdc97 00000465 00000000 c281bc93 
May 16 20:50:50 router kernel: Call Trace: [sprintf+26/3824]
[prio2band+2706/8667] [sprintf+26/3824] [prio2band+2684/8667]
[ip_masq_app_getinfo+213/288] [prio2band+2685/8667] [prio2band+2194/8667] 
May 16 20:50:50 router kernel:        [<c281bc93>] [prio2band+2651/8667]
[proc_file_read+159/440] [proc_file_read+55/440] [sys_read+178/208]
[error_code+53/64] [system_call+52/56] 
May 16 20:50:50 router kernel: Code: 80 38 00 74 07 40 4a 83 fa ff 75 f4 29
c8 8b 54 24 1c 89 c6 

Trace: c281bc93 <END_OF_CODE+2602acb/????>
Code:  00000000 Before first symbol            0000000000000000 <_IP>: <===
Code:  00000000 Before first symbol               0:	80 38 00
cmpb   $0x0,(%eax) <===
Code:  00000003 Before first symbol               3:	74 07
je      0000000c Before first symbol
Code:  00000005 Before first symbol               5:	40
inc    %eax
Code:  00000006 Before first symbol               6:	4a
dec    %edx
Code:  00000007 Before first symbol               7:	83 fa ff
cmp    $0xffffffff,%edx
Code:  0000000a Before first symbol               a:	75 f4
jne    0 <_IP>
Code:  0000000c Before first symbol               c:	29 c8
sub    %ecx,%eax
Code:  0000000e Before first symbol               e:	8b 54 24 1c
mov    0x1c(%esp,1),%edx
Code:  00000012 Before first symbol              12:	89 c6
mov    %eax,%esi

--
Marcin Gozdalik <gozdal_abc@staszic.waw.pl>
Jesli chcesz odpowiedziec usun _abc
If you want to reply remove _abc

