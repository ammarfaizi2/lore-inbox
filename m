Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268035AbUGWUev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268035AbUGWUev (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 16:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268040AbUGWUeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 16:34:50 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:9077 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S268035AbUGWUei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 16:34:38 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Export all functions in lib/string.c
X-Message-Flag: Warning: May contain useful information
From: Roland Dreier <roland@topspin.com>
Date: Fri, 23 Jul 2004 13:32:10 -0700
Message-ID: <52llhatqgl.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 23 Jul 2004 20:32:10.0821 (UTC) FILETIME=[216B0750:01C470F4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quite a few functions in lib/string.c are not exported.  I ran into
this trying to use strnchr() in a module.

This patch
 - exports every function defined in lib/string.c
 - adds some missing __HAVE_ARCH_xxx defines for i386
 - gets rid of the exports of functions from lib/string.c in arch/s390
   (BTW, why is s390 exporting things NOVERS?)

Thanks,
  Roland

Signed-off-by: Roland Dreier <roland@topspin.com>

Index: linux-2.6.8-rc2/arch/s390/lib/string.c
===================================================================
--- linux-2.6.8-rc2.orig/arch/s390/lib/string.c
+++ linux-2.6.8-rc2/arch/s390/lib/string.c
@@ -394,12 +394,3 @@
 	return s;
 }
 EXPORT_SYMBOL_NOVERS(memset);
-
-/*
- * missing exports for string functions defined in lib/string.c
- */
-EXPORT_SYMBOL_NOVERS(memmove);
-EXPORT_SYMBOL_NOVERS(strchr);
-EXPORT_SYMBOL_NOVERS(strnchr);
-EXPORT_SYMBOL_NOVERS(strncmp);
-EXPORT_SYMBOL_NOVERS(strpbrk);
Index: linux-2.6.8-rc2/include/asm-i386/string.h
===================================================================
--- linux-2.6.8-rc2.orig/include/asm-i386/string.h
+++ linux-2.6.8-rc2/include/asm-i386/string.h
@@ -27,6 +27,7 @@
  */
 #if !defined(IN_STRING_C)
 
+#define __HAVE_ARCH_STRCPY
 static inline char * strcpy(char * dest,const char *src)
 {
 int d0, d1, d2;
@@ -40,6 +41,7 @@
 return dest;
 }
 
+#define __HAVE_ARCH_STRNCPY
 static inline char * strncpy(char * dest,const char *src,size_t count)
 {
 int d0, d1, d2, d3;
@@ -58,6 +60,7 @@
 return dest;
 }
 
+#define __HAVE_ARCH_STRCAT
 static inline char * strcat(char * dest,const char * src)
 {
 int d0, d1, d2, d3;
@@ -74,6 +77,7 @@
 return dest;
 }
 
+#define __HAVE_ARCH_STRNCAT
 static inline char * strncat(char * dest,const char * src,size_t count)
 {
 int d0, d1, d2, d3;
@@ -96,6 +100,7 @@
 return dest;
 }
 
+#define __HAVE_ARCH_STRCMP
 static inline int strcmp(const char * cs,const char * ct)
 {
 int d0, d1;
@@ -116,6 +121,7 @@
 return __res;
 }
 
+#define __HAVE_ARCH_STRNCMP
 static inline int strncmp(const char * cs,const char * ct,size_t count)
 {
 register int __res;
@@ -138,6 +144,7 @@
 return __res;
 }
 
+#define __HAVE_ARCH_STRCHR
 static inline char * strchr(const char * s, int c)
 {
 int d0;
@@ -156,6 +163,7 @@
 return __res;
 }
 
+#define __HAVE_ARCH_STRRCHR
 static inline char * strrchr(const char * s, int c)
 {
 int d0, d1;
Index: linux-2.6.8-rc2/lib/string.c
===================================================================
--- linux-2.6.8-rc2.orig/lib/string.c
+++ linux-2.6.8-rc2/lib/string.c
@@ -75,6 +75,7 @@
 		/* nothing */;
 	return tmp;
 }
+EXPORT_SYMBOL(strcpy);
 #endif
 
 #ifndef __HAVE_ARCH_STRNCPY
@@ -98,6 +99,7 @@
 	}
 	return dest;
 }
+EXPORT_SYMBOL(strncpy);
 #endif
 
 #ifndef __HAVE_ARCH_STRLCPY
@@ -143,6 +145,7 @@
 
 	return tmp;
 }
+EXPORT_SYMBOL(strcat);
 #endif
 
 #ifndef __HAVE_ARCH_STRNCAT
@@ -172,6 +175,7 @@
 
 	return tmp;
 }
+EXPORT_SYMBOL(strncat);
 #endif
 
 #ifndef __HAVE_ARCH_STRLCAT
@@ -218,6 +222,7 @@
 
 	return __res;
 }
+EXPORT_SYMBOL(strcmp);
 #endif
 
 #ifndef __HAVE_ARCH_STRNCMP
@@ -239,6 +244,7 @@
 
 	return __res;
 }
+EXPORT_SYMBOL(strncmp);
 #endif
 
 #ifndef __HAVE_ARCH_STRCHR
@@ -254,6 +260,7 @@
 			return NULL;
 	return (char *) s;
 }
+EXPORT_SYMBOL(strchr);
 #endif
 
 #ifndef __HAVE_ARCH_STRRCHR
@@ -271,6 +278,7 @@
        } while (--p >= s);
        return NULL;
 }
+EXPORT_SYMBOL(strrchr);
 #endif
 
 #ifndef __HAVE_ARCH_STRNCHR
@@ -287,6 +295,7 @@
 			return (char *) s;
 	return NULL;
 }
+EXPORT_SYMBOL(strnchr);
 #endif
 
 #ifndef __HAVE_ARCH_STRLEN
@@ -302,6 +311,7 @@
 		/* nothing */;
 	return sc - s;
 }
+EXPORT_SYMBOL(strlen);
 #endif
 
 #ifndef __HAVE_ARCH_STRNLEN
@@ -318,6 +328,7 @@
 		/* nothing */;
 	return sc - s;
 }
+EXPORT_SYMBOL(strnlen);
 #endif
 
 #ifndef __HAVE_ARCH_STRSPN
@@ -371,6 +382,7 @@
 
 	return count;
 }	
+EXPORT_SYMBOL(strcspn);
 
 #ifndef __HAVE_ARCH_STRPBRK
 /**
@@ -390,6 +402,7 @@
 	}
 	return NULL;
 }
+EXPORT_SYMBOL(strpbrk);
 #endif
 
 #ifndef __HAVE_ARCH_STRSEP
@@ -440,6 +453,7 @@
 
 	return s;
 }
+EXPORT_SYMBOL(memset);
 #endif
 
 #ifndef __HAVE_ARCH_BCOPY
@@ -463,6 +477,7 @@
 	while (count--)
 		*dest++ = *src++;
 }
+EXPORT_SYMBOL(bcopy);
 #endif
 
 #ifndef __HAVE_ARCH_MEMCPY
@@ -484,6 +499,7 @@
 
 	return dest;
 }
+EXPORT_SYMBOL(memcpy);
 #endif
 
 #ifndef __HAVE_ARCH_MEMMOVE
@@ -514,6 +530,7 @@
 
 	return dest;
 }
+EXPORT_SYMBOL(memmove);
 #endif
 
 #ifndef __HAVE_ARCH_MEMCMP
@@ -533,6 +550,7 @@
 			break;
 	return res;
 }
+EXPORT_SYMBOL(memcmp);
 #endif
 
 #ifndef __HAVE_ARCH_MEMSCAN
@@ -557,6 +575,7 @@
 	}
   	return (void *) p;
 }
+EXPORT_SYMBOL(memscan);
 #endif
 
 #ifndef __HAVE_ARCH_STRSTR
@@ -581,6 +600,7 @@
 	}
 	return NULL;
 }
+EXPORT_SYMBOL(strstr);
 #endif
 
 #ifndef __HAVE_ARCH_MEMCHR
@@ -603,5 +623,5 @@
 	}
 	return NULL;
 }
-
+EXPORT_SYMBOL(memchr);
 #endif
