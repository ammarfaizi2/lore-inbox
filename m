Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161362AbWASUFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161362AbWASUFl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 15:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161394AbWASUFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 15:05:41 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:53771 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1161362AbWASUFk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 15:05:40 -0500
Date: Thu, 19 Jan 2006 21:05:33 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] kbuild: fix build with O=..
Message-ID: <20060119200533.GD3557@mars.ravnborg.org>
References: <20060119200216.GA3557@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060119200216.GA3557@mars.ravnborg.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH 3/3] kbuild: fix build with O=..

.kernelrelease was saved in same directory as kernel source also
with make O=...
Make sure we kick in the normal logic to shift to the output directory
when we build .kernelrelease after executing *config.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 Makefile |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

f73b6ff2f3e7981c0b9cd34a70c491dfa98fd396
diff --git a/Makefile b/Makefile
index 37a4b67..671e6da 100644
--- a/Makefile
+++ b/Makefile
@@ -435,7 +435,7 @@ export KBUILD_DEFCONFIG
 config %config: scripts_basic outputmakefile FORCE
 	$(Q)mkdir -p include/linux
 	$(Q)$(MAKE) $(build)=scripts/kconfig $@
-	$(Q)$(MAKE) .kernelrelease
+	$(Q)$(MAKE) -C $(srctree) KBUILD_SRC= .kernelrelease
 
 else
 # ===========================================================================
@@ -1265,7 +1265,8 @@ define cmd_tags
 	CTAGSF=`ctags --version | grep -i exuberant >/dev/null &&     \
                 echo "-I __initdata,__exitdata,__acquires,__releases  \
                       -I EXPORT_SYMBOL,EXPORT_SYMBOL_GPL              \
-                      --extra=+f --c-kinds=+px"`;                     \
+                      --extra=+f --c-kinds=+px                        \
+		      --regex-asm=/ENTRY\(([^)]*)\).*/\1/"`;          \
                 $(all-sources) | xargs ctags $$CTAGSF -a
 endef
 
-- 
1.0.GIT
