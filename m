Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264987AbUDUGIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264987AbUDUGIs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 02:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264986AbUDUGIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 02:08:25 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:38828 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264988AbUDUGFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 02:05:45 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 8/15] New set of input patches: atkbd - use bitfields
Date: Wed, 21 Apr 2004 00:57:51 -0500
User-Agent: KMail/1.6.1
Cc: Vojtech Pavlik <vojtech@suse.cz>
References: <200404210049.17139.dtor_core@ameritech.net>
In-Reply-To: <200404210049.17139.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404210057.52989.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1909, 2004-04-20 22:29:12-05:00, dtor_core@ameritech.net
  Input: remove unneeded fields in atkbd structure, convert to bitfields


 atkbd.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)


===================================================================



diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Tue Apr 20 23:08:14 2004
+++ b/drivers/input/keyboard/atkbd.c	Tue Apr 20 23:08:14 2004
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
