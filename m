Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030562AbWAGTJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030562AbWAGTJW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 14:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030561AbWAGTI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 14:08:56 -0500
Received: from smtp103.sbc.mail.re2.yahoo.com ([68.142.229.102]:6525 "HELO
	smtp103.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1030562AbWAGTIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 14:08:24 -0500
Message-Id: <20060107172101.978200000.dtor_core@ameritech.net>
References: <20060107171559.593824000.dtor_core@ameritech.net>
Date: Sat, 07 Jan 2006 12:16:20 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 21/24] atkbd: dont lose keymap settings when reconnecting keyboard
Content-Disposition: inline; filename=atkbd-reconnect.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: atkbd - don't lose keymap settings when reconnecting keyboard

Call serio_reconnect() instead of serio_rescan() when detecting that
a new keyboard was plugged in. This should help KVM uses losing custom
keymap settings when switching between boxes.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/keyboard/atkbd.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: work/drivers/input/keyboard/atkbd.c
===================================================================
--- work.orig/drivers/input/keyboard/atkbd.c
+++ work/drivers/input/keyboard/atkbd.c
@@ -321,7 +321,7 @@ static irqreturn_t atkbd_interrupt(struc
 	switch (code) {
 		case ATKBD_RET_BAT:
 			atkbd->enabled = 0;
-			serio_rescan(atkbd->ps2dev.serio);
+			serio_reconnect(atkbd->ps2dev.serio);
 			goto out;
 		case ATKBD_RET_EMUL0:
 			atkbd->emul = 1;

