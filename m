Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbWDEVes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWDEVes (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 17:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWDEVes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 17:34:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:10476 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751168AbWDEVer (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 17:34:47 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SUSE Labs / Novell Inc.
To: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] modules_install must not remove existing modules
Date: Wed, 5 Apr 2006 23:33:50 +0200
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604052333.51085.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When installing external modules with `make modules_install', the
first thing that happens is a rm -rf of the target directory. This
works only once, and breaks when installing more than one (set of)
external module(s). Bug introduced in:
  http://www.kernel.org/hg/linux-2.6/?cs=bbb3915836f5

Sam, is this fix okay with you?

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Index: linux-2.6.16/Makefile
===================================================================
--- linux-2.6.16.orig/Makefile
+++ linux-2.6.16/Makefile
@@ -1131,7 +1131,6 @@ modules_install: _emodinst_ _emodinst_po
 install-dir := $(if $(INSTALL_MOD_DIR),$(INSTALL_MOD_DIR),extra)	
 .PHONY: _emodinst_
 _emodinst_:
-	$(Q)rm -rf $(MODLIB)/$(install-dir)
 	$(Q)mkdir -p $(MODLIB)/$(install-dir)
 	$(Q)$(MAKE) -rR -f $(srctree)/scripts/Makefile.modinst

-- 
Andreas Gruenbacher <agruen@suse.de>
Novell / SUSE Labs
