Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266128AbUFUGhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266128AbUFUGhO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 02:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266130AbUFUGhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 02:37:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:33469 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266128AbUFUGhM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 02:37:12 -0400
X-Authenticated: #12437197
Date: Mon, 21 Jun 2004 09:38:45 +0300
From: Dan Aloni <da-x@gmx.net>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] missing NULL check in drivers/char/n_tty.c
Message-ID: <20040621063845.GA6379@callisto.yi.org>
Reply-To: Dan Aloni <da-x@colinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The rest of the kernel treats tty->driver->chars_in_buffer as a possible
NULL. This patch changes normal_poll() to be consistent with the rest of
the code.

Signed-off-by: Dan Aloni <da-x@colinux.org>

BTW, who is currently maintaining the tty subsystem?

--- linux-2.6.7/drivers/char/n_tty.c	2004-06-21 09:30:11.000000000 +0300
+++ linux-2.6.7/drivers/char/n_tty.c	2004-06-21 09:28:04.000000000 +0300
@@ -1272,8 +1272,8 @@
 		else
 			tty->minimum_to_wake = 1;
 	}
-	if (tty->driver->chars_in_buffer(tty) < WAKEUP_CHARS &&
-			tty->driver->write_room(tty) > 0)
+	if ((!tty->driver->chars_in_buffer || tty->driver->chars_in_buffer(tty) < WAKEUP_CHARS)
+	   && tty->driver->write_room(tty) > 0)
 		mask |= POLLOUT | POLLWRNORM;
 	return mask;
 }

-- 
Dan Aloni
da-x@colinux.org
