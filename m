Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319416AbSH2V4Y>; Thu, 29 Aug 2002 17:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319355AbSH2Vzk>; Thu, 29 Aug 2002 17:55:40 -0400
Received: from smtpout.mac.com ([204.179.120.86]:61140 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S319402AbSH2VyK>;
	Thu, 29 Aug 2002 17:54:10 -0400
Message-Id: <200208292158.g7TLwXZH004265@smtp-relay02.mac.com>
Date: Thu, 29 Aug 2002 21:56:27 +0200
Mime-Version: 1.0 (Apple Message framework v482)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: [PATCH] 36/41 sound/oss/trident.c - convert cli to spinlocks
From: pwaechtler@mac.com
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Cc: torvalds@transmeta.com
X-Mailer: Apple Mail (2.482)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- vanilla-2.5.32/sound/oss/trident.c	Sat Aug 10 00:10:57 2002
+++ linux-2.5-cli-oss/sound/oss/trident.c	Sat Aug 10 17:04:38 2002
@@ -2150,14 +2150,14 @@
 		/* FIXME: spin_lock ? */
 		if (file->f_mode & FMODE_WRITE) {
 			stop_dac(state);
-			synchronize_irq();
+			synchronize_irq(card->irq);
 			dmabuf->ready = 0;
 			dmabuf->swptr = dmabuf->hwptr = 0;
 			dmabuf->count = dmabuf->total_bytes = 0;
 		}
 		if (file->f_mode & FMODE_READ) {
 			stop_adc(state);
-			synchronize_irq();
+			synchronize_irq(card->irq);
 			dmabuf->ready = 0;
 			dmabuf->swptr = dmabuf->hwptr = 0;
 			dmabuf->count = dmabuf->total_bytes = 0;

