Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130621AbRCITEa>; Fri, 9 Mar 2001 14:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130622AbRCITEU>; Fri, 9 Mar 2001 14:04:20 -0500
Received: from tux.rsn.hk-r.se ([194.47.143.135]:208 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S130621AbRCITEH>;
	Fri, 9 Mar 2001 14:04:07 -0500
Date: Fri, 9 Mar 2001 20:02:33 +0100 (CET)
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: serialconsole broken in 2.4.2-ac16
Message-ID: <Pine.LNX.4.21.0103092001070.28090-100000@tux.rsn.bth.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I found out that there has been a namechange in serial.h and here's the
corresponding changes to serial.c.

--- linux-2.4.2-ac16.backup/drivers/char/serial.c	Fri Mar  9 16:39:16 2001
+++ linux-2.4.2-ac16/drivers/char/serial.c	Fri Mar  9 19:57:52 2001
@@ -5494,7 +5494,7 @@
 		if (--tmout == 0)
 			break;
 	} while((status & BOTH_EMPTY) != BOTH_EMPTY);
-	if (info->flags & ASYNC_NO_FLOW)
+	if (info->flags & ASYNC_CONS_FLOW)
 		return;
 	tmout = 1000000;
 	while (--tmout && ((serial_in(info, UART_MSR) & UART_MSR_CTS) == 0));
@@ -5663,7 +5663,7 @@
 	 */
 	state = rs_table + co->index;
 	if (doflow == 0)
-		state->flags |= ASYNC_NO_FLOW;
+		state->flags |= ASYNC_CONS_FLOW;
 	info = &async_sercons;
 	info->magic = SERIAL_MAGIC;
 	info->state = state;

/Martin

Linux hackers are funny people: They count the time in patchlevels.

