Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbUJ3VoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbUJ3VoR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 17:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbUJ3VmZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 17:42:25 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:16900 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261339AbUJ3Vim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 17:38:42 -0400
Date: Sat, 30 Oct 2004 23:38:11 +0200
From: Adrian Bunk <bunk@stusta.de>
To: dhowells@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] AFS: afs_voltypes isn't always required
Message-ID: <20041030213811.GB4374@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

afs_voltypes is only used #ifdef __KDEBUG, and even then it doesn't has 
to be a global symbol.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm2-full/fs/afs/types.h.old	2004-10-30 20:42:02.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/fs/afs/types.h	2004-10-30 23:22:03.000000000 +0200
@@ -26,8 +26,6 @@
 	AFSVL_BACKVOL,			/* backup volume */
 } __attribute__((packed)) afs_voltype_t;
 
-extern const char *afs_voltypes[];
-
 typedef enum {
 	AFS_FTYPE_INVALID	= 0,
 	AFS_FTYPE_FILE		= 1,
--- linux-2.6.10-rc1-mm2-full/fs/afs/volume.c.old	2004-10-30 20:41:43.000000000 +0200
+++ linux-2.6.10-rc1-mm2-full/fs/afs/volume.c	2004-10-30 23:20:41.000000000 +0200
@@ -24,7 +24,9 @@
 #include "vlclient.h"
 #include "internal.h"
 
-const char *afs_voltypes[] = { "R/W", "R/O", "BAK" };
+#ifdef __KDEBUG
+static const char *afs_voltypes[] = { "R/W", "R/O", "BAK" };
+#endif
 
 #ifdef CONFIG_AFS_FSCACHE
 static fscache_match_val_t afs_volume_cache_match(void *target,
