Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318724AbSHERSF>; Mon, 5 Aug 2002 13:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318726AbSHERSF>; Mon, 5 Aug 2002 13:18:05 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:57729 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S318724AbSHERSE> convert rfc822-to-8bit; Mon, 5 Aug 2002 13:18:04 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <mcp@linux-systeme.de>
To: linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: AIO together with SMPtimers-A0 oops and freezing
Date: Mon, 5 Aug 2002 19:20:29 +0200
X-Mailer: KMail [version 1.4]
Organization: Linux-Systeme GmbH
Cc: Ingo Molnar <mingo@elte.hu>, Benjamin LaHaise <bcrl@redhat.com>
X-PRIORITY: 2 (High)
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200208051920.29018.mcp@linux-systeme.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben, Hi Ingo,

Ben, I am using your AIO 20020619 patch + relevant fixes from the AIO 
mailinglist together with your patch Ingo, SMPtimers-A0.

As almost anything for WOLK is selectable via kernel configuration I was able 
to track the issue down we've experienced with both together. If I use AIO 
without SMPtimers, Oracle 9i works horribly fine :), no oops, no panic, no 
freeze, just fast as light ;) ... Unfortunately if I use them both, AIO + 
SMPtimers, doing some heavy traffic to the Oracle 9i database, the system 
oops() and after that it's almost freezed (only sysrq works).

If I use either AIO _or_ SMPtimers, no problem occurs, all works fine.

Is there any chance to give both a cooperation with each other? :)
Otherwise I have to disable SMPtimers completely from the kernel config if AIO 
gets selected as I am not able to fix that issue :|


Kernel is  :  2.4.18-wolk3.5-rc4 (sf.net/projects/wolk)
Hardware is:  Compaq ML570, Quad Xeon 900MHz, 16GB RAM, u2w scsi raid.
System is  :  Debian Woody 3.0r0


Many thanks for your help and your time!!


Error follows:
--------------

Unable to handle kernel paging request at virtual address  00v03ab9
printing eip:
c01221e1
*pde = 00000000
Oops: 0002
CPU:    1
EIP:    0010:[<c01221e1>]       Not tainted
EFLAGS: 00010002
eax: 08c03ab5   ebx:  d1008000  ecx:  c03ab501  edx:  00c03ab5
esi: c03ab520   edi:  10c03ab5  ebp:  10x03ab5  esp:  d1009f38
ds:  0018       es  0018        ss: 0018
Process swapper (pid: 0, stackpage=d1009000)
Stack:  d1008000 00000080 00001020 c03ab520 00000086 c0122844 c03ab520 
00000080
                00000001 00000000 00000000 c011252d d1008000 d1008000 c0105470 
c02af3a8
                d1009f7c c0105470 d1008000 d1008000 d1008000 c0105470 00000000 
00000000
Call Trace: [<c0122884>] [<c011252d>] [<c0105470>] [<c105470>] [<c105470>]
        [<c0105499>] [<c0105502>] [<c0119326>] [<c01191c4>]

Code: 89 42 04 89 10 c7 41 04 00 00 00 00 c7 01 00 00 00 00 89 4e
>>EIP; c01221e1 <del_timer_sync+32d/a44>   <=====

>>eax; 08c03ab5 Before first symbol
>>ebx; d1008000 <___strtok+10c35f1c/11cebf1c>
>>ecx; c03ab501 <xtime+1011/1530>
>>edx; 00c03ab5 Before first symbol
>>esi; c03ab520 <xtime+1030/1530>
>>edi; 10c03ab5 Before first symbol

Trace; c0122884 <del_timer_sync+9d0/a44>
Trace; c011252d <smp_call_function+7e9/1d24>
Trace; c0105470 <enable_hlt+8/190>
Trace; 0c105470 Before first symbol
Trace; 0c105470 Before first symbol
Trace; c0105499 <enable_hlt+31/190>
Trace; c0105502 <enable_hlt+9a/190>
Trace; c0119326 <acquire_console_sem+136/164>
Trace; c01191c4 <printk+144/170>

Code;  c01221e1 <del_timer_sync+32d/a44>
00000000 <_EIP>:
Code;  c01221e1 <del_timer_sync+32d/a44>   <=====
   0:   89 42 04                  mov    %eax,0x4(%edx)   <=====
Code;  c01221e4 <del_timer_sync+330/a44>
   3:   89 10                     mov    %edx,(%eax)
Code;  c01221e6 <del_timer_sync+332/a44>
   5:   c7 41 04 00 00 00 00      movl   $0x0,0x4(%ecx)
Code;  c01221ed <del_timer_sync+339/a44>
   c:   c7 01 00 00 00 00         movl   $0x0,(%ecx)
Code;  c01221f3 <del_timer_sync+33f/a44>
  12:   89 4e 00                  mov    %ecx,0x0(%esi)



-- 
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/408B2D54947750EC
Fingerprint: 8602 69E0 A9C2 A509 8661 2B0B 408B 2D54 9477 50EC
Key available at www.keyserver.net. Encrypted e-mail preferred.
