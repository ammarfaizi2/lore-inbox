Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263140AbVF3UkN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263140AbVF3UkN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 16:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263127AbVF3UgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 16:36:08 -0400
Received: from mail.dif.dk ([193.138.115.101]:19668 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S263112AbVF3UWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 16:22:24 -0400
Date: Thu, 30 Jun 2005 22:28:27 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Hannu Savolainen <hannu@opensound.com>,
       linux-sound <linux-sound@vger.kernel.org>, akpm@osdl.org
Subject: [PATCH] vfree cleanup for sound/oss/sequencer.c
Message-ID: <Pine.LNX.4.62.0506302223340.2858@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't bother checking for NULL, vfree can handle it.

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 sound/oss/sequencer.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

--- linux-2.6.13-rc1-orig/sound/oss/sequencer.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc1/sound/oss/sequencer.c	2005-06-30 22:21:49.000000000 +0200
@@ -1671,14 +1671,8 @@ void sequencer_init(void)
 
 void sequencer_unload(void)
 {
-	if(queue)
-	{
-		vfree(queue);
-		queue=NULL;
-	}
-	if(iqueue)
-	{
-		vfree(iqueue);
-		iqueue=NULL;
-	}
+	vfree(queue);
+	queue = NULL;
+	vfree(iqueue);
+	iqueue = NULL;
 }



