Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262703AbUCOT3c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 14:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262732AbUCOT1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 14:27:44 -0500
Received: from delerium.kernelslacker.org ([81.187.208.145]:12764 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S262703AbUCOT1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 14:27:24 -0500
Date: Mon, 15 Mar 2004 19:27:06 GMT
Message-Id: <200403151927.i2FJR6Y5015700@delerium.codemonkey.org.uk>
From: davej@redhat.com
To: linux-kernel@vger.kernel.org
Subject: [ALSA][4/6] es968 double free.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This oopses on rmmod, as we do pnp_unregister_card_driver twice.

		Dave

--- linux-2.6.4/sound/isa/sb/es968.c~	2004-03-15 18:11:42.000000000 +0000
+++ linux-2.6.4/sound/isa/sb/es968.c	2004-03-15 18:18:27.000000000 +0000
@@ -226,13 +226,10 @@
 static int __init alsa_card_es968_init(void)
 {
 	int res = pnp_register_card_driver(&es968_pnpc_driver);
-	if (res == 0)
-	{
-		pnp_unregister_card_driver(&es968_pnpc_driver);
 #ifdef MODULE
+	if (res == 0)
 		snd_printk(KERN_ERR "no ES968 based soundcards found\n");
 #endif
-	}
 	return res < 0 ? res : 0;
 }
 
