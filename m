Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbVHIPpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbVHIPpE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 11:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbVHIPpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 11:45:03 -0400
Received: from talin.podgorze.pl ([195.225.250.33]:38633 "EHLO
	thinkpaddie.zlew.org") by vger.kernel.org with ESMTP
	id S964827AbVHIPpA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 11:45:00 -0400
From: Grzegorz Piotr Jaskiewicz <gj@kde.org.uk>
Organization: KDE
To: linux-kernel@vger.kernel.org
Subject: oops in VMWARE vmnet, on 2.6.12.x
Date: Tue, 9 Aug 2005 17:44:33 +0200
User-Agent: KMail/1.8.90
X-Face: ?m}EMc-C]"l7<^`)a1NYO-('xy3:5V{82Z^-/D3^[MU8IHkf$o`~%CC5D4[GhaIgk/$oN7
	Y7;f}!(<IG>ooAGiKCVs$m~P1B-8Vt=]<V,FX{h4@fK/?Qtg]5ofD|P~&)q:6H>~1Nt2fh
	s-iKbN$.Ne^1(4tdwmmW>ew'=LPv+{{=YE=LoZU-5kfYnZSa`P7Q4pW]tKmUk`@&}M,dn-
	Kh{hA{~Ls4a$NjJI@1_f')]3|_}!GoJZss[Q$D-#l^.4GxPp[p:s<S~B&+6)
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508091744.33523@gj-laptop>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know that in general no one here is interested in vmware affairs, but in 
hope that VMware folks are reading this list too, here's the oops:
It's the newest vmware5 for linux from vmware.com

ksymoops 2.4.9 on i686 2.6.12.4.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.12.4/ (default)
     -m /boot/System.map-2.6.12.4 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
c02993d7
*pde = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c02993d7>]    Tainted: P      VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282   (2.6.12.4)
eax: 00000001   ebx: d559e800   ecx: 0000000b   edx: df307800
esi: d559e80c   edi: 00000000   ebp: d1a4fdf0   esp: d1a4fdd0
ds: 007b   es: 007b   ss: 0068
Stack: 00000000 df307800 ffffffff 0000000a df307934 d559e800 d559e80c 00000000
       d1a4fe14 e1a31707 00000010 00000020 00000001 00000000 d559e800 df307805
       d559e811 d1a4fe3c e1a3187a d559e800 d559e80c d1a4fe34 c01381a6 d559e80c
Call Trace:
 [<c0103c2b>] show_stack+0x80/0x96
 [<c0103dbb>] show_registers+0x15a/0x1d1
 [<c0103fa7>] die+0xd2/0x14b
 [<c0115c8f>] do_page_fault+0x455/0x68e
 [<c01038a3>] error_code+0x4f/0x54
 [<e1a31707>] VNetBridgeUp+0xe5/0x16b [vmnet]
 [<e1a3187a>] VNetBridgeNotify+0x7e/0x167 [vmnet]
 [<c029fb49>] register_netdevice_notifier+0x6f/0x74
 [<e1a3104c>] VNetBridge_Create+0x88/0x279 [vmnet]
 [<e1a2e67c>] VNetFileOpIoctl+0x24a/0x4d3 [vmnet]
 [<c0164657>] do_ioctl+0x4f/0x74
 [<c01647bc>] vfs_ioctl+0x62/0x1c2
 [<c0164993>] sys_ioctl+0x77/0x84
 [<c0102d81>] syscall_call+0x7/0xb
Code: e9 39 fc ff ff ba ea ff ff ff c7 85 68 ff ff ff 04 00 00 00 e9 fd fb ff 
ff 55 89 e5 83 ec 20 8b 45 10 89 5d f4 89 75 f8 89 7d fc <8b> 70 68 85 f6 0f 
84 02 01 00 00 8b 55 0c 89 34 24 89 54 24 04


>>EIP; c02993d7 <sk_alloc+12/150>   <=====

>>ebx; d559e800 <pg0+1516c800/3fbcc400>
>>edx; df307800 <pg0+1eed5800/3fbcc400>
>>esi; d559e80c <pg0+1516c80c/3fbcc400>
>>ebp; d1a4fdf0 <pg0+1161ddf0/3fbcc400>
>>esp; d1a4fdd0 <pg0+1161ddd0/3fbcc400>

Trace; c0103c2b <show_stack+80/96>
Trace; c0103dbb <show_registers+15a/1d1>
Trace; c0103fa7 <die+d2/14b>
Trace; c0115c8f <do_page_fault+455/68e>
Trace; c01038a3 <error_code+4f/54>
Trace; e1a31707 <pg0+215ff707/3fbcc400>
Trace; e1a3187a <pg0+215ff87a/3fbcc400>
Trace; c029fb49 <register_netdevice_notifier+6f/74>
Trace; e1a3104c <pg0+215ff04c/3fbcc400>
Trace; e1a2e67c <pg0+215fc67c/3fbcc400>
Trace; c0164657 <do_ioctl+4f/74>
Trace; c01647bc <vfs_ioctl+62/1c2>
Trace; c0164993 <sys_ioctl+77/84>
Trace; c0102d81 <syscall_call+7/b>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c02993ac <sock_getsockopt+43d/456>
00000000 <_EIP>:
Code;  c02993ac <sock_getsockopt+43d/456>
   0:   e9 39 fc ff ff            jmp    fffffc3e <_EIP+0xfffffc3e>
Code;  c02993b1 <sock_getsockopt+442/456>
   5:   ba ea ff ff ff            mov    $0xffffffea,%edx
Code;  c02993b6 <sock_getsockopt+447/456>
   a:   c7 85 68 ff ff ff 04      movl   $0x4,0xffffff68(%ebp)
Code;  c02993bd <sock_getsockopt+44e/456>
  11:   00 00 00
Code;  c02993c0 <sock_getsockopt+451/456>
  14:   e9 fd fb ff ff            jmp    fffffc16 <_EIP+0xfffffc16>
Code;  c02993c5 <sk_alloc+0/150>
  19:   55                        push   %ebp
Code;  c02993c6 <sk_alloc+1/150>
  1a:   89 e5                     mov    %esp,%ebp
Code;  c02993c8 <sk_alloc+3/150>
  1c:   83 ec 20                  sub    $0x20,%esp
Code;  c02993cb <sk_alloc+6/150>
  1f:   8b 45 10                  mov    0x10(%ebp),%eax
Code;  c02993ce <sk_alloc+9/150>
  22:   89 5d f4                  mov    %ebx,0xfffffff4(%ebp)
Code;  c02993d1 <sk_alloc+c/150>
  25:   89 75 f8                  mov    %esi,0xfffffff8(%ebp)
Code;  c02993d4 <sk_alloc+f/150>
  28:   89 7d fc                  mov    %edi,0xfffffffc(%ebp)

This decode from eip onwards should be reliable

Code;  c02993d7 <sk_alloc+12/150>
00000000 <_EIP>:
Code;  c02993d7 <sk_alloc+12/150>   <=====
   0:   8b 70 68                  mov    0x68(%eax),%esi   <=====
Code;  c02993da <sk_alloc+15/150>
   3:   85 f6                     test   %esi,%esi
Code;  c02993dc <sk_alloc+17/150>
   5:   0f 84 02 01 00 00         je     10d <_EIP+0x10d>
Code;  c02993e2 <sk_alloc+1d/150>
   b:   8b 55 0c                  mov    0xc(%ebp),%edx
Code;  c02993e5 <sk_alloc+20/150>
   e:   89 34 24                  mov    %esi,(%esp)
Code;  c02993e8 <sk_alloc+23/150>
  11:   89 54 24 04               mov    %edx,0x4(%esp)


Thanks.

-- 
GJ

Binary system, you're either 1 or 0...
dead or alive ;)
