Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262194AbTCRHBa>; Tue, 18 Mar 2003 02:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262198AbTCRHBa>; Tue, 18 Mar 2003 02:01:30 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:33942 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S262194AbTCRHB1>;
	Tue, 18 Mar 2003 02:01:27 -0500
Date: Tue, 18 Mar 2003 18:11:59 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ralf@gnu.org
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: [PATCH][COMPAT] compat_uptr_t and compat_ptr 3/3 mips64
Message-Id: <20030318181159.63cbccd9.sfr@canb.auug.org.au>
In-Reply-To: <20030318180635.77fee3f7.sfr@canb.auug.org.au>
References: <20030318180635.77fee3f7.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ralf,

Here is the mips64 part.  It depends on my previous COMPAT patches.  It is
safe to apply even before Linus applies the generic part.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.65-32bit.1/include/asm-mips64/compat.h 2.5.65-32bit.2/include/asm-mips64/compat.h
--- 2.5.65-32bit.1/include/asm-mips64/compat.h	2003-03-09 20:34:45.000000000 +1100
+++ 2.5.65-32bit.2/include/asm-mips64/compat.h	2003-03-12 17:57:00.000000000 +1100
@@ -103,4 +103,17 @@
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
 #endif /* _ASM_MIPS64_COMPAT_H */
