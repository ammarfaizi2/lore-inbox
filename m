Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268343AbTCFUPw>; Thu, 6 Mar 2003 15:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268341AbTCFUPv>; Thu, 6 Mar 2003 15:15:51 -0500
Received: from kilo.rb.xcalibre.co.uk ([217.204.38.22]:15110 "EHLO
	kilo.rb.xcalibre.co.uk") by vger.kernel.org with ESMTP
	id <S268332AbTCFUPh>; Thu, 6 Mar 2003 15:15:37 -0500
Envelope-to: linux-kernel@vger.kernel.org
From: Alistair Strachan <alistair@devzero.co.uk>
To: linux-kernel@vger.kernel.org
Subject: [2.5.64-mm1] sysfs oops
Date: Thu, 6 Mar 2003 20:26:18 +0000
User-Agent: KMail/1.5.9
Cc: thundercloud@devzero.co.uk
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_q76Z+DzZ9tVTMK7"
Message-Id: <200303062026.18224.alistair@devzero.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_q76Z+DzZ9tVTMK7
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

The following was experienced while running Andrew's 2.5.64-mm1 kernel. My 
dialup (ppp) connection was terminated, and when I attempted to re-establish, 
pppd would not come up. I found the following oops in dmesg and have provided 
a decoded version below.

This doesn't appear to be fixed in mainline, yet. Is it mm specific? dcache?

Cheers,
Alistair Strachan.

--Boundary-00=_q76Z+DzZ9tVTMK7
Content-Type: text/plain;
  charset="us-ascii";
  name="ksymoops"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ksymoops"

ksymoops 2.4.8 on i686 2.5.64-mm1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.64-mm1/ (default)
     -m /boot/System.map-2.5.64-mm1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
kernel BUG at include/linux/dcache.h:266!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c01759fc>]    Tainted: PF
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: dc6d9184   ecx: 00000000   edx: 00000000
esi: d7b9d300   edi: c959a000   ebp: 00000000   esp: c959bed8
ds: 007b   es: 007b   ss: 0068
Stack: c02b0fc1 dc6d9000 c03455f4 dc6d9184 dc6d9000 c959a000 00000000 c01afb73
       dc6d9184 dc6d9184 c01afba3 dc6d9184 00000000 c026b64d dc6d9184 00000006
       dc6d9000 00000000 dc6d9000 dfd2b680 c0334600 c01f0bbd dc6d9000 cd57d440
Call Trace: [<c02b0fc1>]  [<c01afb73>]  [<c01afba3>]  [<c026b64d>]  [<c01f0bbd>]  [<c01ee67c>]  [<c01edb06>]  [<c0149e68>]  [<c0158e45>]  [<c0148700>]  [<c01090c7>]
Code: 0f 0b 0a 01 9e 23 2e c0 ff 06 83 4e 04 08 85 f6 0f 84 02 01


>>EIP; c01759fc <sysfs_remove_dir+1c/13c>   <=====

Trace; c02b0fc1 <addrconf_notify+71/e0>
Trace; c01afb73 <kobject_del+13/30>
Trace; c01afba3 <kobject_unregister+13/30>
Trace; c026b64d <unregister_netdevice+1bd/295>
Trace; c01f0bbd <ppp_shutdown_interface+ad/120>
Trace; c01ee67c <ppp_ioctl+7cc/800>
Trace; c01edb06 <ppp_release+46/70>
Trace; c0149e68 <__fput+98/e0>
Trace; c0158e45 <sys_ioctl+c5/250>
Trace; c0148700 <sys_close+50/60>
Trace; c01090c7 <syscall_call+7/b>

Code;  c01759fc <sysfs_remove_dir+1c/13c>
00000000 <_EIP>:
Code;  c01759fc <sysfs_remove_dir+1c/13c>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c01759fe <sysfs_remove_dir+1e/13c>
   2:   0a 01                     or     (%ecx),%al
Code;  c0175a00 <sysfs_remove_dir+20/13c>
   4:   9e                        sahf   
Code;  c0175a01 <sysfs_remove_dir+21/13c>
   5:   23 2e                     and    (%esi),%ebp
Code;  c0175a03 <sysfs_remove_dir+23/13c>
   7:   c0 ff 06                  sar    $0x6,%bh
Code;  c0175a06 <sysfs_remove_dir+26/13c>
   a:   83 4e 04 08               orl    $0x8,0x4(%esi)
Code;  c0175a0a <sysfs_remove_dir+2a/13c>
   e:   85 f6                     test   %esi,%esi
Code;  c0175a0c <sysfs_remove_dir+2c/13c>
  10:   0f 84 02 01 00 00         je     118 <_EIP+0x118>


1 warning and 1 error issued.  Results may not be reliable.

--Boundary-00=_q76Z+DzZ9tVTMK7--

