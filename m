Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263851AbUHGRxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263851AbUHGRxG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 13:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263875AbUHGRxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 13:53:06 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:48138 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S263851AbUHGRxD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 13:53:03 -0400
Date: Sat, 7 Aug 2004 19:54:48 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] kbuild: Remove LANG preset in top-level Makefile
Message-ID: <20040807175448.GA20456@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please apply before 2.6.8 final!

In the top-level Makefile a number of locale related
environment variables were preset to give a small
speed up when building the kernel.
Unfortunately this had the bad sideeffect that the
variable CFLAGS_vmlinux.lds.o lost the exported vaule in
some setups (obviously not mine).
This smells like a make issue - but the best solution is simply
to drop presetting the locale related variables.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

===== Makefile 1.509 vs edited =====
--- 1.509/Makefile	2004-08-03 23:11:35 +02:00
+++ edited/Makefile	2004-08-07 19:44:40 +02:00
@@ -619,12 +619,7 @@
 
 .PHONY: $(vmlinux-dirs)
 $(vmlinux-dirs): prepare-all scripts
-	$(Q)if [ ! -z $$LC_ALL ]; then          \
-		export LANG=$$LC_ALL;           \
-		export LC_ALL= ;                \
-	fi;                                     \
-	export LC_COLLATE=C; export LC_CTYPE=C; \
-	$(MAKE) $(build)=$@
+	$(Q)$(MAKE) $(build)=$@
 
 # Things we need to do before we recursively start building the kernel
 # or the modules are listed in "prepare-all".
