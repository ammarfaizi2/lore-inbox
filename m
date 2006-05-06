Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWEFLMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWEFLMt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 07:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWEFLMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 07:12:49 -0400
Received: from tim.rpsys.net ([194.106.48.114]:20944 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1750767AbWEFLMp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 07:12:45 -0400
Subject: [PATCH] Input: Change from numbered to named switches
From: Richard Purdie <rpurdie@rpsys.net>
To: dtor_core@ameritech.net
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@suse.cz>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-input@atrey.karlin.mff.cuni.cz,
       Benjamin Berg <benjamin@sipsolutions.net>,
       Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain
Date: Sat, 06 May 2006 12:12:24 +0100
Message-Id: <1146913945.6237.47.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the numbered SW_* entries from the input system and assign names
to the existing users.

Signed-off-by: Richard Purdie <rpurdie@rpsys.net>

Index: git/drivers/input/keyboard/corgikbd.c
===================================================================
--- git.orig/drivers/input/keyboard/corgikbd.c	2006-05-04 23:12:56.000000000 +0100
+++ git/drivers/input/keyboard/corgikbd.c	2006-05-05 16:21:45.000000000 +0100
@@ -245,9 +245,9 @@
 		if (hinge_count >= HINGE_STABLE_COUNT) {
 			spin_lock_irqsave(&corgikbd_data->lock, flags);
 
-			input_report_switch(corgikbd_data->input, SW_0, ((sharpsl_hinge_state & CORGI_SCP_SWA) != 0));
-			input_report_switch(corgikbd_data->input, SW_1, ((sharpsl_hinge_state & CORGI_SCP_SWB) != 0));
-			input_report_switch(corgikbd_data->input, SW_2, (READ_GPIO_BIT(CORGI_GPIO_AK_INT) != 0));
+			input_report_switch(corgikbd_data->input, SW_LID, ((sharpsl_hinge_state & CORGI_SCP_SWA) != 0));
+			input_report_switch(corgikbd_data->input, SW_TABLET_MODE, ((sharpsl_hinge_state & CORGI_SCP_SWB) != 0));
+			input_report_switch(corgikbd_data->input, SW_HEADPHONE_INSERT, (READ_GPIO_BIT(CORGI_GPIO_AK_INT) != 0));
 			input_sync(corgikbd_data->input);
 
 			spin_unlock_irqrestore(&corgikbd_data->lock, flags);
@@ -340,9 +340,9 @@
 	for (i = 0; i < ARRAY_SIZE(corgikbd_keycode); i++)
 		set_bit(corgikbd->keycode[i], input_dev->keybit);
 	clear_bit(0, input_dev->keybit);
-	set_bit(SW_0, input_dev->swbit);
-	set_bit(SW_1, input_dev->swbit);
-	set_bit(SW_2, input_dev->swbit);
+	set_bit(SW_LID, input_dev->swbit);
+	set_bit(SW_TABLET_MODE, input_dev->swbit);
+	set_bit(SW_HEADPHONE_INSERT, input_dev->swbit);
 
 	input_register_device(corgikbd->input);
 
Index: git/drivers/input/keyboard/spitzkbd.c
===================================================================
--- git.orig/drivers/input/keyboard/spitzkbd.c	2006-05-04 23:12:57.000000000 +0100
+++ git/drivers/input/keyboard/spitzkbd.c	2006-05-05 16:17:35.000000000 +0100
@@ -299,9 +299,9 @@
 	if (hinge_count >= HINGE_STABLE_COUNT) {
 		spin_lock_irqsave(&spitzkbd_data->lock, flags);
 
-		input_report_switch(spitzkbd_data->input, SW_0, ((GPLR(SPITZ_GPIO_SWA) & GPIO_bit(SPITZ_GPIO_SWA)) != 0));
-		input_report_switch(spitzkbd_data->input, SW_1, ((GPLR(SPITZ_GPIO_SWB) & GPIO_bit(SPITZ_GPIO_SWB)) != 0));
-		input_report_switch(spitzkbd_data->input, SW_2, ((GPLR(SPITZ_GPIO_AK_INT) & GPIO_bit(SPITZ_GPIO_AK_INT)) != 0));
+		input_report_switch(spitzkbd_data->input, SW_LID, ((GPLR(SPITZ_GPIO_SWA) & GPIO_bit(SPITZ_GPIO_SWA)) != 0));
+		input_report_switch(spitzkbd_data->input, SW_TABLET_MODE, ((GPLR(SPITZ_GPIO_SWB) & GPIO_bit(SPITZ_GPIO_SWB)) != 0));
+		input_report_switch(spitzkbd_data->input, SW_HEADPHONE_INSERT, ((GPLR(SPITZ_GPIO_AK_INT) & GPIO_bit(SPITZ_GPIO_AK_INT)) != 0));
 		input_sync(spitzkbd_data->input);
 
 		spin_unlock_irqrestore(&spitzkbd_data->lock, flags);
@@ -398,9 +398,9 @@
 	for (i = 0; i < ARRAY_SIZE(spitzkbd_keycode); i++)
 		set_bit(spitzkbd->keycode[i], input_dev->keybit);
 	clear_bit(0, input_dev->keybit);
-	set_bit(SW_0, input_dev->swbit);
-	set_bit(SW_1, input_dev->swbit);
-	set_bit(SW_2, input_dev->swbit);
+	set_bit(SW_LID, input_dev->swbit);
+	set_bit(SW_TABLET_MODE, input_dev->swbit);
+	set_bit(SW_HEADPHONE_INSERT, input_dev->swbit);
 
 	input_register_device(input_dev);
 
Index: git/include/linux/input.h
===================================================================
--- git.orig/include/linux/input.h	2006-05-04 23:13:11.000000000 +0100
+++ git/include/linux/input.h	2006-05-05 16:18:55.000000000 +0100
@@ -577,14 +577,9 @@
  * Switch events
  */
 
-#define SW_0			0x00
-#define SW_1			0x01
-#define SW_2			0x02
-#define SW_3			0x03
-#define SW_4			0x04
-#define SW_5			0x05
-#define SW_6			0x06
-#define SW_7			0x07
+#define SW_LID			0x00  /* set = lid shut */
+#define SW_TABLET_MODE		0x01  /* set = tablet mode */
+#define SW_HEADPHONE_INSERT	0x02  /* set = inserted */
 #define SW_MAX			0x0f
 
 /*


