Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932646AbWAFX1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932646AbWAFX1O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 18:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932647AbWAFX1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 18:27:14 -0500
Received: from quark.didntduck.org ([69.55.226.66]:668 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S932646AbWAFX1O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 18:27:14 -0500
Message-ID: <43BEFD2D.8060102@didntduck.org>
Date: Fri, 06 Jan 2006 18:28:45 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mail/News 1.5 (X11/20060103)
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Clean up asm-offsets.h creation
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Move mkdir out of cmd_offsets
- Add input file to sed command instead of using cat

Signed-off-by: Brian Gerst <bgerst@didntduck.org>

---
commit 5976879aa5546beb50cd88ff1ba1d856445b2bad
tree 3af1bc8f50c8efe446fcc67efe312972bcfa731a
parent bcefe96417edca37a3834ba081bc8928cf411183
author Brian Gerst <bgerst@didntduck.org> Fri, 06 Jan 2006 18:27:07 -0500
committer Brian Gerst <bgerst@didntduck.org> Fri, 06 Jan 2006 18:27:07 -0500

 Kbuild |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/Kbuild b/Kbuild
index 7900391..95d6a00 100644
--- a/Kbuild
+++ b/Kbuild
@@ -22,8 +22,6 @@ sed-$(CONFIG_MIPS) := "/^@@@/s///p"
 
 quiet_cmd_offsets = GEN     $@
 define cmd_offsets
-	mkdir -p $(dir $@); \
-	cat $< | \
 	(set -e; \
 	 echo "#ifndef __ASM_OFFSETS_H__"; \
 	 echo "#define __ASM_OFFSETS_H__"; \
@@ -34,7 +32,7 @@ define cmd_offsets
 	 echo " *"; \
 	 echo " */"; \
 	 echo ""; \
-	 sed -ne $(sed-y); \
+	 sed -ne $(sed-y) $<; \
 	 echo ""; \
 	 echo "#endif" ) > $@
 endef
@@ -45,5 +43,6 @@ arch/$(ARCH)/kernel/asm-offsets.s: arch/
 	$(call if_changed_dep,cc_s_c)
 
 $(obj)/$(offsets-file): arch/$(ARCH)/kernel/asm-offsets.s Kbuild
+	$(Q)mkdir -p $(dir $@)
 	$(call cmd,offsets)
 


