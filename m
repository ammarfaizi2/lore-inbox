Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131478AbRAADtr>; Sun, 31 Dec 2000 22:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131461AbRAADti>; Sun, 31 Dec 2000 22:49:38 -0500
Received: from [139.102.15.42] ([139.102.15.42]:56473 "EHLO
	online.indstate.edu") by vger.kernel.org with ESMTP
	id <S131408AbRAADt3>; Sun, 31 Dec 2000 22:49:29 -0500
From: "Rich Baum" <baumr1@coral.indstate.edu>
To: linux-kernel@vger.kernel.org
Date: Sun, 31 Dec 2000 22:16:25 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Oops on boot with 2.4.0-test13-pre7
Reply-to: richbaum@acm.org
Message-ID: <3A4FB039.24124.114572@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I boot a version of test13-pre7 that was compiled with the 
20001225 snapshot of gcc I get the following oops:

ksymoops 2.3.5 on i586 2.4.0-test11.  Options used
     -V (specified)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.0-test13-pre7/ (specified)
     -m /boot/System.map-2.4.0-test13 (specified)

No modules in ksyms, skipping objects
Oops: 0000
CPU:    0
EIP:    0010:[<c0112a0d>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010083
eax: cbfebfb0  ebx: c3585a59  ecx: fffffe44  edx: 00000003
esi: c0107b94  edi: cbf7423a  ebp: cbf75fc8  esp: cbf75fa4
ds: 0018  es: 0018  ss: 0018
Process kupdate (pid: 6, stackpage=cbf75000)
Stack: 00000000 00000246 00000000 cbfebfb0 00000001 
00000003 cbf74000 c0216576
       cbf7423a cbf74000 c0107bc0 cbfebfa4 cbf74550 00000000 
c020f803 00010f00
       cbfebf6c cbfebfb8 0008e000 c01074b6 cbfebfa4 c0135cf0 
cbfebf98
Call Trace: [<c0216576>] [<c0107bc0>] [<c020f803>] 
[<c01074b6>] [<c0135cf0>]
Code: 8b 01 85 45 f0 74 ec 8b 7d dc 85 ff 0f 84 81 00 00 00 8b 45 

>>EIP; c0112a0d <__wake_up+5d/140>   <=====
Trace; c0216576 <tvecs+1c76/a3c0>
Trace; c0107bc0 <__up_wakeup+8/c>
Trace; c020f803 <stext_lock+433/5530>
Trace; c01074b6 <kernel_thread+26/30>
Trace; c0135cf0 <kupdate+0/f0>
Code;  c0112a0d <__wake_up+5d/140>
00000000 <_EIP>:
Code;  c0112a0d <__wake_up+5d/140>   <=====
   0:   8b 01                     mov    (%ecx),%eax   <=====
Code;  c0112a0f <__wake_up+5f/140>
   2:   85 45 f0                  test   %eax,0xfffffff0(%ebp)
Code;  c0112a12 <__wake_up+62/140>
   5:   74 ec                     je     fffffff3 <_EIP+0xfffffff3> c0112a00 
<__wake_up+50/140>
Code;  c0112a14 <__wake_up+64/140>
   7:   8b 7d dc                  mov    0xffffffdc(%ebp),%edi
Code;  c0112a17 <__wake_up+67/140>
   a:   85 ff                     test   %edi,%edi
Code;  c0112a19 <__wake_up+69/140>
   c:   0f 84 81 00 00 00         je     93 <_EIP+0x93> c0112aa0 
<__wake_up+f0/140>
Code;  c0112a1f <__wake_up+6f/140>
  12:   8b 45 00                  mov    0x0(%ebp),%eax


It appears to be a compiler bug since using egcs-1.1.2 works just 
fine.  If anyone was a patch to try and fix this I'll be happy to try it.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
