Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131581AbQKNXPy>; Tue, 14 Nov 2000 18:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131580AbQKNXPo>; Tue, 14 Nov 2000 18:15:44 -0500
Received: from 66-ZARA-X28.libre.retevision.es ([62.82.239.66]:1285 "EHLO
	head.redvip.net") by vger.kernel.org with ESMTP id <S131430AbQKNXPi>;
	Tue, 14 Nov 2000 18:15:38 -0500
Message-ID: <3A11C0C9.665B1EB0@zaralinux.com>
Date: Tue, 14 Nov 2000 23:46:33 +0100
From: Jorge Nerin <comandante@zaralinux.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: es-ES, es, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: kernel BUG at sock.c:722! (2.4.0-test11-pre4)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, first saw this in test11-pre1, and now in test11-pre4 I report it
again.


Nov 14 15:10:51 quartz kernel: kernel BUG at sock.c:722!
Nov 14 15:10:51 quartz kernel: invalid operand: 0000
Nov 14 15:10:51 quartz kernel: CPU:    0
Nov 14 15:10:51 quartz kernel: EIP:    0010:[sock_wait_for_wmem+104/244]
Nov 14 15:10:51 quartz kernel: EFLAGS: 00010286
Nov 14 15:10:51 quartz kernel: eax: 0000001a   ebx: c1b2a000   ecx:
00000000   edx: 00000002
Nov 14 15:10:51 quartz kernel: esi: c25c60e0   edi: c25c60e0   ebp:
7fffffff   esp: c1b2be7c
Nov 14 15:10:51 quartz kernel: ds: 0018   es: 0018   ss: 0018
Nov 14 15:10:51 quartz kernel: Process sound-propertie (pid: 995,
stackpage=c1b2b000)
Nov 14 15:10:51 quartz kernel: Stack: c0216f45 c021718b 000002d2
7fffffff c25c60e0 c1b2a000 00000ff0 c1b2a000
Nov 14 15:10:51 quartz kernel:        00000000 c1b2a000 00000000
00000000 00000000 c1b2a000 00000000 00000000
Nov 14 15:10:51 quartz kernel:        c01a6829 c25c60e0 7fffffff
c5a81540 00007fef c1b90000 c19a74f4 00000000
Nov 14 15:10:51 quartz kernel: Call Trace: [vga_con+2501/10176]
[vga_con+3083/10176] [sock_alloc_send_skb+221/300]
[unix_stream_sendmsg+302/784] [unix_stream_sendmsg+0/784]
[sock_sendmsg+129/164] [unix_stream_sendmsg+0/784]
Nov 14 15:10:51 quartz kernel:        [sock_write+163/172]
[sys_write+142/196] [system_call+55/64]
Nov 14 15:10:51 quartz kernel: Code: 0f 0b 83 c4 0c 8b 87 50 03 00 00 f0
0f ba 70 04 00 8d 4c 24


ksymoops 2.3.4 on i586 2.4.0-test11-pre4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test11-pre4/ (default)
     -m /boot/System.map-2.4.0-test11-pre4 (specified)

activating NMI Watchdog ... done.
cpu: 0, clocks: 668169, slice: 222723
cpu: 1, clocks: 668169, slice: 222723
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01a66c0>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286
eax: 0000001a   ebx: c1b2a000   ecx: 00000000   edx: 00000002
esi: c25c60e0   edi: c25c60e0   ebp: 7fffffff   esp: c1b2be7c
ds: 0018   es: 0018   ss: 0018
Process sound-propertie (pid: 995, stackpage=c1b2b000)
Stack: c0216f45 c021718b 000002d2 7fffffff c25c60e0 c1b2a000 00000ff0
c1b2a000 
       00000000 c1b2a000 00000000 00000000 00000000 c1b2a000 00000000
00000000 
       c01a6829 c25c60e0 7fffffff c5a81540 00007fef c1b90000 c19a74f4
00000000 
Call Trace: [<c0216f45>] [<c021718b>] [<c01a6829>] [<c01e2f2e>]
[<c01e2e00>] [<c01a3a0d>] [<c01e2e00>] 
       [<c01a3c2b>] [<c013c81a>] [<c010a0f7>] 
Code: 0f 0b 83 c4 0c 8b 87 50 03 00 00 f0 0f ba 70 04 00 8d 4c 24 

>>EIP; c01a66c0 <sock_wait_for_wmem+68/f4>   <=====
Trace; c0216f45 <vga_con+9c5/27c0>
Trace; c021718b <vga_con+c0b/27c0>
Trace; c01a6829 <sock_alloc_send_skb+dd/12c>
Trace; c01e2f2e <unix_stream_sendmsg+12e/310>
Trace; c01e2e00 <unix_stream_sendmsg+0/310>
Trace; c01a3a0d <sock_sendmsg+81/a4>
Trace; c01e2e00 <unix_stream_sendmsg+0/310>
Trace; c01a3c2b <sock_write+a3/ac>
Trace; c013c81a <sys_write+8e/c4>
Trace; c010a0f7 <system_call+37/40>
Code;  c01a66c0 <sock_wait_for_wmem+68/f4>
00000000 <_EIP>:
Code;  c01a66c0 <sock_wait_for_wmem+68/f4>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01a66c2 <sock_wait_for_wmem+6a/f4>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c01a66c5 <sock_wait_for_wmem+6d/f4>
   5:   8b 87 50 03 00 00         mov    0x350(%edi),%eax
Code;  c01a66cb <sock_wait_for_wmem+73/f4>
   b:   f0 0f ba 70 04 00         lock btrl $0x0,0x4(%eax)
Code;  c01a66d1 <sock_wait_for_wmem+79/f4>
  11:   8d 4c 24 00               lea    0x0(%esp,1),%ecx

-- 
Jorge Nerin
<comandante@zaralinux.com>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
