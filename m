Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289718AbSAOWxh>; Tue, 15 Jan 2002 17:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289712AbSAOWxX>; Tue, 15 Jan 2002 17:53:23 -0500
Received: from dialin-145-254-150-169.arcor-ip.net ([145.254.150.169]:15364
	"EHLO picklock.adams.family") by vger.kernel.org with ESMTP
	id <S289725AbSAOWxG>; Tue, 15 Jan 2002 17:53:06 -0500
Message-ID: <3C44B260.D1FA47BF@loewe-komp.de>
Date: Tue, 15 Jan 2002 23:51:12 +0100
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: B16
X-Mailer: Mozilla 4.78 [de] (X11; U; Linux 2.4.17-xfs i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oopses in scheduler on Linux-2.4.17-xfs
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I recently get oopses on 2.4.14-xfs and 2.4.17-xfs.
box is SMP with old Pentium Pro
There were some changes with erratas of the Pro ans something
with "cacheline alignment" and a fence.

The Oopses happen after several days of uptime. I fetch them
with kdb. I don't think that it's xfs related (since
the box does not currently use a xfs fs)

ksymoops 2.4.2 on i686 2.4.17-xfs.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17-xfs/ (default)
     -m /boot/System.map-2.4.17-xfs (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Oops: 0000
CPU:    0
EIP:    0010:[<c0113db0>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00210207
eax: 00000005   ebx: 00000014   ecx: 00000000   edx: 00000006
esi: c3c80000   edi: 00000080   ebp: c4723f14   esp: c4723ee0
ds: 0018   es: 0018   ss: 0018
Process kmix (pid: 25786, stackpage=c4723000)
Stack: c4723f28 03493705 00000080 c68ab884 c02c11c0 ccc3c000 00000000 c0bd2e34
       00000001 00000000 00000000 c4722000 c03148e0 c4723f3c c0113aba c4723f28
       00000000 c0bd2e34 00000000 00000000 03493705 c4722000 c01139e0 c4723f70
Call Trace: [<c0113aba>] [<c01139e0>] [<c014343c>] [<c01437de>] [<c0106e7b>]
Code: 8b 51 20 d1 fa 89 d8 2b 41 24 c1 f8 02 8d 54 10 01 89 51 20

>>EIP; c0113db0 <schedule+248/580>   <=====
Trace; c0113aba <schedule_timeout+7a/9c>
Trace; c01139e0 <process_timeout+0/60>
Trace; c014343c <do_select+1c4/1fc>
Trace; c01437de <sys_select+33e/474>
Trace; c0106e7a <system_call+32/38>
Code;  c0113db0 <schedule+248/580>
00000000 <_EIP>:
Code;  c0113db0 <schedule+248/580>   <=====
   0:   8b 51 20                  mov    0x20(%ecx),%edx   <=====
Code;  c0113db2 <schedule+24a/580>
   3:   d1 fa                     sar    %edx
Code;  c0113db4 <schedule+24c/580>
   5:   89 d8                     mov    %ebx,%eax
Code;  c0113db6 <schedule+24e/580>
   7:   2b 41 24                  sub    0x24(%ecx),%eax
Code;  c0113dba <schedule+252/580>
   a:   c1 f8 02                  sar    $0x2,%eax
Code;  c0113dbc <schedule+254/580>
   d:   8d 54 10 01               lea    0x1(%eax,%edx,1),%edx
Code;  c0113dc0 <schedule+258/580>
  11:   89 51 20                  mov    %edx,0x20(%ecx)


1 warning issued.  Results may not be reliable.







ksymoops 2.4.2 on i686 2.4.17-xfs.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17-xfs/ (default)
     -m /boot/System.map-2.4.17-xfs (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

eax = 0xe4242385 ebx = 0x00000014 ecx = 0x746f6f72 edx = 0x1e5bdb3f
esi = 0xc9d20000 edi = 0x00000010 esp = 0xc9d21f88 eip = 0xc0113db0
ebp = 0xc9d21fbc xss = 0x00000018 xcs = 0x00000010 eflags = 0x00010a87
Oops: 0000
CPU:    0
EIP:    0010:[<c0113db0>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010a87
eax: e4242385   ebx: 00000014   ecx: 746f6f72   edx: 1e5bdb3f
esi: c9d20000   edi: 00000010   ebp: c9d21fbc   esp: c9d21f88
ds: 0018   es: 0018   ss: 0018
Process setiathome (pid: 803, stackpage=c9d21000)
Stack: c9d20000 00000a4c 00000010 ca2b1eb4 c02c11c0 c9d20000 00000000 00000001
       00000001 00000000 00000000 c9d20000 c03148e0 bfffeddc c0106f29 40eebcd0
       00000809 40eea040 00000a4c 00000010 bfffeddc 00000000 0809002b 0000002b
Call Trace: [<c0106f29>]
Code: 8b 51 20 d1 fa 89 d8 2b 41 24 c1 f8 02 8d 54 10 01 89 51 20

>>EIP; c0113db0 <schedule+248/580>   <=====
Trace; c0106f28 <reschedule+4/c>
Code;  c0113db0 <schedule+248/580>
00000000 <_EIP>:
Code;  c0113db0 <schedule+248/580>   <=====
   0:   8b 51 20                  mov    0x20(%ecx),%edx   <=====
Code;  c0113db2 <schedule+24a/580>
   3:   d1 fa                     sar    %edx
Code;  c0113db4 <schedule+24c/580>
   5:   89 d8                     mov    %ebx,%eax
Code;  c0113db6 <schedule+24e/580>
   7:   2b 41 24                  sub    0x24(%ecx),%eax
Code;  c0113dba <schedule+252/580>
   a:   c1 f8 02                  sar    $0x2,%eax
Code;  c0113dbc <schedule+254/580>
   d:   8d 54 10 01               lea    0x1(%eax,%edx,1),%edx
Code;  c0113dc0 <schedule+258/580>
  11:   89 51 20                  mov    %edx,0x20(%ecx)


1 warning issued.  Results may not be reliable.
