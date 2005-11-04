Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbVKDMfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbVKDMfp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 07:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbVKDMfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 07:35:45 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:56074 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932138AbVKDMfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 07:35:45 -0500
Date: Fri, 4 Nov 2005 13:35:41 +0100
From: Adrian Bunk <bunk@stusta.de>
To: vojtech@suse.cz
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       linux-joystick@atrey.karlin.mff.cuni.cz
Subject: [2.6 patch] drivers/input/: possible cleanups
Message-ID: <20051104123541.GC5587@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make needlessly glbal code static
- gameport/gameport: #if 0 the unused global function gameport_reconnect


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/input/gameport/gameport.c |    2 ++
 drivers/input/joystick/twidjoy.c  |    4 ++--
 drivers/input/touchscreen/mk712.c |    2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

--- linux-2.6.14-rc5-mm1-full/drivers/input/joystick/twidjoy.c.old	2005-11-04 11:37:38.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/input/joystick/twidjoy.c	2005-11-04 11:38:01.000000000 +0100
@@ -265,13 +265,13 @@
  * The functions for inserting/removing us as a module.
  */
 
-int __init twidjoy_init(void)
+static int __init twidjoy_init(void)
 {
 	serio_register_driver(&twidjoy_drv);
 	return 0;
 }
 
-void __exit twidjoy_exit(void)
+static void __exit twidjoy_exit(void)
 {
 	serio_unregister_driver(&twidjoy_drv);
 }
--- linux-2.6.14-rc5-mm1-full/drivers/input/touchscreen/mk712.c.old	2005-11-04 11:38:20.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/input/touchscreen/mk712.c	2005-11-04 11:38:29.000000000 +0100
@@ -154,7 +154,7 @@
 	spin_unlock_irqrestore(&mk712_lock, flags);
 }
 
-int __init mk712_init(void)
+static int __init mk712_init(void)
 {
 	int err;
 
--- linux-2.6.14-rc5-mm1-full/drivers/input/gameport/gameport.c.old	2005-11-04 11:38:52.000000000 +0100
+++ linux-2.6.14-rc5-mm1-full/drivers/input/gameport/gameport.c	2005-11-04 11:39:32.000000000 +0100
@@ -637,10 +637,12 @@
 	gameport_queue_event(gameport, NULL, GAMEPORT_RESCAN);
 }
 
+#if 0
 void gameport_reconnect(struct gameport *gameport)
 {
 	gameport_queue_event(gameport, NULL, GAMEPORT_RECONNECT);
 }
+#endif  /*  0  */
 
 /*
  * Submits register request to kgameportd for subsequent execution.

