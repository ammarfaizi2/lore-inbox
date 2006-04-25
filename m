Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751491AbWDYJLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751491AbWDYJLI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 05:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbWDYJLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 05:11:08 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:8172 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751491AbWDYJLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 05:11:07 -0400
Subject: [PATCH 1/2] strstrip API
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: akpm@osdl.org
Cc: holzheu@de.ibm.com, ioe-lkml@rameria.de, joern@wohnheim.fh-wedel.de,
       minyard@acm.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-15
Date: Tue, 25 Apr 2006 12:11:04 +0300
Message-Id: <1145956265.27659.22.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pekka Enberg <penberg@cs.helsinki.fi>

This patch adds a new strstrip() function to lib/string.c for removing
leading and trailing whitespace from a string.

Cc: Michael Holzheu <holzheu@de.ibm.com>
Cc: Ingo Oeser <ioe-lkml@rameria.de>
Cc: Jörn Engel <joern@wohnheim.fh-wedel.de>
Cc: Corey Minyard <minyard@acm.org>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

---

 include/linux/string.h |    1 +
 lib/string.c           |   30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 0 deletions(-)

1a360da62131fb81460ca4abf93d20b9d0d390ff
diff --git a/include/linux/string.h b/include/linux/string.h
index c61306d..e4c7558 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -56,6 +56,7 @@ #endif
 #ifndef __HAVE_ARCH_STRRCHR
 extern char * strrchr(const char *,int);
 #endif
+extern char * strstrip(char *);
 #ifndef __HAVE_ARCH_STRSTR
 extern char * strstr(const char *,const char *);
 #endif
diff --git a/lib/string.c b/lib/string.c
index 064f631..6307726 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -301,6 +301,36 @@ char *strnchr(const char *s, size_t coun
 EXPORT_SYMBOL(strnchr);
 #endif
 
+/**
+ * strstrip - Removes leading and trailing whitespace from @s.
+ * @s: The string to be stripped.
+ *
+ * Note that the first trailing whitespace is replaced with a %NUL-terminator
+ * in the given string @s. Returns a pointer to the first non-whitespace
+ * character in @s.
+ */
+char *strstrip(char *s)
+{
+	size_t size;
+	char *end;
+
+	size = strlen(s);
+
+	if (!size)
+		return s;
+
+	end = s + size - 1;
+	while (end != s && isspace(*end))
+		end--;
+	*(end + 1) = '\0';
+
+	while (*s && isspace(*s))
+		s++;
+
+	return s;
+}
+EXPORT_SYMBOL(strstrip);
+
 #ifndef __HAVE_ARCH_STRLEN
 /**
  * strlen - Find the length of a string
-- 
1.3.0



