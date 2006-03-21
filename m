Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030307AbWCUQVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030307AbWCUQVg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030303AbWCUQVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:21:31 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:29964 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030307AbWCUQVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:21:13 -0500
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 37/46] kbuild: replace PHONY with FORCE
In-Reply-To: <11429580571509-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Tue, 21 Mar 2006 17:20:57 +0100
Message-Id: <1142958057287-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

.PHONY: does not take patterns so use FORCE to achive same effect.
Thanks to "Paul D. Smith" <psmith@gnu.org> for noticing this.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 Makefile                 |    2 --
 scripts/package/Makefile |   18 +++++++-----------
 2 files changed, 7 insertions(+), 13 deletions(-)

0131705d589e2341dbc5e8946a60f83d8c1773dc
diff --git a/Makefile b/Makefile
index a59c1e2..eca667b 100644
--- a/Makefile
+++ b/Makefile
@@ -1000,8 +1000,6 @@ distclean: mrproper
 # rpm target kept for backward compatibility
 package-dir	:= $(srctree)/scripts/package
 
-PHONY += %-pkg rpm
-
 %pkg: FORCE
 	$(Q)$(MAKE) -f $(package-dir)/Makefile $@
 rpm: FORCE
diff --git a/scripts/package/Makefile b/scripts/package/Makefile
index d3038b7..7c434e0 100644
--- a/scripts/package/Makefile
+++ b/scripts/package/Makefile
@@ -32,12 +32,11 @@ MKSPEC     := $(srctree)/scripts/package
 PREV       := set -e; cd ..;
 
 # rpm-pkg
-PHONY += rpm-pkg rpm
-
+# ---------------------------------------------------------------------------
 $(objtree)/kernel.spec: $(MKSPEC) $(srctree)/Makefile
 	$(CONFIG_SHELL) $(MKSPEC) > $@
 
-rpm-pkg rpm: $(objtree)/kernel.spec
+rpm-pkg rpm: $(objtree)/kernel.spec FORCE
 	$(MAKE) clean
 	$(PREV) ln -sf $(srctree) $(KERNELPATH)
 	$(PREV) tar -cz $(RCS_TAR_IGNORE) -f $(KERNELPATH).tar.gz $(KERNELPATH)/.
@@ -54,11 +53,11 @@ rpm-pkg rpm: $(objtree)/kernel.spec
 clean-files := $(objtree)/kernel.spec
 
 # binrpm-pkg
-PHONY += binrpm-pkg
+# ---------------------------------------------------------------------------
 $(objtree)/binkernel.spec: $(MKSPEC) $(srctree)/Makefile
 	$(CONFIG_SHELL) $(MKSPEC) prebuilt > $@
 
-binrpm-pkg: $(objtree)/binkernel.spec
+binrpm-pkg: $(objtree)/binkernel.spec FORCE
 	$(MAKE) KBUILD_SRC=
 	set -e; \
 	$(CONFIG_SHELL) $(srctree)/scripts/mkversion > $(objtree)/.tmp_version
@@ -71,9 +70,7 @@ clean-files += $(objtree)/binkernel.spec
 
 # Deb target
 # ---------------------------------------------------------------------------
-#
-PHONY += deb-pkg
-deb-pkg:
+deb-pkg: FORCE
 	$(MAKE) KBUILD_SRC=
 	$(CONFIG_SHELL) $(srctree)/scripts/package/builddeb
 
@@ -82,8 +79,7 @@ clean-dirs += $(objtree)/debian/
 
 # tarball targets
 # ---------------------------------------------------------------------------
-PHONY += tar%pkg
-tar%pkg:
+tar%pkg: FORCE
 	$(MAKE) KBUILD_SRC=
 	$(CONFIG_SHELL) $(srctree)/scripts/package/buildtar $@
 
@@ -92,7 +88,7 @@ clean-dirs += $(objtree)/tar-install/
 
 # Help text displayed when executing 'make help'
 # ---------------------------------------------------------------------------
-help:
+help: FORCE
 	@echo '  rpm-pkg         - Build the kernel as an RPM package'
 	@echo '  binrpm-pkg      - Build an rpm package containing the compiled kernel'
 	@echo '                    and modules'
-- 
1.0.GIT


