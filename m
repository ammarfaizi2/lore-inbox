Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbWIXVNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbWIXVNN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 17:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWIXVNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 17:13:12 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:14300 "EHLO pasmtpA.tele.dk")
	by vger.kernel.org with ESMTP id S932111AbWIXVNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 17:13:09 -0400
From: sam@ravnborg.org
To: linux-kernel@vger.kernel.org
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 5/28] kbuild: use in-kernel unifdef
Reply-To: sam@ravnborg.org
Date: Sun, 24 Sep 2006 23:18:01 +0200
Message-Id: <11591327041374-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11591327041272-git-send-email-sam@ravnborg.org>
References: 20060924210827.GA26969@uranus.ravnborg.org <1159132704708-git-send-email-sam@ravnborg.org> <11591327042606-git-send-email-sam@ravnborg.org> <11591327042944-git-send-email-sam@ravnborg.org> <11591327041272-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@mars.ravnborg.org>

Let headers_install use in-kernel unifdef

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 Makefile                     |    4 ++--
 scripts/Makefile             |    3 +++
 scripts/Makefile.headersinst |    2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index edfc2fd..b06b1ea 100644
--- a/Makefile
+++ b/Makefile
@@ -893,8 +893,8 @@ INSTALL_HDR_PATH=$(objtree)/usr
 export INSTALL_HDR_PATH
 
 PHONY += headers_install
-headers_install: include/linux/version.h
-	$(Q)unifdef -Ux /dev/null
+headers_install: include/linux/version.h scripts_basic FORCE
+	$(Q)$(MAKE) $(build)=scripts scripts/unifdef
 	$(Q)rm -rf $(INSTALL_HDR_PATH)/include
 	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.headersinst obj=include
 
diff --git a/scripts/Makefile b/scripts/Makefile
index 6f6b48f..d531a1f 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -15,6 +15,9 @@ hostprogs-$(CONFIG_IKCONFIG)     += bin2
 
 always		:= $(hostprogs-y)
 
+# The following hostprogs-y programs are only build on demand
+hostprogs-y += unifdef
+
 subdir-$(CONFIG_MODVERSIONS) += genksyms
 subdir-$(CONFIG_MODULES)     += mod
 
diff --git a/scripts/Makefile.headersinst b/scripts/Makefile.headersinst
index 12e1daf..8c02d2d 100644
--- a/scripts/Makefile.headersinst
+++ b/scripts/Makefile.headersinst
@@ -7,7 +7,7 @@ # objhdr-y are generated files that will
 #
 # ==========================================================================
 
-UNIFDEF := unifdef -U__KERNEL__
+UNIFDEF := scripts/unifdef -U__KERNEL__
 
 # Eliminate the contents of (and inclusions of) compiler.h
 HDRSED  := sed 	-e "s/ inline / __inline__ /g" \
-- 
1.4.1

