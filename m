Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316782AbSEaUl6>; Fri, 31 May 2002 16:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316803AbSEaUl5>; Fri, 31 May 2002 16:41:57 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:25102 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S316782AbSEaUly>;
	Fri, 31 May 2002 16:41:54 -0400
Date: Fri, 31 May 2002 22:43:59 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: [PATCH] kbuild: Get rid of warnings in depmod + split-include
Message-ID: <20020531224359.B13857@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PPYy/fEw/8QCHSq3"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--PPYy/fEw/8QCHSq3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Remove compiletime warnings from mkdep.c and split-include.c
Credits for this patch goes to Keith Owens.

Credits for this patch goes to Keith Owens, I just extracted it from kbuild-2.5.

	Sam

--PPYy/fEw/8QCHSq3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="warnings.diff"

--- mkdep.c.orig	Fri May 31 21:59:07 2002
+++ mkdep.c	Fri May 31 21:41:41 2002
@@ -268,7 +268,7 @@
 
 	for (i = 0; i < len; i++) {
 	    char c = name[i];
-	    if (isupper(c)) c = tolower(c);
+	    if (isupper((int)c)) c = tolower((int)c);
 	    if (c == '_')   c = '/';
 	    pc[i] = c;
 	}
@@ -496,7 +496,7 @@
 
 /* \<CONFIG_(\w*) */
 cee:
-	if (next >= map+2 && (isalnum(next[-2]) || next[-2] == '_'))
+	if (next >= map+2 && (isalnum((int)next[-2]) || next[-2] == '_'))
 		goto start;
 	GETNEXT NOTCASE('O', __start);
 	GETNEXT NOTCASE('N', __start);
--- split-include.c.orig	Fri May 31 21:57:10 2002
+++ split-include.c	Fri May 31 21:41:41 2002
@@ -115,10 +115,10 @@
 
 	/* Make the output file name. */
 	str_config += sizeof("CONFIG_") - 1;
-	for (itarget = 0; !isspace(str_config[itarget]); itarget++)
+	for (itarget = 0; !isspace((int)str_config[itarget]); itarget++)
 	{
 	    char c = str_config[itarget];
-	    if (isupper(c)) c = tolower(c);
+	    if (isupper((int)c)) c = tolower((int)c);
 	    if (c == '_')   c = '/';
 	    ptarget[itarget] = c;
 	}

--PPYy/fEw/8QCHSq3--
