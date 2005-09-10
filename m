Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932349AbVIJWh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbVIJWh5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 18:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbVIJWeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 18:34:17 -0400
Received: from styx.suse.cz ([82.119.242.94]:38308 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932358AbVIJWdw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 18:33:52 -0400
Subject: [PATCH 16/26] HID - add support for Logitech UltraX Media Remote control
In-Reply-To: <11263916532510@midnight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sun, 11 Sep 2005 00:34:13 +0200
Message-Id: <11263916532348@midnight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] Input: HID - add support for Logitech UltraX Media Remote control
From: Micah F. Galizia <mfgalizi@uwo.ca>
Date: 1125897135 -0500

The hid now supports the Logitech UltraX Media Remote control.
For now, ID 45 on the consumer usage page has been incorrectly
mapped to KEY_RADIO since no other devices uses it.

Signed-off-by: Micah F. Galizia <mfgalizi@csd.uwo.ca>
Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

---

 drivers/usb/input/hid-input.c |   28 ++++++++++++++++++++++++++--
 1 files changed, 26 insertions(+), 2 deletions(-)

39fd748f56012fdde4cf862f127ce4cdec50d661
diff --git a/drivers/usb/input/hid-input.c b/drivers/usb/input/hid-input.c
--- a/drivers/usb/input/hid-input.c
+++ b/drivers/usb/input/hid-input.c
@@ -247,6 +247,7 @@ static void hidinput_configure_usage(str
 				case 0x000: goto ignore;
 				case 0x034: map_key_clear(KEY_SLEEP);		break;
 				case 0x036: map_key_clear(BTN_MISC);		break;
+				case 0x045: map_key_clear(KEY_RADIO);		break;
 				case 0x08a: map_key_clear(KEY_WWW);		break;
 				case 0x08d: map_key_clear(KEY_PROGRAM);		break;
 				case 0x095: map_key_clear(KEY_HELP);		break;
@@ -318,10 +319,33 @@ static void hidinput_configure_usage(str
 
 		case HID_UP_MSVENDOR:
 		case HID_UP_LOGIVENDOR:
-		case HID_UP_LOGIVENDOR2:
-
 			goto ignore;
 
+		case HID_UP_LOGIVENDOR2: /* Reported on Logitech Ultra X Media Remote */
+
+			set_bit(EV_REP, input->evbit);
+			switch(usage->hid & HID_USAGE) {
+				case 0x004: map_key_clear(KEY_AGAIN);		break;
+				case 0x00d: map_key_clear(KEY_HOME);		break;
+				case 0x024: map_key_clear(KEY_SHUFFLE);		break;
+				case 0x025: map_key_clear(KEY_TV);		break;
+				case 0x026: map_key_clear(KEY_MENU);		break;
+				case 0x031: map_key_clear(KEY_AUDIO);		break;
+				case 0x032: map_key_clear(KEY_SUBTITLE);	break;
+				case 0x033: map_key_clear(KEY_LAST);		break;
+				case 0x047: map_key_clear(KEY_MP3);		break;
+				case 0x048: map_key_clear(KEY_DVD);		break;
+				case 0x049: map_key_clear(KEY_MEDIA);		break;
+				case 0x04a: map_key_clear(KEY_VIDEO);		break;
+				case 0x04b: map_key_clear(KEY_ANGLE);		break;
+				case 0x04c: map_key_clear(KEY_LANGUAGE);	break;
+				case 0x04d: map_key_clear(KEY_SUBTITLE);	break;
+				case 0x051: map_key_clear(KEY_RED);		break;
+				case 0x052: map_key_clear(KEY_CLOSE);		break;
+				default:    goto ignore;
+			}
+			break;
+
 		case HID_UP_PID:
 
 			set_bit(EV_FF, input->evbit);

