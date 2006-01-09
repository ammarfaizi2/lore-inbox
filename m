Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWAIVi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWAIVi0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 16:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWAIVi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 16:38:26 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:33807 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750722AbWAIViZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 16:38:25 -0500
Subject: [PATCH 02/11] kbuild: clean up asm-offsets.h creation
In-Reply-To: <20060109211157.GA14477@mars.ravnborg.org>
X-Mailer: gregkh_patchbomb-sam
Date: Mon, 9 Jan 2006 22:38:09 +0100
Message-Id: <11368426891562@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian Gerst <bgerst@didntduck.org>
Date: 1136590125 -0500

- Move mkdir out of cmd_offsets
- Add input file to sed command instead of using cat

Signed-off-by: Brian Gerst <bgerst@didntduck.org>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 Kbuild |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

ac448afbcdcc218fd8d177960466ecc4a523722f
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
 
-- 
1.0.GIT

