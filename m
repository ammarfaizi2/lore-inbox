Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262823AbUDAJHc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 04:07:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262814AbUDAJHb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 04:07:31 -0500
Received: from ua-online.net ([213.179.225.6]:52867 "EHLO center.hqhost.net")
	by vger.kernel.org with ESMTP id S262807AbUDAJEr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 04:04:47 -0500
From: Vladimir Klenov <maple@center.hqhost.net>
Date: Thu, 1 Apr 2004 12:04:40 +0300
To: linux-kernel@vger.kernel.org
Subject: oops on same place on two different machines (2.4.23,2.4.24)
Message-ID: <20040401090440.GA24164@valinor.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
On two different machines running 2.4.23-grsec, 2.4.24-grsec with last
holes patched appearing oopses in same place. Both serving
dynamic http content with apache 1.3

ksymoops output

first, 4G RAM, 2xP4 xeon 2.4G, HT, 64G RAM support enabled, ext3 as root, reiserfs
as /home with noatime,nodiratime, 2.4.23-grsec-2

ksymoops 2.4.9 on i686 2.4.23-grsec-2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.23-grsec-2/ (default)
     -m /boot2/System.map-2.4.23-grsec-2 (specified)

eip: c01c6c50
kernel BUG at /home/src/kernel/linux-2.4.23/include/asm/spinlock.h:133!
invalid operand: 0000
CPU:    3
EIP:    0010:[<c01c6c68>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: 0000000e   ebx: d9cda2c0   ecx: ffffffff   edx: c010256c
esi: f02cfde4   edi: 00000246   ebp: f02cfdc0   esp: f02cfdac
ds: 0018   es: 0018   ss: 0018
Process httpd (pid: 14513, stackpage=f02cf000)
Stack: c0346eb5 c01c6c50 f02ce000 f02cfde4 d9cda2c0 f02cfdf4 c020a9d9
d9cda204 
       d9cda204 c0242418 00000000 f02ce000 00000000 00000000 00000000
f02ce000 
       d9cda2c8 d9cda2c8 f02cfe0c c020bf8a d9cda204 00000000 f7d16cd0
0043bbf6 
Call Trace:    [<c01c6c50>] [<c020a9d9>] [<c0242418>] [<c020bf8a>]
[<c020c59a>]
  [<c0242418>] [<c02424de>] [<c0242418>] [<c023e1c0>] [<c01fd79d>]
[<c01fe404>]
  [<c01fe77d>] [<c01fe946>] [<c01feced>] [<c01fa5fe>] [<c01b5693>]
Code: 0f 0b 85 00 80 6e 34 c0 f0 fe 0b 0f 88 53 17 00 00 8d 4e 08 


>>EIP; c01c6c68 <remove_wait_queue+28/84>   <=====

>>ebx; d9cda2c0 <_end+19944f58/386d0cf8>
>>edx; c010256c <log_wait+0/10>
>>esi; f02cfde4 <_end+2ff3aa7c/386d0cf8>

 <_end+2ff3aa58/386d0cf8>
>>esp; f02cfdac <_end+2ff3aa44/386d0cf8>

Trace; c01c6c50 <remove_wait_queue+10/84>
Trace; c020a9d9 <__wait_on_freeing_inode+9d/d8>
Trace; c0242418 <reiserfs_find_actor+0/a0>
Trace; c020bf8a <find_inode+4e/6c>
Trace; c020c59a <iget4+72/164>
Trace; c0242418 <reiserfs_find_actor+0/a0>
Trace; c02424de <reiserfs_iget+26/6c>
Trace; c0242418 <reiserfs_find_actor+0/a0>
Trace; c023e1c0 <reiserfs_lookup+8c/d4>
Trace; c01fd79d <real_lookup+a9/168>
Trace; c01fe404 <link_path_walk+998/cf4>
Trace; c01fe77d <path_walk+1d/24>
Trace; c01fe946 <path_lookup+1e/2c>
Trace; c01feced <__user_walk+2d/48>
Trace; c01fa5fe <sys_lstat64+1a/70>
Trace; c01b5693 <system_call+33/40>

Code;  c01c6c68 <remove_wait_queue+28/84>
00000000 <_EIP>:
Code;  c01c6c68 <remove_wait_queue+28/84>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01c6c6a <remove_wait_queue+2a/84>
   2:   85 00                     test   %eax,(%eax)
Code;  c01c6c6c <remove_wait_queue+2c/84>
   4:   80 6e 34 c0               subb   $0xc0,0x34(%esi)
Code;  c01c6c70 <remove_wait_queue+30/84>
   8:   f0 fe 0b                  lock decb (%ebx)
Code;  c01c6c73 <remove_wait_queue+33/84>
   b:   0f 88 53 17 00 00         js     1764 <_EIP+0x1764>
Code;  c01c6c79 <remove_wait_queue+39/84>
  11:   8d 4e 08                  lea    0x8(%esi),%ecx





second, 4G RAM, 2xP4 xeon 2.4G, HT, 64G RAM support enabled, ext3, /home
with noatime,nodiratime

ksymoops 2.4.9 on i686 2.4.24-grsec-1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.24-grsec-1/ (default)
     -m /boot/System.map-2.4.24-grsec-1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

eip: c01dc180
kernel BUG at
/usr/src/kernel/linux-2.4.24-grsec/include/asm/spinlock.h:133!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c01dc1b4>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: 0000000e   ebx: d4a6de00   ecx: 00000002   edx: f6213f74
esi: efd5613c   edi: 00000292   ebp: d4a6ddd8   esp: d4a6ddbc
ds: 0018   es: 0018   ss: 0018
Process httpd (pid: 29534, stackpage=d4a6d000)
Stack: c03b04d8 c01dc180 c011a080 c011a090 d4a6c000 d4a6de00 efd5613c
d4a6de1c
       c0226e6d f774d600 f774d600 00000e00 00000000 00000000 d4a6c000
00000000
       00000000 00000000 d4a6c000 efd56144 efd56144 efd56080 efd56080
f7c81f48
Call Trace:    [<c01dc180>] [<c0226e6d>] [<c0227f1d>] [<c02285b9>]
[<c0242e2c>]
  [<c0219630>] [<c02194cb>] [<c0219cb4>] [<c02248e1>] [<c021a39a>]
[<c021a9ac>]
  [<c0337bd5>] [<c020a30c>] [<c0219063>] [<c020a721>] [<c01c7da3>]
Code: 0f 0b 85 00 e0 07 3b c0 f0 fe 0e 0f 88 40 1b 00 00 8d 4b 08

>>EIP; c01dc1b4 <remove_wait_queue+34/a0>   <=====

>>ebx; d4a6de00 <_end+146766c0/38544920>
>>edx; f6213f74 <_end+35e1c834/38544920>
>>esi; efd5613c <_end+2f95e9fc/38544920>
>>ebp; d4a6ddd8 <_end+14676698/38544920>
>>esp; d4a6ddbc <_end+1467667c/38544920>

Trace; c01dc180 <remove_wait_queue+0/a0>
Trace; c0226e6d <__wait_on_freeing_inode+8d/d0>
Trace; c0227f1d <find_inode+5d/70>
Trace; c02285b9 <iget4+89/190>
Trace; c0242e2c <ext3_lookup+6c/90>
Trace; c0219630 <real_lookup+110/190>
Trace; c02194cb <cached_lookup+1b/70>
Trace; c0219cb4 <link_path_walk+3c4/880>
Trace; c02248e1 <dput+31/210>
Trace; c021a39a <path_lookup+3a/40>
Trace; c021a9ac <open_namei+6c/7f0>
Trace; c0337bd5 <net_rx_action+b5/160>
Trace; c020a30c <filp_open+3c/60>
Trace; c0219063 <getname+93/d0>
Trace; c020a721 <sys_open+51/d0>
Trace; c01c7da3 <system_call+33/40>

Code;  c01dc1b4 <remove_wait_queue+34/a0>
00000000 <_EIP>:
Code;  c01dc1b4 <remove_wait_queue+34/a0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01dc1b6 <remove_wait_queue+36/a0>
   2:   85 00                     test   %eax,(%eax)
Code;  c01dc1b8 <remove_wait_queue+38/a0>
   4:   e0 07                     loopne d <_EIP+0xd>
Code;  c01dc1ba <remove_wait_queue+3a/a0>
   6:   3b c0                     cmp    %eax,%eax
Code;  c01dc1bc <remove_wait_queue+3c/a0>
   8:   f0 fe 0e                  lock decb (%esi)
Code;  c01dc1bf <remove_wait_queue+3f/a0>
   b:   0f 88 40 1b 00 00         js     1b51 <_EIP+0x1b51>
Code;  c01dc1c5 <remove_wait_queue+45/a0>
  11:   8d 4b 08                  lea    0x8(%ebx),%ecx


1 warning issued.  Results may not be reliable.


I can provide more information if needed

		SY, Vladimir
