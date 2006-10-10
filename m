Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964989AbWJJFcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbWJJFcQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 01:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964987AbWJJFcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 01:32:15 -0400
Received: from adelie.ubuntu.com ([82.211.81.139]:18380 "EHLO
	adelie.ubuntu.com") by vger.kernel.org with ESMTP id S964989AbWJJFcP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 01:32:15 -0400
Subject: [PATCH] kbuild: Allow header_install to work with O=
From: Ben Collins <ben.collins@ubuntu.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 10 Oct 2006 01:31:56 -0400
Message-Id: <1160458316.5205.53.camel@gullible>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Without this patch, doing:

make O=/foo/build INSTALL_HDR_PATH=/foo/install-headers headers_install

Doesn't work.

Signed-off-by: Ben Collins <bcollins@ubuntu.com>

---
 Makefile                     |    2 +-
 scripts/Makefile.headersinst |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 274b780..f9e3f61 100644
--- a/Makefile
+++ b/Makefile
@@ -932,7 +932,7 @@ headers_install_all: include/linux/versi
 
 PHONY += headers_install
 headers_install: include/linux/version.h scripts_basic FORCE
-	@if [ ! -r include/asm-$(ARCH)/Kbuild ]; then \
+	@if [ ! -r $(srctree)/include/asm-$(ARCH)/Kbuild ]; then \
 	  echo '*** Error: Headers not exportable for this architecture ($(ARCH))'; \
 	  exit 1 ; fi
 	$(Q)$(MAKE) $(build)=scripts scripts/unifdef
diff --git a/scripts/Makefile.headersinst b/scripts/Makefile.headersinst
index 6a026f6..f1c3057 100644
--- a/scripts/Makefile.headersinst
+++ b/scripts/Makefile.headersinst
@@ -168,7 +168,7 @@ ifdef GENASM
 	$(call cmd,gen)
 
 else
-$(objhdr-y) :		$(INSTALL_HDR_PATH)/$(_dst)/%.h: $(srctree)/$(obj)/%.h $(KBUILDFILES)
+$(objhdr-y) :		$(INSTALL_HDR_PATH)/$(_dst)/%.h: $(obj)/%.h $(KBUILDFILES)
 	$(call cmd,o_hdr_install)
 
 $(header-y) :		$(INSTALL_HDR_PATH)/$(_dst)/%.h: $(srctree)/$(obj)/%.h $(KBUILDFILES)


