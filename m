Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271967AbRH2OC5>; Wed, 29 Aug 2001 10:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271970AbRH2OCh>; Wed, 29 Aug 2001 10:02:37 -0400
Received: from spr-tik2.ethz.ch ([129.132.119.69]:57289 "EHLO tik2.ethz.ch")
	by vger.kernel.org with ESMTP id <S271967AbRH2OC0>;
	Wed, 29 Aug 2001 10:02:26 -0400
Date: Wed, 29 Aug 2001 16:02:34 +0200
From: Lukas Ruf <ruf@tik.ee.ethz.ch>
To: Linux Kernel ml <linux-kernel@vger.kernel.org>
Subject: [PATCH] include/linux/ghash.h (2.4.8 & 2.4.9)
Message-ID: <20010829160234.K13576@tik.ee.ethz.ch>
Reply-To: Lukas Ruf <ruf@tik.ee.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
X-ID: 0xD20BA2ED
X-URL: www.tik.ee.ethz.ch/~ruf
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Dear all,

please find attached two patches for include/linux/ghash.h against 2.4.8
and 2.4.9 (even if they seem to be the same ,-).

The issue, I struggled over:
in find_##NAME_hash() the macro argument was written in lower case.
Therefore, a module that makes use of ghash.h cannot be depmod'd as hashfn
is a not resolved symbol.

The provided patch fixes this small typo by that it changes hashfn to
HASHFN, as required by the macro definition.

I missed this correction in 2.4.8 (up to ac12) as well as in 2.4.9
(vanilla).  Please drop a line if I misunderstood something.  Otherwise
include the patch in the kernel, please.

Any comments are welcome!

Lukas

-- 
Lukas Ruf                        Swiss Federal Institute of Technology
Office: ETZ-G61.2                             Computer Engineering and
Phone: +41/1/632 7312                        Networks Laboratory (TIK)
Fax:   +41/1/632 1035                                      ETH Zentrum
PGP 2.6: ID D20BA2ED;                                    Gloriastr. 35
Fingerprint 6323 B9BC 9C8E 6563  B477 BADD FEA6 E6B7    CH-8092 Zurich

--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.8-ghash.diff"

--- linux,orig/include/linux/ghash.h	Mon Jul  7 17:24:28 1997
+++ linux/include/linux/ghash.h	Wed Aug 29 14:46:15 2001
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

--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-2.4.9-ghash.diff"

--- linux/include/linux/ghash.h,orig	Wed Aug 29 15:53:29 2001
+++ linux/include/linux/ghash.h	Wed Aug 29 15:54:11 2001
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

--5mCyUwZo2JvN/JJP--
