Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280532AbRKJGYY>; Sat, 10 Nov 2001 01:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280538AbRKJGYN>; Sat, 10 Nov 2001 01:24:13 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:16000 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S280532AbRKJGYJ>;
	Sat, 10 Nov 2001 01:24:09 -0500
Message-ID: <3BECC7F4.A9EF9E6B@pobox.com>
Date: Fri, 09 Nov 2001 22:23:48 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.15-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Networking: repeatable oops in 2.4.15-pre2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello -

I have been running the 2.4.15-pre kernels and
have found an interesting oops. I can reproduce
it immediately, and reliably, just by issuing an ssh
command (as a normal user).

Hardware: Pentium III 933 w/512 MB RAM
Red Hat 7.1+ updates

I have 2 eepro 100 cards and am running
an iptables firewall.

The condition exists in 2.4.15-pre1 and -pre2.
I have not seen this before (2.4.14 is fine)

Tonight I compiled 2.4.15-pre2 and ran dbench
for awhile, with good results.

Then I tried the simple "ssh <somehost>"cmd
that locked up -pre1 - sure enough, it locked
up the system again -

Here is the hand-copied, decoded oops:

ksymoops 2.4.3 on i686 2.4.15-pre2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.15-pre2/ (default)
     -m /boot/System.map (specified)

c01b8345
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01b8345>]   Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010293
eax: 000005dc   ebx: df0f7de0   ecx: df0e1000   edx: 0000000e
esi: df96bdec   edi: 00000000   ebp: d793b2a0   esp: da64bcf8
ds: 0018   es: 0018  ss: 0018
Process ssh (pid:2028, stackpage=da64b000)
Stack: 00000003 c01b82b0 c01af49b c0294838 00000000 df0e1000 00000003
c01b82b0
       c01af4d2 df0d7de0 00000000 c0294838 df96b690 00000286 0001e9c0
00000286
       df0e1000 de4297a0 00000000 dfd8aee0 c01b7269 00000002 00000003
df0d7de0
Call Trace:  [<c01b82b0>] [<c01af49b>] [<c01b82b0>] [<c01af4d2>]
[<c01b7269>]
[<c01b82b0>] [<c01abec8>] [<c01c9d5e>] [<c01c5243>] [<c01c755b>]
[<c015fcb6>]
[<c01c95f7>] [<c01d42c2>] [<c01a3df6>] [<c01a2fce>] [<c01a3a27>]
[<c01211b1>]
[<c01a3a7d>] [<c01a4790>] [<c011d34b>] [<c0106cfb>]
Code: 0f b6 87 c6 02 00 00 31 d2 3c 02 74 0a fe c8 75 0b f6 45 20

>>EIP; c01b8344 <ip_queue_xmit2+94/220>   <=====
Trace; c01b82b0 <ip_queue_xmit2+0/220>
Trace; c01af49a <nf_hook_slow+aa/140>
Trace; c01b82b0 <ip_queue_xmit2+0/220>
Trace; c01af4d2 <nf_hook_slow+e2/140>
Trace; c01b7268 <ip_queue_xmit+448/490>
Trace; c01b82b0 <ip_queue_xmit2+0/220>
Trace; c01abec8 <neigh_lookup+18/80>
Trace; c01c9d5e <tcp_v4_send_check+6e/b0>
Trace; c01c5242 <tcp_transmit_skb+552/600>
Trace; c01c755a <tcp_connect+3ba/4b0>
Trace; c015fcb6 <secure_tcp_sequence_number+96/c0>
Trace; c01c95f6 <tcp_v4_connect+2c6/300>
Trace; c01d42c2 <inet_stream_connect+102/230>
Trace; c01a3df6 <sys_connect+56/80>
Trace; c01a2fce <sock_map_fd+ee/170>
Trace; c01a3a26 <sock_create+d6/100>
Trace; c01211b0 <do_munmap+1f0/260>
Trace; c01a3a7c <sys_socket+2c/50>
Trace; c01a4790 <sys_socketcall+e0/200>
Trace; c011d34a <sys_setgroups+5a/80>
Trace; c0106cfa <system_call+32/38>
Code;  c01b8344 <ip_queue_xmit2+94/220>
00000000 <_EIP>:
Code;  c01b8344 <ip_queue_xmit2+94/220>   <=====
   0:   0f b6 87 c6 02 00 00      movzbl 0x2c6(%edi),%eax   <=====
Code;  c01b834a <ip_queue_xmit2+9a/220>
   7:   31 d2                     xor    %edx,%edx
Code;  c01b834c <ip_queue_xmit2+9c/220>
   9:   3c 02                     cmp    $0x2,%al
Code;  c01b834e <ip_queue_xmit2+9e/220>
   b:   74 0a                     je     17 <_EIP+0x17> c01b835a
<ip_queue_xmit2
+aa/220>
Code;  c01b8350 <ip_queue_xmit2+a0/220>
   d:   fe c8                     dec    %al
Code;  c01b8352 <ip_queue_xmit2+a2/220>
   f:   75 0b                     jne    1c <_EIP+0x1c> c01b8360
<ip_queue_xmit2
+b0/220>
Code;  c01b8354 <ip_queue_xmit2+a4/220>
  11:   f6 45 20 00               testb  $0x0,0x20(%ebp)

 <0>Kernel panic: Aiee, killing interrupt handler!


