Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268382AbUHQSY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268382AbUHQSY6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 14:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268383AbUHQSY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 14:24:58 -0400
Received: from [12.177.129.25] ([12.177.129.25]:35523 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S268382AbUHQSYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 14:24:55 -0400
Message-Id: <200408171926.i7HJQ6KF003372@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Andrew Morton <akpm@osdl.org>
Cc: Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.8.1-mm1 - Clean up a Makefile bogosity
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 17 Aug 2004 15:26:06 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following a suggestion from Andreas Schwab, this switches the UML build to
a somewhat official way of getting a library search path from gcc.

				Jeff

Index: 2.6.8.1-mm1/arch/um/Makefile
===================================================================
--- 2.6.8.1-mm1.orig/arch/um/Makefile	2004-08-17 00:37:04.000000000 -0400
+++ 2.6.8.1-mm1/arch/um/Makefile	2004-08-17 13:18:13.000000000 -0400
@@ -88,10 +88,11 @@
 
 prepare: $(ARCH_SYMLINKS) $(SYS_HEADERS) $(GEN_HEADERS)
 
-# This stupidity extracts the directory in which gcc lives so that it can
-# be fed to ld when it's linking .tmp_vmlinux during the ldchk stage.
-LD_DIR = $(shell dirname `gcc -v 2>&1 | head -1 | awk '{print $$NF}'`)
-LDFLAGS_vmlinux = -L/usr/lib -L$(LD_DIR) -r
+# This extracts the library path from gcc with -print-search-dirs and munges
+# the output into a bunch of -L switches.
+LD_DIRS = $(shell gcc -print-search-dirs | grep libraries | \
+	sed -e 's/^.*=/-L/' -e 's/:/ -L/g')
+LDFLAGS_vmlinux = $(LD_DIRS) -r
 
 vmlinux: $(ARCH_DIR)/main.o 
 

