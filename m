Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265143AbSJWS4E>; Wed, 23 Oct 2002 14:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265145AbSJWS4D>; Wed, 23 Oct 2002 14:56:03 -0400
Received: from blowme.phunnypharm.org ([65.207.35.140]:5126 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S265143AbSJWS4C>; Wed, 23 Oct 2002 14:56:02 -0400
Date: Wed, 23 Oct 2002 15:02:11 -0400
From: Ben Collins <bcollins@debian.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] potential NULL deref in serial/core.c
Message-ID: <20021023190211.GG536@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not sure if it's supposed to be a BUG() for tty to be NULL, but it's
surely a bug to dereference it before checking for that.



--- drivers/serial/core.c~	2002-10-23 14:59:17.000000000 -0400
+++ drivers/serial/core.c	2002-10-23 14:59:42.000000000 -0400
@@ -472,10 +472,12 @@
 
 static void uart_put_char(struct tty_struct *tty, unsigned char ch)
 {
-	struct uart_info *info = tty->driver_data;
+	struct uart_info *info;
 
-	if (tty)
+	if (tty) {
+		info = tty->driver_data;
 		__uart_put_char(info->port, &info->xmit, ch);
+	}
 }
 
 static void uart_flush_chars(struct tty_struct *tty)

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
