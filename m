Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264418AbUAHNZp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 08:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264419AbUAHNZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 08:25:45 -0500
Received: from mail.donpac.ru ([80.254.111.2]:26317 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S264418AbUAHNZn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 08:25:43 -0500
Date: Thu, 8 Jan 2004 16:25:39 +0300
From: Andrey Panin <pazke@donpac.ru>
To: linux-kernel@vger.kernel.org
Cc: Trivial Patch Monkey <trivial@rustcorp.com.au>
Subject: [PATCH][TRIVIAL] madvise() syscall: don't test arguments holding semaphore
Message-ID: <20040108132539.GD16362@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Trivial Patch Monkey <trivial@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nhYGnrYv1PEJ5gA2"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
X-SMTP-Authenticated: pazke@donpac.ru (cram)
X-SMTP-TLS: TLSv1:AES256-SHA:256
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nhYGnrYv1PEJ5gA2
Content-Type: multipart/mixed; boundary="nYySOmuH/HDX6pKp"
Content-Disposition: inline


--nYySOmuH/HDX6pKp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

madvise() system call checks its arguments holding current->mm->mmap_sem
semaphore. I know that madvise() shouldn't be perfomance critical,=20
but fix it so obvious :) Patch against 2.6.1-rc

Best regards.

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--nYySOmuH/HDX6pKp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-madvise-2.6.1"
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/share/dontdiff linux-2.6.0-test3.vanilla/mm/madvise.c lin=
ux-2.6.0-test3/mm/madvise.c
--- linux-2.6.0-test3.vanilla/mm/madvise.c	2003-08-09 08:34:02.000000000 +0=
400
+++ linux-2.6.0-test3/mm/madvise.c	2004-01-01 16:51:58.000000000 +0300
@@ -166,20 +166,20 @@
 	unsigned long end;
 	struct vm_area_struct * vma;
 	int unmapped_error =3D 0;
-	int error =3D -EINVAL;
-
-	down_write(&current->mm->mmap_sem);
+	int error;
=20
 	if (start & ~PAGE_MASK)
-		goto out;
+		return -EINVAL;
+
 	len =3D (len + ~PAGE_MASK) & PAGE_MASK;
 	end =3D start + len;
 	if (end < start)
-		goto out;
+		return -EINVAL;
=20
-	error =3D 0;
 	if (end =3D=3D start)
-		goto out;
+		return 0;
+
+	down_write(&current->mm->mmap_sem);
=20
 	/*
 	 * If the interval [start,end) covers some unmapped address

--nYySOmuH/HDX6pKp--

--nhYGnrYv1PEJ5gA2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE//VpTby9O0+A2ZecRAsqaAKCadqCJ9PpztVrggfFQziyUuYtvZACfaEsl
HbLuXaDs7T19NxRboJbi7Lo=
=G026
-----END PGP SIGNATURE-----

--nhYGnrYv1PEJ5gA2--
