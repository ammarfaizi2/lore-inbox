Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262862AbVG2VZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262862AbVG2VZT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 17:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262841AbVG2VYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 17:24:05 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:31998 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262654AbVG2VVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 17:21:22 -0400
Subject: [patch 13/15] Minor SysRq keyboard bugfix for KGDB
Date: Fri, 29 Jul 2005 14:21:20 -0700
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, trini@kernel.crashing.org, george@mvista.com
From: Tom Rini <trini@kernel.crashing.org>
Message-Id: <resend.13.2972005.trini@kernel.crashing.org>
In-Reply-To: <resend.12.2972005.trini@kernel.crashing.org>
References: <resend.12.2972005.trini@kernel.crashing.org> <1.2972005.trini@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


CC: George Anzginer <george@mvista.com>
It is possible that when SysRq-G is triggered via the keyboard that we will
miss the "up" event and once KGDB lets the kernel go another SysRq will be
required to clear this, without this change.

---

 linux-2.6.13-rc3-trini/drivers/char/keyboard.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN drivers/char/keyboard.c~sysrq_bugfix drivers/char/keyboard.c
--- linux-2.6.13-rc3/drivers/char/keyboard.c~sysrq_bugfix	2005-07-29 11:55:34.000000000 -0700
+++ linux-2.6.13-rc3-trini/drivers/char/keyboard.c	2005-07-29 11:55:34.000000000 -0700
@@ -1070,6 +1070,7 @@ static void kbd_keycode(unsigned int key
 	}
 	if (sysrq_down && down && !rep) {
 		handle_sysrq(kbd_sysrq_xlate[keycode], regs, tty);
+		sysrq_down = 0;		/* In case we miss the 'up' event. */
 		return;
 	}
 #endif
_
