Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbUBYUB3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 15:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261398AbUBYUB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 15:01:29 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:12838 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261282AbUBYUB1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 15:01:27 -0500
Date: Wed, 25 Feb 2004 22:03:05 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: add defconfig targets to make help
Message-ID: <20040225210305.GA6445@mars.ravnborg.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus & Andrew - please apply.

List all entries in arch/$(ARCH)/configs/*_defconfig when
doing 'make help'.

Results in output like this (ppc64 as example):

  g5_defconfig             - Build for g5
  pSeries_defconfig        - Build for pSeries

The implementation is generic and enables this for all users of _defconfig.

	Sam

===== Makefile 1.456 vs edited =====
--- 1.456/Makefile	Sun Feb 15 03:42:40 2004
+++ edited/Makefile	Wed Feb 25 21:57:52 2004
@@ -889,6 +889,9 @@
 # Brief documentation of the typical targets used
 # ---------------------------------------------------------------------------
 
+boards := $(wildcard $(srctree)/arch/$(ARCH)/configs/*_defconfig)
+boards := $(notdir $(boards))
+
 help:
 	@echo  'Cleaning targets:'
 	@echo  '  clean		  - remove most generated files but keep the config'
@@ -914,6 +917,11 @@
 	@$(if $(archhelp),$(archhelp),\
 		echo '  No architecture specific help defined for $(ARCH)')
 	@echo  ''
+	@$(if $(boards), \
+		$(foreach b, $(boards), \
+		printf "  %-24s - Build for %s\\n" $(b) $(subst _defconfig,,$(b));) \
+		echo '')
+	
 	@echo  '  make V=0|1 [targets] 0 => quiet build (default), 1 => verbose build'
 	@echo  '  make O=dir [targets] Locate all output files in "dir", including .config'
 	@echo  '  make C=1   [targets] Check all c source with checker tool'
