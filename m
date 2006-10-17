Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423200AbWJQJod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423200AbWJQJod (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 05:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423201AbWJQJod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 05:44:33 -0400
Received: from main.gmane.org ([80.91.229.2]:41151 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1423200AbWJQJoc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 05:44:32 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: [PATCH RFC] kbuild: more headers_check fix for non-in-tree builds (was [BUG 2.6.19-rc2-g51018b0a] No rule to make target /mnt/md0/devel/linux-git/include/linux/version.h)
Date: Tue, 17 Oct 2006 09:43:42 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrnej8vcn.2lu.olecom@flower.upol.cz>
References: <6bffcb0e0610160352h2bd86f33x72c438c7e8bdf810@mail.gmail.com>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: flower.upol.cz
Mail-Followup-To: Oleg Verych <olecom@flower.upol.cz>,  LKML <linux-kernel@vger.kernel.org>
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"'objhdr-y' are generated files", thus they are not in $(srctree).
Kbuild.include already included in root Makefile.

Signed-off-by: Oleg Verych <olecom@flower.upol.cz>

---
 scripts/Makefile.headersinst |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

Index: linux-2.6.19-rc2/scripts/Makefile.headersinst
===================================================================
--- linux-2.6.19-rc2.orig/scripts/Makefile.headersinst	2006-10-17 06:31:48.379349215 +0000
+++ linux-2.6.19-rc2/scripts/Makefile.headersinst	2006-10-17 06:32:30.161730257 +0000
@@ -39,8 +39,6 @@
 
 include $(KBUILDFILES)
 
-include scripts/Kbuild.include 
-
 # If this is include/asm-$(ARCH) and there's no $(ALTARCH), then
 # override $(_dst) so that we install to include/asm directly.
 # Unless $(BIASMDIR) is set, in which case we're probably doing
@@ -168,7 +166,7 @@
 	$(call cmd,gen)
 
 else
-$(objhdr-y) :		$(INSTALL_HDR_PATH)/$(_dst)/%.h: $(srctree)/$(obj)/%.h $(KBUILDFILES)
+$(objhdr-y) : $(INSTALL_HDR_PATH)/$(_dst)/%.h: $(obj)/%.h $(KBUILDFILES)
 	$(call cmd,o_hdr_install)
 
 $(header-y) :		$(INSTALL_HDR_PATH)/$(_dst)/%.h: $(srctree)/$(obj)/%.h $(KBUILDFILES)



