Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261966AbULKQzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261966AbULKQzK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 11:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbULKQzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 11:55:09 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:43527 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261966AbULKQzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 11:55:00 -0500
Date: Sat, 11 Dec 2004 17:54:51 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] AFS: afs_voltypes isn't always required (fwd)
Message-ID: <20041211165451.GT22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below still applies and compiles against 
2.6.10-rc2-mm4.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Sat, 30 Oct 2004 23:38:11 +0200
From: Adrian Bunk <bunk@stusta.de>
To: dhowells@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] AFS: afs_voltypes isn't always required

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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

