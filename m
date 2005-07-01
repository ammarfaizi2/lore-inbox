Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261423AbVGAW42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbVGAW42 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 18:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVGAW41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 18:56:27 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:17681 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262901AbVGAW4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 18:56:00 -0400
Date: Sat, 2 Jul 2005 00:55:59 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Robert Love <rml@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] inotify: fsnotify.h: use kstrdup
Message-ID: <20050701225559.GC3592@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kstrdup was added in 2.6.13-rc1.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.12-mm2-full/include/linux/fsnotify.h.old	2005-06-30 22:26:07.000000000 +0200
+++ linux-2.6.12-mm2-full/include/linux/fsnotify.h	2005-06-30 22:27:26.000000000 +0200
@@ -216,19 +216,10 @@
 
 /*
  * fsnotify_oldname_init - save off the old filename before we change it
- *
- * XXX: This could be kstrdup if only we could add that to lib/string.c
  */
 static inline const char *fsnotify_oldname_init(const char *name)
 {
-	size_t len;
-	char *buf;
-
-	len = strlen(name) + 1;
-	buf = kmalloc(len, GFP_KERNEL);
-	if (likely(buf))
-		memcpy(buf, name, len);
-	return buf;
+	return kstrdup(name, GFP_KERNEL);
 }
 
 /*

