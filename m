Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267301AbTAKR3t>; Sat, 11 Jan 2003 12:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267306AbTAKR3s>; Sat, 11 Jan 2003 12:29:48 -0500
Received: from kilo.rb.xcalibre.co.uk ([217.204.38.22]:21523 "EHLO
	kilo.rb.xcalibre.co.uk") by vger.kernel.org with ESMTP
	id <S267301AbTAKR15>; Sat, 11 Jan 2003 12:27:57 -0500
Envelope-to: linux-kernel@vger.kernel.org
From: Alistair Strachan <alistair@devzero.co.uk>
Date: Sat, 11 Jan 2003 17:36:57 +0000
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
To: linux-kernel@vger.kernel.org
Subject: [2.5.56] Oops using pppd.
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_5YFI+fQfjdk1IDc"
Message-Id: <200301111736.57416.alistair@devzero.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_5YFI+fQfjdk1IDc
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Find attached a decoded kernel oops which I have only _noticed_ since 2.5.56. 
This is difficult to reproduce, but seems to happen when pppd completes 
authentication. The connection is dropped immediately.

kobject problems?

Regards,
Alistair Strachan.

--Boundary-00=_5YFI+fQfjdk1IDc
Content-Type: text/plain;
  charset="utf-8";
  name="ksymoops"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ksymoops"

ksymoops 2.4.8 on i686 2.5.56.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.56/ (default)
     -m /boot/System.map-2.5.56 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Call Trace: [<c01ba298>]  [<c02825cb>]  [<c01f9f45>]  [<c01f7c5c>]  [<c01f7b33>]  [<c015ba70>]  [<c015c681>]  [<c010951b>]
Unable to handle kernel NULL pointer dereference at virtual address 0000006c
c0280249
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c0280249>]    Tainted: P
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010216
eax: ffffffff   ebx: dc4cff34   ecx: 0000000f   edx: 0000006c
esi: 0000006c   edi: dc4cff34   ebp: 00000010   esp: dc4cfef4
ds: 007b   es: 007b   ss: 0068
Stack: dc4ce000 00000001 00008913 dc4cff34 c02802e1 dc4cff34 dc4cff34 00000001
       c02805a3 dc4cff34 dc4ce000 c0282209 dc4cff34 bffff140 00000020 00000000
       30707070 08148d00 bffff168 0060de02 406962fc bffff1a0 00000089 00000012
Call Trace: [<c02802e1>]  [<c02805a3>]  [<c0282209>]  [<c02bb8e6>]  [<c0279315>]  [<c015c681>]  [<c010951b>]
Code: ac ae 75 08 84 c0 75 f5 31 c0 eb 04 19 c0 0c 01 85 c0 74 07


Trace; c01ba298 <kobject_register+58/70>
Trace; c02825cb <register_netdevice+16b/1b0>
Trace; c01f9f45 <ppp_create_interface+125/1d0>
Trace; c01f7c5c <ppp_unattached_ioctl+11c/1d0>
Trace; c01f7b33 <ppp_ioctl+843/850>
Trace; c015ba70 <setfl+c0/f0>
Trace; c015c681 <sys_ioctl+c1/230>
Trace; c010951b <syscall_call+7/b>

>>EIP; c0280249 <__dev_get_by_name+29/50>   <=====

Trace; c02802e1 <dev_get+21/50>
Trace; c02805a3 <dev_load+13/60>
Trace; c0282209 <dev_ioctl+a9/2b0>
Trace; c02bb8e6 <inet_ioctl+e6/100>
Trace; c0279315 <sock_ioctl+c5/210>
Trace; c015c681 <sys_ioctl+c1/230>
Trace; c010951b <syscall_call+7/b>

Code;  c0280249 <__dev_get_by_name+29/50>
00000000 <_EIP>:
Code;  c0280249 <__dev_get_by_name+29/50>   <=====
   0:   ac                        lods   %ds:(%esi),%al   <=====
Code;  c028024a <__dev_get_by_name+2a/50>
   1:   ae                        scas   %es:(%edi),%al
Code;  c028024b <__dev_get_by_name+2b/50>
   2:   75 08                     jne    c <_EIP+0xc>
Code;  c028024d <__dev_get_by_name+2d/50>
   4:   84 c0                     test   %al,%al
Code;  c028024f <__dev_get_by_name+2f/50>
   6:   75 f5                     jne    fffffffd <_EIP+0xfffffffd>
Code;  c0280251 <__dev_get_by_name+31/50>
   8:   31 c0                     xor    %eax,%eax
Code;  c0280253 <__dev_get_by_name+33/50>
   a:   eb 04                     jmp    10 <_EIP+0x10>
Code;  c0280255 <__dev_get_by_name+35/50>
   c:   19 c0                     sbb    %eax,%eax
Code;  c0280257 <__dev_get_by_name+37/50>
   e:   0c 01                     or     $0x1,%al
Code;  c0280259 <__dev_get_by_name+39/50>
  10:   85 c0                     test   %eax,%eax
Code;  c028025b <__dev_get_by_name+3b/50>
  12:   74 07                     je     1b <_EIP+0x1b>

1 warning and 1 error issued.  Results may not be reliable.

--Boundary-00=_5YFI+fQfjdk1IDc
Content-Type: text/plain;
  charset="utf-8";
  name="oops"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="oops"

Badness in kobject_register at lib/kobject.c:129
Call Trace: [<c01ba298>]  [<c02825cb>]  [<c01f9f45>]  [<c01f7c5c>]  [<c01f7b33>]  [<c015ba70>]  [<c015c681>]  [<c010951b>]
PPP: couldn't register device ppp0 (-17)
Unable to handle kernel NULL pointer dereference at virtual address 0000006c
 printing eip:
c0280249
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c0280249>]    Tainted: P
EFLAGS: 00010216
eax: ffffffff   ebx: dc4cff34   ecx: 0000000f   edx: 0000006c
esi: 0000006c   edi: dc4cff34   ebp: 00000010   esp: dc4cfef4
ds: 007b   es: 007b   ss: 0068
Process kppp (pid: 370, threadinfo=dc4ce000 task=dd5d2d20)
Stack: dc4ce000 00000001 00008913 dc4cff34 c02802e1 dc4cff34 dc4cff34 00000001
       c02805a3 dc4cff34 dc4ce000 c0282209 dc4cff34 bffff140 00000020 00000000
       30707070 08148d00 bffff168 0060de02 406962fc bffff1a0 00000089 00000012
Call Trace: [<c02802e1>]  [<c02805a3>]  [<c0282209>]  [<c02bb8e6>]  [<c0279315>]  [<c015c681>]  [<c010951b>]
Code: ac ae 75 08 84 c0 75 f5 31 c0 eb 04 19 c0 0c 01 85 c0 74 07
 <6>note: kppp[370] exited with preempt_count 1
Unable to handle kernel paging request at virtual address 64203361
 printing eip:
c0280249
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c0280249>]    Tainted: P
EFLAGS: 00010216
eax: ffffffff   ebx: c6831f34   ecx: 0000000f   edx: 64203361
esi: 64203361   edi: c6831f34   ebp: 00000010   esp: c6831ef4
ds: 007b   es: 007b   ss: 0068
Process kppp (pid: 631, threadinfo=c6830000 task=d873a1a0)
Stack: c6830000 00000001 00008913 c6831f34 c02802e1 c6831f34 c6831f34 00000001
       c02805a3 c6831f34 c6830000 c0282209 c6831f34 bfffe5a0 00000020 00000000
       30707070 00000200 080d67e0 00ffe5e0 bfffef78 4000aa80 bfffe5d4 00005410
Call Trace: [<c02802e1>]  [<c02805a3>]  [<c0282209>]  [<c02bb8e6>]  [<c0279315>]  [<c015c681>]  [<c010951b>]
Code: ac ae 75 08 84 c0 75 f5 31 c0 eb 04 19 c0 0c 01 85 c0 74 07
 <6>note: kppp[631] exited with preempt_count 1
Unable to handle kernel paging request at virtual address 0007003e
 printing eip:
c0280249
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c0280249>]    Tainted: P
EFLAGS: 00010216
eax: 00000001   ebx: c7925f34   ecx: 0000000f   edx: 0007003e
esi: 0007003e   edi: c7925f34   ebp: 00000010   esp: c7925ef4
ds: 007b   es: 007b   ss: 0068
Process kppp (pid: 632, threadinfo=c7924000 task=d873a1a0)
Stack: c7924000 00000001 00008913 c7925f34 c02802e1 c7925f34 c7925f34 00000001
       c02805a3 c7925f34 c7924000 c0282209 c7925f34 bffff130 00000020 00000000
       30707070 081ba300 bffff158 0060de02 406962fc bffff190 00000089 00000012
Call Trace: [<c02802e1>]  [<c02805a3>]  [<c0282209>]  [<c02bb8e6>]  [<c0279315>]  [<c015c681>]  [<c0119aa0>]  [<c010951b>]
Code: ac ae 75 08 84 c0 75 f5 31 c0 eb 04 19 c0 0c 01 85 c0 74 07
 <6>note: kppp[632] exited with preempt_count 1
Unable to handle kernel paging request at virtual address 0006000a
 printing eip:
c0280249
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c0280249>]    Tainted: P
EFLAGS: 00010216
eax: ffffffff   ebx: c2cbff34   ecx: 0000000f   edx: 0006000a
esi: 0006000a   edi: c2cbff34   ebp: 00000010   esp: c2cbfef4
ds: 007b   es: 007b   ss: 0068
Process kppp (pid: 640, threadinfo=c2cbe000 task=c8d16140)
Stack: c2cbe000 00000001 00008913 c2cbff34 c02802e1 c2cbff34 c2cbff34 00000001
       c02805a3 c2cbff34 c2cbe000 c0282209 c2cbff34 bfffe590 00000020 00000000
       30707070 00000200 080d67e0 00ffe5d0 bfffef68 4000aa80 bfffe5c4 00005410
Call Trace: [<c02802e1>]  [<c02805a3>]  [<c0282209>]  [<c02bb8e6>]  [<c0279315>]  [<c015c681>]  [<c010951b>]
Code: ac ae 75 08 84 c0 75 f5 31 c0 eb 04 19 c0 0c 01 85 c0 74 07
 <6>note: kppp[640] exited with preempt_count 1

--Boundary-00=_5YFI+fQfjdk1IDc--

