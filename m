Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319254AbSIKR5u>; Wed, 11 Sep 2002 13:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319256AbSIKR5u>; Wed, 11 Sep 2002 13:57:50 -0400
Received: from CPE00c0f0141dc1.cpe.net.cable.rogers.com ([24.42.47.5]:38865
	"EHLO jukie.net") by vger.kernel.org with ESMTP id <S319254AbSIKR5t>;
	Wed, 11 Sep 2002 13:57:49 -0400
Date: Wed, 11 Sep 2002 14:02:32 -0400
From: Bart Trojanowski <bart@jukie.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.19 fix for fuzzy hash <linux/ghash.h>
Message-ID: <20020911140232.R32387@jukie.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="yrxji9MxLi9YGTOD"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--yrxji9MxLi9YGTOD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The DEF_HASH_FUZZY macro allows the user to template their hash; it
takes on a paramter for the hashing-function, namely HASHFN.  When used
with a hashing-function named anything other than 'hashfn()', a module
using the kernel's fuzzy hash implementation will not compile.

None of the in-kernel 2.4.x drivers use this primitive (yet) so it's no
wonder no one has spotted it.  The patch is very trivial and makes me
think that I am the very first user of the include/linux/ghash.h
hash-table primitive.   ;)

Bart.

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
diff -ruN linux-2.4.19/include/linux/ghash.h~ linux-2.4.19+ghash-fix/include/linux/ghash.h~
--- linux-2.4.19/include/linux/ghash.h~	Wed Sep 11 10:09:49 2002
+++ linux-2.4.19+ghash-fix/include/linux/ghash.h~	Wed Sep 11 10:10:57 2002
@@ -1,4 +1,3 @@
-
 /*
  * include/linux/ghash.h -- generic hashing with fuzzy retrieval
  *

--yrxji9MxLi9YGTOD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9f4U4/zRZ1SKJaI8RAvOaAKCT7+saiMZytWcqA6sfWNEdTmZyTwCg4fsI
thR3NhPB9DwpuhG6urAGcvk=
=2b3h
-----END PGP SIGNATURE-----

--yrxji9MxLi9YGTOD--
