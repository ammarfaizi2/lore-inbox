Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267903AbUHRVTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267903AbUHRVTu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 17:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267891AbUHRVQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 17:16:46 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:28022 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S267748AbUHRVI6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 17:08:58 -0400
Date: Thu, 19 Aug 2004 01:09:11 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: kbuild: Added CHECKFLAGS to enable 'make CHECK=mysparse'
Message-ID: <20040818230911.GG23495@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040818230252.GA23495@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040818230252.GA23495@mars.ravnborg.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/08/18 23:31:32+02:00 sam@mars.ravnborg.org 
#   kbuild/all archs: added CHECKFLAGS
#   
#   Using separate assignment for CHECKFLAGS allows convenient redefinition of CHECK
#   on the command line:
#   make CHECK=~/bin64/sparse C=2
#   to use a special 64 bit version.
#   Introduced usage in all archs that assined values to CHECK.
#   
#   Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
# 
# scripts/Makefile.build
#   2004/08/18 23:31:15+02:00 sam@mars.ravnborg.org +2 -2
#   Use CHECKFLAGS
# 
# arch/x86_64/Makefile
#   2004/08/18 23:31:15+02:00 sam@mars.ravnborg.org +1 -1
#   Replace assigment to CHECK with assignment to CHECKFLAGS
# 
# arch/sparc64/Makefile
#   2004/08/18 23:31:15+02:00 sam@mars.ravnborg.org +1 -1
#   Replace assigment to CHECK with assignment to CHECKFLAGS
# 
# arch/sparc/Makefile
#   2004/08/18 23:31:15+02:00 sam@mars.ravnborg.org +1 -1
#   Replace assigment to CHECK with assignment to CHECKFLAGS
# 
# arch/ppc64/Makefile
#   2004/08/18 23:31:15+02:00 sam@mars.ravnborg.org +1 -1
#   Replace assigment to CHECK with assignment to CHECKFLAGS
# 
# arch/ppc/Makefile
#   2004/08/18 23:31:15+02:00 sam@mars.ravnborg.org +1 -1
#   Replace assigment to CHECK with assignment to CHECKFLAGS
# 
# arch/m68k/Makefile
#   2004/08/18 23:31:15+02:00 sam@mars.ravnborg.org +1 -1
#   Replace assigment to CHECK with assignment to CHECKFLAGS
# 
# arch/i386/Makefile
#   2004/08/18 23:31:15+02:00 sam@mars.ravnborg.org +1 -1
#   Replace assigment to CHECK with assignment to CHECKFLAGS
# 
# arch/arm/Makefile
#   2004/08/18 23:31:15+02:00 sam@mars.ravnborg.org +1 -1
#   Replace assigment to CHECK with assignment to CHECKFLAGS
# 
# arch/alpha/Makefile
#   2004/08/18 23:31:15+02:00 sam@mars.ravnborg.org +1 -1
#   Replace assigment to CHECK with assignment to CHECKFLAGS
# 
# Makefile
#   2004/08/18 23:31:15+02:00 sam@mars.ravnborg.org +2 -1
#   Introduce CHECKFLAGS
# 
diff -Nru a/Makefile b/Makefile
--- a/Makefile	2004-08-19 01:08:59 +02:00
+++ b/Makefile	2004-08-19 01:08:59 +02:00
@@ -285,6 +285,7 @@
 KALLSYMS	= scripts/kallsyms
 PERL		= perl
 CHECK		= sparse
+CHECKFLAGS     :=
 MODFLAGS	= -DMODULE
 CFLAGS_MODULE   = $(MODFLAGS)
 AFLAGS_MODULE   = $(MODFLAGS)
@@ -308,7 +309,7 @@
 export	VERSION PATCHLEVEL SUBLEVEL EXTRAVERSION KERNELRELEASE ARCH \
 	CONFIG_SHELL HOSTCC HOSTCFLAGS CROSS_COMPILE AS LD CC \
 	CPP AR NM STRIP OBJCOPY OBJDUMP MAKE AWK GENKSYMS PERL UTS_MACHINE \
-	HOSTCXX HOSTCXXFLAGS LDFLAGS_BLOB LDFLAGS_MODULE CHECK
+	HOSTCXX HOSTCXXFLAGS LDFLAGS_BLOB LDFLAGS_MODULE CHECK CHECKFLAGS
 
 export CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS LDFLAGS
 export CFLAGS CFLAGS_KERNEL CFLAGS_MODULE 
diff -Nru a/arch/alpha/Makefile b/arch/alpha/Makefile
--- a/arch/alpha/Makefile	2004-08-19 01:08:59 +02:00
+++ b/arch/alpha/Makefile	2004-08-19 01:08:59 +02:00
@@ -11,7 +11,7 @@
 NM := $(NM) -B
 
 LDFLAGS_vmlinux	:= -static -N #-relax
-CHECK		:= $(CHECK) -D__alpha__=1
+CHECKFLAGS	+= -D__alpha__=1
 cflags-y	:= -pipe -mno-fp-regs -ffixed-8
 
 # Determine if we can use the BWX instructions with GAS.
diff -Nru a/arch/arm/Makefile b/arch/arm/Makefile
--- a/arch/arm/Makefile	2004-08-19 01:08:59 +02:00
+++ b/arch/arm/Makefile	2004-08-19 01:08:59 +02:00
@@ -58,7 +58,7 @@
 CFLAGS		+=-mapcs-32 $(arch-y) $(tune-y) $(call check_gcc,-malignment-traps,-mshort-load-bytes) -msoft-float -Wa,-mno-fpu -Uarm
 AFLAGS		+=-mapcs-32 $(arch-y) $(tune-y) -msoft-float -Wa,-mno-fpu
 
-CHECK		:= $(CHECK) -D__arm__=1
+CHECKFLAGS	+= -D__arm__=1
 
 #Default value
 DATAADDR	:= .
diff -Nru a/arch/i386/Makefile b/arch/i386/Makefile
--- a/arch/i386/Makefile	2004-08-19 01:08:59 +02:00
+++ b/arch/i386/Makefile	2004-08-19 01:08:59 +02:00
@@ -18,7 +18,7 @@
 LDFLAGS		:= -m elf_i386
 OBJCOPYFLAGS	:= -O binary -R .note -R .comment -S
 LDFLAGS_vmlinux :=
-CHECK		:= $(CHECK) -D__i386__=1
+CHECKFLAGS	+= -D__i386__=1
 
 CFLAGS += -pipe -msoft-float
 
diff -Nru a/arch/m68k/Makefile b/arch/m68k/Makefile
--- a/arch/m68k/Makefile	2004-08-19 01:08:59 +02:00
+++ b/arch/m68k/Makefile	2004-08-19 01:08:59 +02:00
@@ -28,7 +28,7 @@
 LDFLAGS_vmlinux = -N
 endif
 
-CHECK := $(CHECK) -D__mc68000__=1 -I$(shell $(CC) -print-file-name=include)
+CHECKFLAGS += -D__mc68000__=1 -I$(shell $(CC) -print-file-name=include)
 
 # without -fno-strength-reduce the 53c7xx.c driver fails ;-(
 CFLAGS += -pipe -fno-strength-reduce -ffixed-a2
diff -Nru a/arch/ppc/Makefile b/arch/ppc/Makefile
--- a/arch/ppc/Makefile	2004-08-19 01:08:59 +02:00
+++ b/arch/ppc/Makefile	2004-08-19 01:08:59 +02:00
@@ -27,7 +27,7 @@
 		-ffixed-r2 -Wno-uninitialized -mmultiple
 CPP		= $(CC) -E $(CFLAGS)
 
-CHECK		:= $(CHECK) -D__powerpc__=1
+CHECKFLAGS	+= -D__powerpc__=1
 
 ifndef CONFIG_E500
 CFLAGS		+= -mstring
diff -Nru a/arch/ppc64/Makefile b/arch/ppc64/Makefile
--- a/arch/ppc64/Makefile	2004-08-19 01:08:59 +02:00
+++ b/arch/ppc64/Makefile	2004-08-19 01:08:59 +02:00
@@ -22,7 +22,7 @@
 CC		:= $(CC) -m64
 endif
 
-CHECK		:= $(CHECK) -m64 -D__powerpc__=1
+CHECKFLAGS	+= -m64 -D__powerpc__=1
 
 LDFLAGS		:= -m elf64ppc
 LDFLAGS_vmlinux	:= -Bstatic -e $(KERNELLOAD) -Ttext $(KERNELLOAD)
diff -Nru a/arch/sparc/Makefile b/arch/sparc/Makefile
--- a/arch/sparc/Makefile	2004-08-19 01:08:59 +02:00
+++ b/arch/sparc/Makefile	2004-08-19 01:08:59 +02:00
@@ -13,7 +13,7 @@
 
 AS              := $(AS) -32
 LDFLAGS		:= -m elf32_sparc
-CHECK		:= $(CHECK) -D__sparc__=1
+CHECKFLAGS	+= -D__sparc__=1
 
 #CFLAGS := $(CFLAGS) -g -pipe -fcall-used-g5 -fcall-used-g7
 CFLAGS := $(CFLAGS) -m32 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7
diff -Nru a/arch/sparc64/Makefile b/arch/sparc64/Makefile
--- a/arch/sparc64/Makefile	2004-08-19 01:08:59 +02:00
+++ b/arch/sparc64/Makefile	2004-08-19 01:08:59 +02:00
@@ -8,7 +8,7 @@
 # Copyright (C) 1998 Jakub Jelinek (jj@ultra.linux.cz)
 #
 
-CHECK		:= $(CHECK) -D__sparc__=1 -D__sparc_v9__=1
+CHECKFLAGS	+= -D__sparc__=1 -D__sparc_v9__=1
 
 CPPFLAGS_vmlinux.lds += -Usparc
 
diff -Nru a/arch/x86_64/Makefile b/arch/x86_64/Makefile
--- a/arch/x86_64/Makefile	2004-08-19 01:08:59 +02:00
+++ b/arch/x86_64/Makefile	2004-08-19 01:08:59 +02:00
@@ -37,7 +37,7 @@
 OBJCOPYFLAGS	:= -O binary -R .note -R .comment -S
 LDFLAGS_vmlinux := -e stext
 
-CHECK           := $(CHECK) -D__x86_64__=1
+CHECKFLAGS      += -D__x86_64__=1
 
 cflags-$(CONFIG_MK8) += $(call check_gcc,-march=k8,)
 cflags-$(CONFIG_MPSC) += $(call check_gcc,-march=nocona,)
diff -Nru a/scripts/Makefile.build b/scripts/Makefile.build
--- a/scripts/Makefile.build	2004-08-19 01:08:59 +02:00
+++ b/scripts/Makefile.build	2004-08-19 01:08:59 +02:00
@@ -85,10 +85,10 @@
 ifneq ($(KBUILD_CHECKSRC),0)
   ifeq ($(KBUILD_CHECKSRC),2)
     quiet_cmd_force_checksrc = CHECK   $<
-          cmd_force_checksrc = $(CHECK) $(c_flags) $< ;
+          cmd_force_checksrc = $(CHECK) $(CHECKFLAGS) $(c_flags) $< ;
   else
       quiet_cmd_checksrc     = CHECK   $<
-            cmd_checksrc     = $(CHECK) $(c_flags) $< ;
+            cmd_checksrc     = $(CHECK) $(CHECKFLAGS) $(c_flags) $< ;
   endif
 endif
 
