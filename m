Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267451AbTANE3T>; Mon, 13 Jan 2003 23:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267452AbTANE3T>; Mon, 13 Jan 2003 23:29:19 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:22744 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S267451AbTANE3P>; Mon, 13 Jan 2003 23:29:15 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH]  Use `--unique=.gnu.linkonce.this_module' linker flag for modules on v850
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030114043757.DE66A3736@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue, 14 Jan 2003 13:37:57 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This prevents the linker from merging the .gnu.linkonce.this_module section
into the .text section, which is necessary for modules to load correctly.

diff -ruN -X../cludes linux-2.5.57-uc0.orig/arch/v850/Makefile linux-2.5.57-uc0/arch/v850/Makefile
--- linux-2.5.57-uc0.orig/arch/v850/Makefile	2002-12-16 12:53:44.000000000 +0900
+++ linux-2.5.57-uc0/arch/v850/Makefile	2003-01-14 11:16:53.000000000 +0900
@@ -1,8 +1,8 @@
 #
 # arch/v850/Makefile
 #
-#  Copyright (C) 2001,02  NEC Corporation
-#  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+#  Copyright (C) 2001,02,03  NEC Corporation
+#  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
 #
 # This file is included by the global makefile so that you can add your own
 # architecture-specific flags and dependencies. Remember to do have actions
@@ -22,6 +22,11 @@
 CFLAGS += -fno-builtin
 CFLAGS += -D__linux__ -DUTS_SYSNAME=\"uClinux\"
 
+# This prevents the linker from consolidating the .gnu.linkonce.this_module
+# section into .text (which the v850 default linker script for -r does for
+# some reason)
+LDFLAGS_MODULE += --unique=.gnu.linkonce.this_module
+
 LDFLAGS_BLOB := -b binary --oformat elf32-little
 OBJCOPY_FLAGS_BLOB := -I binary -O elf32-little -B v850e
 
