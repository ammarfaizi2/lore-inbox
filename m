Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbVLQCbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbVLQCbJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 21:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbVLQCbI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 21:31:08 -0500
Received: from smtp113.sbc.mail.re2.yahoo.com ([68.142.229.92]:2386 "HELO
	smtp113.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751358AbVLQCbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 21:31:08 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] Input: fix an OOPS in HID driver
Date: Fri, 16 Dec 2005 21:31:04 -0500
User-Agent: KMail/1.8.3
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512162131.04544.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: 

This patch fixes an OOPS in HID driver when connecting simulation
devices generating unknown simulation events.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/usb/input/hid-input.c |    1 +
 1 files changed, 1 insertion(+)

Index: work/drivers/usb/input/hid-input.c
===================================================================
--- work.orig/drivers/usb/input/hid-input.c
+++ work/drivers/usb/input/hid-input.c
@@ -137,6 +137,7 @@ static void hidinput_configure_usage(str
 			switch (usage->hid & 0xffff) {
 				case 0xba: map_abs(ABS_RUDDER); break;
 				case 0xbb: map_abs(ABS_THROTTLE); break;
+				default:   goto unknown;
 			}
 			break;
 
