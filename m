Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932540AbWAJUA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbWAJUA3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 15:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932544AbWAJUA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 15:00:29 -0500
Received: from neapel230.server4you.de ([217.172.187.230]:9170 "EHLO
	neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S932540AbWAJUA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 15:00:28 -0500
Date: Tue, 10 Jan 2006 21:00:16 +0100
From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix running 'make kernelrelease' before builing
Message-ID: <20060110200016.GA13461@lsrfire.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

after your latest Makefile changes 'make kernelrelease' displays an
empty line when it is run before building.  I think it's more useful
to let it build the kernel version and display it.

The patch makes kernelrelease dependant on .kernelrelease.  It also
moves one echo call to the single other place that depends on
.kernelrelease.  Otherwise it would display its message there _and_
when called through 'make kernelrelease'.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

diff --git a/Makefile b/Makefile
index deedaf7..403eee0 100644
--- a/Makefile
+++ b/Makefile
@@ -788,7 +788,6 @@ kernelrelease = \
 .kernelrelease: FORCE
 	$(Q)rm -f .kernelrelease
 	$(Q)echo $(kernelrelease) > .kernelrelease
-	$(Q)echo "  Building kernel $(kernelrelease)"
 
 
 # Things we need to do before we recursively start building the kernel
@@ -808,6 +807,7 @@ kernelrelease = \
 # 1) Check that make has not been executed in the kernel src $(srctree)
 # 2) Create the include2 directory, used for the second asm symlink
 prepare3: .kernelrelease
+	$(Q)echo "  Building kernel $(KERNELRELEASE)"
 ifneq ($(KBUILD_SRC),)
 	@echo '  Using $(srctree) as source for kernel'
 	$(Q)if [ -f $(srctree)/.config ]; then \
@@ -1300,7 +1300,7 @@ checkstack:
 	$(OBJDUMP) -d vmlinux $$(find . -name '*.ko') | \
 	$(PERL) $(src)/scripts/checkstack.pl $(ARCH)
 
-kernelrelease:
+kernelrelease: .kernelrelease
 	@echo $(KERNELRELEASE)
 kernelversion:
 	@echo $(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
