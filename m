Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbUC0DMS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 22:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbUC0DMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 22:12:18 -0500
Received: from mail07a.vwh1.net ([207.201.152.66]:56963 "HELO mail07a.vwh1.net")
	by vger.kernel.org with SMTP id S261664AbUC0DMQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 22:12:16 -0500
From: Nick Popoff <cryptic-lkml@bloodletting.com>
To: linux-kernel@vger.kernel.org
Subject: PATCH: Minor fix to serial debug option in 2.4.25
Date: Fri, 26 Mar 2004 19:17:49 -0800
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_dJPZAS5/zIHEK2C"
Message-Id: <200403261917.49587.cryptic-lkml@bloodletting.com>
X-Loop-Detect: 1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_dJPZAS5/zIHEK2C
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I work for a PC/104 embedded hardware company and I'm trying to get IRQ 
sharing working for our serial boards and CPU boards with serial ports.

I'm having some trouble with set_multiport and discovered
SERIAL_DEBUG_INTR in serial.c as a helpful option.  When I enabled it I
found a bug in one of the debug statements.  I've attached a patch for
2.4.25 which fixes the bug.

I'm not on this list so please CC me if you have any questions or
comments.  Thanks.

--Boundary-00=_dJPZAS5/zIHEK2C
Content-Type: text/x-diff;
  charset="us-ascii";
  name="serial.debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="serial.debug.patch"

diff -Naur linux-2.4.25-orig/drivers/char/serial.c linux-2.4.25/drivers/char/serial.c
--- linux-2.4.25-orig/drivers/char/serial.c	2004-02-18 05:36:31.000000000 -0800
+++ linux-2.4.25/drivers/char/serial.c	2004-03-26 18:36:25.000000000 -0800
@@ -924,7 +924,7 @@
 			transmit_chars(info, 0);
 #endif
 		if (pass_counter++ > RS_ISR_PASS_LIMIT) {
-#if SERIAL_DEBUG_INTR
+#ifdef SERIAL_DEBUG_INTR
 			printk("rs_single loop break.\n");
 #endif
 			break;

--Boundary-00=_dJPZAS5/zIHEK2C--

