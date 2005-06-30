Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263131AbVF3Uf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263131AbVF3Uf7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 16:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263127AbVF3Ufh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 16:35:37 -0400
Received: from mail.dif.dk ([193.138.115.101]:44756 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S263114AbVF3U2r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 16:28:47 -0400
Date: Thu, 30 Jun 2005 22:34:45 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: linux-sound@vger.kernel.org, Paul Laufer <paul@laufernet.com>,
       Hannu Savolainen <hannu@opensound.com>, akpm@osdl.org
Subject: [PATCH] vfree cleanup for sound/oss/sb_card.c
Message-ID: <Pine.LNX.4.62.0506302230450.2858@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vfree can take a NULL pointer, no point in checking.

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 sound/oss/sb_card.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

--- linux-2.6.13-rc1-orig/sound/oss/sb_card.c	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc1/sound/oss/sb_card.c	2005-06-30 22:29:46.000000000 +0200
@@ -337,10 +337,8 @@ static void __exit sb_exit(void)
 	pnp_unregister_card_driver(&sb_pnp_driver);
 #endif
 
-	if (smw_free) {
-		vfree(smw_free);
-		smw_free = NULL;
-	}
+	vfree(smw_free);
+	smw_free = NULL;
 }
 
 module_init(sb_init);


