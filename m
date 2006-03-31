Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWCaEfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWCaEfs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 23:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWCaEfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 23:35:48 -0500
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:55178 "EHLO
	stout.engsoc.carleton.ca") by vger.kernel.org with ESMTP
	id S1750707AbWCaEfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 23:35:47 -0500
Date: Thu, 30 Mar 2006 23:33:45 -0500
From: Kyle McMartin <kyle@parisc-linux.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Clean up arch-overrides in linux/string.h
Message-ID: <20060331043345.GH31321@quicksilver.road.mcmartin.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some string functions were safely overrideable in lib/string.c, but
their corresponding declarations in linux/string.h were not.
Correct this, and make strcspn overrideable.

Odds of someone wanting to do optimized assembly of these are small,
but for the sake of cleanliness, might as well bring them into line with
the rest of the file.

Signed-off-by: Kyle McMartin <kyle@parisc-linux.org>

---
diff --git a/include/linux/string.h b/include/linux/string.h
index dee2214..c044eab 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -13,11 +13,6 @@
 extern "C" {
 #endif
 
-extern char * strpbrk(const char *,const char *);
-extern char * strsep(char **,const char *);
-extern __kernel_size_t strspn(const char *,const char *);
-extern __kernel_size_t strcspn(const char *,const char *);
-
 extern char *strndup_user(const char __user *, long);
 
 /*
@@ -70,6 +65,18 @@ extern __kernel_size_t strlen(const char
 #ifndef __HAVE_ARCH_STRNLEN
 extern __kernel_size_t strnlen(const char *,__kernel_size_t);
 #endif
+#ifndef __HAVE_ARCH_STRPBRK
+extern char * strpbrk(const char *,const char *);
+#endif
+#ifndef __HAVE_ARCH_STRSEP
+extern char * strsep(char **,const char *);
+#endif
+#ifndef __HAVE_ARCH_STRSPN
+extern __kernel_size_t strspn(const char *,const char *);
+#endif
+#ifndef __HAVE_ARCH_STRCSPN
+extern __kernel_size_t strcspn(const char *,const char *);
+#endif
 
 #ifndef __HAVE_ARCH_MEMSET
 extern void * memset(void *,int,__kernel_size_t);
diff --git a/lib/string.c b/lib/string.c
index b3c28a3..b1c8645 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -362,6 +362,7 @@ size_t strspn(const char *s, const char 
 EXPORT_SYMBOL(strspn);
 #endif
 
+#ifndef __HAVE_ARCH_STRCSPN
 /**
  * strcspn - Calculate the length of the initial substring of @s which does
  * 	not contain letters in @reject
@@ -384,6 +385,7 @@ size_t strcspn(const char *s, const char
 	return count;
 }
 EXPORT_SYMBOL(strcspn);
+#endif
 
 #ifndef __HAVE_ARCH_STRPBRK
 /**
