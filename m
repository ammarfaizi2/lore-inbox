Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262048AbUJYWOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbUJYWOt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 18:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbUJYWJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 18:09:53 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:24030 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262029AbUJYWJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 18:09:27 -0400
Subject: ia64 failure with [PATCH] 8250: Let arch provide the list of
	leagacy ports
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 25 Oct 2004 18:08:59 -0400
Message-Id: <1098742146.2144.200.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ia64 seems to rely on empty ports being registered.  Without this, ia64
crashes on boot with

Removing wrong port: 0000000000000000 != a000000100781bd8

James

===== drivers/serial/8250.c 1.76 vs edited =====
--- 1.76/drivers/serial/8250.c	2004-10-22 18:31:26 -05:00
+++ edited/drivers/serial/8250.c	2004-10-25 16:59:22 -05:00
@@ -2001,13 +2001,6 @@
 	for (i = 0; i < UART_NR; i++) {
 		struct uart_8250_port *up = &serial8250_ports[i];
 
-		/* Don't register "empty" ports, setting "ops" on them
-		 * makes the console driver "setup" routine to succeed,
-		 * which is wrong. --BenH.
-		 */
-		if (!up->port.iobase)
-			continue;
-
 		up->port.line = i;
 		up->port.ops = &serial8250_pops;
 		up->port.dev = dev;

