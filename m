Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267106AbSKSGRt>; Tue, 19 Nov 2002 01:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267111AbSKSGRL>; Tue, 19 Nov 2002 01:17:11 -0500
Received: from dp.samba.org ([66.70.73.150]:51381 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267112AbSKSGQS>;
	Tue, 19 Nov 2002 01:16:18 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: [PATCH] 1/4 Module Parameter Support
Date: Tue, 19 Nov 2002 17:12:56 +1100
Message-Id: <20021119062321.A9B0E2C48F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this time less shouting, more module-like.  Thanks Jeff, Linus for
suggestions.

Please report if module param parsing is not compatible for you.
Rusty.

Name: strcspn patch
Author: Rusty Russell
Status: Experimental

D: This patch implements a generic strcspn.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7629-linux-2.5-bk/include/linux/string.h .7629-linux-2.5-bk.updated/include/linux/string.h
--- .7629-linux-2.5-bk/include/linux/string.h	2002-06-06 21:38:40.000000000 +1000
+++ .7629-linux-2.5-bk.updated/include/linux/string.h	2002-11-16 17:24:44.000000000 +1100
@@ -15,7 +15,7 @@ extern "C" {
 extern char * strpbrk(const char *,const char *);
 extern char * strsep(char **,const char *);
 extern __kernel_size_t strspn(const char *,const char *);
-
+extern __kernel_size_t strcspn(const char *,const char *);
 
 /*
  * Include machine specific inline routines
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .7629-linux-2.5-bk/lib/string.c .7629-linux-2.5-bk.updated/lib/string.c
--- .7629-linux-2.5-bk/lib/string.c	2002-05-24 15:20:35.000000000 +1000
+++ .7629-linux-2.5-bk.updated/lib/string.c	2002-11-16 17:25:20.000000000 +1100
@@ -272,6 +272,27 @@ size_t strspn(const char *s, const char 
 }
 #endif
 
+/**
+ * strcspn - Calculate the length of the initial substring of @s which does
+ * 	not contain letters in @reject
+ * @s: The string to be searched
+ * @reject: The string to avoid
+ */
+size_t strcspn(const char *s, const char *reject)
+{
+	const char *p;
+	const char *r;
+
+	for (p = s; *p != '\0'; ++p) {
+		for (r = reject; *r != '\0'; ++r) {
+			if (*p == *r)
+				return p - s;
+		}
+	}
+
+	return p - s;
+}
+
 #ifndef __HAVE_ARCH_STRPBRK
 /**
  * strpbrk - Find the first occurrence of a set of characters

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
