Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264502AbUFGL5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264502AbUFGL5s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 07:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264642AbUFGL44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 07:56:56 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:65408 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264452AbUFGLzb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 07:55:31 -0400
To: torvalds@osdl.org, akpm@osdl.org, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
Message-Id: <10866093532008@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <10866093531034@twilight.ucw.cz>
Mime-Version: 1.0
Date: Mon, 7 Jun 2004 13:55:53 +0200
Subject: [PATCH 9/39] input: Remove unneeded fields in atkbd structure, convert to bitfields
X-Mailer: gregkh_patchbomb_levon_offspring
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input-for-linus

===================================================================

ChangeSet@1.1371.753.16, 2004-04-23 02:40:08-05:00, dtor_core@ameritech.net
  Input: remove unneeded fields in atkbd structure, convert to bitfields


 atkbd.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

===================================================================

diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	2004-06-07 13:13:04 +02:00
+++ b/drivers/input/keyboard/atkbd.c	2004-06-07 13:13:04 +02:00
@@ -26,7 +26,6 @@
 #include <linux/input.h>
 #include <linux/serio.h>
 #include <linux/workqueue.h>
-#include <linux/timer.h>
 
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@suse.cz>");
 MODULE_DESCRIPTION("AT and PS/2 keyboard driver");
@@ -173,22 +172,23 @@
 	unsigned char keycode[512];
 	struct input_dev dev;
 	struct serio *serio;
-	struct timer_list timer;
+
 	char name[64];
 	char phys[32];
+	unsigned short id;
+	unsigned char set;
+	unsigned int translated:1;
+	unsigned int extra:1;
+	unsigned int write:1;
+
 	unsigned char cmdbuf[4];
 	unsigned char cmdcnt;
-	unsigned char set;
-	unsigned char extra;
-	unsigned char release;
-	int lastkey;
 	volatile signed char ack;
 	unsigned char emul;
-	unsigned short id;
-	unsigned char write;
-	unsigned char translated;
-	unsigned char resend;
-	unsigned char bat_xl;
+	unsigned int resend:1;
+	unsigned int release:1;
+	unsigned int bat_xl:1;
+
 	unsigned int last;
 	unsigned long time;
 };

