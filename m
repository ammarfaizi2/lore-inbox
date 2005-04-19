Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261686AbVDSVRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbVDSVRr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 17:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbVDSVRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 17:17:47 -0400
Received: from mail.dif.dk ([193.138.115.101]:52101 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261686AbVDSVQ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 17:16:57 -0400
Date: Tue, 19 Apr 2005 23:20:00 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steven French <sfrench@us.ibm.com>
Cc: Steve French <smfrench@austin.rr.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] cifs: cleanups for cifs_unicode.c
Message-ID: <Pine.LNX.4.62.0504192316510.2074@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This time it's fs/cifs/cifs_unicode.c's turn.


Minor cleanups. Make function definitions confoorm to established style, same
for comments. Remove a few blank lines and other similar minor adjustments.
No code changes.

This patch is also at : 
	http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs-cifs_unicode-cleanup.patch


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

 cifs_unicode.c |   42 ++++++++++++++----------------------------
 1 files changed, 14 insertions(+), 28 deletions(-)

--- linux-2.6.12-rc2-mm3-orig/fs/cifs/cifs_unicode.c	2005-04-11 21:20:50.000000000 +0200
+++ linux-2.6.12-rc2-mm3/fs/cifs/cifs_unicode.c	2005-04-19 23:00:57.000000000 +0200
@@ -24,15 +24,10 @@
 #include "cifspdu.h"
 #include "cifs_debug.h"
 
-/*
- * NAME:	cifs_strfromUCS()
- *
- * FUNCTION:	Convert little-endian unicode string to character string
- *
- */
-int
-cifs_strfromUCS_le(char *to, const wchar_t * from,	/* LITTLE ENDIAN */
-		   int len, const struct nls_table *codepage)
+/* NAME:	cifs_strfromUCS()
+   FUNCTION:	Convert little-endian unicode string to character string */
+int cifs_strfromUCS_le(char *to, const wchar_t *from, /* LITTLE ENDIAN */
+	int len, const struct nls_table *codepage)
 {
 	int i;
 	int outlen = 0;
@@ -40,9 +35,8 @@ cifs_strfromUCS_le(char *to, const wchar
 	for (i = 0; (i < len) && from[i]; i++) {
 		int charlen;
 		/* 2.4.0 kernel or greater */
-		charlen =
-		    codepage->uni2char(le16_to_cpu(from[i]), &to[outlen],
-				       NLS_MAX_CHARSET_SIZE);
+		charlen = codepage->uni2char(le16_to_cpu(from[i]), &to[outlen],
+					     NLS_MAX_CHARSET_SIZE);
 		if (charlen > 0) {
 			outlen += charlen;
 		} else {
@@ -53,35 +47,27 @@ cifs_strfromUCS_le(char *to, const wchar
 	return outlen;
 }
 
-/*
- * NAME:	cifs_strtoUCS()
- *
- * FUNCTION:	Convert character string to unicode string
- *
- */
-int
-cifs_strtoUCS(wchar_t * to, const char *from, int len,
-	      const struct nls_table *codepage)
+/* NAME:	cifs_strtoUCS()
+   FUNCTION:	Convert character string to unicode string */
+int cifs_strtoUCS(wchar_t *to, const char *from, int len,
+	const struct nls_table *codepage)
 {
 	int charlen;
 	int i;
 
 	for (i = 0; len && *from; i++, from += charlen, len -= charlen) {
-
 		/* works for 2.4.0 kernel or later */
 		charlen = codepage->char2uni(from, len, &to[i]);
 		if (charlen < 1) {
-			cERROR(1,
-			       ("cifs_strtoUCS: char2uni returned %d",
-				charlen));
+			cERROR(1, ("cifs_strtoUCS: char2uni returned %d",
+				   charlen));
 			to[i] = cpu_to_le16(0x003f);	/* a question mark */
 			charlen = 1;
-		} else 
+		} else {
 			to[i] = cpu_to_le16(to[i]);
-
+		}
 	}
 
 	to[i] = 0;
 	return i;
 }
-



