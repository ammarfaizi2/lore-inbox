Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262439AbTGKQSv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 12:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbTGKQSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 12:18:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:24962 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262439AbTGKQSt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 12:18:49 -0400
Date: Fri, 11 Jul 2003 19:37:38 +0300
From: Teemu Tervo <teemu.tervo@gmx.net>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: [PATCH] 2.5.75 (repost) Fix head/tail -num
Message-Id: <20030711193738.5331f3c0.teemu.tervo@gmx.net>
X-Mailer: Sylpheed version 0.8.6claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following changes the incorrect head/tail -NUM syntax to the posix
compliant 'head/tail -n NUM'.

- Teemu

diff -Naur linux-2.5.75.orig/arch/ppc64/boot/Makefile linux-2.5.75/arch/ppc64/boot/Makefile
--- linux-2.5.75.orig/arch/ppc64/boot/Makefile	Fri Jul 11 09:27:15 2003
+++ linux-2.5.75/arch/ppc64/boot/Makefile	Fri Jul 11 09:33:21 2003
@@ -118,7 +118,7 @@
 	ls -l vmlinux | \
 	awk '{printf "/* generated -- do not edit! */\n" \
 		"unsigned long vmlinux_filesize = %d;\n", $$5}' > $(obj)/imagesize.c
-	$(CROSS_COMPILE)nm -n vmlinux | tail -1 | \
+	$(CROSS_COMPILE)nm -n vmlinux | tail -n 1 | \
 	awk '{printf "unsigned long vmlinux_memsize = 0x%s;\n", substr($$1,8)}' \
 		>> $(obj)/imagesize.c
 
diff -Naur linux-2.5.75.orig/scripts/mkcompile_h linux-2.5.75/scripts/mkcompile_h
--- linux-2.5.75.orig/scripts/mkcompile_h	Fri Jul 11 09:29:09 2003
+++ linux-2.5.75/scripts/mkcompile_h	Fri Jul 11 09:33:21 2003
@@ -54,7 +54,7 @@
     echo \#define LINUX_COMPILE_DOMAIN
   fi
 
-  echo \#define LINUX_COMPILER \"`$CC -v 2>&1 | tail -1`\"
+  echo \#define LINUX_COMPILER \"`$CC -v 2>&1 | tail -n 1`\"
 ) > .tmpcompile
 
 # Only replace the real compile.h if the new one is different,
diff -Naur linux-2.5.75.orig/scripts/ver_linux linux-2.5.75/scripts/ver_linux
--- linux-2.5.75.orig/scripts/ver_linux	Fri Jul 11 09:29:09 2003
+++ linux-2.5.75/scripts/ver_linux	Fri Jul 11 09:33:21 2003
@@ -58,7 +58,7 @@
 -e 's/\.so$//' | awk -F'[.-]'   '{print "Linux C Library        " \
 $(NF-2)"."$(NF-1)"."$NF}'
 
-ldd -v > /dev/null 2>&1 && ldd -v || ldd --version |head -1 | awk \
+ldd -v > /dev/null 2>&1 && ldd -v || ldd --version |head -n 1 | awk \
 'NR==1{print "Dynamic linker (ldd)  ", $NF}'
 
 ls -l /usr/lib/lib{g,stdc}++.so  2>/dev/null | awk -F. \
