Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266433AbUBFDvz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 22:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266435AbUBFDvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 22:51:55 -0500
Received: from h80ad253b.async.vt.edu ([128.173.37.59]:58752 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266433AbUBFDvx (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 22:51:53 -0500
Message-Id: <200402060351.i163ptpB010350@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.2-mm1 - more -Wundef cleanup
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_266810730P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 05 Feb 2004 22:51:54 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_266810730P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <10342.1076039514.1@turing-police.cc.vt.edu>

Even after the patch I just sent, building with -Wundef still gets:

  CC      drivers/char/mem.o
In file included from drivers/char/mem.c:15:
include/linux/ftape.h:168:7: warning: "CONFIG_FT_ALT_FDC" is not defined

#elif CONFIG_FT_ALT_FDC == 1  /* CONFIG_FT_MACH2 */

The sort of whoops that -Wundef was intended to catch.

Further research shows that it's spurious - there's no obvious
reason for mem.c to even include ftape.h (or tpquic02.h for that
matter) - compiles fine, even compared 'gcc -E' with and without.

--- linux-2.6.2-mm1/drivers/char/mem.c.dist	2004-02-05 22:23:34.291328515 -0500
+++ linux-2.6.2-mm1/drivers/char/mem.c	2004-02-05 22:36:25.900847264 -0500
@@ -11,8 +11,6 @@
 #include <linux/config.h>
 #include <linux/mm.h>
 #include <linux/miscdevice.h>
-#include <linux/tpqic02.h>
-#include <linux/ftape.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/mman.h>


--==_Exmh_266810730P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAIw9acC3lWbTT17ARAj+MAKDmioxvVzWQ9ivqu0OB/wEW8CHEBQCeJZwA
ZTL5zzzd2+ejId4kNoJF8w4=
=f3yX
-----END PGP SIGNATURE-----

--==_Exmh_266810730P--
