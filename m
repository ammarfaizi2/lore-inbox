Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319418AbSH2V4Y>; Thu, 29 Aug 2002 17:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319409AbSH2Vze>; Thu, 29 Aug 2002 17:55:34 -0400
Received: from smtpout.mac.com ([204.179.120.88]:12282 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S319406AbSH2VyZ>;
	Thu, 29 Aug 2002 17:54:25 -0400
Message-Id: <200208292158.g7TLwmZH004328@smtp-relay02.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 38/41 sound/oss/pas2_card.c - convert cli to spinlocks
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.32/sound/oss/pas2_card.c	Sat Apr 20 18:25:21 2002
+++ linux-2.5-cli-oss/sound/oss/pas2_card.c	Tue Aug 13 23:18:58 2002
@@ -7,6 +7,7 @@
 #include <linux/config.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/spinlock.h>
 #include "sound_config.h"
 
 #include "pas2.h"
@@ -38,6 +39,7 @@
 static int      pas_intr_mask = 0;
 static int      pas_irq = 0;
 static int      pas_sb_base = 0;
+spinlock_t		lock=SPIN_LOCK_UNLOCKED;
 #ifndef CONFIG_PAS_JOYSTICK
 static int	joystick = 0;
 #else

