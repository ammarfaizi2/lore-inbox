Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262068AbVF0Nbo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbVF0Nbo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 09:31:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbVF0Naw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 09:30:52 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:21989 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262070AbVF0MQq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 08:16:46 -0400
Message-Id: <20050627121419.840759000@abc>
References: <20050627120600.739151000@abc>
Date: Mon, 27 Jun 2005 14:06:51 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Patrick Boettcher <pb@linuxtv.org>
Content-Disposition: inline; filename=dvb-usb-ir-input-fixes.patch
X-SA-Exim-Connect-IP: 84.189.248.249
Subject: [DVB patch 51/51] usb: IR input fixes
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Boettcher <pb@linuxtv.org>

o fixed usage of the correct number of events in keymapping-array
o better place for return

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/dvb-usb/dvb-usb-remote.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6.12-git8/drivers/media/dvb/dvb-usb/dvb-usb-remote.c
===================================================================
--- linux-2.6.12-git8.orig/drivers/media/dvb/dvb-usb/dvb-usb-remote.c	2005-06-27 13:26:11.000000000 +0200
+++ linux-2.6.12-git8/drivers/media/dvb/dvb-usb/dvb-usb-remote.c	2005-06-27 13:27:09.000000000 +0200
@@ -39,7 +39,7 @@ static void dvb_usb_read_remote_control(
 			d->last_event = event;
 		case REMOTE_KEY_REPEAT:
 			deb_rc("key repeated\n");
-			input_event(&d->rc_input_dev, EV_KEY, event, 1);
+			input_event(&d->rc_input_dev, EV_KEY, d->last_event, 1);
 			input_event(&d->rc_input_dev, EV_KEY, d->last_event, 0);
 			input_sync(&d->rc_input_dev);
 			break;
@@ -160,12 +160,12 @@ int dvb_usb_nec_rc_key_to_event(struct d
 				break;
 			}
 			/* See if we can match the raw key code. */
-			for (i = 0; i < sizeof(keymap)/sizeof(struct dvb_usb_rc_key); i++)
+			for (i = 0; i < d->props.rc_key_map_size; i++)
 				if (keymap[i].custom == keybuf[1] &&
 					keymap[i].data == keybuf[3]) {
 					*event = keymap[i].event;
 					*state = REMOTE_KEY_PRESSED;
-					break;
+					return 0;
 				}
 			deb_err("key mapping failed - no appropriate key found in keymapping\n");
 			break;

--

