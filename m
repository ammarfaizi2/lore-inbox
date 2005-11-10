Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932066AbVKJQp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbVKJQp6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 11:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbVKJQp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 11:45:58 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:13005 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932066AbVKJQpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 11:45:23 -0500
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Tom Rini <trini@kernel.crashing.org>, lkml <linux-kernel@vger.kernel.org>
Message-Id: <20051110164515.20950.68313.sendpatchset@localhost.localdomain>
In-Reply-To: <20051110163906.20950.45704.sendpatchset@localhost.localdomain>
References: <20051110163906.20950.45704.sendpatchset@localhost.localdomain>
Subject: [PATCH,RFC 2.6.14 14/15] KGDB: Fix for 'lost' SysRq events
Date: Thu, 10 Nov 2005 11:45:00 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible that when SysRq-G is triggered via the keyboard that we will
miss the "up" event and once KGDB lets the kernel go another SysRq will be
required to clear this, without this change.

 drivers/char/keyboard.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6.14/drivers/char/keyboard.c
===================================================================
--- linux-2.6.14.orig/drivers/char/keyboard.c
+++ linux-2.6.14/drivers/char/keyboard.c
@@ -1069,6 +1069,7 @@ static void kbd_keycode(unsigned int key
 	}
 	if (sysrq_down && down && !rep) {
 		handle_sysrq(kbd_sysrq_xlate[keycode], regs, tty);
+		sysrq_down = 0;		/* In case we miss the 'up' event. */
 		return;
 	}
 #endif

-- 
Tom
