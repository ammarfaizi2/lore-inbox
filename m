Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133068AbREHRhO>; Tue, 8 May 2001 13:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133023AbREHRgz>; Tue, 8 May 2001 13:36:55 -0400
Received: from [194.213.32.137] ([194.213.32.137]:260 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S133018AbREHRgs>;
	Tue, 8 May 2001 13:36:48 -0400
Message-ID: <20010508141417.A128@bug.ucw.cz>
Date: Tue, 8 May 2001 14:14:17 +0200
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: PCMCIA IDE flash problem found
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

2.4.[123] changed name of ide-cs module, which means your pcmcia setup
breaks... This is how to undo the damage. Works for me, do *not* apply
into anything official.

								Pavel

--- clean/drivers/ide/ide-cs.c	Sun Apr  1 00:23:29 2001
+++ linux/drivers/ide/ide-cs.c	Tue May  8 14:06:09 2001
@@ -95,7 +96,7 @@
 static int ide_event(event_t event, int priority,
 		     event_callback_args_t *args);
 
-static dev_info_t dev_info = "ide-cs";
+static dev_info_t dev_info = "ide_cs";
 
 static dev_link_t *ide_attach(void);
 static void ide_detach(dev_link_t *);
@@ -388,9 +389,12 @@
 	MOD_DEC_USE_COUNT;
     }
 
+#if 0
     request_region(link->io.BasePort1, link->io.NumPorts1,"ide-cs");
     if (link->io.NumPorts2)
 	request_region(link->io.BasePort2, link->io.NumPorts2,"ide-cs");
+#endif
+    printk("Should call request_region\n");
     
     info->ndev = 0;
     link->dev = NULL;

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
