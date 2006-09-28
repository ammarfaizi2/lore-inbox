Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161015AbWI1GCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161015AbWI1GCt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 02:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161018AbWI1GCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 02:02:49 -0400
Received: from natlemon.rzone.de ([81.169.145.170]:40698 "EHLO
	natlemon.rzone.de") by vger.kernel.org with ESMTP id S1161015AbWI1GCs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 02:02:48 -0400
Date: Thu, 28 Sep 2006 08:02:24 +0200
From: Olaf Hering <olaf@aepfle.de>
To: sam@ravnborg.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] add XARGS to toplevel Makefile
Message-ID: <20060928060224.GA16290@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


run xargs with --no-run-if-empty to avoid random failures:

  MAKE   tags
ctags: No files specified. Try "ctags --help".
make: *** [tags] Error 123

Signed-off-by: Olaf Hering <olaf@aepfle.de>

---
 Makefile |   25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

Index: linux-2.6/Makefile
===================================================================
--- linux-2.6.orig/Makefile
+++ linux-2.6/Makefile
@@ -295,6 +295,7 @@ DEPMOD		= /sbin/depmod
 KALLSYMS	= scripts/kallsyms
 PERL		= perl
 CHECK		= sparse
+XARGS		= xargs --no-run-if-empty
 
 CHECKFLAGS     := -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ -Wbitwise $(CF)
 MODFLAGS	= -DMODULE
@@ -1049,7 +1050,7 @@ clean: archclean $(clean-dirs)
 		\( -name '*.[oas]' -o -name '*.ko' -o -name '.*.cmd' \
 		-o -name '.*.d' -o -name '.*.tmp' -o -name '*.mod.c' \
 		-o -name '*.symtypes' \) \
-		-type f -print | xargs rm -f
+		-type f -print | $(XARGS) rm -f
 
 # mrproper - Delete all generated files, including .config
 #
@@ -1075,7 +1076,7 @@ distclean: mrproper
 		-o -name '*.bak' -o -name '#*#' -o -name '.*.orig' \
 		-o -name '.*.rej' -o -size 0 \
 		-o -name '*%' -o -name '.*.cmd' -o -name 'core' \) \
-		-type f -print | xargs rm -f
+		-type f -print | $(XARGS) rm -f
 
 
 # Packaging of the kernel to various formats
@@ -1237,7 +1238,7 @@ clean: $(clean-dirs)
 	@find $(KBUILD_EXTMOD) $(RCS_FIND_IGNORE) \
 		\( -name '*.[oas]' -o -name '*.ko' -o -name '.*.cmd' \
 		-o -name '.*.d' -o -name '.*.tmp' -o -name '*.mod.c' \) \
-		-type f -print | xargs rm -f
+		-type f -print | $(XARGS) rm -f
 
 help:
 	@echo  '  Building external modules.'
@@ -1313,26 +1314,26 @@ endef
 
 define xtags
 	if $1 --version 2>&1 | grep -iq exuberant; then \
-	    $(all-sources) | xargs $1 -a \
+	    $(all-sources) | $(XARGS) $1 -a \
 		-I __initdata,__exitdata,__acquires,__releases \
 		-I EXPORT_SYMBOL,EXPORT_SYMBOL_GPL \
 		--extra=+f --c-kinds=+px; \
-	    $(all-kconfigs) | xargs $1 -a \
+	    $(all-kconfigs) | $(XARGS) $1 -a \
 		--langdef=kconfig \
 		--language-force=kconfig \
 		--regex-kconfig='/^[[:blank:]]*config[[:blank:]]+([[:alnum:]_]+)/\1/'; \
-	    $(all-defconfigs) | xargs $1 -a \
+	    $(all-defconfigs) | $(XARGS) $1 -a \
 		--langdef=dotconfig \
 		--language-force=dotconfig \
 		--regex-dotconfig='/^#?[[:blank:]]*(CONFIG_[[:alnum:]_]+)/\1/'; \
 	elif $1 --version 2>&1 | grep -iq emacs; then \
-	    $(all-sources) | xargs $1 -a; \
-	    $(all-kconfigs) | xargs $1 -a \
+	    $(all-sources) | $(XARGS) $1 -a; \
+	    $(all-kconfigs) | $(XARGS) $1 -a \
 		--regex='/^[ \t]*config[ \t]+\([a-zA-Z0-9_]+\)/\1/'; \
-	    $(all-defconfigs) | xargs $1 -a \
+	    $(all-defconfigs) | $(XARGS) $1 -a \
 		--regex='/^#?[ \t]?\(CONFIG_[a-zA-Z0-9_]+\)/\1/'; \
 	else \
-	    $(all-sources) | xargs $1 -a; \
+	    $(all-sources) | $(XARGS) $1 -a; \
 	fi
 endef
 
@@ -1371,12 +1372,12 @@ tags: FORCE
 includecheck:
 	find * $(RCS_FIND_IGNORE) \
 		-name '*.[hcS]' -type f -print | sort \
-		| xargs $(PERL) -w scripts/checkincludes.pl
+		| $(XARGS) $(PERL) -w scripts/checkincludes.pl
 
 versioncheck:
 	find * $(RCS_FIND_IGNORE) \
 		-name '*.[hcS]' -type f -print | sort \
-		| xargs $(PERL) -w scripts/checkversion.pl
+		| $(XARGS) $(PERL) -w scripts/checkversion.pl
 
 namespacecheck:
 	$(PERL) $(srctree)/scripts/namespace.pl
