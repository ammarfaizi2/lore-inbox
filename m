Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319403AbSH2VzT>; Thu, 29 Aug 2002 17:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319368AbSH2Vxy>; Thu, 29 Aug 2002 17:53:54 -0400
Received: from smtpout.mac.com ([204.179.120.88]:55033 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S319400AbSH2Vxl>;
	Thu, 29 Aug 2002 17:53:41 -0400
Message-Id: <200208292158.g7TLw472021793@smtp-relay04-en1.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 32/41 sound/oss/rme96xx.c - convert cli to spinlocks
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.32/sound/oss/rme96xx.c	Sat Aug 10 00:04:15 2002
+++ linux-2.5-cli-oss/sound/oss/rme96xx.c	Sat Aug 10 17:03:07 2002
@@ -10,6 +10,7 @@
    *  11 May 2001: 0.4 fixed for SMP, included into kernel source tree
    *  17 May 2001: 0.5 draining code didn't work on new cards
    *  18 May 2001: 0.6 remove synchronize_irq() call 
+   *  10 Aug 2002: added synchronize_irq() again
 
 TODO:
    - test more than one card --- done
@@ -41,6 +42,7 @@
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <asm/dma.h>
+#include <asm/hardirq.h>
 #include <linux/init.h>
 #include <linux/poll.h>
 #include "rme96xx.h"
@@ -786,8 +788,8 @@
 	}
 	
 	unregister_sound_mixer(s->mixer);
-/*	synchronize_irq(); This call got lost somehow ? */
-        free_irq(s->irq,s);
+	synchronize_irq(s->irq);
+	free_irq(s->irq,s);
 	busmaster_free(s->recbuf,RME96xx_DMA_MAX_SIZE_ALL);
 	busmaster_free(s->playbuf,RME96xx_DMA_MAX_SIZE_ALL);
 	kfree(s);

