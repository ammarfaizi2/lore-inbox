Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264635AbUFGNIN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264635AbUFGNIN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 09:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264656AbUFGMUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 08:20:20 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:17281 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S264637AbUFGL4h convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 07:56:37 -0400
To: torvalds@osdl.org, akpm@osdl.org, vojtech@ucw.cz,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
Message-Id: <1086609355796@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <10866093551747@twilight.ucw.cz>
Mime-Version: 1.0
Date: Mon, 7 Jun 2004 13:55:55 +0200
Subject: [PATCH 37/39] input: Check for IM Explorer mice even if IMPS check failed.
X-Mailer: gregkh_patchbomb_levon_offspring
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input-for-linus

===================================================================

ChangeSet@1.1612.1.17, 2004-05-14 11:18:46+02:00, vojtech@suse.cz
  input: Check for IM Explorer mice even if IMPS check failed.


 psmouse-base.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

===================================================================

diff -Nru a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
--- a/drivers/input/mouse/psmouse-base.c	2004-06-07 13:10:27 +02:00
+++ b/drivers/input/mouse/psmouse-base.c	2004-06-07 13:10:27 +02:00
@@ -461,24 +461,25 @@
 			return type;
 	}
 
-	if (max_proto >= PSMOUSE_IMPS && intellimouse_detect(psmouse)) {
+	if (max_proto >= PSMOUSE_IMEX && im_explorer_detect(psmouse)) {
 
 		if (set_properties) {
 			set_bit(REL_WHEEL, psmouse->dev.relbit);
+			set_bit(BTN_SIDE, psmouse->dev.keybit);
+			set_bit(BTN_EXTRA, psmouse->dev.keybit);
 			if (!psmouse->name)
-				psmouse->name = "Wheel Mouse";
+				psmouse->name = "Explorer Mouse";
 		}
 
-		if (max_proto >= PSMOUSE_IMEX && im_explorer_detect(psmouse)) {
+		return PSMOUSE_IMEX;
+	}
 
-			if (!set_properties) {
-				set_bit(BTN_SIDE, psmouse->dev.keybit);
-				set_bit(BTN_EXTRA, psmouse->dev.keybit);
-				if (!psmouse->name)
-					psmouse->name = "Explorer Mouse";
-			}
+	if (max_proto >= PSMOUSE_IMPS && intellimouse_detect(psmouse)) {
 
-			return PSMOUSE_IMEX;
+		if (set_properties) {
+			set_bit(REL_WHEEL, psmouse->dev.relbit);
+			if (!psmouse->name)
+				psmouse->name = "Wheel Mouse";
 		}
 
 		return PSMOUSE_IMPS;

