Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262901AbSLDHMI>; Wed, 4 Dec 2002 02:12:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265480AbSLDHMH>; Wed, 4 Dec 2002 02:12:07 -0500
Received: from [202.56.196.162] ([202.56.196.162]:20032 "EHLO
	brahma.intotoind.com") by vger.kernel.org with ESMTP
	id <S262901AbSLDHMD>; Wed, 4 Dec 2002 02:12:03 -0500
Message-Id: <5.1.0.14.0.20021004125147.00a089b0@172.16.1.10>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 04 Oct 2002 12:54:34 +0530
To: linux-kernel@vger.kernel.org
From: Ram Kumar <ramkumar@intotoinc.com>
Subject: kernel BUG at slab.c:1095!
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Kernel hangs after some time when i run my module.

Environment : PCQlinux 7.1 Kernel 2.4.2-2 on i586
Platform : Pentium III 200 MHz,62MBRAM
I am using PCMCIA provided by linux.

kernel BUG at slab.c:1095!
invalid operand: 0000
CPU: 0
EIP: 0010:[<c012a52b>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 0000001b ebx: 00000007 ecx: 00000080 edx: 00000014
esi: c11150c0 edi: c1dd702e ebp: c345e5a0 esp: c026dd60
ds: 0018 es: 0018 ss:0018
Process swapper (pid: 0, stackpage=c026d000)
Stack: c02102db c021037b 00000447 c01c9f63 00000143 c01c9ff7 c1159a40 c01e84c0
c026de78 c11150c0 00000007 c1dd702e c345e5a0 c012a7cf c11150c0 00000007
c026ddc4 00000286 c1f058ec 00000282 c345e527 c1d9c50c c485417a 00000008
Call Trace: [<c02102db>] [<c021037b>] [<c01c9f63>] [<c01c9f97>] 
[<c01e84c0>] [<c012a7cf>] [<c485417a>]
[<c4856250>] [<c011d1e0>] [<c485b2b5>] [<c010a35a>] [<c0250108>] 
[<c010a50f>] [<c4858329>]
[<c485abd6>] [<c488dde0>] [<c48b9fad>] [<c48495eb>] [<c011d1e0>] 
[<c485c2a3>] [<c011d495>]
[<c010a35a>] [<c010a4dd>] [<c0107220>] [<c0109070>] [<c0107220>] 
[<c0107244>] [<c01072b2>]
[<c0105000>] [<c0100191>]
Code: 0f 0b 83 c4 0c 89 dd c7 04 24 01 00 00 00 83 d5 07 83 fd 02


ksymoops output shows as below:

 >>EIP; c012a52b <lookup_swap_cache+1b/180> <=====
Trace; c02102db <quota_versions+5b13/88c4>
Trace; c021037b <quota_versions+5bb3/88c4>
Trace; c01c9f63 <csum_partial_copy_fromiovecend+b3/220>
Trace; c01c9f97 <csum_partial_copy_fromiovecend+e7/220>
Trace; c01e84c0 <tcp_v4_rcv+260/5d0>
Trace; c012a7cf <__get_swap_page+af/240>
Trace; c485417a <.data.end+18d7/????>
Trace; c4856250 <.data.end+39ad/????>
Trace; c011d1e0 <exec_usermodehelper+50/3d0>
Trace; c485b2b5 <END_OF_CODE+8a12/????>
Trace; c010a35a <do_IRQ+6a/b0>
Trace; c0250108 <bm_status_operations+48/60>
Trace; c010a50f <probe_irq_on+4f/160>
Trace; c4858329 <.data.end+5a86/????>
Trace; c485abd6 <END_OF_CODE+8333/????>
Trace; c488dde0 <END_OF_CODE+3b53d/????>
Trace; c48b9fad <END_OF_CODE+6770a/????>
Trace; c48495eb <[i82365]pcic_interrupt+7b/1c0>
Trace; c011d1e0 <exec_usermodehelper+50/3d0>
Trace; c485c2a3 <END_OF_CODE+9a00/????>
Trace; c011d495 <exec_usermodehelper+305/3d0>
Trace; c010a35a <do_IRQ+6a/b0>
Trace; c010a4dd <probe_irq_on+1d/160>
Trace; c0107220 <machine_real_restart+0/b0>
Trace; c0109070 <device_not_available+8/3c>
Trace; c0107220 <machine_real_restart+0/b0>
Trace; c0107244 <machine_real_restart+24/b0>
Trace; c01072b2 <machine_real_restart+92/b0>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c0100191 <L6+0/2>
Code; c012a52b <lookup_swap_cache+1b/180>
00000000 <_EIP>:
Code; c012a52b <lookup_swap_cache+1b/180> <=====
0: 0f 0b ud2a <=====
Code; c012a52d <lookup_swap_cache+1d/180>
2: 83 c4 0c add $0xc,%esp
Code; c012a530 <lookup_swap_cache+20/180>
5: 89 dd mov %ebx,%ebp
Code; c012a532 <lookup_swap_cache+22/180>
7: c7 04 24 01 00 00 00 movl $0x1,(%esp,1)
Code; c012a539 <lookup_swap_cache+29/180>
e: 83 d5 07 adc $0x7,%ebp
Code; c012a53c <lookup_swap_cache+2c/180>
11: 83 fd 02 cmp $0x2,%ebp

Kernel panic: Aiee, killng interrupt handler!

1125 warnings issued. Results may not be reliable.

Please help me.

-with regards,
Ramkumar

