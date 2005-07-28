Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbVG1NcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVG1NcW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 09:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbVG1NcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 09:32:22 -0400
Received: from quickstop.soohrt.org ([81.2.155.147]:18630 "EHLO
	quickstop.soohrt.org") by vger.kernel.org with ESMTP
	id S261268AbVG1NcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 09:32:21 -0400
Date: Thu, 28 Jul 2005 15:32:20 +0200
From: Horst Schirmeier <horst@schirmeier.com>
To: gregkh@suse.de
Cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.13-rc3-git9] pl2303: pl2303_update_line_status data length fix
Message-ID: <20050728133220.GJ25889@quickstop.soohrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Minimum data length must be UART_STATE + 1, as data[UART_STATE] is being
accessed for the new line_state. Although PL-2303 hardware is not
expected to send data with exactly UART_STATE length, this keeps it on
the safe side.

Signed-off-by: Horst Schirmeier <horst@schirmeier.com>
---

--- linux-2.6.13-rc3-git9/drivers/usb/serial/pl2303.c.orig	2005-07-28 14:42:58.000000000 +0200
+++ linux-2.6.13-rc3-git9/drivers/usb/serial/pl2303.c	2005-07-28 14:43:16.000000000 +0200
@@ -826,7 +826,7 @@ static void pl2303_update_line_status(st
 	struct pl2303_private *priv = usb_get_serial_port_data(port);
 	unsigned long flags;
 	u8 status_idx = UART_STATE;
-	u8 length = UART_STATE;
+	u8 length = UART_STATE + 1;
 
 	if ((le16_to_cpu(port->serial->dev->descriptor.idVendor) == SIEMENS_VENDOR_ID) &&
 	    (le16_to_cpu(port->serial->dev->descriptor.idProduct) == SIEMENS_PRODUCT_ID_X65)) {

--
PGP-Key 0xD40E0E7A
