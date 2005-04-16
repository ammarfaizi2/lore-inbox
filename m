Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262696AbVDPQRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262696AbVDPQRp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 12:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262695AbVDPQRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 12:17:45 -0400
Received: from mail.dif.dk ([193.138.115.101]:16832 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262694AbVDPQRk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 12:17:40 -0400
Date: Sat, 16 Apr 2005 18:20:30 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Joshua Thompson <funaho@jurai.org>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Roman Zippel <zippel@linux-m68k.org>, linuxppc-dev@ozlabs.org,
       linux-m68k@lists.linux-m68k.org
Subject: [PATCH] drivers/macintosh: Remove redundant NULL check before kfree
Message-ID: <Pine.LNX.4.62.0504161801580.2480@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Amavis-Alert: BAD HEADER Improper folded header field made up entirely of whitespace in message header 'Subject':    
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes a redundant NULL check before kfree() - kfree handles 
NULL pointers just fine so there's no need to check first.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
---

 drivers/macintosh/adbhid.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)


--- linux-2.6.12-rc2-mm3-orig/drivers/macintosh/adbhid.c	2005-03-02 08:38:33.000000000 +0100
+++ linux-2.6.12-rc2-mm3/drivers/macintosh/adbhid.c	2005-04-16 18:00:10.000000000 +0200
@@ -806,8 +806,7 @@ adbhid_input_register(int id, int defaul
 static void adbhid_input_unregister(int id)
 {
 	input_unregister_device(&adbhid[id]->input);
-	if (adbhid[id]->keycode)
-		kfree(adbhid[id]->keycode);
+	kfree(adbhid[id]->keycode);
 	kfree(adbhid[id]);
 	adbhid[id] = NULL;
 }



-- 
Jesper Juhl

PS. Sorry about the long CC list, but I was unsure who to send this to.
Please CC me on replies.



