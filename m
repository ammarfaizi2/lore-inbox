Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbTERMwn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 08:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbTERMwn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 08:52:43 -0400
Received: from ns.suse.de ([213.95.15.193]:38411 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262034AbTERMwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 08:52:41 -0400
Date: Sun, 18 May 2003 12:47:18 +0200
From: Olaf Hering <olh@suse.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       David Engebretsen <engebret@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.21-rc2 syntax error in toplevel Makefile
Message-ID: <20030518104718.GA9425@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The used syntax is obsolete since a while.
Update two places to the correct syntax.

Please apply for 2.4.21.


nectarine:/ # tail -1
tail: `-1' option is obsolete; use `-n 1'
Try `tail --help' for more information.
nectarine:/ # tail --version
tail (coreutils) 5.0
Written by Paul Rubin, David MacKenzie, Ian Lance Taylor, and Jim Meyering.

Copyright (C) 2003 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.


diff -purN linux-2.4.21-rc2/Makefile linux-2.4.21-rc2.tail/Makefile
--- linux-2.4.21-rc2/Makefile	2003-05-18 12:39:41.000000000 +0200
+++ linux-2.4.21-rc2.tail/Makefile	2003-05-18 12:37:05.000000000 +0200
@@ -342,7 +342,7 @@ include/linux/compile.h: $(CONFIGURATION
 	 ([ -x /bin/domainname ] && /bin/domainname > .ver1) || \
 	 echo > .ver1
 	@echo \#define LINUX_COMPILE_DOMAIN \"`cat .ver1 | $(uts_truncate)`\" >> .ver
-	@echo \#define LINUX_COMPILER \"`$(CC) $(CFLAGS) -v 2>&1 | tail -1`\" >> .ver
+	@echo \#define LINUX_COMPILER \"`$(CC) $(CFLAGS) -v 2>&1 | tail -n 1`\" >> .ver
 	@mv -f .ver $@
 	@rm -f .ver1
 
diff -purN linux-2.4.21-rc2/arch/ppc64/boot/Makefile linux-2.4.21-rc2.tail/arch/ppc64/boot/Makefile
--- linux-2.4.21-rc2/arch/ppc64/boot/Makefile	2003-05-18 12:39:42.000000000 +0200
+++ linux-2.4.21-rc2.tail/arch/ppc64/boot/Makefile	2003-05-18 12:37:46.000000000 +0200
@@ -90,7 +90,7 @@ addnote: addnote.c
 
 imagesize.c: $(TOPDIR)/vmlinux
 	ls -l $(TOPDIR)/vmlinux | awk '{printf "/* generated -- do not edit! */\nunsigned long vmlinux_filesize = %d;\n", $$5}' > imagesize.c
-	$(CROSS_COMPILE)nm -n $(TOPDIR)/vmlinux | tail -1 | awk '{printf "unsigned long vmlinux_memsize = 0x%s;\n", substr($$1,8)}' >> imagesize.c
+	$(CROSS_COMPILE)nm -n $(TOPDIR)/vmlinux | awk '{i=$$1}END{printf "unsigned long vmlinux_memsize = 0x%s;\n", substr(i,8)}' >> imagesize.c
 
 zImage.o: $(TOPDIR)/vmlinux
 
-- 
USB is for mice, FireWire is for men!
