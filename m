Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268048AbUGWUqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268048AbUGWUqz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 16:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268049AbUGWUqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 16:46:55 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:36232 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S268048AbUGWUqj (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 16:46:39 -0400
Message-Id: <200407232046.i6NKkZ5V003482@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.0.4+dev
To: Steve G <linux_4ever@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ext3 problems in dual booting machine with SE Linux 
In-Reply-To: Your message of "Fri, 23 Jul 2004 08:37:15 PDT."
             <20040723153715.81677.qmail@web50610.mail.yahoo.com> 
From: Valdis.Kletnieks@vt.edu
References: <20040723153715.81677.qmail@web50610.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1854615034P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 23 Jul 2004 16:46:35 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1854615034P
Content-Type: text/plain; charset=us-ascii

On Fri, 23 Jul 2004 08:37:15 PDT, Steve G <linux_4ever@yahoo.com>  said:

> At this point, 'umount /dev/sda3' is impossible. Its reported as busy. The on
ly

> [root@buildhost root]# cat /proc/mounts

> /dev/root / ext3 rw 0 0
> /dev/sda3 /mnt/target ext3 rw 0 0

> [root@buildhost root]# rm -rf /mnt/target/tmp/
> [root@buildhost root]# rm -rf /mnt/target/usr/
> Segmentation fault
> [root@buildhost root]#
> Message from syslogd@buildhost at Fri Jul 23 10:50:53 2004 ...
> buildhost kernel: Assertion failure in journal_revoke_Rsmp_9762279c() at
> revoke.c:329: "!(__builtin_constant_p(BH_Revoked) ?
> constant_test_bit((BH_Revoked),(&bh->b_state)) :
> variable_test_bit((BH_Revoked),(&bh->b_state)))"
> 
> At this point the system is non-functional since it oops'ed. Here's the Oops

Fix your boot to not use /dev/root, but an actual partition number.

What's happening is that /dev/sda3 is *both* your /mnt/target *and* your
root filesystem.  So when you start rm -rf'ing, you trash your root filesystem and
things go pear-shaped.

--==_Exmh_1854615034P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBAXkrcC3lWbTT17ARAmhxAKCO+2abBDlScXEyFbXTun0ejb2AXQCg1X4N
Tohj2D/sE/fZNUj58a+/D2U=
=YhVL
-----END PGP SIGNATURE-----

--==_Exmh_1854615034P--
