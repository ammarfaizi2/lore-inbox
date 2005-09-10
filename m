Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbVIJWm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbVIJWm3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 18:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbVIJWm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 18:42:27 -0400
Received: from styx.suse.cz ([82.119.242.94]:40356 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932361AbVIJWdw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 18:33:52 -0400
Subject: [PATCH 19/26] HID - fix URB success status handling
In-Reply-To: <11263916533441@midnight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sun, 11 Sep 2005 00:34:13 +0200
Message-Id: <11263916533298@midnight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, dtor_core@ameritech.net, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] Input: HID - fix URB success status handling
From: Vojtech Pavlik <vojtech@suse.cz>
Date: 1125897183 -0500

Add a missing break; statement to the URB status handling
in hid-core.c, avoiding flushing the request queue on success.

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

---

 drivers/usb/input/hid-core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

c4786ca8a4274a0bbffe217917972943348bed64
diff --git a/drivers/usb/input/hid-core.c b/drivers/usb/input/hid-core.c
--- a/drivers/usb/input/hid-core.c
+++ b/drivers/usb/input/hid-core.c
@@ -1097,6 +1097,7 @@ static void hid_irq_out(struct urb *urb,
 
 	switch (urb->status) {
 		case 0:			/* success */
+			break;
 		case -ESHUTDOWN:	/* unplug */
 		case -EILSEQ:		/* unplug timeout on uhci */
 			unplug = 1;
@@ -1144,6 +1145,7 @@ static void hid_ctrl(struct urb *urb, st
 		case 0:			/* success */
 			if (hid->ctrl[hid->ctrltail].dir == USB_DIR_IN)
 				hid_input_report(hid->ctrl[hid->ctrltail].report->type, urb, 0, regs);
+			break;
 		case -ESHUTDOWN:	/* unplug */
 		case -EILSEQ:		/* unplug timectrl on uhci */
 			unplug = 1;

