Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319257AbSIKSI4>; Wed, 11 Sep 2002 14:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319258AbSIKSI4>; Wed, 11 Sep 2002 14:08:56 -0400
Received: from CPE00c0f0141dc1.cpe.net.cable.rogers.com ([24.42.47.5]:40913
	"EHLO jukie.net") by vger.kernel.org with ESMTP id <S319257AbSIKSIz>;
	Wed, 11 Sep 2002 14:08:55 -0400
Date: Wed, 11 Sep 2002 14:13:38 -0400
From: Bart Trojanowski <bart@jukie.net>
To: linux-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.19 fix for fuzzy hash <linux/ghash.h>
Message-ID: <20020911141338.A16252@jukie.net>
References: <20020911140232.R32387@jukie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020911140232.R32387@jukie.net>; from bart@jukie.net on Wed, Sep 11, 2002 at 02:02:32PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Bart Trojanowski <bart@jukie.net> [020911 14:04]:
> The DEF_HASH_FUZZY macro allows the user to template their hash; it
> takes on a paramter for the hashing-function, namely HASHFN.  When used
> with a hashing-function named anything other than 'hashfn()', a module
> using the kernel's fuzzy hash implementation will not compile.
> 
> None of the in-kernel 2.4.x drivers use this primitive (yet) so it's no
> wonder no one has spotted it.  The patch is very trivial and makes me
> think that I am the very first user of the include/linux/ghash.h
> hash-table primitive.   ;)
> 
> Bart.

Please ignore the garbage at the end of the last patch.

Here is a cleaned up one.

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
