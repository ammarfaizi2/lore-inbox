Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263365AbUEPIa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263365AbUEPIa3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 04:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263370AbUEPIa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 04:30:29 -0400
Received: from outmx018.isp.belgacom.be ([195.238.2.117]:6805 "EHLO
	outmx018.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S263365AbUEPIa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 04:30:27 -0400
Subject: [PATCH 2.6.6-mm2] i8042 debug broken
From: FabF <Fabian.Frederick@skynet.be>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-hfr0u29ZJLKt2wCrOMEf"
Message-Id: <1084532991.8303.2.camel@bluerhyme.real3>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 14 May 2004 13:09:51 +0200
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (outmx018.isp.belgacom.be)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hfr0u29ZJLKt2wCrOMEf
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

	i8042 handle_data debug was broken -trying to display unknown
irq-.Here's a quick fix.

Regards,
FabF

--=-hfr0u29ZJLKt2wCrOMEf
Content-Disposition: attachment; filename=i80421.diff
Content-Type: text/x-patch; name=i80421.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -Naur orig/drivers/input/serio/i8042.c edited/drivers/input/serio/i8042.c
--- orig/drivers/input/serio/i8042.c	2004-05-14 12:40:49.000000000 +0200
+++ edited/drivers/input/serio/i8042.c	2004-05-14 12:56:48.000000000 +0200
@@ -420,16 +420,16 @@
 				data = 0xfe;
 			} else dfl = 0;
 
-			dbg("%02x <- i8042 (interrupt, aux%d, %d%s%s)",
-				data, (str >> 6), irq,
+			dbg("%02x <- i8042 (interrupt, aux%d, %s%s)",
+				data, (str >> 6), 
 				dfl & SERIO_PARITY ? ", bad parity" : "",
 				dfl & SERIO_TIMEOUT ? ", timeout" : "");
 
 			serio_interrupt(i8042_mux_port + ((str >> 6) & 3), data, dfl, NULL);
 		} else {
 
-			dbg("%02x <- i8042 (interrupt, %s, %d%s%s)",
-				data, (str & I8042_STR_AUXDATA) ? "aux" : "kbd", irq,
+			dbg("%02x <- i8042 (interrupt, %s, %s%s)",
+				data, (str & I8042_STR_AUXDATA) ? "aux" : "kbd",
 				dfl & SERIO_PARITY ? ", bad parity" : "",
 				dfl & SERIO_TIMEOUT ? ", timeout" : "");
 

--=-hfr0u29ZJLKt2wCrOMEf--

