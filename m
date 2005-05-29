Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVE2Fdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVE2Fdl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 01:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVE2Fdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 01:33:41 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:58246 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261249AbVE2Fdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 01:33:39 -0400
Message-Id: <20050529045847.618273000.dtor_core@ameritech.net>
References: <20050529044813.711249000.dtor_core@ameritech.net>
Date: Sat, 28 May 2005 23:48:22 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [patch 09/13] joydev: fix button mapping
Content-Disposition: inline; filename=joydev-button-fix.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vojtech Pavlik <vojtech@suse.cz>

Input: Fix button mapping in joydev - BTN_TRIGGER was being
       mapped twice, resulting in it being the last (instead
       of first) button on a joystick.

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/joydev.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: work/drivers/input/joydev.c
===================================================================
--- work.orig/drivers/input/joydev.c
+++ work/drivers/input/joydev.c
@@ -422,7 +422,7 @@ static struct input_handle *joydev_conne
 			joydev->nkey++;
 		}
 
-	for (i = 0; i < BTN_JOYSTICK - BTN_MISC + 1; i++)
+	for (i = 0; i < BTN_JOYSTICK - BTN_MISC; i++)
 		if (test_bit(i + BTN_MISC, dev->keybit)) {
 			joydev->keymap[i] = joydev->nkey;
 			joydev->keypam[joydev->nkey] = i + BTN_MISC;

