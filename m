Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbWBFK1T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbWBFK1T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 05:27:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbWBFK1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 05:27:19 -0500
Received: from webapps.arcom.com ([194.200.159.168]:2573 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S1751057AbWBFK1S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 05:27:18 -0500
Message-ID: <43E72479.4020804@arcom.com>
Date: Mon, 06 Feb 2006 10:27:05 +0000
From: David Vrabel <dvrabel@arcom.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: serial: SERIAL_8250_RUNTIME_UARTS must be <= SERIAL_8250_NR_UARTS
Content-Type: multipart/mixed;
 boundary="------------000108030200060804040905"
X-OriginalArrivalTime: 06 Feb 2006 10:31:59.0000 (UTC) FILETIME=[8F447980:01C62B08]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000108030200060804040905
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

If SERIAL_8250_RUNTIME_UARTS is > SERIAL_8250_NR_UARTS then more serial
ports are registered than we've allocated memory for.  Prevent this by
limiting SERIAL_8250_RUNTIME_UARTS in the serial Kconfig.

Signed-off-by: David Vrabel <dvrabel@arcom.com>
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/

--------------000108030200060804040905
Content-Type: text/plain;
 name="serial-limit-SERIAL_8250_RUNTIME_UARTS"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="serial-limit-SERIAL_8250_RUNTIME_UARTS"

Index: linux-2.6-working/drivers/serial/Kconfig
===================================================================
--- linux-2.6-working.orig/drivers/serial/Kconfig	2006-02-03 14:22:05.000000000 +0000
+++ linux-2.6-working/drivers/serial/Kconfig	2006-02-06 10:17:52.000000000 +0000
@@ -98,6 +98,7 @@
 config SERIAL_8250_RUNTIME_UARTS
 	int "Number of 8250/16550 serial ports to register at runtime"
 	depends on SERIAL_8250
+	range 0 SERIAL_8250_NR_UARTS
 	default "4"
 	help
 	  Set this to the maximum number of serial ports you want
@@ -105,6 +106,9 @@
 	  with the module parameter "nr_uarts", or boot-time parameter
 	  8250.nr_uarts
 
+	  This must be less than or equal to the maximum number of 8250/16550
+	  serial ports supported (SERIAL_8250_NR_UARTS).
+
 config SERIAL_8250_EXTENDED
 	bool "Extended 8250/16550 serial driver options"
 	depends on SERIAL_8250

--------------000108030200060804040905--
