Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261906AbSJISRF>; Wed, 9 Oct 2002 14:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261920AbSJISRF>; Wed, 9 Oct 2002 14:17:05 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:35745 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261906AbSJISRE>; Wed, 9 Oct 2002 14:17:04 -0400
Subject: [PATCH] Possible null pointer in drivers/serial/core.c
From: Paul Larson <plars@austin.ibm.com>
To: tytso@mit.edu, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 09 Oct 2002 13:17:19 -0500
Message-Id: <1034187439.30975.29.camel@plars>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In core.c:uart_startup() line 210 I found a possible null pointer
dereference at line 210:
 if (info->tty->termios->c_cflag & CBAUD)

There are other things around that same area that do the checking for
info->tty before dereferencing it, so either they are unneeded, or this
one needs a check too.

Thanks,
Paul Larson
--------------------
--- linux-2.5/drivers/serial/core.c	Wed Oct  9 13:45:11 2002
+++ linux-corefix/drivers/serial/core.c	Wed Oct  9 13:50:09 2002
@@ -207,7 +207,7 @@
 			 * Setup the RTS and DTR signals once the
 			 * port is open and ready to respond.
 			 */
-			if (info->tty->termios->c_cflag & CBAUD)
+			if (info->tty && (info->tty->termios->c_cflag & CBAUD))
 				uart_set_mctrl(port, TIOCM_RTS | TIOCM_DTR);
 		}
 

