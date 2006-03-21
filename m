Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751203AbWCUQeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbWCUQeY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1160995AbWCUQaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:30:19 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:28684 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030335AbWCUQVN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:21:13 -0500
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 45/46] kbuild: fix make help & make *pkg
In-Reply-To: <11429580573947-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email
Date: Tue, 21 Mar 2006 17:20:57 +0100
Message-Id: <11429580571883-git-send-email-sam@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: lkml <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FORCE was not defined => error.
Use kbuild infrastructure to call down to the relevant
Makefile. This enables us to use the FORCE definition from kbuild.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 Makefile |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

6c2133e11b422b7379b5a660c639f7d53d18ca3b
diff --git a/Makefile b/Makefile
index 3dbaac6..0c223df 100644
--- a/Makefile
+++ b/Makefile
@@ -994,9 +994,9 @@ distclean: mrproper
 package-dir	:= $(srctree)/scripts/package
 
 %pkg: FORCE
-	$(Q)$(MAKE) -f $(package-dir)/Makefile $@
+	$(Q)$(MAKE) $(build)=$(package-dir) $@
 rpm: FORCE
-	$(Q)$(MAKE) -f $(package-dir)/Makefile $@
+	$(Q)$(MAKE) $(build)=$(package-dir) $@
 
 
 # Brief documentation of the typical targets used
@@ -1034,7 +1034,7 @@ help:
 	@echo  '  namespacecheck  - Name space analysis on compiled kernel'
 	@echo  ''
 	@echo  'Kernel packaging:'
-	@$(MAKE) -f $(package-dir)/Makefile help
+	@$(MAKE) $(build)=$(package-dir) help
 	@echo  ''
 	@echo  'Documentation targets:'
 	@$(MAKE) -f $(srctree)/Documentation/DocBook/Makefile dochelp
-- 
1.0.GIT


