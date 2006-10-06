Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423004AbWJFX1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423004AbWJFX1J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 19:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423006AbWJFX1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 19:27:09 -0400
Received: from cacti.profiwh.com ([85.93.165.66]:16605 "EHLO cacti.profiwh.com")
	by vger.kernel.org with ESMTP id S1423004AbWJFX1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 19:27:08 -0400
Message-id: <12387098213213@wsc.cz>
Subject: [PATCH] Char: nozomi, use tty_wakeup
From: Jiri Slaby <jirislaby@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <p.hardwick@option.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Sat,  7 Oct 2006 01:27:07 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

nozomi, use tty_wakeup

Use tty_wakeup instead of self-implemented wake calling.

Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

---
commit b19884f570ea41ff9100cc56962e8d6f435e2337
tree f68d0e40ee5e527a0c6d96dc28291235032c45e1
parent 56269f9ba9ccaf60a314ebcf58d4de650995c4e5
author Jiri Slaby <jirislaby@gmail.com> Sat, 07 Oct 2006 01:23:24 +0200
committer Jiri Slaby <xslaby@anemoi.localdomain> Sat, 07 Oct 2006 01:23:24 +0200

 drivers/char/nozomi.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/char/nozomi.c b/drivers/char/nozomi.c
index cd95ed5..8d502d2 100644
--- a/drivers/char/nozomi.c
+++ b/drivers/char/nozomi.c
@@ -922,12 +922,8 @@ static int send_data( enum port_type ind
     SET_MEM( addr, &size, 4 );
     SET_MEM_BUF( addr + 4, dc->send_buf, size);
 
-    if (port->tty) {
-        if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) && tty->ldisc.write_wakeup) {
-            tty->ldisc.write_wakeup(tty);
-        }
-        wake_up_interruptible(&tty->write_wait);
-    }
+    if (tty)
+	tty_wakeup(tty);
 
     return 1;
 }
