Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313477AbSFBTrh>; Sun, 2 Jun 2002 15:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313492AbSFBTrg>; Sun, 2 Jun 2002 15:47:36 -0400
Received: from pD9E239B5.dip.t-dialin.net ([217.226.57.181]:8148 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S313419AbSFBTrf>; Sun, 2 Jun 2002 15:47:35 -0400
Date: Sun, 2 Jun 2002 13:47:25 -0600 (MDT)
From: Lightweight patch manager <patch@luckynet.dynu.com>
X-X-Sender: patch@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Kernel Build -- Daniel Phillips <phillips@bonn-fries.net>,
        Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        Keith Owens <kaos@ocs.com.au>, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] kbuild-2.5: get rid of warnings in split-include and mkdep
Message-ID: <Pine.LNX.4.44.0206021300590.14017-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kbuild-2.5: this patch gets rid of compiletime warnings for mkdep.c and 
            split-include.c

It is also available at
<URL:ftp://luckynet.dynu.com/pub/linux/kbuild-2.5/kbuild-2.5-noscriptwarnings.patch>

diff -Nur kbuild-2.5/scripts/mkdep.c kbuild-2.5/scripts/mkdep.c
--- kbuild-2.5/scripts/mkdep.c Sat Jun  1 16:19:33 2002
+++ kbuild-2.5/scripts/mkdep.c Sat Jun  1 16:19:33 2002 +0000 thunder (thunder-2.5/scripts/mkdep.c 1.1 0644)
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
diff -Nur kbuild-2.5/scripts/split-include.c kbuild-2.5/scripts/split-include.c
--- kbuild-2.5/scripts/split-include.c Sat Jun  1 16:19:32 2002
+++ kbuild-2.5/scripts/split-include.c Sat Jun  1 16:19:32 2002 +0000 thunder (thunder-2.5/scripts/split-include.c 1.1 0644)
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
-- 
Lightweight patch manager using pine. If you have any objections, tell me.

