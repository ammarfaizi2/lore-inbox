Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262723AbTCJEyS>; Sun, 9 Mar 2003 23:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262722AbTCJExp>; Sun, 9 Mar 2003 23:53:45 -0500
Received: from dhcp024-209-039-102.neo.rr.com ([24.209.39.102]:9602 "EHLO
	neo.rr.com") by vger.kernel.org with ESMTP id <S262723AbTCJEwj>;
	Sun, 9 Mar 2003 23:52:39 -0500
Date: Mon, 10 Mar 2003 00:07:24 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Changes for 2.5.64
Message-ID: <20030310000724.GE2118@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>,
	linux-kernel@vger.kernel.org
References: <20030310000521.GA2118@neo.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030310000521.GA2118@neo.rr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1082  -> 1.1083 
#	 sound/oss/sb_card.c	1.15    -> 1.16   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/09	ambx1@neo.rr.com	1.1083
# OSS SB driver Updates
# 
# Compatibility update for the latest changes.
# --------------------------------------------
#
diff -Nru a/sound/oss/sb_card.c b/sound/oss/sb_card.c
--- a/sound/oss/sb_card.c	Sun Mar  9 23:47:34 2003
+++ b/sound/oss/sb_card.c	Sun Mar  9 23:47:34 2003
@@ -252,14 +252,14 @@
 	       "dma=%d, dma16=%d\n", scc->conf.io_base, scc->conf.irq,
 	       scc->conf.dma, scc->conf.dma2);
 
-	pnpc_set_drvdata(card, scc);
+	pnp_set_card_drvdata(card, scc);
 
 	return sb_register_oss(scc, &sbmo);
 }
 
 static void sb_pnp_remove(struct pnp_card *card)
 {
-	struct sb_card_config *scc = pnpc_get_drvdata(card);
+	struct sb_card_config *scc = pnp_get_card_drvdata(card);
 
 	if(!scc)
 		return;
@@ -269,7 +269,7 @@
 	sb_unload(scc);
 }
 
-static struct pnpc_driver sb_pnp_driver = {
+static struct pnp_card_driver sb_pnp_driver = {
 	.name          = "OSS SndBlstr", /* 16 character limit */
 	.id_table      = sb_pnp_card_table,
 	.probe         = sb_pnp_probe,
@@ -295,7 +295,7 @@
 
 #ifdef CONFIG_PNP_CARD
 	if(pnp) {
-		pres = pnpc_register_driver(&sb_pnp_driver);
+		pres = pnp_register_card_driver(&sb_pnp_driver);
 	}
 #endif
 	printk(KERN_INFO "sb: Init: Done\n");
@@ -316,7 +316,7 @@
 	}
 
 #ifdef CONFIG_PNP_CARD
-	pnpc_unregister_driver(&sb_pnp_driver);
+	pnp_unregister_card_driver(&sb_pnp_driver);
 #endif
 
 	if (smw_free) {
