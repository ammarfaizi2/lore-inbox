Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261891AbVBISkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbVBISkW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 13:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbVBISkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 13:40:22 -0500
Received: from waste.org ([216.27.176.166]:10726 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261891AbVBISkP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 13:40:15 -0500
Date: Wed, 9 Feb 2005 10:40:11 -0800
From: Matt Mackall <mpm@selenic.com>
To: Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] "PREEMPT" in UTS_VERSION
Message-ID: <20050209184011.GB2366@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add PREEMPT to UTS_VERSION where enabled as is done for SMP to make
preempt kernels easily identifiable.

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: mm1/scripts/mkcompile_h
===================================================================
--- mm1.orig/scripts/mkcompile_h	2004-04-03 19:38:28.000000000 -0800
+++ mm1/scripts/mkcompile_h	2005-02-08 23:02:11.000000000 -0800
@@ -2,6 +2,7 @@
 ARCH=$2
 SMP=$3
 CC=$4
+PREEMPT=$5
 
 # If compile.h exists already and we don't own autoconf.h
 # (i.e. we're not the same user who did make *config), don't
@@ -27,6 +28,7 @@
 
 UTS_VERSION="#$VERSION"
 if [ -n "$SMP" ] ; then UTS_VERSION="$UTS_VERSION SMP"; fi
+if [ -n "$PREEMPT" ] ; then UTS_VERSION="$UTS_VERSION PREEMPT"; fi
 UTS_VERSION="$UTS_VERSION `LC_ALL=C LANG=C date`"
 
 # Truncate to maximum length
Index: mm1/init/Makefile
===================================================================
--- mm1.orig/init/Makefile	2005-02-04 11:22:34.000000000 -0800
+++ mm1/init/Makefile	2005-02-08 23:02:07.000000000 -0800
@@ -25,4 +25,4 @@
 
 include/linux/compile.h: FORCE
 	@echo '  CHK     $@'
-	@$(CONFIG_SHELL) $(srctree)/scripts/mkcompile_h $@ "$(UTS_MACHINE)" "$(CONFIG_SMP)" "$(CC) $(CFLAGS)"
+	@$(CONFIG_SHELL) $(srctree)/scripts/mkcompile_h $@ "$(UTS_MACHINE)" "$(CONFIG_SMP)" "$(CC) $(CFLAGS)" "$(CONFIG_PREEMPT)"

-- 
Mathematics is the supreme nostalgia of our time.
