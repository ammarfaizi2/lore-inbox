Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932590AbVLQQnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932590AbVLQQnD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 11:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932606AbVLQQnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 11:43:03 -0500
Received: from smtp101.sbc.mail.re2.yahoo.com ([68.142.229.104]:33653 "HELO
	smtp101.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932590AbVLQQnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 11:43:02 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH] Input: fix an OOPS in HID driver
Date: Sat, 17 Dec 2005 11:42:54 -0500
User-Agent: KMail/1.8.3
Cc: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <200512162131.04544.dtor_core@ameritech.net> <20051217102223.GB27280@midnight.suse.cz> <200512171140.28029.dtor_core@ameritech.net>
In-Reply-To: <200512171140.28029.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512171142.54758.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes an OOPS in HID driver when connecting simulation
devices generating unknown simulation events.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Acked-by: Vojtech Pavlik <vojtech@suse.cz>
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
+				default:   goto ignore;
 			}
 			break;
 
