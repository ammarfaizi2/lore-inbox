Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265728AbUBQBzM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 20:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265715AbUBQBzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 20:55:11 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:38186 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S265953AbUBQByG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 20:54:06 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>
Subject: Re: 2.6.3-rc3 serial console woes 
In-reply-to: Your message of "Mon, 16 Feb 2004 16:45:14 PDT."
             <200402161645.14151.bjorn.helgaas@hp.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 17 Feb 2004 12:53:21 +1100
Message-ID: <4693.1076982801@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Feb 2004 16:45:14 -0700, 
Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
>Reverting for now sounds like the right thing to me.  I would like to
>understand what's going on, though.

My bad, patch merge error against kdb.  Your one line patch is all that
is required.  I have included it in kdb-v4.3-2.6.3-rc3-common-1 to
ensure that kdb works.

===== drivers/serial/8250.c 1.44 vs edited =====
--- 1.44/drivers/serial/8250.c	Fri Feb 13 08:19:33 2004
+++ edited/drivers/serial/8250.c	Mon Feb 16 12:03:06 2004
@@ -1976,7 +1976,7 @@
 	if (co->index >= UART_NR)
 		co->index = 0;
 	port = &serial8250_ports[co->index].port;
-	if (port->type == PORT_UNKNOWN)
+	if (!port->ops)
 		return -ENODEV;
 
 	/*


