Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261216AbVGQOxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261216AbVGQOxf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 10:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbVGQOxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 10:53:34 -0400
Received: from ns.suse.de ([195.135.220.2]:2964 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261216AbVGQOxa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 10:53:30 -0400
Date: Sun, 17 Jul 2005 16:53:28 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>, blaisorblade@yahoo.it,
       linux-kernel@vger.kernel.org
Subject: [PATCH] add dependency to arch/um/Makefile for parallel builds
Message-ID: <20050717145327.GB15771@suse.de>
References: <20050717145228.GA15771@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20050717145228.GA15771@suse.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the headerfile must be build before mk_user_constants. Adding it as 
a direct dep doesnt work for some reason.

arch/um/os-Linux/util/mk_user_constants.c:2:26: error: user-offsets.h: No such file or directory
arch/um/os-Linux/util/mk_user_constants.c: In function 'main':
arch/um/os-Linux/util/mk_user_constants.c:17: error: '__UM_FRAME_SIZE' undeclared (first use in this function)
arch/um/os-Linux/util/mk_user_constants.c:17: error: (Each undeclared identifier is reported only once
arch/um/os-Linux/util/mk_user_constants.c:17: error: for each function it appears in.)
make[1]: *** [arch/um/os-Linux/util/mk_user_constants] Error 1

Signed-off-by: Olaf Hering <olh@suse.de>

 arch/um/Makefile |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.13-rc3-git4/arch/um/Makefile
===================================================================
--- linux-2.6.13-rc3-git4.orig/arch/um/Makefile
+++ linux-2.6.13-rc3-git4/arch/um/Makefile
@@ -245,7 +245,7 @@ $(ARCH_DIR)/util: scripts_basic $(SYS_DI
 $(ARCH_DIR)/kernel/skas/util: scripts_basic $(ARCH_DIR)/user-offsets.h FORCE
 	$(Q)$(MAKE) $(build)=$@
 
-$(ARCH_DIR)/os-$(OS)/util: scripts_basic FORCE
+$(ARCH_DIR)/os-$(OS)/util: scripts_basic $(ARCH_DIR)/user-offsets.h FORCE
 	$(Q)$(MAKE) $(build)=$@
 
 export SUBARCH USER_CFLAGS OS
