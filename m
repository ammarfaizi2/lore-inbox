Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbUDNU2W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 16:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbUDNUZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 16:25:46 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:57104 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261673AbUDNUXh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 16:23:37 -0400
Date: Wed, 14 Apr 2004 22:31:13 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: fix modules_install
Message-ID: <20040414203113.GC12020@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The directory .tmp_versions/ was deleted during make vmlinux.
This eliminated the list of modules used for moudles_install.
The effect was that the following scenario failed:
make
make install
make modules_install

The solution is to only cleanup .tmp_versions when building modules.

===== Makefile 1.478 vs edited =====
--- 1.478/Makefile	Tue Apr 13 17:46:49 2004
+++ edited/Makefile	Wed Apr 14 22:19:26 2004
@@ -624,8 +624,10 @@
 endif
 
 prepare0: prepare1 include/linux/version.h include/asm include/config/MARKER
+ifneq ($(KBUILD_MODULES),)
 	$(Q)rm -rf $(MODVERDIR)
-	$(if $(CONFIG_MODULES),$(Q)mkdir -p $(MODVERDIR))
+	$(Q)mkdir -p $(MODVERDIR)
+endif
 
 # All the preparing..
 prepare-all: prepare0 prepare

