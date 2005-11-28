Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbVK1VRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbVK1VRL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 16:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbVK1VRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 16:17:11 -0500
Received: from gate.crashing.org ([63.228.1.57]:49569 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932124AbVK1VRJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 16:17:09 -0500
Subject: [PATCH] serial: Fix matching of MMIO ports
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Tue, 29 Nov 2005 08:11:08 +1100
Message-Id: <1133212269.7768.220.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The function uart_match_port() incorrectly compares the ioremap'd
virtual addresses of ports instead of the physical address to find
duplicate ports for MMIO based UARTs. This fixes it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/serial/serial_core.c
===================================================================
--- linux-work.orig/drivers/serial/serial_core.c	2005-11-14 20:32:16.000000000 +1100
+++ linux-work/drivers/serial/serial_core.c	2005-11-29 08:08:44.000000000 +1100
@@ -2307,7 +2307,7 @@
 		return (port1->iobase == port2->iobase) &&
 		       (port1->hub6   == port2->hub6);
 	case UPIO_MEM:
-		return (port1->membase == port2->membase);
+		return (port1->mapbase == port2->mapbase);
 	}
 	return 0;
 }


