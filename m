Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268551AbRGYKET>; Wed, 25 Jul 2001 06:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268552AbRGYKEJ>; Wed, 25 Jul 2001 06:04:09 -0400
Received: from nick.dcs.qmw.ac.uk ([138.37.88.61]:27909 "EHLO dcs.qmw.ac.uk")
	by vger.kernel.org with ESMTP id <S268551AbRGYKD6>;
	Wed, 25 Jul 2001 06:03:58 -0400
Date: Wed, 25 Jul 2001 11:04:04 +0100 (BST)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.7 crash with ipchains/netfilter as modules
Message-ID: <Pine.LNX.4.33.0107251054420.1834-100000@nick.dcs.qmw.ac.uk>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Just upgraded a fileserver (dual Pentium II/440BX) running Debian potato +
the bunk 2.4 support debs from 2.2.19, modularising what I can, without
resorting to initrd.

/proc/version:
Linux version 2.4.7 (mb@custard) (gcc version 2.95.2 20000220 (Debian GNU/Linux)) #1 SMP Wed Jul 25 09:07:05 BST 2001

Unfortunately the firewalling code is confused.

# lsmod
Module                  Size  Used by
nfs                    79168   3  (autoclean)
lockd                  49888   1  (autoclean) [nfs]
sunrpc                 66496   1  (autoclean) [nfs lockd]
floppy                 45744   1  (autoclean)
ipip                    6448   0  (unused)
eepro100               16336   1
acenic                125824   1
ipchains               37568   0  (unused)
unix                   16992  27  (autoclean)

..but "ipchains -L" does produce some output (though it takes many
minutes), and the kernel has logged some DENY packets. Attempting
"modprobe -r ipchains" gives the following (possibly meaningless) oops.

ksymoops 2.3.7 on i686 2.4.7.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.7/ (default)
     -m /boot/System.map-2.4.7 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol nlmsvc_grace_period  , lockd
says f8969e14, /lib/modules/2.4.7/kernel/fs/lockd/lockd.o says f896922c.
Ignoring /lib/modules/2.4.7/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nlmsvc_ops  , lockd says
f8969e10, /lib/modules/2.4.7/kernel/fs/lockd/lockd.o says f8969228.
Ignoring /lib/modules/2.4.7/kernel/fs/lockd/lockd.o entryWarning
(compare_maps): mismatch on symbol nlmsvc_timeout  , lockd says f8969e18,
/lib/modules/2.4.7/kernel/fs/lockd/lockd.o says f8969230.  Ignoring
/lib/modules/2.4.7/kernel/fs/lockd/lockd.o entry
Warning (compare_maps): mismatch on symbol nfs_debug  , sunrpc says
f895c3a8, /lib/modules/2.4.7/kernel/net/sunrpc/sunrpc.o says f895c068.
Ignoring /lib/modules/2.4.7/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nfsd_debug  , sunrpc says
f895c3ac, /lib/modules/2.4.7/kernel/net/sunrpc/sunrpc.o says f895c06c.
Ignoring /lib/modules/2.4.7/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol nlm_debug  , sunrpc says
f895c3b0, /lib/modules/2.4.7/kernel/net/sunrpc/sunrpc.o says f895c070.
Ignoring /lib/modules/2.4.7/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_debug  , sunrpc says
f895c3a4, /lib/modules/2.4.7/kernel/net/sunrpc/sunrpc.o says f895c064.
Ignoring /lib/modules/2.4.7/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_garbage_args  , sunrpc says
f895c384, /lib/modules/2.4.7/kernel/net/sunrpc/sunrpc.o says f895c044.
Ignoring /lib/modules/2.4.7/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_success  , sunrpc says
f895c374, /lib/modules/2.4.7/kernel/net/sunrpc/sunrpc.o says f895c034.
Ignoring /lib/modules/2.4.7/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol rpc_system_err  , sunrpc says
f895c388, /lib/modules/2.4.7/kernel/net/sunrpc/sunrpc.o says f895c048.
Ignoring /lib/modules/2.4.7/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol xdr_one  , sunrpc says
f895c36c, /lib/modules/2.4.7/kernel/net/sunrpc/sunrpc.o says f895c02c.
Ignoring /lib/modules/2.4.7/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol xdr_two  , sunrpc says
f895c370, /lib/modules/2.4.7/kernel/net/sunrpc/sunrpc.o says f895c030.
Ignoring /lib/modules/2.4.7/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol xdr_zero  , sunrpc says
f895c368, /lib/modules/2.4.7/kernel/net/sunrpc/sunrpc.o says f895c028.
Ignoring /lib/modules/2.4.7/kernel/net/sunrpc/sunrpc.o entry
Warning (compare_maps): mismatch on symbol floppy  , floppy says f8944258,
/lib/modules/2.4.7/kernel/drivers/block/floppy.o says f89435f8.  Ignoring
/lib/modules/2.4.7/kernel/drivers/block/floppy.o entry
Warning (compare_maps): mismatch on symbol unix_socket_table  , unix says
f8808dc0, /lib/modules/2.4.7/kernel/net/unix/unix.o says f8808a20.
Ignoring /lib/modules/2.4.7/kernel/net/unix/unix.o entry
Reading Oops report from the terminal
Unable to handle kernel paging request at virtual address f895f3bc
 printing eip:
f895f3bc
*pde = 37db0067
*pte = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<f895f3bc>]
EFLAGS: 00010282
eax: f895f3bc   ebx: f71d9140   ecx: f76f2240   edx: f71d9160
esi: 00000400   edi: f6ef2000   ebp: 00000400   esp: f6c7bf68
ds: 0018   es: 0018   ss: 0018
Process ipchains (pid: 3589, stackpage=f6c7b000)
Stack: c014fcdf f6ef2000 f6c7bf98 00000000 00000400 f71d9140 ffffffea 00000000
       00000400 f76f2240 00000000 00000000 00000000 c01330c7 f71d9140 40014000
       00000400 f71d9160 f6c7a000 08052438 00000000 bffffa3c c0106cfb 00000003
Call Trace: [<c014fcdf>] [<c01330c7>] [<c0106cfb>]

Code:  Bad EIP value.
Unable to handle kernel paging request at virtual address f895f3bc
f895f3bc
*pde = 37db0067
Oops: 0000
CPU:    0
EIP:    0010:[<f895f3bc>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010282
eax: f895f3bc   ebx: f71d9140   ecx: f76f2240   edx: f71d9160
esi: 00000400   edi: f6ef2000   ebp: 00000400   esp: f6c7bf68
ds: 0018   es: 0018   ss: 0018
Process ipchains (pid: 3589, stackpage=f6c7b000)
Stack: c014fcdf f6ef2000 f6c7bf98 00000000 00000400 f71d9140 ffffffea 00000000
       00000400 f76f2240 00000000 00000000 00000000 c01330c7 f71d9140 40014000
       00000400 f71d9160 f6c7a000 08052438 00000000 bffffa3c c0106cfb 00000003
Call Trace: [<c014fcdf>] [<c01330c7>] [<c0106cfb>]
Code:  Bad EIP value.

>>EIP; f895f3bc <[lockd]nlm_lookup_host+1e4/2a4>   <=====
Trace; c014fcdf <proc_file_read+b7/194>
Trace; c01330c7 <sys_read+8f/c4>
Trace; c0106cfb <system_call+33/38>


16 warnings issued.  Results may not be reliable.



Any help gratefully received. Any further information willingly offered!

Matt

