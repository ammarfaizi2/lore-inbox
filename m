Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbWAZDYG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbWAZDYG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 22:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbWAZDYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 22:24:05 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:39677 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1751291AbWAZDYE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 22:24:04 -0500
Date: Wed, 25 Jan 2006 22:24:03 -0500
From: "George G. Davis" <gdavis@mvista.com>
To: rmk+serial@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] serial: Add spin_lock_init() in 8250 early_serial_setup() to init port.lock
Message-ID: <20060126032403.GG5133@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Need spin_lock_init(&serial8250_ports[port->line].port.lock) in
early_serial_setup() since we're copying struct uart_port *port
into serial8250_ports[port->line].port and *port.lock is typically
unitiliased by the caller.

Signed-off-by: George G. Davis <gdavis@mvista.com>

Index: linux-2.6/drivers/serial/8250.c
===================================================================
--- linux-2.6.orig/drivers/serial/8250.c
+++ linux-2.6/drivers/serial/8250.c
@@ -2340,6 +2340,7 @@ int __init early_serial_setup(struct uar
 	serial8250_isa_init_ports();
 	serial8250_ports[port->line].port	= *port;
 	serial8250_ports[port->line].port.ops	= &serial8250_pops;
+	spin_lock_init(&serial8250_ports[port->line].port.lock);
 	return 0;
 }
 
