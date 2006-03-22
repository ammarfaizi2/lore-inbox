Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbWCVShP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWCVShP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 13:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbWCVShP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 13:37:15 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:31449 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S1751110AbWCVShN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 13:37:13 -0500
Date: Wed, 22 Mar 2006 11:37:47 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Stephane@artesyncp.com, rmk+serial@arm.linux.org.uk
Subject: [PATCH 2.6.16-rc6-mm2] serial: mpsc driver passes bad devname to request_irq()
Message-ID: <20060322183747.GA13014@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The devname passed to request_irq() contained a '/' which is wrong.  At
a minimum, the '/' prevented the devname from showing up in
/proc/irq/<irq>/<devname>.  This patch replaces the '/' with a '-' to
fixes that problem.

Reported-by: Stephane Chazelas <Stephane@artesyncp.com>
Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---

 mpsc.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)
---

diff -Nurp linux-2.6.16-rc6-mm2/drivers/serial/mpsc.c linux-2.6.16-rc6-mm2-mpsc_namefix/drivers/serial/mpsc.c
--- linux-2.6.16-rc6-mm2/drivers/serial/mpsc.c	2006-03-11 15:12:55.000000000 -0700
+++ linux-2.6.16-rc6-mm2-mpsc_namefix/drivers/serial/mpsc.c	2006-03-22 10:42:42.000000000 -0700
@@ -1165,7 +1165,7 @@ mpsc_startup(struct uart_port *port)
 			flag = SA_SHIRQ;
 
 		if (request_irq(pi->port.irq, mpsc_sdma_intr, flag,
-				"mpsc/sdma", pi))
+				"mpsc-sdma", pi))
 			printk(KERN_ERR "MPSC: Can't get SDMA IRQ %d\n",
 			       pi->port.irq);
 
