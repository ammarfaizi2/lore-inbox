Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267208AbTBXQCI>; Mon, 24 Feb 2003 11:02:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267206AbTBXQCI>; Mon, 24 Feb 2003 11:02:08 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:8719 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267187AbTBXQCF>;
	Mon, 24 Feb 2003 11:02:05 -0500
Date: Mon, 24 Feb 2003 17:12:17 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: State of sparc32 union
Message-ID: <20030224161217.GA1012@mars.ravnborg.org>
Mail-Followup-To: Pete Zaitcev <zaitcev@redhat.com>,
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20030223202233.A20072@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030223202233.A20072@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  ## 2002/11/13 Incorporate Ravnborg's build cleanups
> -- make clean does not work right - retest

When using Bitkeeper this is trivial.
make mrproper
bk extras -a	=> Will list additional files not supposed to be present


> -- what the hell does "make help" do?

make help just give a brief introduction to available targets, with
default targets marked.
See make help as a help to newcomers and an easy way to see targets
available for the selected platform.

I did a small update:
1) Moved above mentioned helptext to arch/sparc/Makefile
2) Added default target as suggested by kai G.
3) Used more compact notation when calling make recursively
	- This also supress a warning when using make -jn

	Sam

===== arch/sparc/Makefile 1.20 vs edited =====
--- 1.20/arch/sparc/Makefile	Tue Feb 11 12:40:52 2003
+++ edited/arch/sparc/Makefile	Mon Feb 24 17:08:08 2003
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
 
@@ -75,3 +78,8 @@
 CLEAN_FILES +=	include/asm-$(ARCH)/asm_offsets.h.tmp	\
 		include/asm-$(ARCH)/asm_offsets.h	\
 		arch/$(ARCH)/kernel/asm-offsets.s
+
+define archhelp
+  echo  '* image		- kernel image ($(boot)/image)'
+  echo  '  tftpboot.img		- image prepared for tftp'
+endef
===== arch/sparc/boot/Makefile 1.12 vs edited =====
--- 1.12/arch/sparc/boot/Makefile	Tue Feb 11 12:40:52 2003
+++ edited/arch/sparc/boot/Makefile	Mon Feb 24 17:05:32 2003
@@ -32,7 +32,3 @@
 
 $(obj)/btfix.s: $(obj)/btfixupprep vmlinux FORCE
 	$(call if_changed,btfix)
-
-archhelp:
-	@echo '* image		- kernel image ($(obj)/image)'
-	@echo '  tftpboot.img	- image prepared for tftp'
