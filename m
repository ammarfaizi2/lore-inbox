Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264767AbSKRUqb>; Mon, 18 Nov 2002 15:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264779AbSKRUqb>; Mon, 18 Nov 2002 15:46:31 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:61444
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S264767AbSKRUq0>; Mon, 18 Nov 2002 15:46:26 -0500
Subject: [patch] ALSA compiler warnings fixes
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1037652811.8374.138.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 (1.2.0-1) 
Date: 18 Nov 2002 15:53:31 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Attached patch fixes numerous warnings in ALSA core of the type "unused
variable foo" due to defined-away functions.

Usual solution applied.

Patch is against current BK, please apply.

	Robert Love


Fix numerous ALSA core compiler warnings of the type "unused variable foo"

 include/sound/core.h |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)


diff -urN linux-2.5.48/include/sound/core.h linux/include/sound/core.h
--- linux-2.5.48/include/sound/core.h	2002-11-17 23:29:57.000000000 -0500
+++ linux/include/sound/core.h	2002-11-18 15:51:59.000000000 -0500
@@ -177,11 +177,11 @@
 	wake_up(&card->power_sleep);
 }
 #else
-#define snd_power_lock(card) do { ; } while (0)
-#define snd_power_unlock(card) do { ; } while (0)
-#define snd_power_wait(card) do { ; } while (0)
-#define snd_power_get_state(card) SNDRV_CTL_POWER_D0
-#define snd_power_change_state(card, state) do { ; } while (0)
+#define snd_power_lock(card)		do { (void)(card); } while (0)
+#define snd_power_unlock(card)		do { (void)(card); } while (0)
+#define snd_power_wait(card)		do { (void)(card); } while (0)
+#define snd_power_get_state(card)	SNDRV_CTL_POWER_D0
+#define snd_power_change_state(card, state)	do { (void)(card); } while (0)
 #endif
 
 /* device.c */



