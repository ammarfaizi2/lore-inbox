Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268593AbUIXIcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268593AbUIXIcw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 04:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268609AbUIXIcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 04:32:52 -0400
Received: from webapps.arcom.com ([194.200.159.168]:12550 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S268593AbUIXIcf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 04:32:35 -0400
Message-ID: <4153DBA3.5080507@arcom.com>
Date: Fri, 24 Sep 2004 09:32:35 +0100
From: David Vrabel <dvrabel@arcom.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040912)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: New 8250 device -- XR16550.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Sep 2004 08:36:46.0859 (UTC) FILETIME=[A0C475B0:01C4A211]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This adds support for the two 16550 compatible UARTs in an Exar 
XR16L2551 chip to the 8250 driver.  They have a sleep mode like the 
ST16650V2s but a smaller (16 byte) Rx fifo.

Index: linux-2.6-armbe/drivers/serial/8250.c
===================================================================
--- linux-2.6-armbe.orig/drivers/serial/8250.c	2004-09-22 
17:12:19.000000000 +0100
+++ linux-2.6-armbe/drivers/serial/8250.c	2004-09-23 17:53:37.000000000 
+0100
@@ -174,6 +174,7 @@
  	{ "RSA",	2048,	2048,	UART_CAP_FIFO },
  	{ "NS16550A",	16,	16,	UART_CAP_FIFO | UART_NATSEMI },
  	{ "XScale",	32,	32,	UART_CAP_FIFO },
+	{ "XR16550",	16,	16,	UART_CAP_FIFO | UART_CAP_SLEEP | UART_CAP_EFR },
  };

  static _INLINE_ unsigned int serial_in(struct uart_8250_port *up, int 
offset)
@@ -477,8 +478,10 @@
  	 */
  	if (size_fifo(up) == 64)
  		up->port.type = PORT_16654;
-	else
+	else if(size_fifo(up) == 32)
  		up->port.type = PORT_16650V2;
+	else
+		up->port.type = PORT_XR16550;
  }

  /*
Index: linux-2.6-armbe/include/linux/serial_core.h
===================================================================
--- linux-2.6-armbe.orig/include/linux/serial_core.h	2004-09-23 
17:01:32.000000000 +0100
+++ linux-2.6-armbe/include/linux/serial_core.h	2004-09-23 
17:03:10.000000000 +0100
@@ -37,7 +37,8 @@
  #define PORT_RSA	13
  #define PORT_NS16550A	14
  #define PORT_XSCALE	15
-#define PORT_MAX_8250	15	/* max port ID */
+#define PORT_XR16550	16
+#define PORT_MAX_8250	16	/* max port ID */

  /*
   * ARM specific type numbers.  These are not currently guaranteed

David Vrabel
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/
