Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131602AbRCOBeE>; Wed, 14 Mar 2001 20:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131609AbRCOBdp>; Wed, 14 Mar 2001 20:33:45 -0500
Received: from [210.164.203.132] ([210.164.203.132]:48650 "EHLO
	neptune.soft-net.co.jp") by vger.kernel.org with ESMTP
	id <S131602AbRCOBdn>; Wed, 14 Mar 2001 20:33:43 -0500
Message-ID: <004801c0acef$bfa13bf0$0f01a8c0@ndiamond5w2k>
From: "SN_Diamond" <Norman.Diamond@soft-net.co.jp>
To: <linux-kernel@vger.kernel.org>
Subject: Kernel bug in 2.4.2
Date: Thu, 15 Mar 2001 10:31:23 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.4.2 on a uniprocessor Pentium-MMX.
Kernel PCMCIA 3.1.22 is built-in.
PCMCIA 3.1.24 package is added.

Cardinfo applet was used in ejecting the network card.
Network configuration applet was not used so the network driver
must have thought that the network interface was still active.

Base distribution is Red Hat 7J (default language Japanese).
Update rpms were applied for gcc 2.96-69, glibc 2.2-12,
modutils 2.4.1-1, and ksymoops 2.4.0-3.
The kernel and PCMCIA packages, mentioned at the beginning of
this message, were not from rpms.


/var/log/messages contains nothing useful:

Mar 14 17:34:29 localhost syslog: klogd shutdown succeeded
Mar 14 17:34:29 localhost exiting on signal 15
Mar 14 17:55:05 localhost syslogd 1.3-3: restart


Following are the last lines displayed on the screen:
[several irrelevant successful shutdowns omitted]

Shutting down system logger:                              [  OK  ]
Shutting down interface eth0:  Scheduling in interrupt
kernel BUG at sched.c:681!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0113333>]
EFLAGS: 00010282
eax: 0000001b   ebx: c02fbe00   ecx: 00000001   edx: c02c9d88
esi: 00000000   edi: c3aa3140   ebp: c02fbd6c   esp: c02fbd40
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02fb000)
Stack: c026124b c02613b6 000002a9 0000001d c02fa000 00000000 c02fa000 c02cad00
       c02fbe00 c02fa000 c02fbe00 00000001 c0107ac4 00000001 c02fa000 c02fbe0c
       c02fbe0c c02fbdc0 c02cabe0 c0107c10 c02fbe00 00000014 00000001 c0257319
Call Trace: [<c0107ac4>] [<c0107c10>] [<c0257319>] [<c0120330>] [<c0120330>] [<c
021ceef>] [<c021cd45>]
       [<c01af830>] [<c688b05a>] [<c011c350>] [<c688afcc>] [<c011c633>] [<c01192
ec>] [<c0119206>] [<c0119102>]
       [<c010a5ef>] [<c0107220>] [<c0109070>] [<c0107220>] [<c0107244>] [<c01072
b2>] [<c0105000>] [<c0100191>]

Code: 0f 0b 83 c4 0c 8d 65 f4 5b 5e 5f 5d c3 55 89 e5 57 56 53 83
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing


ksymoops 2.4.0 on i586 2.4.2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.2/ (default)
     -m /boot/System.map-2.4.2 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

kernel BUG at sched.c:681!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0113333>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: 0000001b   ebx: c02fbe00   ecx: 00000001   edx: c02c9d88
esi: 00000000   edi: c3aa3140   ebp: c02fbd6c   esp: c02fbd40
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c02fb000)
Stack: c026124b c02613b6 000002a9 0000001d c02fa000 00000000 c02fa000 c02cad00
       c02fbe00 c02fa000 c02fbe00 00000001 c0107ac4 00000001 c02fa000 c02fbe0c
       c02fbe0c c02fbdc0 c02cabe0 c0107c10 c02fbe00 00000014 00000001 c0257319
Call Trace: [<c0107ac4>] [<c0107c10>] [<c0257319>] [<c0120330>] [<c0120330>] [<c
021ceef>] [<c021cd45>]
       [<c01af830>] [<c688b05a>] [<c011c350>] [<c688afcc>] [<c011c633>] [<c01192
       [<c010a5ef>] [<c0107220>] [<c0109070>] [<c0107220>] [<c0107244>] [<c01072
Code: 0f 0b 83 c4 0c 8d 65 f4 5b 5e 5f 5d c3 55 89 e5 57 56 53 83

>>EIP; c0113333 <schedule+3a3/3b0>   <=====
Trace; c0107ac4 <__down+54/a0>
Trace; c0107c10 <__down_failed+8/c>
Trace; c0257319 <stext_lock+1a9/168a>
Trace; c0120330 <__call_usermodehelper+0/30>
Trace; c0120330 <__call_usermodehelper+0/30>
Code;  c0113333 <schedule+3a3/3b0>
00000000 <_EIP>:
Code;  c0113333 <schedule+3a3/3b0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0113335 <schedule+3a5/3b0>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c0113338 <schedule+3a8/3b0>
   5:   8d 65 f4                  lea    0xfffffff4(%ebp),%esp
Code;  c011333b <schedule+3ab/3b0>
   8:   5b                        pop    %ebx
Code;  c011333c <schedule+3ac/3b0>
   9:   5e                        pop    %esi
Code;  c011333d <schedule+3ad/3b0>
   a:   5f                        pop    %edi
Code;  c011333e <schedule+3ae/3b0>
   b:   5d                        pop    %ebp
Code;  c011333f <schedule+3af/3b0>
   c:   c3                        ret    
Code;  c0113340 <__wake_up+0/b0>
   d:   55                        push   %ebp
Code;  c0113341 <__wake_up+1/b0>
   e:   89 e5                     mov    %esp,%ebp
Code;  c0113343 <__wake_up+3/b0>
  10:   57                        push   %edi
Code;  c0113344 <__wake_up+4/b0>
  11:   56                        push   %esi
Code;  c0113345 <__wake_up+5/b0>
  12:   53                        push   %ebx
Code;  c0113346 <__wake_up+6/b0>
  13:   83 00 00                  addl   $0x0,(%eax)

Kernel panic: Aiee, killing interrupt handler!

1 warning issued.  Results may not be reliable.


