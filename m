Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263192AbTDCAD6>; Wed, 2 Apr 2003 19:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263198AbTDCADQ>; Wed, 2 Apr 2003 19:03:16 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:10374 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263209AbTDCACN> convert rfc822-to-8bit; Wed, 2 Apr 2003 19:02:13 -0500
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1049328957515@kroah.com>
Subject: [PATCH] More i2c driver changes for 2.5.66
In-Reply-To: <20030403001456.GA4973@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 2 Apr 2003 16:15:57 -0800
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.977.29.1, 2003/03/25 17:22:33-08:00, j.dittmer@portrix.net

[PATCH] i2c: fix compile bugs in tvmixer.c

Additionally I need the following patch to tvmixer.c to compile properly
with CONFIG_SOUND_TVMIXER=m. Just a /client->name/client->dev.name/g.


 drivers/media/video/tvmixer.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)


diff -Nru a/drivers/media/video/tvmixer.c b/drivers/media/video/tvmixer.c
--- a/drivers/media/video/tvmixer.c	Wed Apr  2 16:02:10 2003
+++ b/drivers/media/video/tvmixer.c	Wed Apr  2 16:02:10 2003
@@ -87,7 +87,7 @@
         if (cmd == SOUND_MIXER_INFO) {
                 mixer_info info;
                 strncpy(info.id, "tv card", sizeof(info.id));
-                strncpy(info.name, client->name, sizeof(info.name));
+                strncpy(info.name, client->dev.name, sizeof(info.name));
                 info.modify_counter = 42 /* FIXME */;
                 if (copy_to_user((void *)arg, &info, sizeof(info)))
                         return -EFAULT;
@@ -96,7 +96,7 @@
         if (cmd == SOUND_OLD_MIXER_INFO) {
                 _old_mixer_info info;
                 strncpy(info.id, "tv card", sizeof(info.id));
-                strncpy(info.name, client->name, sizeof(info.name));
+                strncpy(info.name, client->dev.name, sizeof(info.name));
                 if (copy_to_user((void *)arg, &info, sizeof(info)))
                         return -EFAULT;
                 return 0;
@@ -237,7 +237,7 @@
 	int i;
 
 	if (debug)
-		printk("tvmixer: adapter %s\n",adap->name);
+		printk("tvmixer: adapter %s\n",adap->dev.name);
 	for (i=0; i<I2C_CLIENT_MAX; i++) {
 		if (!adap->clients[i])
 			continue;
@@ -261,10 +261,10 @@
 		/* ignore that one */
 		if (debug)
 			printk("tvmixer: %s is not a tv card\n",
-			       client->adapter->name);
+			       client->adapter->dev.name);
 		return -1;
 	}
-	printk("tvmixer: debug: %s\n",client->name);
+	printk("tvmixer: debug: %s\n",client->dev.name);
 
 	/* unregister ?? */
 	for (i = 0; i < DEV_MAX; i++) {
@@ -273,7 +273,7 @@
 			unregister_sound_mixer(devices[i].minor);
 			devices[i].dev = NULL;
 			devices[i].minor = -1;
-			printk("tvmixer: %s unregistered (#1)\n",client->name);
+			printk("tvmixer: %s unregistered (#1)\n",client->dev.name);
 			return 0;
 		}
 	}
@@ -298,13 +298,13 @@
 	if (0 != client->driver->command(client,VIDIOCGAUDIO,&va)) {
 		if (debug)
 			printk("tvmixer: %s: VIDIOCGAUDIO failed\n",
-			       client->name);
+			       client->dev.name);
 		return -1;
 	}
 	if (0 == (va.flags & VIDEO_AUDIO_VOLUME)) {
 		if (debug)
 			printk("tvmixer: %s: has no volume control\n",
-			       client->name);
+			       client->dev.name);
 		return -1;
 	}
 
@@ -318,7 +318,7 @@
 	devices[i].count = 0;
 	devices[i].dev   = client;
 	printk("tvmixer: %s (%s) registered with minor %d\n",
-	       client->name,client->adapter->name,minor);
+	       client->dev.name,client->adapter->dev.name,minor);
 	
 	return 0;
 }
@@ -344,7 +344,7 @@
 		if (devices[i].minor != -1) {
 			unregister_sound_mixer(devices[i].minor);
 			printk("tvmixer: %s unregistered (#2)\n",
-			       devices[i].dev->name);
+			       devices[i].dev->dev.name);
 		}
 	}
 }

