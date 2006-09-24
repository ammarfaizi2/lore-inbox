Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWIXVOJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWIXVOJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 17:14:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbWIXVNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 17:13:22 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:3474 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S932123AbWIXVNK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 17:13:10 -0400
From: sam@ravnborg.org
To: linux-kernel@vger.kernel.org
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 13/28] kbuild: make -rR is now default
Reply-To: sam@ravnborg.org
Date: Sun, 24 Sep 2006 23:18:09 +0200
Message-Id: <11591327051652-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11591327051998-git-send-email-sam@ravnborg.org>
References: 20060924210827.GA26969@uranus.ravnborg.org <1159132704708-git-send-email-sam@ravnborg.org> <11591327042606-git-send-email-sam@ravnborg.org> <11591327042944-git-send-email-sam@ravnborg.org> <11591327041272-git-send-email-sam@ravnborg.org> <11591327041374-git-send-email-sam@ravnborg.org> <11591327041093-git-send-email-sam@ravnborg.org> <11591327053484-git-send-email-sam@ravnborg.org> <11591327051061-git-send-email-sam@ravnborg.org> <11591327053770-git-send-email-sam@ravnborg.org> <11591327051381-git-send-email-sam@ravnborg.org> <11591327054119-git-send-email-sam@ravnborg.org> <11591327051998-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@mars.ravnborg.org>

Do not specify -rR anymore - it is default.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 Makefile |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 440a133..ccbc8c0 100644
--- a/Makefile
+++ b/Makefile
@@ -897,11 +897,11 @@ PHONY += headers_install
 headers_install: include/linux/version.h scripts_basic FORCE
 	$(Q)$(MAKE) $(build)=scripts scripts/unifdef
 	$(Q)rm -rf $(INSTALL_HDR_PATH)/include
-	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.headersinst obj=include
+	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.headersinst obj=include
 
 PHONY += headers_check
 headers_check: headers_install
-	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.headersinst obj=include HDRCHECK=1
+	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.headersinst obj=include HDRCHECK=1
 
 # ---------------------------------------------------------------------------
 # Modules
@@ -917,7 +917,7 @@ #	Build modules
 PHONY += modules
 modules: $(vmlinux-dirs) $(if $(KBUILD_BUILTIN),vmlinux)
 	@echo '  Building modules, stage 2.';
-	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.modpost
+	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
 
 
 # Target to prepare building external modules
@@ -943,7 +943,7 @@ _modinst_:
 		rm -f $(MODLIB)/build ; \
 		ln -s $(objtree) $(MODLIB)/build ; \
 	fi
-	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.modinst
+	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modinst
 
 # If System.map exists, run depmod.  This deliberately does not have a
 # dependency on System.map since that would run the dependency tree on
@@ -1156,7 +1156,7 @@ PHONY += $(module-dirs) modules
 
 modules: $(module-dirs)
 	@echo '  Building modules, stage 2.';
-	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.modpost
+	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
 
 PHONY += modules_install
 modules_install: _emodinst_ _emodinst_post
@@ -1165,7 +1165,7 @@ install-dir := $(if $(INSTALL_MOD_DIR),$
 PHONY += _emodinst_
 _emodinst_:
 	$(Q)mkdir -p $(MODLIB)/$(install-dir)
-	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.modinst
+	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modinst
 
 # Run depmod only is we have System.map and depmod is executable
 quiet_cmd_depmod = DEPMOD  $(KERNELRELEASE)
@@ -1381,7 +1381,7 @@ # Modules
 %.ko: prepare scripts FORCE
 	$(Q)$(MAKE) KBUILD_MODULES=$(if $(CONFIG_MODULES),1)   \
 	$(build)=$(build-dir) $(@:.ko=.o)
-	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.modpost
+	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost
 
 # FIXME Should go into a make.lib or something 
 # ===========================================================================
-- 
1.4.1

