Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbUEKD5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbUEKD5G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 23:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262050AbUEKD5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 23:57:06 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:38387 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S262029AbUEKD5B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 23:57:01 -0400
Date: Tue, 11 May 2004 04:57:00 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: rmk+serial@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [patch] serial fifo size is ignored
Message-ID: <Pine.LNX.4.58.0405110453540.3427@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When using register_serial the xmit_fifo_size parameter is accepted by the
8250 driver, and copied to the uart_port fifosize parameter, however
autoconfigure then comes along and overrides this from the
dfl_xmit_fifo_size,

this patch checks if fifosize is 0 and if it is updates from the default,
otherwise it accepts the value,

ignore the 2.6.4 in the patch, it is against 2.6.6.

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

--- linux26/drivers/serial/8250.c	2004-05-11 10:42:56.000000000 +1000
+++ linux-2.6.4/drivers/serial/8250.c	2004-05-11 14:02:45.000000000 +1000
@@ -697,7 +697,8 @@
 #endif
 	serial_outp(up, UART_LCR, save_lcr);

-	up->port.fifosize = uart_config[up->port.type].dfl_xmit_fifo_size;
+	if (up->port.fifosize==0)
+		up->port.fifosize = uart_config[up->port.type].dfl_xmit_fifo_size;
 	up->capabilities = uart_config[up->port.type].flags;

 	if (up->port.type == PORT_UNKNOWN)
