Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317874AbSGXV3Q>; Wed, 24 Jul 2002 17:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317904AbSGXV3Q>; Wed, 24 Jul 2002 17:29:16 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:6918 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S317874AbSGXV3L>;
	Wed, 24 Jul 2002 17:29:11 -0400
Date: Wed, 24 Jul 2002 23:39:42 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: torvalds@transmeta.com, davej@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] docbook: Call docbook makefile with -f [9/9]
Message-ID: <20020724233942.H12782@mars.ravnborg.org>
References: <20020724232021.A12622@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020724232021.A12622@mars.ravnborg.org>; from sam@ravnborg.org on Wed, Jul 24, 2002 at 11:20:21PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.439   -> 1.440  
#	            Makefile	1.278   -> 1.279  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/24	sam@mars.ravnborg.org	1.440
# [PATCH] docbook: Call docbook makefile with -f [9/9]
# The rewritten makefile for DocBook requires that working directory
# is $(TOPDIR) therefore use -f Documentation/DocBook/Makefile to
# invoke the docbook makefile.
# --------------------------------------------
#
diff -Nru a/Makefile b/Makefile
--- a/Makefile	Wed Jul 24 23:08:55 2002
+++ b/Makefile	Wed Jul 24 23:08:55 2002
@@ -650,7 +650,7 @@
 		-name .\*.tmp -o -name .\*.d \) -type f -print \
 		| grep -v lxdialog/ | xargs rm -f
 	@rm -f $(CLEAN_FILES)
-	@$(MAKE) -C Documentation/DocBook clean
+	@$(MAKE) -f Documentation/DocBook/Makefile clean
 
 mrproper: clean archmrproper
 	@echo 'Making mrproper'
@@ -659,7 +659,7 @@
 		-type f -print | xargs rm -f
 	@rm -f $(MRPROPER_FILES)
 	@rm -rf $(MRPROPER_DIRS)
-	@$(MAKE) -C Documentation/DocBook mrproper
+	@$(MAKE) -f Documentation/DocBook/Makefile mrproper
 
 distclean: mrproper
 	@echo 'Making distclean'
@@ -732,10 +732,8 @@
 
 # Documentation targets
 # ---------------------------------------------------------------------------
-
-sgmldocs psdocs pdfdocs htmldocs:
-	@$(MAKE) -C Documentation/DocBook $@
-
+sgmldocs psdocs pdfdocs htmldocs: scripts
+	@$(MAKE) -f Documentation/DocBook/Makefile $@
 
 # Scripts to check various things for consistency
 # ---------------------------------------------------------------------------
