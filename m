Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261845AbTCaUzW>; Mon, 31 Mar 2003 15:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261848AbTCaUzW>; Mon, 31 Mar 2003 15:55:22 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:46838 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261845AbTCaUzL>; Mon, 31 Mar 2003 15:55:11 -0500
Date: Mon, 31 Mar 2003 16:06:33 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [sparc] Default target
Message-ID: <20030331160633.B5930@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Apparently, Sam changed his mind about the "makeboot", too.
In 2.5.66, only s390, sparc64, and ppc64 still have it.

diff -urN -X dontdiff linux-2.5.66/arch/sparc/boot/Makefile linux-2.5.66-sparc/arch/sparc/boot/Makefile
--- linux-2.5.66/arch/sparc/boot/Makefile	2003-03-24 14:01:25.000000000 -0800
+++ linux-2.5.66-sparc/arch/sparc/boot/Makefile	2003-03-29 23:23:30.000000000 -0800
@@ -32,7 +32,3 @@
 
 $(obj)/btfix.s: $(obj)/btfixupprep vmlinux FORCE
 	$(call if_changed,btfix)
-
-archhelp:
-	@echo '* image		- kernel image ($(obj)/image)'
-	@echo '  tftpboot.img	- image prepared for tftp'
diff -urN -X dontdiff linux-2.5.66/arch/sparc/Makefile linux-2.5.66-sparc/arch/sparc/Makefile
--- linux-2.5.66/arch/sparc/Makefile	2003-03-24 14:00:03.000000000 -0800
+++ linux-2.5.66-sparc/arch/sparc/Makefile	2003-03-29 23:23:31.000000000 -0800
@@ -54,13 +54,16 @@
 LIBS_Y		:= $(patsubst %/, %/lib.a, $(libs-y))
 export INIT_Y CORE_Y DRIVERS_Y NET_Y LIBS_Y HEAD_Y
 
-makeboot =$(Q)$(MAKE) -f scripts/Makefile.build obj=arch/$(ARCH)/boot $(1)
+# Default target
+all: image
+
+boot := arch/sparc/boot
 
 image tftpboot.img: vmlinux
-	$(call makeboot,arch/sparc/boot/$@)
+	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
 archclean:
-	$(Q)$(MAKE) -f scripts/Makefile.clean obj=arch/$(ARCH)/boot
+	$(Q)$(MAKE) $(clean)=$(boot)
 
 prepare: include/asm-$(ARCH)/asm_offsets.h
 
@@ -72,3 +75,9 @@
 
 CLEAN_FILES +=	include/asm-$(ARCH)/asm_offsets.h	\
 		arch/$(ARCH)/kernel/asm-offsets.s
+
+# Don't use tabs in echo arguments.
+define archhelp
+  echo  '* image        - kernel image ($(boot)/image)'
+  echo  '  tftpboot.img - image prepared for tftp'
+endef
