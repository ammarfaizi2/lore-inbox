Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267798AbTGHWgu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 18:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265426AbTGHWgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 18:36:49 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:36756 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S267798AbTGHWep (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 18:34:45 -0400
Date: Wed, 9 Jul 2003 00:41:47 +0200
From: Pavel Machek <pavel@ucw.cz>
To: dahinds@users.sourceforge.net, kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>
Subject: Fix suspend/resume with yenta
Message-ID: <20030708224146.GA140@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes suspend/resume with yenta active. Please apply,

(it is trivial after you look at pcmcia_socket_dev_suspend ;-).

							Pavel

--- clean/drivers/pcmcia/yenta_socket.c	2003-07-06 20:07:39.000000000 +0200
+++ linux/drivers/pcmcia/yenta_socket.c	2003-07-09 00:30:21.000000000 +0200
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
