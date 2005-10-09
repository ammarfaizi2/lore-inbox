Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbVJITpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbVJITpF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 15:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbVJITmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 15:42:37 -0400
Received: from ppp-62-11-74-46.dialup.tiscali.it ([62.11.74.46]:24216 "EHLO
	zion.home.lan") by vger.kernel.org with ESMTP id S1750967AbVJITmY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 15:42:24 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 3/6] uml: allow building .s/.i/.lst files from userspace files
Date: Sun, 09 Oct 2005 21:37:26 +0200
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20051009193726.26019.36037.stgit@zion.home.lan>
In-Reply-To: <200510092118.21032.blaisorblade@yahoo.it>
References: <200510092118.21032.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

For files which need to include glibc headers (i.e. userspace files), we
specified the correct flags only for .o, not for .s/.lst/.i. Fix this.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/scripts/Makefile.rules |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/scripts/Makefile.rules b/arch/um/scripts/Makefile.rules
--- a/arch/um/scripts/Makefile.rules
+++ b/arch/um/scripts/Makefile.rules
@@ -7,8 +7,8 @@ USER_SINGLE_OBJS := \
 USER_OBJS += $(filter %_user.o,$(obj-y) $(obj-m)  $(USER_SINGLE_OBJS))
 USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
 
-$(USER_OBJS) : c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) \
-	$(CFLAGS_$(notdir $@))
+$(USER_OBJS) $(USER_OBJS:.o=.i) $(USER_OBJS:.o=.s) $(USER_OBJS:.o=.lst): \
+	c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) $(CFLAGS_$(notdir $@))
 $(USER_OBJS): cmd_checksrc =
 $(USER_OBJS): quiet_cmd_checksrc =
 $(USER_OBJS): cmd_force_checksrc =

