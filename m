Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbVIJWmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbVIJWmp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 18:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbVIJWmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 18:42:36 -0400
Received: from styx.suse.cz ([82.119.242.94]:31396 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932350AbVIJWdv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 18:33:51 -0400
Subject: [PATCH 12/26] add HID simulation mappings
In-Reply-To: <11263916521314@midnight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sun, 11 Sep 2005 00:34:12 +0200
Message-Id: <1126391652262@midnight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] Input: add HID simulation mappings
From: Vojtech Pavlik <vojtech@suse.cz>
Date: 1125896879 -0500

Add simulation usage page mappings to hid-input.c to support
a new crop of joysticks using them to designate Rudder and
Throttle controls.

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

---

 drivers/usb/input/hid-debug.h |   17 +++++++++++++++++
 drivers/usb/input/hid-input.c |    9 +++++++++
 drivers/usb/input/hid.h       |    1 +
 3 files changed, 27 insertions(+), 0 deletions(-)

0aebfdac042b63d0f2625414062e138a4333181c
diff --git a/drivers/usb/input/hid-debug.h b/drivers/usb/input/hid-debug.h
--- a/drivers/usb/input/hid-debug.h
+++ b/drivers/usb/input/hid-debug.h
@@ -85,6 +85,23 @@ static const struct hid_usage_entry hid_
       {0, 0x91, "D-PadDown"},
       {0, 0x92, "D-PadRight"},
       {0, 0x93, "D-PadLeft"},
+  {  2, 0, "Simulation" },
+      {0, 0xb0, "Aileron"},
+      {0, 0xb1, "AileronTrim"},
+      {0, 0xb2, "Anti-Torque"},
+      {0, 0xb3, "Autopilot"},
+      {0, 0xb4, "Chaff"},
+      {0, 0xb5, "Collective"},
+      {0, 0xb6, "DiveBrake"},
+      {0, 0xb7, "ElectronicCountermeasures"},
+      {0, 0xb8, "Elevator"},
+      {0, 0xb9, "ElevatorTrim"},
+      {0, 0xba, "Rudder"},
+      {0, 0xbb, "Throttle"},
+      {0, 0xbc, "FlightCommunications"},
+      {0, 0xbd, "FlareRelease"},
+      {0, 0xbe, "LandingGear"},
+      {0, 0xbf, "ToeBrake"},
   {  7, 0, "Keyboard" },
   {  8, 0, "LED" },
       {0, 0x01, "NumLock"},
diff --git a/drivers/usb/input/hid-input.c b/drivers/usb/input/hid-input.c
--- a/drivers/usb/input/hid-input.c
+++ b/drivers/usb/input/hid-input.c
@@ -131,6 +131,15 @@ static void hidinput_configure_usage(str
 			map_key(code);
 			break;
 
+
+		case HID_UP_SIMULATION:
+
+			switch (usage->hid & 0xffff) {
+				case 0xba: map_abs(ABS_RUDDER); break;
+				case 0xbb: map_abs(ABS_THROTTLE); break;
+			}
+			break;
+
 		case HID_UP_GENDESK:
 
 			if ((usage->hid & 0xf0) == 0x80) {	/* SystemControl */
diff --git a/drivers/usb/input/hid.h b/drivers/usb/input/hid.h
--- a/drivers/usb/input/hid.h
+++ b/drivers/usb/input/hid.h
@@ -173,6 +173,7 @@ struct hid_item {
 
 #define HID_UP_UNDEFINED	0x00000000
 #define HID_UP_GENDESK		0x00010000
+#define HID_UP_SIMULATION	0x00020000
 #define HID_UP_KEYBOARD		0x00070000
 #define HID_UP_LED		0x00080000
 #define HID_UP_BUTTON		0x00090000

