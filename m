Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263084AbVF3Uev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263084AbVF3Uev (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 16:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263118AbVF3Udq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 16:33:46 -0400
Received: from mail.dif.dk ([193.138.115.101]:64724 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S263137AbVF3UdE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 16:33:04 -0400
Date: Thu, 30 Jun 2005 22:39:01 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Veliath <andrewtv@usa.net>, linux-sound@vger.kernel.org,
       akpm@osdl.org
Subject: [PATCH] vfree can handle NULL (sound/oss/msnd.c)
Message-ID: <Pine.LNX.4.62.0506302236250.2858@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing wrong in handing vfree a NULL pointer.

 sound/oss/msnd.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

--- linux-2.6.13-rc1-orig/sound/oss/msnd.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc1/sound/oss/msnd.c	2005-06-30 22:35:41.000000000 +0200
@@ -96,10 +96,8 @@ void msnd_fifo_init(msnd_fifo *f)
 
 void msnd_fifo_free(msnd_fifo *f)
 {
-	if (f->data) {
-		vfree(f->data);
-		f->data = NULL;
-	}
+	vfree(f->data);
+	f->data = NULL;
 }
 
 int msnd_fifo_alloc(msnd_fifo *f, size_t n)


