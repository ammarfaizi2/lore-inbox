Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264668AbTFAQnR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 12:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264669AbTFAQnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 12:43:17 -0400
Received: from dclient217-162-108-200.hispeed.ch ([217.162.108.200]:46857 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S264668AbTFAQnQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 12:43:16 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Ritz <daniel.ritz@gmx.ch>
Subject: Re: [Bug 762] New: cs4232, cs4236 module loading problem
Date: Sun, 1 Jun 2003 18:56:34 +0200
User-Agent: KMail/1.4.3
To: "linux-kernel" <linux-kernel@vger.kernel.org>, feketga@delfin.klte.hu
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200306011856.34369.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

yaroslav's linux-sound tree has two fixes to cs4236.c, i think they fix the
reported oops. 


rgds
-daniel


--- 1.14/sound/isa/cs423x/cs4236.c	Thu Apr 10 03:28:11 2003
+++ 1.15/sound/isa/cs423x/cs4236.c	Fri Apr 11 04:37:55 2003
@@ -590,6 +590,9 @@
 	cards += pnp_register_card_driver(&cs423x_pnpc_driver);
 #endif
        if (!cards) {
+#ifdef CONFIG_PNP
+		pnp_unregister_card_driver(&cs423x_pnpc_driver);
+#endif
 #ifdef MODULE
 		printk(KERN_ERR IDENT " soundcard not found or device busy\n");
 #endif


--- 1.15/sound/isa/cs423x/cs4236.c	Fri Apr 11 04:37:55 2003
+++ 1.16/sound/isa/cs423x/cs4236.c	Tue May 20 14:13:00 2003
@@ -365,7 +365,6 @@
 			snd_printk(KERN_ERR IDENT " MPU401 PnP manual resources are invalid, using auto config\n");
 		err = pnp_activate_dev(pdev);
 		if (err < 0) {
-			kfree(cfg);
 			printk(KERN_ERR IDENT " MPU401 PnP configure failed for WSS (out of resources?)\n");
 			mpu_port[dev] = SNDRV_AUTO_PORT;
 			mpu_irq[dev] = SNDRV_AUTO_IRQ;
@@ -382,7 +381,7 @@
 	kfree(cfg);
 	return 0;
 }
-#endif
+#endif /* CONFIG_PNP */
 
 static void snd_card_cs4236_free(snd_card_t *card)
 {


