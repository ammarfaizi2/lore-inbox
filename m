Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261875AbREPLJO>; Wed, 16 May 2001 07:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261876AbREPLJE>; Wed, 16 May 2001 07:09:04 -0400
Received: from nick.dcs.qmw.ac.uk ([138.37.88.61]:24335 "EHLO dcs.qmw.ac.uk")
	by vger.kernel.org with ESMTP id <S261875AbREPLIx>;
	Wed, 16 May 2001 07:08:53 -0400
Date: Wed, 16 May 2001 12:08:46 +0100 (BST)
From: Matt Bernstein <mb@dcs.qmw.ac.uk>
To: <linux-xfs@oss.sgi.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Oops with 2.4.3-XFS
Message-ID: <Pine.LNX.4.33.0105161159400.2837-100000@nick.dcs.qmw.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

[ I'm not subscribed to linux-xfs, please cc me ]

We have managed to get a Debian potato system (with the 2.4 updates from
http://people.debian.org/~bunk/debian plus xfs-tools which we imported
from woody) to run 2.4.3-XFS.

However, in testing a directory with lots (~177000) of files, we get the
following oops (copied by hand, and run through ksymoops on a Red Hat box
since the Debian one segfaulted :( )

HTH,

Matt

r2-pc:~/oopsie$ ksymoops -m System.map -v vmlinux -K -L -O -S <oops
ksymoops 2.4.0 on i686 2.4.2-2.  Options used
     -v vmlinux (specified)
     -K (specified)
     -L (specified)
     -O (specified)
     -m System.map (specified)
     -S

Unable to handle kernel NULL pointer dereference at virtual address 00000008 printing eip:
c01950e9
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01950e9>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010256
eax: 00000000   ebx: cff25c00   ecx: 00000008   edx: 00000008
esi: 00000000   edi: 00000005   ebp: 00000000   esp: cee59b94
ds: 0018   es: 0018   ss: 0018
Process xntpd (pid: 364, stackpage=cee59000)
Stack: c0411e90 00000fe6 00000005 c0411e90 c0198682 cd2b06c8 c01986e6 00000000
       02683f18 00000000 00000010 c0411e08 0000e016 c01980d7 cff25c00 00000000
       cbf894b0 cee59c04 cee59c08 00000000 00000000 cbf894b0 00000fe6 00000bb0
Call Trace: [<c0198682>] [<c01986e6>] [<c01980d7>] [<c0199074>] [<c01992e0>] [<c01a95b2>] [<c019c33e>]
       [<c019b7a1>] [<c01a85d4>] [<c0196c24>] [<c01aed54>] [<c01af5af>] [<c0106fe0>] [<c01bf124>] [<c01be417>]
       [<c014182b>] [<c013fb4e>] [<c013fe31>] [<c0127fef>] [<c0128162>] [<c0128e3e>] [<c0128ef4>] [<c013c183>]
       [<c01f3c67>] [<c01f0773>] [<c013c3cf>] [<c013c91d>] [<c0106f37>]
Code: f6 45 08 04 74 09 8b 55 30 01 c2 eb 12 89 f6 50 55 e8 51 9f

>>EIP; c01950e9 <xfs_itobp+139/1e0>   <=====
Trace; c0198682 <xfs_iflush_int+272/300>
Trace; c01986e6 <xfs_iflush_int+2d6/300>
Trace; c01980d7 <xfs_iflush+b7/3f0>
Trace; c0199074 <xfs_inode_item_trylock+24/80>
Trace; c01992e0 <xfs_inode_item_push+10/20>
Trace; c01a95b2 <xfs_trans_push_ail+122/200>
Trace; c019c33e <xlog_grant_push_ail+15e/170>
Trace; c019b7a1 <xfs_log_reserve+41/90>
Trace; c01a85d4 <xfs_trans_reserve+84/140>
Trace; c0196c24 <xfs_itruncate_finish+354/3f0>
Trace; c01aed54 <xfs_inactive_free_eofblocks+284/2d0>
Trace; c01af5af <xfs_inactive+10f/480>
Trace; c0106fe0 <ret_from_intr+0/20>
Trace; c01bf124 <vn_put+34/50>
Trace; c01be417 <linvfs_put_inode+17/20>
Trace; c014182b <iput+2b/150>
Trace; c013fb4e <prune_dcache+de/150>
Trace; c013fe31 <shrink_dcache_memory+21/30>
Trace; c0127fef <do_try_to_free_pages+5f/80>
Trace; c0128162 <try_to_free_pages+22/30>
Trace; c0128e3e <__alloc_pages+24e/2f0>
Trace; c0128ef4 <__get_free_pages+14/20>
Trace; c013c183 <__pollwait+33/a0>
Trace; c01f3c67 <datagram_poll+27/f0>
Trace; c01f0773 <sock_poll+23/30>
Trace; c013c3cf <do_select+11f/210>
Trace; c013c91d <sys_select+42d/5a0>
Trace; c0106f37 <system_call+33/38>
Code;  c01950e9 <xfs_itobp+139/1e0>            00000000 <_EIP>:
Code;  c01950e9 <xfs_itobp+139/1e0>               0:   f6 45 08 04               testb  $0x4,0x8(%ebp)   <=====
Code;  c01950ed <xfs_itobp+13d/1e0>               4:   74 09                     je     f <_EIP+0xf> c01950f8 <xfs_itobp+148/1e0>
Code;  c01950ef <xfs_itobp+13f/1e0>               6:   8b 55 30                  mov    0x30(%ebp),%edx
Code;  c01950f2 <xfs_itobp+142/1e0>               9:   01 c2                     add    %eax,%edx
Code;  c01950f4 <xfs_itobp+144/1e0>               b:   eb 12                     jmp    1f <_EIP+0x1f> c0195108 <xfs_itobp+158/1e0>
Code;  c01950f6 <xfs_itobp+146/1e0>               d:   89 f6                     mov    %esi,%esi
Code;  c01950f8 <xfs_itobp+148/1e0>               f:   50                        push   %eax
Code;  c01950f9 <xfs_itobp+149/1e0>              10:   55                        push   %ebp
Code;  c01950fa <xfs_itobp+14a/1e0>              11:   e8 51 9f 00 00            call   9f67 <_EIP+0x9f67> c019f050 <xlog_find_zeroed+150/200>

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7Al/D1vU/2MhEp5cRApvnAKCWumj3KYcd1ucNLVrPwZOWzVxwWQCfaqVg
6L3NvlsLoQgvkPbru2dPYJs=
=z9ET
-----END PGP SIGNATURE-----

