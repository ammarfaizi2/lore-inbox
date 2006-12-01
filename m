Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031634AbWLARMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031634AbWLARMF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 12:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031640AbWLARMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 12:12:05 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:45322 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1031634AbWLARMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 12:12:03 -0500
Date: Fri, 1 Dec 2006 18:12:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] cleanup include/asm-generic/atomic.h
Message-ID: <20061201171208.GG11084@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cleanup asm-generic/atomic.h

- no longer a userspace header
- remove the unneeded #include <asm/types.h>
- #else/#endif comments

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/asm-generic/Kbuild   |    1 -
 include/asm-generic/atomic.h |    9 ++++-----

--- a/include/asm-generic/atomic.h
+++ b/include/asm-generic/atomic.h
@@ -8,8 +8,6 @@ #define _ASM_GENERIC_ATOMIC_H
  * edit all arch specific atomic.h files.
  */
 
-#include <asm/types.h>
-
 /*
  * Suppport for atomic_long_t
  *
@@ -66,7 +64,7 @@ static inline void atomic_long_sub(long 
 	atomic64_sub(i, v);
 }
 
-#else
+#else  /*  BITS_PER_LONG == 64  */
 
 typedef atomic_t atomic_long_t;
 
@@ -113,5 +111,6 @@ static inline void atomic_long_sub(long 
 	atomic_sub(i, v);
 }
 
-#endif
-#endif
+#endif  /*  BITS_PER_LONG == 64  */
+
+#endif  /*  _ASM_GENERIC_ATOMIC_H  */
--- linux-2.6.19-rc6-mm2/include/asm-generic/Kbuild.old	2006-12-01 13:17:07.000000000 +0100
+++ linux-2.6.19-rc6-mm2/include/asm-generic/Kbuild	2006-12-01 13:17:10.000000000 +0100
@@ -1,4 +1,3 @@
-header-y += atomic.h
 header-y += errno-base.h
 header-y += errno.h
 header-y += fcntl.h
