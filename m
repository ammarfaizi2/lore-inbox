Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbTHaENG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 00:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262448AbTHaENG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 00:13:06 -0400
Received: from h80ad2775.async.vt.edu ([128.173.39.117]:3201 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262439AbTHaENC (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 00:13:02 -0400
Message-Id: <200308310412.h7V4Cxd7013786@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test4-mm3.1 oops with ext3 extended attributes on R/O filesystem
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1353710848P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 31 Aug 2003 00:12:59 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1353710848P
Content-Type: text/plain; charset=us-ascii

Working on installing SELINUX, and I get to the part where all the file labels
get added.  Unfortunately, I had some file systems mounted R/O (intentionally,
forgot to mount them R/W for this).  The ext3 code upchucked while trying
to set extended attributes on the filesystem it couldn't write to.

In addition to the OOPS, it seemed to leave a lock dangling - even after remounting
the filesystem R/W and trying again, it just sat there.

Proper action would probably be to -EPERM rather than OOPS...

Aug 30 17:24:04 turing-police kernel: Unable to handle kernel paging request at virtual address ffffffe2
Aug 30 17:24:04 turing-police kernel:  printing eip:
Aug 30 17:24:04 turing-police kernel: c0184c46
Aug 30 17:24:04 turing-police kernel: *pde = 00001067
Aug 30 17:24:04 turing-police kernel: *pte = 00000000
Aug 30 17:24:04 turing-police kernel: Oops: 0000 [#1]
Aug 30 17:24:04 turing-police kernel: PREEMPT
Aug 30 17:24:04 turing-police kernel: CPU:    0
Aug 30 17:24:04 turing-police kernel: EIP:    0060:[__ext3_journal_stop+8/60]    Not tainted VLI
Aug 30 17:24:04 turing-police kernel: EFLAGS: 00010216
Aug 30 17:24:04 turing-police kernel: EIP is at __ext3_journal_stop+0x8/0x3c
Aug 30 17:24:04 turing-police kernel: eax: ffffffe2   ebx: ffffffe2   ecx: cf429990   edx: cfd75000
Aug 30 17:24:04 turing-police kernel: esi: ffffffe2   edi: cf429990   ebp: cf30fdc8   esp: cf30fdc0
Aug 30 17:24:04 turing-police kernel: ds: 007b   es: 007b   ss: 0068
Aug 30 17:24:04 turing-police kernel: Process setfiles (pid: 980, threadinfo=cf30e000 task=cf2786b0)
Aug 30 17:24:04 turing-police kernel: Stack: ffffffe2 ffffffe2 cf30fde4 c0188b4e c0355ca1 ffffffe2 c03d022c cf30fe66
Aug 30 17:24:04 turing-police kernel:        c03693b4 cf30fe0c c018a0a9 cf429990 00000006 cf30fe65 cef53d60 00000019
Aug 30 17:24:04 turing-police kernel:        00000000 00000005 cef53d60 cf30fe3c c0187a79 cf429990 cf30fe65 cef53d60
Aug 30 17:24:04 turing-police kernel: Call Trace:
Aug 30 17:24:04 turing-police kernel:  [ext3_xattr_set+68/83] ext3_xattr_set+0x44/0x53
Aug 30 17:24:04 turing-police kernel:  [ext3_xattr_security_set+60/71] ext3_xattr_security_set+0x3c/0x47
Aug 30 17:24:05 turing-police kernel:  [ext3_setxattr+175/183] ext3_setxattr+0xaf/0xb7
Aug 30 17:24:05 turing-police kernel:  [setxattr+373/444] setxattr+0x175/0x1bc
Aug 30 17:24:05 turing-police kernel:  [inode_has_perm+93/101] inode_has_perm+0x5d/0x65
Aug 30 17:24:05 turing-police kernel:  [dput+28/508] dput+0x1c/0x1fc
Aug 30 17:24:05 turing-police kernel:  [dput+28/508] dput+0x1c/0x1fc
Aug 30 17:24:05 turing-police kernel:  [link_path_walk+1754/1932] link_path_walk+0x6da/0x78c
Aug 30 17:24:05 turing-police kernel:  [sys_lsetxattr+49/66] sys_lsetxattr+0x31/0x42
Aug 30 17:24:05 turing-police kernel:  [sysenter_past_esp+67/101] sysenter_past_esp+0x43/0x65
Aug 30 17:24:05 turing-police kernel:
Aug 30 17:24:05 turing-police kernel: Code: 68 a0 5a 35 c0 52 e8 02 02 00 00 83 c4 0c eb 0c 89 4d 0c 89 45 08 c9 e9 5e 58 00 00 b8 e2 ff ff ff c9 c3 55 89 e5 56 53 8b 45 0c <8b> 10 8b 58 0c 8b 12 8b b2 dc 00 00 00 50 e8 b0 68 00 00 85 db



--==_Exmh_1353710848P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/UXXKcC3lWbTT17ARAl5TAJ4gMCh/snHYxjuw7FKJwgl/DLgxbwCfSl3e
qluQpBrZFMeXbssAK1WbE34=
=m4Jw
-----END PGP SIGNATURE-----

--==_Exmh_1353710848P--
