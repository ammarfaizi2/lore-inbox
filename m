Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263155AbVF3UlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263155AbVF3UlQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 16:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263157AbVF3UkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 16:40:08 -0400
Received: from mail.dif.dk ([193.138.115.101]:17621 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S263150AbVF3Uja (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 16:39:30 -0400
Date: Thu, 30 Jun 2005 22:45:29 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Zach Brown <zab@zabbo.net>, linux-sound@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] cleanup NULL pointer check before vfree in sound/oss/maestro3.c
Message-ID: <Pine.LNX.4.62.0506302241251.2858@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vfree() can take a NULL pointer so don't waste time checking first.

 sound/oss/maestro3.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.13-rc1-orig/sound/oss/maestro3.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc1/sound/oss/maestro3.c	2005-06-30 22:40:42.000000000 +0200
@@ -2580,10 +2580,10 @@ static int alloc_dsp_suspendmem(struct m
 
     return 0;
 }
+
 static void free_dsp_suspendmem(struct m3_card *card)
 {
-   if(card->suspend_mem)
-       vfree(card->suspend_mem);
+	vfree(card->suspend_mem);
 }
 
 #else


