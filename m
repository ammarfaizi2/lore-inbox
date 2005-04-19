Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261666AbVDSVMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261666AbVDSVMR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 17:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbVDSVMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 17:12:17 -0400
Received: from mail.dif.dk ([193.138.115.101]:25733 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261666AbVDSVLG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 17:11:06 -0400
Date: Tue, 19 Apr 2005 23:14:05 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steven French <sfrench@us.ibm.com>
Cc: Steve French <smfrench@austin.rr.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] cifs: little cleanups for cifs_unicode.h - functions
 and comments
Message-ID: <Pine.LNX.4.62.0504192309570.2074@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Steve,

Still working my way through fs/cifs/ doing these small cleanups. Here are 
a few more.


Clean up both comments and function definitions to match the established style
for fs/cifs/ .

This patch is also available at : 
	http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs-cifs_unicode-functions_and_comments.patch


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

 fs/cifs/cifs_unicode.h |  185 +++++++++++++++++--------------------------------
 1 files changed, 67 insertions(+), 118 deletions(-)

--- linux-2.6.12-rc2-mm3-orig/fs/cifs/cifs_unicode.h	2005-03-02 08:38:33.000000000 +0100
+++ linux-2.6.12-rc2-mm3/fs/cifs/cifs_unicode.h	2005-04-19 22:43:09.000000000 +0200
@@ -38,57 +38,46 @@
 #define  UNIUPR_NOLOWER		/* Example to not expand lower case tables */
 
 /* Just define what we want from uniupr.h.  We don't want to define the tables
- * in each source file.
- */
+   in each source file. */
 #ifndef	UNICASERANGE_DEFINED
 struct UniCaseRange {
 	wchar_t start;
 	wchar_t end;
 	signed char *table;
 };
-#endif				/* UNICASERANGE_DEFINED */
+#endif	/* UNICASERANGE_DEFINED */
 
 #ifndef UNIUPR_NOUPPER
 extern signed char CifsUniUpperTable[512];
 extern const struct UniCaseRange CifsUniUpperRange[];
-#endif				/* UNIUPR_NOUPPER */
+#endif	/* UNIUPR_NOUPPER */
 
 #ifndef UNIUPR_NOLOWER
 extern signed char UniLowerTable[512];
 extern struct UniCaseRange UniLowerRange[];
-#endif				/* UNIUPR_NOLOWER */
+#endif	/* UNIUPR_NOLOWER */
 
 #ifdef __KERNEL__
 int cifs_strfromUCS_le(char *, const wchar_t *, int, const struct nls_table *);
 int cifs_strtoUCS(wchar_t *, const char *, int, const struct nls_table *);
 #endif
 
-/*
- * UniStrcat:  Concatenate the second string to the first
- *
- * Returns:
- *     Address of the first string
- */
-static inline wchar_t *
-UniStrcat(wchar_t * ucs1, const wchar_t * ucs2)
+/* UniStrcat:  Concatenate the second string to the first
+   Returns:    Address of the first string */
+static inline wchar_t *UniStrcat(wchar_t *ucs1, const wchar_t *ucs2)
 {
 	wchar_t *anchor = ucs1;	/* save a pointer to start of ucs1 */
 
 	while (*ucs1++) ;	/* To end of first string */
-	ucs1--;			/* Return to the null */
+	ucs1--;			/* Return to the NULL */
 	while ((*ucs1++ = *ucs2++)) ;	/* copy string 2 over */
 	return anchor;
 }
 
-/*
- * UniStrchr:  Find a character in a string
- *
- * Returns:
- *     Address of first occurrence of character in string
- *     or NULL if the character is not in the string
- */
-static inline wchar_t *
-UniStrchr(const wchar_t * ucs, wchar_t uc)
+/* UniStrchr:  Find a character in a string
+   Returns:    Address of first occurrence of character in string or NULL if
+               the character is not in the string */
+static inline wchar_t *UniStrchr(const wchar_t *ucs, wchar_t uc)
 {
 	while ((*ucs != uc) && *ucs)
 		ucs++;
@@ -98,16 +87,12 @@ UniStrchr(const wchar_t * ucs, wchar_t u
 	return NULL;
 }
 
-/*
- * UniStrcmp:  Compare two strings
- *
- * Returns:
- *     < 0:  First string is less than second
- *     = 0:  Strings are equal
- *     > 0:  First string is greater than second
- */
-static inline int
-UniStrcmp(const wchar_t * ucs1, const wchar_t * ucs2)
+/* UniStrcmp:  Compare two strings
+   Returns:
+               < 0:  First string is less than second
+               = 0:  Strings are equal
+               > 0:  First string is greater than second */
+static inline int UniStrcmp(const wchar_t *ucs1, const wchar_t *ucs2)
 {
 	while ((*ucs1 == *ucs2) && *ucs1) {
 		ucs1++;
@@ -116,11 +101,8 @@ UniStrcmp(const wchar_t * ucs1, const wc
 	return (int) *ucs1 - (int) *ucs2;
 }
 
-/*
- * UniStrcpy:  Copy a string
- */
-static inline wchar_t *
-UniStrcpy(wchar_t * ucs1, const wchar_t * ucs2)
+/* UniStrcpy:  Copy a string */
+static inline wchar_t *UniStrcpy(wchar_t *ucs1, const wchar_t *ucs2)
 {
 	wchar_t *anchor = ucs1;	/* save the start of result string */
 
@@ -128,11 +110,9 @@ UniStrcpy(wchar_t * ucs1, const wchar_t 
 	return anchor;
 }
 
-/*
- * UniStrlen:  Return the length of a string (in 16 bit Unicode chars not bytes)
- */
-static inline size_t
-UniStrlen(const wchar_t * ucs1)
+/* UniStrlen:  Return the length of a string (in 16 bit Unicode chars not
+               bytes) */
+static inline size_t UniStrlen(const wchar_t *ucs1)
 {
 	int i = 0;
 
@@ -141,11 +121,9 @@ UniStrlen(const wchar_t * ucs1)
 	return i;
 }
 
-/*
- * UniStrnlen:  Return the length (in 16 bit Unicode chars not bytes) of a string (length limited)
- */
-static inline size_t
-UniStrnlen(const wchar_t * ucs1, int maxlen)
+/* UniStrnlen:  Return the length (in 16 bit Unicode chars not bytes) of a
+                string (length limited) */
+static inline size_t UniStrnlen(const wchar_t *ucs1, int maxlen)
 {
 	int i = 0;
 
@@ -157,32 +135,27 @@ UniStrnlen(const wchar_t * ucs1, int max
 	return i;
 }
 
-/*
- * UniStrncat:  Concatenate length limited string
- */
-static inline wchar_t *
-UniStrncat(wchar_t * ucs1, const wchar_t * ucs2, size_t n)
+/* UniStrncat:  Concatenate length limited string */
+static inline wchar_t *UniStrncat(wchar_t *ucs1, const wchar_t *ucs2, size_t n)
 {
 	wchar_t *anchor = ucs1;	/* save pointer to string 1 */
 
 	while (*ucs1++) ;
-	ucs1--;			/* point to null terminator of s1 */
+	ucs1--;			/* point to NULL terminator of s1 */
 	while (n-- && (*ucs1 = *ucs2)) {	/* copy s2 after s1 */
 		ucs1++;
 		ucs2++;
 	}
-	*ucs1 = 0;		/* Null terminate the result */
+	*ucs1 = 0;		/* NULL terminate the result */
 	return (anchor);
 }
 
-/*
- * UniStrncmp:  Compare length limited string
- */
-static inline int
-UniStrncmp(const wchar_t * ucs1, const wchar_t * ucs2, size_t n)
+/* UniStrncmp:  Compare length limited string */
+static inline int UniStrncmp(const wchar_t *ucs1, const wchar_t *ucs2,
+	size_t n)
 {
 	if (!n)
-		return 0;	/* Null strings are equal */
+		return 0;	/* NULL strings are equal */
 	while ((*ucs1 == *ucs2) && *ucs1 && --n) {
 		ucs1++;
 		ucs2++;
@@ -190,14 +163,12 @@ UniStrncmp(const wchar_t * ucs1, const w
 	return (int) *ucs1 - (int) *ucs2;
 }
 
-/*
- * UniStrncmp_le:  Compare length limited string - native to little-endian
- */
-static inline int
-UniStrncmp_le(const wchar_t * ucs1, const wchar_t * ucs2, size_t n)
+/* UniStrncmp_le:  Compare length limited string - native to little-endian */
+static inline int UniStrncmp_le(const wchar_t *ucs1, const wchar_t *ucs2,
+	size_t n)
 {
 	if (!n)
-		return 0;	/* Null strings are equal */
+		return 0;	/* NULL strings are equal */
 	while ((*ucs1 == __le16_to_cpu(*ucs2)) && *ucs1 && --n) {
 		ucs1++;
 		ucs2++;
@@ -205,11 +176,8 @@ UniStrncmp_le(const wchar_t * ucs1, cons
 	return (int) *ucs1 - (int) __le16_to_cpu(*ucs2);
 }
 
-/*
- * UniStrncpy:  Copy length limited string with pad
- */
-static inline wchar_t *
-UniStrncpy(wchar_t * ucs1, const wchar_t * ucs2, size_t n)
+/* UniStrncpy:  Copy length limited string with pad */
+static inline wchar_t *UniStrncpy(wchar_t *ucs1, const wchar_t *ucs2, size_t n)
 {
 	wchar_t *anchor = ucs1;
 
@@ -217,16 +185,14 @@ UniStrncpy(wchar_t * ucs1, const wchar_t
 		*ucs1++ = *ucs2++;
 
 	n++;
-	while (n--)		/* Pad with nulls */
+	while (n--)	/* Pad with NULLs */
 		*ucs1++ = 0;
 	return anchor;
 }
 
-/*
- * UniStrncpy_le:  Copy length limited string with pad to little-endian
- */
-static inline wchar_t *
-UniStrncpy_le(wchar_t * ucs1, const wchar_t * ucs2, size_t n)
+/* UniStrncpy_le:  Copy length limited string with pad to little-endian */
+static inline wchar_t *UniStrncpy_le(wchar_t *ucs1, const wchar_t *ucs2,
+	size_t n)
 {
 	wchar_t *anchor = ucs1;
 
@@ -234,20 +200,15 @@ UniStrncpy_le(wchar_t * ucs1, const wcha
 		*ucs1++ = __le16_to_cpu(*ucs2++);
 
 	n++;
-	while (n--)		/* Pad with nulls */
+	while (n--)	/* Pad with NULLs */
 		*ucs1++ = 0;
 	return anchor;
 }
 
-/*
- * UniStrstr:  Find a string in a string
- *
- * Returns:
- *     Address of first match found
- *     NULL if no matching string is found
- */
-static inline wchar_t *
-UniStrstr(const wchar_t * ucs1, const wchar_t * ucs2)
+/* UniStrstr:  Find a string in a string
+   Returns:    Address of first match found
+               NULL if no matching string is found */
+static inline wchar_t *UniStrstr(const wchar_t *ucs1, const wchar_t *ucs2)
 {
 	const wchar_t *anchor1 = ucs1;
 	const wchar_t *anchor2 = ucs2;
@@ -264,17 +225,14 @@ UniStrstr(const wchar_t * ucs1, const wc
 		}
 	}
 
-	if (!*ucs2)		/* Both end together */
+	if (!*ucs2)	/* Both end together */
 		return (wchar_t *) anchor1;	/* Match found */
-	return NULL;		/* No match */
+	return NULL;	/* No match */
 }
 
 #ifndef UNIUPR_NOUPPER
-/*
- * UniToupper:  Convert a unicode character to upper case
- */
-static inline wchar_t
-UniToupper(register wchar_t uc)
+/* UniToupper:  Convert a unicode character to upper case */
+static inline wchar_t UniToupper(register wchar_t uc)
 {
 	register const struct UniCaseRange *rp;
 
@@ -290,32 +248,26 @@ UniToupper(register wchar_t uc)
 			rp++;	/* Try next range */
 		}
 	}
-	return uc;		/* Past last range */
+	return uc;	/* Past last range */
 }
 
-/*
- * UniStrupr:  Upper case a unicode string
- */
-static inline wchar_t *
-UniStrupr(register wchar_t * upin)
+/* UniStrupr:  Upper case a unicode string */
+static inline wchar_t *UniStrupr(register wchar_t *upin)
 {
 	register wchar_t *up;
 
 	up = upin;
-	while (*up) {		/* For all characters */
+	while (*up) {	/* For all characters */
 		*up = UniToupper(*up);
 		up++;
 	}
-	return upin;		/* Return input pointer */
+	return upin;	/* Return input pointer */
 }
-#endif				/* UNIUPR_NOUPPER */
+#endif	/* UNIUPR_NOUPPER */
 
 #ifndef UNIUPR_NOLOWER
-/*
- * UniTolower:  Convert a unicode character to lower case
- */
-static inline wchar_t
-UniTolower(wchar_t uc)
+/* UniTolower:  Convert a unicode character to lower case */
+static inline wchar_t UniTolower(wchar_t uc)
 {
 	register struct UniCaseRange *rp;
 
@@ -331,23 +283,20 @@ UniTolower(wchar_t uc)
 			rp++;	/* Try next range */
 		}
 	}
-	return uc;		/* Past last range */
+	return uc;	/* Past last range */
 }
 
-/*
- * UniStrlwr:  Lower case a unicode string
- */
-static inline wchar_t *
-UniStrlwr(register wchar_t * upin)
+/* UniStrlwr:  Lower case a unicode string */
+static inline wchar_t *UniStrlwr(register wchar_t *upin)
 {
 	register wchar_t *up;
 
 	up = upin;
-	while (*up) {		/* For all characters */
+	while (*up) {	/* For all characters */
 		*up = UniTolower(*up);
 		up++;
 	}
-	return upin;		/* Return input pointer */
+	return upin;	/* Return input pointer */
 }
 
-#endif
+#endif	/* UNIUPR_NOLOWER */



