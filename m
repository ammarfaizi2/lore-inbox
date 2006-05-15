Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbWEOTBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbWEOTBX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 15:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbWEOTBW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 15:01:22 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:12478 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S932447AbWEOTAx (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 15:00:53 -0400
Message-Id: <200605151900.k4FJ0ktD006410@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andrew Morton <akpm@osdl.org>, Ram Pai <linuxram@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.17-rc4-mm1 - kbuild wierdness with EXPORT_SYMBOL_GPL
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1147719646_2500P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 15 May 2006 15:00:46 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1147719646_2500P
Content-Type: text/plain; charset=us-ascii

It looks like a buggy comparison down in the guts of
kbuild-export-type-enhancement-to-modpostc.patch - it's doing
something really odd when it hits a EXPORT_SYMBOL_GPL.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
---
Proposed fix (with an added debugging warning Just In Case:

--- linux-2.6.17-rc4-mm1/scripts/mod/modpost.c.whatdied	2006-05-15 13:50:13.000000000 -0400
+++ linux-2.6.17-rc4-mm1/scripts/mod/modpost.c	2006-05-15 14:52:13.000000000 -0400
@@ -1194,12 +1194,14 @@
 					*d != '\0')
 			goto fail;
 
-		if ((strcmp(export, "EXPORT_SYMBOL_GPL")))
+		if ((strcmp(export, "EXPORT_SYMBOL_GPL") == 0))
 			export_type = 1;
 		else if(strcmp(export, "EXPORT_SYMBOL") == 0)
 			export_type = 0;
-		else
+		else {
+			warn("Odd symbol export=%s symname=%s modname=%s\n",export,symname,modname);
 			goto fail;
+		}
 
 		if (!(mod = find_module(modname))) {
 			if (is_vmlinux(modname)) {



--==_Exmh_1147719646_2500P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEaM/ecC3lWbTT17ARAjssAKDOWQbHVzLoE+xPXcx41yOwpXbfyACgqDKo
WGAyB2KW+qi/wHeSvhjcPQ8=
=R8FM
-----END PGP SIGNATURE-----

--==_Exmh_1147719646_2500P--
