Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272796AbTHKVL6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 17:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273028AbTHKVL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 17:11:58 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:41467 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S272796AbTHKVL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 17:11:56 -0400
Date: Mon, 11 Aug 2003 23:11:45 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] add an -Os config option
Message-ID: <20030811211145.GA569@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below adds an option OPTIMIZE_FOR_SIZE (depending on EMBEDDED) 
that changes the optimization from -O2 to -Os.

cu
Adrian

--- linux-2.6.0-test3/init/Kconfig.old	2003-08-11 01:33:31.000000000 +0200
+++ linux-2.6.0-test3/init/Kconfig	2003-08-11 01:46:48.000000000 +0200
@@ -118,6 +118,17 @@
 	  a "non-standard" kernel.  Only use this if you really know what you
 	  are doing.
 
+config OPTIMIZE_FOR_SIZE
+	bool "Optimize for size" if EMBEDDED
+	default n
+	help
+	  Enabling this option will pass "-Os" instead of "-O2" to gcc
+	  resulting in a smaller kernel.
+
+	  The resulting kernel might be significantly slower.
+
+	  If unsure, say N.
+
 config KALLSYMS
 	 bool "Load all symbols for debugging/kksymoops" if EMBEDDED
 	 default y
--- linux-2.6.0-test3/Makefile.old	2003-08-11 01:34:41.000000000 +0200
+++ linux-2.6.0-test3/Makefile	2003-08-11 01:37:16.000000000 +0200
@@ -223,7 +223,7 @@
 NOSTDINC_FLAGS  = -nostdinc -iwithprefix include
 
 CPPFLAGS	:= -D__KERNEL__ -Iinclude
-CFLAGS 		:= -Wall -Wstrict-prototypes -Wno-trigraphs -O2 \
+CFLAGS 		:= -Wall -Wstrict-prototypes -Wno-trigraphs \
 	  	   -fno-strict-aliasing -fno-common
 AFLAGS		:= -D__ASSEMBLY__
 
@@ -318,6 +318,12 @@
 
 -include .config.cmd
 
+ifdef CONFIG_OPTIMIZE_FOR_SIZE
+CFLAGS		+= -Os
+else
+CFLAGS		+= -O2
+endif
+
 ifndef CONFIG_FRAME_POINTER
 CFLAGS		+= -fomit-frame-pointer
 endif
