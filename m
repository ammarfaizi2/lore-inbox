Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267991AbUG2PG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267991AbUG2PG7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 11:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267785AbUG2O5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 10:57:24 -0400
Received: from styx.suse.cz ([82.119.242.94]:8854 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264791AbUG2OII convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:08:08 -0400
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 7/47] Add reporting of raw scancodes to atkbd.c
Content-Transfer-Encoding: 7BIT
Date: Thu, 29 Jul 2004 16:09:54 +0200
X-Mailer: gregkh_patchbomb_levon_offspring
In-Reply-To: <10911101943135@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Message-Id: <10911101943792@twilight.ucw.cz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1722.63.2, 2004-05-31 15:49:05+02:00, vojtech@suse.cz
  input: Add reporting of raw scancodes to atkbd.c
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 drivers/input/keyboard/atkbd.c |    8 +++++---
 include/linux/input.h          |    1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

===================================================================

diff -Nru a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
--- a/drivers/input/keyboard/atkbd.c	Thu Jul 29 14:42:00 2004
+++ b/drivers/input/keyboard/atkbd.c	Thu Jul 29 14:42:00 2004
@@ -280,6 +280,8 @@
 	if (!test_bit(ATKBD_FLAG_ENABLED, &atkbd->flags))
 		goto out;
 
+	input_event(&atkbd->dev, EV_MSC, MSC_RAW, code);
+
 	if (atkbd->translated) {
 
 		if (atkbd->emul ||
@@ -753,9 +755,10 @@
 	}
 
 	if (atkbd->write) {
-		atkbd->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_LED) | BIT(EV_REP);
+		atkbd->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_LED) | BIT(EV_REP) | BIT(EV_MSC);
 		atkbd->dev.ledbit[0] = BIT(LED_NUML) | BIT(LED_CAPSL) | BIT(LED_SCROLLL);
-	} else  atkbd->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REP);
+	} else  atkbd->dev.evbit[0] = BIT(EV_KEY) | BIT(EV_REP) | BIT(EV_MSC);
+	atkbd->dev.mscbit[0] = BIT(MSC_RAW);
 
 	if (!atkbd_softrepeat) {
 		atkbd->dev.rep[REP_DELAY] = 250;
@@ -795,7 +798,6 @@
 		atkbd->set = 2;
 		atkbd->id = 0xab00;
 	}
-
 
 	if (atkbd->extra) {
 		atkbd->dev.ledbit[0] |= BIT(LED_COMPOSE) | BIT(LED_SUSPEND) | BIT(LED_SLEEP) | BIT(LED_MUTE) | BIT(LED_MISC);
diff -Nru a/include/linux/input.h b/include/linux/input.h
--- a/include/linux/input.h	Thu Jul 29 14:42:00 2004
+++ b/include/linux/input.h	Thu Jul 29 14:42:00 2004
@@ -527,6 +527,7 @@
 #define MSC_SERIAL		0x00
 #define MSC_PULSELED		0x01
 #define MSC_GESTURE		0x02
+#define MSC_RAW			0x03
 #define MSC_MAX			0x07
 
 /*

