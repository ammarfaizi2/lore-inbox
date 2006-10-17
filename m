Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751032AbWJQOEA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbWJQOEA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 10:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbWJQOEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 10:04:00 -0400
Received: from main.gmane.org ([80.91.229.2]:1199 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751031AbWJQOD7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 10:03:59 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: [PATCH .19-rc2] kbuild: Another 'headers*' fix for non in-tree build
Date: Tue, 17 Oct 2006 14:03:05 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrnej9p0r.2m4.olecom@flower.upol.cz>
References: <6bffcb0e0610160352h2bd86f33x72c438c7e8bdf810@mail.gmail.com>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: flower.upol.cz
Mail-Followup-To: Oleg Verych <olecom@flower.upol.cz>, LKML <linux-kernel@vger.kernel.org>
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 While it mostly work, version.h header *is* generated, thus resides
 in $(objtree), not $(srctree).
 This broke headers_install, thus headers_check.

Signed-off-by: Oleg Verych <olecom@flower.upol.cz>

---
 was [BUG 2.6.19-rc2-g51018b0a] No rule to make target
       /mnt/md0/devel/linux-git/include/linux/version.h
 by Michal Piotrowski <michal.k.k.piotrowski@gmail.com>

 Test it, please, Michal. I think this, non-rfc version, is OK for 2.6.19.

 scripts/Makefile.headersinst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.19-rc2/scripts/Makefile.headersinst
===================================================================
--- linux-2.6.19-rc2.orig/scripts/Makefile.headersinst	2006-10-17 13:40:58.091384132 +0000
+++ linux-2.6.19-rc2/scripts/Makefile.headersinst	2006-10-17 13:42:03.591116749 +0000
@@ -168,7 +168,7 @@
 	$(call cmd,gen)
 
 else
-$(objhdr-y) :		$(INSTALL_HDR_PATH)/$(_dst)/%.h: $(srctree)/$(obj)/%.h $(KBUILDFILES)
+$(objhdr-y) :		$(INSTALL_HDR_PATH)/$(_dst)/%.h: $(objtree)/$(obj)/%.h $(KBUILDFILES)
 	$(call cmd,o_hdr_install)
 
 $(header-y) :		$(INSTALL_HDR_PATH)/$(_dst)/%.h: $(srctree)/$(obj)/%.h $(KBUILDFILES)

