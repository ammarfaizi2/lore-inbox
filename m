Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270627AbTGZWoR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 18:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270628AbTGZWoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 18:44:17 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:54191 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S270627AbTGZWoN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 18:44:13 -0400
Date: Sun, 27 Jul 2003 00:59:15 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: [PM] Make yenta work
Message-ID: <20030726225915.GA537@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This makes yenta work, and its really trivial...
								Pavel

Index: linux/drivers/pcmcia/yenta_socket.c
===================================================================
--- linux.orig/drivers/pcmcia/yenta_socket.c	2003-07-22 13:39:42.000000000 +0200
+++ linux/drivers/pcmcia/yenta_socket.c	2003-07-17 22:22:58.000000000 +0200
@@ -899,7 +899,10 @@
 
 static int yenta_dev_suspend (struct pci_dev *dev, u32 state)
 {
-	return pcmcia_socket_dev_suspend(&dev->dev, state, 0);
+	/* FIXME: We should really let devices to act on *all* levels :-(.
+	   If you put something else than SUSPEND_SAVE_STATE,
+	   pcmcia_socket_dev_suspend() will simply do nothing due to its check. */
+	return pcmcia_socket_dev_suspend(&dev->dev, state, SUSPEND_SAVE_STATE);
 }
 
 

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
