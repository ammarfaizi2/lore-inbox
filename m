Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbVE2FBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVE2FBT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 01:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261253AbVE2FBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 01:01:19 -0400
Received: from smtp826.mail.sc5.yahoo.com ([66.163.171.13]:882 "HELO
	smtp826.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261238AbVE2FBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 01:01:08 -0400
Message-Id: <20050529045846.909849000.dtor_core@ameritech.net>
References: <20050529044813.711249000.dtor_core@ameritech.net>
Date: Sat, 28 May 2005 23:48:16 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [patch 03/13] i8042: try AUX (on x86) even if PNP only reports KBD
Content-Disposition: inline; filename=i8042-aux-detection.patch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vojtech Pavlik <vojtech@suse.cz>

Input: Add a missing KERN_INFO message designation, fix behavior
       when only a keyboard part of the controller is detected.

Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/serio/i8042-x86ia64io.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: work/drivers/input/serio/i8042-x86ia64io.h
===================================================================
--- work.orig/drivers/input/serio/i8042-x86ia64io.h
+++ work/drivers/input/serio/i8042-x86ia64io.h
@@ -227,7 +227,7 @@ static int i8042_pnp_init(void)
 	int result_kbd, result_aux;
 
 	if (i8042_nopnp) {
-		printk("i8042: PNP detection disabled\n");
+		printk(KERN_INFO "i8042: PNP detection disabled\n");
 		return 0;
 	}
 
@@ -265,7 +265,7 @@ static int i8042_pnp_init(void)
 		i8042_pnp_kbd_irq = i8042_kbd_irq;
 	}
 
-	if (result_aux > 0 && !i8042_pnp_aux_irq) {
+	if (!i8042_pnp_aux_irq) {
 		printk(KERN_WARNING "PNP: PS/2 controller doesn't have AUX irq; using default %#x\n", i8042_aux_irq);
 		i8042_pnp_aux_irq = i8042_aux_irq;
 	}

