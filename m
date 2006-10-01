Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751731AbWJALYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731AbWJALYf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 07:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbWJALYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 07:24:35 -0400
Received: from havoc.gtf.org ([69.61.125.42]:2533 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1751731AbWJALYe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 07:24:34 -0400
Date: Sun, 1 Oct 2006 07:24:33 -0400
From: Jeff Garzik <jeff@garzik.org>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] usb/serial/mos7840: fix cast
Message-ID: <20061001112433.GA26855@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Debug code in mos7840 emits the following warnings on 64-bit:

drivers/usb/serial/mos7840.c: In function ‘mos7840_open’:
drivers/usb/serial/mos7840.c:1091: warning: cast from pointer to integer of different size
drivers/usb/serial/mos7840.c:1091: warning: cast from pointer to integer of different size
drivers/usb/serial/mos7840.c:1091: warning: cast from pointer to integer of different size

Solution:  Don't assume pointers are 32-bit.  The easy solution actually
cleans up the code:  "%p" (pointer) permits us to eliminate the casts,
and print correct debug information on 64-bit.

Signed-off-by: Jeff Garzik <jeff@garzik.org>

diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index 95bf571..117fe5f 100644
--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -1088,7 +1088,7 @@ static int mos7840_open(struct usb_seria
 	mos7840_port->icount.tx = 0;
 	mos7840_port->icount.rx = 0;
 
-	dbg("\n\nusb_serial serial:%x       mos7840_port:%x\n      usb_serial_port port:%x\n\n", (unsigned int)serial, (unsigned int)mos7840_port, (unsigned int)port);
+	dbg("\n\nusb_serial serial:%p       mos7840_port:%p\n      usb_serial_port port:%p\n\n", serial, mos7840_port, port);
 
 	return 0;
 
