Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbTJ3AvN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 19:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbTJ3AvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 19:51:13 -0500
Received: from mail.kroah.org ([65.200.24.183]:42932 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262015AbTJ3AvJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 19:51:09 -0500
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10674750383605@kroah.com>
Subject: Re: [PATCH] fixes for 2.6.0-test9
In-Reply-To: <10674750381029@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 29 Oct 2003 16:50:38 -0800
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1385, 2003/10/29 16:04:38-08:00, greg@kroah.com

[PATCH] I2C: remove some MOD_INC and MOD_DEC usages that are not needed anymore.


 drivers/media/video/bt832.c      |    2 --
 drivers/media/video/saa5249.c    |    2 --
 drivers/media/video/tuner-3036.c |    2 --
 3 files changed, 6 deletions(-)


diff -Nru a/drivers/media/video/bt832.c b/drivers/media/video/bt832.c
--- a/drivers/media/video/bt832.c	Wed Oct 29 16:45:13 2003
+++ b/drivers/media/video/bt832.c	Wed Oct 29 16:45:13 2003
@@ -187,7 +187,6 @@
         t->client.data = t;
         i2c_attach_client(&t->client);
 
-	MOD_INC_USE_COUNT;
 	if(! bt832_init(&t->client)) {
 		bt832_detach(&t->client);
 		return -1;
@@ -210,7 +209,6 @@
 	printk("bt832: detach.\n");
 	i2c_detach_client(client);
 	kfree(t);
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
diff -Nru a/drivers/media/video/saa5249.c b/drivers/media/video/saa5249.c
--- a/drivers/media/video/saa5249.c	Wed Oct 29 16:45:13 2003
+++ b/drivers/media/video/saa5249.c	Wed Oct 29 16:45:13 2003
@@ -214,7 +214,6 @@
 	}
 	t->client = client;
 	i2c_attach_client(client);
-	MOD_INC_USE_COUNT;
 	return 0;
 }
 
@@ -237,7 +236,6 @@
 	kfree(vd->priv);
 	kfree(vd);
 	kfree(client);
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
diff -Nru a/drivers/media/video/tuner-3036.c b/drivers/media/video/tuner-3036.c
--- a/drivers/media/video/tuner-3036.c	Wed Oct 29 16:45:13 2003
+++ b/drivers/media/video/tuner-3036.c	Wed Oct 29 16:45:13 2003
@@ -134,7 +134,6 @@
 	printk("tuner: SAB3036 found, status %02x\n", tuner_getstatus(client));
 
         i2c_attach_client(client);
-	MOD_INC_USE_COUNT;
 
 	if (i2c_master_send(client, buffer, 2) != 2)
 		printk("tuner: i2c i/o error 1\n");
@@ -148,7 +147,6 @@
 static int 
 tuner_detach(struct i2c_client *c)
 {
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 

