Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264543AbTFLKET (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 06:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264646AbTFLKET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 06:04:19 -0400
Received: from 205-158-62-158.outblaze.com ([205.158.62.158]:55216 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP id S264543AbTFLKED
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 06:04:03 -0400
Message-ID: <20030612101744.7207.qmail@graffiti.net>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Christopher Chan" <lkml@graffiti.net>
To: linux-kernel@vger.kernel.org
Date: Thu, 12 Jun 2003 18:17:44 +0800
Subject: Sudden instabilty of mysql boxen
X-Originating-Ip: 202.81.246.192
X-Originating-Server: ws2.hk5.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Can somebody help out with pointers to why my boxes would suddenly
become unstable?

I have two boxes running mysql servers. The first one is running RH
7.3 with a 2.4.18-26 kernel that has the 3ware no bounce buffer patch
enabled (the src.rpm was downloaded, 3ware patch enabled and
rpmbuild) and the second one is running Rh 7.0 with a 2.4.2-ac28
kernel. The 3ware box handles over 600 queries per second.

The first box runs on a linux software mirrored array but has the
mysql data on a 3ware stripped mirrored array while the second one
runs on a linux software mirrored array (got two disks only).

They both suddenly started vomiting messages like:

Code: 8b 42 04 83 f8 ff 0f 84 6f 01 00 00 83 f8 fc 77 07 c7 42 04
 <1>Unable to handle kernel NULL pointer dereference at virtual
address 00000004

Code: 8b 42 04 83 f8 ff 0f 84 6f 01 00 00 83 f8 fc 77 07 c7 42 04
 Oops: 0000

and any commands you run on shells (if you them in the first place)
would exit with a segmentation fault. All attempts to ssh into the
box would fail after successful authentication with the connection
being closed (bash segfault?)

A reboot would cause them to run normally until they start acting up
again minutes later.

Here are the oops from the 3ware box run through ksymoops:

ksymoops 2.4.4 on i686 2.4.18-26.7.x.3ware.outblazesmp.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-26.7.x.3ware.outblazesmp/ (default)
     -m /boot/System.map-2.4.18-26.7.x.3ware.outblazesmp (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (expand_objects): cannot stat(/lib/ext3.o) for ext3
Error (expand_objects): cannot stat(/lib/jbd.o) for jbd
Error (expand_objects): cannot stat(/lib/raid1.o) for raid1
Error (expand_objects): cannot stat(/lib/3w-xxxx.o) for 3w-xxxx
Error (expand_objects): cannot stat(/lib/sd_mod.o) for sd_mod
Error (expand_objects): cannot stat(/lib/scsi_mod.o) for scsi_mod
Error (pclose_local): find_objects pclose failed 0x100
Warning (map_ksym_to_module): cannot match loaded module ext3 to a unique module object.  Trace may not be reliable.
Code: 8b 42 04 83 f8 ff 0f 84 6f 01 00 00 83 f8 fc 77 07 c7 42 04
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 42 04                  mov    0x4(%edx),%eax
Code;  00000003 Before first symbol
   3:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  00000006 Before first symbol
   6:   0f 84 6f 01 00 00         je     17b <_EIP+0x17b> 0000017b Before first symbol
Code;  0000000c Before first symbol
   c:   83 f8 fc                  cmp    $0xfffffffc,%eax
Code;  0000000f Before first symbol
   f:   77 07                     ja     18 <_EIP+0x18> 00000018 Before first symbol
Code;  00000011 Before first symbol
  11:   c7 42 04 00 00 00 00      movl   $0x0,0x4(%edx)

 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
f78a1842
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<f78a1842>]    Not tainted
EFLAGS: 00010286
eax: bfffede4   ebx: e8922000   ecx: 00000000   edx: 00000000
esi: c0108ca3   edi: 0000000b   ebp: e8923fb8   esp: e8923f80
ds: 0018   es: 0018   ss: 0018
Process id (pid: 2824, stackpage=e8923000)
Stack: e8922000 c0108ca3 0000000b f69af000 c014da2e f69af000 f69af000 0000000b
       00000000 bfffede4 0000000b 00000000 00000a3a 00000020 bfffef58 f78a1a36
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Call Trace: [<c0108ca3>] system_call [kernel] 0x33 (0xe8923f84))
[<c014da2e>] getname [kernel] 0x5e (0xe8923f90))
Code: 8b 42 04 83 f8 ff 0f 84 6f 01 00 00 83 f8 fc 77 07 c7 42 04

>>EIP; f78a1842 <_end+37468ca6/383d4464>   <=====
Trace; c0108ca3 <system_call+33/38>
Trace; c014da2e <.text.lock.pipe+42/b4>
Code;  f78a1842 <_end+37468ca6/383d4464>
00000000 <_EIP>:
Code;  f78a1842 <_end+37468ca6/383d4464>   <=====
   0:   8b 42 04                  mov    0x4(%edx),%eax   <=====
Code;  f78a1845 <_end+37468ca9/383d4464>
   3:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  f78a1848 <_end+37468cac/383d4464>
   6:   0f 84 6f 01 00 00         je     17b <_EIP+0x17b> f78a19bd <_end+37468e21/383d4464>
Code;  f78a184e <_end+37468cb2/383d4464>
   c:   83 f8 fc                  cmp    $0xfffffffc,%eax
Code;  f78a1851 <_end+37468cb5/383d4464>
   f:   77 07                     ja     18 <_EIP+0x18> f78a185a <_end+37468cbe/383d4464>
Code;  f78a1853 <_end+37468cb7/383d4464>
  11:   c7 42 04 00 00 00 00      movl   $0x0,0x4(%edx)

 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
f78a1842
*pde = 00000000
Oops: 0000
CPU:    3
EIP:    0010:[<f78a1842>]    Not tainted
EFLAGS: 00010286
eax: bfffe9e4   ebx: e8922000   ecx: 00000000   edx: 00000000
esi: c0108ca3   edi: 0000000b   ebp: e8923fb8   esp: e8923f80
ds: 0018   es: 0018   ss: 0018
Process id (pid: 2826, stackpage=e8923000)
Stack: e8922000 c0108ca3 0000000b f69ae000 c014da2e f69ae000 f69ae000 0000000b
       00000000 bfffe9e4 0000000b 00000000 00000a3a 00000020 bffff128 f78a1a36
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Call Trace: [<c0108ca3>] system_call [kernel] 0x33 (0xe8923f84))
[<c014da2e>] getname [kernel] 0x5e (0xe8923f90))
Code: 8b 42 04 83 f8 ff 0f 84 6f 01 00 00 83 f8 fc <1>Unable to handle kernel NULL pointer dereference77 07 c7 42 04
Warning (Oops_code): trailing garbage ignored on Code: line
  Text: 'Code: 8b 42 04 83 f8 ff 0f 84 6f 01 00 00 83 f8 fc <1>Unable to handle kernel NULL pointer dereference77 07 c7 42 04'
  Garbage: 'Unable to handle kernel NULL pointer dereference77 07 c7 42 04'
Error (Oops_code_values): invalid value 0x1 in Code line, must be 2, 4, 8 or 16 digits, value ignored

>>EIP; f78a1842 <_end+37468ca6/383d4464>   <=====
Trace; c0108ca3 <system_call+33/38>
Trace; c014da2e <.text.lock.pipe+42/b4>
Code;  f78a1833 <_end+37468c97/383d4464>
00000000 <_EIP>:
Code;  f78a1833 <_end+37468c97/383d4464>
   0:   8b 42 04                  mov    0x4(%edx),%eax
Code;  f78a1836 <_end+37468c9a/383d4464>
   3:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  f78a1839 <_end+37468c9d/383d4464>
   6:   0f 84 6f 01 00 00         je     17b <_EIP+0x17b> f78a19ae <_end+37468e12/383d4464>
Code;  f78a183f <_end+37468ca3/383d4464>
   c:   83 f8 fc                  cmp    $0xfffffffc,%eax

f78a1842
*pde = 00000000
Oops: 0000
CPU:    2
EIP:    0010:[<f78a1842>]    Not tainted
EFLAGS: 00010282
eax: bfffe8c4   ebx: e8776000   ecx: 00000000   edx: 00000000
esi: c0108ca3   edi: 0000000b   ebp: e8777fb8   esp: e8777f80
ds: 0018   es: 0018   ss: 0018
Process ifconfig (pid: 2827, stackpage=e8777000)
Stack: e8776000 c0108ca3 0000000b f7971000 c014da2e f7971000 f7971000 0000000b
       00000000 bfffe8c4 0000000b 00000000 00000a3a 00000020 bfffe528 f78a1a36
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Call Trace: [<c0108ca3>] system_call [kernel] 0x33 (0xe8777f84))
[<c014da2e>] getname [kernel] 0x5e (0xe8777f90))
Code: 8b 42 04 83 f8 ff 0f 84 6f 01 00 00 83 f8 fc 77 07 c7 42 04

>>EIP; f78a1842 <_end+37468ca6/383d4464>   <=====
Trace; c0108ca3 <system_call+33/38>
Trace; c014da2e <.text.lock.pipe+42/b4>
Code;  f78a1842 <_end+37468ca6/383d4464>
00000000 <_EIP>:
Code;  f78a1842 <_end+37468ca6/383d4464>   <=====
   0:   8b 42 04                  mov    0x4(%edx),%eax   <=====
Code;  f78a1845 <_end+37468ca9/383d4464>
   3:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  f78a1848 <_end+37468cac/383d4464>
   6:   0f 84 6f 01 00 00         je     17b <_EIP+0x17b> f78a19bd <_end+37468e21/383d4464>
Code;  f78a184e <_end+37468cb2/383d4464>
   c:   83 f8 fc                  cmp    $0xfffffffc,%eax
Code;  f78a1851 <_end+37468cb5/383d4464>
   f:   77 07                     ja     18 <_EIP+0x18> f78a185a <_end+37468cbe/383d4464>
Code;  f78a1853 <_end+37468cb7/383d4464>
  11:   c7 42 04 00 00 00 00      movl   $0x0,0x4(%edx)

 <1>Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel NULL pointer dereference<1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
f78a1842
*pde = 00000000
f78a1842
f78a180000
f78a1842
*pde = 00000000
*pde = 00000000
CPU:    0
EIP:    0010:[<f78a1842>]    Not tainted
EFLAGS: 00010282
eax: bfffe204   ebx: e7e12000   ecx: 00000000   edx: 00000000
esi: c0108ca3   edi: 0000000b   ebp: e7e13fb8   esp: e7e13f80
ds: 0018   es: 0018   ss: 0018
Process grep (pid: 2838, stackpage=e7e13000)
Stack: e7e12000 c0108ca3 0000000b f69b1000 c014da2e f69b1000 f69b1000 0000000b
       00000000 bfffe204 0000000b 00000000 00000a3a 00000020 bfffdf78 f78a1a36
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Call Trace: [<c0108ca3>] system_call [kernel] 0x33 (0xe7e13f84))
[<c014da2e>] getname [kernel] 0x5e (0xe7e13f90))
Code: 8b 42 04 83 f8 ff 0f 84 6f 01 00 00 83 f8 fc 77 07 c7 42 04

>>EIP; f78a1842 <_end+37468ca6/383d4464>   <=====
Trace; c0108ca3 <system_call+33/38>
Trace; c014da2e <.text.lock.pipe+42/b4>
Code;  f78a1842 <_end+37468ca6/383d4464>
00000000 <_EIP>:
Code;  f78a1842 <_end+37468ca6/383d4464>   <=====
   0:   8b 42 04                  mov    0x4(%edx),%eax   <=====
Code;  f78a1845 <_end+37468ca9/383d4464>
   3:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  f78a1848 <_end+37468cac/383d4464>
   6:   0f 84 6f 01 00 00         je     17b <_EIP+0x17b> f78a19bd <_end+37468e21/383d4464>
Code;  f78a184e <_end+37468cb2/383d4464>
   c:   83 f8 fc                  cmp    $0xfffffffc,%eax
Code;  f78a1851 <_end+37468cb5/383d4464>
   f:   77 07                     ja     18 <_EIP+0x18> f78a185a <_end+37468cbe/383d4464>
Code;  f78a1853 <_end+37468cb7/383d4464>
  11:   c7 42 04 00 00 00 00      movl   $0x0,0x4(%edx)

 Oops: 0000
CPU:    2
EIP:    0010:[<f78a1842>]    Not tainted
EFLAGS: 00010286
eax: bfffe174   ebx: e7e04000   ecx: 00000000   edx: 00000000
esi: c0108ca3   edi: 0000000b   ebp: e7e05fb8   esp: e7e05f80
ds: 0018   es: 0018   ss: 0018
Process cut (pid: 2839, stackpage=e7e05000)
Stack: e7e04000 c0108ca3 0000000b f7971000 c014da2e f7971000 f7971000 0000000b
       00000000 bfffe174 0000000b 00000000 00000a3a 00000020 bfffdf78 f78a1a36
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Call Trace: [<c0108ca3>] system_call [kernel] 0x33 (0xe7e05f84))
[<c014da2e>] getname [kernel] 0x5e (0xe7e05f90))
Code: 8b 42 04 83 f8 ff 0f 84 6f 01 00 00 83 f8 fc 77 07 c7 42 04

>>EIP; f78a1842 <_end+37468ca6/383d4464>   <=====
Trace; c0108ca3 <system_call+33/38>
Trace; c014da2e <.text.lock.pipe+42/b4>
Code;  f78a1842 <_end+37468ca6/383d4464>
00000000 <_EIP>:
Code;  f78a1842 <_end+37468ca6/383d4464>   <=====
   0:   8b 42 04                  mov    0x4(%edx),%eax   <=====
Code;  f78a1845 <_end+37468ca9/383d4464>
   3:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  f78a1848 <_end+37468cac/383d4464>
   6:   0f 84 6f 01 00 00         je     17b <_EIP+0x17b> f78a19bd <_end+37468e21/383d4464>
Code;  f78a184e <_end+37468cb2/383d4464>
   c:   83 f8 fc                  cmp    $0xfffffffc,%eax
Code;  f78a1851 <_end+37468cb5/383d4464>
   f:   77 07                     ja     18 <_EIP+0x18> f78a185a <_end+37468cbe/383d4464>
Code;  f78a1853 <_end+37468cb7/383d4464>
  11:   c7 42 04 00 00 00 00      movl   $0x0,0x4(%edx)

 Oops: 0000
CPU:    3
EIP:    0010:[<f78a1842>]    Not tainted
EFLAGS: 00010286
eax: bfffe274   ebx: e7e24000   ecx: 00000000   edx: 00000000
esi: c0108ca3   edi: 0000000b   ebp: e7e25fb8   esp: e7e25f80
ds: 0018   es: 0018   ss: 0018
Process cat (pid: 2837, stackpage=e7e25000)
Stack: e7e24000 c0108ca3 0000000b f69ae000 c014da2e f69ae000 f69ae000 0000000b
       00000000 bfffe274 0000000b 00000000 00000a3a 00000020 bfffdf78 f78a1a36
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Call Trace: [<c0108ca3>] system_call [kernel] 0x33 (0xe7e25f84))
Unable to handle kernel NULL pointer dereference[<c014da2e>] getname [kernel] 0x5e (0xe7e25f90))
Code: 8b 42 04  printing eip:
Warning (Oops_code): trailing garbage ignored on Code: line
  Text: 'Code: 8b 42 04  printing eip:'
  Garbage: '  printing eip:'

>>EIP; f78a1842 <_end+37468ca6/383d4464>   <=====
Trace; c0108ca3 <system_call+33/38>
Code;  f78a1842 <_end+37468ca6/383d4464>
00000000 <_EIP>:
Code;  f78a1842 <_end+37468ca6/383d4464>
   0:   8b 42 04                  mov    0x4(%edx),%eax

 Oops: 0000
CPU:    1
EIP:    0010:[<f78a1842>]    Not tainted
EFLAGS: 00010282
eax: bfffe694   ebx: e7b4e000   ecx: f7358000   edx: 00000000
esi: c0108ca3   edi: 0000000b   ebp: e7b4ffb8   esp: e7b4ff80
ds: 0018   es: 0018   ss: 0018
Process w (pid: 2840, stackpage=e7b4f000)
Stack: e7b4e000 c0108ca3 0000000b f69af000 c014da2e f69af000 f69af000 0000000b
       00000000 bfffe694 0000000b 00000000 00000a3a 00000020 bfffe888 f78a1a36
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Call Trace: [<c0108ca3>] system_call [kernel] 0x33 (0xe7b4ff84))
[<c014da2e>] getname [kernel] 0x5e (0xe7b4ff90))
Code: 8b 42 04 83 f8 ff 0f 84 6f 01 00 00 83 f8 fc 77 07 c7 42 04

>>EIP; f78a1842 <_end+37468ca6/383d4464>   <=====
Trace; c0108ca3 <system_call+33/38>
Trace; c014da2e <.text.lock.pipe+42/b4>
Code;  f78a1842 <_end+37468ca6/383d4464>
00000000 <_EIP>:
Code;  f78a1842 <_end+37468ca6/383d4464>   <=====
   0:   8b 42 04                  mov    0x4(%edx),%eax   <=====
Code;  f78a1845 <_end+37468ca9/383d4464>
   3:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  f78a1848 <_end+37468cac/383d4464>
   6:   0f 84 6f 01 00 00         je     17b <_EIP+0x17b> f78a19bd <_end+37468e21/383d4464>
Code;  f78a184e <_end+37468cb2/383d4464>
   c:   83 f8 fc                  cmp    $0xfffffffc,%eax
Code;  f78a1851 <_end+37468cb5/383d4464>
   f:   77 07                     ja     18 <_EIP+0x18> f78a185a <_end+37468cbe/383d4464>
Code;  f78a1853 <_end+37468cb7/383d4464>
  11:   c7 42 04 00 00 00 00      movl   $0x0,0x4(%edx)

 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
f78a1842
*pde = 00000000
Unable to handle kernel NULL pointer dereferenceOops: 0000
CPU:    1
EIP:    0010:[<f78a1842>]    Not tainted
EFLAGS: 00010282
f78a1842
*pde = 00000000
eax: bffff164   ebx: e745c000   ecx: 00000000   edx: 00000000
esi: c0108ca3   edi: 0000000b   ebp: e745dfb8   esp: e745df80
ds: 0018   es: 0018   ss: 0018
Process id (pid: 2846, stackpage=e745d000)
Stack: e745c000 c0108ca3 0000000b f69af000 c014da2e f69af000 f69af000 0000000b
       00000000 bffff164 0000000b 00000000 00000a3a 00000020 bfffe658 f78a1a36
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[<c014da2e>] getname [kernel] 0x5e (0xe745df90))
Code: 8b 42 04 83 f8 ff 0f 84 6f 01 00 00 83 f8 fc 77 07 c7 42 04

>>EIP; f78a1842 <_end+37468ca6/383d4464>   <=====
Code;  f78a1842 <_end+37468ca6/383d4464>
00000000 <_EIP>:
Code;  f78a1842 <_end+37468ca6/383d4464>   <=====
   0:   8b 42 04                  mov    0x4(%edx),%eax   <=====
Code;  f78a1845 <_end+37468ca9/383d4464>
   3:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  f78a1848 <_end+37468cac/383d4464>
   6:   0f 84 6f 01 00 00         je     17b <_EIP+0x17b> f78a19bd <_end+37468e21/383d4464>
Code;  f78a184e <_end+37468cb2/383d4464>
   c:   83 f8 fc                  cmp    $0xfffffffc,%eax
Code;  f78a1851 <_end+37468cb5/383d4464>
   f:   77 07                     ja     18 <_EIP+0x18> f78a185a <_end+37468cbe/383d4464>
Code;  f78a1853 <_end+37468cb7/383d4464>
  11:   c7 42 04 00 00 00 00      movl   $0x0,0x4(%edx)

 Oops: 0000
Unable to handle kernel NULL pointer dereferenceeepro100 usb-uhci usbcore ext3 jbd raid1 3w-xxxx sd_mod scsi_mod
CPU:    3
EIP:    0010:[<f78a1842>]    Not tainted
EFLAGS: 00010282
f78a1842
*pde = 00000000
eax: bfffedf4   ebx: e742e000   ecx: f7358000   edx: 00000000
esi: c0108ca3   edi: 0000000b   ebp: e742ffb8   esp: e742ff80
ds: 0018   es: 0018   ss: 0018
Process sh (pid: 2848, stackpage=e742f000)
Stack: e742e000 c0108ca3 0000000b f69ae000 c014da2e f69ae000 f69ae000 0000000b
       00000000 bfffedf4 0000000b 00000000 00000a3a 00000020 bfffdaa8 f78a1a36
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Call Trace: [<c0108ca3>] system_call [kernel] 0x33 (0xe742ff84))
[<c014da2e>] getname [kernel] 0x5e (0xe742ff90))
Code: 8b 42 04 83 f8 ff 0f 84 6f 01 00 00 83 f8 fc 77 07 c7 42 04

>>EIP; f78a1842 <_end+37468ca6/383d4464>   <=====
Trace; c0108ca3 <system_call+33/38>
Trace; c014da2e <.text.lock.pipe+42/b4>
Code;  f78a1842 <_end+37468ca6/383d4464>
00000000 <_EIP>:
Code;  f78a1842 <_end+37468ca6/383d4464>   <=====
   0:   8b 42 04                  mov    0x4(%edx),%eax   <=====
Code;  f78a1845 <_end+37468ca9/383d4464>
   3:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  f78a1848 <_end+37468cac/383d4464>
   6:   0f 84 6f 01 00 00         je     17b <_EIP+0x17b> f78a19bd <_end+37468e21/383d4464>
Code;  f78a184e <_end+37468cb2/383d4464>
   c:   83 f8 fc                  cmp    $0xfffffffc,%eax
Code;  f78a1851 <_end+37468cb5/383d4464>
   f:   77 07                     ja     18 <_EIP+0x18> f78a185a <_end+37468cbe/383d4464>
Code;  f78a1853 <_end+37468cb7/383d4464>
  11:   c7 42 04 00 00 00 00      movl   $0x0,0x4(%edx)

 Oops: 0000
CPU:    1
EIP:    0010:[<f78a1842>]    Not tainted
EFLAGS: 00010282
eax: bffff664   ebx: e7348000   ecx: 00000000   edx: 00000000
esi: c0108ca3   edi: 0000000b   ebp: e7349fb8   esp: e7349f80
ds: 0018   es: 0018   ss: 0018
Process id (pid: 2850, stackpage=e7349000)
Stack: e7348000 c0108ca3 0000000b f69af000 c014da2e f69af000 f69af000 0000000b
       00000000 bffff664 0000000b 00000000 00000a3a 00000020 bfffe658 f78a1a36
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Call Trace: [<c0108ca3>] system_call [kernel] 0x33 (0xe7349f84))
[<c014da2e>] getname [kernel] 0x5e (0xe7349f90))
Code: 8b 42 04 83 f8 ff 0f 84 6f 01 00 00 83 f8 fc 77 07 c7 42 04

>>EIP; f78a1842 <_end+37468ca6/383d4464>   <=====
Trace; c0108ca3 <system_call+33/38>
Trace; c014da2e <.text.lock.pipe+42/b4>
Code;  f78a1842 <_end+37468ca6/383d4464>
00000000 <_EIP>:
Code;  f78a1842 <_end+37468ca6/383d4464>   <=====
   0:   8b 42 04                  mov    0x4(%edx),%eax   <=====
Code;  f78a1845 <_end+37468ca9/383d4464>
   3:   83 f8 ff                  cmp    $0xffffffff,%eax
Code;  f78a1848 <_end+37468cac/383d4464>
   6:   0f 84 6f 01 00 00         je     17b <_EIP+0x17b> f78a19bd <_end+37468e21/383d4464>
Code;  f78a184e <_end+37468cb2/383d4464>
   c:   83 f8 fc                  cmp    $0xfffffffc,%eax
Code;  f78a1851 <_end+37468cb5/383d4464>
   f:   77 07                     ja     18 <_EIP+0x18> f78a185a <_end+37468cbe/383d4464>
Code;  f78a1853 <_end+37468cb7/383d4464>
  11:   c7 42 04 00 00 00 00      movl   $0x0,0x4(%edx)

 <1>Unable to handle kernel NULL pointer dereference at virtual address 00000004
f78a1842
*pde = 00000000
Oops: 0000
CPU:    3
EIP:    0010:[<f78a1842>]    Not tainted
EFLAGS: 00010282
eax: bffff364   ebx: e7348000   ecx: 00000000   edx: 00000000
esi: c0108ca3   edi: 0000000b   ebp: e7349fb8   esp: e7349f80
ds: 0018   es: 0018   ss: 0018
Process id (pid: 2852, stackpage=e7349000)
Stack: e7348000 c0108ca3 0000000b f69ae000 c014da2e f69ae000 f69ae000 0000000b
       00000000 bffff364 0000000b 00000000 00000a3a 00000020 bfffe828 f78a1a36
       00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
Call Trace: [<c0108ca3>] system_call [kernel] 0x33 (0xe7349f84))
[<c014da2e>] getname [kernel] 0x5e (0xe7349f90))
Warning (Oops_read): Code line not seen, dumping what data is available

>>EIP; f78a1842 <_end+37468ca6/383d4464>   <=====
Trace; c0108ca3 <system_call+33/38>
Trace; c014da2e <.text.lock.pipe+42/b4>


5 warnings and 8 errors issued.  Results may not be reliable.

-- 
_______________________________________________
Get your free email from http://www.graffiti.net

Powered by Outblaze
