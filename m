Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbUKNCZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbUKNCZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 21:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbUKNCZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 21:25:28 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:22795 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261237AbUKNCZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 21:25:20 -0500
Date: Sun, 14 Nov 2004 03:24:46 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] OSS via82cxxx_audio.c: enable procfs code
Message-ID: <20041114022446.GK2249@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below enables the procfs code in sound/oss/via82cxxx_audio.c 
if CONFIG_PROC_FS=y.

This fuxes Bugzilla #3738.


diffstat output:
 sound/oss/via82cxxx_audio.c |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm5-full/sound/oss/via82cxxx_audio.c.old	2004-11-14 03:09:05.000000000 +0100
+++ linux-2.6.10-rc1-mm5-full/sound/oss/via82cxxx_audio.c	2004-11-14 03:09:45.000000000 +0100
@@ -62,11 +62,6 @@
         }
 #endif
 
-#if defined(CONFIG_PROC_FS) && \
-    defined(CONFIG_SOUND_VIA82CXXX_PROCFS)
-#define VIA_PROC_FS 1
-#endif
-
 #define VIA_SUPPORT_MMAP 1 /* buggy, for now... */
 
 #define MAX_CARDS	1
@@ -366,7 +361,7 @@
 static void via_chan_pcm_fmt (struct via_channel *chan, int reset);
 static void via_chan_buffer_free (struct via_info *card, struct via_channel *chan);
 
-#ifdef VIA_PROC_FS
+#ifdef CONFIG_PROC_FS
 static int via_init_proc (void);
 static void via_cleanup_proc (void);
 static int via_card_init_proc (struct via_info *card);
@@ -3652,7 +3647,7 @@
 MODULE_LICENSE("GPL");
 
 
-#ifdef VIA_PROC_FS
+#ifdef CONFIG_PROC_FS
 
 /****************************************************************
  *
@@ -3828,4 +3823,4 @@
 	DPRINTK ("EXIT\n");
 }
 
-#endif /* VIA_PROC_FS */
+#endif /* CONFIG_PROC_FS */

