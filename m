Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbWABKZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWABKZb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 05:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbWABKZb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 05:25:31 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:261 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932195AbWABKZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 05:25:30 -0500
Date: Mon, 2 Jan 2006 11:25:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: zippel@linux-m68k.org
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fix gconfig with POSIXLY_CORRECT=1
Message-ID: <20060102102530.GA17398@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixed "make gconfig" with POSIXLY_CORRECT=1 set.

This issue was reported by Jens Elkner <elkner@linofee.org> in kernel
Bugzilla #2919.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 scripts/kconfig/Makefile |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.15-rc5-mm3-full/scripts/kconfig/Makefile.old	2006-01-02 11:19:56.000000000 +0100
+++ linux-2.6.15-rc5-mm3-full/scripts/kconfig/Makefile	2006-01-02 11:22:30.000000000 +0100
@@ -132,8 +132,8 @@
 HOSTLOADLIBES_qconf	= $(KC_QT_LIBS) -ldl
 HOSTCXXFLAGS_qconf.o	= $(KC_QT_CFLAGS) -D LKC_DIRECT_LINK
 
-HOSTLOADLIBES_gconf	= `pkg-config gtk+-2.0 gmodule-2.0 libglade-2.0 --libs`
-HOSTCFLAGS_gconf.o	= `pkg-config gtk+-2.0 gmodule-2.0 libglade-2.0 --cflags` \
+HOSTLOADLIBES_gconf	= `pkg-config --libs gtk+-2.0 gmodule-2.0 libglade-2.0`
+HOSTCFLAGS_gconf.o	= `pkg-config --cflags gtk+-2.0 gmodule-2.0 libglade-2.0` \
                           -D LKC_DIRECT_LINK
 
 $(obj)/qconf.o: $(obj)/.tmp_qtcheck
@@ -192,8 +192,8 @@
 
 # GTK needs some extra effort, too...
 $(obj)/.tmp_gtkcheck:
-	@if `pkg-config gtk+-2.0 gmodule-2.0 libglade-2.0 --exists`; then		\
-		if `pkg-config gtk+-2.0 --atleast-version=2.0.0`; then			\
+	@if `pkg-config --exists gtk+-2.0 gmodule-2.0 libglade-2.0`; then		\
+		if `pkg-config --atleast-version=2.0.0 gtk+-2.0`; then			\
 			touch $@;								\
 		else									\
 			echo "*"; 							\

