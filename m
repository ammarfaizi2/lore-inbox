Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262130AbSLTLKd>; Fri, 20 Dec 2002 06:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262210AbSLTLKa>; Fri, 20 Dec 2002 06:10:30 -0500
Received: from host217-36-81-41.in-addr.btopenworld.com ([217.36.81.41]:40588
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP
	id <S262130AbSLTLK0>; Fri, 20 Dec 2002 06:10:26 -0500
Subject: [PATCH]: trivial sys_mincore cleanup
From: Gianni Tedesco <gianni@ecsc.co.uk>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-xYvwGWUrlhf06EGX2daM"
Organization: 
Message-Id: <1040383074.12106.30.camel@lemsip>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 20 Dec 2002 11:17:54 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xYvwGWUrlhf06EGX2daM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Patch makes 2 simple cleanups:
 - Checks the syscall parameters before grabbing mmap semaphore.
 - Tidy up a comment.

BTW. How comes mincore() doesn't return a bit vector? :P

diff -urN linux-2.4.19.orig/mm/filemap.c linux-2.4.19/mm/filemap.c
--- linux-2.4.19.orig/mm/filemap.c      Sat Aug  3 00:39:46 2002
+++ linux-2.4.19/mm/filemap.c   Fri Dec 20 11:11:56 2002
@@ -2736,21 +2736,21 @@
        int unmapped_error =3D 0;
        long error =3D -EINVAL;
=20
-       down_read(&current->mm->mmap_sem);
-
        if (start & ~PAGE_CACHE_MASK)
-               goto out;
+               return error;
        len =3D (len + ~PAGE_CACHE_MASK) & PAGE_CACHE_MASK;
        end =3D start + len;
        if (end < start)
-               goto out;
+               return error;
=20
        error =3D 0;
        if (end =3D=3D start)
-               goto out;
+               return error;
+
+       down_read(&current->mm->mmap_sem);
=20
        /*
-        * If the interval [start,end) covers some unmapped address
+        * If the interval [start,end] covers some unmapped address
         * ranges, just ignore them, but return -ENOMEM at the end.
         */
        vma =3D find_vma(current->mm, start);

--=20
// Gianni Tedesco (gianni at ecsc dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

--=-xYvwGWUrlhf06EGX2daM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA+AvxikbV2aYZGvn0RAgBfAKCF7fFcNDp1rCq03uZHTRUqfwYk2QCfWKt1
LFASvguBdT+Ul/92cMK07T4=
=4D/M
-----END PGP SIGNATURE-----

--=-xYvwGWUrlhf06EGX2daM--

