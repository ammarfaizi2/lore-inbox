Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262483AbUKLGlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262483AbUKLGlI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 01:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262474AbUKLGjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 01:39:33 -0500
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:18590 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262470AbUKLGfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 01:35:12 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 6/7] Correctly set mouse name when using PS2++ protocol
Date: Fri, 12 Nov 2004 01:33:34 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200411120127.01473.dtor_core@ameritech.net> <200411120131.54268.dtor_core@ameritech.net> <200411120132.44833.dtor_core@ameritech.net>
In-Reply-To: <200411120132.44833.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200411120133.36249.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1990, 2004-11-12 00:39:02-05:00, dtor_core@ameritech.net
  Input: psmouse - set mouse name to "Mouse" when using PS2++ and
         don't have any other information about the mouse.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 logips2pp.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)


===================================================================



diff -Nru a/drivers/input/mouse/logips2pp.c b/drivers/input/mouse/logips2pp.c
--- a/drivers/input/mouse/logips2pp.c	2004-11-12 01:01:15 -05:00
+++ b/drivers/input/mouse/logips2pp.c	2004-11-12 01:01:15 -05:00
@@ -245,7 +245,8 @@
  * Set up input device's properties based on the detected mouse model.
  */
 
-static void ps2pp_set_model_properties(struct psmouse *psmouse, struct ps2pp_info *model_info)
+static void ps2pp_set_model_properties(struct psmouse *psmouse, struct ps2pp_info *model_info,
+				       int using_ps2pp)
 {
 	if (model_info->features & PS2PP_SIDE_BTN)
 		set_bit(BTN_SIDE, psmouse->dev.keybit);
@@ -279,6 +280,16 @@
 		case PS2PP_KIND_TP3:
 			psmouse->name = "TouchPad 3";
 			break;
+
+		default:
+			/*
+			 * Set name to "Mouse" only when using PS2++,
+			 * otherwise let other protocols define suitable
+			 * name
+			 */
+			if (using_ps2pp)
+				psmouse->name = "Mouse";
+			break;
 	}
 }
 
@@ -371,7 +382,7 @@
 			clear_bit(BTN_RIGHT, psmouse->dev.keybit);
 
 		if (model_info)
-			ps2pp_set_model_properties(psmouse, model_info);
+			ps2pp_set_model_properties(psmouse, model_info, use_ps2pp);
 	}
 
 	return use_ps2pp ? 0 : -1;
