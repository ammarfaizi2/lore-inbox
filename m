Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317624AbSGXV2M>; Wed, 24 Jul 2002 17:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317643AbSGXV2M>; Wed, 24 Jul 2002 17:28:12 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:39172 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S317624AbSGXV2K>;
	Wed, 24 Jul 2002 17:28:10 -0400
Date: Wed, 24 Jul 2002 23:38:35 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: torvalds@transmeta.com, davej@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] docbook: Move script target in top-level file [8/9]
Message-ID: <20020724233835.G12782@mars.ravnborg.org>
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
#	           ChangeSet	1.438   -> 1.439  
#	            Makefile	1.277   -> 1.278  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/24	sam@mars.ravnborg.org	1.439
# [PATCH] docbook: Move script target in top-level file [8/9]
# To support the new DocBook makefile the script target needs to be located
# the block that is checked for precense of a .config file.
# --------------------------------------------
#
diff -Nru a/Makefile b/Makefile
--- a/Makefile	Wed Jul 24 23:09:43 2002
+++ b/Makefile	Wed Jul 24 23:09:43 2002
@@ -166,6 +166,15 @@
 		    help tags TAGS sgmldocs psdocs pdfdocs htmldocs \
 		    checkconfig checkhelp checkincludes
 
+# Helpers built in scripts/
+# ---------------------------------------------------------------------------
+
+scripts/docproc scripts/fixdep scripts/split-include : scripts ;
+
+.PHONY: scripts
+scripts:
+	@$(MAKE) -C scripts
+
 ifeq ($(filter $(noconfig_targets),$(MAKECMDGOALS)),)
 
 # Here goes the main Makefile
@@ -356,15 +365,6 @@
 	 echo '#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))'; \
 	) > $@.tmp
 	@$(update-if-changed)
-
-# Helpers built in scripts/
-# ---------------------------------------------------------------------------
-
-scripts/fixdep scripts/split-include : scripts ;
-
-.PHONY: scripts
-scripts:
-	@$(MAKE) -C scripts
 
 # Generate module versions
 # ---------------------------------------------------------------------------
