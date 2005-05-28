Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVE1Wjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVE1Wjk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 18:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbVE1Wjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 18:39:40 -0400
Received: from h80ad26b2.async.vt.edu ([128.173.38.178]:6666 "EHLO
	h80ad26b2.async.vt.edu") by vger.kernel.org with ESMTP
	id S261187AbVE1Wj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 18:39:27 -0400
Message-Id: <200505282238.j4SMcYdN014990@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.12-rc5-mm1 - missing #define SECTIONS_SHIFT in sparsemem
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1117319910_6734P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sat, 28 May 2005 18:38:31 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1117319910_6734P
Content-Type: text/plain; charset=us-ascii

sparsemem-memory-model.patch references SECTIONS_SHIFT without defining it.

Caught this while compiling with -Wundef, causes lots of warnings
when it gets used in include/linux/mm.h.  The appended patch Works For Me,
although I wonder if the *real* problem isn't a missing '#ifdef CONFIG_SPARSEMEM'
around the code that uses it in mm.h.  
 
Signed-Off-By: valdis.kletnieks@vt.edu

--- linux-2.6.12-rc5-mm1/include/linux/mmzone.h.ifdef	2005-05-27 15:12:26.000000000 -0400
+++ linux-2.6.12-rc5-mm1/include/linux/mmzone.h	2005-05-27 16:26:40.000000000 -0400
@@ -568,6 +568,7 @@ static inline int pfn_valid(unsigned lon
 void sparse_init(void);
 #else
 #define sparse_init()	do {} while (0)
+#define SECTIONS_SHIFT	0
 #endif /* CONFIG_SPARSEMEM */
 
 #ifdef CONFIG_NODES_SPAN_OTHER_NODES


--==_Exmh_1117319910_6734P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCmPLmcC3lWbTT17ARAmGzAKDOVDbGBVcG0oQqY1rV2gIZrsnCYACg2PWl
+ad4DrEzTHY68wGrxaRRBok=
=+dzq
-----END PGP SIGNATURE-----

--==_Exmh_1117319910_6734P--
