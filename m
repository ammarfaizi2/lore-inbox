Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261860AbSJQIZM>; Thu, 17 Oct 2002 04:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261863AbSJQIZM>; Thu, 17 Oct 2002 04:25:12 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:53510 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S261860AbSJQIZJ>; Thu, 17 Oct 2002 04:25:09 -0400
Date: Thu, 17 Oct 2002 10:31:02 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: davem@redhat.com
Cc: sparclinux@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: [2.5 sparc32] trivial: fix up check_asm
Message-ID: <20021017083102.GA20917@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The attached patch fixes up sparc32's lunatic check_asm in 2.5:

T.


diff -urN linux-2.5.43/arch/sparc/kernel/Makefile linux-2.5.43.1/arch/sparc/kernel/Makefile
--- linux-2.5.43/arch/sparc/kernel/Makefile	2002-09-28 10:11:16.000000000 +0200
+++ linux-2.5.43.1/arch/sparc/kernel/Makefile	2002-10-17 10:19:25.000000000 +0200
@@ -29,7 +29,7 @@
 
 include $(TOPDIR)/Rules.make
 
-HPATH := $(objtree)/include
+HPATH := $(TOPDIR)/include
 
 check_asm: FORCE
 	@if [ ! -r $(HPATH)/asm/asm_offsets.h ] ; then \
@@ -46,7 +46,7 @@
 	@echo "#include <linux/config.h>" > tmp.c
 	@echo "#undef CONFIG_SMP" >> tmp.c
 	@echo "#include <linux/sched.h>" >> tmp.c
-	$(CPP) $(CPPFLAGS) tmp.c -o tmp.i
+	$(CC) $(CFLAGS) -E tmp.c -o tmp.i
 	@echo "/* Automatically generated. Do not edit. */" > check_asm_data.c
 	@echo "#include <linux/config.h>" >> check_asm_data.c
 	@echo "#undef CONFIG_SMP" >> check_asm_data.c
@@ -79,7 +79,7 @@
 	@echo "#undef CONFIG_SMP" >> tmp.c
 	@echo "#define CONFIG_SMP 1" >> tmp.c
 	@echo "#include <linux/sched.h>" >> tmp.c
-	$(CPP) $(CPPFLAGS) tmp.c -o tmp.i
+	$(CC) $(CFLAGS) -E tmp.c -o tmp.i
 	@echo "/* Automatically generated. Do not edit. */" > check_asm_data.c
 	@echo "#include <linux/config.h>" >> check_asm_data.c
 	@echo "#undef CONFIG_SMP" >> check_asm_data.c
