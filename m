Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266512AbUAWGgm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 01:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266515AbUAWGgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 01:36:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:16338 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266512AbUAWGgk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 01:36:40 -0500
To: linux-kernel@vger.kernel.org
From: davej@redhat.com
Cc: greg@kroah.com
Subject: Suspicious pointer usage in kobil_sct driver.
Message-Id: <E1Ajuub-0000xh-00@hardwired>
Date: Fri, 23 Jan 2004 06:35:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg, is this what's intended here?

    Dave

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/usb/serial/kobil_sct.c linux-2.5/drivers/usb/serial/kobil_sct.c
--- bk-linus/drivers/usb/serial/kobil_sct.c	2003-09-29 20:00:01.000000000 +0100
+++ linux-2.5/drivers/usb/serial/kobil_sct.c	2004-01-23 05:06:40.000000000 +0000
@@ -651,7 +651,7 @@ static int  kobil_ioctl(struct usb_seria
 		return 0;
 
 	case TCSETS:   // 0x5402
-		if (! &port->tty->termios) {
+		if (!(port->tty->termios)) {
 			dbg("%s - port %d Error: port->tty->termios is NULL", __FUNCTION__, port->number);
 			return -ENOTTY;
 		}
