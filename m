Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263330AbSJTR7h>; Sun, 20 Oct 2002 13:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263333AbSJTR7h>; Sun, 20 Oct 2002 13:59:37 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:22966 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S263330AbSJTR7g>;
	Sun, 20 Oct 2002 13:59:36 -0400
Date: Sun, 20 Oct 2002 20:01:54 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200210201801.UAA22227@harpo.it.uu.se>
To: kai@tp1.ruhr-uni-bochum.de
Subject: [PATCH] 2.5.44 mrproper removes editor backup files
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Contrary to years of history and several explicit comments in
Makefile that mrproper != distclean, 2.5.44 merged the two
which causes mrproper to incorrectly remove editor backup files.
Suggested fix below -- works for me.

/Mikael

--- linux-2.5.44/Makefile.~1~	2002-10-20 18:51:07.000000000 +0200
+++ linux-2.5.44/Makefile	2002-10-20 19:36:20.000000000 +0200
@@ -712,7 +712,11 @@
 #
 quiet_cmd_mrproper = RM  $$(MRPROPER_DIRS) + $$(MRPROPER_FILES)
 cmd_mrproper = rm -rf $(MRPROPER_DIRS) && rm -f $(MRPROPER_FILES)
-mrproper distclean: clean archmrproper
+mrproper: clean archmrproper
+	@echo '  Making $@ in the srctree'
+	$(call cmd,mrproper)
+
+distclean: mrproper
 	@echo '  Making $@ in the srctree'
 	@find . $(RCS_FIND_IGNORE) \
 	 	\( -name '*.orig' -o -name '*.rej' -o -name '*~' \
@@ -720,7 +724,6 @@
 	 	-o -name '.*.rej' -o -size 0 \
 		-o -name '*%' -o -name '.*.cmd' -o -name 'core' \) \
 		-type f -print | xargs rm -f
-	$(call cmd,mrproper)
 
 # Generate tags for editors
 # ---------------------------------------------------------------------------
