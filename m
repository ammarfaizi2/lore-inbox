Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264578AbUFGM1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264578AbUFGM1Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 08:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264582AbUFGMZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 08:25:29 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:13441 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264578AbUFGL4T convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 07:56:19 -0400
To: torvalds@osdl.org, akpm@osdl.org, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
Message-Id: <1086609354864@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <10866093541635@twilight.ucw.cz>
Mime-Version: 1.0
Date: Mon, 7 Jun 2004 13:55:54 +0200
Subject: [PATCH 26/39] input: Twidjoy module fixes
X-Mailer: gregkh_patchbomb_levon_offspring
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input-for-linus

===================================================================

ChangeSet@1.1587.27.6, 2004-05-10 01:30:08-05:00, dtor_core@ameritech.net
  Input: twidjoy module
         - twidjoy_interrupt should return irqreturn_t
         - add MODULE_DESCRIPTION and MODULE_LICENSE


 twidjoy.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

===================================================================

diff -Nru a/drivers/input/joystick/twidjoy.c b/drivers/input/joystick/twidjoy.c
--- a/drivers/input/joystick/twidjoy.c	2004-06-07 13:11:29 +02:00
+++ b/drivers/input/joystick/twidjoy.c	2004-06-07 13:11:29 +02:00
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

