Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262694AbVBBUTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbVBBUTG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 15:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262377AbVBBUJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 15:09:43 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:32132 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S262308AbVBBTqj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 14:46:39 -0500
Subject: [PATCH 4/4] Fix HID LED mapping.
In-Reply-To: <11073736133786@twilight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Wed, 2 Feb 2005 20:46:54 +0100
Message-Id: <11073736142817@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, vojtech@ucw.cz, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/for-linus

===================================================================

ChangeSet@1.1994, 2005-02-02 17:54:35+01:00, vojtech@silver.ucw.cz
  input: Fix HID LED mapping. LEDs were ignored because the usage
         value contains the page code in high 16 bits.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 hid-debug.h |    2 +-
 hid-input.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

===================================================================

diff -Nru a/drivers/usb/input/hid-debug.h b/drivers/usb/input/hid-debug.h
--- a/drivers/usb/input/hid-debug.h	2005-02-02 20:29:32 +01:00
+++ b/drivers/usb/input/hid-debug.h	2005-02-02 20:29:32 +01:00
@@ -86,12 +86,12 @@
       {0, 0x92, "D-PadRight"},
       {0, 0x93, "D-PadLeft"},
   {  7, 0, "Keyboard" },
+  {  8, 0, "LED" },
       {0, 0x01, "NumLock"},
       {0, 0x02, "CapsLock"},
       {0, 0x03, "ScrollLock"},
       {0, 0x04, "Compose"},
       {0, 0x05, "Kana"},
-  {  8, 0, "LED" },
   {  9, 0, "Button" },
   { 10, 0, "Ordinal" },
   { 12, 0, "Consumer" },
diff -Nru a/drivers/usb/input/hid-input.c b/drivers/usb/input/hid-input.c
--- a/drivers/usb/input/hid-input.c	2005-02-02 20:29:32 +01:00
+++ b/drivers/usb/input/hid-input.c	2005-02-02 20:29:32 +01:00
@@ -185,9 +185,9 @@
 			break;
 
 		case HID_UP_LED:
-			if (usage->hid - 1 >= LED_MAX)
+			if (((usage->hid - 1) & 0xffff) >= LED_MAX)
 				goto ignore;
-			map_led(usage->hid - 1);
+			map_led((usage->hid - 1) & 0xffff);
 			break;
 
 		case HID_UP_DIGITIZER:

