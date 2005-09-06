Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965027AbVIFBHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965027AbVIFBHB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 21:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965037AbVIFBHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 21:07:01 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:21395 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S965027AbVIFBHA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 21:07:00 -0400
Date: Tue, 6 Sep 2005 02:06:57 +0100
From: viro@ZenIV.linux.org.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [PATCH] iomem annotations (sound/arm/aaci)
Message-ID: <20050906010657.GS5155@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC13-git5-sunsu/sound/arm/aaci.c RC13-git5-aaci/sound/arm/aaci.c
--- RC13-git5-sunsu/sound/arm/aaci.c	2005-08-28 23:09:50.000000000 -0400
+++ RC13-git5-aaci/sound/arm/aaci.c	2005-09-05 16:41:09.000000000 -0400
@@ -821,7 +821,7 @@
 
 static unsigned int __devinit aaci_size_fifo(struct aaci *aaci)
 {
-	void *base = aaci->base + AACI_CSCH1;
+	void __iomem *base = aaci->base + AACI_CSCH1;
 	int i;
 
 	writel(TXCR_FEN | TXCR_TSZ16 | TXCR_TXEN, base + AACI_TXCR);
@@ -877,7 +877,7 @@
 	aaci->playback.fifo = aaci->base + AACI_DR1;
 
 	for (i = 0; i < 4; i++) {
-		void *base = aaci->base + i * 0x14;
+		void __iomem *base = aaci->base + i * 0x14;
 
 		writel(0, base + AACI_IE);
 		writel(0, base + AACI_TXCR);
diff -urN RC13-git5-sunsu/sound/arm/aaci.h RC13-git5-aaci/sound/arm/aaci.h
--- RC13-git5-sunsu/sound/arm/aaci.h	2005-08-28 23:09:50.000000000 -0400
+++ RC13-git5-aaci/sound/arm/aaci.h	2005-09-05 16:41:09.000000000 -0400
@@ -200,8 +200,8 @@
 
 
 struct aaci_runtime {
-	void			*base;
-	void			*fifo;
+	void			__iomem *base;
+	void			__iomem *fifo;
 
 	struct ac97_pcm		*pcm;
 	int			pcm_open;
@@ -223,7 +223,7 @@
 struct aaci {
 	struct amba_device	*dev;
 	snd_card_t		*card;
-	void			*base;
+	void			__iomem *base;
 	unsigned int		fifosize;
 
 	/* AC'97 */
