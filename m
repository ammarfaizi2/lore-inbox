Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbWDGOel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbWDGOel (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 10:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWDGOc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 10:32:29 -0400
Received: from [151.97.230.9] ([151.97.230.9]:31708 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S932305AbWDGOcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 10:32:23 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 10/17] uml: support sparse for userspace files
Date: Fri, 07 Apr 2006 16:31:13 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20060407143112.19201.59675.stgit@zion.home.lan>
In-Reply-To: <20060407142709.19201.99196.stgit@zion.home.lan>
References: <20060407142709.19201.99196.stgit@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Make sparse checker work for userspace files - it normally gets -nostdinc
separately, so avoid having it for userspace files. Also, add -D$(SUBARCH) for
multiarch hosts (i.e. AMD64 with compatibility headers).

It works, the only problem is a bit of bogus warnings for system headers, but
they're not too many.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/um/scripts/Makefile.rules |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/um/scripts/Makefile.rules b/arch/um/scripts/Makefile.rules
index b696b45..5e7a9c3 100644
--- a/arch/um/scripts/Makefile.rules
+++ b/arch/um/scripts/Makefile.rules
@@ -9,10 +9,8 @@ USER_OBJS := $(foreach file,$(USER_OBJS)
 
 $(USER_OBJS) $(USER_OBJS:.o=.i) $(USER_OBJS:.o=.s) $(USER_OBJS:.o=.lst): \
 	c_flags = -Wp,-MD,$(depfile) $(USER_CFLAGS) $(CFLAGS_$(notdir $@))
-$(USER_OBJS): cmd_checksrc =
-$(USER_OBJS): quiet_cmd_checksrc =
-$(USER_OBJS): cmd_force_checksrc =
-$(USER_OBJS): quiet_cmd_force_checksrc =
+$(USER_OBJS) : CHECKFLAGS := -D__linux__ -Dlinux -D__STDC__ \
+	-Dunix -D__unix__ -D__$(SUBARCH)__
 
 
 # The stubs and unmap.o can't try to call mcount or update basic block data
