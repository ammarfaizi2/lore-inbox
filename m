Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbVKWTGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbVKWTGa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 14:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbVKWTG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 14:06:29 -0500
Received: from gate.crashing.org ([63.228.1.57]:11233 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932204AbVKWTG2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 14:06:28 -0500
Date: Wed, 23 Nov 2005 13:03:37 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Paul Mackerras <paulus@samba.org>
cc: linuxppc-dev@ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH] powerpc: Fix suboptimal uImage target   
Message-ID: <Pine.LNX.4.44.0511231303030.4255-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg pointed out that calling if_changed was redudant in the
rule since we a prerequisite had to have change for us to get there.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit b3b2fd54eab2d87dcc29db5c537b5aee2a7732ce
tree 0eba205e3944aca7095fb2723f95e9799be5c853
parent 74dc65dbfa00bb69929c34da2ae788868aaae399
author Kumar Gala <galak@kernel.crashing.org> Wed, 23 Nov 2005 13:04:48 -0600
committer Kumar Gala <galak@kernel.crashing.org> Wed, 23 Nov 2005 13:04:48 -0600

 arch/powerpc/boot/Makefile    |    2 +-
 arch/ppc/boot/images/Makefile |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index dfc7eac..22726ae 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -169,7 +169,7 @@ $(obj)/vmlinux.gz: $(obj)/vmlinux.bin FO
 
 $(obj)/uImage: $(obj)/vmlinux.gz
 	$(Q)rm -f $@
-	$(call if_changed,uimage)
+	$(call cmd,uimage)
 	@echo -n '  Image: $@ '
 	@if [ -f $@ ]; then echo 'is ready' ; else echo 'not made'; fi
 
diff --git a/arch/ppc/boot/images/Makefile b/arch/ppc/boot/images/Makefile
index 532e7ef..58415d5 100644
--- a/arch/ppc/boot/images/Makefile
+++ b/arch/ppc/boot/images/Makefile
@@ -26,7 +26,7 @@ quiet_cmd_uimage = UIMAGE  $@
 targets += uImage
 $(obj)/uImage: $(obj)/vmlinux.gz
 	$(Q)rm -f $@
-	$(call if_changed,uimage)
+	$(call cmd,uimage)
 	@echo -n '  Image: $@ '
 	@if [ -f $@ ]; then echo 'is ready' ; else echo 'not made'; fi
 

