Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269413AbUKAX00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269413AbUKAX00 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 18:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S381735AbUKAX0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 18:26:06 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:39558 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S325256AbUKAWKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 17:10:24 -0500
Date: Mon, 1 Nov 2004 15:10:22 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Russell King <rmk@arm.linux.org.uk>,
       Torben Mathiasen <device@lanana.org>
Subject: [PATCH 2.6.10-rc1] Fix CPM2 uart driver device number brain damage
Message-ID: <20041101221022.GO24459@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch against 2.6.10-rc1 fixes the brain damage that was
found in the CPM2 uart driver.  Previously, if 8250 was configured in,
it would use one set of numbers (which at the time didn't conflict with
anything, but have since been officially given to the Motorola i.MX
driver) and if 8250 wasn't in, it would masquerade as it.  The following
switches us over to 204/46...49 (Which is still unclaimed).  I don't
know whose tree this should go in, however..

Signed-off-by: Tom Rini <trini@kernel.crashing.org>

--- 1.3/drivers/serial/cpm_uart/cpm_uart.h	2004-06-21 08:37:14 -07:00
+++ edited/drivers/serial/cpm_uart/cpm_uart.h	2004-11-01 15:05:21 -07:00
@@ -17,13 +17,8 @@
 #include "cpm_uart_cpm1.h"
 #endif
 
-#ifndef CONFIG_SERIAL_8250
-#define SERIAL_CPM_MAJOR	TTY_MAJOR
-#define SERIAL_CPM_MINOR	64
-#else
 #define SERIAL_CPM_MAJOR	204
-#define SERIAL_CPM_MINOR	42
-#endif
+#define SERIAL_CPM_MINOR	46
 
 #define IS_SMC(pinfo) 		(pinfo->flags & FLAG_SMC)
 #define IS_DISCARDING(pinfo)	(pinfo->flags & FLAG_DISCARDING)
--- 1.21/Documentation/devices.txt	2004-10-20 15:28:12 -07:00
+++ edited/Documentation/devices.txt	2004-11-01 15:03:02 -07:00
@@ -2758,6 +2758,10 @@
 		 43 = /dev/ttySMX2		Motorola i.MX - port 2
 		 44 = /dev/ttyMM0		Marvell MPSC - port 0
 		 45 = /dev/ttyMM1		Marvell MPSC - port 1
+		 46 = /dev/ttyCPM0		PPC CPM (SCC or SMC) - port 0
+		    ...
+		 49 = /dev/ttyCPM5		PPC CPM (SCC or SMC) - port 5
+
 
 205 char	Low-density serial ports (alternate device)
 		  0 = /dev/culu0		Callout device for ttyLU0
@@ -2786,6 +2790,9 @@
 		 41 = /dev/ttySMX0		Callout device for ttySMX0
 		 42 = /dev/ttySMX1		Callout device for ttySMX1
 		 43 = /dev/ttySMX2		Callout device for ttySMX2
+		 46 = /dev/cucpm0		Callout device for ttyCPM0
+		    ...
+		 49 = /dev/cucpm5		Callout device for ttyCPM5
 
 206 char	OnStream SC-x0 tape devices
 		  0 = /dev/osst0		First OnStream SCSI tape, mode 0

-- 
Tom Rini
http://gate.crashing.org/~trini/
