Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129624AbRCIEWs>; Thu, 8 Mar 2001 23:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130094AbRCIEW3>; Thu, 8 Mar 2001 23:22:29 -0500
Received: from rhenium.btinternet.com ([194.73.73.93]:34252 "EHLO rhenium")
	by vger.kernel.org with ESMTP id <S129624AbRCIEWY>;
	Thu, 8 Mar 2001 23:22:24 -0500
Date: Fri, 9 Mar 2001 04:21:45 +0000 (GMT)
From: <davej@suse.de>
X-X-Sender: <davej@athlon>
To: Ken Hill <khill2@mediaone.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@redhat.com>
Subject: Re: compile errors on 2.4.2-ac16
In-Reply-To: <3AA84F7F.27F5C165@mediaone.net>
Message-ID: <Pine.LNX.4.31.0103090418290.1265-100000@athlon>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Mar 2001, Ken Hill wrote:

> serial.c:5497: `ASYNC_NO_FLOW' undeclared (first use in this function)
> serial.c:5666: `ASYNC_NO_FLOW' undeclared (first use in this function)

On quick inspection, just looks like a renamed declaration.
Does this fix things ?

regards,

Dave.

diff -urN --exclude-from=/home/davej/.exclude linux/drivers/char/serial.c linux-dj/drivers/char/serial.c
--- linux/drivers/char/serial.c	Fri Mar  9 03:59:02 2001
+++ linux-dj/drivers/char/serial.c	Fri Mar  9 04:12:25 2001
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


-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

