Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269399AbUJLAXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269399AbUJLAXX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 20:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269395AbUJLAWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 20:22:44 -0400
Received: from host157-148.pool8289.interbusiness.it ([82.89.148.157]:25731
	"EHLO zion.localdomain") by vger.kernel.org with ESMTP
	id S269399AbUJLATI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 20:19:08 -0400
Subject: [patch 03/10] uml: no extraversion in arch/um/Makefile for mainline
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Tue, 12 Oct 2004 02:17:49 +0200
Message-Id: <20041012001749.C0D03868D@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Extraversion in arch/um/Makefile is not needed in mainline, but just for
separate patches; also, they should set it in the main Makefile, not elsewhere
(Jeff Garzik has just complained). Also remove the dependency from version.h
on arch/um/Makefile: it was added because arch/um/Makefile could change the
kernel version number.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.9-current-paolo/arch/um/Makefile |    9 ---------
 1 files changed, 9 deletions(-)

diff -puN arch/um/Makefile~uml-no-extraversion-in-mainline arch/um/Makefile
--- linux-2.6.9-current/arch/um/Makefile~uml-no-extraversion-in-mainline	2004-10-12 00:39:57.768983440 +0200
+++ linux-2.6.9-current-paolo/arch/um/Makefile	2004-10-12 00:40:11.263931896 +0200
@@ -8,13 +8,6 @@ OS := $(shell uname -s)
 #We require it or things break.
 SHELL := /bin/bash
 
-# Recalculate MODLIB to reflect the EXTRAVERSION changes (via KERNELRELEASE)
-# The way the toplevel Makefile is written EXTRAVERSION is not supposed
-# to be changed outside the toplevel Makefile, but recalculating MODLIB is
-# a sufficient workaround until we no longer need architecture dependent
-# EXTRAVERSION...
-MODLIB := $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
-
 core-y			+= $(ARCH_DIR)/kernel/		 \
 			   $(ARCH_DIR)/drivers/          \
 			   $(ARCH_DIR)/sys-$(SUBARCH)/
@@ -73,8 +66,6 @@ ifeq ($(CONFIG_MODE_SKAS), y)
 $(SYS_HEADERS) : $(TOPDIR)/$(ARCH_DIR)/include/skas_ptregs.h
 endif
 
-include/linux/version.h: arch/$(ARCH)/Makefile
-
 $(ARCH_DIR)/vmlinux.lds.S :
 	touch $@
 
_
