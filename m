Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261724AbSLCPpV>; Tue, 3 Dec 2002 10:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261732AbSLCPpU>; Tue, 3 Dec 2002 10:45:20 -0500
Received: from rtsx.com ([63.148.235.69]:5906 "EHLO rtsx.com")
	by vger.kernel.org with ESMTP id <S261724AbSLCPpT>;
	Tue, 3 Dec 2002 10:45:19 -0500
Subject: PROBLEM: system crashes with oops message
From: Ken Schneider <kschneider@rtsx.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7Rubber Turnip 
Date: 03 Dec 2002 10:52:43 -0500
Message-Id: <1038930763.1856.22.camel@kens>
Mime-Version: 1.0
X-MDRemoteIP: 10.0.1.218
X-Return-Path: kschneider@rtsx.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

system info below:

oops message:

Unable to handle kernel NULL pointer dereference at virtual address
0000002d
 printing eip:
c0150dfc
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c0150dfc>]    Not tainted
EFLAGS: 00010246
eax: dae03ae0   ebx: 00000000   ecx: 00000000   edx: c0720000
esi: 00000000   edi: 00000000   ebp: 00008001   esp: c0721f34
ds: 0018   es: 0018   ss: 0018
Process smbd (pid: 6105, stackpage=c0721000)
Stack: dae03ae0 ffffffff 0821c438 c0721f8c cf721cf8 c014a980 dae03ae0
00008001
       00008000 c55cf000 0821c438 bfffed8c c160ddf8 00000000 00000004
d3dad760
       c013e4e3 c55cf000 00008001 00000000 c0721f8c 0000001d d3dad760
c1c37ee0
Call Trace: [<c014a980>] [<c013e4e3>] [<c013e87e>] [<c0108b73>]

Code: f6 43 2d 10 74 59 f7 c5 00 08 00 00 0f 85 d7 00 00 00 8b 82


*********************************************************************

output of ksymoops:

ksymoops 2.4.3 on i686 2.4.18-4GB-SMP.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-4GB-SMP/ (default)
     -m /boot/System.map-2.4.18-4GB-SMP (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel NULL pointer dereference at virtual address
0000002d
c0150dfc
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c0150dfc>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: dae03ae0   ebx: 00000000   ecx: 00000000   edx: c0720000
esi: 00000000   edi: 00000000   ebp: 00008001   esp: c0721f34
ds: 0018   es: 0018   ss: 0018
Process smbd (pid: 6105, stackpage=c0721000)
Stack: dae03ae0 ffffffff 0821c438 c0721f8c cf721cf8 c014a980 dae03ae0
00008001
       00008000 c55cf000 0821c438 bfffed8c c160ddf8 00000000 00000004
d3dad760
       c013e4e3 c55cf000 00008001 00000000 c0721f8c 0000001d d3dad760
c1c37ee0
Call Trace: [<c014a980>] [<c013e4e3>] [<c013e87e>] [<c0108b73>]
Code: f6 43 2d 10 74 59 f7 c5 00 08 00 00 0f 85 d7 00 00 00 8b 82

>>EIP; c0150dfc <__get_lease+4c/24c>   <=====
Trace; c014a980 <open_namei+3e4/69c>
Trace; c013e4e2 <filp_open+32/54>
Trace; c013e87e <sys_open+36/9c>
Trace; c0108b72 <system_call+32/40>
Code;  c0150dfc <__get_lease+4c/24c>
00000000 <_EIP>:
Code;  c0150dfc <__get_lease+4c/24c>   <=====
   0:   f6 43 2d 10               testb  $0x10,0x2d(%ebx)   <=====
Code;  c0150e00 <__get_lease+50/24c>
   4:   74 59                     je     5f <_EIP+0x5f> c0150e5a
<__get_lease+aa/24c>
Code;  c0150e02 <__get_lease+52/24c>
   6:   f7 c5 00 08 00 00         test   $0x800,%ebp
Code;  c0150e08 <__get_lease+58/24c>
   c:   0f 85 d7 00 00 00         jne    e9 <_EIP+0xe9> c0150ee4
<__get_lease+134/24c>
Code;  c0150e0e <__get_lease+5e/24c>
  12:   8b 82 00 00 00 00         mov    0x0(%edx),%eax


1 warning issued.  Results may not be reliable.

-----------------------------------------------------------------------------

Running SuSE 8.0 system with only SuSE supplied RPMS
Using system as a fileserver using samba w/winbind and XFS filesystem
and extended ACL's. Authentication against an NT 4.0 server for share
access.

Hardware:
Compaq Proliant 6000
512m ram 
10k rpm disks in raid 5 array
4 Intel pentium pro 200mhz processors (zeon)

System crashes HARD intermittenly (1-20 days) and only way to recover is
by system power cycle.

Any help or redirection would be appreciated. 


-- 
Ken Schneider
*NIX Administrator
Network Administrator
Radiation Therapy Services, Inc.
kschneider@rtsx.com

