Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316878AbSIIKBj>; Mon, 9 Sep 2002 06:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316860AbSIIKBa>; Mon, 9 Sep 2002 06:01:30 -0400
Received: from smtpout.mac.com ([204.179.120.87]:25834 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S316857AbSIIKBM>;
	Mon, 9 Sep 2002 06:01:12 -0400
Message-Id: <200209091005.g89A5tOg000843@smtp-relay04-en1.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 3/10 sound/oss/ics2101.c
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.33/sound/oss/ics2101.c	Sat Apr 20 18:25:20 2002
+++ linux-2.5-cli-oss/sound/oss/ics2101.c	Fri Aug 16 13:59:55 2002
@@ -15,6 +15,7 @@
  * Bartlomiej Zolnierkiewicz : added __init to ics2101_mixer_init()
  */
 #include <linux/init.h>
+#include <linux/spinlock.h>
 #include "sound_config.h"
 
 #include <linux/ultrasound.h>
@@ -28,6 +29,7 @@
 
 extern int     *gus_osp;
 extern int      gus_base;
+extern spinlock_t lock;
 static int      volumes[ICS_MIXDEVS];
 static int      left_fix[ICS_MIXDEVS] =
 {1, 1, 1, 2, 1, 2};
@@ -85,13 +87,12 @@
 		attn_addr |= 0x03;
 	}
 
-	save_flags(flags);
-	cli();
+	spin_lock_irqsave(&lock, flags);
 	outb((ctrl_addr), u_MixSelect);
 	outb((selector[dev]), u_MixData);
 	outb((attn_addr), u_MixSelect);
 	outb(((unsigned char) vol), u_MixData);
-	restore_flags(flags);
+	spin_unlock_irqrestore(&lock, flags);
 }
 
 static int set_volumes(int dev, int vol)

