Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263845AbUDVHrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263845AbUDVHrc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 03:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263819AbUDVHpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 03:45:45 -0400
Received: from [194.89.250.117] ([194.89.250.117]:14482 "EHLO
	kimputer.holviala.com") by vger.kernel.org with ESMTP
	id S263834AbUDVHo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 03:44:59 -0400
From: Kim Holviala <kim@holviala.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] psmouse: fix mouse hotplugging
Date: Thu, 22 Apr 2004 10:44:56 +0300
User-Agent: KMail/1.6.1
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, vojtech@suse.cz
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404221044.56294.kim@holviala.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Note to myself: make small patches not big confusing ones.

This patch fixes hotplugging of PS/2 devices on hardware which don't
support hotplugging of PS/2 devices. In other words, most desktop machines.
Applies to at least 2.6.5, 2.6.6, 2.6.6-rc2 and 2.6.6-rc2-mm1.



Kim




--- linux-2.6.6-rc2/drivers/input/mouse/psmouse-base.c	2004-04-21 13:35:43.000000000 +0300
+++ linux-2.6.6-rc2-kim/drivers/input/mouse/psmouse-base.c	2004-04-21 13:50:16.753975235 +0300
@@ -470,7 +470,7 @@
  * Then we reset and disable the mouse so that it doesn't generate events.
  */
 
-	if (psmouse_command(psmouse, NULL, PSMOUSE_CMD_RESET_DIS))
+	if (psmouse_reset(psmouse))
 		printk(KERN_WARNING "psmouse.c: Failed to reset mouse on %s\n", psmouse->serio->phys);
 
 /*
