Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265542AbTGCBSW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 21:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265549AbTGCBSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 21:18:22 -0400
Received: from mail.gmx.de ([213.165.64.20]:28555 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265542AbTGCBSV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 21:18:21 -0400
Date: Thu, 3 Jul 2003 04:36:41 +0300
From: Teemu Tervo <teemu.tervo@gmx.net>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: [PATCH] 2.5.74 - POSIX head & tail
Message-Id: <20030703043641.562fc8ba.teemu.tervo@gmx.net>
X-Mailer: Sylpheed version 0.8.6claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Despite being widely used, the 'head/tail -N' syntax isn't POSIX
compliant. This changes it to 'head/tail -n N'.

-Teemu

diff -Naur linux-2.5.74.orig/arch/mips/ramdisk/Makefile linux-2.5.74/arch/mips/ramdisk/Makefile
--- linux-2.5.74.orig/arch/mips/ramdisk/Makefile	Thu Jul  3 03:25:01 2003
+++ linux-2.5.74/arch/mips/ramdisk/Makefile	Thu Jul  3 03:28:34 2003
@@ -2,7 +2,7 @@
 # Makefile for a ramdisk image
 #
 
-O_FORMAT = $(shell $(OBJDUMP) -i | head -2 | grep elf32)
+O_FORMAT = $(shell $(OBJDUMP) -i | head -n 2 | grep elf32)
 img = $(CONFIG_EMBEDDED_RAMDISK_IMAGE)
 ramdisk.o: $(subst ",,$(img)) ld.script
 	echo "O_FORMAT:  " $(O_FORMAT)
diff -Naur linux-2.5.74.orig/arch/ppc64/boot/Makefile linux-2.5.74/arch/ppc64/boot/Makefile
--- linux-2.5.74.orig/arch/ppc64/boot/Makefile	Thu Jul  3 03:25:18 2003
+++ linux-2.5.74/arch/ppc64/boot/Makefile	Thu Jul  3 03:27:50 2003
@@ -118,7 +118,7 @@
 	ls -l vmlinux | \
 	awk '{printf "/* generated -- do not edit! */\n" \
 		"unsigned long vmlinux_filesize = %d;\n", $$5}' > $(obj)/imagesize.c
-	$(CROSS_COMPILE)nm -n vmlinux | tail -1 | \
+	$(CROSS_COMPILE)nm -n vmlinux | tail -n 1 | \
 	awk '{printf "unsigned long vmlinux_memsize = 0x%s;\n", substr($$1,8)}' \
 		>> $(obj)/imagesize.c
 
diff -Naur linux-2.5.74.orig/scripts/mkcompile_h linux-2.5.74/scripts/mkcompile_h
--- linux-2.5.74.orig/scripts/mkcompile_h	Thu Jul  3 03:27:06 2003
+++ linux-2.5.74/scripts/mkcompile_h	Thu Jul  3 03:27:50 2003
@@ -54,7 +54,7 @@
     echo \#define LINUX_COMPILE_DOMAIN
   fi
 
-  echo \#define LINUX_COMPILER \"`$CC -v 2>&1 | tail -1`\"
+  echo \#define LINUX_COMPILER \"`$CC -v 2>&1 | tail -n 1`\"
 ) > .tmpcompile
 
 # Only replace the real compile.h if the new one is different,
diff -Naur linux-2.5.74.orig/scripts/ver_linux linux-2.5.74/scripts/ver_linux
--- linux-2.5.74.orig/scripts/ver_linux	Thu Jul  3 03:27:06 2003
+++ linux-2.5.74/scripts/ver_linux	Thu Jul  3 03:27:50 2003
@@ -55,7 +55,7 @@
 -e 's/\.so$//' | awk -F'[.-]'   '{print "Linux C Library        " \
 $(NF-2)"."$(NF-1)"."$NF}'
 
-ldd -v > /dev/null 2>&1 && ldd -v || ldd --version |head -1 | awk \
+ldd -v > /dev/null 2>&1 && ldd -v || ldd --version |head -n 1 | awk \
 'NR==1{print "Dynamic linker (ldd)  ", $NF}'
 
 ls -l /usr/lib/lib{g,stdc}++.so  2>/dev/null | awk -F. \
