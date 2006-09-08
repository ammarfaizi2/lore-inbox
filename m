Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbWIHSxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWIHSxV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 14:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbWIHSxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 14:53:21 -0400
Received: from moooo.ath.cx ([85.116.203.178]:1159 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1750804AbWIHSxU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 14:53:20 -0400
Date: Fri, 8 Sep 2006 20:53:16 +0200
From: Matthias Lederhofer <matled@gmx.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [BUG/PATCH] make deb-pkg: optionally use fakeroot
Message-ID: <20060908185316.GA20352@moooo.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem: deb-pkg needs root privileges or fakeroot but git-diff-index
does not work correctly with fakeroot.  Perhaps this variable should
have another name and be added to the other package targets too.

---
 scripts/package/Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/scripts/package/Makefile b/scripts/package/Makefile
index 7c434e0..d77e21a 100644
--- a/scripts/package/Makefile
+++ b/scripts/package/Makefile
@@ -72,7 +72,7 @@ # Deb target
 # ---------------------------------------------------------------------------
 deb-pkg: FORCE
 	$(MAKE) KBUILD_SRC=
-	$(CONFIG_SHELL) $(srctree)/scripts/package/builddeb
+	$(FAKEROOT) $(CONFIG_SHELL) $(srctree)/scripts/package/builddeb
 
 clean-dirs += $(objtree)/debian/
 
-- 
1.4.2.g0ea2

