Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133083AbREHSGT>; Tue, 8 May 2001 14:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133040AbREHSGJ>; Tue, 8 May 2001 14:06:09 -0400
Received: from comverse-in.com ([38.150.222.2]:12234 "EHLO
	eagle.comverse-in.com") by vger.kernel.org with ESMTP
	id <S133083AbREHSGD>; Tue, 8 May 2001 14:06:03 -0400
Message-ID: <6B1DF6EEBA51D31182F200902740436802678EA9@mail-in.comverse-in.com>
From: "Khachaturov, Vassilii" <Vassilii.Khachaturov@comverse.com>
To: "'Pavel Machek'" <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: RE: PCMCIA IDE flash problem found
Date: Tue, 8 May 2001 14:05:04 -0400 
Importance: low
X-Priority: 5
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why did not you take care of the request_region() call and just disabled it?
The ports will be considered free by the system, and another device might 
grab them later on!

Vassilii

-----Original Message-----
From: Pavel Machek [mailto:pavel@suse.cz]
Sent: Tuesday, May 08, 2001 8:14 AM
To: kernel list
Subject: PCMCIA IDE flash problem found


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
