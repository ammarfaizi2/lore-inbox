Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263085AbTIVX4k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 19:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262795AbTIVXyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 19:54:15 -0400
Received: from mail.kroah.org ([65.200.24.183]:18849 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262796AbTIVXbN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 19:31:13 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10642734183644@kroah.com>
Subject: Re: [PATCH] i2c driver fixes for 2.6.0-test5
In-Reply-To: <10642734172743@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 22 Sep 2003 16:30:18 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1153.85.4, 2003/08/27 15:32:44-07:00, hirofumi@mail.parknet.co.jp

[PATCH] DEVICE_NAME_SIZE/_HALF removal (I2C related, but v4l stuff)


 drivers/media/video/msp3400.c |    2 +-
 drivers/media/video/saa5249.c |    2 +-
 drivers/media/video/tuner.c   |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)


diff -Nru a/drivers/media/video/msp3400.c b/drivers/media/video/msp3400.c
--- a/drivers/media/video/msp3400.c	Mon Sep 22 16:16:43 2003
+++ b/drivers/media/video/msp3400.c	Mon Sep 22 16:16:43 2003
@@ -1316,7 +1316,7 @@
 #endif
 	msp3400c_setvolume(c,msp->muted,msp->left,msp->right);
 
-	snprintf(c->name, DEVICE_NAME_SIZE, "MSP34%02d%c-%c%d",
+	snprintf(c->name, I2C_NAME_SIZE, "MSP34%02d%c-%c%d",
 		 (msp->rev2>>8)&0xff, (msp->rev1&0xff)+'@',
 		 ((msp->rev1>>8)&0xff)+'@', msp->rev2&0x1f);
 
diff -Nru a/drivers/media/video/saa5249.c b/drivers/media/video/saa5249.c
--- a/drivers/media/video/saa5249.c	Mon Sep 22 16:16:43 2003
+++ b/drivers/media/video/saa5249.c	Mon Sep 22 16:16:43 2003
@@ -171,7 +171,7 @@
 		return -ENOMEM;
 	}
 	memset(t, 0, sizeof(*t));
-	strlcpy(client->name, IF_NAME, DEVICE_NAME_SIZE);
+	strlcpy(client->name, IF_NAME, I2C_NAME_SIZE);
 	init_MUTEX(&t->lock);
 	
 	/*
diff -Nru a/drivers/media/video/tuner.c b/drivers/media/video/tuner.c
--- a/drivers/media/video/tuner.c	Mon Sep 22 16:16:43 2003
+++ b/drivers/media/video/tuner.c	Mon Sep 22 16:16:43 2003
@@ -824,7 +824,7 @@
 	if (type < TUNERS) {
 		t->type = type;
 		printk("tuner(bttv): type forced to %d (%s) [insmod]\n",t->type,tuners[t->type].name);
-		strlcpy(client->name, tuners[t->type].name, DEVICE_NAME_SIZE);
+		strlcpy(client->name, tuners[t->type].name, I2C_NAME_SIZE);
 	}
         i2c_attach_client(client);
         if (t->type == TUNER_MT2032)
@@ -875,7 +875,7 @@
 		t->type = *iarg;
 		printk("tuner: type set to %d (%s)\n",
                         t->type,tuners[t->type].name);
-		strlcpy(client->name, tuners[t->type].name, DEVICE_NAME_SIZE);
+		strlcpy(client->name, tuners[t->type].name, I2C_NAME_SIZE);
 		if (t->type == TUNER_MT2032)
                         mt2032_init(client);
 		break;

