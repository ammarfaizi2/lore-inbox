Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262398AbUEKGaD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262398AbUEKGaD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 02:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbUEKG3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 02:29:20 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:30840 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262273AbUEKGZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 02:25:07 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 4/9] New set of input patches - 05-twidjoy-fixes.patch
Date: Tue, 11 May 2004 01:05:50 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200405110101.42805.dtor_core@ameritech.net> <200405110104.20283.dtor_core@ameritech.net> <200405110105.08839.dtor_core@ameritech.net>
In-Reply-To: <200405110105.08839.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405110105.58112.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1587.20.6, 2004-05-10 01:30:08-05:00, dtor_core@ameritech.net
  Input: twidjoy module
         - twidjoy_interrupt should return irqreturn_t
         - add MODULE_DESCRIPTION and MODULE_LICENSE


 twidjoy.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)


===================================================================



diff -Nru a/drivers/input/joystick/twidjoy.c b/drivers/input/joystick/twidjoy.c
--- a/drivers/input/joystick/twidjoy.c	Tue May 11 00:56:27 2004
+++ b/drivers/input/joystick/twidjoy.c	Tue May 11 00:56:27 2004
@@ -58,6 +58,9 @@
 #include <linux/serio.h>
 #include <linux/init.h>
 
+MODULE_DESCRIPTION("Handykey Twiddler keyboard as a joystick driver");
+MODULE_LICENSE("GPL");
+
 /*
  * Constants.
  */
@@ -142,7 +145,7 @@
  * packet processing routine.
  */
 
-static void twidjoy_interrupt(struct serio *serio, unsigned char data, unsigned int flags, struc pt_regs *regs)
+static irqreturn_t twidjoy_interrupt(struct serio *serio, unsigned char data, unsigned int flags, struct pt_regs *regs)
 {
 	struct twidjoy *twidjoy = serio->private;
 
@@ -153,7 +156,7 @@
 	if ((data & 0x80) == 0)
 		twidjoy->idx = 0;	/* this byte starts a new packet */
 	else if (twidjoy->idx == 0)
-		return;			/* wrong MSB -- ignore this byte */
+		return IRQ_HANDLED;	/* wrong MSB -- ignore this byte */
 
 	if (twidjoy->idx < TWIDJOY_MAX_LENGTH)
 		twidjoy->data[twidjoy->idx++] = data;
@@ -163,7 +166,7 @@
 		twidjoy->idx = 0;
 	}
 
-	return;
+	return IRQ_HANDLED;
 }
 
 /*
