Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264151AbTCXLKu>; Mon, 24 Mar 2003 06:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264152AbTCXLKu>; Mon, 24 Mar 2003 06:10:50 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:11462 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S264151AbTCXLKt>;
	Mon, 24 Mar 2003 06:10:49 -0500
Date: Mon, 24 Mar 2003 22:21:48 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@transmeta.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH][COMPAT] another fix for compat_ptr
Message-Id: <20030324222148.6207e5dc.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is the other part of the missing bits of the compat_ptr patch
pointed out to me by Andrew Morton and Dave Miller. This is just
the architectures I have permission to send you.  Dave has sent you
his own already.

Please apply.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.5.65-2003032421/include/asm-parisc/compat.h 2.5.65-2003032421-32bit.1/include/asm-parisc/compat.h
--- 2.5.65-2003032421/include/asm-parisc/compat.h	2003-03-24 21:35:55.000000000 +1100
+++ 2.5.65-2003032421-32bit.1/include/asm-parisc/compat.h	2003-03-24 21:55:20.000000000 +1100
@@ -114,7 +114,7 @@
 
 static inline void *compat_ptr(compat_uptr_t uptr)
 {
-	return (void *)uptr;
+	return (void *)(unsigned long)uptr;
 }
 
 #endif /* _ASM_PARISC_COMPAT_H */
diff -ruN 2.5.65-2003032421/include/asm-ppc64/compat.h 2.5.65-2003032421-32bit.1/include/asm-ppc64/compat.h
--- 2.5.65-2003032421/include/asm-ppc64/compat.h	2003-03-24 21:35:55.000000000 +1100
+++ 2.5.65-2003032421-32bit.1/include/asm-ppc64/compat.h	2003-03-24 21:55:55.000000000 +1100
@@ -108,7 +108,7 @@
 
 static inline void *compat_ptr(compat_uptr_t uptr)
 {
-	return (void *)uptr;
+	return (void *)(unsigned long)uptr;
 }
 
 #endif /* _ASM_PPC64_COMPAT_H */
diff -ruN 2.5.65-2003032421/include/asm-s390x/compat.h 2.5.65-2003032421-32bit.1/include/asm-s390x/compat.h
--- 2.5.65-2003032421/include/asm-s390x/compat.h	2003-03-24 21:35:55.000000000 +1100
+++ 2.5.65-2003032421-32bit.1/include/asm-s390x/compat.h	2003-03-24 21:56:51.000000000 +1100
@@ -111,7 +111,7 @@
 
 static inline void *compat_ptr(compat_uptr_t uptr)
 {
-	return (void *)(uptr & 0x7fffffffUL);
+	return (void *)(unsigned long)(uptr & 0x7fffffffUL);
 }
 
 #endif /* _ASM_S390X_COMPAT_H */
diff -ruN 2.5.65-2003032421/include/asm-x86_64/compat.h 2.5.65-2003032421-32bit.1/include/asm-x86_64/compat.h
--- 2.5.65-2003032421/include/asm-x86_64/compat.h	2003-03-24 21:35:55.000000000 +1100
+++ 2.5.65-2003032421-32bit.1/include/asm-x86_64/compat.h	2003-03-24 21:57:46.000000000 +1100
@@ -117,7 +117,7 @@
 
 static inline void *compat_ptr(compat_uptr_t uptr)
 {
-	return (void *)uptr;
+	return (void *)(unsigned long)uptr;
 }
 
 #endif /* _ASM_X86_64_COMPAT_H */
