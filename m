Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751278AbWIXWQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWIXWQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 18:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWIXWQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 18:16:49 -0400
Received: (root@vger.kernel.org) by vger.kernel.org id S1751276AbWIXWQf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 18:16:35 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:19420 "EHLO pasmtpA.tele.dk")
	by vger.kernel.org with ESMTP id S932139AbWIXVNL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 17:13:11 -0400
From: sam@ravnborg.org
To: linux-kernel@vger.kernel.org
Cc: "Robert P. J. Day" <rpjday@mindspring.com>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 25/28] kbuild: correct and clarify versioning info in Makefile
Reply-To: sam@ravnborg.org
Date: Sun, 24 Sep 2006 23:18:21 +0200
Message-Id: <11591327073816-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <11591327063733-git-send-email-sam@ravnborg.org>
References: 20060924210827.GA26969@uranus.ravnborg.org <1159132704708-git-send-email-sam@ravnborg.org> <11591327042606-git-send-email-sam@ravnborg.org> <11591327042944-git-send-email-sam@ravnborg.org> <11591327041272-git-send-email-sam@ravnborg.org> <11591327041374-git-send-email-sam@ravnborg.org> <11591327041093-git-send-email-sam@ravnborg.org> <11591327053484-git-send-email-sam@ravnborg.org> <11591327051061-git-send-email-sam@ravnborg.org> <11591327053770-git-send-email-sam@ravnborg.org> <11591327051381-git-send-email-sam@ravnborg.org> <11591327054119-git-send-email-sam@ravnborg.org> <11591327051998-git-send-email-sam@ravnborg.org> <11591327051652-git-send-email-sam@ravnborg.org> <11591327053365-git-send-email-sam@ravnborg.org> <1159132705363-git-send-email-sam@ravnborg.org> <11591327063034-git-send-email-sam@ravnborg.org> <11591327061320-git-send-email-sam@ravnborg.org> <1159132706174-git-send-email-sam@ravnborg.org> <11591327061478-git-send-email-sam@ravnborg.org> <115913
 2706423-git-send-email-sam@ravnborg.org> <115913270694-git-send-email-sam@ravnborg.org> <1159132706126-git-send-email-sam@ravnborg.org> <11591327063625-git-send-email-sam@ravnborg.org> <11591327063733-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert P. J. Day <rpjday@mindspring.com>

The attached patch clarifies the creation of KERNELRELEASE and
corrects an error regarding the use of $(LOCALVERSION).

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 Makefile |   32 +++++++++++++++++++++++++++-----
 1 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index 13bc589..241fed3 100644
--- a/Makefile
+++ b/Makefile
@@ -760,12 +760,34 @@ PHONY += $(vmlinux-dirs)
 	$(Q)$(MAKE) $(build)=$@
 
 # Build the kernel release string
-# The KERNELRELEASE is stored in a file named include/config/kernel.release
-# to be used when executing for example make install or make modules_install
 #
-# Take the contents of any files called localversion* and the config
-# variable CONFIG_LOCALVERSION and append them to KERNELRELEASE.
-# LOCALVERSION from the command line override all of this
+# The KERNELRELEASE value built here is stored in the file
+# include/config/kernel.release, and is used when executing several
+# make targets, such as "make install" or "make modules_install."
+#
+# The eventual kernel release string consists of the following fields,
+# shown in a hierarchical format to show how smaller parts are concatenated
+# to form the larger and final value, with values coming from places like
+# the Makefile, kernel config options, make command line options and/or
+# SCM tag information.
+#
+#	$(KERNELVERSION)
+#	  $(VERSION)			eg, 2
+#	  $(PATCHLEVEL)			eg, 6
+#	  $(SUBLEVEL)			eg, 18
+#	  $(EXTRAVERSION)		eg, -rc6
+#	$(localver-full)
+#	  $(localver)
+#	    localversion*		(all localversion* files)
+#	    $(CONFIG_LOCALVERSION)	(from kernel config setting)
+#	  $(localver-auto)		(only if CONFIG_LOCALVERSION_AUTO is set)
+#	    ./scripts/setlocalversion	(SCM tag, if one exists)
+#	    $(LOCALVERSION)		(from make command line if provided)
+#
+#  Note how the final $(localver-auto) string is included *only* if the
+# kernel config option CONFIG_LOCALVERSION_AUTO is selected.  Also, at the
+# moment, only git is supported but other SCMs can edit the script
+# scripts/setlocalversion and add the appropriate checks as needed.
 
 nullstring :=
 space      := $(nullstring) # end of line
-- 
1.4.1

