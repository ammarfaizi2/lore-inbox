Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263737AbTCUSgp>; Fri, 21 Mar 2003 13:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263728AbTCUSfF>; Fri, 21 Mar 2003 13:35:05 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:3460
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263737AbTCUSez>; Fri, 21 Mar 2003 13:34:55 -0500
Date: Fri, 21 Mar 2003 19:50:04 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211950.h2LJo40o026043@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: fix whiteheat always returning -EFAULT
Cc: gregkh@kroah.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/usb/serial/whiteheat.c linux-2.5.65-ac2/drivers/usb/serial/whiteheat.c
--- linux-2.5.65/drivers/usb/serial/whiteheat.c	2003-02-10 18:38:18.000000000 +0000
+++ linux-2.5.65-ac2/drivers/usb/serial/whiteheat.c	2003-03-06 22:00:28.000000000 +0000
@@ -783,7 +783,7 @@
 			if (info->mcr & UART_MCR_RTS)
 				modem_signals |= TIOCM_RTS;
 			
-			if (copy_to_user((unsigned int *)arg, &modem_signals, sizeof(unsigned int)));
+			if (copy_to_user((unsigned int *)arg, &modem_signals, sizeof(unsigned int)))
 				return -EFAULT;
 
 			break;
