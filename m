Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261504AbVCCGSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261504AbVCCGSr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 01:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVCCGQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 01:16:15 -0500
Received: from fire.osdl.org ([65.172.181.4]:45008 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261508AbVCCGKJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 01:10:09 -0500
Date: Wed, 2 Mar 2005 21:58:28 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] hweight: typecast return types
Message-Id: <20050302215828.0c5be29b.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Make hweight() macros return unsigned int for 8,16,32 bits,
instead of requiring callers to do that.

drivers/input/joystick/analog.c:414: warning: int format, different type arg (arg 3)
drivers/input/joystick/analog.c:414: warning: int format, different type arg (arg 4)
drivers/input/joystick/analog.c:418: warning: int format, different type arg (arg 4)

Note:  does not address parisc, s390, or sparc64...
waiting for comments.

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 include/asm-alpha/bitops.h |    6 +++---
 include/asm-ia64/bitops.h  |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff -Naurp ./include/asm-alpha/bitops.h~hweight_types ./include/asm-alpha/bitops.h
--- ./include/asm-alpha/bitops.h~hweight_types	2005-03-01 23:38:09.000000000 -0800
+++ ./include/asm-alpha/bitops.h	2005-03-02 12:56:01.746250696 -0800
@@ -353,9 +353,9 @@ static inline unsigned long hweight64(un
 	return __kernel_ctpop(w);
 }
 
-#define hweight32(x) hweight64((x) & 0xfffffffful)
-#define hweight16(x) hweight64((x) & 0xfffful)
-#define hweight8(x)  hweight64((x) & 0xfful)
+#define hweight32(x)	(unsigned int) hweight64((x) & 0xfffffffful)
+#define hweight16(x)	(unsigned int) hweight64((x) & 0xfffful)
+#define hweight8(x)	(unsigned int) hweight64((x) & 0xfful)
 #else
 static inline unsigned long hweight64(unsigned long w)
 {
diff -Naurp ./include/asm-ia64/bitops.h~hweight_types ./include/asm-ia64/bitops.h
--- ./include/asm-ia64/bitops.h~hweight_types	2005-03-01 23:38:38.000000000 -0800
+++ ./include/asm-ia64/bitops.h	2005-03-02 12:59:27.282004512 -0800
@@ -353,9 +353,9 @@ hweight64 (unsigned long x)
 	return result;
 }
 
-#define hweight32(x) hweight64 ((x) & 0xfffffffful)
-#define hweight16(x) hweight64 ((x) & 0xfffful)
-#define hweight8(x)  hweight64 ((x) & 0xfful)
+#define hweight32(x)	(unsigned int) hweight64((x) & 0xfffffffful)
+#define hweight16(x)	(unsigned int) hweight64((x) & 0xfffful)
+#define hweight8(x)	(unsigned int) hweight64((x) & 0xfful)
 
 #endif /* __KERNEL__ */
 

---
