Return-Path: <linux-kernel-owner+w=401wt.eu-S1752000AbWLXOqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbWLXOqS (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 09:46:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752028AbWLXOqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 09:46:17 -0500
Received: from aun.it.uu.se ([130.238.12.36]:52813 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752000AbWLXOqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 09:46:17 -0500
Date: Sun, 24 Dec 2006 15:45:12 +0100 (MET)
Message-Id: <200612241445.kBOEjC47021011@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: sam@ravnborg.org
Subject: [PATCH 2.6.20-rc2] fix mrproper incompleteness
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

include/linux/utsrelease.h and include/linux/version.h
aren't removed any more by mrproper in kernel 2.6.20-rc2.
The patch below fixes this.

The definition of MRPROPER_FILES looks weird: generated-headers
looks like a misspelling of generated_headers, but that one is
a Makefile target, not a variable or a file, so I don't see how
including it in MRPROPER_FILES could have any effect.

Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

--- linux-2.6.20-rc2/Makefile.~1~	2006-12-24 14:04:26.000000000 +0100
+++ linux-2.6.20-rc2/Makefile	2006-12-24 15:31:41.000000000 +0100
@@ -1040,7 +1040,7 @@ CLEAN_FILES +=	vmlinux System.map \
 # Directories & files removed with 'make mrproper'
 MRPROPER_DIRS  += include/config include2 usr/include
 MRPROPER_FILES += .config .config.old include/asm .version .old_version \
-                  include/linux/autoconf.h generated-headers		\
+                  include/linux/autoconf.h include/linux/utsrelease.h include/linux/version.h \
 		  Module.symvers tags TAGS cscope*
 
 # clean - Delete most, but leave enough to build external modules
