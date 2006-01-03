Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbWACN2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbWACN2P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 08:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbWACN2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 08:28:13 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:43781 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932358AbWACNZi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 08:25:38 -0500
Subject: [PATCH 09/26] kconfig: move lxdialog to scripts/kconfig/lxdialog
In-Reply-To: <20060103132035.GA17485@mars.ravnborg.org>
X-Mailer: gregkh_patchbomb-sam
Date: Tue, 3 Jan 2006 14:25:25 +0100
Message-Id: <11362947251865@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Ravnborg <sam@mars.ravnborg.org>
Date: 1134765319 +0100

The only lxdialog user i kconfig - for menuconfig.
So move it to reflect this.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 scripts/Makefile                         |    2 +-
 scripts/kconfig/Makefile                 |    3 ++-
 scripts/kconfig/lxdialog/BIG.FAT.WARNING |    0 
 scripts/kconfig/lxdialog/Makefile        |    0 
 scripts/kconfig/lxdialog/checklist.c     |    0 
 scripts/kconfig/lxdialog/colors.h        |    0 
 scripts/kconfig/lxdialog/dialog.h        |    0 
 scripts/kconfig/lxdialog/inputbox.c      |    0 
 scripts/kconfig/lxdialog/lxdialog.c      |    0 
 scripts/kconfig/lxdialog/menubox.c       |    2 +-
 scripts/kconfig/lxdialog/msgbox.c        |    0 
 scripts/kconfig/lxdialog/textbox.c       |    0 
 scripts/kconfig/lxdialog/util.c          |    0 
 scripts/kconfig/lxdialog/yesno.c         |    0 
 scripts/kconfig/mconf.c                  |    2 +-
 15 files changed, 5 insertions(+), 4 deletions(-)
 rename scripts/{lxdialog/BIG.FAT.WARNING => kconfig/lxdialog/BIG.FAT.WARNING} (100%)
 rename scripts/{lxdialog/Makefile => kconfig/lxdialog/Makefile} (100%)
 rename scripts/{lxdialog/checklist.c => kconfig/lxdialog/checklist.c} (100%)
 rename scripts/{lxdialog/colors.h => kconfig/lxdialog/colors.h} (100%)
 rename scripts/{lxdialog/dialog.h => kconfig/lxdialog/dialog.h} (100%)
 rename scripts/{lxdialog/inputbox.c => kconfig/lxdialog/inputbox.c} (100%)
 rename scripts/{lxdialog/lxdialog.c => kconfig/lxdialog/lxdialog.c} (100%)
 rename scripts/{lxdialog/menubox.c => kconfig/lxdialog/menubox.c} (100%)
 rename scripts/{lxdialog/msgbox.c => kconfig/lxdialog/msgbox.c} (100%)
 rename scripts/{lxdialog/textbox.c => kconfig/lxdialog/textbox.c} (100%)
 rename scripts/{lxdialog/util.c => kconfig/lxdialog/util.c} (100%)
 rename scripts/{lxdialog/yesno.c => kconfig/lxdialog/yesno.c} (100%)

6f6046cff2e8f04d6b916b10ebaa7b40d7e7967a
diff --git a/scripts/Makefile b/scripts/Makefile
index 67763ee..6f6b48f 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -19,4 +19,4 @@ subdir-$(CONFIG_MODVERSIONS) += genksyms
 subdir-$(CONFIG_MODULES)     += mod
 
 # Let clean descend into subdirs
-subdir-	+= basic lxdialog kconfig package
+subdir-	+= basic kconfig package
diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index 9d67782..55bf955 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -11,7 +11,7 @@ gconfig: $(obj)/gconf
 	$< arch/$(ARCH)/Kconfig
 
 menuconfig: $(obj)/mconf
-	$(Q)$(MAKE) $(build)=scripts/lxdialog
+	$(Q)$(MAKE) $(build)=scripts/kconfig/lxdialog
 	$< arch/$(ARCH)/Kconfig
 
 config: $(obj)/conf
@@ -115,6 +115,7 @@ endif
 
 clean-files	:= lkc_defs.h qconf.moc .tmp_qtcheck \
 		   .tmp_gtkcheck zconf.tab.c lex.zconf.c zconf.hash.c
+subdir- += lxdialog
 
 # Needed for systems without gettext
 KBUILD_HAVE_NLS := $(shell \
diff --git a/scripts/lxdialog/BIG.FAT.WARNING b/scripts/kconfig/lxdialog/BIG.FAT.WARNING
similarity index 100%
rename from scripts/lxdialog/BIG.FAT.WARNING
rename to scripts/kconfig/lxdialog/BIG.FAT.WARNING
diff --git a/scripts/lxdialog/Makefile b/scripts/kconfig/lxdialog/Makefile
similarity index 100%
rename from scripts/lxdialog/Makefile
rename to scripts/kconfig/lxdialog/Makefile
diff --git a/scripts/lxdialog/checklist.c b/scripts/kconfig/lxdialog/checklist.c
similarity index 100%
rename from scripts/lxdialog/checklist.c
rename to scripts/kconfig/lxdialog/checklist.c
diff --git a/scripts/lxdialog/colors.h b/scripts/kconfig/lxdialog/colors.h
similarity index 100%
rename from scripts/lxdialog/colors.h
rename to scripts/kconfig/lxdialog/colors.h
diff --git a/scripts/lxdialog/dialog.h b/scripts/kconfig/lxdialog/dialog.h
similarity index 100%
rename from scripts/lxdialog/dialog.h
rename to scripts/kconfig/lxdialog/dialog.h
diff --git a/scripts/lxdialog/inputbox.c b/scripts/kconfig/lxdialog/inputbox.c
similarity index 100%
rename from scripts/lxdialog/inputbox.c
rename to scripts/kconfig/lxdialog/inputbox.c
diff --git a/scripts/lxdialog/lxdialog.c b/scripts/kconfig/lxdialog/lxdialog.c
similarity index 100%
rename from scripts/lxdialog/lxdialog.c
rename to scripts/kconfig/lxdialog/lxdialog.c
diff --git a/scripts/lxdialog/menubox.c b/scripts/kconfig/lxdialog/menubox.c
similarity index 100%
rename from scripts/lxdialog/menubox.c
rename to scripts/kconfig/lxdialog/menubox.c
index 2d91880..09512b5 100644
--- a/scripts/lxdialog/menubox.c
+++ b/scripts/kconfig/lxdialog/menubox.c
@@ -58,7 +58,7 @@
 
 #include "dialog.h"
 
-#define ITEM_IDENT 4   /* Indent of menu entries. Fixed for all menus */
+#define ITEM_IDENT 1   /* Indent of menu entries. Fixed for all menus */
 static int menu_width;
 
 /*
diff --git a/scripts/lxdialog/msgbox.c b/scripts/kconfig/lxdialog/msgbox.c
similarity index 100%
rename from scripts/lxdialog/msgbox.c
rename to scripts/kconfig/lxdialog/msgbox.c
diff --git a/scripts/lxdialog/textbox.c b/scripts/kconfig/lxdialog/textbox.c
similarity index 100%
rename from scripts/lxdialog/textbox.c
rename to scripts/kconfig/lxdialog/textbox.c
diff --git a/scripts/lxdialog/util.c b/scripts/kconfig/lxdialog/util.c
similarity index 100%
rename from scripts/lxdialog/util.c
rename to scripts/kconfig/lxdialog/util.c
diff --git a/scripts/lxdialog/yesno.c b/scripts/kconfig/lxdialog/yesno.c
similarity index 100%
rename from scripts/lxdialog/yesno.c
rename to scripts/kconfig/lxdialog/yesno.c
diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
index d1ad405..d63d7fb 100644
--- a/scripts/kconfig/mconf.c
+++ b/scripts/kconfig/mconf.c
@@ -325,7 +325,7 @@ static void cprint_init(void)
 	memset(args, 0, sizeof(args));
 	indent = 0;
 	child_count = 0;
-	cprint("./scripts/lxdialog/lxdialog");
+	cprint("./scripts/kconfig/lxdialog/lxdialog");
 	cprint("--backtitle");
 	cprint(menu_backtitle);
 }
-- 
1.0.6

