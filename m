Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261861AbRE0MAt>; Sun, 27 May 2001 08:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261894AbRE0MAj>; Sun, 27 May 2001 08:00:39 -0400
Received: from tes4.tesnetwork.cz ([194.213.206.4]:26124 "EHLO
	server.tesnetwork.cz") by vger.kernel.org with ESMTP
	id <S261861AbRE0MA3>; Sun, 27 May 2001 08:00:29 -0400
Message-ID: <3B111566.6070507@centrum.cz>
Date: Sun, 27 May 2001 13:55:34 -0100
From: Jan Sembera <sembera@centrum.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5 i686; en-US; rv:0.9) Gecko/20010507
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH][2.4.5] buz.c compile errors
Content-Type: multipart/mixed;
 boundary="------------030800010305050409010201"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030800010305050409010201
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I have written a patch for buz.c for 2.4.5, it should be solution, but i 
don't know it really works, I don't have such hardware available.

Jan Sembera


--------------030800010305050409010201
Content-Type: text/plain;
 name="patch1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch1"

--- linux/drivers/media/video/buz.c.orig	Sat May 26 23:56:26 2001
+++ linux/drivers/media/video/buz.c	Sun May 27 00:02:09 2001
@@ -146,7 +146,7 @@
 
 static int default_input;	/* 0=Composite (default), 1=S-VHS */
 static int default_norm;	/* 0=PAL (default), 1=NTSC */
-
+static int video_nr = -1;
 MODULE_PARM(vidmem, "i");
 MODULE_PARM(triton, "i");
 MODULE_PARM(natoma, "i");
@@ -154,6 +154,7 @@
 MODULE_PARM(v4l_bufsize, "i");
 MODULE_PARM(default_input, "i");
 MODULE_PARM(default_norm, "i");
+MODULE_PARM(video_nr, "i");
 
 /* Anybody who uses more than four? */
 #define BUZ_MAX 4
@@ -3212,7 +3213,7 @@
 	 */
 	memcpy(&zr->video_dev, &zoran_template, sizeof(zoran_template));
 	sprintf(zr->video_dev.name, "zoran%u", zr->id);
-	if (video_register_device(&zr->video_dev, VFL_TYPE_GRABBER) < 0) {
+	if (video_register_device(&zr->video_dev, VFL_TYPE_GRABBER, video_nr) < 0) {
 		i2c_unregister_bus(&zr->i2c);
 		kfree((void *) zr->stat_com);
 		return -1;


--------------030800010305050409010201
Content-Type: text/plain;
 name="patch2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch2"

--- linux/drivers/media/video/buz.h.orig	Sat May 26 23:56:30 2001
+++ linux/drivers/media/video/buz.h	Sun May 27 00:01:58 2001
@@ -36,6 +36,12 @@
 
 #define XAWTV_HACK
 
+/* I'm not sure if this is correct value or not, I cannot test it, because
+   I don't have this piece of hardware and is only value I was able to 
+   get (from 2.2.19). */
+
+#define KMALLOC_MAXSIZE (512*1024)
+
 #ifdef XAWTV_HACK
 #define   BUZ_MAX_WIDTH   768	/* never display more than 768 pixels */
 #else


--------------030800010305050409010201--

