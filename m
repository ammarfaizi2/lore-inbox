Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261322AbVFTPXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbVFTPXv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 11:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVFTPXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 11:23:50 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:14406 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261322AbVFTPXi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 11:23:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DXkqYmWOG4T/J8KKHqA/p/DKAplVL86Do546A+d98ybjF6eXqfytBdlkQarvLY0sNpxuBi87AUqCJBiMzbSvvxqY8T4Yfpgxh/0j3SKWlegKEiD0nX2TQCnZ0fjuwECFNSOZwsa+IYmPEq7qfAVLohWINvtN7Dze7T6pSLDT/fo=
Message-ID: <cb57165a0506200823313d0bc@mail.gmail.com>
Date: Mon, 20 Jun 2005 08:23:38 -0700
From: Lee Nicks <allinux@gmail.com>
Reply-To: Lee Nicks <allinux@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.12] compilation errors in drivers/serial/mpsc.c
In-Reply-To: <cb57165a05061922331cce2a12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <cb57165a05061922331cce2a12@mail.gmail.com>
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
