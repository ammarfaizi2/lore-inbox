Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262190AbTCRG7n>; Tue, 18 Mar 2003 01:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262194AbTCRG7n>; Tue, 18 Mar 2003 01:59:43 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:23958 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S262190AbTCRG7m>;
	Tue, 18 Mar 2003 01:59:42 -0500
Date: Tue, 18 Mar 2003 18:10:20 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: davidm@hpl.hp.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] compat_uptr_t and compat_ptr 2/3 ia64
Message-Id: <20030318181020.2d03859a.sfr@canb.auug.org.au>
In-Reply-To: <20030318180635.77fee3f7.sfr@canb.auug.org.au>
References: <20030318180635.77fee3f7.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Here is the ia64 part of the patch.  It depends on my previous COMPAT
patches.  This is safe to apply even before Linus applies the generic
part.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.65-32bit.1/include/asm-ia64/compat.h 2.5.65-32bit.2/include/asm-ia64/compat.h
--- 2.5.65-32bit.1/include/asm-ia64/compat.h	2003-03-09 20:34:45.000000000 +1100
+++ 2.5.65-32bit.2/include/asm-ia64/compat.h	2003-03-12 17:56:59.000000000 +1100
@@ -107,4 +107,17 @@
 #define COMPAT_OFF_T_MAX	0x7fffffff
 #define COMPAT_LOFF_T_MAX	0x7fffffffffffffffL
 
+/*
+ * A pointer passed in from user mode. This should not
+ * be used for syscall parameters, just declare them
+ * as pointers because the syscall entry code will have
+ * appropriately comverted them already.
+ */
+typedef	u32		compat_uptr_t;
+
+static inline void *compat_ptr(compat_ptr_t uptr)
+{
+	return (void *)uptr;
+}
+
 #endif /* _ASM_IA64_COMPAT_H */
