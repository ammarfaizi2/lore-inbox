Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVE2Fdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVE2Fdq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 01:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261259AbVE2Fdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 01:33:46 -0400
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:703 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261258AbVE2Fdk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 01:33:40 -0400
Message-Id: <20050529045847.387715000.dtor_core@ameritech.net>
References: <20050529044813.711249000.dtor_core@ameritech.net>
Date: Sat, 28 May 2005 23:48:20 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [patch 07/13] i8042: Make sure we unregister PNP driver only once
Content-Disposition: inline; filename=i8042-unregister-only-once.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kurt Garloff <garloff@suse.de>

Input: Avoid double unregistering of i8042 PnP driver. This can happen
       when no i8042 controller (not PnP, not legacy) is present.

From: Kurt Garloff <garloff@suse.de>
Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/serio/i8042-x86ia64io.h |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

Index: work/drivers/input/serio/i8042-x86ia64io.h
===================================================================
--- work.orig/drivers/input/serio/i8042-x86ia64io.h
+++ work/drivers/input/serio/i8042-x86ia64io.h
@@ -215,11 +215,15 @@ static struct pnp_driver i8042_pnp_aux_d
 
 static void i8042_pnp_exit(void)
 {
-	if (i8042_pnp_kbd_registered)
+	if (i8042_pnp_kbd_registered) {
+		i8042_pnp_kbd_registered = 0;
 		pnp_unregister_driver(&i8042_pnp_kbd_driver);
+	}
 
-	if (i8042_pnp_aux_registered)
+	if (i8042_pnp_aux_registered) {
+		i8042_pnp_aux_registered = 0;
 		pnp_unregister_driver(&i8042_pnp_aux_driver);
+	}
 }
 
 static int i8042_pnp_init(void)

