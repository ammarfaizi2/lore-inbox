Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964985AbWIDVZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbWIDVZf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 17:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbWIDVZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 17:25:35 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:40069 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S964985AbWIDVZf (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 17:25:35 -0400
Message-Id: <200609042125.k84LPMYR003633@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andrew Morton <akpm@osdl.org>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm3 crypto issues with encrypted disks
In-Reply-To: Your message of "Mon, 04 Sep 2006 12:02:28 EDT."
             <200609041602.k84G2SYc005390@turing-police.cc.vt.edu>
From: Valdis.Kletnieks@vt.edu
References: <200609041602.k84G2SYc005390@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1157405122_3505P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 04 Sep 2006 17:25:22 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1157405122_3505P
Content-Type: text/plain; charset=us-ascii

On Mon, 04 Sep 2006 12:02:28 EDT, Valdis.Kletnieks@vt.edu said:

> Sorry for not catching this one earlier..  Sometime between 2.6.18-rc4-mm2
> and -mm3, something crept into the git-cryptodev.patch that breaks mounting
> encrypted disks.  What I have in /etc/fstab:

And of course, after I spend time doing a -mm bisect, the problem evaporates
in -rc5-mm1. ;)

> /dev/rootvg/crypto1     /crypto/mount_dir    ext3    nodev,nosuid,noexec,noauto,noatime,nodiratime,user,loop,encryption=aes 1 0

> My personal guess as "most likely suspect" (only obvious hit on cryptoloop):

Looks like a self-inflicted screw-up in the .config.  The relevant diff
of the 2 .config files (the -rc4-mm3 had a 'patch -R < git-cryptodev' so
the new options aren't in that .config)

-# Linux kernel version: 2.6.18-rc4-mm3
-# Wed Aug 30 10:00:30 2006
+# Linux kernel version: 2.6.18-rc5-mm1
+# Mon Sep  4 16:22:37 2006
....
+CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_BLKCIPHER=y
+CONFIG_CRYPTO_HASH=y
+CONFIG_CRYPTO_MANAGER=y

Does 'CONFIG_CRYPTOLOOP' need a 'SELECT CRYPTO_MANAGER' (or one of the other
symbols)?

--==_Exmh_1157405122_3505P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFE/JnCcC3lWbTT17ARApqpAJ9uyd49Ckzz0CJRKelg4M0q1iVKGgCeMrae
893oYU1msuLhJej8sIKb0Sw=
=NbTb
-----END PGP SIGNATURE-----

--==_Exmh_1157405122_3505P--
