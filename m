Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbUBUO3g (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 09:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbUBUO3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 09:29:36 -0500
Received: from s4.uklinux.net ([80.84.72.14]:43754 "EHLO mail2.uklinux.net")
	by vger.kernel.org with ESMTP id S261561AbUBUO3f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 09:29:35 -0500
Date: Sat, 21 Feb 2004 14:28:04 +0000
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.6.3 fix 8250_pnp resource allocation
Message-ID: <20040221142804.GA5292@titan.home.hindley.uklinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Mark Hindley <mark@hindley.uklinux.net>
X-MailScanner-Titan: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Patch below to ensure that 8250_pnp sets necessary flags so that 8250
driver will reserve ioports.

Before, I was logging errors like

Feb 20 08:42:37 titan kernel: Trying to free nonexistent resource <000003e8-000003ef>

on module unload.

Mark


diff -u ../linux-2.6.3/drivers/serial/8250_pnp.c drivers/serial/8250_pnp.c
--- ../linux-2.6.3/drivers/serial/8250_pnp.c	Sat Feb 21 12:18:33 2004
+++ drivers/serial/8250_pnp.c	Sat Feb 21 14:18:38 2004
@@ -21,8 +21,10 @@
 #include <linux/pnp.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
+#include <linux/tty.h>
 #include <linux/serial.h>
 #include <linux/serialP.h>
+#include <linux/serial_core.h>
 
 #include <asm/bitops.h>
 #include <asm/byteorder.h>
@@ -408,7 +410,7 @@
 	       serial_req.port, serial_req.irq, serial_req.io_type);
 #endif
 
-	serial_req.flags = ASYNC_SKIP_TEST | ASYNC_AUTOPROBE;
+	serial_req.flags = UPF_SKIP_TEST | UPF_AUTOPROBE  | UPF_RESOURCES;
 	serial_req.baud_base = 115200;
 	line = register_serial(&serial_req);
 
