Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbWDEKXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWDEKXM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 06:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWDEKXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 06:23:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:19096 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751205AbWDEKXL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 06:23:11 -0400
Message-ID: <44339A8F.7030305@suse.de>
Date: Wed, 05 Apr 2006 12:23:11 +0200
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [patch] serial: fix UART_BUG_TXEN test
Content-Type: multipart/mixed;
 boundary="------------080105030708090209010506"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080105030708090209010506
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

  Hi,

There is a bug in the UART_BUG_TXEN test: It gives false positives in
case the UART_IER_THRI bit is set.  Fixed by explicitly clearing the
UART_IER register first.

It may trigger with an active serial console as serial console writes
set the UART_IER_THRI bit.

cheers,

  Gerd

--------------080105030708090209010506
Content-Type: text/plain;
 name="fix-serial-8250-UART_BUG_TXEN-test"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-serial-8250-UART_BUG_TXEN-test"

Signed-off-by: Gerd Hoffmann <kraxel@suse.de>
--- linux-2.6.16/drivers/serial/8250.c.serial	2006-04-05 12:04:31.000000000 +0200
+++ linux-2.6.16/drivers/serial/8250.c	2006-04-05 12:04:49.000000000 +0200
@@ -1712,6 +1712,7 @@
 	 * Do a quick test to see if we receive an
 	 * interrupt when we enable the TX irq.
 	 */
+	serial_outp(up, UART_IER, 0);
 	serial_outp(up, UART_IER, UART_IER_THRI);
 	lsr = serial_in(up, UART_LSR);
 	iir = serial_in(up, UART_IIR);

--------------080105030708090209010506--
