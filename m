Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266367AbTB0Tgh>; Thu, 27 Feb 2003 14:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266434AbTB0Tgg>; Thu, 27 Feb 2003 14:36:36 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:37763 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S266367AbTB0Tfz>; Thu, 27 Feb 2003 14:35:55 -0500
Message-Id: <200302271946.h1RJkAJT010712@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.1 02/18/2003 with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Subject: 2.5.63 - if/ifdef janitor work - actual bug found..
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1352218482P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 27 Feb 2003 14:46:10 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1352218482P
Content-Type: text/plain; charset=us-ascii

The previous patches cleaned things up enough that -Wundef doesn't trigger
a lot of false positives.. which made this one visible.  There's no other
occurrence of MAX_OWNER_OVERRIDE in the tree, and it's obviously not
MAY_OWNER_OVERRIDE either.  Looks like just remaindered cruft that I've
cleaned up....

--- include/linux/nfsd/nfsd.h.dist	2003-02-24 14:06:01.000000000 -0500
+++ include/linux/nfsd/nfsd.h	2003-02-27 00:21:53.957428476 -0500
@@ -39,7 +39,7 @@
 #define MAY_LOCK		32
 #define MAY_OWNER_OVERRIDE	64
 #define	MAY_LOCAL_ACCESS	128 /* IRIX doing local access check on device special file*/
-#if (MAY_SATTR | MAY_TRUNC | MAY_LOCK | MAX_OWNER_OVERRIDE | MAY_LOCAL_ACCESS) & (MAY_READ | MAY_WRITE | MAY_EXEC | MAY_OWNER_OVERRIDE)
+#if (MAY_SATTR | MAY_TRUNC | MAY_LOCK | MAY_LOCAL_ACCESS) & (MAY_READ | MAY_WRITE | MAY_EXEC | MAY_OWNER_OVERRIDE)
 # error "please use a different value for MAY_SATTR or MAY_TRUNC or MAY_LOCK or MAY_OWNER_OVERRIDE."
 #endif
 #define MAY_CREATE		(MAY_EXEC|MAY_WRITE)



--==_Exmh_1352218482P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE+XmsCcC3lWbTT17ARAlKPAKCgn+ctrKYzi9bwpp70OVQNPVfp3wCdH/Zi
4/BFc+ZaBvKKP3zTwfsrq24=
=Ye4O
-----END PGP SIGNATURE-----

--==_Exmh_1352218482P--
