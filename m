Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbVH2QLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbVH2QLu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 12:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbVH2QLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 12:11:50 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:33717 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751257AbVH2QLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 12:11:47 -0400
Subject: [patch 14/16] Minor SysRq keyboard bugfix for KGDB
Date: Mon, 29 Aug 2005 09:11:46 -0700
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, trini@kernel.crashing.org, george@mvista.com
From: Tom Rini <trini@kernel.crashing.org>
Message-Id: <resend.14.2982005.trini@kernel.crashing.org>
In-Reply-To: <resend.13.2982005.trini@kernel.crashing.org>
References: <resend.13.2982005.trini@kernel.crashing.org> <1.2982005.trini@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CC: George Anzginer <george@mvista.com>
It is possible that when SysRq-G is triggered via the keyboard that we will
miss the "up" event and once KGDB lets the kernel go another SysRq will be
required to clear this, without this change.

---

 linux-2.6.13-trini/drivers/char/keyboard.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN drivers/char/keyboard.c~sysrq_bugfix drivers/char/keyboard.c
--- linux-2.6.13/drivers/char/keyboard.c~sysrq_bugfix	2005-08-08 19:16:04.000000000 -0700
+++ linux-2.6.13-trini/drivers/char/keyboard.c	2005-08-08 19:16:04.000000000 -0700
@@ -1070,6 +1070,7 @@ static void kbd_keycode(unsigned int key
 	}
 	if (sysrq_down && down && !rep) {
 		handle_sysrq(kbd_sysrq_xlate[keycode], regs, tty);
+		sysrq_down = 0;		/* In case we miss the 'up' event. */
 		return;
 	}
 #endif
_
