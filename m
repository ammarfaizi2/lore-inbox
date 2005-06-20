Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261453AbVFTFdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261453AbVFTFdT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 01:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbVFTFdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 01:33:19 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:27974 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261453AbVFTFdI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 01:33:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=B4aTZGJEc1RnQgh1WvBw++G4EmeGTosw2WcRQ5izmAM0dCnljlb4zudCfjcTV7ztudamjXRSgMv/0Pg/BPlGIuaP3GERltLJLsgLjgWM7Rqzt22ihXL0llXaFZX/K4fd3ZePQztKhjMk7zS02WQPj/ciJMcTlQoa0fDGef/owaI=
Message-ID: <cb57165a05061922331cce2a12@mail.gmail.com>
Date: Sun, 19 Jun 2005 22:33:07 -0700
From: Lee Nicks <allinux@gmail.com>
Reply-To: Lee Nicks <allinux@gmail.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.12] compilation errors in drivers/serial/mpsc.c
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch fix gcc 4 compilation errors in drivers/serial/mpsc.c

Signed-off-by: Lee Nicks <allinux@gmail.com>

Index: linux-2.6.12/drivers/serial/mpsc.c
===================================================================
--- linux-2.6.12-orig/drivers/serial/mpsc.c     2005-06-17
12:48:29.000000000 -0700
+++ linux-2.6.12/drivers/serial/mpsc.c  2005-06-19 22:08:04.000000000 -0700
@@ -67,7 +67,11 @@

 static struct mpsc_port_info mpsc_ports[MPSC_NUM_CTLRS];
 static struct mpsc_shared_regs mpsc_shared_regs;
+static struct uart_driver mpsc_reg;

+static void mpsc_start_rx(struct mpsc_port_info *pi);
+static void mpsc_free_ring_mem(struct mpsc_port_info *pi);
+static void mpsc_release_port(struct uart_port *port);
 /*
  ******************************************************************************
  *
@@ -546,7 +550,6 @@
 mpsc_alloc_ring_mem(struct mpsc_port_info *pi)
 {
        int rc = 0;
-       static void mpsc_free_ring_mem(struct mpsc_port_info *pi);

        pr_debug("mpsc_alloc_ring_mem[%d]: Allocating ring mem\n",
                pi->port.line);
@@ -745,7 +748,6 @@
        int     rc = 0;
        u8      *bp;
        char    flag = TTY_NORMAL;
-       static void mpsc_start_rx(struct mpsc_port_info *pi);

        pr_debug("mpsc_rx_intr[%d]: Handling Rx intr\n", pi->port.line);

@@ -1178,7 +1180,6 @@
 mpsc_shutdown(struct uart_port *port)
 {
        struct mpsc_port_info *pi = (struct mpsc_port_info *)port;
-       static void mpsc_release_port(struct uart_port *port);

        pr_debug("mpsc_shutdown[%d]: Shutting down MPSC\n", port->line);

@@ -1448,7 +1449,6 @@
        return uart_set_options(&pi->port, co, baud, parity, bits, flow);
 }

-extern struct uart_driver mpsc_reg;
 static struct console mpsc_console = {
        .name   = MPSC_DEV_NAME,
        .write  = mpsc_console_write,
