Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267368AbTBYFGP>; Tue, 25 Feb 2003 00:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267476AbTBYFGP>; Tue, 25 Feb 2003 00:06:15 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:37851 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267368AbTBYFGO>;
	Tue, 25 Feb 2003 00:06:14 -0500
Subject: [PATCH] linux-2.5.63_x86-tsc-cleanup_A0
From: john stultz <johnstul@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>, ak@suse.de,
       Andrew Morton <akpm@digeo.com>
In-Reply-To: <1046149232.18311.337.camel@w-jstultz2.beaverton.ibm.com>
References: <1046149232.18311.337.camel@w-jstultz2.beaverton.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-I+13UOxrcbLnM6G9UDpj"
Organization: 
Message-Id: <1046149849.18311.348.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 24 Feb 2003 21:10:49 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-I+13UOxrcbLnM6G9UDpj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Linus, All,
	As promised, here is a minor cleanup that removes the usage of
CONFIG_X86_TSC in get_cycles(), replacing it with a runtime conditional
of if(cpu_has_tsc).

Andi: I've already posted this a few times without complaint, but since
you didn't like my playing with get_cycles() last time, let me know if
have any issues with this.

thanks
-john


diff -Nru a/include/asm-i386/timex.h b/include/asm-i386/timex.h
--- a/include/asm-i386/timex.h	Mon Feb 24 21:09:32 2003
+++ b/include/asm-i386/timex.h	Mon Feb 24 21:09:32 2003
@@ -40,14 +40,10 @@
=20
 static inline cycles_t get_cycles (void)
 {
-#ifndef CONFIG_X86_TSC
-	return 0;
-#else
-	unsigned long long ret;
-
-	rdtscll(ret);
+	unsigned long long ret =3D 0;
+	if(cpu_has_tsc)
+		rdtscll(ret);
 	return ret;
-#endif
 }
=20
 extern unsigned long cpu_khz;




--=-I+13UOxrcbLnM6G9UDpj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA+WvrZMDAZ/OmgHwwRAo02AJ9xf14lC8yFkodkAL8J0MiYnQP24QCfbvBk
3pbsQPvVI0EAGG3msULwi44=
=YKuH
-----END PGP SIGNATURE-----

--=-I+13UOxrcbLnM6G9UDpj--

