Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266924AbTGOJHJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 05:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266985AbTGOJHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 05:07:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:18134 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266924AbTGOJGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 05:06:55 -0400
Date: Tue, 15 Jul 2003 12:25:56 +0300
From: Teemu Tervo <teemu.tervo@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.0-test1 - Fix head & tail syntax
Message-Id: <20030715122556.46de7334.teemu.tervo@gmx.net>
X-Mailer: Sylpheed version 0.8.6claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Once again, fix 'head/tail -NUM' to posix compliant 'head/tail -n NUM'.

- Teemu

diff -Naur linux-2.6.0-test1.orig/arch/mips/ramdisk/Makefile linux-2.6.0-test1/arch/mips/ramdisk/Makefile
--- linux-2.6.0-test1.orig/arch/mips/ramdisk/Makefile	Tue Jul 15 12:02:55 2003
+++ linux-2.6.0-test1/arch/mips/ramdisk/Makefile	Tue Jul 15 12:16:03 2003
@@ -2,7 +2,7 @@
 # Makefile for a ramdisk image
 #
 
-O_FORMAT = $(shell $(OBJDUMP) -i | head -2 | grep elf32)
+O_FORMAT = $(shell $(OBJDUMP) -i | head -n 2 | grep elf32)
 img = $(CONFIG_EMBEDDED_RAMDISK_IMAGE)
 ramdisk.o: $(subst ",,$(img)) ld.script
 	echo "O_FORMAT:  " $(O_FORMAT)
diff -Naur linux-2.6.0-test1.orig/arch/ppc64/boot/Makefile linux-2.6.0-test1/arch/ppc64/boot/Makefile
--- linux-2.6.0-test1.orig/arch/ppc64/boot/Makefile	Tue Jul 15 12:03:27 2003
+++ linux-2.6.0-test1/arch/ppc64/boot/Makefile	Tue Jul 15 12:06:34 2003
@@ -118,7 +118,7 @@
 	ls -l vmlinux | \
 	awk '{printf "/* generated -- do not edit! */\n" \
 		"unsigned long vmlinux_filesize = %d;\n", $$5}' > $(obj)/imagesize.c
-	$(CROSS_COMPILE)nm -n vmlinux | tail -1 | \
+	$(CROSS_COMPILE)nm -n vmlinux | tail -n 1 | \
 	awk '{printf "unsigned long vmlinux_memsize = 0x%s;\n", substr($$1,8)}' \
 		>> $(obj)/imagesize.c
 
diff -Naur linux-2.6.0-test1.orig/scripts/mkcompile_h linux-2.6.0-test1/scripts/mkcompile_h
--- linux-2.6.0-test1.orig/scripts/mkcompile_h	Tue Jul 15 12:06:00 2003
+++ linux-2.6.0-test1/scripts/mkcompile_h	Tue Jul 15 12:06:34 2003
@@ -54,7 +54,7 @@
     echo \#define LINUX_COMPILE_DOMAIN
   fi
 
-  echo \#define LINUX_COMPILER \"`$CC -v 2>&1 | tail -1`\"
+  echo \#define LINUX_COMPILER \"`$CC -v 2>&1 | tail -n 1`\"
 ) > .tmpcompile
 
 # Only replace the real compile.h if the new one is different,
diff -Naur linux-2.6.0-test1.orig/scripts/ver_linux linux-2.6.0-test1/scripts/ver_linux
--- linux-2.6.0-test1.orig/scripts/ver_linux	Tue Jul 15 12:06:00 2003
+++ linux-2.6.0-test1/scripts/ver_linux	Tue Jul 15 12:06:34 2003
@@ -58,7 +58,7 @@
 -e 's/\.so$//' | awk -F'[.-]'   '{print "Linux C Library        " \
 $(NF-2)"."$(NF-1)"."$NF}'
 
-ldd -v > /dev/null 2>&1 && ldd -v || ldd --version |head -1 | awk \
+ldd -v > /dev/null 2>&1 && ldd -v || ldd --version |head -n 1 | awk \
 'NR==1{print "Dynamic linker (ldd)  ", $NF}'
 
 ls -l /usr/lib/lib{g,stdc}++.so  2>/dev/null | awk -F. \
