Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263002AbTKERDR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 12:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263009AbTKERDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 12:03:17 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:23936 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263002AbTKERDJ (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 12:03:09 -0500
Message-Id: <200311051703.hA5H38nQ007123@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: 2.6.0-test9: Kernel OOPS in /sbin/nameif
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-402562100P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 05 Nov 2003 12:03:08 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-402562100P
Content-Type: text/plain; charset=us-ascii

(am on lkml but not linux-net - linux-net replies please cc: me)

This broke sometime between 2.6.0-test8-mm1 (which works) and -test9.

Userspace is Red Hat Rawhide/Fedora Core, kernel compiled with RH gcc-3.3.2-1

Basic summary - when /sbin/nameif goes to rename an interface, things
go totally pear-shaped.  nameif itself croaks, and apparently leaves
data structures corrupted - on a subsequent 'ifup lo' or 'shutdown -r'
the system locks up solid.

Unable to handle kernel NULL pointer dereference at virtual address 000000d8
 printing eip:
c033eb32
*pde = 0f670067
*pte = 00000000
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c033eb32>]    Not tainted
EFLAGS: 00010246
EIP is at addrconf_sysctl_unregister+0x7/0x3a
eax: 0000009c   ebx: 0000009c   ecx: 00000000   edx: 00000000
esi: 00000000   edi: cfd4a800   ebp: cedabea8   esp: cedabea4
ds: 007b   es: 007b   ss: 0068
Process nameif (pid: 280, threadinfo=cedaa000 task=ceaeecc0)
Stack: 0000009c cedabec0 c033cdda 0000009c c042e318 cfd4a800 0000000a cedabee0 
       c012673d c042e318 0000000a cfd4a800 cfd4a800 00000000 cedabf34 cedabf10 
       c02ec593 c04c5848 0000000a cfd4a800 cfd4a800 cedabf34 00000010 cedabf24 
Call Trace:
 [<c033cdda>] addrconf_notify+0xc4/0xfb
 [<c012673d>] notifier_call_chain+0x1c/0x37
 [<c02ec593>] dev_ifsioc+0x2f3/0x391
 [<c02ec867>] dev_ioctl+0x236/0x33b
 [<c0322188>] inet_ioctl+0xbf/0xcd
 [<c02e4ee7>] sock_ioctl+0x27d/0x2a3
 [<c0156922>] sys_ioctl+0x200/0x246
 [<c010a96b>] syscall_call+0x7/0xb

Code: 8b 58 3c 85 db 74 27 c7 40 3c 00 00 00 00 ff 33 e8 dc 13 de 

Reproducible on both -test9 and -test9-mm1.  Sorry I didn't catch it sooner,
I hadn't booted the laptop in the docking station under -test9 till
yesterday, so the call to nameif didn't actually have to rename
anything until then.

--==_Exmh_-402562100P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/qS1McC3lWbTT17ARApmQAJ9NMWohn4Qv7ik/OLMbIOlJlgHhLACfaSt3
AWzd3jxxc5mlWQW6fDZTtCM=
=sPup
-----END PGP SIGNATURE-----

--==_Exmh_-402562100P--
