Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbWAUSIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbWAUSIS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 13:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbWAUSIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 13:08:18 -0500
Received: from cantor2.suse.de ([195.135.220.15]:46310 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932219AbWAUSIR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 13:08:17 -0500
Date: Sat, 21 Jan 2006 19:08:05 +0100
From: Olaf Hering <olh@suse.de>
To: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: cc-version not available to change EXTRA_CFLAGS
Message-ID: <20060121180805.GA15761@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I want to add a gcc version check for reiserfs, on akpms request.
This one doesnt work with 2.6.16rc1, havent checked if it ever worked.


 make -kj14 O=../O-powerpc-ppc64-defconfig arch/powerpc/mm/mem.o
  GEN    /home/olaf/kernel/olh/ppc64/O-powerpc-ppc64-defconfig/Makefile
scripts/kconfig/conf -s arch/powerpc/Kconfig
arch/powerpc/platforms/83xx/Kconfig:10:warning: 'select' used by config symbol 'MPC834x_SYS' refer to undefined symbol 'DEFAULT_UIMAGE'
#
# using defaults found in .config
#
make[3]: `.kernelrelease' is up to date.
  SPLIT   include/linux/autoconf.h -> include/config/*
+ '[' -lt 0400 ']'
/bin/sh: line 1: [: -lt: unary operator expected
make[2]: `arch/powerpc/mm/mem.o' is up to date.
olaf@pomegranate:~/kernel/olh/ppc64/linux-2.6.16-rc1-olh> quilt diff
Index: linux-2.6.16-rc1-olh/arch/powerpc/mm/Makefile
===================================================================
--- linux-2.6.16-rc1-olh.orig/arch/powerpc/mm/Makefile
+++ linux-2.6.16-rc1-olh/arch/powerpc/mm/Makefile
@@ -5,6 +5,7 @@
 ifeq ($(CONFIG_PPC64),y)
 EXTRA_CFLAGS   += -mno-minimal-toc
 endif
+GCC_BROKEN_VEC := $(shell set -x ; if [ $(call cc-version) -lt 0400 ] ; then echo "y"; fi)

 obj-y                          := fault.o mem.o lmb.o
 obj-$(CONFIG_PPC32)            += init_32.o pgtable_32.o mmu_context_32.o
Index: linux-2.6.16-rc1-olh/fs/reiserfs/Makefile
===================================================================
--- linux-2.6.16-rc1-olh.orig/fs/reiserfs/Makefile
+++ linux-2.6.16-rc1-olh/fs/reiserfs/Makefile
@@ -28,7 +28,7 @@ endif
 # will work around it. If any other architecture displays this behavior,
 # add it here.
 ifeq ($(CONFIG_PPC32),y)
-EXTRA_CFLAGS := -O1
+EXTRA_CFLAGS := $(shell set -x ; if [ $(call cc-version) -lt 0402 ] ; then echo $(call cc-option,-O1); fi ;)
 endif

 TAGS:



-- 
short story of a lazy sysadmin:
 alias appserv=wotan
