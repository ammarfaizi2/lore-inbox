Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266407AbSKKLwl>; Mon, 11 Nov 2002 06:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266409AbSKKLwl>; Mon, 11 Nov 2002 06:52:41 -0500
Received: from pop.gmx.net ([213.165.64.20]:24813 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S266407AbSKKLwk>;
	Mon, 11 Nov 2002 06:52:40 -0500
Message-ID: <3DCF9B7D.3030406@gmx.net>
Date: Mon, 11 Nov 2002 12:58:53 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2002-Q4@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: de, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] restore framebuffer console after suspend
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------040202080100020008020904"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040202080100020008020904
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Marcelo,

this patch fixes the case when a laptop was suspended and resumed while a 
framebuffer console was active, the console would not be redrawn.

After a discussion with Benjamin Herrenschmidt, we both agree that this 
patch is the best solution. It is the same as my first patch with this 
subject, just resent because there was some confusion about which patch was 
best.

Please apply for 2.4.20-rc2.

Thanks
Carl-Daniel

--------------040202080100020008020904
Content-Type: text/plain;
 name="patch-fbdev.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-fbdev.txt"

diff -Naur linux.orig/drivers/video/fbcon.c linux/drivers/video/fbcon.c
--- linux.orig/drivers/video/fbcon.c	Thu Sep 12 17:22:35 2002
+++ linux/drivers/video/fbcon.c	Fri Nov  8 13:09:41 2002
@@ -1571,10 +1571,6 @@ static int fbcon_blank(struct vc_data *c
 
     if (blank < 0)	/* Entering graphics mode */
 	return 0;
-#ifdef CONFIG_PM
-    if (fbcon_sleeping)
-    	return 0;
-#endif /* CONFIG_PM */
 
     fbcon_cursor(p->conp, blank ? CM_ERASE : CM_DRAW);
 

--------------040202080100020008020904--

