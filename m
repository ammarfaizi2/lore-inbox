Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261492AbSKNDry>; Wed, 13 Nov 2002 22:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261451AbSKNDqp>; Wed, 13 Nov 2002 22:46:45 -0500
Received: from dp.samba.org ([66.70.73.150]:7365 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261446AbSKNDqc>;
	Wed, 13 Nov 2002 22:46:32 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Module parameters 1/4
Date: Thu, 14 Nov 2002 15:42:18 +1100
Message-Id: <20021114035325.57D082C0F6@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simple strcspn implementation for parsing.

Name: strcspn patch
Author: Rusty Russell
Status: Experimental

D: This patch implements a generic strcspn.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17889-2.5.36-param.pre/include/linux/string.h .17889-2.5.36-param/include/linux/string.h
--- .17889-2.5.36-param.pre/include/linux/string.h	2002-06-06 21:38:40.000000000 +1000
+++ .17889-2.5.36-param/include/linux/string.h	2002-09-19 16:15:20.000000000 +1000
@@ -15,7 +15,7 @@ extern "C" {
 extern char * strpbrk(const char *,const char *);
 extern char * strsep(char **,const char *);
 extern __kernel_size_t strspn(const char *,const char *);
-
+extern __kernel_size_t strcspn(const char *,const char *);
 
 /*
  * Include machine specific inline routines
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .17889-2.5.36-param.pre/lib/string.c .17889-2.5.36-param/lib/string.c
--- .17889-2.5.36-param.pre/lib/string.c	2002-05-24 15:20:35.000000000 +1000
+++ .17889-2.5.36-param/lib/string.c	2002-09-19 16:15:20.000000000 +1000
@@ -272,6 +272,29 @@ size_t strspn(const char *s, const char 
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
+	size_t count = 0;
+
+	for (p = s; *p != '\0'; ++p) {
+		for (r = reject; *r != '\0'; ++r) {
+			if (*p == *r)
+				return count;
+		}
+		++count;
+	}
+
+	return count;
+}	
+
 #ifndef __HAVE_ARCH_STRPBRK
 /**
  * strpbrk - Find the first occurrence of a set of characters

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
