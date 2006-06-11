Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751067AbWFKVYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbWFKVYa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 17:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbWFKVYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 17:24:30 -0400
Received: from mail.gmx.de ([213.165.64.20]:47815 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750979AbWFKVYa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 17:24:30 -0400
X-Authenticated: #704063
Subject: [Patch] Cleanup char/esp.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sun, 11 Jun 2006 23:24:27 +0200
Message-Id: <1150061067.9424.1.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

hi,

coverity choked at another two !tty checks, in places where tty can
never be NULL. Since it removes some code we should remove
these checks. (Coverity ids #763,#762)

Signed-off-by Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.17-rc5/drivers/char/esp.c.orig	2006-06-11 23:21:37.000000000 +0200
+++ linux-2.6.17-rc5/drivers/char/esp.c	2006-06-11 23:21:55.000000000 +0200
@@ -1212,7 +1212,7 @@ static void rs_put_char(struct tty_struc
 	if (serial_paranoia_check(info, tty->name, "rs_put_char"))
 		return;
 
-	if (!tty || !info->xmit_buf)
+	if (!info->xmit_buf)
 		return;
 
 	spin_lock_irqsave(&info->lock, flags);
@@ -1256,7 +1256,7 @@ static int rs_write(struct tty_struct * 
 	if (serial_paranoia_check(info, tty->name, "rs_write"))
 		return 0;
 
-	if (!tty || !info->xmit_buf)
+	if (!info->xmit_buf)
 		return 0;
 	    
 	while (1) {


