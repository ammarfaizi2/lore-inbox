Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbWIXWQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWIXWQL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 18:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWIXWQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 18:16:10 -0400
Received: (root@vger.kernel.org) by vger.kernel.org id S1751241AbWIXWQK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 18:16:10 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:8594 "EHLO pasmtpB.tele.dk")
	by vger.kernel.org with ESMTP id S932103AbWIXVNL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 17:13:11 -0400
From: sam@ravnborg.org
To: linux-kernel@vger.kernel.org
Cc: "Robert P. J. Day" <rpjday@mindspring.com>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 21/28] kbuild: clarify "make C=" build option
Reply-To: sam@ravnborg.org
Date: Sun, 24 Sep 2006 23:18:17 +0200
Message-Id: <115913270694-git-send-email-sam@ravnborg.org>
X-Mailer: git-send-email 1.4.1
In-Reply-To: <1159132706423-git-send-email-sam@ravnborg.org>
References: 20060924210827.GA26969@uranus.ravnborg.org <1159132704708-git-send-email-sam@ravnborg.org> <11591327042606-git-send-email-sam@ravnborg.org> <11591327042944-git-send-email-sam@ravnborg.org> <11591327041272-git-send-email-sam@ravnborg.org> <11591327041374-git-send-email-sam@ravnborg.org> <11591327041093-git-send-email-sam@ravnborg.org> <11591327053484-git-send-email-sam@ravnborg.org> <11591327051061-git-send-email-sam@ravnborg.org> <11591327053770-git-send-email-sam@ravnborg.org> <11591327051381-git-send-email-sam@ravnborg.org> <11591327054119-git-send-email-sam@ravnborg.org> <11591327051998-git-send-email-sam@ravnborg.org> <11591327051652-git-send-email-sam@ravnborg.org> <11591327053365-git-send-email-sam@ravnborg.org> <1159132705363-git-send-email-sam@ravnborg.org> <11591327063034-git-send-email-sam@ravnborg.org> <11591327061320-git-send-email-sam@ravnborg.org> <1159132706174-git-send-email-sam@ravnborg.org> <11591327061478-git-send-email-sam@ravnborg.org> <115913
 2706423-git-send-email-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert P. J. Day <rpjday@mindspring.com>

Clarify the use of "make C=" in the top-level Makefile, and fix a
typo in the Documentation file.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 Documentation/sparse.txt |    8 ++++----
 Makefile                 |   12 +++++++++---
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/Documentation/sparse.txt b/Documentation/sparse.txt
index 5a311c3..f9c99c9 100644
--- a/Documentation/sparse.txt
+++ b/Documentation/sparse.txt
@@ -69,10 +69,10 @@ recompiled, or use "make C=2" to run spa
 be recompiled or not.  The latter is a fast way to check the whole tree if you
 have already built it.
 
-The optional make variable CF can be used to pass arguments to sparse.  The
-build system passes -Wbitwise to sparse automatically.  To perform endianness
-checks, you may define __CHECK_ENDIAN__:
+The optional make variable CHECKFLAGS can be used to pass arguments to sparse.
+The build system passes -Wbitwise to sparse automatically.  To perform
+endianness checks, you may define __CHECK_ENDIAN__:
 
-        make C=2 CF="-D__CHECK_ENDIAN__"
+        make C=2 CHECKFLAGS="-D__CHECK_ENDIAN__"
 
 These checks are disabled by default as they generate a host of warnings.
diff --git a/Makefile b/Makefile
index 0d4a4dc..cd50298 100644
--- a/Makefile
+++ b/Makefile
@@ -41,9 +41,15 @@ ifndef KBUILD_VERBOSE
   KBUILD_VERBOSE = 0
 endif
 
-# Call checker as part of compilation of C files
-# Use 'make C=1' to enable checking (sparse, by default)
-# Override with 'make C=1 CHECK=checker_executable CHECKFLAGS=....'
+# Call a source code checker (by default, "sparse") as part of the
+# C compilation.
+#
+# Use 'make C=1' to enable checking of only re-compiled files.
+# Use 'make C=2' to enable checking of *all* source files, regardless
+# of whether they are re-compiled or not.
+#
+# See the file "Documentation/sparse.txt" for more details, including
+# where to get the "sparse" utility.
 
 ifdef C
   ifeq ("$(origin C)", "command line")
-- 
1.4.1

