Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265847AbUBPVGP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 16:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265848AbUBPVGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 16:06:15 -0500
Received: from pr-117-210.ains.net.au ([202.147.117.210]:59078 "EHLO
	mail.ocs.com.au") by vger.kernel.org with ESMTP id S265847AbUBPVGO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 16:06:14 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>
Subject: Re: 2.6.3-rc3 serial console woes 
In-reply-to: Your message of "Mon, 16 Feb 2004 12:07:56 PDT."
             <200402161207.56284.bjorn.helgaas@hp.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 17 Feb 2004 08:05:54 +1100
Message-ID: <8778.1076965554@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Feb 2004 12:07:56 -0700, 
Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
>Hmm....  I suspect the problem is that serial8250_isa_init_ports()
>doesn't initialize port->type for the ports in SERIAL_PORT_DFNS,
>so we fail the console setup.
>
>Does the attached patch make it work like it used to?  ISTR that
>Russell didn't really like testing port->ops, but I can't remember
>why, and I don't see anything better.
>
>===== drivers/serial/8250.c 1.44 vs edited =====
>--- 1.44/drivers/serial/8250.c	Fri Feb 13 08:19:33 2004
>+++ edited/drivers/serial/8250.c	Mon Feb 16 12:03:06 2004
>@@ -1976,7 +1976,7 @@
> 	if (co->index >= UART_NR)
> 		co->index = 0;
> 	port = &serial8250_ports[co->index].port;
>-	if (port->type == PORT_UNKNOWN)
>+	if (!port->ops)
> 		return -ENODEV;
> 
> 	/*

Works for me on i386.

