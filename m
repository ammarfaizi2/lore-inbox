Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262633AbVDHAQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262633AbVDHAQH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 20:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262632AbVDHANB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 20:13:01 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:52233 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262631AbVDHALK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 20:11:10 -0400
Date: Fri, 8 Apr 2005 02:11:05 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] fix sound/oss/nm256_audio.c with gcc 4.0
Message-ID: <20050408001105.GH4325@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rearrange sound/oss/nm256_audio.c and to drop nm256_debug from nm256.h 
since it confuses gcc 4.0 (this problem was my fault).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 29 Mar 2005

--- linux-2.6.12-rc1-mm3-full/sound/oss/nm256.h.old	2005-03-28 23:49:39.000000000 +0200
+++ linux-2.6.12-rc1-mm3-full/sound/oss/nm256.h	2005-03-28 23:51:33.000000000 +0200
@@ -128,9 +128,6 @@
     struct nm256_info *next_card;
 };
 
-/* Debug flag--bigger numbers mean more output. */
-extern int nm256_debug;
-
 /* The BIOS signature. */
 #define NM_SIGNATURE 0x4e4d0000
 /* Signature mask. */
--- linux-2.6.12-rc1-mm3-full/sound/oss/nm256_audio.c.old	2005-03-28 23:51:53.000000000 +0200
+++ linux-2.6.12-rc1-mm3-full/sound/oss/nm256_audio.c	2005-03-28 23:52:19.000000000 +0200
@@ -28,12 +28,13 @@
 #include <linux/delay.h>
 #include <linux/spinlock.h>
 #include "sound_config.h"
-#include "nm256.h"
-#include "nm256_coeff.h"
 
 static int nm256_debug;
 static int force_load;
 
+#include "nm256.h"
+#include "nm256_coeff.h"
+
 /* 
  * The size of the playback reserve.  When the playback buffer has less
  * than NM256_PLAY_WMARK_SIZE bytes to output, we request a new

