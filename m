Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbWACN1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWACN1O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 08:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWACNZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 08:25:54 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:45061 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932368AbWACNZi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 08:25:38 -0500
Subject: [PATCH 20/26] kbuild: tags file generation fixup
In-Reply-To: <20060103132035.GA17485@mars.ravnborg.org>
X-Mailer: gregkh_patchbomb-sam
Date: Tue, 3 Jan 2006 14:25:26 +0100
Message-Id: <11362947261422@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Sam Ravnborg <sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: 1135561638 +0100

Here is a fixup for tags file generation, for proper tags of
__releases/__acquires functions.

Signed-off-by: samuel.thibault@ens-lyon.org
Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

---

 Makefile |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

54e08a2392e99ba9e48ce1060e0b52a39118419c
diff --git a/Makefile b/Makefile
index ced0346..922c763 100644
--- a/Makefile
+++ b/Makefile
@@ -1236,9 +1236,10 @@ cscope: FORCE
 quiet_cmd_TAGS = MAKE   $@
 define cmd_TAGS
 	rm -f $@; \
-	ETAGSF=`etags --version | grep -i exuberant >/dev/null && \
-                echo "-I __initdata,__exitdata,EXPORT_SYMBOL,EXPORT_SYMBOL_GPL \
-                --extra=+f --c-kinds=+px"`; \
+	ETAGSF=`etags --version | grep -i exuberant >/dev/null &&     \
+                echo "-I __initdata,__exitdata,__acquires,__releases  \
+                      -I EXPORT_SYMBOL,EXPORT_SYMBOL_GPL              \
+                      --extra=+f --c-kinds=+px"`;                     \
                 $(all-sources) | xargs etags $$ETAGSF -a
 endef
 
@@ -1249,9 +1250,10 @@ TAGS: FORCE
 quiet_cmd_tags = MAKE   $@
 define cmd_tags
 	rm -f $@; \
-	CTAGSF=`ctags --version | grep -i exuberant >/dev/null && \
-                echo "-I __initdata,__exitdata,EXPORT_SYMBOL,EXPORT_SYMBOL_GPL \
-                --extra=+f --c-kinds=+px"`; \
+	CTAGSF=`ctags --version | grep -i exuberant >/dev/null &&     \
+                echo "-I __initdata,__exitdata,__acquires,__releases  \
+                      -I EXPORT_SYMBOL,EXPORT_SYMBOL_GPL              \
+                      --extra=+f --c-kinds=+px"`;                     \
                 $(all-sources) | xargs ctags $$CTAGSF -a
 endef
 
-- 
1.0.6

