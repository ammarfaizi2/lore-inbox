Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261292AbSLPTTo>; Mon, 16 Dec 2002 14:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261295AbSLPTTo>; Mon, 16 Dec 2002 14:19:44 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:40401 "HELO atlrel9.hp.com")
	by vger.kernel.org with SMTP id <S261292AbSLPTTn>;
	Mon, 16 Dec 2002 14:19:43 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Bjorn Helgaas <bjorn_helgaas@hp.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [PATCH] joydev: fix HZ->millisecond transformation
Date: Mon, 16 Dec 2002 12:27:38 -0700
User-Agent: KMail/1.4.3
Cc: vojtech@ucw.cz, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200212161227.38764.bjorn_helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* fix a problem with HZ->millisecond transformation on
  non-x86 archs (from 2.5 change by vojtech@suse.cz)

Applies to 2.4.20.

diff -Nru a/drivers/input/joydev.c b/drivers/input/joydev.c
--- a/drivers/input/joydev.c	Mon Dec 16 12:16:32 2002
+++ b/drivers/input/joydev.c	Mon Dec 16 12:16:32 2002
@@ -50,6 +50,8 @@
 #define JOYDEV_MINORS		32
 #define JOYDEV_BUFFER_SIZE	64
 
+#define MSECS(t)	(1000 * ((t) / HZ) + 1000 * ((t) % HZ) / HZ)
+
 struct joydev {
 	int exist;
 	int open;
@@ -134,7 +136,7 @@
 			return;
 	}  
 
-	event.time = jiffies * (1000 / HZ);
+	event.time = MSECS(jiffies);
 
 	while (list) {
 
@@ -279,7 +281,7 @@
 
 		struct js_event event;
 
-		event.time = jiffies * (1000/HZ);
+		event.time = MSECS(jiffies);
 
 		if (list->startup < joydev->nkey) {
 			event.type = JS_EVENT_BUTTON | JS_EVENT_INIT;

