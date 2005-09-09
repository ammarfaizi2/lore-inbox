Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbVIIQOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbVIIQOP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 12:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030206AbVIIQOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 12:14:14 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:15752 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030205AbVIIQOO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 12:14:14 -0400
Date: Fri, 9 Sep 2005 17:14:12 +0100
From: viro@ZenIV.linux.org.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org
Subject: [PATCH] sparse on uml (infrastructure bits)
Message-ID: <20050909161412.GK9623@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Passes -m64 to sparse on uml/amd64, tells sparse to stay out of
USER_OBJS.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC13-git7-stubs/arch/um/Makefile-x86_64 RC13-git7-uml-checker/arch/um/Makefile-x86_64
--- RC13-git7-stubs/arch/um/Makefile-x86_64	2005-09-05 07:05:14.000000000 -0400
+++ RC13-git7-uml-checker/arch/um/Makefile-x86_64	2005-09-07 13:55:09.000000000 -0400
@@ -8,6 +8,7 @@
 #it's needed for headers to work!
 CFLAGS += -U__$(SUBARCH)__ -fno-builtin
 USER_CFLAGS += -fno-builtin
+CHECKFLAGS  += -m64
 
 ELF_ARCH := i386:x86-64
 ELF_FORMAT := elf64-x86-64
diff -urN RC13-git7-stubs/arch/um/scripts/Makefile.rules RC13-git7-uml-checker/arch/um/scripts/Makefile.rules
--- RC13-git7-stubs/arch/um/scripts/Makefile.rules	2005-08-28 23:09:40.000000000 -0400
+++ RC13-git7-uml-checker/arch/um/scripts/Makefile.rules	2005-09-07 13:55:09.000000000 -0400
@@ -9,6 +9,11 @@
 
 $(USER_OBJS) : c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) \
 	$(CFLAGS_$(notdir $@))
+$(USER_OBJS): cmd_checksrc =
+$(USER_OBJS): quiet_cmd_checksrc =
+$(USER_OBJS): cmd_force_checksrc =
+$(USER_OBJS): quiet_cmd_force_checksrc =
+
 
 # The stubs and unmap.o can't try to call mcount or update basic block data
 define unprofile
