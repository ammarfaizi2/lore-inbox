Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262681AbSJPS2v>; Wed, 16 Oct 2002 14:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262709AbSJPS2v>; Wed, 16 Oct 2002 14:28:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13840 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262681AbSJPS2u>;
	Wed, 16 Oct 2002 14:28:50 -0400
Date: Wed, 16 Oct 2002 19:34:47 +0100
From: Matthew Wilcox <willy@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] introduce UTS_MACHINE
Message-ID: <20021016193447.M15163@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We want to be able to override the value reported by uname -m so we don't
have to duplicate vast amounts of code between parisc & parisc64.

diff -urpNX build-tools/dontdiff linus-2.5/Makefile parisc-2.5/Makefile
--- linus-2.5/Makefile	Tue Oct  8 10:52:12 2002
+++ parisc-2.5/Makefile	Tue Oct 15 15:53:19 2002
@@ -38,6 +38,8 @@ ARCH := $(SUBARCH)
 
 KERNELPATH=kernel-$(shell echo $(KERNELRELEASE) | sed -e "s/-//g")
 
+UTS_MACHINE := $(ARCH)
+
 CONFIG_SHELL := $(shell if [ -x "$$BASH" ]; then echo $$BASH; \
 	  else if [ -x /bin/bash ]; then echo /bin/bash; \
 	  else echo sh; fi ; fi)
@@ -161,7 +165,8 @@ AFLAGS		:= -D__ASSEMBLY__ $(CPPFLAGS)
 
 export	VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION KERNELRELEASE ARCH \
 	CONFIG_SHELL TOPDIR HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC \
-	CPP AR NM STRIP OBJCOPY OBJDUMP MAKE MAKEFILES GENKSYMS PERL
+	CPP AR NM STRIP OBJCOPY OBJDUMP MAKE MAKEFILES GENKSYMS PERL \
+	UTS_MACHINE
 
 export CPPFLAGS NOSTDINC_FLAGS OBJCOPYFLAGS LDFLAGS
 export CFLAGS CFLAGS_KERNEL CFLAGS_MODULE 
diff -urpNX build-tools/dontdiff linus-2.5/init/Makefile parisc-2.5/init/Makefile
--- linus-2.5/init/Makefile	Tue Oct  8 10:54:20 2002
+++ parisc-2.5/init/Makefile	Tue Oct  8 16:49:22 2002
@@ -17,4 +17,4 @@ $(obj)/version.o: $(objtree)/include/lin
 
 $(objtree)/include/linux/compile.h: FORCE
 	@echo -n '  Generating $@'
-	@$(srctree)/scripts/mkcompile_h $@ "$(ARCH)" "$(CONFIG_SMP)" "$(CC) $(CFLAGS)"
+	@$(srctree)/scripts/mkcompile_h $@ "$(UTS_MACHINE)" "$(CONFIG_SMP)" "$(CC) $(CFLAGS)"

-- 
Revolutions do not require corporate support.
