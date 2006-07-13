Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161044AbWGMXSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161044AbWGMXSs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 19:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161046AbWGMXSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 19:18:48 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:5273 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1161044AbWGMXSs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 19:18:48 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Reply-To: nigel@suspend2.net
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] Rt-tester makes freezing processes fail.
Date: Fri, 14 Jul 2006 09:18:43 +1000
User-Agent: KMail/1.9.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@timesys.com>,
       "Linux-pm list" <linux-pm@lists.osdl.org>,
       Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1519839.1496W9ZNkl";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607140918.49040.nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1519839.1496W9ZNkl
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi.

Compiling in the rt-tester currently makes freezing processes fail.
I don't think there's anything wrong with it running during
suspending, so adding PF_NOFREEZE to the flags set seems to be the
right solution.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 rtmutex-tester.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
diff -ruNp 9971-rt-tester.patch-old/kernel/rtmutex-tester.c 9971-rt-tester.=
patch-new/kernel/rtmutex-tester.c
=2D-- 9971-rt-tester.patch-old/kernel/rtmutex-tester.c	2006-07-07 10:27:46.=
000000000 +1000
+++ 9971-rt-tester.patch-new/kernel/rtmutex-tester.c	2006-07-14 07:48:01.00=
0000000 +1000
@@ -259,7 +259,7 @@ static int test_func(void *data)
 	struct test_thread_data *td =3D data;
 	int ret;
=20
=2D	current->flags |=3D PF_MUTEX_TESTER;
+	current->flags |=3D PF_MUTEX_TESTER | PF_NOFREEZE;
 	allow_signal(SIGHUP);
=20
 	for(;;) {


--nextPart1519839.1496W9ZNkl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEttTYN0y+n1M3mo0RAjGRAJwL5ubwjpA0odnoeTXhk6r8Vmb4oACglwTR
JmR0MHTeNk+dSS3M0jh2YYI=
=TpOi
-----END PGP SIGNATURE-----

--nextPart1519839.1496W9ZNkl--
