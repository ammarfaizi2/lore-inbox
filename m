Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbWACN2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbWACN2j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 08:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWACN2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 08:28:25 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:44549 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932361AbWACNZi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 08:25:38 -0500
Subject: [PATCH 14/26] kbuild: Add ctags support for function prototypes and external variable declarations
In-Reply-To: <20060103132035.GA17485@mars.ravnborg.org>
X-Mailer: gregkh_patchbomb-sam
Date: Tue, 3 Jan 2006 14:25:25 +0100
Message-Id: <11362947251329@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Kacur <jkacur@rogers.com>
Date: 1130559913 -0400

This patch adds function prototypes and external variable declarations
to the set of tag kinds when running ctags. I find this useful when
perusing the kernel. Please apply.

Signed-off-by: John Kacur <jkacur@rogers.com>
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 Makefile |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

f6333eb4e788bf70d6455c9004b6b676df62c500
diff --git a/Makefile b/Makefile
index 5f685b9..ced0346 100644
--- a/Makefile
+++ b/Makefile
@@ -1236,8 +1236,10 @@ cscope: FORCE
 quiet_cmd_TAGS = MAKE   $@
 define cmd_TAGS
 	rm -f $@; \
-	ETAGSF=`etags --version | grep -i exuberant >/dev/null && echo "-I __initdata,__exitdata,EXPORT_SYMBOL,EXPORT_SYMBOL_GPL --extra=+f"`; \
-	$(all-sources) | xargs etags $$ETAGSF -a
+	ETAGSF=`etags --version | grep -i exuberant >/dev/null && \
+                echo "-I __initdata,__exitdata,EXPORT_SYMBOL,EXPORT_SYMBOL_GPL \
+                --extra=+f --c-kinds=+px"`; \
+                $(all-sources) | xargs etags $$ETAGSF -a
 endef
 
 TAGS: FORCE
@@ -1247,8 +1249,10 @@ TAGS: FORCE
 quiet_cmd_tags = MAKE   $@
 define cmd_tags
 	rm -f $@; \
-	CTAGSF=`ctags --version | grep -i exuberant >/dev/null && echo "-I __initdata,__exitdata,EXPORT_SYMBOL,EXPORT_SYMBOL_GPL --extra=+f"`; \
-	$(all-sources) | xargs ctags $$CTAGSF -a
+	CTAGSF=`ctags --version | grep -i exuberant >/dev/null && \
+                echo "-I __initdata,__exitdata,EXPORT_SYMBOL,EXPORT_SYMBOL_GPL \
+                --extra=+f --c-kinds=+px"`; \
+                $(all-sources) | xargs ctags $$CTAGSF -a
 endef
 
 tags: FORCE
-- 
1.0.6

