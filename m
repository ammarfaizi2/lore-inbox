Return-Path: <linux-kernel-owner+w=401wt.eu-S964915AbWLMNHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964915AbWLMNHk (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 08:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbWLMNHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 08:07:40 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2439 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S964915AbWLMNHi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 08:07:38 -0500
Date: Wed, 13 Dec 2006 14:07:46 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [-mm patch] cleanup linux/byteorder/swabb.h
Message-ID: <20061213130746.GH3851@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- no longer a userspace header
- add #include <linux/types.h> for in-kernel compilation

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/linux/byteorder/Kbuild  |    1 -
 include/linux/byteorder/swabb.h |   13 ++++---------
 2 files changed, 4 insertions(+), 10 deletions(-)

--- a/include/linux/byteorder/swabb.h
+++ b/include/linux/byteorder/swabb.h
@@ -25,6 +25,8 @@ #define _LINUX_BYTEORDER_SWABB_H
  *
  */
 
+#include <linux/types.h>
+
 #define ___swahw32(x) \
 ({ \
 	__u32 __x = (x); \
@@ -77,19 +79,14 @@ #endif
 /*
  * Allow constant folding
  */
-#if defined(__GNUC__) && defined(__OPTIMIZE__)
-#  define __swahw32(x) \
+#define __swahw32(x) \
 (__builtin_constant_p((__u32)(x)) ? \
  ___swahw32((x)) : \
  __fswahw32((x)))
-#  define __swahb32(x) \
+#define __swahb32(x) \
 (__builtin_constant_p((__u32)(x)) ? \
  ___swahb32((x)) : \
  __fswahb32((x)))
-#else
-#  define __swahw32(x) __fswahw32(x)
-#  define __swahb32(x) __fswahb32(x)
-#endif /* OPTIMIZE */
 
 
 static inline __u32 __fswahw32(__u32 x)
@@ -128,13 +125,11 @@ #ifdef __BYTEORDER_HAS_U64__
  */
 #endif /* __BYTEORDER_HAS_U64__ */
 
-#if defined(__KERNEL__)
 #define swahw32 __swahw32
 #define swahb32 __swahb32
 #define swahw32p __swahw32p
 #define swahb32p __swahb32p
 #define swahw32s __swahw32s
 #define swahb32s __swahb32s
-#endif
 
 #endif /* _LINUX_BYTEORDER_SWABB_H */
--- linux-2.6.19-mm1/include/linux/byteorder/Kbuild.old	2006-12-13 02:33:41.000000000 +0100
+++ linux-2.6.19-mm1/include/linux/byteorder/Kbuild	2006-12-13 02:33:46.000000000 +0100
@@ -2,5 +2,4 @@
 header-y += little_endian.h
 
 unifdef-y += generic.h
-unifdef-y += swabb.h
 unifdef-y += swab.h
