Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750842AbWKAXqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbWKAXqR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 18:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbWKAXqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 18:46:17 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:19732 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750842AbWKAXqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 18:46:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qKv0Kr7kFLm80b0tPaGW0gKpCPG2YR+2SEuvQUHNl3UInBGqOb7tpxAmKOQk3oM2aoUOdyj0a4S+F2q/guZsvfHmmmvs/ShvVTQbwXwJK4VlDKMNzPBKwVyQOjgnFyOVyM3IIEb7LlZookDJdn32AUCdhd06xb5RM4fNL89ETc0=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: trivial@kernel.org
Subject: [patch] make the Makefile mostly stay within col 80
Date: Thu, 2 Nov 2006 00:47:53 +0100
User-Agent: KMail/1.9.4
Cc: linux-kernel@vger.kernel.org, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611020047.53658.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial little thing really. 
Try to make most of the Makefile obey the 80 column width rule.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

diff --git a/Makefile b/Makefile
index 9557619..beea239 100644
--- a/Makefile
+++ b/Makefile
@@ -296,7 +296,8 @@ KALLSYMS	= scripts/kallsyms
 PERL		= perl
 CHECK		= sparse
 
-CHECKFLAGS     := -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ -Wbitwise $(CF)
+CHECKFLAGS     := -D__linux__ -Dlinux -D__STDC__ -Dunix -D__unix__ \
+		  -Wbitwise $(CF)
 MODFLAGS	= -DMODULE
 CFLAGS_MODULE   = $(MODFLAGS)
 AFLAGS_MODULE   = $(MODFLAGS)
@@ -308,13 +309,13 @@ AFLAGS_KERNEL	=
 # Use LINUXINCLUDE when you must reference the include/ directory.
 # Needed to be compatible with the O= option
 LINUXINCLUDE    := -Iinclude \
-                   $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include) \
+		   $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include) \
 		   -include include/linux/autoconf.h
 
 CPPFLAGS        := -D__KERNEL__ $(LINUXINCLUDE)
 
 CFLAGS          := -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
-                   -fno-strict-aliasing -fno-common
+		   -fno-strict-aliasing -fno-common
 AFLAGS          := -D__ASSEMBLY__
 
 # Read KERNELRELEASE from include/config/kernel.release (if it exists)
@@ -333,12 +334,17 @@ export AFLAGS AFLAGS_KERNEL AFLAGS_MODUL
 # When compiling out-of-tree modules, put MODVERDIR in the module
 # tree rather than in the kernel tree. The kernel tree might
 # even be read-only.
-export MODVERDIR := $(if $(KBUILD_EXTMOD),$(firstword $(KBUILD_EXTMOD))/).tmp_versions
+export MODVERDIR := $(if $(KBUILD_EXTMOD),$(firstword \
+		    $(KBUILD_EXTMOD))/).tmp_versions
 
 # Files to ignore in find ... statements
 
-RCS_FIND_IGNORE := \( -name SCCS -o -name BitKeeper -o -name .svn -o -name CVS -o -name .pc -o -name .hg -o -name .git \) -prune -o
-export RCS_TAR_IGNORE := --exclude SCCS --exclude BitKeeper --exclude .svn --exclude CVS --exclude .pc --exclude .hg --exclude .git
+RCS_FIND_IGNORE := \( -name SCCS -o -name BitKeeper -o -name .svn -o \
+		   -name CVS -o -name .pc -o -name .hg -o -name .git \) \
+		   -prune -o
+export RCS_TAR_IGNORE := --exclude SCCS --exclude BitKeeper \
+			 --exclude .svn --exclude CVS --exclude .pc \
+			 --exclude .hg --exclude .git
 
 # ===========================================================================
 # Rules shared between *config targets and build targets
@@ -466,7 +472,8 @@ include/config/auto.conf:
 	echo;								\
 	echo "  ERROR: Kernel configuration is invalid.";		\
 	echo "         include/linux/autoconf.h or $@ are missing.";	\
-	echo "         Run 'make oldconfig && make prepare' on kernel src to fix it.";	\
+	echo "         Run 'make oldconfig && make prepare'";		\
+	echo "         on kernel src to fix it.";			\
 	echo;								\
 	/bin/false)
 
@@ -492,7 +499,8 @@ endif
 include $(srctree)/arch/$(ARCH)/Makefile
 
 ifdef CONFIG_FRAME_POINTER
-CFLAGS		+= -fno-omit-frame-pointer $(call cc-option,-fno-optimize-sibling-calls,)
+CFLAGS		+= -fno-omit-frame-pointer \
+		   $(call cc-option,-fno-optimize-sibling-calls,)
 else
 CFLAGS		+= -fomit-frame-pointer
 endif
@@ -732,7 +740,8 @@ # Generate some data for debugging stran
 debug_kallsyms: .tmp_map$(last_kallsyms)
 
 .tmp_map%: .tmp_vmlinux% FORCE
-	($(OBJDUMP) -h $< | $(AWK) '/^ +[0-9]/{print $$4 " 0 " $$2}'; $(NM) $<) | sort > $@
+	($(OBJDUMP) -h $< | $(AWK) '/^ +[0-9]/{print $$4 " 0 " $$2}'; \
+	$(NM) $<) | sort > $@
 
 .tmp_map3: .tmp_map2
 
@@ -784,7 +793,7 @@ #	$(localver-full)
 #	  $(localver)
 #	    localversion*		(all localversion* files)
 #	    $(CONFIG_LOCALVERSION)	(from kernel config setting)
-#	  $(localver-auto)		(only if CONFIG_LOCALVERSION_AUTO is set)
+#	  $(localver-auto)		(only if CONFIG_LOCALVERSION_AUTO set)
 #	    ./scripts/setlocalversion	(SCM tag, if one exists)
 #	    $(LOCALVERSION)		(from make command line if provided)
 #
@@ -846,7 +855,7 @@ # 2) Create the include2 directory, used
 prepare3: include/config/kernel.release
 ifneq ($(KBUILD_SRC),)
 	@echo '  Using $(srctree) as source for kernel'
-	$(Q)if [ -f $(srctree)/.config -o -d $(srctree)/include/config ]; then \
+	$(Q)if [ -f $(srctree)/.config -o -d $(srctree)/include/config ]; then\
 		echo "  $(srctree) is not clean, please run 'make mrproper'";\
 		echo "  in the '$(srctree)' directory.";\
 		/bin/false; \
@@ -925,26 +934,29 @@ # Kernel headers
 INSTALL_HDR_PATH=$(objtree)/usr
 export INSTALL_HDR_PATH
 
-HDRARCHES=$(filter-out generic,$(patsubst $(srctree)/include/asm-%/Kbuild,%,$(wildcard $(srctree)/include/asm-*/Kbuild)))
+HDRARCHES=$(filter-out generic,$(patsubst $(srctree)/include/asm-%/Kbuild,%,\
+	  $(wildcard $(srctree)/include/asm-*/Kbuild)))
 
 PHONY += headers_install_all
 headers_install_all: include/linux/version.h scripts_basic FORCE
 	$(Q)$(MAKE) $(build)=scripts scripts/unifdef
 	$(Q)for arch in $(HDRARCHES); do \
-	 $(MAKE) ARCH=$$arch -f $(srctree)/scripts/Makefile.headersinst obj=include BIASMDIR=-bi-$$arch ;\
+	 $(MAKE) ARCH=$$arch -f $(srctree)/scripts/Makefile.headersinst \
+	 obj=include BIASMDIR=-bi-$$arch ;\
 	 done
 
 PHONY += headers_install
 headers_install: include/linux/version.h scripts_basic FORCE
 	@if [ ! -r $(srctree)/include/asm-$(ARCH)/Kbuild ]; then \
-	  echo '*** Error: Headers not exportable for this architecture ($(ARCH))'; \
+	  echo '*** Error: Headers not exportable for this arch ($(ARCH))'; \
 	  exit 1 ; fi
 	$(Q)$(MAKE) $(build)=scripts scripts/unifdef
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.headersinst obj=include
 
 PHONY += headers_check
 headers_check: headers_install
-	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.headersinst obj=include HDRCHECK=1
+	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.headersinst \
+	obj=include HDRCHECK=1
 
 # ---------------------------------------------------------------------------
 # Modules
@@ -1000,7 +1012,8 @@ depmod_opts	:= -b $(INSTALL_MOD_PATH) -r
 endif
 PHONY += _modinst_post
 _modinst_post: _modinst_
-	if [ -r System.map -a -x $(DEPMOD) ]; then $(DEPMOD) -ae -F System.map $(depmod_opts) $(KERNELRELEASE); fi
+	if [ -r System.map -a -x $(DEPMOD) ]; then $(DEPMOD) -ae \
+		-F System.map $(depmod_opts) $(KERNELRELEASE); fi
 
 else # CONFIG_MODULES
 
@@ -1146,7 +1159,8 @@ help:
 	@echo  ''
 	@$(if $(boards), \
 		$(foreach b, $(boards), \
-		printf "  %-24s - Build for %s\\n" $(b) $(subst _defconfig,,$(b));) \
+		printf "  %-24s - Build for %s\\n" $(b) \
+			$(subst _defconfig,,$(b));) \
 		echo '')
 
 	@echo  '  make V=0|1 [targets] 0 => quiet build (default), 1 => verbose build'
@@ -1261,9 +1275,10 @@ endif # KBUILD_EXTMOD
 # Generate tags for editors
 # ---------------------------------------------------------------------------
 
-#We want __srctree to totally vanish out when KBUILD_OUTPUT is not set
-#(which is the most common case IMHO) to avoid unneeded clutter in the big tags file.
-#Adding $(srctree) adds about 20M on i386 to the size of the output file!
+# We want __srctree to totally vanish out when KBUILD_OUTPUT is not set
+# (which is the most common case IMHO) to avoid unneeded clutter in the big
+# tags file.
+# Adding $(srctree) adds about 20M on i386 to the size of the output file!
 
 ifeq ($(src),$(obj))
 __srctree =
@@ -1278,7 +1293,8 @@ else
 ALLINCLUDE_ARCHS := $(ARCH)
 endif
 else
-#Allow user to specify only ALLSOURCE_PATHS on the command line, keeping existing behavour.
+# Allow user to specify only ALLSOURCE_PATHS on the command line, keeping
+# existing behavour.
 ALLINCLUDE_ARCHS := $(ALLSOURCE_ARCHS)
 endif
 
@@ -1399,7 +1415,8 @@ checkstack:
 	$(PERL) $(src)/scripts/checkstack.pl $(SUBARCH)
 
 kernelrelease:
-	$(if $(wildcard include/config/kernel.release), $(Q)echo $(KERNELRELEASE), \
+	$(if $(wildcard include/config/kernel.release), \
+	$(Q)echo $(KERNELRELEASE), \
 	$(error kernelrelease not valid - run 'make prepare' to update it))
 kernelversion:
 	@echo $(KERNELVERSION)
@@ -1450,10 +1467,10 @@ # Modules
 # FIXME Should go into a make.lib or something 
 # ===========================================================================
 
-quiet_cmd_rmdirs = $(if $(wildcard $(rm-dirs)),CLEAN   $(wildcard $(rm-dirs)))
+quiet_cmd_rmdirs = $(if $(wildcard $(rm-dirs)),CLEAN $(wildcard $(rm-dirs)))
       cmd_rmdirs = rm -rf $(rm-dirs)
 
-quiet_cmd_rmfiles = $(if $(wildcard $(rm-files)),CLEAN   $(wildcard $(rm-files)))
+quiet_cmd_rmfiles = $(if $(wildcard $(rm-files)),CLEAN $(wildcard $(rm-files)))
       cmd_rmfiles = rm -f $(rm-files)
 
 
@@ -1467,7 +1484,8 @@ cmd_as_o_S       = $(CC) $(a_flags) -c -
 # read all saved command lines
 
 targets := $(wildcard $(sort $(targets)))
-cmd_files := $(wildcard .*.cmd $(foreach f,$(targets),$(dir $(f)).$(notdir $(f)).cmd))
+cmd_files := $(wildcard .*.cmd $(foreach f,$(targets),$(dir $(f)).$(notdir \
+	     $(f)).cmd))
 
 ifneq ($(cmd_files),)
   $(cmd_files): ;	# Do not try to update included dependency files

