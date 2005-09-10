Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbVIJWij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbVIJWij (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 18:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbVIJWeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 18:34:08 -0400
Received: from styx.suse.cz ([82.119.242.94]:30372 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932349AbVIJWdv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 18:33:51 -0400
Subject: [PATCH 13/26] HID - add more consumer usages
In-Reply-To: <1126391652262@midnight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sun, 11 Sep 2005 00:34:13 +0200
Message-Id: <11263916532605@midnight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] Input: HID - add more consumer usages
From: Vojtech Pavlik <vojtech@suse.cz>
Date: 1125896888 -0500

Extend mapping of the consumer usage page in hid-input.c to handle
more cases appearing on new USB keyboards.

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

---

 drivers/usb/input/hid-debug.h |   17 +++++++++++------
 drivers/usb/input/hid-input.c |   19 ++++++++++++++++---
 drivers/usb/input/hid.h       |    1 +
 include/linux/input.h         |    8 ++++++++
 4 files changed, 36 insertions(+), 9 deletions(-)

8a409b0118c2d78f84f740f60fe03abda1fe3333
diff --git a/drivers/usb/input/hid-debug.h b/drivers/usb/input/hid-debug.h
--- a/drivers/usb/input/hid-debug.h
+++ b/drivers/usb/input/hid-debug.h
@@ -109,6 +109,7 @@ static const struct hid_usage_entry hid_
       {0, 0x03, "ScrollLock"},
       {0, 0x04, "Compose"},
       {0, 0x05, "Kana"},
+      {0, 0x4b, "GenericIndicator"},
   {  9, 0, "Button" },
   { 10, 0, "Ordinal" },
   { 12, 0, "Consumer" },
@@ -591,7 +592,8 @@ static char *keys[KEY_MAX + 1] = {
 	[KEY_EXIT] = "Exit",			[KEY_MOVE] = "Move",
 	[KEY_EDIT] = "Edit",			[KEY_SCROLLUP] = "ScrollUp",
 	[KEY_SCROLLDOWN] = "ScrollDown",	[KEY_KPLEFTPAREN] = "KPLeftParenthesis",
-	[KEY_KPRIGHTPAREN] = "KPRightParenthesis", [KEY_F13] = "F13",
+	[KEY_KPRIGHTPAREN] = "KPRightParenthesis", [KEY_NEW] = "New",
+	[KEY_REDO] = "Redo",			[KEY_F13] = "F13",
 	[KEY_F14] = "F14",			[KEY_F15] = "F15",
 	[KEY_F16] = "F16",			[KEY_F17] = "F17",
 	[KEY_F18] = "F18",			[KEY_F19] = "F19",
@@ -601,15 +603,15 @@ static char *keys[KEY_MAX + 1] = {
 	[KEY_PAUSECD] = "PauseCD",		[KEY_PROG3] = "Prog3",
 	[KEY_PROG4] = "Prog4",			[KEY_SUSPEND] = "Suspend",
 	[KEY_CLOSE] = "Close",			[KEY_PLAY] = "Play",
-	[KEY_FASTFORWARD] = "Fast Forward",	[KEY_BASSBOOST] = "Bass Boost",
+	[KEY_FASTFORWARD] = "FastForward",	[KEY_BASSBOOST] = "BassBoost",
 	[KEY_PRINT] = "Print",			[KEY_HP] = "HP",
 	[KEY_CAMERA] = "Camera",		[KEY_SOUND] = "Sound",
 	[KEY_QUESTION] = "Question",		[KEY_EMAIL] = "Email",
 	[KEY_CHAT] = "Chat",			[KEY_SEARCH] = "Search",
 	[KEY_CONNECT] = "Connect",		[KEY_FINANCE] = "Finance",
 	[KEY_SPORT] = "Sport",			[KEY_SHOP] = "Shop",
-	[KEY_ALTERASE] = "Alternate Erase",	[KEY_CANCEL] = "Cancel",
-	[KEY_BRIGHTNESSDOWN] = "Brightness down", [KEY_BRIGHTNESSUP] = "Brightness up",
+	[KEY_ALTERASE] = "AlternateErase",	[KEY_CANCEL] = "Cancel",
+	[KEY_BRIGHTNESSDOWN] = "BrightnessDown", [KEY_BRIGHTNESSUP] = "BrightnessUp",
 	[KEY_MEDIA] = "Media",			[KEY_UNKNOWN] = "Unknown",
 	[BTN_0] = "Btn0",			[BTN_1] = "Btn1",
 	[BTN_2] = "Btn2",			[BTN_3] = "Btn3",
@@ -639,8 +641,8 @@ static char *keys[KEY_MAX + 1] = {
 	[BTN_TOOL_AIRBRUSH] = "ToolAirbrush",	[BTN_TOOL_FINGER] = "ToolFinger",
 	[BTN_TOOL_MOUSE] = "ToolMouse",		[BTN_TOOL_LENS] = "ToolLens",
 	[BTN_TOUCH] = "Touch",			[BTN_STYLUS] = "Stylus",
-	[BTN_STYLUS2] = "Stylus2",		[BTN_TOOL_DOUBLETAP] = "Tool Doubletap",
-	[BTN_TOOL_TRIPLETAP] = "Tool Tripletap", [BTN_GEAR_DOWN] = "WheelBtn",
+	[BTN_STYLUS2] = "Stylus2",		[BTN_TOOL_DOUBLETAP] = "ToolDoubleTap",
+	[BTN_TOOL_TRIPLETAP] = "ToolTripleTap", [BTN_GEAR_DOWN] = "WheelBtn",
 	[BTN_GEAR_UP] = "Gear up",		[KEY_OK] = "Ok",
 	[KEY_SELECT] = "Select",		[KEY_GOTO] = "Goto",
 	[KEY_CLEAR] = "Clear",			[KEY_POWER2] = "Power2",
@@ -676,6 +678,9 @@ static char *keys[KEY_MAX + 1] = {
 	[KEY_TWEN] = "TWEN",			[KEY_DEL_EOL] = "DeleteEOL",
 	[KEY_DEL_EOS] = "DeleteEOS",		[KEY_INS_LINE] = "InsertLine",
 	[KEY_DEL_LINE] = "DeleteLine",
+	[KEY_SEND] = "Send",			[KEY_REPLY] = "Reply",
+	[KEY_FORWARDMAIL] = "ForwardMail",	[KEY_SAVE] = "Save",
+	[KEY_DOCUMENTS] = "Documents",
 };
 
 static char *relatives[REL_MAX + 1] = {
diff --git a/drivers/usb/input/hid-input.c b/drivers/usb/input/hid-input.c
--- a/drivers/usb/input/hid-input.c
+++ b/drivers/usb/input/hid-input.c
@@ -78,8 +78,8 @@ static void hidinput_configure_usage(str
 {
 	struct input_dev *input = &hidinput->input;
 	struct hid_device *device = hidinput->input.private;
-	int max, code;
-	unsigned long *bit;
+	int max = 0, code;
+	unsigned long *bit = NULL;
 
 	field->hidinput = hidinput;
 
@@ -248,7 +248,10 @@ static void hidinput_configure_usage(str
 				case 0x034: map_key_clear(KEY_SLEEP);		break;
 				case 0x036: map_key_clear(BTN_MISC);		break;
 				case 0x08a: map_key_clear(KEY_WWW);		break;
+				case 0x08d: map_key_clear(KEY_PROGRAM);		break;
 				case 0x095: map_key_clear(KEY_HELP);		break;
+				case 0x09c: map_key_clear(KEY_CHANNELUP);	break;
+				case 0x09d: map_key_clear(KEY_CHANNELDOWN);	break;
 				case 0x0b0: map_key_clear(KEY_PLAY);		break;
 				case 0x0b1: map_key_clear(KEY_PAUSE);		break;
 				case 0x0b2: map_key_clear(KEY_RECORD);		break;
@@ -268,6 +271,11 @@ static void hidinput_configure_usage(str
 				case 0x18a: map_key_clear(KEY_MAIL);		break;
 				case 0x192: map_key_clear(KEY_CALC);		break;
 				case 0x194: map_key_clear(KEY_FILE);		break;
+				case 0x1a7: map_key_clear(KEY_DOCUMENTS);	break;
+				case 0x201: map_key_clear(KEY_NEW);		break;
+				case 0x207: map_key_clear(KEY_SAVE);		break;
+				case 0x208: map_key_clear(KEY_PRINT);		break;
+				case 0x209: map_key_clear(KEY_PROPS);		break;
 				case 0x21a: map_key_clear(KEY_UNDO);		break;
 				case 0x21b: map_key_clear(KEY_COPY);		break;
 				case 0x21c: map_key_clear(KEY_CUT);		break;
@@ -280,7 +288,11 @@ static void hidinput_configure_usage(str
 				case 0x227: map_key_clear(KEY_REFRESH);		break;
 				case 0x22a: map_key_clear(KEY_BOOKMARKS);	break;
 				case 0x238: map_rel(REL_HWHEEL);		break;
-				default:    goto unknown;
+				case 0x279: map_key_clear(KEY_REDO);		break;
+				case 0x289: map_key_clear(KEY_REPLY);		break;
+				case 0x28b: map_key_clear(KEY_FORWARDMAIL);	break;
+				case 0x28c: map_key_clear(KEY_SEND);		break;
+				default:    goto ignore;
 			}
 			break;
 
@@ -306,6 +318,7 @@ static void hidinput_configure_usage(str
 
 		case HID_UP_MSVENDOR:
 		case HID_UP_LOGIVENDOR:
+		case HID_UP_LOGIVENDOR2:
 
 			goto ignore;
 
diff --git a/drivers/usb/input/hid.h b/drivers/usb/input/hid.h
--- a/drivers/usb/input/hid.h
+++ b/drivers/usb/input/hid.h
@@ -184,6 +184,7 @@ struct hid_item {
 #define HID_UP_HPVENDOR         0xff7f0000
 #define HID_UP_MSVENDOR		0xff000000
 #define HID_UP_LOGIVENDOR	0x00ff0000
+#define HID_UP_LOGIVENDOR2	0xffbc0000
 
 #define HID_USAGE		0x0000ffff
 
diff --git a/include/linux/input.h b/include/linux/input.h
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -287,6 +287,8 @@ struct input_absinfo {
 #define KEY_SCROLLDOWN		178
 #define KEY_KPLEFTPAREN		179
 #define KEY_KPRIGHTPAREN	180
+#define KEY_NEW			181
+#define KEY_REDO		182
 
 #define KEY_F13			183
 #define KEY_F14			184
@@ -333,6 +335,12 @@ struct input_absinfo {
 #define KEY_KBDILLUMDOWN	229
 #define KEY_KBDILLUMUP		230
 
+#define KEY_SEND		231
+#define KEY_REPLY		232
+#define KEY_FORWARDMAIL		233
+#define KEY_SAVE		234
+#define KEY_DOCUMENTS		235
+
 #define KEY_UNKNOWN		240
 
 #define BTN_MISC		0x100

