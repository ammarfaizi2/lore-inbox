Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262184AbSJFUz7>; Sun, 6 Oct 2002 16:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262185AbSJFUz6>; Sun, 6 Oct 2002 16:55:58 -0400
Received: from CPE00c0f0141dc1.cpe.net.cable.rogers.com ([24.42.47.5]:59284
	"EHLO jukie.net") by vger.kernel.org with ESMTP id <S262184AbSJFUzx>;
	Sun, 6 Oct 2002 16:55:53 -0400
Date: Sun, 6 Oct 2002 17:01:24 -0400
From: Bart Trojanowski <bart@jukie.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] [2.4.19] fix for fuzzy hash <linux/ghash.h> [Attempt 2]
Message-ID: <20021006170124.D28201@jukie.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

[ Originally posted on 2002/09/11;  I just looked in 2.4.20-pre9 and it
was not there, hence the repost. ]

The DEF_HASH_FUZZY macro allows the user to template their hash; it
takes on a paramter for the hashing-function, namely HASHFN.  When used
with a hashing-function named anything other than 'hashfn()', a module
using the kernel's fuzzy hash implementation will not compile.

None of the in-kernel 2.4.x drivers use this primitive (yet) so it's no
wonder no one has spotted it.  The patch is very trivial and makes me
think that I am the very first user of the include/linux/ghash.h
hash-table primitive.   ;)

Bart.

---
diff -ruN linux-2.4.19/include/linux/ghash.h linux-2.4.19+ghash-fix/include/linux/ghash.h
--- linux-2.4.19/include/linux/ghash.h	Wed Sep 11 10:09:57 2002
+++ linux-2.4.19+ghash-fix/include/linux/ghash.h	Wed Sep 11 10:12:52 2002
@@ -106,7 +106,7 @@
 \
 LINKAGE TYPE * find_##NAME##_hash(struct NAME##_table * tbl, KEYTYPE pos)\
 {\
-	int ix = hashfn(pos);\
+	int ix = HASHFN(pos);\
 	TYPE * ptr = tbl->hashtable[ix];\
 	while(ptr && KEYCMP(ptr->KEY, pos))\
 		ptr = ptr->PTRS.next_hash;\
@@ -206,7 +206,7 @@
 \
 LINKAGE TYPE * find_##NAME##_hash(struct NAME##_table * tbl, KEYTYPE pos)\
 {\
-	int ix = hashfn(pos);\
+	int ix = HASHFN(pos);\
 	TYPE * ptr = tbl->hashtable[ix];\
 	while(ptr && KEYCMP(ptr->KEY, pos))\
 		ptr = ptr->PTRS.next_hash;\

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9oKSk/zRZ1SKJaI8RAmG9AJ4qXpBWBNu0VS5EPw1JtGM7Rkc4iwCgqw9P
QFaK8uSYNcGeXX5+BbEtzv4=
=B6g4
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
